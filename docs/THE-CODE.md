# The code

[Getting started](GETTING-STARTED.html) · [The game](THE-GAME.html) · [The tape](THE-TAPE.html) · [Findings](FINDINGS.html) · [Open questions](OPEN-QUESTIONS.html)

## The memory map, once everything is in place

| address | what is there |
|---|---|
| `0x0190`-`0x3F4E` | the **MSX layer**: VRAM, keyboard, joystick, colour, tape |
| `0x5E00`-`0x96F0` | **the game**: menu, world, play, battle and panels |
| `0x9E00`-`0xE677` | **graphics, map and tables**, not one byte of code |

Inside the high block, everything in its place:

| address | bytes | what it is |
|---|---:|---|
| `0x9E00`-`0xA280` | 1,152 | 128 map tiles, of **nine** bytes each |
| `0xA2E8`-`0xB8E8` | 5,632 | 176 battle sprites of 16×8 with a mask |
| `0xB8E8`-`0xC600` | — | game state tables |
| `0xC800`-`0xCC00` | 1,024 | the font: 128 eight-byte characters |
| `0xCC00`-`0xE400` | 6,144 | **the map** |
| `0xE400`-`0xE678` | 632 | final tables |

And one thing explains an odd address: the map starts at `0xCC67` and not at
`0xCC00` because immediately before it sit the `0x80` printable characters of
the font. Codes `>= 0x80` are map tiles, of nine bytes; codes `< 0x80` are
characters, of eight.

## The variables live inside the instructions

This game keeps almost everything in the **operands** of its own `ld`
instructions. The clock is four `ld a,nn` (`0x831C`, `0x8326`, `0x8333`,
`0x8355`); the tape loader keeps its pointer there; and battle goes as far as
rewriting **opcodes**, not just operands: `0x8982` writes a `0xD0` (`ret nc`) or
a `0xD8` (`ret c`) into `0x8AF3` so that the same routine walks one side or the
other.

That forces the real control flow to be traced and every entry point to be
justified, because a linear disassembly loses its footing the moment a jump
table or a self-modified operand decides where to go.

## How the listing was made

- The game is traced **whole, over the 64 KB image**, because the three blocks
  call one another, and is only then split into three listings with different
  `org`.
- The entry points the tracer cannot deduce — pushed return addresses, jump
  tables, self-modified operands — go in `src/juego.entries`, **each with the
  instruction that justifies it**.
- The gaps between blocks are declared in `src/juego.nocode` so a stray call
  cannot swallow zeros as code.
- `make sanity` crosses the **52 declared data ranges** against what the tracer
  believes, and checks that not one tape byte is left unexplained.

## The comments, measured

    make densidad

| listing | instructions | comments | density | weak routines |
|---|---:|---:|---:|---:|
| `war_loader` | 379 | 150 | 39.6% | 0 of 48 |
| `war_pantalla` | 14 | 10 | 71.4% | 0 of 1 |
| `war_bajo` | 785 | 226 | 28.8% | 0 of 96 |
| `war_medio` | 5,664 | 1,645 | **29.0%** | **0 of 621** |
| **total** | **6,844** | **2,031** | **29.7%** | **0 of 767** |

The series applies two figures, and both are met: **over 22% density and no
routine below 10%**.

The big block, the game itself, stood at **11 comments across 5,664
instructions** — 0.2% — before this pass. Reading it line by line to comment it
is what turned up almost everything in [Findings](FINDINGS.html), starting with
the fact that `0x62FF` does not hold the cursor's artwork but what the cursor
covers up.
