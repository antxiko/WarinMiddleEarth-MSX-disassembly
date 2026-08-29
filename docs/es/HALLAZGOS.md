# Hallazgos

[Empezar](EMPEZAR.html) · [El juego](EL-JUEGO.html) · [La cinta](LA-CINTA.html) · [El codigo](EL-CODIGO.html) · [Preguntas abiertas](PREGUNTAS-ABIERTAS.html)

Casi todo lo de esta página salió de leer el listado instrucción a instrucción
para comentarlo. Cada cosa lleva la dirección al lado, que es lo que permite
comprobarla.

---

## 1. El juego es mudo, y se puede señalar dónde se quedó el sonido

La conversión se trajo del Spectrum el motor de sonido **entero**: está en
`0x6600`, saca las notas por el `out (0xFE)` con el bit 4 —el altavoz del ZX— y
detrás lleva cinco efectos de veintiún bytes en `0x636F`-`0x63D7`.

**No lo llama nadie.** Ni una sola instrucción de los cinco listados apunta a
`0x6600`.

Y los cuatro sitios que piden un efecto —`0x5F90`, `0x647A`, `0x6AA1` y
`0x833D`— llaman a `0x65FF`, que es **un `ret` pelado**.

¿Y el PSG del MSX? Se le escriben exactamente **dos registros, el 7 y el 14**, y
los dos en la rutina del joystick de `0x046E`: el 7 para poner los puertos como
entrada y el 14 para leerlos. Ni un registro de tono ni de volumen, en toda la
cinta. La única rutina que sabría escribir una nota en el PSG, `0x04F2`, tampoco
la llama nadie, y ya estaba anotada como código muerto.

No hay un tercer camino. **Este juego no suena.**

---

## 2. En `0x62FF` no está el dibujo del cursor: está lo que el cursor tapa

Esos 24 bytes estaban documentados en este mismo proyecto como «el dibujo de la
marca del cursor». **Es falso**, y el listado lo desmiente sin lugar a dudas.

`0x6580` mete `0x62FF` en el HL alternativo, y el bucle de `0x65B4`-`0x65D5`,
por cada uno de los tres bytes de la columna, hace esto:

```
65B4  ld a,(iy+000h)   ; LEE la pantalla
65B7  exx
65B8  ld (hl),a        ; y la guarda en 0x62FF++
65B9  inc hl
65BA  exx
65BB  and e            ; y SOLO ENTONCES compone el cursor
65BC  or b
65BD  ld (iy+000h),a
```

Y `0x64DC` hace el camino de vuelta (`ld a,(de) / ld (hl),a`) para borrarlo.

El dibujo de verdad está en `0x6345`, con su máscara detrás
(`ld ix,0x6345` en `0x657B`).

Lo bonito es lo que eso convierte en los bytes que trae la cinta: los `0xAD` que
hay en `0x62FF` no son un dibujo, son **lo que había debajo del cursor el día
que se grabó la cinta**.

---

## 3. Los tiles del mapa van a nueve bytes

Un tile de MSX ocupa ocho bytes. Los del mapa de este juego ocupan **nueve**:
las ocho líneas del dibujo y, pegado detrás, **un atributo del ZX Spectrum**
—tinta en los bits 0-2, papel en los 3-5, brillo en el 6—.

Los lee `0x75C7`-`0x75EB` cuando el código de la rejilla lleva puesto el bit 7.
La conversión no rehizo los gráficos: se trajo los del Spectrum con su color
puesto y los traduce al vuelo, con la rutina de `0x049F`, que convierte un
atributo del Spectrum en un byte de color de SCREEN 2.

Es la huella más limpia de la conversión que hay en toda la cinta, y por eso los
tiles de la galería salen con su color de verdad: se lee el atributo que llevan
dentro.

---

## 4. El tablero de batalla se monta encima del menú, y es un damero

La batalla usa `0x5E00`-`0x62FF`, que es **donde vive el código del menú**. Lo
dice `0x8E08` con su `ld b,0x5E`, y el `ldir` de `0x904D` borra 0x500 bytes ahí
antes de cada batalla. Una vez empezada la partida, el menú y sus textos son
papel de borrador.

