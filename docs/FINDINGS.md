# Findings

[Getting started](GETTING-STARTED.html) · [The game](THE-GAME.html) · [The tape](THE-TAPE.html) · [The code](THE-CODE.html) · [Open questions](OPEN-QUESTIONS.html)

Almost everything on this page came out of reading the listing instruction by
instruction in order to comment it. Each item carries its address, which is what
lets anyone check it.

---

## 1. The game is silent, and you can point at where the sound stopped

The conversion brought the Spectrum's **whole** sound engine across: it sits at
`0x6600`, drives the notes through `out (0xFE)` with bit 4 — the ZX beeper —
and behind it are five twenty-one-byte effects at `0x636F`-`0x63D7`.

**Nothing ever calls it.** Not one instruction in the five listings points at
`0x6600`.

And the four places that ask for an effect — `0x5F90`, `0x647A`, `0x6AA1` and
`0x833D` — call `0x65FF`, which is **a bare `ret`**.

What about the MSX's PSG? Exactly **two registers are ever written, 7 and 14**,
and both in the joystick routine at `0x046E`: 7 to set the ports as input, 14 to
read them. Not one tone or volume register in the whole tape. The one routine
that would know how to write a note to the PSG, `0x04F2`, is never called
either, and was already annotated as dead code.

There is no third path. **This game makes no sound.**

---

## 2. `0x62FF` is not the cursor's artwork: it is what the cursor covers up

Those 24 bytes were documented, in this very project, as "the cursor mark's
drawing". **That is false**, and the listing leaves no room for doubt.

`0x6580` loads `0x62FF` into the alternate HL, and the loop at
`0x65B4`-`0x65D5`, for each of the column's three bytes, does this:

```
65B4  ld a,(iy+000h)   ; READS the screen
65B7  exx
65B8  ld (hl),a        ; and saves it at 0x62FF++
65B9  inc hl
65BA  exx
65BB  and e            ; and ONLY THEN composites the cursor
65BC  or b
65BD  ld (iy+000h),a
```

And `0x64DC` walks it back (`ld a,(de) / ld (hl),a`) to erase.

The real artwork is at `0x6345`, with its mask behind it (`ld ix,0x6345` at
`0x657B`).

The lovely part is what that makes of the bytes the tape carries: the `0xAD`
bytes sitting at `0x62FF` are not a drawing, they are **whatever was underneath
the cursor the day the tape was recorded**.

---

## 3. The map tiles are nine bytes long

An MSX tile takes eight bytes. This game's map tiles take **nine**: the eight
lines of the drawing and, glued behind them, **a ZX Spectrum attribute** — ink
in bits 0-2, paper in 3-5, bright in 6.

`0x75C7`-`0x75EB` read them when the grid code has bit 7 set. The conversion did
not redraw the artwork: it brought the Spectrum's across with its colour already
attached and translates it on the fly, with the routine at `0x049F`, which turns
a Spectrum attribute into a SCREEN 2 colour byte.

It is the cleanest fingerprint of the conversion anywhere on the tape, and it is
why the tiles in the gallery come out in their real colours: the attribute they
carry inside is read.

---

## 4. The battle board is built on top of the menu, and it is a draughtboard

Battle uses `0x5E00`-`0x62FF`, which is **where the menu's code lives**.
`0x8E08` says so with its `ld b,0x5E`, and the `ldir` at `0x904D` wipes 0x500
bytes there before every battle. Once a game has started, the menu and its text
are scrap paper.

And the board is a **draughtboard**: the four movement routines (`0x893E`,
`0x894D`, `0x895C`, `0x896B`) always change both coordinates at once — the first
one, for instance, does `inc b / dec c` — so the parity of x+y never changes.
The figures **only move diagonally**. Deployment (`0x8D6E`) rejects any pair
whose parities differ, and the obstacles (`0x9079`) go on exactly the squares of
the other colour.

---

## 5. The friend-or-foe filter is an opcode switch

To walk the other side's units the game uses neither a flag nor a branch: **it
rewrites the instruction**.

```
8980  ld a,0d0h        ; 0xD0 = ret nc
8982  ld (08af3h),a
...
8991  ld a,0d8h        ; 0xD8 = ret c
8993  ld (08af3h),a
```

The same routine, with the same threshold, hands back one side's units or the
other's depending on which **opcode** was written over it a moment earlier.

---

## 6. The map travels compressed, and gets recompressed before every battle

`0x9366` moves the map's `0x16ED` compressed bytes out to `0x4000` with an
`ldir` and then expands them into the `0x33CD` at `0xCC00`, reading count/value
pairs. `0x5E28` calls it at boot: the map **arrives from tape already
compressed**.

And `0x9394` does the reverse before every battle, packing it back down to
`0x16EC` bytes. That is not to save tape — the tape is already recorded — it is
to **make room in RAM**: what it frees, `0xE2EC`-`0xFFFF`, is exactly where the
battle buffers live.

---

## 7. The battle sprites are not laid out the way they look

176 sprites of 16×8 with a mask, 32 bytes each, at `0xA2E8` + `(type-4)*32`. But
those 32 bytes are **not "16 of drawing and 16 of mask"**: they go in **pairs**,
mask first and drawing behind, because the routine that paints them does
`and (hl) / inc hl / or (hl) / inc hl` for every screen byte.

And they do not run top to bottom but in **zig-zag**: `0x887B` writes the left,
`inc e` to the right, `inc d` to drop a line and `dec e` to come back left,
saving itself the trouble of reloading DE. Drawing them assuming the obvious
order gives convincing noise, which is the worst kind of error.

---

## 8. Spectrum leftovers that mean nothing on an MSX

- The menu's **control mode 2** — the Spectrum's Interface Two — does not exist
  here: its pointer, at `0x06D7`, is `0x0000`, which is why the menu jumps from
  1 to 3.
- The ZX keyboard block at `0x5F75`-`0x5FB7`, which reads port `0xFE`, is dead
  code.
- And in the **save-game** routine the break-key check was never converted:
  `0x0930` does `in a,(0xFE)`, which on an MSX is not the keyboard.

---

## 9. Things that never get to run

- **`0x68C8`: the `ld a,0x3C` is good for nothing.** `L_67C5` is only entered
  from `L_67B0` (`0x67B4` and `0x67BE` are the only two references), and there C
  is 0, 2 or 3. With C=0 execution never reaches it, so at `0x68CA` bit 1 of C
  is always set, the `inc a` always runs and A always comes out `0x3D`.
  Consequence: a unit records in bit 7 of its coordinates which way it was going
  round an obstacle, but on resuming it **always turns the same way**.
- **`ld hl,(0x6543)` at `0x6578` is a dead load**: `0x658F` overwrites it before
  it is used, and the only exit in between (`jr nc,L_65F9`) does not touch HL
  either.
- **The font at `0xC800` starts empty**: codes `0x00`-`0x20` are **33 characters
  of zeros**, counted byte by byte. The first one with any drawing is `0x21`.
