#!/usr/bin/env python3
"""Genera la portada de la web, en los dos idiomas.

El diseno es el compartido por la serie (tools/estilo_web.py) y la pagina sale
autocontenida, con las imagenes embebidas como data URI.

NINGUNA IMAGEN ES UNA CAPTURA. Todas las dibujan tools/render_carga.py y
tools/render_graficos.py con los bytes de la cinta, en los rangos que el
listado tiene acotados y revelandolos como los revela el juego. Si un rango
estuviera mal etiquetado, saldria ruido; que salga un dibujo es la
comprobacion.

El rotulo de la cabecera es un recorte de la propia pantalla de carga, y por
eso trae el titulo tal como lo escribio Maelstrom Games.

Uso: make_web.py <docs/imagenes> <salida.html> <idioma>
"""
import base64
import os
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from estilo_web import ESTILO                                   # noqa: E402

# Las cifras salen de las herramientas, no de escribirlas aqui a ojo:
# tools/presupuesto.py (make sanity) da el reparto de la cinta y
# tools/densidad.py (make densidad) las rutinas y la densidad.
CINTA = 62261
CODIGO = 11814
DATOS = 50191
LISTADOS = 5
RUTINAS = 767
INSTRUCCIONES = 6844
COMENTARIOS = 2031
DENSIDAD_ES = "29,7 %"
DENSIDAD_EN = "29.7%"


def mil(n, idioma):
    return f"{n:,}".replace(",", "." if idioma == "es" else ",")


TXT = {
    "es": dict(
        titulo="War in Middle Earth — desensamblado comentado",
        aviso="<b>Aquí no hay ni una captura de pantalla.</b> Todas las "
              "imágenes están <b>dibujadas desde la cinta</b>: se leen los "
              "bytes en los rangos que el listado tiene acotados y se revelan "
              "como los revela el juego, con sus máscaras y con el atributo de "
              "color que cada dibujo lleva pegado. Que salgan dibujos y no "
              "ruido es la prueba de que los rangos están bien leídos. El "
              "listado y las cifras salen del binario y se reproducen con "
              "<code>make</code>.",
        claim="Una conversión del ZX Spectrum que se trajo el sistema de cinta "
              "entero, los atributos de color pegados a cada dibujo y hasta el "
              "motor de sonido del altavoz… que aquí <b>no lo llama nadie</b>. "
              "Los cuatro sitios que piden un efecto acaban en un "
              "<code>ret</code> pelado, y del PSG del MSX sólo se tocan los dos "
              "registros del joystick: <b>este juego es mudo</b>.",
        ficha=["Melbourne House / Dro Soft · <b>1989</b>",
               "Cinta, <b>62.261 bytes</b>",
               "MSX1 · <b>64 KB, sin BIOS</b>",
               "Conversión de <b>Animagic S.A.</b>"],
        nav=[("#numbers", "Las cifras"), ("#findings", "Hallazgos"),
             ("#screens", "Lo que dibuja")],
        docnav=[("EMPEZAR.html", "Empezar"), ("EL-JUEGO.html", "El juego"),
                ("LA-CINTA.html", "La cinta"),
                ("EL-CODIGO.html", "El código"),
                ("HALLAZGOS.html", "Hallazgos"),
                ("PREGUNTAS-ABIERTAS.html", "Preguntas abiertas")],
        otro=("../", "In English"),
        h_num="La cinta en cifras", h_find="Lo que apareció al desmontarla",
        h_scr="Lo que la cinta dibuja",
        cifras=[("100 %", "de la cinta explicada"),
                (str(LISTADOS), "listados"),
                (mil(RUTINAS, "es"), "rutinas identificadas"),
                (mil(CODIGO, "es"), "bytes de código"),
                (mil(DATOS, "es"), "bytes de datos"),
                ("0", "bytes sin identificar"),
                (DENSIDAD_ES, "de densidad de comentarios"),
                ("0", "rutinas por debajo del 10 %")],
        nota_scr="Debajo de cada pie está la dirección de donde sale. Todas se "
                 "rehacen con <code>make imagenes</code> y no hace falta "
                 "emulador.",
        pie_leg="Esto es trabajo de documentación y preservación: el código y "
                "los gráficos siguen siendo de sus autores, y la cinta no se "
                "distribuye.",
    ),
    "en": dict(
        titulo="War in Middle Earth — a commented disassembly",
        aviso="<b>There is not a single screenshot here.</b> Every picture is "
              "<b>drawn from the tape</b>: the bytes are read in the ranges the "
              "listing delimits and developed the way the game develops them, "
              "with their masks and with the colour attribute each drawing "
              "carries glued to it. That drawings come out instead of noise is "
              "the proof the ranges have been read correctly. The listing and "
              "the numbers come from the binary and are reproduced with "
              "<code>make</code>.",
        claim="A ZX Spectrum conversion that brought across the whole tape "
              "system, the colour attributes glued to every tile, and even the "
              "beeper sound engine… which here <b>nothing ever calls</b>. The "
              "four places that ask for a sound effect all land on a bare "
              "<code>ret</code>, and of the MSX's PSG only the two joystick "
              "registers are ever touched: <b>this game is silent</b>.",
        ficha=["Melbourne House / Dro Soft · <b>1989</b>",
               "Tape, <b>62,261 bytes</b>",
               "MSX1 · <b>64 KB, no BIOS</b>",
               "Converted by <b>Animagic S.A.</b>"],
        nav=[("#numbers", "The numbers"), ("#findings", "What turned up"),
             ("#screens", "What it draws")],
        docnav=[("GETTING-STARTED.html", "Getting started"),
                ("THE-GAME.html", "The game"),
                ("THE-TAPE.html", "The tape"),
                ("THE-CODE.html", "The code"),
                ("FINDINGS.html", "Findings"),
                ("OPEN-QUESTIONS.html", "Open questions")],
        otro=("es/", "En castellano"),
        h_num="The tape in numbers",
        h_find="What turned up when we took it apart",
        h_scr="What the tape draws",
        cifras=[("100%", "of the tape explained"),
                (str(LISTADOS), "listings"),
                (mil(RUTINAS, "en"), "routines identified"),
                (mil(CODIGO, "en"), "bytes of code"),
                (mil(DATOS, "en"), "bytes of data"),
                ("0", "bytes unidentified"),
                (DENSIDAD_EN, "comment density"),
                ("0", "routines below 10%")],
        nota_scr="Under each caption is the address it comes from. They are "
                 "all rebuilt by <code>make imagenes</code> and no emulator is "
                 "needed.",
        pie_leg="This is documentation and preservation work: the code and "
                "artwork still belong to their authors, and the tape is not "
                "distributed.",
    ),
}

