# Muestrea el PC con el juego corriendo, partiendo del savestate de 0x5E00.
#
# Para que sirve: el trazado estatico se para en lo que no ve (retornos
# empujados, tablas, automodificacion). Cada PC muestreado es una instruccion
# que se EJECUTO de verdad, y las que caen fuera del trazado son semillas con
# la mejor justificacion posible: se vieron correr.
#
# Barato a proposito: el callback solo hace `dict incr` con el PC en crudo. El
# volcado, al final. Y se teclea una secuencia por entorno (WAR_TECLAS, pares
# "instante tecla" separados por ';') para llevar el juego a donde haga falta.
#
#   WAR_OUT=<dir> WAR_SEG=<segundos emulados> WAR_TECLAS="2 0;10 ..." \
#       openmsx -machine Philips_VG_8020 -script este.tcl

set OUT $::env(WAR_OUT)
set SEG [expr {[info exists ::env(WAR_SEG)] ? $::env(WAR_SEG) : 60}]
set NOMBRE [expr {[info exists ::env(WAR_NOMBRE)] ? $::env(WAR_NOMBRE) : "muestreo"}]
file mkdir $OUT
set LOG [open "$OUT/$NOMBRE.log" w]
proc say {m} { global LOG; puts $LOG "\[[format %8.2f [machine_info time]]\] $m"; flush $LOG }

# El estado lo guardo omsx_arranque.tcl con store_machine (ver alli por que).
set r [catch {
    set nuevo [restore_machine "$OUT/war_5e00.oms"]
    set viejo [machine]
    if {$viejo ne ""} { delete_machine $viejo }
    activate_machine $nuevo
} msg]
say "restore_machine war_5e00 rc=$r: $msg"
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

# Interrupciones: el control de que la maquina esta viva.
set ints 0
debug set_bp 0x0038 {} { incr ints }

if {[info exists ::env(WAR_TECLAS)]} {
    foreach par [split $::env(WAR_TECLAS) ";"] {
        lassign $par t k
        after time $t [list apply {{k} { say "tecla '$k'"; type $k }} $k]
    }
}

after time $SEG {
    global pcs N ints OUT NOMBRE T0
    set f [open "$OUT/$NOMBRE.pcs" w]
    dict for {pc n} $pcs { puts $f [format "%04X %d" $pc $n] }
    close $f
    say "muestras=$N  PCs distintos=[dict size $pcs]  interrupciones=$ints en [expr {[machine_info time]-$T0}] s"
    dump_ram
    say "FIN"
    exit 0
}
proc dump_ram {} {
    global OUT NOMBRE
    set f [open "$OUT/$NOMBRE.ram.bin" w]
    fconfigure $f -translation binary
    puts -nonewline $f [debug read_block memory 0 0x10000]
    close $f
}
