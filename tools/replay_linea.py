#!/usr/bin/env python3
"""Lee una pasada de tools/omsx_pasada.tcl (work/replay/<nombre>/) y saca la
linea de tiempo de la partida.

    resumen  <dir> [trace.json]   tabla por ventana: control, pantalla, PC calientes
    tramos   <dir>                ventanas consecutivas con la misma firma, agrupadas
    pantalla <dir> <idx> <png>    la pantalla ZX (0x4000-0x5AFF) de la ventana idx, en PNG
    texto    <dir> <idx>          el texto de esa pantalla, leido celda a celda con la
                                  fuente de 0xC800 (cada celda de 8x8 se busca entre los
                                  128 glifos; lo que no es un glifo sale como '.')
    nuevos   <dir> <trace.json>   PCs fuera del trazado, por ventana y en total
    lecturas <dir>                quien lee cada region vigilada, en que ventanas
    escrituras <dir>              quien escribe en los bloques de codigo, en que ventanas

La pantalla es la del Spectrum emulada en RAM: bitmap en 0x4000-0x57FF con el
orden de filas del ZX y atributos en 0x5800-0x5AFF (tinta bits 0-2, papel 3-5,
brillo 6). La fuente del juego esta en 0xC800 (128 caracteres de 8 bytes) y sus
codigos son ASCII: se comprueba en `texto`, que lee los rotulos de los paneles.
"""
import json
import os
import sys

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
ZX = 6912
REG = {"zx": 0x1B00, "sys": 0x300, "est": 0xF18, "fin": 0x278, "alta": 0x1988, "baja": 0x190}
VACIO = bytes(8)


def lee_indice(d):
    out = []
    for ln in open(os.path.join(d, "indice.txt")):
        if ln.startswith("#"):
            continue
        p = ln.split()
        if len(p) < 9:
            continue
        out.append(dict(idx=int(p[0]), t0=float(p[1]), t1=float(p[2]), pc=int(p[3], 16),
                        sp=int(p[4], 16), n38=int(p[5]), nm=int(p[6]), mf=int(p[7]), nd=int(p[8])))
    return out


def lee_bloque(d, nombre, idx):
    tam = REG[nombre]
    with open(os.path.join(d, nombre + ".bin"), "rb") as f:
        f.seek(idx * tam)
        return f.read(tam)


def lee_por_ventana(d, fichero):
    """Ficheros '== idx t' + lineas 'clave... n' -> {idx: [(campos, n)]}."""
    out, cur = {}, None
    p = os.path.join(d, fichero)
    if not os.path.exists(p):
        return out
    for ln in open(p):
        ln = ln.strip()
        if not ln:
            continue
        if ln.startswith("=="):
            cur = int(ln.split()[1])
            out[cur] = []
        elif cur is not None:
            p2 = ln.split()
            out[cur].append((p2[:-1], int(p2[-1])))
    return out


def codigo_trazado(trace):
    cod = set()
    for k, a, b in json.load(open(trace))["blocks"]:
        if k == "c":
            cod.update(range(a, b))
    return cod


def dir_zx(x, y):
    return ((y & 0xC0) << 5) + ((y & 0x07) << 8) + ((y & 0x38) << 2) + (x >> 3)


PALETA = [(0, 0, 0), (0, 0, 205), (205, 0, 0), (205, 0, 205), (0, 205, 0), (0, 205, 205), (205, 205, 0), (205, 205, 205)]
PALETA_B = [(0, 0, 0), (0, 0, 255), (255, 0, 0), (255, 0, 255), (0, 255, 0), (0, 255, 255), (255, 255, 0), (255, 255, 255)]


def pantalla_png(zx, fn, escala=2):
    from PIL import Image
    im = Image.new("RGB", (256, 192))
    px = im.load()
    for y in range(192):
        for x in range(256):
            b = zx[dir_zx(x, y)]
            at = zx[0x1800 + (y >> 3) * 32 + (x >> 3)]
            tinta, papel, brillo = at & 7, (at >> 3) & 7, at & 0x40
            pal = PALETA_B if brillo else PALETA
            px[x, y] = pal[tinta] if (b >> (7 - (x & 7))) & 1 else pal[papel]
    if escala != 1:
        im = im.resize((256 * escala, 192 * escala), Image.NEAREST)
    im.save(fn)


def fuente():
    j = open(os.path.join(RAIZ, "work", "juego64.bin"), "rb").read()
    gl = {}
    for c in range(128):
        g = j[0xC800 + c * 8: 0xC800 + c * 8 + 8]
        gl.setdefault(g, c)
    return gl


