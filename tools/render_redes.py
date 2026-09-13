#!/usr/bin/env python3
"""Dibuja las CARRETERAS de la maquina y el DESPLIEGUE INICIAL sobre el mapa.

Nada de esto se captura de la pantalla: el mapa se descomprime de la cinta con
`render_mapa_completo`, y lo que se pinta encima sale de dos sitios del
desensamblado:

LAS DOS REDES DE CAMINOS. Los ejercitos que lleva la maquina no van a donde
quieren: van de un punto marcado al siguiente. `DESTINO_POR_LA_RED_GRANDE`
(0x69C1) y `DESTINO_POR_LA_RED_CHICA` (0x6993) leen dos tablas de puntos de
cuatro bytes -columna, fila, y dos salidas- y `BUSCA_EN_LA_RED` (0x69F3) busca
en ellas el punto en el que esta la unidad. Las salidas son el indice de otro
punto de la MISMA tabla, asi que las dos tablas son un grafo:

    0x6BFB  64 puntos   la red grande
    0x6CFB  15 puntos   la red chica

`REPARTE_POR_NUMERO` (0x6A17) decide cual le toca a cada unidad por su NUMERO:
de 0xDD arriba la chica, de 0x78 a 0xDC la grande, la 0x16 (Sauron) la grande y
la 0x17 (Saruman) la chica. Las demas -los personajes con nombre- no reciben
destino: las mueve el jugador.

EL DESPLIEGUE INICIAL. No lo calcula nadie: viene grabado en la cinta, dentro
del bloque alto, en las tiras de 256 bytes que empiezan en 0xB900 (columna),
0xBA00 (fila), 0xBD00 (tipo y banderas) y 0xC500 (cuantas figuras pone en una
batalla). `EMPIEZA_PARTIDA_NUEVA` (0x7F43) solo pone en pie el estado de
0xC600: las posiciones ya estaban ahi.

Los bandos salen de la misma pregunta que se hace el juego en 0x8F84, 0x90BC y
0x91E1: las unidades 0x16, 0x17 y de 0x78 arriba son de Sauron; el resto, del
jugador.

Uso:
    python3 tools/render_redes.py <alto.raw> <medio.raw> <salida-base>

Escribe <salida-base>_redes.png y <salida-base>_despliegue.png.
"""

import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from lienzos import MSX, escribe_png                              # noqa: E402
from render_mapa_completo import (ANCHO, ALTO, Mapa,              # noqa: E402
                                  descomprime_el_mapa)

ORG_MEDIO = 0x5E00
ORG_ALTO = 0x9E00

RED_GRANDE = (0x6BFB, 64)       # 0x69C6: 64 puntos de cuatro bytes
RED_CHICA = (0x6CFB, 15)        # 0x6998: 15 puntos de cuatro bytes

CELDA = 16                      # cada casilla del mapa mide 16 x 16 pixeles

# Colores que NO aparecen en el mapa del juego, para que se vean encima.
MAGENTA, AMARILLO, CIAN, BLANCO, NEGRO, ROJO = 13, 10, 7, 15, 1, 9


def lee_red(medio, base, cuantos):
    """Cada punto son cuatro bytes: columna, fila, salida 1 y salida 2."""
    puntos = []
    for i in range(cuantos):
        p = base - ORG_MEDIO + i * 4
        col, fila, s1, s2 = medio[p:p + 4]
        puntos.append((col, fila, s1, s2))
    return puntos


def tira(alto, base):
    """Una de las tiras de 256 bytes del estado de la partida."""
    return alto[base - ORG_ALTO:base - ORG_ALTO + 256]


def es_de_sauron(n):
    """La misma pregunta que se hacen 0x8F84, 0x90BC y 0x91E1."""
    return n in (0x16, 0x17) or n >= 0x78


# --------------------------------------------------------------- pintar
def punto_a_pixel(col, fila):
    return col * CELDA + CELDA // 2, fila * CELDA + CELDA // 2


def pon(filas, x, y, color):
    if 0 <= y < len(filas) and 0 <= x < len(filas[0]):
        filas[y][x] = color


