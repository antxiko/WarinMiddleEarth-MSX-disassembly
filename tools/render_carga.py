#!/usr/bin/env python3
"""Dibuja la pantalla que War in Middle Earth ensena mientras carga.

No es una captura: se monta con los bytes del bloque [08] de la cinta,
siguiendo lo que hace el propio cargador. Sus dos volcados (0xD702-0xD719) lo
dicen sin ambiguedad:

    ld hl,0x891C / ld de,0x0000 / ld bc,0x1800 / call 0xD748   -> los PATRONES
    ld hl,0xA11C / ld de,0x2000 / ld bc,0x1800 / call 0xD748   -> los COLORES

y las cuentas cierran solas: 0x88B8 + 100 = 0x891C, + 6144 = 0xA11C, + 6144 =
0xB91C, que es el final exacto del bloque de 12.388 bytes.

Los 100 bytes del principio hacen lo mismo con la BIOS -DISSCR, dos LDIRVM y
ENASCR- pero en esta cinta no los llama nadie: cuando el bloque llega, la BIOS
ya no esta mapeada, y la pantalla la vuelca el cargador con su propia rutina.

LA UNICA SUPOSICION, y va dicha: que la tabla de nombres sea la identidad, o
sea 0,1,2...255 en cada tercio, que es lo normal cuando se usa el SCREEN 2 como
mapa de bits y lo que hace falta para que 6144 bytes seguidos sean una pantalla
entera. No la pone este bloque. Si estuviera mal, aqui saldria ruido: que salga
un dibujo coherente ES la comprobacion.

En SCREEN 2 cada byte de color vale para una fila de ocho pixeles de una
casilla: el nibble alto es la tinta -donde el patron tiene un 1- y el bajo, el
fondo.

Uso: render_carga.py <work/pantalla.raw> <salida.png> [escala]
"""
import os
import struct
import sys
import zlib

ORG = 0x88B8
PATRONES = 0x891C
COLORES = 0xA11C
BLOQUE = 0x1800          # 6144 bytes cada tabla
ANCHO, ALTO = 256, 192

# La paleta del TMS9918, en el orden en que la numera el VDP.
PAL = [(0, 0, 0), (0, 0, 0), (33, 200, 66), (94, 220, 120), (84, 85, 237),
       (125, 118, 252), (212, 82, 77), (66, 235, 245), (252, 85, 84),
       (255, 121, 120), (212, 193, 84), (230, 206, 128), (33, 176, 59),
       (201, 91, 186), (204, 204, 204), (255, 255, 255)]


def png(path, w, h, filas):
    """Un PNG de color verdadero, sin dependencias."""
    raw = b"".join(b"\x00" + bytes(v for p in f for v in p) for f in filas)

    def chunk(t, d):
        return (struct.pack(">I", len(d)) + t + d
                + struct.pack(">I", zlib.crc32(t + d) & 0xffffffff))

    with open(path, "wb") as f:
        f.write(b"\x89PNG\r\n\x1a\n"
                + chunk(b"IHDR", struct.pack(">IIBBBBB", w, h, 8, 2, 0, 0, 0))
                + chunk(b"IDAT", zlib.compress(raw, 9))
                + chunk(b"IEND", b""))


def revela(patrones, colores, escala=2):
    """Revela las dos tablas como lo haria el VDP en SCREEN 2."""
    lienzo = [[(0, 0, 0)] * (ANCHO * escala) for _ in range(ALTO * escala)]
    for y in range(ALTO):
        tercio, fila = divmod(y, 64)
        fila, linea = divmod(fila, 8)
        for cx in range(32):
            # tabla de nombres = identidad: la casilla N del tercio usa el
            # patron N de ese tercio
            off = tercio * 2048 + (fila * 32 + cx) * 8 + linea
            pat, col = patrones[off], colores[off]
            tinta, fondo = PAL[col >> 4], PAL[col & 0x0F]
            for bit in range(8):
                rgb = tinta if pat & (0x80 >> bit) else fondo
                px, py = (cx * 8 + bit) * escala, y * escala
                for dy in range(escala):
                    for dx in range(escala):
                        lienzo[py + dy][px + dx] = rgb
    return lienzo


def main(argv):
    if len(argv) < 3:
        print(__doc__)
        return 2
    ruta, salida = argv[1], argv[2]
    escala = int(argv[3]) if len(argv) > 3 else 2
    if not os.path.exists(ruta):
        print("  falta %s: hazlo antes con `make extract`" % ruta)
        return 2
    d = open(ruta, "rb").read()
    fin = COLORES - ORG + BLOQUE
    if len(d) < fin:
        print("  el bloque son %d bytes y las dos tablas acaban en %d: no cabe"
              % (len(d), fin))
        return 1
    patrones = d[PATRONES - ORG:PATRONES - ORG + BLOQUE]
    colores = d[COLORES - ORG:COLORES - ORG + BLOQUE]
    os.makedirs(os.path.dirname(salida) or ".", exist_ok=True)
    png(salida, ANCHO * escala, ALTO * escala, revela(patrones, colores, escala))
    print("  pantalla de carga: patrones 0x%04X, colores 0x%04X -> %s"
          % (PATRONES, COLORES, salida))
    # Si el reparto estuviese cambiado, los "colores" tendrian la pinta de un
    # dibujo y los "patrones" la de una paleta. Se dice cuantos colores
    # distintos hay en cada tabla, que es la senal mas barata de que van bien.
    print("  %d bytes distintos en los patrones, %d en los colores"
          % (len(set(patrones)), len(set(colores))))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