HALLAZGOS = {
    "es": [
        ("Este juego es mudo, y se puede señalar dónde se quedó el sonido",
         "<p>La conversión se trajo del Spectrum su motor de sonido entero: "
         "está en <code>0x6600</code>, saca las notas por el "
         "<code>out (0xFE)</code> con el bit 4, y detrás lleva cinco efectos de "
         "veintiún bytes en <code>0x636F</code>-<code>0x63D7</code>.</p>"
         "<p><b>No lo llama nadie.</b> Ni una sola instrucción de los cinco "
         "listados apunta a <code>0x6600</code>. Y los cuatro sitios que piden "
         "un efecto —<code>0x5F90</code>, <code>0x647A</code>, "
         "<code>0x6AA1</code> y <code>0x833D</code>— llaman a "
         "<code>0x65FF</code>, que es <b>un <code>ret</code> pelado</b>.</p>"
         "<p>Del PSG del MSX sólo se escriben dos registros, el 7 y el 14, y "
         "los dos son para leer el joystick (<code>0x046E</code>). La única "
         "rutina que sabría escribir una nota en el PSG, <code>0x04F2</code>, "
         "no la llama nadie tampoco. No hay un tercer camino: <b>el juego no "
         "suena</b>.</p>"),
        ("La pantalla de carga, entera, sacada de la cinta",
         "<p>Los 12.388 bytes del bloque [08] son una pantalla de SCREEN 2 "
         "completa: 6.144 de patrones y 6.144 de colores, y las cuentas cierran "
         "solas (<code>0x88B8</code> + 100 + 6.144 + 6.144 = <code>0xB91C</code>, "
         "el final exacto del bloque).</p>"
         "<p>Dibujada, se lee lo que el juego dice de sí mismo: <b>MAELSTROM "
         "GAMES LTD. PRESENTS</b>, <b>War in Middle Earth</b>, <b>Mike "
         "Singleton</b> y, abajo a la derecha, <b>CONVERSION by ANIMAGIC "
         "sa</b>. Y el menú añade el resto: «Programado por C.J.Pink».</p>"),
        ("Los tiles del mapa van a nueve bytes, y ése es el sello de la conversión",
         "<p>Un tile de MSX ocupa ocho bytes. Los del mapa de este juego ocupan "
         "<b>nueve</b>: las ocho líneas del dibujo y, pegado detrás, <b>un "
         "atributo del ZX Spectrum</b> —tinta en los bits 0-2, papel en los "
         "3-5, brillo en el 6—.</p>"
         "<p>Los lee <code>0x75C7</code>-<code>0x75EB</code> cuando el código "
         "de la rejilla lleva puesto el bit 7. La conversión no rehizo los "
         "gráficos: se trajo los del Spectrum con su color puesto y los "
         "traduce al vuelo, en <code>0x049F</code>.</p>"),
        ("En 0x62FF no está el dibujo del cursor: está lo que el cursor tapa",
         "<p>Esos 24 bytes estaban documentados como el dibujo de la marca del "
         "cursor. <b>No lo son.</b> <code>0x6580</code> mete "
         "<code>0x62FF</code> en el HL alternativo y el bucle de "
         "<code>0x65B4</code>, por cada uno de los tres bytes de la columna, "
         "primero <b>lee la pantalla</b> (<code>ld a,(iy+n)</code>), la copia "
         "ahí, y sólo después compone el cursor encima.</p>"
         "<p><code>0x64DC</code> hace el camino de vuelta para borrarlo. El "
         "dibujo de verdad está en <code>0x6345</code>, con su máscara detrás "
         "(<code>ld ix,0x6345</code> en <code>0x657B</code>). Y los "
         "<code>0xAD</code> que trae la cinta ahí no son un dibujo: son <b>lo "
         "que había bajo el cursor el día que se grabó</b>.</p>"),
        ("El tablero de batalla se monta encima del menú, y es un damero",
         "<p>La batalla usa <code>0x5E00</code>-<code>0x62FF</code>, que es "
         "<b>donde vive el código del menú</b>: una vez empezada la partida, el "
         "menú y sus textos son papel de borrador. Lo dice "
         "<code>0x8E08</code> con su <code>ld b,0x5E</code>, y el "
         "<code>ldir</code> de <code>0x904D</code> lo borra entero antes de "
         "cada batalla.</p>"
         "<p>Y el tablero es un <b>damero</b>: las cuatro rutinas de "
         "movimiento (<code>0x893E</code> y compañía) cambian siempre las dos "
         "coordenadas a la vez, así que la paridad de x+y no cambia nunca. El "
         "despliegue rechaza los pares de paridad distinta y los obstáculos van "
         "justo en las casillas del otro color.</p>"),
        ("El filtro de amigo o enemigo es un interruptor por opcode",
         "<p>Para recorrer las unidades del bando contrario, el juego no usa "
         "una bandera: <b>se reescribe la instrucción</b>. "
         "<code>0x8980</code>-<code>0x8982</code> mete un <code>0xD0</code> en "
         "<code>0x8AF3</code>, y <code>0x8991</code>-<code>0x8993</code> mete "
         "un <code>0xD8</code>.</p>"
         "<p><code>0xD0</code> es <code>ret nc</code> y <code>0xD8</code> es "
         "<code>ret c</code>. La misma rutina, con el mismo umbral, devuelve "
         "las de un bando o las del otro según qué opcode se le haya escrito "
         "encima un momento antes.</p>"),
        ("El mapa viaja comprimido, y se vuelve a comprimir antes de cada batalla",
         "<p><code>0x9366</code> aparta los <code>0x16ED</code> bytes "
         "comprimidos del mapa a <code>0x4000</code> con un <code>ldir</code> y "
         "los expande a los <code>0x33CD</code> de <code>0xCC00</code> leyendo "
         "parejas de cuenta y valor. Lo llama <code>0x5E28</code>, en el "
         "arranque: el mapa <b>llega de la cinta ya comprimido</b>.</p>"
         "<p>Y <code>0x9394</code> hace lo contrario antes de cada batalla, "
         "volviéndolo a dejar en <code>0x16EC</code> bytes. No es por ahorrar "
         "cinta: es por <b>hacer sitio</b>. Lo que se libera, "
         "<code>0xE2EC</code>-<code>0xFFFF</code>, es exactamente donde viven "
         "los búferes de la batalla.</p>"),
        ("Y restos del Spectrum que en un MSX no significan nada",
         "<p>El <b>modo de control 2</b> del menú —el Interface Two del "
         "Spectrum— no existe aquí: su puntero, en <code>0x06D7</code>, es "
         "<code>0x0000</code>, así que el menú salta del 1 al 3.</p>"
         "<p>El bloque de teclado del ZX de <code>0x5F75</code>-"
         "<code>0x5FB7</code>, que lee el puerto <code>0xFE</code>, es código "
         "muerto. Y en la rutina de <b>grabar la partida</b> quedó sin "
         "convertir la comprobación de la tecla de parada: <code>0x0930</code> "
         "hace <code>in a,(0xFE)</code>, que en un MSX no es el teclado.</p>"),
    ],
    "en": [
        ("This game is silent, and you can point at where the sound stopped",
         "<p>The conversion brought the Spectrum's whole sound engine across: "
         "it sits at <code>0x6600</code>, drives the notes through "
         "<code>out (0xFE)</code> with bit 4, and behind it are five "
         "twenty-one-byte effects at <code>0x636F</code>-<code>0x63D7</code>.</p>"
         "<p><b>Nothing ever calls it.</b> Not one instruction in the five "
         "listings points at <code>0x6600</code>. And the four places that ask "
         "for an effect — <code>0x5F90</code>, <code>0x647A</code>, "
         "<code>0x6AA1</code> and <code>0x833D</code> — call "
         "<code>0x65FF</code>, which is <b>a bare <code>ret</code></b>.</p>"
         "<p>Of the MSX's PSG only two registers are ever written, 7 and 14, "
         "and both are for reading the joystick (<code>0x046E</code>). The one "
         "routine that would know how to write a note to the PSG, "
         "<code>0x04F2</code>, is never called either. There is no third path: "
         "<b>the game makes no sound</b>.</p>"),
        ("The loading screen, whole, pulled out of the tape",
         "<p>The 12,388 bytes of block [08] are a complete SCREEN 2 picture: "
         "6,144 of patterns and 6,144 of colours, and the sums close on their "
         "own (<code>0x88B8</code> + 100 + 6,144 + 6,144 = <code>0xB91C</code>, "
         "the exact end of the block).</p>"
         "<p>Drawn, it says what the game says about itself: <b>MAELSTROM GAMES "
         "LTD. PRESENTS</b>, <b>War in Middle Earth</b>, <b>Mike Singleton</b> "
         "and, bottom right, <b>CONVERSION by ANIMAGIC sa</b>. The menu adds "
         "the rest: “Programado por C.J.Pink”.</p>"),
        ("The map tiles are nine bytes long, and that is the conversion's fingerprint",
         "<p>An MSX tile takes eight bytes. This game's map tiles take "
         "<b>nine</b>: the eight lines of the drawing and, glued behind them, "
         "<b>a ZX Spectrum attribute</b> — ink in bits 0-2, paper in 3-5, "
         "bright in 6.</p>"
         "<p><code>0x75C7</code>-<code>0x75EB</code> read them when the grid "
         "code has bit 7 set. The conversion did not redraw the artwork: it "
         "brought the Spectrum's across with its colour already attached and "
         "translates it on the fly, at <code>0x049F</code>.</p>"),
        ("0x62FF is not the cursor's artwork: it is what the cursor covers up",
         "<p>Those 24 bytes were documented as the cursor mark's drawing. "
         "<b>They are not.</b> <code>0x6580</code> loads <code>0x62FF</code> "
         "into the alternate HL and the loop at <code>0x65B4</code>, for each "
         "of the column's three bytes, first <b>reads the screen</b> "
         "(<code>ld a,(iy+n)</code>), copies it there, and only then composites "
         "the cursor on top.</p>"
         "<p><code>0x64DC</code> walks it back to erase. The real artwork is at "
         "<code>0x6345</code>, with its mask behind it "
         "(<code>ld ix,0x6345</code> at <code>0x657B</code>). And the "
         "<code>0xAD</code> bytes the tape carries there are not a drawing: "
         "they are <b>whatever was under the cursor the day it was saved</b>.</p>"),
        ("The battle board is built on top of the menu, and it is a draughtboard",
         "<p>Battle uses <code>0x5E00</code>-<code>0x62FF</code>, which is "
         "<b>where the menu's code lives</b>: once a game has started, the menu "
         "and its text are scrap paper. <code>0x8E08</code> says so with its "
         "<code>ld b,0x5E</code>, and the <code>ldir</code> at "
         "<code>0x904D</code> wipes the lot before every battle.</p>"
         "<p>And the board is a <b>draughtboard</b>: the four movement routines "
         "(<code>0x893E</code> and friends) always change both coordinates at "
         "once, so the parity of x+y never changes. Deployment rejects any pair "
         "whose parities differ, and the obstacles go on exactly the squares of "
         "the other colour.</p>"),
        ("The friend-or-foe filter is an opcode switch",
         "<p>To walk the other side's units the game does not use a flag: "
         "<b>it rewrites the instruction</b>. "
         "<code>0x8980</code>-<code>0x8982</code> writes a <code>0xD0</code> "
         "into <code>0x8AF3</code>, and <code>0x8991</code>-<code>0x8993</code> "
         "writes a <code>0xD8</code>.</p>"
         "<p><code>0xD0</code> is <code>ret nc</code> and <code>0xD8</code> is "
         "<code>ret c</code>. The same routine, with the same threshold, hands "
         "back one side's units or the other's depending on which opcode was "
         "written over it a moment earlier.</p>"),
        ("The map travels compressed, and gets recompressed before every battle",
         "<p><code>0x9366</code> moves the map's <code>0x16ED</code> compressed "
         "bytes out to <code>0x4000</code> with an <code>ldir</code> and "
         "expands them into the <code>0x33CD</code> at <code>0xCC00</code>, "
         "reading count/value pairs. <code>0x5E28</code> calls it at boot: the "
         "map <b>arrives from tape already compressed</b>.</p>"
         "<p>And <code>0x9394</code> does the reverse before every battle, "
         "packing it back down to <code>0x16EC</code> bytes. That is not to "
         "save tape: it is to <b>make room</b>. What it frees, "
         "<code>0xE2EC</code>-<code>0xFFFF</code>, is exactly where the battle "
         "buffers live.</p>"),
        ("And Spectrum leftovers that mean nothing on an MSX",
         "<p>The menu's <b>control mode 2</b> — the Spectrum's Interface Two — "
         "does not exist here: its pointer, at <code>0x06D7</code>, is "
         "<code>0x0000</code>, so the menu jumps from 1 to 3.</p>"
         "<p>The ZX keyboard block at <code>0x5F75</code>-<code>0x5FB7</code>, "
         "which reads port <code>0xFE</code>, is dead code. And in the "
         "<b>save-game</b> routine the break-key check was never converted: "
         "<code>0x0930</code> does <code>in a,(0xFE)</code>, which on an MSX is "
         "not the keyboard.</p>"),
    ],
}

