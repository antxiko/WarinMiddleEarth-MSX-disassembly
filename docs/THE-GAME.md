# The game

[Getting started](GETTING-STARTED.html) · [The tape](THE-TAPE.html) · [The code](THE-CODE.html) · [Findings](FINDINGS.html) · [Open questions](OPEN-QUESTIONS.html)

War in Middle Earth is a strategy game about Middle-earth: you move armies
around a large map, time runs on, and now and then two units meet and there is
a battle.

Everything below is **measured against the binary**. Anything that is a reading
rather than a fact is said to be one.

## The map

The map lives at `0xCC00`-`0xE400` and is addressed like this:

    0xCC67 + column*102 + row

with limits of **127 columns and 99 rows** (the `cp` instructions at `0x734B`).
Each cell is two by two pixels of the big map, and each colour-attribute cell
covers four by four map cells (`0x6AC5`).

The compass is eight offsets, in the table at `0x6B34`: `-1, +101, +102, +103,
+1, -101, -102, -103`. Note that 102 is a column's stride: those are the eight
neighbours. The table carries **one extra entry at each end** so that
"direction ± 1" works without having to mask the index.

The map **arrives from tape compressed**, and gets compressed again before every
battle to make room. That is in [Findings](FINDINGS.html).

## The clock, and losing by running out of time

Game time lives in the **operands** of four `ld a,nn` instructions, which is how
this game keeps almost all its variables: `0x831C` the tick, `0x8326` the day,
`0x8355` the month and `0x8333` the countdown.

The game loop (`0x7F6B`) calls the clock every time round, and:

- on the **256th** turn a day passes;
- on day **61** it goes back to 1 and moves to the next month (1 to 12);
- and every month it subtracts one from the **countdown**, which starts at 255
  (`0x7F4F`). If it reaches zero, **defeat** (`0x83E1`).

At every month change it adds one to the 256 counters at `0xC300` (saturating at
255) and leaves the message "El Anillo corrompe al que lo usa." The *Time* panel
paints it in **Roman numerals**: `0x8383` writes an L if the number reaches 50,
an X per ten, and the units come from the table at `0x8517`.

**In battle the clock does not run**: the loop at `0x7F57` never turns.

## The Ring

**Bit 4** of `0xBD00+n` marks the unit carrying it. `0x733E` looks for the first
unit with that bit set; the game loop checks whether **that** unit is on cell
`(0x68, 0x3F)` and, if it is, jumps to `0x83D9`. And when the bearer ends up on
the same cell as another unit, `0x6A47` does `set 4` on the new one and `res 4`
on the old, leaving the message "El Anillo se ha perdido."

*(That the bit means "carries the Ring" is a reading, even if everything points
the same way: what is measured is that it decides victory at `0x7F7D` and defeat
at `0x9218`.)*

## Battle

When two units meet, the game **builds the board on top of the menu's code**:
`0x5E00`-`0x62FF`. Once a game has started, the menu and its text are scrap
paper.

And the board is a **draughtboard**. The four movement routines (`0x893E`,
`0x894D`, `0x895C`, `0x896B`) always change both coordinates at once — `inc b /
dec c`, for instance — so the parity of x+y never changes: **the figures only
move diagonally**. Deployment rejects any pair whose parities differ, and the
obstacles go on exactly the squares of the other colour.

The figures are 176 sprites of 16×8 with a mask, 32 bytes each, at `0xA2E8`.
They are in the gallery on the front page.

## The messages, and the language

The game's text is **in Spanish**: "La Batalla ha comenzado", "Elige el enemigo
a atacar", "No puedes atacar a un amigo", "No pertenece a tu Alianza", "Aqui no
hay nadie". There are six, reached through the pointer table at `0x93D9`, and
the number left in `0x9190` chooses which one comes out.

The tape prompts — "Cargando Posiciones" and company — are at `0x9687`, and the
panel labels (*File*, *Memo*, *Time*, "Volver/Cargar/Salvar", "Pulsa Fuego") at
`0x83F8`.

## And nothing makes a sound

The game **is silent**, and not for want of code: the conversion brought the
Spectrum's whole sound engine across. Nothing simply ever calls it. It is
measured in [Findings](FINDINGS.html).
