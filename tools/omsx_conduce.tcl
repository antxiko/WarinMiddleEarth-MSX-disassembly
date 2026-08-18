# Conduce el juego a ciegas y muestrea el PC: teclado (opcion 3, Q-A-O-P-SPC),
# empieza la partida y luego pulsa direcciones y fuego al azar. Cada PC visto
# es una instruccion que corrio de verdad; las que caen fuera del trazado son
# semillas para el trazador (tools/cruza_muestreo.py).
#
# Teclas por la matriz del MSX (fila/mascara): Q=4/0x40 A=2/0x40 O=4/0x10
# P=4/0x20 SPC=8/0x01. Se MANTIENEN pulsadas un rato, que `type` suelta enseguida
# y un juego que lee la matriz cada cuadro puede no verlas.
#
#   WAR_OUT=<dir> WAR_SEG=<segundos> WAR_NOMBRE=<nombre> [WAR_SEMILLA=n] \
#       openmsx -machine Philips_VG_8020 -script este.tcl

set OUT $::env(WAR_OUT)
set SEG [expr {[info exists ::env(WAR_SEG)] ? $::env(WAR_SEG) : 300}]
set NOMBRE [expr {[info exists ::env(WAR_NOMBRE)] ? $::env(WAR_NOMBRE) : "conduce"}]
if {[info exists ::env(WAR_SEMILLA)]} { expr {srand($::env(WAR_SEMILLA))} } else { expr {srand(1)} }
file mkdir $OUT
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
set T0 [machine_info time]
set throttle off

set pcs [dict create]
set N 0
proc muestra {} {
    global pcs N
    dict incr pcs [reg PC]
    incr N
    after time 0.0005 muestra
}
after time 0.01 muestra
set ints 0
debug set_bp 0x0038 {} { incr ints }

# Q A O P SPC, mas R (menu) y 1 (pausa) de vez en cuando
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
        # R = menu del juego; 1 = pausa/abandona (y otra vez para seguir)
        say "tecla R"; type "R"
        after time 1.0 paso
    } elseif {$r < 0.95} {
        say "tecla 1"; type "1"
        after time 1.5 paso
    } else {
        after time 1.0 paso
    }
}

after time 2 { say "tecla 3 (teclado)"; type "3" }
after time 4 { say "tecla 0 (empieza)"; type "0" }
after time 8 { say "empiezo a conducir"; paso }

after time $SEG {
    global pcs N ints OUT NOMBRE T0
    set f [open "$OUT/$NOMBRE.pcs" w]
    dict for {pc n} $pcs { puts $f [format "%04X %d" $pc $n] }
    close $f
    say "muestras=$N  PCs distintos=[dict size $pcs]  interrupciones=$ints en [expr {[machine_info time]-$T0}] s"
    set f [open "$OUT/$NOMBRE.ram.bin" w]
    fconfigure $f -translation binary
    puts -nonewline $f [debug read_block memory 0 0x10000]
    close $f
    catch {store_machine [machine] "$OUT/$NOMBRE.oms"}
    say "FIN"
    exit 0
}
