#!/bin/sh
# Verificacion de reproducibilidad: ensambla un listado y comprueba que sale
# EXACTAMENTE el binario original, byte a byte.
#
# Es el criterio que decide si el desensamblado es fiable. Mientras esto no este
# en verde, cualquier modificacion del juego se hace a ciegas: no habria forma de
# saber si un cambio de comportamiento viene de lo que hemos tocado o de un error
# del propio desensamblado.
#
# QUIEN DECIDE ES `cmp`, NO EL HASH. Antes la comparacion era de dos sha256 y,
# si `shasum` no estaba instalado -pasa al llamar a make desde fuera de Git
# Bash-, las dos variables salian VACIAS, resultaban iguales y esto imprimia
# "OK: reproducible byte a byte" sin haber comparado ni un byte. El hash se
# sigue enseñando, porque es lo que se pega en los informes, pero solo informa.
#
# Uso: verify_build.sh <listado.asm> <binario_original> <org>

set -e
ASM="$1"
ORIG="$2"
ORG="$3"
TMP="$(dirname "$0")/../work/verify"
mkdir -p "$TMP"
OUT="$TMP/$(basename "$ASM" .asm).bin"
ERR="$TMP/pasmo.err"

echo "== ensamblando $ASM (org $ORG) =="
if ! pasmo --bin "$ASM" "$OUT" 2>"$ERR"; then
    echo "FALLO: pasmo no pudo ensamblar. Primeros errores:"
    head -20 "$ERR"
    exit 1
fi

# El sha256 es solo para el informe: se usa lo que haya, y si no hay nada se
# dice, en vez de dejar la cadena vacia haciendose pasar por un hash.
hash256() {
    if command -v shasum > /dev/null 2>&1; then
        shasum -a 256 "$1" | cut -d' ' -f1
    elif command -v sha256sum > /dev/null 2>&1; then
        sha256sum "$1" | cut -d' ' -f1
    else
        echo "(sin herramienta de sha256)"
    fi
}

SZ_A=$(wc -c < "$OUT" | tr -d ' ')
SZ_B=$(wc -c < "$ORIG" | tr -d ' ')
echo "  ensamblado : $SZ_A bytes  $(hash256 "$OUT")"
echo "  original   : $SZ_B bytes  $(hash256 "$ORIG")"

# La comparacion, con lo que haya a mano. Si no hubiera NINGUNA de las dos
# formas de comparar, esto se para: callarse y decir OK es justo lo que no
# puede hacer el guardian del proyecto.
if command -v cmp > /dev/null 2>&1; then
    cmp -s "$OUT" "$ORIG" && IGUALES=si || IGUALES=no
elif command -v python3 > /dev/null 2>&1; then
    IGUALES=$(python3 -c "import sys;a=open(sys.argv[1],'rb').read();b=open(sys.argv[2],'rb').read();print('si' if a==b else 'no')" "$OUT" "$ORIG")
else
    echo "FALLO: aqui no hay ni cmp ni python3, asi que no se puede comparar."
    exit 2
fi

if [ "$IGUALES" = "si" ]; then
    echo "OK: reproducible byte a byte"
    exit 0
fi

echo "DIFIERE. Primeras discrepancias:"
if command -v cmp > /dev/null 2>&1; then
    cmp -l "$OUT" "$ORIG" 2>/dev/null | head -20 || true
    echo "(total de bytes distintos: $(cmp -l "$OUT" "$ORIG" 2>/dev/null | wc -l | tr -d ' '))"
else
    python3 -c "
import sys
a = open(sys.argv[1], 'rb').read()
b = open(sys.argv[2], 'rb').read()
d = [i for i in range(min(len(a), len(b))) if a[i] != b[i]]
for i in d[:20]:
    print('  %6d  %02X != %02X' % (i, a[i], b[i]))
print('(bytes distintos: %d; tamanos %d y %d)' % (len(d), len(a), len(b)))
" "$OUT" "$ORIG"
fi
exit 1
