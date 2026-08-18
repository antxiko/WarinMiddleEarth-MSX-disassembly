#!/usr/bin/env python3
"""Saca de la cinta el cuerpo de cada bloque, listo para desensamblar, y monta
la imagen de memoria del juego tal y como queda al arrancar.

War in Middle Earth mezcla DOS formatos de bloque:

  - Dos ficheros del MSX: el BASIC en ASCII (256 B, texto) y el cargador, un
    BIN con 6 bytes de cabecera (carga, fin, arranque en little-endian) que
    aqui se quitan.

  - Cuatro bloques del ZX SPECTRUM (TZX id 0x10): un byte de bandera, los
    datos, y un byte final que es el XOR de todo lo anterior. Se comprueba ese
    XOR, que es la unica verificacion de integridad que trae la cinta.

Las direcciones son las que dice el propio cargador (0xD6D8) y el arranque
(0x0190), no supuestas:

    [08]  cargado en 0x88B8   la pantalla de carga; el juego la machaca luego
    [09]  cargado en 0x0190   se queda ahi
    [10]  cargado en 0x3F4F   el arranque lo sube con LDDR a 0x5E00
    [11]  cargado en 0x88B8   el arranque lo sube con LDDR a 0x9E00

Uso: cuerpos.py <extracted> <work>
"""
import json
import os
import sys

# fichero, nombre, direccion de CARGA, direccion donde se EJECUTA, descripcion
BLOQUES_SPECTRUM = [
    ("08_raw_10.bin", "pantalla", 0x88B8, 0x88B8, "pantalla de carga: 100 B de codigo + patrones + colores"),
    ("09_raw_10.bin", "bajo",     0x0190, 0x0190, "arranque + tablas + interrupcion; se queda en la pagina 0"),
    ("10_raw_10.bin", "medio",    0x3F4F, 0x5E00, "el juego (1): recolocado a 0x5E00 al arrancar"),
    ("11_raw_10.bin", "alto",     0x88B8, 0x9E00, "el juego (2): recolocado a 0x9E00 al arrancar"),
]

CARGADOR = ("07_loader.bin", "loader", "el cargador estilo Spectrum")
BASIC = ("05_WAR.ascii", "basic", "dos lineas de BASIC en ASCII")


def cuerpo_bin(datos):
    """Los 6 bytes de cabecera fuera; devuelve (carga, fin, arranque, cuerpo)."""
    carga = datos[0] | (datos[1] << 8)
    fin = datos[2] | (datos[3] << 8)
    arranque = datos[4] | (datos[5] << 8)
    return carga, fin, arranque, datos[6:]


def cuerpo_spectrum(datos):
    """Quita bandera y checksum, y comprueba el XOR."""
    x = 0
    for c in datos[:-1]:
        x ^= c
    return datos[0], datos[1:-1], x == datos[-1]


def main(argv):
    if len(argv) < 3:
        print(__doc__)
        return 2
    ext, work = argv[1], argv[2]
    os.makedirs(work, exist_ok=True)
    manifiesto = {}

    print("  ficheros del MSX")
    fichero, nombre, desc = BASIC
    with open(os.path.join(ext, fichero), "rb") as f:
        b = f.read()
    with open(os.path.join(work, nombre + ".raw"), "wb") as f:
        f.write(b)
    print("    %-8s %5d B  %s" % (nombre, len(b), desc))
    manifiesto[nombre] = {"bytes": len(b), "desc": desc}

    fichero, nombre, desc = CARGADOR
    with open(os.path.join(ext, fichero), "rb") as f:
        carga, fin, arranque, cuerpo = cuerpo_bin(f.read())
    esperado = fin - carga + 1
    ok = esperado == len(cuerpo)
    print("    %-8s 0x%04X-0x%04X arranca 0x%04X  %5d B  %s  %s"
          % (nombre, carga, fin, arranque, len(cuerpo),
             "OK" if ok else "!! la cabecera dice %d" % esperado, desc))
    if not ok:
        return 1
    with open(os.path.join(work, nombre + ".raw"), "wb") as f:
        f.write(cuerpo)
    manifiesto[nombre] = {"org": carga, "arranque": arranque,
                          "bytes": len(cuerpo), "desc": desc}

    print("  bloques del ZX Spectrum")
    imagen = bytearray(0x10000)
    ocupado = bytearray(0x10000)
    for fichero, nombre, carga, org, desc in BLOQUES_SPECTRUM:
        with open(os.path.join(ext, fichero), "rb") as f:
            bandera, cuerpo, xor_ok = cuerpo_spectrum(f.read())
        if not xor_ok:
            print("    %-8s !! el checksum XOR no cuadra" % nombre)
            return 1
        print("    %-8s carga 0x%04X  corre 0x%04X-0x%04X  bandera 0x%02X  %5d B  XOR OK  %s"
              % (nombre, carga, org, org + len(cuerpo) - 1, bandera, len(cuerpo), desc))
        with open(os.path.join(work, nombre + ".raw"), "wb") as f:
            f.write(cuerpo)
        manifiesto[nombre] = {"carga": carga, "org": org, "bandera": bandera,
                              "bytes": len(cuerpo), "desc": desc}
        if nombre != "pantalla":
            for i, c in enumerate(cuerpo):
                if ocupado[org + i]:
                    print("    !! solape en 0x%04X" % (org + i))
                    return 1
                imagen[org + i] = c
                ocupado[org + i] = 1

    with open(os.path.join(work, "juego64.bin"), "wb") as f:
        f.write(imagen)
    with open(os.path.join(work, "juego64.ocupado.bin"), "wb") as f:
        f.write(ocupado)
    print("  imagen de 64K del juego -> juego64.bin (%d bytes ocupados)" % sum(ocupado))

    total = sum(m["bytes"] for m in manifiesto.values())
    print("  total de cuerpos: %d bytes" % total)
    with open(os.path.join(work, "bloques.json"), "w") as f:
        json.dump(manifiesto, f, indent=1)
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
