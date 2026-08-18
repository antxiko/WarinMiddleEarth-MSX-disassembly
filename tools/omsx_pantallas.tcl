# Capturas del juego a partir del estado de 0x5E00: el menu y lo que sigue.
# Renderer encendido y capturas con `after realtime` (ver memoria del emulador).
#   WAR_OUT=<dir> WAR_TECLAS="3 0;12 x" openmsx -machine Philips_VG_8020 -script este.tcl
set OUT $::env(WAR_OUT)
set LOG [open "$OUT/pantallas.log" w]
proc say {m} { global LOG; puts $LOG "\[[format %8.2f [machine_info time]]\] $m"; flush $LOG }
set r [catch {
    set nuevo [restore_machine "$OUT/war_5e00.oms"]
    set viejo [machine]
    if {$viejo ne ""} { delete_machine $viejo }
    activate_machine $nuevo
} msg]
say "restore rc=$r: $msg"
set renderer SDLGL-PP
set throttle on
set n 0
proc foto {} {
    global OUT n
    incr n
    set f [format "%s/pantalla_%02d.png" $OUT $n]
    catch {screenshot $f} e
    say "foto $f -> $e"
}
if {[info exists ::env(WAR_TECLAS)]} {
    foreach par [split $::env(WAR_TECLAS) ";"] {
        lassign $par t k
        if {$k eq "FOTO"} {
            after realtime $t foto
        } else {
            after realtime $t [list apply {{k} { say "tecla '$k'"; type $k }} $k]
        }
    }
}
set FIN [expr {[info exists ::env(WAR_FIN)] ? $::env(WAR_FIN) : 20}]
after realtime $FIN { say "FIN"; exit 0 }
