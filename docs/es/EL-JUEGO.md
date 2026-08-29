# El juego

[Empezar](EMPEZAR.html) · [La cinta](LA-CINTA.html) · [El codigo](EL-CODIGO.html) · [Hallazgos](HALLAZGOS.html) · [Preguntas abiertas](PREGUNTAS-ABIERTAS.html)

War in Middle Earth es un juego de estrategia sobre la Tierra Media: se mueven
ejércitos por un mapa enorme, el tiempo corre, y de vez en cuando dos unidades
se encuentran y hay batalla.

Todo lo que sigue está **medido sobre el binario**. Lo que es una lectura y no
un dato va dicho como tal.

## El mapa

El mapa vive en `0xCC00`-`0xE400` y se direcciona así:

    0xCC67 + columna*102 + fila

con topes de **127 columnas y 99 filas** (los `cp` de `0x734B`). Cada celda son
dos por dos píxeles del mapa grande, y cada celda de atributo de color cubre
cuatro por cuatro celdas (`0x6AC5`).

La brújula son ocho saltos, en la tabla de `0x6B34`: `-1, +101, +102, +103,
+1, -101, -102, -103`. Fíjese en que 102 es la anchura de una columna: los ocho
son las ocho vecinas. La tabla lleva **una entrada de más a cada lado** para que
«dirección ± 1» funcione sin tener que enmascarar el índice.

El mapa **llega de la cinta comprimido**, y se vuelve a comprimir antes de cada
batalla para hacer sitio. Está contado en [Hallazgos](HALLAZGOS.html).

## El reloj, y la derrota por agotamiento

El tiempo del juego vive en los **operandos** de cuatro `ld a,nn`, que es como
este juego guarda casi todas sus variables: `0x831C` el tic, `0x8326` el día,
`0x8355` el mes y `0x8333` la cuenta atrás.

El bucle de partida (`0x7F6B`) llama al reloj en cada vuelta, y:

- a la vuelta **256** avanza un día;
- al día **61** vuelve al 1 y pasa al mes siguiente (1 a 12);
- y en cada mes resta uno a la **cuenta atrás**, que empieza en 255 (`0x7F4F`).
  Si llega a cero, **derrota** (`0x83E1`).

En cada cambio de mes suma uno a los 256 contadores de `0xC300` (saturando en
255) y deja el mensaje «El Anillo corrompe al que lo usa.». El panel *Time* lo
pinta en **números romanos**: `0x8383` escribe una L si el número llega a 50,
una X por decena, y las unidades salen de la tabla de `0x8517`.

**En batalla el reloj no corre**: el bucle de `0x7F57` no gira.

## El Anillo

El **bit 4** de `0xBD00+n` marca la unidad que lo lleva. `0x733E` busca la
primera que lo tenga puesto; el bucle de partida mira si **esa** unidad está en
la casilla `(0x68, 0x3F)` y, si lo está, salta a `0x83D9`. Y cuando el portador
coincide de casilla con otra unidad, `0x6A47` hace `set 4` en la nueva y
`res 4` en la vieja, dejando el mensaje «El Anillo se ha perdido.».

*(Que ese bit sea «lleva el Anillo» es una lectura, aunque todo apunte al mismo
sitio: lo medido es que decide la victoria en `0x7F7D` y la derrota en
`0x9218`.)*

## La batalla

Cuando dos unidades se encuentran, el juego **monta el tablero encima del
código del menú**: `0x5E00`-`0x62FF`. Una vez empezada la partida, el menú y sus
textos son papel de borrador.

Y el tablero es un **damero**. Las cuatro rutinas de movimiento (`0x893E`,
`0x894D`, `0x895C`, `0x896B`) cambian siempre las dos coordenadas a la vez —por
ejemplo `inc b / dec c`—, así que la paridad de x+y no cambia nunca: **las
figuras sólo se mueven en diagonal**. El despliegue rechaza cualquier par de
paridad distinta, y los obstáculos van justo en las casillas del otro color.

Los dibujos de las figuras son 176 sprites de 16×8 con máscara, 32 bytes cada
uno, en `0xA2E8`. Están en la galería de la portada.

## Los mensajes, y el idioma

Los textos del juego están **en castellano**: «La Batalla ha comenzado», «Elige
el enemigo a atacar», «No puedes atacar a un amigo», «No pertenece a tu
Alianza», «Aqui no hay nadie». Son seis, apuntados por la tabla de punteros de
`0x93D9`, y el número que se deja en `0x9190` elige cuál sale.

Los rótulos de la cinta —«Cargando Posiciones» y compañía— están en `0x9687`, y
los de los paneles (*File*, *Memo*, *Time*, «Volver/Cargar/Salvar», «Pulsa
Fuego») en `0x83F8`.

## Y no suena nada

El juego **es mudo**, y no por falta de código: la conversión se trajo del
Spectrum el motor de sonido entero. Simplemente no lo llama nadie. Está medido
en [Hallazgos](HALLAZGOS.html).