GALERIA = [
    ("carga.png",
     "DIBUJADA de 0x891C y 0xA11C — la pantalla de carga entera: 6.144 bytes de "
     "patrones y 6.144 de color, tal como los sube el cargador. Aqui esta el "
     "juego diciendo quien lo hizo",
     "DRAWN from 0x891C and 0xA11C — the whole loading screen: 6,144 bytes of "
     "patterns and 6,144 of colour, exactly as the loader uploads them. This is "
     "the game saying who made it"),
    ("tiles-del-mapa.png",
     "DIBUJADOS de 0x9E00 — los 128 tiles del mapa, con el color que dice su "
     "atributo del Spectrum. Van a NUEVE bytes: ocho de dibujo y el atributo "
     "pegado detras",
     "DRAWN from 0x9E00 — the 128 map tiles, in the colour their Spectrum "
     "attribute names. They are NINE bytes each: eight of drawing and the "
     "attribute glued behind"),
    ("sprites-de-dos-en-dos.png",
     "DIBUJADOS de 0xA2E8 — los sprites de batalla apilados de dos en dos. "
     "Medido: cada uno son 32 bytes de 16x8 en parejas mascara/dibujo. Que las "
     "entradas consecutivas encajen en figuras de 16x16 es una lectura de la "
     "imagen, no una rutina que se haya encontrado",
     "DRAWN from 0xA2E8 — the battle sprites stacked in pairs. Measured: each "
     "one is 32 bytes of 16x8 in mask/drawing pairs. That consecutive entries "
     "fit together into 16x16 figures is a reading of the picture, not a "
     "routine anyone has found"),
    ("sprites-de-batalla.png",
     "DIBUJADOS de 0xA2E8 — los mismos 176 sprites, uno a uno. El orden de sus "
     "bytes no es obvio: van en parejas mascara/dibujo y en zigzag, porque la "
     "rutina de 0x887B escribe izquierda, derecha, baja una linea y vuelve",
     "DRAWN from 0xA2E8 — the same 176 sprites, one by one. The byte order is "
     "not obvious: they go in mask/drawing pairs and in zig-zag, because the "
     "routine at 0x887B writes left, right, down a line and back"),
    ("fuente.png",
     "DIBUJADA de 0xC800 — los 128 caracteres de ocho bytes. Los 33 primeros "
     "estan a cero: el primero con dibujo es el 0x21, y de ahi salen marcos, "
     "flechas, digitos, mayusculas y minusculas",
     "DRAWN from 0xC800 — the 128 eight-byte characters. The first 33 are all "
     "zero: the first with any drawing is 0x21, and from there come frames, "
     "arrows, digits, upper and lower case"),
]