Y el tablero es un **damero**: las cuatro rutinas de movimiento (`0x893E`,
`0x894D`, `0x895C`, `0x896B`) cambian siempre las dos coordenadas a la vez —el
primero, por ejemplo, hace `inc b / dec c`—, así que la paridad de x+y no cambia
nunca. Las figuras **sólo se mueven en diagonal**. El despliegue (`0x8D6E`)
rechaza cualquier par de paridad distinta, y los obstáculos (`0x9079`) van justo
en las casillas del otro color.

---

## 5. El filtro de amigo o enemigo es un interruptor por opcode

Para recorrer las unidades del bando contrario, el juego no usa una bandera ni
un salto: **se reescribe la instrucción**.

```
8980  ld a,0d0h        ; 0xD0 = ret nc
8982  ld (08af3h),a
...
8991  ld a,0d8h        ; 0xD8 = ret c
8993  ld (08af3h),a
```

La misma rutina, con el mismo umbral, devuelve las unidades de un bando o las
del otro según qué **opcode** se le haya escrito encima un momento antes.

---

## 6. El mapa viaja comprimido, y se vuelve a comprimir antes de cada batalla

`0x9366` aparta los `0x16ED` bytes comprimidos del mapa a `0x4000` con un
`ldir` y luego los expande a los `0x33CD` de `0xCC00`, leyendo parejas de cuenta
y valor. Lo llama `0x5E28`, en el arranque: el mapa **llega de la cinta ya
comprimido**.

Y `0x9394` hace lo contrario antes de cada batalla, volviéndolo a dejar en
`0x16EC` bytes. Eso no es para ahorrar cinta —la cinta ya está grabada—, es para
**hacer sitio en la RAM**: lo que se libera, `0xE2EC`-`0xFFFF`, es exactamente
donde viven los búferes de la batalla.

---

## 7. Los sprites de batalla no están donde parece

176 sprites de 16×8 con máscara, 32 bytes cada uno, en `0xA2E8` +
`(tipo-4)*32`. Pero los 32 bytes **no son «16 de dibujo y 16 de máscara»**: van
en **parejas**, primero la máscara y detrás el dibujo, porque la rutina que los
pinta hace `and (hl) / inc hl / or (hl) / inc hl` por cada byte de pantalla.

Y no van en orden de arriba abajo, sino en **zigzag**: `0x887B` escribe la
izquierda, `inc e` a la derecha, `inc d` para bajar una línea y `dec e` para
volver a la izquierda, ahorrándose recolocar DE. Dibujarlos suponiendo el orden
obvio da ruido convincente, que es la peor clase de error.

---

## 8. Restos del Spectrum que en un MSX no significan nada

- El **modo de control 2** del menú —el Interface Two del Spectrum— no existe
  aquí: su puntero, en `0x06D7`, es `0x0000`, y por eso el menú salta del 1 al
  3.
- El bloque de teclado del ZX de `0x5F75`-`0x5FB7`, que lee el puerto `0xFE`, es
  código muerto.
- Y en la rutina de **grabar la partida** quedó sin convertir la comprobación de
  la tecla de parada: `0x0930` hace `in a,(0xFE)`, que en un MSX no es el
  teclado.

---

## 9. Cosas que no llegan a ejecutarse

- **`0x68C8`: el `ld a,0x3C` no sirve para nada.** A `L_67C5` sólo se entra
  desde `L_67B0` (`0x67B4` y `0x67BE` son las dos únicas referencias), y allí C
  vale 0, 2 o 3. Con C=0 no se llega hasta ahí, así que en `0x68CA` el bit 1 de
  C siempre está puesto, el `inc a` siempre corre y A sale siempre `0x3D`.
  Consecuencia: la unidad guarda en los bits 7 de sus coordenadas por qué lado
  rodeaba un obstáculo, pero al reanudar **siempre gira hacia el mismo lado**.
- **`ld hl,(0x6543)` en `0x6578` es una carga muerta**: `0x658F` la pisa antes de
  usarla, y la única salida por en medio (`jr nc,L_65F9`) tampoco toca HL.
- **La fuente de `0xC800` empieza vacía**: los códigos `0x00`-`0x20` son **33
  caracteres a cero**, contados byte a byte. El primero con dibujo es el
  `0x21`.
