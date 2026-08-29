# Empezar

[El juego](EL-JUEGO.html) · [La cinta](LA-CINTA.html) · [El codigo](EL-CODIGO.html) · [Hallazgos](HALLAZGOS.html) · [Preguntas abiertas](PREGUNTAS-ABIERTAS.html)

Este repositorio contiene un **desensamblado comentado** de War in Middle Earth
para MSX (Melbourne House / Dro Soft, 1989). Todo lo que hay aquí sale del
binario y se puede volver a generar a partir de él.

## Qué hace falta

- **Python 3** (sin paquetes de terceros)
- **pasmo**, para reensamblar
- **z80dasm**, sólo para los nemónicos
- la cinta, que este repositorio **no distribuye**

La cinta va en la raíz, con el nombre `war.tsx`, y el `Makefile` la pide por su
sha256:

    13c636328d1714d5e00419141ca1a7ac9c7a3a04d7ec2b26545212aab1d81208

Es un **TSX**, no un `.cas`: los bloques no son los del MSX sino los del ZX
Spectrum, porque la conversión se trajo el sistema de cinta entero. Está
contado en [La cinta](LA-CINTA.html).

## La comprobación que importa

    make verify

Reensambla los cinco listados con pasmo y compara cada uno, byte a byte, con el
trozo de cinta que le corresponde. Si los cinco dicen `OK: reproducible byte a
byte`, el desensamblado no se ha inventado nada.

## Todo lo demás que se puede lanzar

    make            # el ciclo entero: extraer, trazar, listar, verificar
    make listados   # regenera los cinco src/war_*.asm
    make sanity     # las comprobaciones que el reensamblado NO cubre
    make test       # los tests
    make imagenes   # redibuja los PNG de docs/imagenes desde la cinta
    make web        # regenera esta web

`make sanity` es el que vigila lo que un reensamblado correcto puede esconder:
datos leídos como código, y bytes de la cinta sin explicar. Hoy dice
**62.261 de 62.261, el 100 %**.

## Los cinco listados

El juego corre con **las cuatro páginas en RAM y sin BIOS**, y los tres bloques
grandes no se ejecutan donde se cargan: el arranque los recoloca. Por eso hay
cinco listados y no tres.

| listado | org | qué es |
|---|---|---|
| `war_loader.asm` | `0xD6D8` | el cargador: monta la RAM y lee los cuatro bloques |
| `war_pantalla.asm` | `0x88B8` | la pantalla de carga (casi toda, datos) |
| `war_bajo.asm` | `0x0190` | la capa MSX: VRAM, teclado, joystick, color, cinta |
| `war_medio.asm` | `0x5E00` | **el juego** |
| `war_alto.asm` | `0x9E00` | gráficos, mapa y tablas (todo datos) |

## Y una advertencia sobre las imágenes

Ninguna de las de `docs/imagenes/` es una captura. Las dibujan
`tools/render_carga.py` y `tools/render_graficos.py` leyendo los bytes de la
cinta en los rangos que el listado tiene acotados. Si un rango estuviera mal
etiquetado, saldría ruido.
