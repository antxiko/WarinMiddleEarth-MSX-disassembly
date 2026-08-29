# Preguntas abiertas

[Empezar](EMPEZAR.html) · [El juego](EL-JUEGO.html) · [La cinta](LA-CINTA.html) · [El codigo](EL-CODIGO.html) · [Hallazgos](HALLAZGOS.html)

Lo que queda abierto, separando lo MEDIDO de lo SUPUESTO. Lo medido lleva al
lado la medida; lo supuesto va marcado como tal y **no se ha escrito en el
listado como si fuera un hecho**.

---

## MEDIDO, y cerrado

- La cinta entera: **62.261 bytes, 62.261 explicados, cero sin explicar**.
- Los cinco listados **reensamblan byte a byte** con pasmo.
- **52 zonas de datos** declaradas, todas cruzadas contra el trazado.
- Comentado al **29,7 %**, sin una sola rutina por debajo del 10 % de 767.
- El presupuesto se cerró con la **partida completa de Araubi**: los 13,8 KB que
  quedaban sin ver eran las dos pantallas finales.

---

## SUPUESTO (marcado como tal)

- **Que el bit 4 de `0xBD00+n` sea «lleva el Anillo».** Lo medido es que
  `0x733E` busca la primera unidad con ese bit, que el bucle de partida mira si
  esa unidad está en `(0x68, 0x3F)`, y que decide la victoria (`0x7F7D`) y la
  derrota (`0x9218`). Todo apunta al mismo sitio, pero el binario no lo dice con
  esas palabras.
- **Que las unidades `0x16` y `0x17` sean Sauron y Saruman.** La cadena es
  larga: `0x72FD` guarda el portador y hace `inc a` para marcar el renglón, y
  `0x7314` hace `dec a` al volver; luego renglón = unidad + 1 y el renglón 0 es
  «Vuelve», así que unidad *n* es el nombre *n+1* de la lista de `0x6B46`.
  Contando salen Gollum, Sauron y Saruman. Encaja con que `0x6AE3` se salte
  justo esas dos al pintar ejércitos y con que `0x7514` (elegir enemigo) acepte
  exactamente `{0x16, 0x17, >= 0x78}`. Es una deducción, no una lectura directa.
- **Que las figuras se apilen de dos en dos.** Medido: cada sprite son 32 bytes
  de 16×8. Que las entradas consecutivas encajen en figuras de 16×16 es lo que
  se ve al dibujarlas, pero **no se ha encontrado la rutina que las apile**.

---

## ABIERTO: lo que no se ha podido cerrar

### 1. El interior de las tablas de estado

`0xB8E8`-`0xC600` y `0xE400`-`0xE678` están acotadas y se sabe quién las lee
(`0x6AC2`, `0x6EAC`, `0x8F7A`, `0x92E4`, `0x81A9`, `0x8189`, `0x7FF0`), pero
**no se han desmenuzado campo a campo**. Se llama X a `0xB900` y Y a `0xBA00`
porque `0x8108` multiplica la primera por 102, que es el paso de columna, y
`0x8166` recorre columnas en el bucle exterior; es consistente, no demostrado.

### 2. Qué añade la segunda pasada del mapa

El dibujo del mapa hace tres pasadas. La segunda (`0x7714`) indexa `0x77B5` con
**el mismo nibble bajo** que ya usó la pasada de terreno (`0x7687`), y no se ha
podido decir qué aporta.

### 3. Quién pone el bit 7 de un byte del mapa

La tercera pasada de `0x7708` sólo pinta si ese bit está puesto. Se pone desde
`0x8F70`, `0x8044` y `0x80BD`, pero no se ha cerrado con qué criterio.

### 4. El trasiego de nibbles con la cuenta atrás

`0x6A76`-`0x6A94` coge el operando de `0x8333` —que es la cuenta atrás de meses,
puesta a 255 en `0x7F4F`—, lo guarda **multiplicado por 16** y mete su nibble
alto menos uno en el nibble bajo de `0xC000+portador`. Con 255 dentro, eso deja
la cuenta atrás en 240 a la primera y en 0 a la segunda. O es un castigo
intencionado, o ese byte tiene un segundo uso que no se ha sabido ver. Está
comentado describiendo **lo que hace**, sin interpretarlo.

### 5. `0x9144` lee lo que `0x904D` acaba de borrar

En la misma rutina, a unas pocas instrucciones: `0x904D` pone a cero
`0x5E00`+`0x4FF` —`0x6010` incluido— y `0x9144` hace luego `ld hl,0x6010 /
ld a,(hl) / ld (0x8B19),a`. O está pensado para leer el tablero de batalla, o es
un resto del Spectrum donde ese byte estaba en otro sitio. Se ha comentado el
mecanismo, no la intención.

### 6. Filas de tiles que se calculan y no se dibujan

`0x86AF` calcula **19 filas** de tiles (`ld c,0x13` en `0x86CC`) pero el bucle
que dibuja hace 16×16. Tres filas que se preparan y no se ven.

### 7. Dos rangos que habría que separar

Hoy están dentro de `textos_de_los_paneles` y merecen nombre propio:
`0x83F8`-`0x83FB`, que son los cuatro rellenos de dos bits (`00`, `FF`, `AA`,
`55`), y `0x846F`-`0x8496`, que son las cinco texturas de terreno que escoge
`0x80BD`.