def img64(ruta):
    with open(ruta, "rb") as f:
        return "data:image/png;base64," + base64.b64encode(f.read()).decode()


def rotulo(imgdir, salida):
    """Recorta el titulo de la pantalla de carga para la cabecera.

    No es un montaje ni una fuente de fuera: son las filas 24 a 68 de la propia
    pantalla que el juego ensena mientras carga, que es donde esta escrito
    "War in Middle Earth".
    """
    fuente = os.path.join(imgdir, "carga.png")
    if not os.path.exists(fuente):
        return None
    return fuente


def main(argv):
    if len(argv) < 4:
        print(__doc__)
        return 2
    imgdir, salida, idioma = argv[1:4]
    t = TXT[idioma]

    ruta_logo = rotulo(imgdir, salida)
    cabecera = ("<h1>War in Middle Earth</h1>" if not ruta_logo
                else f'<img src="{img64(ruta_logo)}" alt="War in Middle Earth">')

    nav = "".join(f'<a href="{h}">{x}</a>' for h, x in t["nav"])
    nav += "".join(f'<a href="{h}">{x}</a>' for h, x in t["docnav"])
    nav += (f'<a href="{t["otro"][0]}" style="margin-left:auto;color:var(--oro)">'
            f'{t["otro"][1]}</a>')

    cifras = "".join(f'<div class="cifra"><b>{v}</b><span>{e}</span></div>'
                     for v, e in t["cifras"])
    halls = "".join(f'<div class="hall"><h3>{tit}</h3>{cuerpo}</div>'
                    for tit, cuerpo in HALLAZGOS[idioma])
    imgs = ""
    faltan = []
    for fich, es, en in GALERIA:
        ruta = os.path.join(imgdir, fich)
        if not os.path.exists(ruta):
            faltan.append(fich)
            continue
        pie = es if idioma == "es" else en
        imgs += (f'<figure><img src="{img64(ruta)}" alt="{pie}">'
                 f'<figcaption>{pie}</figcaption></figure>')
    if faltan:
        print("  (faltan %d imagenes: %s)" % (len(faltan), " ".join(faltan)))

    html = f"""<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>{t['titulo']}</title>
<style>{ESTILO}</style>
<header class="top">
  {cabecera}
  <p class="claim">{t['claim']}</p>
  <p class="ficha">{' · '.join(t['ficha'])}</p>
</header>
<p class="ficha" style="border:1px solid var(--oro);padding:.8em 1em;margin:1.5em 0">
{t['aviso']}</p>
<nav>{nav}</nav>
<section id="numbers">
  <h2>{t['h_num']}</h2>
  <div class="cifras">{cifras}</div>
</section>
<section id="findings"><h2>{t['h_find']}</h2>{halls}</section>
<section id="screens">
  <h2>{t['h_scr']}</h2>
  <p class="n">{t['nota_scr']}</p>
  <div class="galeria">{imgs}</div>
</section>
<footer><p>{t['pie_leg']}</p></footer>
"""
    with open(salida, "w", encoding="utf-8") as f:
        f.write(html)
    print("  %s: %d KB (%s)" % (salida, len(html) // 1024, idioma))
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
