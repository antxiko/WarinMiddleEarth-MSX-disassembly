# La cinta

[Empezar](EMPEZAR.html) · [El juego](EL-JUEGO.html) · [El codigo](EL-CODIGO.html) · [Hallazgos](HALLAZGOS.html) · [Preguntas abiertas](PREGUNTAS-ABIERTAS.html)

Lo primero que sorprende de esta cinta es que **no es una cinta de MSX**.

## Bloques del Spectrum en un juego de MSX

El fichero es un **TSX** y sus bloques son los del ZX Spectrum (TZX tipo
`0x10`), con la estructura de siempre: `[bandera][datos][XOR]`. No hay bloques
KCS del MSX por ninguna parte.

Y el cargador no es el de la BIOS: es una **reimplementación de LD-BYTES**, la
rutina de la ROM del Spectrum, escrita a mano para el MSX. Vive en `0xD6D8` y
son 681 bytes. Se trajeron el sistema de cinta entero porque era más barato que
rehacerlo.

Hay una segunda copia de ese cargador **dentro del juego**, en `0x07F9`, más la
de grabar en `0x08B2`: son las que usan el guardar y cargar partida. La de leer
es la misma rutina con dos diferencias que se pueden señalar: aquí **sí** hay
salida por fallo (el `ret nz` de `0x0819`) y el borde sube de color de uno en
uno en vez de ir al azar.

## Los cuatro bloques, y adónde van de verdad

El cargador lee cuatro bloques seguidos y ninguno se ejecuta donde cae:

| bloque | cae en | acaba en | bytes |
|---|---|---|---:|
| la pantalla de carga | `0x88B8` | la VRAM | 12.388 |
| el bloque bajo | `0x0190` | `0x0190` (no se mueve) | 15.807 |
| el bloque medio | `0x3F4F` | **`0x5E00`** | 14.577 |
| el bloque alto | encima de la pantalla | **`0x9E00`** | 18.552 |

La pantalla de carga se vuelca a la VRAM nada más leerla, y por eso el bloque
alto puede cargarse justo encima: para cuando llega, ese trozo de RAM ya no
hace falta.

El bloque bajo es el que recoloca a los otros dos. Sus cuentas están escritas
en el propio listado y salen exactas:

    0xE677 - 0x4878 + 1 = 0x9E00     (el bloque alto, 18.552 bytes)
    0x96F0 - 0x38F1 + 1 = 0x5E00     (el bloque medio, 14.577 bytes)

y los copia **de atrás adelante**, porque origen y destino se solapan.

## Las cuatro páginas en RAM, y sin BIOS

Antes de nada, el cargador deja **las cuatro páginas del MSX en RAM**. A partir
de ahí no hay BIOS: el juego se lo hace todo él, y por eso el bloque bajo lleva
su propia capa de VRAM, de teclado, de joystick y de conversión de color.

Eso obliga a trazar el juego sobre una imagen de 64 KB —`work/juego64.bin`— y a
partirlo después en tres listados, cada uno con el `org` donde de verdad se
ejecuta.

## Y un buzón de POKEs

El arranque (`0x0190`) hace algo que no se ve todos los días: comprueba que los
tres primeros bytes de los 100 que el cargador trajo a `0x012C` valgan `0xC9`, y
si es así **aplica lo que venga detrás**. Es un buzón para parchear el juego
desde la cinta sin tocar el código.

## El presupuesto: ni un byte sin explicar

```
modulo             bytes  codigo   datos  sin explicar
loader               681     675       6             0
pantalla           12388      34   12354             0
bajo               15807    1218   14589             0
medio              14577    9887    4690             0
alto               18552       0   18552             0
cargador BASIC       256   dos lineas de texto y relleno
TOTAL              62261 bytes, 62261 explicados (100,00 %)
```

El cargador BASIC son dos líneas: una que pone `COLOR` y `SCREEN 2`, y otra con
el `BLOAD`. El resto de sus 256 bytes es el relleno `^Z` que el MSX escribe
hasta completar el trozo.
