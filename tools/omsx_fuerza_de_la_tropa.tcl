# Que saca de verdad FUERZA_DE_LA_TROPA (0x8DE4) en una partida completa.
#
# Leyendo el listado sale que el indice esta mal calculado: en vez de
# 0x6D47 + tipo*16 + terreno -que es como se lee esa tabla en los otros dos
# sitios, 0x6728 y 0x9296-, aqui se hace
#
#     a = tipo*8 ; a += 0x47 ; a |= terreno ; hl = 0x6D00 + a
#
# o sea paso OCHO y un `or` en lugar de una suma, y los tres bits bajos del
# 0x47 ya estan puestos. Sobre el volcado de la cinta eso da SIEMPRE el mismo
# byte, un 3, para los diez tipos y los dieciseis terrenos. Pero eso es leer,
# no ejecutar: esto lo mide mientras corre una partida de verdad.
#
# Lo que se apunta, por cada llamada:
#   en 0x8DE4  el tipo de tropa (A) y el terreno (el operando de 0x8DEA)
#   en 0x8DF1  el byte que ha salido de la tabla (A), que es lo que luego se
#              multiplica por ocho y se resta a la vida de la figura
#
# Y de paso, dos guardias: que nadie escriba el operando de 0x8DEA salvo 0x902F,
# y que nadie escriba dentro de la tabla de fichas de tropa (0x6D47-0x6DE6).
#
# Uso:
#   WAR_REPLAY=<replay.omr> WAR_OUT=<dir> openmsx -script este.tcl

set REPLAY $::env(WAR_REPLAY)
set OUT $::env(WAR_OUT)
file mkdir $OUT

set L [open "$OUT/fuerza.log" w]
proc di {m} {
    global L
    puts $L "\[[format %9.3f [machine_info time]]\] $m"
    flush $L
}

proc byte {a} { return [debug read memory $a] }

set ::llamadas 0
set ::batallas 0
set ::tipo -1
set ::terreno -1
array set ::visto {}
array set ::valores {}

set r [catch {reverse loadreplay -viewonly $REPLAY} msg]
di "loadreplay rc=$r: $msg"
if {$r} { di "ABORTADO"; exit 1 }

debug set_bp 0x8DE4 {} {
    set ::tipo [reg a]
    set ::terreno [byte 0x8DEA]
}

debug set_bp 0x8DF1 {} {
    incr ::llamadas
    set v [reg a]
    set clave "[expr {$::tipo & 0x0F}],$::terreno"
    set ::visto($clave) 1
    lappend ::valores($v) $clave
    if {$v != 3} {
        di "OJO: con tipo $::tipo y terreno $::terreno la tabla ha dado $v, no 3"
    }
}

debug set_bp 0x9021 {} {incr ::batallas; di "batalla $::batallas"}

debug set_watchpoint write_mem 0x8DEA {} {
    di "escriben el operando del terreno desde PC=[format 0x%04X [reg pc]]"
}
debug set_watchpoint write_mem {0x6D47 0x6DE6} {} {
    di "ESCRIBEN DENTRO DE LA TABLA DE TROPAS desde PC=[format 0x%04X [reg pc]]"
}

proc resumen {} {
    di "-------- resumen --------"
    di "batallas vistas: $::batallas ; llamadas a FUERZA_DE_LA_TROPA: $::llamadas"
    foreach v [lsort -integer [array names ::valores]] {
        di "  la tabla devolvio $v en [llength $::valores($v)] llamadas"
    }
    di "parejas (tipo,terreno) distintas que han pasado por aqui: [llength [array names ::visto]]"
    di "  [lsort [array names ::visto]]"
}

proc vigila {} {
    di "... batallas $::batallas, llamadas $::llamadas"
    after time 120 vigila
}
after time 120 vigila

set throttle off
after realtime 780 {resumen; di "fin del muestreo"; exit 0}
