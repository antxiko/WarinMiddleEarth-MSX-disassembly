# Quien LEE cada zona de datos: puntos de observacion de lectura sobre rangos,
# y por cada rango, los PC que leen de el, con su cuenta.
#
# Es la forma de no adivinar formatos: la rutina que consume una tabla dice
# como esta hecha. El callback es barato a proposito (dict incr con el PC en
# crudo); el volcado, al final. Parte del estado de 0x5E00 y conduce el juego
# a ciegas igual que omsx_conduce.tcl para que pase por cuantas mas cosas mejor.
#
#   WAR_OUT=<dir> WAR_SEG=<segundos> WAR_NOMBRE=<nombre> \
#   WAR_RANGOS="0x9E00-0xB8E8;0xB8E8-0xC800" [WAR_SEMILLA=n] \
#       openmsx -machine Philips_VG_8020 -script este.tcl

set OUT $::env(WAR_OUT)
set SEG [expr {[info exists ::env(WAR_SEG)] ? $::env(WAR_SEG) : 120}]
set NOMBRE [expr {[info exists ::env(WAR_NOMBRE)] ? $::env(WAR_NOMBRE) : "quienlee"}]
if {[info exists ::env(WAR_SEMILLA)]} { expr {srand($::env(WAR_SEMILLA))} } else { expr {srand(3)} }
set LOG [open "$OUT/$NOMBRE.log" w]
proc say {m} { global LOG; puts $LOG "\[[format %8.2f [machine_info time]]\] $m"; flush $LOG }

set r [catch {
    set nuevo [restore_machine "$OUT/war_5e00.oms"]
    set viejo [machine]
    if {$viejo ne ""} { delete_machine $viejo }
    activate_machine $nuevo
} msg]
say "restore rc=$r: $msg"
if {$r} { exit 1 }
set throttle off

set RANGOS [list]
set i 0
foreach par [split $::env(WAR_RANGOS) ";"] {
    lassign [split $par "-"] a b
    set a [expr $a]; set b [expr $b]
    lappend RANGOS [list $i $a $b]
    set ::lee($i) [dict create]
    # el ultimo byte del watchpoint es inclusivo en openMSX
    debug set_watchpoint read_mem [list $a [expr {$b - 1}]] {} [subst -nocommands {dict incr ::lee($i) [reg PC]}]
    say [format "rango %d: 0x%04X-0x%04X" $i $a [expr {$b-1}]]
    incr i
}

set TECLAS {{4 0x40 Q} {2 0x40 A} {4 0x10 O} {4 0x20 P} {8 0x01 SPC}}
proc pulsa {fila masc dur} {
    keymatrixdown $fila $masc
    after time $dur [list keymatrixup $fila $masc]
}
proc paso {} {
    global TECLAS
    set r [expr {rand()}]
    if {$r < 0.6} {
        lassign [lindex $TECLAS [expr {int(rand()*4)}]] f m n
        set d [expr {0.1 + rand()*1.5}]
        pulsa $f $m $d
        after time [expr {$d + 0.1}] paso
    } elseif {$r < 0.9} {
        pulsa 8 0x01 0.3
        after time 0.6 paso
    } elseif {$r < 0.93} {
        type "R"; after time 1.0 paso
    } else {
        after time 1.0 paso
    }
}
after time 2 { type "3" }
after time 4 { type "0" }
after time 8 { paso }

after time $SEG {
    global RANGOS OUT NOMBRE
    set f [open "$OUT/$NOMBRE.lee" w]
    foreach r $RANGOS {
        lassign $r i a b
        puts $f [format "== rango 0x%04X-0x%04X" $a [expr {$b-1}]]
        dict for {pc n} $::lee($i) { puts $f [format "%04X %d" $pc $n] }
    }
    close $f
    say "FIN"
    exit 0
}