def linea(filas, x0, y0, x1, y1, color, grosor=1):
    """Bresenham, con el grosor a base de un cuadradito por punto."""
    dx, dy = abs(x1 - x0), -abs(y1 - y0)
    sx = 1 if x0 < x1 else -1
    sy = 1 if y0 < y1 else -1
    err = dx + dy
    r = grosor // 2
    while True:
        for oy in range(-r, r + 1):
            for ox in range(-r, r + 1):
                pon(filas, x0 + ox, y0 + oy, color)
        if x0 == x1 and y0 == y1:
            break
        e2 = 2 * err
        if e2 >= dy:
            err += dy
            x0 += sx
        if e2 <= dx:
            err += dx
            y0 += sy


def disco(filas, cx, cy, radio, color, borde=NEGRO):
    for oy in range(-radio, radio + 1):
        for ox in range(-radio, radio + 1):
            d = ox * ox + oy * oy
            if d <= radio * radio:
                c = borde if d > (radio - 1) * (radio - 1) else color
                pon(filas, cx + ox, cy + oy, c)


def lienzo_del_mapa(alto, medio, con_unidades=False):
    mapa = descomprime_el_mapa(alto)
    m = Mapa(mapa, medio, alto)
    celdas = [(x, y) for y in range(ALTO) for x in range(ANCHO)]
    m.dibuja(celdas, con_unidades)
    w, h, filas = m.a_pixeles(0, 0, ANCHO, ALTO, 1)
    return w, h, [bytearray(f) for f in filas]


def pinta_una_red(filas, puntos, color_linea, color_punto, radio):
    """Primero todas las lineas y despues los puntos, para que no los tape."""
    for col, fila, s1, s2 in puntos:
        x, y = punto_a_pixel(col, fila)
        for salida in (s1, s2):
            if salida < len(puntos):
                dc, df = puntos[salida][0], puntos[salida][1]
                linea(filas, x, y, *punto_a_pixel(dc, df), color_linea, 3)
    for col, fila, _, _ in puntos:
        disco(filas, *punto_a_pixel(col, fila), radio, color_punto)


def main(argv):
    if len(argv) < 4:
        print(__doc__)
        return 2
    alto = open(argv[1], "rb").read()
    medio = open(argv[2], "rb").read()
    base = argv[3]

    # ---------------------------------------------------------- las redes
    w, h, filas = lienzo_del_mapa(alto, medio)
    grande = lee_red(medio, *RED_GRANDE)
    chica = lee_red(medio, *RED_CHICA)
    pinta_una_red(filas, grande, MAGENTA, MAGENTA, 7)
    pinta_una_red(filas, chica, AMARILLO, AMARILLO, 5)
    # Sauron y Saruman, donde los deja la cinta.
    cols, fils = tira(alto, 0xB900), tira(alto, 0xBA00)
    for n, color in ((0x16, ROJO), (0x17, ROJO)):
        disco(filas, *punto_a_pixel(cols[n] & 0x7F, fils[n] & 0x7F), 11, color)
    salida = base + "_redes.png"
    escribe_png(salida, w, h, [bytes(f) for f in filas], MSX)
    print("%s: %d x %d px  (red grande %d puntos, red chica %d)"
          % (salida, w, h, len(grande), len(chica)))

    # ------------------------------------------------------- el despliegue
    w, h, filas = lienzo_del_mapa(alto, medio)
    figuras = tira(alto, 0xC500)
    porcasilla = {}
    for n in range(256):
        c, f = cols[n] & 0x7F, fils[n] & 0x7F
        clave = (es_de_sauron(n), c, f)
        u, fg = porcasilla.get(clave, (0, 0))
        porcasilla[clave] = (u + 1, fg + figuras[n])
    for (oscuro, c, f), (u, fg) in sorted(porcasilla.items(),
                                          key=lambda kv: -kv[1][1]):
        # El radio dice cuanta tropa sale de ahi; el color, de quien es.
        radio = 6 + min(18, int((fg ** 0.5)))
        disco(filas, *punto_a_pixel(c, f), radio,
              MAGENTA if oscuro else CIAN)
    salida = base + "_despliegue.png"
    escribe_png(salida, w, h, [bytes(f) for f in filas], MSX)
    print("%s: %d x %d px  (%d casillas de salida)" % (salida, w, h,
                                                       len(porcasilla)))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
