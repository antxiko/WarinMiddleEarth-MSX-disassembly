# Deja el juego en marcha para jugarlo A MANO, muestreando el PC y grabando.
#
# Para que: lo que un conductor a ciegas no alcanza -una batalla, entrar en un
# lugar, File -> Cargar/Salvar, perder el Anillo, el final- lo alcanza una
# persona en unos minutos. Cada PC muestreado es una instruccion que corrio de
# verdad; los que caen fuera del trazado (tools/cruza_muestreo.py) son las
# semillas que faltan, y los puntos de observacion de lectura de despues diran
# quien lee los 13,8 KB de graficos del bloque bajo que nadie ha leido aun.
#
# Parte del estado de 0x5E00 (work/omsx/war_5e00.oms), en el menu: elige el
# control (1/2/3), 0 para empezar. Dentro: R = menu del juego, 1 = pausa.
#
# Se guarda solo cada minuto: los PCs a <nombre>.pcs, la RAM a <nombre>.ram.bin
# y la partida grabada a <nombre>.omr (todo en WAR_OUT). Cierra la ventana
# cuando quieras: se pierde como mucho el ultimo minuto.
#
#   W=$(cygpath -m "$PWD"); WAR_OUT="$W/work/omsx" WAR_NOMBRE=antxiko1 \
#       "/c/Program Files/openMSX/openmsx.exe" -machine Philips_VG_8020 -script tools/omsx_juega_tu.tcl

set OUT $::env(WAR_OUT)
set NOMBRE [expr {[info exists ::env(WAR_NOMBRE)] ? $::env(WAR_NOMBRE) : "juega_tu"}]
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

# A velocidad normal y con imagen: esto se juega.
set renderer SDLGL-PP
set throttle on

set pcs [dict create]
set N 0
proc muestra {} {
    global pcs N
    dict incr pcs [reg PC]
    incr N
    after time 0.001 muestra
}
after time 0.01 muestra

set r [catch {reverse start} msg]
say "reverse start rc=$r $msg"

set ::guardados 0
proc guarda {} {
    global pcs N OUT NOMBRE
    set f [open "$OUT/$NOMBRE.pcs" w]
    dict for {pc n} $pcs { puts $f [format "%04X %d" $pc $n] }
    close $f
    set f [open "$OUT/$NOMBRE.ram.bin" w]
    fconfigure $f -translation binary
    puts -nonewline $f [debug read_block memory 0 0x10000]
    close $f
    set r [catch {reverse savereplay "$OUT/$NOMBRE.omr"} msg]
    incr ::guardados
    say "guardado #$::guardados: muestras=$N PCs=[dict size $pcs] replay rc=$r $msg"
    after time 60 guarda
}
after time 60 guarda

osd create rectangle juega -x 4 -y 4 -w 240 -h 14 -rgba 0x00000080
osd create text juega.t -x 6 -y 5 -size 10 -rgb 0xffffff -text "WAR: grabando; se guarda solo cada minuto"
after realtime 8 { catch {osd destroy juega} }
say "El mando es tuyo."

# Prueba de humo sin persona delante: WAR_PRUEBA=1 guarda a los 5 s y sale.
if {[info exists ::env(WAR_PRUEBA)]} { after realtime 5 { guarda; say "FIN prueba"; exit 0 } }
