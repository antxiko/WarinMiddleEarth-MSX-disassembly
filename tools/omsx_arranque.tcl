# Carga la cinta original en openMSX y vuelca la RAM en los puntos clave.
#
# Es la comprobacion de lo que se lee en el cargador: que los bloques van donde
# el cargador dice, que el arranque de 0x0190 los recoloca a 0x5E00 y 0x9E00, y
# que la imagen de 64K que monta tools/cuerpos.py (work/juego64.bin) es la que
# hay de verdad en la maquina cuando el juego arranca.
#
# Cadena de carga (leida del cargador 0xD6D8 y del arranque 0x0190):
#   0xD6D8  cargador: busca RAM en las paginas 1, 2 y 0
#   0x88B8  pantalla de carga cargada (12388 B); el cargador la vuelca a VRAM
#   0x0190  los tres bloques cargados; ANTES de recolocar   <-- volcado crudo
#   0x5E00  recolocados; arranca el juego                    <-- volcado bueno
#
# openMSX no pasa argv a los scripts de -script, asi que van por entorno:
#   WAR_TSX=<war.tsx> WAR_OUT=<directorio> openmsx -machine Philips_VG_8020 -script este.tcl

set TSX  $::env(WAR_TSX)
set OUT  $::env(WAR_OUT)
file mkdir $OUT

set LOG [open "$OUT/omsx_arranque.log" w]
proc say {msg} { global LOG; puts $LOG "\[[format %8.2f [machine_info time]]\] $msg"; flush $LOG }

proc dump {name addr size} {
    global OUT
    set f [open "$OUT/$name" w]
    fconfigure $f -translation binary
    puts -nonewline $f [debug read_block memory $addr $size]
    close $f
    say "volcado $name  <- CPU\[[format 0x%04X $addr] .. [format 0x%04X [expr {$addr+$size-1}]]\] ($size bytes)"
}

set throttle off
catch {set renderer none}

cassetteplayer insert $TSX
say "cinta insertada: $TSX"

debug set_bp 0xD6D8 {} { say "cargador en marcha (0xD6D8)" }
debug set_bp 0xD702 {} {
    say "pantalla de carga cargada; el cargador la vuelca a VRAM"
    dump "pantalla_ram.bin" 0x88B8 0x3064
}
debug set_bp 0x0190 {} {
    say "los tres bloques cargados; PC en 0x0190, ANTES de recolocar"
    dump "full_crudo.bin" 0x0000 0x10000
    say [format "A8=0x%02X" [debug read "ioports" 0xA8]]
}
debug set_bp 0x5E00 {} {
    say "recolocado; el juego arranca en 0x5E00"
    dump "full_5e00.bin" 0x0000 0x10000
    say [format "SP=0x%04X" [reg SP]]
    # Estado guardado para no volver a cargar la cinta (6 min emulados) en
    # cada medida. Con store_machine, no con `savestate`: en esta maquina un
    # script del usuario (ownl.tcl) anula ese envoltorio, y asi ademas el
    # fichero queda en work/ del proyecto y no en la carpeta de openMSX.
    catch {store_machine [machine] "$OUT/war_5e00.oms"} e
    say "estado guardado -> $e"
    say "OK: la cinta original carga y el juego arranca"
    exit 0
}

after time 4 {
    say "tecleando RUN\"CAS:\""
    type "RUN\"CAS:\"\r"
}

after time 900 { say "TIMEOUT: no se llego a 0x5E00"; exit 1 }
