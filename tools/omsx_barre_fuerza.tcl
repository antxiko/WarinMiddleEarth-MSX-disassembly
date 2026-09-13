# Ejecuta FUERZA_DE_LA_TROPA (0x8DE4) con TODOS los tipos y terrenos posibles.
#
# Esperar a que una partida pase por sus 160 combinaciones es inviable: se dejo
# correr el replay de Araubi 52.828 segundos emulados con un punto de ruptura en
# 0x9021 y no se registro NI UNA batalla (work/fuerza/fuerza.log). Cuidado con
# leer de mas en ese dato: el guion no detectaba el final del replay, asi que
# parte de ese tiempo es el emulador corriendo solo, sin nadie a los mandos. Lo
# que si vale es que por ahi no iba a salir la medida.
#
# Asi que se hace al reves: con el juego ya cargado en la RAM, se le pone al Z80
# el tipo en A y el terreno en el operando de 0x8DEA, se coloca el PC en 0x8DE4
# y se le deja ejecutar la rutina. En 0x8DF1, A ya trae el byte de la tabla.
#
#   8DE4 add a,a / 8DE5 add a,a / 8DE6 add a,a / 8DE7 add a,047h / 8DE9 or nn
#   8DEB ld l,a / 8DEC adc a,06dh / 8DEE sub l / 8DEF ld h,a / 8DF0 ld a,(hl)
#
# DOS COSAS QUE COSTARON TRES INTENTOS:
#
#   1. Mientras el replay esta reproduciendo, la maquina es de SOLO LECTURA:
#      `reg pc` no tiene efecto. Hay que soltarla antes con `reverse stop`.
#   2. `debug step` NO avanza dentro de un bucle TCL: el emulador solo ejecuta
#      cuando le devuelves el control, asi que un `for` con steps se queda
#      clavado en la misma instruccion. Por eso los 160 casos van encadenados
#      por el propio punto de ruptura: cada vez que se llega a 0x8DF1 se anota
#      el resultado y se prepara el siguiente, sin dejar que la CPU pase de ahi.
#
# Uso:
#   WAR_REPLAY=<replay.omr> WAR_OUT=<dir> [WAR_T=<segundo>] openmsx -script este.tcl

set REPLAY $::env(WAR_REPLAY)
set OUT $::env(WAR_OUT)
set T [expr {[info exists ::env(WAR_T)] ? $::env(WAR_T) : 2000}]
file mkdir $OUT

set L [open "$OUT/barrido.log" w]
proc di {m} {
    global L
    puts $L "\[[format %9.3f [machine_info time]]\] $m"
    flush $L
}

proc byte {a} { return [debug read memory $a] }

set ::caso 0
set ::distintos {}
array set ::salida {}

proc prepara {} {
    set tipo [expr {$::caso / 16}]
    set terr [expr {$::caso % 16}]
    debug write memory 0x8DEA $terr
    reg a $tipo
    reg pc 0x8DE4
}

proc recoge {} {
    set tipo [expr {$::caso / 16}]
    set terr [expr {$::caso % 16}]
    set v [reg a]
    set ::salida($tipo,$terr) $v
    if {[lsearch $::distintos $v] < 0} { lappend ::distintos $v }
    if {$terr == 0} {
        di "  tipo $tipo, terreno 0: HL=[format 0x%04X [reg hl]], la tabla da $v"
    }
    incr ::caso
    if {$::caso < 160} {
        prepara
        return
    }
    di "-------- los 160 casos, ejecutados por el Z80 --------"
    for {set t 0} {$t < 10} {incr t} {
        set fila ""
        for {set e 0} {$e < 16} {incr e} {
            append fila [format " %3d" $::salida($t,$e)]
        }
        di "  tipo $t ->$fila"
    }
    di "valores distintos devueltos: $::distintos"
    if {[llength $::distintos] == 1} {
        set v [lindex $::distintos 0]
        di "CONFIRMADO: siempre $v. La fuerza que sale de aqui es [expr {$v * 8}],"
        di "la misma para los diez tipos de tropa y los dieciseis terrenos."
    } else {
        di "NO siempre el mismo: la lectura del listado estaba equivocada."
    }
    after realtime 1 {exit 0}
}

set r [catch {reverse loadreplay -viewonly $REPLAY} msg]
di "loadreplay rc=$r: $msg"
if {$r} { di "ABORTADO"; exit 1 }
set r [catch {reverse goto $T} msg]
di "reverse goto $T: rc=$r $msg"

after time 1 {
    set f "[format %02X [byte 0x6D47]] [format %02X [byte 0x6D48]] [format %02X [byte 0x6D49]]"
    di "primera ficha de tropa en 0x6D47: $f  (tiene que ser 03 FF FF)"
    if {$f ne "03 FF FF"} { di "el juego no esta cargado aqui; prueba otro WAR_T"; exit 2 }

    di "la tabla, tal como esta en la RAM ahora mismo:"
    for {set t 0} {$t < 10} {incr t} {
        set fila ""
        for {set i 0} {$i < 16} {incr i} {
            append fila [format " %02X" [byte [expr {0x6D47 + $t * 16 + $i}]]]
        }
        di "  tipo $t:$fila"
    }

    set r [catch {reverse stop} m]
    di "reverse stop: rc=$r $m"
    debug set_bp 0x8DF1 {} {recoge}
    prepara
    di "-------- barriendo --------"
}

set throttle off
after realtime 240 {di "se acabo el tiempo en el caso $::caso"; exit 3}
