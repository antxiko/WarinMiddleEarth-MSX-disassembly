# War in Middle Earth (MSX, 1989) - desensamblado comentado

*(Also available [in English](README.md).)*

Desensamblado completo y reproducible byte a byte de la cinta de MSX de
**War in Middle Earth** (Melbourne House / Dro Soft, 1989, conversion de
Animagic S.A.). El listado se genera a partir de un trazado de flujo real, no de
un desensamblado lineal, y `make verify` comprueba que al reensamblarlo vuelve a
salir cada trozo de la cinta exacto.

**La web, con las imagenes:** [antxiko.github.io/WarinMiddleEarth-MSX-disassembly](https://antxiko.github.io/WarinMiddleEarth-MSX-disassembly/)

## La cinta no esta aqui

Este repositorio contiene solo el trabajo de documentacion. Para reconstruirlo
todo hace falta tu propia copia de la cinta, con el nombre `war.tsx` en la raiz
y este sha256:

    13c636328d1714d5e00419141ca1a7ac9c7a3a04d7ec2b26545212aab1d81208

## Que tiene de raro este juego

Es una **conversion del ZX Spectrum** (Melbourne House, 1988) y se trajeron el
sistema de cinta entero. Los bloques no son KCS del MSX sino del Spectrum (TZX
`0x10`), con su `[bandera][datos][XOR]`, y el cargador es una reimplementacion a
mano de la rutina LD-BYTES de la ROM del Spectrum.

El juego corre con **las cuatro paginas del MSX en RAM y sin BIOS**, en tres
bloques que el arranque recoloca. Por eso se traza sobre una imagen de 64 KB y
se parte despues en tres listados, cada uno con el `org` donde de verdad se
ejecuta.

## Algo de lo que aparecio

- **El juego es mudo.** El motor de sonido del altavoz del Spectrum se vino
  entero, en `0x6600`, y **no lo llama nadie**; los cuatro sitios que piden un
  efecto acaban en un `ret` pelado en `0x65FF`; y del PSG del MSX solo se
  escriben los dos registros del joystick.
- **Los tiles del mapa van a nueve bytes**: ocho de dibujo y un atributo del ZX
  Spectrum pegado detras. La conversion no rehizo los graficos, traduce el color
  al vuelo.
- **En `0x62FF` no esta el dibujo del cursor**: ahi es donde el cursor guarda el
  fondo que tapa. Los bytes que trae la cinta son lo que habia debajo el dia que
  se grabo.
- **El tablero de batalla se monta encima del codigo del menu**, y es un damero:
  las figuras solo se mueven en diagonal.
- **El filtro de amigo o enemigo es un interruptor por opcode**: el juego escribe
  `0xD0` (`ret nc`) o `0xD8` (`ret c`) en mitad de una rutina para que recorra un
  bando o el otro.
- **El mapa viaja comprimido y se vuelve a comprimir antes de cada batalla**,
  para liberar justo la RAM que necesitan los buferes de la batalla.

Estan todos en [docs/es/HALLAZGOS.md](docs/es/HALLAZGOS.md), cada uno con la
direccion que lo demuestra.

## Uso

    make verify     # extrae, traza, genera y comprueba byte a byte
    make sanity     # coherencia del trazado y presupuesto al 100 %
    make test       # los tests
    make imagenes   # redibuja los PNG desde la cinta
    make web        # regenera la web

Hace falta `pasmo`, `z80dasm` y `python3`.

## Las cifras

```
cinta entera                62.261 bytes
  codigo trazado            11.814
  datos con nombre          50.191
  sin explicar                   0   ->  100,00 %

listados                         5
rangos de datos declarados      52
instrucciones                6.844
comentarios de linea         2.031
densidad                      29,7 %    (liston de la serie: 22 %)
rutinas flojas                    0 de 767
```

## Las imagenes no son capturas

Todo lo de `docs/imagenes/` esta **dibujado desde los bytes de la cinta**:
`tools/render_carga.py` rehace la pantalla de carga tal como la sube el
cargador, y `tools/render_graficos.py` revela los tiles del mapa con su atributo
del Spectrum, los sprites de batalla con su mascara, y la fuente. Si un rango
estuviera mal etiquetado, saldria ruido.

## Documentacion

La web es bilingue y se genera con `make web`. Las paginas viven en `docs/`
(ingles) y `docs/es/` (castellano):

- [docs/es/HALLAZGOS.md](docs/es/HALLAZGOS.md) - lo que aparecio al desmontarla.
- [docs/es/PREGUNTAS-ABIERTAS.md](docs/es/PREGUNTAS-ABIERTAS.md) - lo que queda
  abierto, separando lo MEDIDO de lo SUPUESTO.
- [docs/es/LA-CINTA.md](docs/es/LA-CINTA.md) - bloques del Spectrum en un juego
  de MSX.
- [docs/es/EL-JUEGO.md](docs/es/EL-JUEGO.md) y
  [docs/es/EL-CODIGO.md](docs/es/EL-CODIGO.md) - como esta montado por dentro.

## Licencia y atribucion

Las herramientas, los comentarios y la documentacion de este repositorio van con
la licencia de [LICENSE](LICENSE). **El juego no**: sus derechos siguen siendo
de sus titulares, y la cinta no se distribuye aqui. Esta contado en
[AVISO-LEGAL.md](AVISO-LEGAL.md).
