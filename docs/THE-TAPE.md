# The tape

[Getting started](GETTING-STARTED.html) · [The game](THE-GAME.html) · [The code](THE-CODE.html) · [Findings](FINDINGS.html) · [Open questions](OPEN-QUESTIONS.html)

The first surprise about this tape is that **it is not an MSX tape**.

## Spectrum blocks in an MSX game

The file is a **TSX** and its blocks are ZX Spectrum ones (TZX type `0x10`),
with the usual structure: `[flag][data][XOR]`. There is not a single MSX KCS
block anywhere in it.

And the loader is not the BIOS's: it is a **reimplementation of LD-BYTES**, the
Spectrum ROM's routine, written out by hand for the MSX. It lives at `0xD6D8`
and is 681 bytes. They brought the whole tape system across because it was
cheaper than redoing it.

There is a second copy of that loader **inside the game**, at `0x07F9`, plus the
saving one at `0x08B2`: those are what save and load a game use. The reading one
is the same routine with two differences you can point at: here there **is** a
failure exit (the `ret nz` at `0x0819`) and the border steps through colours one
at a time instead of going random.

## The four blocks, and where they really end up

The loader reads four blocks in a row and none of them runs where it lands:

| block | lands at | ends up at | bytes |
|---|---|---|---:|
| the loading screen | `0x88B8` | the VRAM | 12,388 |
| the low block | `0x0190` | `0x0190` (never moved) | 15,807 |
| the middle block | `0x3F4F` | **`0x5E00`** | 14,577 |
| the high block | on top of the screen | **`0x9E00`** | 18,552 |

The loading screen is dumped to VRAM the moment it is read, which is why the
high block can load right on top of it: by the time it arrives, that piece of
RAM is no longer needed.

The low block is what relocates the other two. Its sums are written into the
listing itself and come out exact:

    0xE677 - 0x4878 + 1 = 0x9E00     (the high block, 18,552 bytes)
    0x96F0 - 0x38F1 + 1 = 0x5E00     (the middle block, 14,577 bytes)

and it copies them **backwards**, because source and destination overlap.

## All four pages in RAM, and no BIOS

Before anything else, the loader puts **all four MSX pages into RAM**. From
there on there is no BIOS: the game does everything itself, which is why the low
block carries its own layer for VRAM, keyboard, joystick and colour conversion.

That forces the game to be traced over a 64 KB image — `work/juego64.bin` — and
split afterwards into three listings, each with the `org` where it really runs.

## And a POKE letterbox

The boot code (`0x0190`) does something you do not see every day: it checks that
the first three of the 100 bytes the loader brought to `0x012C` are `0xC9`, and
if so **applies whatever comes behind them**. It is a letterbox for patching the
game from the tape without touching the code.

## The budget: not one byte unexplained

```
module             bytes    code    data   unexplained
loader               681     675       6             0
screen             12388      34   12354             0
low                15807    1218   14589             0
middle             14577    9887    4690             0
high               18552       0   18552             0
BASIC loader         256   two lines of text and padding
TOTAL              62261 bytes, 62261 explained (100.00%)
```

The BASIC loader is two lines: one setting `COLOR` and `SCREEN 2`, and one with
the `BLOAD`. The rest of its 256 bytes is the `^Z` padding the MSX writes to
fill out the chunk.
