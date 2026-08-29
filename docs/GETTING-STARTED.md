# Getting started

[The game](THE-GAME.html) · [The tape](THE-TAPE.html) · [The code](THE-CODE.html) · [Findings](FINDINGS.html) · [Open questions](OPEN-QUESTIONS.html)

This repository holds a **commented disassembly** of War in Middle Earth for
the MSX (Melbourne House / Dro Soft, 1989). Everything here comes out of the
binary and can be generated from it again.

## What you need

- **Python 3** (no third-party packages)
- **pasmo**, to reassemble
- **z80dasm**, used only for the mnemonics
- the tape, which this repository **does not distribute**

The tape goes in the root, named `war.tsx`, and the `Makefile` asks for it by
sha256:

    13c636328d1714d5e00419141ca1a7ac9c7a3a04d7ec2b26545212aab1d81208

It is a **TSX**, not a `.cas`: the blocks are not MSX blocks but ZX Spectrum
ones, because the conversion brought the whole tape system across. That is in
[The tape](THE-TAPE.html).

## The test that matters

    make verify

This reassembles the five listings with pasmo and compares each one, byte for
byte, against the piece of tape it belongs to. If all five say `OK: reproducible
byte a byte`, the disassembly has invented nothing.

## Everything else you can run

    make            # the whole cycle: extract, trace, list, verify
    make listados   # regenerates the five src/war_*.asm
    make sanity     # the checks reassembly does NOT cover
    make test       # the tests
    make imagenes   # redraws the PNGs in docs/imagenes from the tape
    make web        # regenerates this site

`make sanity` is the one that watches for what a correct reassembly can hide:
data being read as code, and tape bytes left unexplained. Today it says
**62,261 out of 62,261, 100%**.

## The five listings

The game runs with **all four pages in RAM and no BIOS**, and the three big
blocks are not run where they land: the boot code relocates them. That is why
there are five listings and not three.

| listing | org | what it is |
|---|---|---|
| `war_loader.asm` | `0xD6D8` | the loader: sets up RAM and reads the four blocks |
| `war_pantalla.asm` | `0x88B8` | the loading screen (almost all data) |
| `war_bajo.asm` | `0x0190` | the MSX layer: VRAM, keyboard, joystick, colour, tape |
| `war_medio.asm` | `0x5E00` | **the game** |
| `war_alto.asm` | `0x9E00` | graphics, map and tables (all data) |

## And a word about the pictures

None of the ones in `docs/imagenes/` is a screenshot. `tools/render_carga.py`
and `tools/render_graficos.py` draw them by reading the tape's bytes in the
ranges the listing delimits. If a range were mislabelled, it would come out as
noise.
