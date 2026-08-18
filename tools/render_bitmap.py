#!/usr/bin/env python3
"""Dibuja un tramo como bitmap LINEAL de 1 bit con un ancho dado en bytes.

    python3 tools/render_bitmap.py <imagen> <ini> <fin> <bytes_por_fila> <salida.png> [escala]
"""
import struct
import sys
import zlib


def png(w, h, rows, fn):
    raw = b"".join(b"\x00" + bytes(r) for r in rows)
    def chunk(t, d):
        return struct.pack(">I", len(d)) + t + d + struct.pack(">I", zlib.crc32(t + d) & 0xffffffff)
    open(fn, "wb").write(b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", struct.pack(">IIBBBBB", w, h, 8, 0, 0, 0, 0))
                         + chunk(b"IDAT", zlib.compress(raw)) + chunk(b"IEND", b""))


def main():
    img = open(sys.argv[1], "rb").read()
    a, b, bpr = int(sys.argv[2], 0), int(sys.argv[3], 0), int(sys.argv[4], 0)
    out = sys.argv[5]
    esc = int(sys.argv[6]) if len(sys.argv) > 6 else 2
    datos = img[a:b]
    h = (len(datos) + bpr - 1) // bpr
    rows = []
    for y in range(h):
        r = []
        for x in range(bpr):
            i = y * bpr + x
            v = datos[i] if i < len(datos) else 0
            for bit in range(8):
                r += [0 if (v >> (7 - bit)) & 1 else 255] * esc
        for _ in range(esc):
            rows.append(r)
    png(bpr * 8 * esc, h * esc, rows, out)
    print(f"{out}: {h} filas de {bpr} bytes")


if __name__ == "__main__":
    main()
