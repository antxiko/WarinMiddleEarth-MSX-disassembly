#!/usr/bin/env python3
"""Para cada hueco sin explicar de la imagen de 64K, quien lo apunta desde el
codigo ya trazado.

    python3 tools/quien_apunta.py <work_dir> <src_dir> [minimo_bytes]

Un rango de datos no se declara porque sobre, se declara porque hay una
instruccion identificada que lo lee. Esto busca esa instruccion: recorre SOLO
los inicios de instruccion del codigo trazado (con la tabla de longitudes del
trazador: leer desde mitad de una instruccion inventa punteros) y se queda con
los operandos inmediatos de 16 bits -ld hl/de/bc/sp,nn, ld (nn),.., ld ..,(nn),
ix/iy- que caen dentro de cada hueco.

Los huecos que salgan SIN NADIE que los apunte son los interesantes: datos
encadenados que se consumen uno detras de otro, o codigo al que no llega nadie.
"""
import json
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from pistas import longitud  # noqa: E402

INMEDIATO = {
    0x21: "ld hl,nn", 0x11: "ld de,nn", 0x01: "ld bc,nn", 0x31: "ld sp,nn",
    0x22: "ld (nn),hl", 0x2A: "ld hl,(nn)", 0x32: "ld (nn),a", 0x3A: "ld a,(nn)",
}
MODULOS = ("bajo", "medio", "alto")


def rangos_d(path):
    out = []
    if not os.path.exists(path):
        return out
    with open(path, encoding="utf-8") as f:
        for ln in f:
            m = re.match(r"^D\s+(0x[0-9A-Fa-f]+)\s+(0x[0-9A-Fa-f]+)", ln)
            if m:
                out.append((int(m.group(1), 16), int(m.group(2), 16)))
    return out


def main():
    work, src = sys.argv[1], sys.argv[2]
    minimo = int(sys.argv[3]) if len(sys.argv) > 3 else 1
    img = open(os.path.join(work, "juego64.bin"), "rb").read()
    occ = open(os.path.join(work, "juego64.ocupado.bin"), "rb").read()
    tr = json.load(open(os.path.join(work, "juego.trace.json")))

    marca = bytearray(0x10000)
    for k, a, b in tr["blocks"]:
        if k == "c":
            for i in range(a, b):
                marca[i] = 1
    for m in MODULOS:
        for a, b in rangos_d(os.path.join(src, m + ".notes")):
            for i in range(a, b):
                marca[i] = 2

    # inmediatos del codigo trazado, por inicio de instruccion
    imm = []
    for k, a, b in tr["blocks"]:
        if k != "c":
            continue
        p = a
        while p < b:
            op = img[p]
            if op in INMEDIATO:
                imm.append((p, INMEDIATO[op], img[p + 1] | img[p + 2] << 8))
            elif op in (0xDD, 0xFD) and img[p + 1] in (0x21, 0x22, 0x2A):
                reg = "ix" if op == 0xDD else "iy"
                imm.append((p, {0x21: f"ld {reg},nn", 0x22: f"ld (nn),{reg}", 0x2A: f"ld {reg},(nn)"}[img[p + 1]],
                            img[p + 2] | img[p + 3] << 8))
            elif op == 0xED and img[p + 1] in (0x43, 0x53, 0x4B, 0x5B, 0x73, 0x7B):
                imm.append((p, {0x43: "ld (nn),bc", 0x53: "ld (nn),de", 0x4B: "ld bc,(nn)",
                                0x5B: "ld de,(nn)", 0x73: "ld (nn),sp", 0x7B: "ld sp,(nn)"}[img[p + 1]],
                            img[p + 2] | img[p + 3] << 8))
            p += longitud(img, p)

    huecos, ini = [], None
    for i in range(0x10000):
        libre = occ[i] and marca[i] == 0
        if libre and ini is None:
            ini = i
        elif not libre and ini is not None:
            huecos.append((ini, i))
            ini = None
    if ini is not None:
        huecos.append((ini, 0x10000))

    print("Huecos sin explicar: %d, %d bytes" % (len(huecos), sum(b - a for a, b in huecos)))
    for a, b in huecos:
        if b - a < minimo:
            continue
        dentro = sorted(set((v, p, m) for p, m, v in imm if a <= v < b))
        txt = "".join(chr(c) if 32 <= c < 127 else "." for c in img[a:a + 24])
        print("\n0x%04X..0x%04X  (%d bytes)  %s  %s" % (a, b - 1, b - a, img[a:a + 8].hex(" "), txt))
        if not dentro:
            print("    NADIE LO APUNTA")
        for v2, p, m in dentro[:10]:
            print("    0x%04X  <- %-12s en 0x%04X" % (v2, m, p))
        if len(dentro) > 10:
            print("    ... y %d mas" % (len(dentro) - 10))
    return 0


if __name__ == "__main__":
    sys.exit(main())
