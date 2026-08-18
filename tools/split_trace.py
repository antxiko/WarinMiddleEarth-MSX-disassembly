#!/usr/bin/env python3
"""Parte el trazado de la imagen de 64K en los tres bloques reales de la cinta.

War in Middle Earth se traza sobre UNA imagen de 64K (work/juego64.bin) porque
el juego corre asi: tres bloques disjuntos que se llaman entre si. Pero cada
bloque es un fichero de la cinta con su propio sitio, y el reensamblado tiene
que dar ese fichero byte a byte. Asi que cada bloque es un modulo con su `org`
de EJECUCION (que es el bueno para leer los CALL y los JP), y este script saca,
para cada uno:
  - su binario recortado de la imagen (identico a work/<nombre>.raw)
  - su .trace.json con solo los bloques que le caen dentro

Uso: split_trace.py <imagen64k> <trace64k.json> <directorio_salida>
"""
import json
import sys

# nombre, org (= direccion de ejecucion), primer byte, ultimo byte
TROZOS = [
    ("bajo",  0x0190, 0x0190, 0x3F4E),
    ("medio", 0x5E00, 0x5E00, 0x96F0),
    ("alto",  0x9E00, 0x9E00, 0xE677),
]


def recorta(tr, lo, fin):
    """Bloques que caen en [lo,fin), recortados.

    OJO con el convenio: z80trace emite los bloques con el extremo derecho
    EXCLUSIVO, [ini,fin), y mkasm los consume igual. Tratarlos como cerrados
    hace que se pierda el ultimo byte de cada trozo y el reensamblado sale
    un byte corto.
    """
    bloques = []
    for k, a, b in tr["blocks"]:
        if b <= lo or a >= fin:
            continue
        bloques.append([k, max(a, lo), min(b, fin)])
    bloques.sort(key=lambda x: x[1])

    completo, cursor = [], lo
    for k, a, b in bloques:
        if a > cursor:
            completo.append(["d", cursor, a])
        completo.append([k, a, b])
        cursor = b
    if cursor < fin:
        completo.append(["d", cursor, fin])
    return completo


def main():
    imgpath, trpath, outdir = sys.argv[1:4]
    img = open(imgpath, "rb").read()
    tr = json.load(open(trpath))

    total = 0
    for nombre, org, lo, hi in TROZOS:
        fin = hi + 1
        n = fin - lo
        cuerpo = img[lo:fin]
        raw = open(f"{outdir}/{nombre}.raw", "rb").read()
        if cuerpo != raw:
            print(f"!! {nombre}: el recorte de la imagen no es {nombre}.raw")
            return 1
        bloques = recorta(tr, lo, fin)
        entradas = [a for a in tr["entries"] if lo <= a < fin]
        json.dump(dict(report=tr.get("report", {}), entries=sorted(entradas),
                       blind=[b for b in tr.get("blind", [])
                              if lo <= int(b[0], 16) < fin],
                       blocks=bloques),
                  open(f"{outdir}/{nombre}.trace.json", "w"), indent=1)
        ncode = sum(b - a for k, a, b in bloques if k == "c")
        print(f"  {nombre:6s} org {org:#06x}  {n:6d} B  "
              f"codigo {ncode:5d} B ({100*ncode/n:5.1f}%)  {len(entradas)} etiquetas")
        total += n
    print(f"  {'':6s} {'':11s} {total:6d} B en total (los tres cuerpos suman 48936)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
