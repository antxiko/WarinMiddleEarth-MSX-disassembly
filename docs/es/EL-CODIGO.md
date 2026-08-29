# El codigo

[Empezar](EMPEZAR.html) · [El juego](EL-JUEGO.html) · [La cinta](LA-CINTA.html) · [Hallazgos](HALLAZGOS.html) · [Preguntas abiertas](PREGUNTAS-ABIERTAS.html)

## El mapa de memoria, una vez colocado

| dirección | qué hay |
|---|---|
| `0x0190`-`0x3F4E` | la **capa MSX**: VRAM, teclado, joystick, color, cinta |
| `0x5E00`-`0x96F0` | **el juego**: menú, mundo, partida, batalla y paneles |
| `0x9E00`-`0xE677` | **gráficos, mapa y tablas**, ni un byte de código |

Dentro del bloque alto, cada cosa en su sitio:

| dirección | bytes | qué es |
|---|---:|---|
| `0x9E00`-`0xA280` | 1.152 | 128 tiles del mapa, de **nueve** bytes |
| `0xA2E8`-`0xB8E8` | 5.632 | 176 sprites de batalla de 16×8 con máscara |
| `0xB8E8`-`0xC600` | — | tablas de estado del juego |
| `0xC800`-`0xCC00` | 1.024 | la fuente: 128 caracteres de ocho bytes |
| `0xCC00`-`0xE400` | 6.144 | **el mapa** |
| `0xE400`-`0xE678` | 632 | tablas finales |

Y una cosa que explica una dirección rara: el mapa empieza en `0xCC67` y no en
`0xCC00` porque justo delante están los `0x80` caracteres imprimibles de la
fuente. Los códigos `>= 0x80` son tiles del mapa, de nueve bytes; los `< 0x80`
son caracteres, de ocho.

## Las variables viven dentro de las instrucciones

Este juego guarda casi todo en los **operandos** de sus propios `ld`. El reloj
son cuatro `ld a,nn` (`0x831C`, `0x8326`, `0x8333`, `0x8355`); el cargador de
cinta guarda ahí su puntero; y la batalla llega a reescribir **opcodes**, no
sólo operandos: `0x8982` mete un `0xD0` (`ret nc`) o un `0xD8` (`ret c`) dentro
de `0x8AF3` para que la misma rutina recorra un bando o el otro.

Eso obliga a trazar el flujo de verdad y a justificar cada punto de entrada,
porque un desensamblado lineal se pierde en cuanto una tabla de saltos o un
operando automodificado deciden adónde se va.

## Cómo se hizo el listado

- El juego se traza **entero sobre la imagen de 64 KB**, porque los tres
  bloques se llaman entre sí, y luego se parte en tres listados con `org`
  distinto.
- Los puntos de entrada que el trazador no puede deducir —retornos empujados a
  la pila, tablas de saltos, operandos automodificados— van en
  `src/juego.entries`, **cada uno con la instrucción que lo justifica**.
- Los huecos entre bloques van declarados en `src/juego.nocode` para que una
  llamada perdida no se trague ceros como código.
- `make sanity` cruza las **52 zonas de datos declaradas** contra lo que el
  trazador cree, y comprueba que no quede un byte de la cinta sin explicar.

## Los comentarios, medidos

    make densidad

| listado | instrucciones | comentarios | densidad | rutinas flojas |
|---|---:|---:|---:|---:|
| `war_loader` | 379 | 150 | 39,6 % | 0 de 48 |
| `war_pantalla` | 14 | 10 | 71,4 % | 0 de 1 |
| `war_bajo` | 785 | 226 | 28,8 % | 0 de 96 |
| `war_medio` | 5.664 | 1.645 | **29,0 %** | **0 de 621** |
| **total** | **6.844** | **2.031** | **29,7 %** | **0 de 767** |

El listón de la serie son dos cifras, y las dos se cumplen: **más del 22 % de
densidad y ninguna rutina por debajo del 10 %**.

El bloque grande, el del juego, estaba en **11 comentarios de 5.664
instrucciones** —el 0,2 %— antes de esta pasada. Leerlo línea a línea para
comentarlo es lo que destapó casi todo lo que hay en
[Hallazgos](HALLAZGOS.html), empezando por que en `0x62FF` no está el dibujo del
cursor sino lo que el cursor tapa.