def texto(zx, gl=None):
    gl = gl or fuente()
    filas = []
    for r in range(24):
        s = ""
        for c in range(32):
            g = bytes(zx[dir_zx(c * 8, r * 8 + l)] for l in range(8))
            if g == VACIO:
                s += " "
                continue
            inv = bytes(v ^ 0xFF for v in g)
            code = gl.get(g)
            if code is None and inv in gl:
                code = gl[inv]
            if code is None:
                s += "."
            elif 0x20 <= code < 0x7F:
                s += chr(code)
            else:
                s += "#"
        filas.append(s)
    return filas


def calientes(pcs, n=4, grano=64):
    b = {}
    for pc, k in pcs:
        b[pc // grano * grano] = b.get(pc // grano * grano, 0) + k
    tot = sum(b.values()) or 1
    top = sorted(b.items(), key=lambda x: -x[1])[:n]
    return [(a, 100.0 * k / tot) for a, k in top]


def resumen(d, trace=None):
    idx = lee_indice(d)
    pcsv = lee_por_ventana(d, "pcs_ventanas.txt")
    prev = None
    print("  idx      t_ini    t_fin  n38   muestras fuera  pant_bits pant_attr  est  alta   PC calientes (bloques de 64 B, %)")
    for r in idx:
        zx = lee_bloque(d, "zx", r["idx"])
        est = lee_bloque(d, "est", r["idx"])
        alta = lee_bloque(d, "alta", r["idx"])
        if prev:
            db = sum(1 for i in range(0x1800) if zx[i] != prev[0][i])
            da = sum(1 for i in range(0x1800, ZX) if zx[i] != prev[0][i])
            de = sum(1 for i in range(len(est)) if est[i] != prev[1][i])
            dh = sum(1 for i in range(len(alta)) if alta[i] != prev[2][i])
        else:
            db = da = de = dh = -1
        prev = (zx, est, alta)
        pcs = [(int(p[0], 16), n) for p, n in pcsv.get(r["idx"], [])]
        cal = " ".join(f"{a:04X}:{p:2.0f}" for a, p in calientes(pcs))
        aviso = "" if 2400 <= r["n38"] <= 2600 else "  <-- CONTROL 0x0038 FUERA DE 50/s"
        print(f"  {r['idx']:4d} {r['t0']:9.1f} {r['t1']:8.1f} {r['n38']:5d} {r['nm']:8d} {r['mf']:5d}  {db:9d} {da:9d} {de:4d} {dh:5d}   {cal}{aviso}")


def modo(zx, pcs):
    """Que esta haciendo el juego en la ventana, por la pantalla y por el PC.

    La pantalla de batalla es verde (atributo 0x20: papel verde, tinta negra)
    en casi toda su superficie; la del mapa es blanca (0x38/0x78) con rojo; el
    resto (paneles, menu) se distingue por los PC calientes: 0x87xx-0x8Bxx es
    el motor de la batalla, 0x73xx/0x75xx el dibujo del mapa, 0x82xx los
    paneles de File/Memo/Time y 0x92xx-0x93xx los mensajes de abajo.
    """
    at = zx[0x1800:ZX]
    verde = sum(1 for v in at if v & 0x38 == 0x20)
    cal = [a for a, p in calientes(pcs, n=4, grano=256)]
    if verde > len(at) * 0.5:
        return "batalla"
    if 0x8200 in cal:
        return "panel"
    if 0x7500 in cal or 0x7300 in cal:
        return "mapa"
    if 0x8700 in cal or 0x8800 in cal or 0x8A00 in cal:
        return "batalla"
    if 0x9300 in cal or 0x9200 in cal:
        return "mensaje"
    return "otro:" + " ".join(f"{x:04X}" for x in cal[:2])


def tramos(d):
    idx = lee_indice(d)
    pcsv = lee_por_ventana(d, "pcs_ventanas.txt")
    gl = fuente()
    cur = None
    out = []
    for r in idx:
        pcs = [(int(p[0], 16), n) for p, n in pcsv.get(r["idx"], [])]
        zx = lee_bloque(d, "zx", r["idx"])
        m = modo(zx, pcs)
        msg = texto(zx, gl)[0].replace(".", "").replace("#", "").strip()
        if cur and cur[2] == m:
            cur[1] = r
            if msg and msg not in cur[3]:
                cur[3].append(msg)
        else:
            if cur:
                out.append(cur)
            cur = [r, r, m, [msg] if msg else []]
    if cur:
        out.append(cur)
    for a, b, m, msgs in out:
        h0 = a["t0"] / 3600
        print(f"  ventanas {a['idx']:4d}-{b['idx']:4d}  t {a['t0']:9.1f}-{b['t1']:9.1f} ({h0:5.2f} h, {(b['t1']-a['t0'])/60:6.1f} min)  {m:8s}  " + " | ".join(msgs[:4]))


def nuevos(d, trace):
    cod = codigo_trazado(trace)
    nv = lee_por_ventana(d, "nuevos_ventanas.txt")
    tot = {}
    for i in sorted(nv):
        fuera = [(int(p[0], 16), n) for p, n in nv[i] if int(p[0], 16) not in cod]
        if fuera:
            print(f"  ventana {i}: " + " ".join(f"{a:04X}x{n}" for a, n in fuera[:30]) + (" ..." if len(fuera) > 30 else ""))
            for a, n in fuera:
                tot[a] = tot.get(a, 0) + n
    print(f"  PCs fuera del trazado distintos: {len(tot)}")
    rangos = []
    for a in sorted(tot):
        if rangos and a - rangos[-1][1] <= 16:
            rangos[-1][1] = a
            rangos[-1][2] += tot[a]
            rangos[-1][3] += 1
        else:
            rangos.append([a, a, tot[a], 1])
    for a, b, n, k in rangos:
        print(f"    {a:04X}-{b:04X}  {k:4d} PCs  {n:8d} muestras/fetches")
    p = os.path.join(d, "nuevos_primera_vez.txt")
    if os.path.exists(p):
        print("  primera vez:")
        for ln in open(p):
            print("    " + ln.rstrip())


def lecturas(d):
    regs = []
    for ln in open(os.path.join(RAIZ, "work", "replay", "regiones.tcl")):
        p = ln.split()
        if len(p) == 2 and p[0].isdigit():
            regs.append((int(p[0]), int(p[1])))
    lv = lee_por_ventana(d, "lecturas_ventanas.txt")
    por_region = {}
    for i in sorted(lv):
        for (ri, pc), n in lv[i]:
            ri = int(ri)
            e = por_region.setdefault(ri, {}).setdefault(int(pc, 16), [0, None, None])
            e[0] += n
            if e[1] is None:
                e[1] = i
            e[2] = i
    for ri, (a, b) in enumerate(regs):
        if ri not in por_region:
            print(f"  region {ri:2d} {a:04X}-{b:04X}: nadie la lee")
            continue
        print(f"  region {ri:2d} {a:04X}-{b:04X}:")
        for pc, (n, i0, i1) in sorted(por_region[ri].items()):
            print(f"      PC {pc:04X}  {n:8d} lecturas  ventanas {i0}..{i1}")


def escrituras(d):
    ev = lee_por_ventana(d, "escrituras_ventanas.txt")
    tot = {}
    for i in sorted(ev):
        for (pc, addr), n in ev[i]:
            e = tot.setdefault((int(pc, 16), int(addr, 16)), [0, i, i])
            e[0] += n
            e[2] = i
    por_pc = {}
    for (pc, addr), (n, i0, i1) in tot.items():
        e = por_pc.setdefault(pc, [0xFFFF, 0, 0, 10**9, 0, 0])
        e[0] = min(e[0], addr)
        e[1] = max(e[1], addr)
        e[2] += n
        e[3] = min(e[3], i0)
        e[4] = max(e[4], i1)
        e[5] += 1
    for pc, (a, b, n, i0, i1, k) in sorted(por_pc.items()):
        print(f"  PC {pc:04X} escribe {a:04X}-{b:04X} ({k:4d} direcciones, {n:8d} escrituras) ventanas {i0}..{i1}")


def main(argv):
    if len(argv) < 3:
        print(__doc__)
        return 2
    cmd, d = argv[1], argv[2]
    if cmd == "resumen":
        resumen(d, argv[3] if len(argv) > 3 else None)
    elif cmd == "tramos":
        tramos(d)
    elif cmd == "pantalla":
        pantalla_png(lee_bloque(d, "zx", int(argv[3])), argv[4])
    elif cmd == "texto":
        for fila in texto(lee_bloque(d, "zx", int(argv[3]))):
            print("  |" + fila + "|")
    elif cmd == "nuevos":
        nuevos(d, argv[3])
    elif cmd == "lecturas":
        lecturas(d)
    elif cmd == "escrituras":
        escrituras(d)
    else:
        print(__doc__)
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
