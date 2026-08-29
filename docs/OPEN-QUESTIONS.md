# Open questions

[Getting started](GETTING-STARTED.html) · [The game](THE-GAME.html) · [The tape](THE-TAPE.html) · [The code](THE-CODE.html) · [Findings](FINDINGS.html)

What is still open, keeping MEASURED and ASSUMED apart. What is measured carries
its measurement; what is assumed is labelled as such and **has not been written
into the listing as if it were a fact**.

---

## MEASURED, and closed

- The whole tape: **62,261 bytes, 62,261 explained, zero unexplained**.
- All five listings **reassemble byte for byte** with pasmo.
- **52 data ranges** declared, all crossed against the trace.
- Commented at **29.7%**, with no routine below 10% out of 767.
- The budget was closed with **Araubi's complete playthrough**: the 13.8 KB that
  had never been seen running were the two ending screens.

---

## ASSUMED (labelled as such)

- **That bit 4 of `0xBD00+n` means "carries the Ring".** What is measured is
  that `0x733E` looks for the first unit with that bit, that the game loop
  checks whether that unit is on `(0x68, 0x3F)`, and that it decides victory
  (`0x7F7D`) and defeat (`0x9218`). Everything points the same way, but the
  binary does not say it in so many words.
- **That units `0x16` and `0x17` are Sauron and Saruman.** The chain is long:
  `0x72FD` stores the bearer and does `inc a` to mark the row, and `0x7314` does
  `dec a` on the way back; so row = unit + 1 and row 0 is "Vuelve", making unit
  *n* the *n+1*th name in the list at `0x6B46`. Counting gives Gollum, Sauron
  and Saruman. It fits with `0x6AE3` skipping exactly those two when painting
  armies, and with `0x7514` (choosing an enemy) accepting exactly
  `{0x16, 0x17, >= 0x78}`. It is a deduction, not a direct reading.
- **That the figures stack in pairs.** Measured: each sprite is 32 bytes of
  16×8. That consecutive entries fit together into 16×16 figures is what you see
  when you draw them, but **no routine that stacks them has been found**.

---

## OPEN: what could not be closed

### 1. The insides of the state tables

`0xB8E8`-`0xC600` and `0xE400`-`0xE678` are delimited and we know who reads them
(`0x6AC2`, `0x6EAC`, `0x8F7A`, `0x92E4`, `0x81A9`, `0x8189`, `0x7FF0`), but they
have **not been broken down field by field**. `0xB900` is called X and `0xBA00`
Y because `0x8108` multiplies the first by 102, which is the column stride, and
`0x8166` walks columns in the outer loop; that is consistent, not proven.

### 2. What the map's second pass adds

Drawing the map takes three passes. The second (`0x7714`) indexes `0x77B5` with
**the same low nibble** the terrain pass already used (`0x7687`), and what it
contributes could not be established.

### 3. Who sets bit 7 of a map byte

The third pass of `0x7708` only paints if that bit is set. It is set from
`0x8F70`, `0x8044` and `0x80BD`, but on what criterion was not settled.

### 4. The nibble shuffling with the countdown

`0x6A76`-`0x6A94` takes the operand of `0x8333` — the month countdown, set to
255 at `0x7F4F` — stores it **multiplied by 16**, and puts its high nibble minus
one into the low nibble of `0xC000+bearer`. With 255 in there, that leaves the
countdown at 240 the first time and at 0 the second. Either it is a deliberate
penalty, or that byte has a second use nobody has worked out. It is commented by
describing **what it does**, without interpreting it.

### 5. `0x9144` reads what `0x904D` has just cleared

In the same routine, a few instructions apart: `0x904D` zeroes `0x5E00`+`0x4FF`
— `0x6010` included — and `0x9144` then does `ld hl,0x6010 / ld a,(hl) /
ld (0x8B19),a`. Either it is meant to read the battle board, or it is a Spectrum
leftover where that byte lived somewhere else. The mechanism is commented, not
the intent.

### 6. Rows of tiles that are computed and never drawn

`0x86AF` works out **19 rows** of tiles (`ld c,0x13` at `0x86CC`) but the
drawing loop does 16×16. Three rows prepared and never seen.

### 7. Two ranges that ought to be split off

They currently sit inside `textos_de_los_paneles` and deserve names of their
own: `0x83F8`-`0x83FB`, the four two-bit fills (`00`, `FF`, `AA`, `55`), and
`0x846F`-`0x8496`, the five terrain textures `0x80BD` picks from.
