; ==========================================================================
; WAR IN MIDDLE EARTH - MSX - el cargador
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x0d6d8


; ======================================================================
; CODIGO 0xd6d8..0xd744  (108 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Lo que llama el BLOAD"cas:",R: monta la RAM y carga los cuatro bloques
; ----------------------------------------------------------------------
ARRANQUE:		; Deja las cuatro paginas en RAM, carga la pantalla y los tres bloques del juego
	di			;d6d8
	ld sp,0fde8h		;d6d9   ; La pila en 0xFDE8; el arranque del bloque bajo la vuelve a poner justo ahi (0x0191)
	call BUSCA_RAM		;d6dc   ; Busca en que slot hay RAM en las paginas 0, 1 y 2, y lo anota en 0xD746-47
	call RAM_EN_P0		;d6df   ; Pagina 0 a RAM: a partir de aqui la BIOS ya no esta debajo
	call RAM_EN_P1		;d6e2   ; Pagina 1 a RAM
	call RAM_EN_P2		;d6e5   ; Pagina 2 a RAM; la 3 ya lo era. El juego corre sin ROM ninguna
	ld hl,0dac0h		;d6e8   ; 0xDAC0 esta FUERA del bloque cargado (681 bytes acaban en 0xD981): copia RAM tal como estaba
	ld de,0012ch		;d6eb   ; A 0x012C-0x018F, los 100 bytes justo debajo de donde cae el bloque bajo
	ld bc,00064h		;d6ee
	ldir		;d6f1
	call PANTALLA_APAGADA		;d6f3   ; Pantalla apagada mientras se vuelca la imagen de carga a la VRAM
	ld ix,088b8h		;d6f6   ; Primer bloque: la pantalla de carga, a 0x88B8
	ld de,03064h		;d6fa   ; 0x3064 = 12388 bytes, el tamano exacto del bloque [08] de la cinta
	xor a			;d6fd   ; A = el byte de bandera que tiene que traer el bloque: 0
	scf			;d6fe   ; Acarreo puesto: en LD-BYTES es "cargar" y no "verificar"
	call CARGA_BLOQUE		;d6ff
	ld hl,0891ch		;d702   ; 0x88B8 + 100 de cabecera: los 6144 bytes de patrones
	ld de,00000h		;d705
	ld bc,01800h		;d708   ; 0x1800 = 6144 bytes a la VRAM 0x0000
	call VUELCA_A_VRAM		;d70b
	ld hl,0a11ch		;d70e   ; Y los otros 6144, los de color, a la VRAM 0x2000
	ld de,02000h		;d711
	ld bc,01800h		;d714
	call VUELCA_A_VRAM		;d717
	call PANTALLA_ENCENDIDA		;d71a   ; Enciende la pantalla: ya se ve el dibujo mientras carga el resto
	ld ix,00190h		;d71d   ; Bloque bajo, a 0x0190, que es donde se ejecuta: no lo mueve nadie
	ld de,03dbfh		;d721   ; 0x3DBF = 15807 bytes
	xor a			;d724
	scf			;d725
	call CARGA_BLOQUE		;d726
	ld ix,03f4fh		;d729   ; Bloque medio, a 0x3F4F, pegado al anterior; el arranque lo subira a 0x5E00
	ld de,038f1h		;d72d   ; 0x38F1 = 14577 bytes
	xor a			;d730
	scf			;d731
	call CARGA_BLOQUE		;d732
	ld ix,088b8h		;d735   ; Bloque alto, encima de la pantalla de carga, que ya esta en la VRAM
	ld de,04878h		;d739   ; 0x4878 = 18552 bytes; el arranque lo subira a 0x9E00
	xor a			;d73c
	scf			;d73d
	call CARGA_BLOQUE		;d73e
	jp 00190h		;d741   ; Y al bloque bajo, que recoloca los otros dos y salta al juego

; ----------------------------------------------------------------------
; DATOS slots_originales_y_de_ram: Los slots: A8 y (0xFFFF) originales
;   (0xD744-45) y los que tienen RAM en las tres paginas (0xD746-47)
;   0xd744..0xd748  (4 bytes)
DATA_slots_originales_y_de_ram:
	defb 000h,000h	; d744
	defb 000h,000h	; d746

; ======================================================================
; CODIGO 0xd748..0xd8be  (374 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Volcar RAM a VRAM
; ----------------------------------------------------------------------
VUELCA_A_VRAM:		; BC bytes desde HL a la VRAM DE
	di			;d748
	ex de,hl			;d749   ; La direccion de VRAM viene en DE y la de RAM en HL; se cruzan
	call VRAM_A_ESCRIBIR		;d74a
	ex de,hl			;d74d
BUCLE_A_VRAM:		; Un byte por vuelta al puerto 0x98
	ld a,(hl)			;d74e
	out (098h),a		;d74f   ; Puerto 0x98: el dato. La direccion se autoincrementa sola en el VDP
	inc hl			;d751
	dec bc			;d752
	ld a,b			;d753
	or c			;d754
	jp nz,BUCLE_A_VRAM		;d755   ; Ni ei al acabar: todo el cargador corre con las interrupciones cerradas
	ret			;d758
VRAM_A_ESCRIBIR:		; Pone HL como direccion de ESCRITURA de la VRAM
	ld a,l			;d759
	out (099h),a		;d75a   ; Primero el byte bajo de la direccion, por el puerto 0x99
	ld a,h			;d75c
	and 03fh		;d75d   ; El VDP solo mira 14 bits de direccion
	or 040h		;d75f   ; Bit 6 a 1: lo que viene detras son escrituras
	out (099h),a		;d761
	ex (sp),hl			;d763   ; Dos `ex (sp),hl` seguidos: el retardo que necesita el VDP, sin tocar nada
	ex (sp),hl			;d764
	ret			;d765
PANTALLA_APAGADA:		; Registro 1 del VDP con el bit de pantalla a 0
	di			;d766
	in a,(099h)		;d767   ; Leer el estado deja el puerto 0x99 esperando una direccion, no medio dato
	ld a,0a0h		;d769   ; Registro 1 = 0xA0: bit 6 (pantalla) a 0, bit 5 (interrupcion) a 1
	out (099h),a		;d76b   ; 0x81 = escribir en el registro 1
	ld a,081h		;d76d
	out (099h),a		;d76f
	ret			;d771
PANTALLA_ENCENDIDA:		; Registro 1 del VDP con el bit de pantalla a 1
	di			;d772
	in a,(099h)		;d773
	ld a,0e0h		;d775   ; Registro 1 = 0xE0: lo mismo de arriba con el bit 6 puesto
	out (099h),a		;d777   ; 0x81 = escribir en el registro 1
	ld a,081h		;d779
	out (099h),a		;d77b
	ret			;d77d

; ----------------------------------------------------------------------
; Conmutar una pagina entre su slot original y el slot con RAM
; ----------------------------------------------------------------------
RESTAURA_P0:		; Pagina 0 a su slot original. NADIE la llama en esta cinta
	ld hl,0d745h		;d77e   ; 0xD745 es la pareja de slots de cuando arranco la maquina
	jr MASCARA_P0		;d781
RESTAURA_P1:		; Pagina 1 a su slot original. Sin llamadas
	ld hl,0d745h		;d783   ; Mismo par de bytes; solo cambia la mascara de la pagina
	jr MASCARA_P1		;d786
RESTAURA_P2:		; Pagina 2 a su slot original. Sin llamadas
	ld hl,0d745h		;d788   ; Las tres son codigo muerto: este cargador no devuelve la BIOS nunca
	jr MASCARA_P2		;d78b
RAM_EN_P0:		; Pagina 0 al slot con RAM
	ld hl,0d747h		;d78d   ; 0xD747 es la pareja de slots que dejo anotada 0xD7C4: los que tienen RAM
	jr MASCARA_P0		;d790
RAM_EN_P1:		; Pagina 1 al slot con RAM
	ld hl,0d747h		;d792   ; La misma pareja de 0xD747, con la mascara de la pagina 1
	jr MASCARA_P1		;d795
RAM_EN_P2:		; Pagina 2 al slot con RAM
	ld hl,0d747h		;d797   ; Y con la de la pagina 2
	jr MASCARA_P2		;d79a
MASCARA_P0:		; D = los bits de la pagina 0 en los registros de slot, E = su contrario
	ld d,003h		;d79c   ; Bits 0-1: la pagina 0
	ld e,0fch		;d79e
	jr CAMBIA_SLOT		;d7a0
MASCARA_P1:		; D/E para la pagina 1
	ld d,00ch		;d7a2   ; Bits 2-3: la pagina 1
	ld e,0f3h		;d7a4
	jr CAMBIA_SLOT		;d7a6
MASCARA_P2:		; D/E para la pagina 2
	ld d,030h		;d7a8   ; Bits 4-5: la pagina 2. Los 6-7, la pagina 3, no se tocan jamas
	ld e,0cfh		;d7aa
CAMBIA_SLOT:		; Mete en 0xFFFF y en el puerto 0xA8 los dos bits de una pagina
	di			;d7ac
	ld a,(hl)			;d7ad   ; El byte de arriba de la pareja: el registro de slots secundarios
	and d			;d7ae   ; Solo los dos bits de esta pagina; el resto se deja como esta
	ld b,a			;d7af
	ld a,(0ffffh)		;d7b0   ; 0xFFFF se lee INVERTIDO, y el cpl deshace la inversion
	cpl			;d7b3
	and e			;d7b4   ; Las otras tres paginas se conservan
	or b			;d7b5
	ld (0ffffh),a		;d7b6   ; Y se escribe el registro secundario entero
	dec hl			;d7b9   ; Ahora el byte de abajo: el registro de slots primarios
	ld a,(hl)			;d7ba
	and d			;d7bb
	ld b,a			;d7bc
	in a,(0a8h)		;d7bd   ; El puerto 0xA8 lleva los slots primarios de las cuatro paginas
	and e			;d7bf
	or b			;d7c0
	out (0a8h),a		;d7c1   ; Aqui es donde desaparece la BIOS, cuando la pagina es la 0
	ret			;d7c3

; ----------------------------------------------------------------------
; Buscar RAM probando slot a slot en las paginas 1, 2 y 0
; ----------------------------------------------------------------------
BUSCA_RAM:		; Deja las tres paginas en un slot con RAM y anota la pareja en 0xD746-47
	di			;d7c4
	ld a,(08000h)		;d7c5   ; La prueba escribe en 0x0000, 0x4000 y 0x8000; de los tres solo se salva este
	push af			;d7c8
	call APUNTA_ORIGINALES		;d7c9   ; Anota en 0xD744-45 los slots tal como estaban al entrar
	ld hl,00024h		;d7cc   ; 0xD827 es el OPERANDO del `call` de 0xD826: se le pone el ENASLT de la BIOS
	ld (0d827h),hl		;d7cf
	ld hl,04000h		;d7d2   ; Probar la pagina 1...
	call RECORRE_SLOTS		;d7d5
	ld hl,08000h		;d7d8   ; ...y la pagina 2, que ya se pueden probar con la BIOS puesta
	call RECORRE_SLOTS		;d7db
	ld hl,ENASLT_COPIA		;d7de   ; 122 bytes de ENASLT recolocado, con los saltos ya escritos para 0xAFC8
	ld de,0afc8h		;d7e1
	ld bc,0007ah		;d7e4
	ldir		;d7e7
	ld hl,0afc8h		;d7e9   ; Y ahora el `call` de 0xD826 va a la copia: la pagina 0 se cambia sin BIOS
	ld (0d827h),hl		;d7ec
	ld hl,00000h		;d7ef   ; Probar la pagina 0
	call RECORRE_SLOTS		;d7f2
	call APUNTA_LOS_DE_RAM		;d7f5   ; Anota en 0xD746-47 los slots que han quedado, los que tienen RAM
	ld a,(0d744h)		;d7f8
	out (0a8h),a		;d7fb   ; Se devuelven los slots de antes: el juego todavia no ha empezado
	ld a,(0d745h)		;d7fd
	ld (0ffffh),a		;d800
	pop af			;d803
	ld (08000h),a		;d804   ; Y el byte de 0x8000 que se piso al probar
	ei			;d807
	ret			;d808
APUNTA_ORIGINALES:		; Guarda los slots de ahora en 0xD744-45
	ld hl,0d744h		;d809   ; 0xD744: la pareja "como estaba la maquina"
	jr APUNTA_SLOTS		;d80c
APUNTA_LOS_DE_RAM:		; Guarda los slots de ahora en 0xD746-47
	ld hl,0d746h		;d80e   ; 0xD746: la pareja "donde hay RAM"
APUNTA_SLOTS:		; Mete en (HL) el puerto 0xA8 y en (HL+1) el registro 0xFFFF
	in a,(0a8h)		;d811   ; Byte de abajo: los slots primarios del puerto 0xA8
	ld (hl),a			;d813
	inc hl			;d814
	ld a,(0ffffh)		;d815   ; Byte de arriba: el registro de slots secundarios, que se lee invertido
	cpl			;d818   ; Se guarda ya sin invertir, listo para volver a escribirlo
	ld (hl),a			;d819
	ret			;d81a
RECORRE_SLOTS:		; Prueba los 16 slots hasta que en HL se pueda escribir y releer
	ld a,080h		;d81b   ; Bit 7 puesto: a ENASLT se le da siempre la forma de slot expandido
	ld c,004h		;d81d   ; Cuatro slots primarios
SIGUIENTE_PRIMARIO:		; Empieza un slot primario, con el secundario otra vez a cero
	and 083h		;d81f   ; Se limpian los bits 2-3 al pasar al siguiente primario
	ld b,004h		;d821   ; Y cuatro secundarios dentro de cada uno
PRUEBA_UN_SLOT:		; Conecta un slot y escribe dos valores en HL para ver si es RAM
	push af			;d823
	push bc			;d824
	push hl			;d825
	call 00024h		;d826   ; BIOS ENASLT - Switches to specified slot and page definitively | ENASLT, o su copia de 0xAFC8: el operando lo pone 0xD7CC o 0xD7EC
	pop hl			;d829
	ld (hl),020h		;d82a   ; Escribe 0x20 en la direccion de prueba...
	ld a,(hl)			;d82c   ; ...y lo relee: si no vuelve igual, ahi no hay RAM
	cp 020h		;d82d
	jr nz,SLOT_SIN_RAM		;d82f
	ld (hl),0fah		;d831   ; Segundo valor, 0xFA, por si lo que se leyo era un eco del bus
	ld a,(hl)			;d833
	cp 0fah		;d834
	jr z,SLOT_CON_RAM		;d836
SLOT_SIN_RAM:		; Sigue con el siguiente slot
	pop bc			;d838
	pop af			;d839
	add a,004h		;d83a   ; +4: el siguiente slot secundario (bits 2-3)
	djnz PRUEBA_UN_SLOT		;d83c
	inc a			;d83e   ; +1: el siguiente primario (bits 0-1)
	dec c			;d83f
	jr nz,SIGUIENTE_PRIMARIO		;d840
	ret			;d842
SLOT_CON_RAM:		; Sale dejando conectado el slot que ha valido
	pop bc			;d843   ; Se sale con ese slot ya conectado y su identificador en A
	pop af			;d844
	ret			;d845
ENASLT_COPIA:		; Conmuta la pagina de HL al slot A. Corre recolocado en 0xAFC8
	call 0afe8h		;d846   ; 0xAFE8 es este mismo trozo copiado: le saca en B y C la mascara de la pagina
	jp m,0afd5h		;d849   ; Bit 7 del identificador: es un slot expandido y hay que tocar tambien 0xFFFF
	in a,(0a8h)		;d84c   ; Cambia en el puerto 0xA8 solo los dos bits de esa pagina
	and c			;d84e
	or b			;d84f
	out (0a8h),a		;d850
	ret			;d852
ENASLT_EXPANDIDO:		; La parte de los slots expandidos
	push hl			;d853
	call 0b00ch		;d854   ; 0xB00C: escribe el registro secundario del primario que toca
	ld c,a			;d857
	ld b,000h		;d858
	ld a,l			;d85a
	and h			;d85b
	or d			;d85c
	ld hl,0fcc5h		;d85d   ; 0xFCC5 es SLTTBL, la copia que la BIOS guarda de los cuatro registros secundarios
	add hl,bc			;d860
	ld (hl),a			;d861
	pop hl			;d862
	ld a,c			;d863
	jr ENASLT_COPIA		;d864   ; Y a rematar por el camino del slot no expandido, el del puerto 0xA8
MASCARAS_DE_SLOT:		; B = los bits que hay que meter, C = la mascara de lo que se conserva
	push af			;d866
	ld a,h			;d867   ; Los dos bits altos de H: la pagina, 0 a 3
	rlca			;d868
	rlca			;d869
	and 003h		;d86a
	ld e,a			;d86c
	ld a,0c0h		;d86d   ; 0xC0 rotado dos veces por pagina: sale 0x03, 0x0C, 0x30 o 0xC0
ROTA_LA_MASCARA:		; Dos rotaciones por pagina
	rlca			;d86f
	rlca			;d870
	dec e			;d871
	jp p,0aff1h		;d872
	ld e,a			;d875
	cpl			;d876   ; C se queda con la mascara al reves, la de los bits que NO se tocan
	ld c,a			;d877
	pop af			;d878
	push af			;d879
	and 003h		;d87a   ; Los dos bits bajos del identificador: el slot primario
	inc a			;d87c
	ld b,a			;d87d
	ld a,0abh		;d87e   ; 0xAB mas 0x55 por vuelta: 0x00, 0x55, 0xAA o 0xFF, el numero repetido cuatro veces
REPITE_EL_SLOT:		; 0xAB + 0x55 por cada vuelta
	add a,055h		;d880
	djnz REPITE_EL_SLOT		;d882
	ld d,a			;d884
	and e			;d885   ; Y se recorta a la pagina que toca
	ld b,a			;d886
	pop af			;d887
	and a			;d888   ; Deja el signo del identificador, que es el bit de "expandido"
	ret			;d889
ESCRIBE_SECUNDARIO:		; Mete el slot secundario en 0xFFFF, conmutando antes la pagina 3
	push af			;d88a
	ld a,d			;d88b   ; Los dos bits altos del patron que armo 0xD866
	and 0c0h		;d88c
	ld c,a			;d88e
	pop af			;d88f
	push af			;d890
	ld d,a			;d891
	in a,(0a8h)		;d892   ; Se apunta el puerto 0xA8 para dejarlo luego como estaba
	ld b,a			;d894
	and 03fh		;d895   ; La pagina 3 se lleva al primario que se va a tocar...
	or c			;d897
	out (0a8h),a		;d898   ; ...porque 0xFFFF es el registro secundario DE ESE primario, no uno global
	ld a,d			;d89a
	rrca			;d89b   ; Bits 2-3 del identificador: el slot secundario
	rrca			;d89c
	and 003h		;d89d
	ld d,a			;d89f
	ld a,0abh		;d8a0   ; Otra vez 0xAB + 0x55 por vuelta
REPITE_SECUNDARIO:		; El mismo truco del 0x55 para el slot secundario
	add a,055h		;d8a2
	dec d			;d8a4
	jp p,0b024h		;d8a5
	and e			;d8a8
	ld d,a			;d8a9
	ld a,e			;d8aa
	cpl			;d8ab
	ld h,a			;d8ac
	ld a,(0ffffh)		;d8ad   ; Se lee 0xFFFF invertido y se le cambian solo los dos bits de la pagina
	cpl			;d8b0
	ld l,a			;d8b1
	and h			;d8b2
	or d			;d8b3
	ld (0ffffh),a		;d8b4
	ld a,b			;d8b7   ; Y la pagina 3 vuelve a su slot de antes
	out (0a8h),a		;d8b8
	pop af			;d8ba
	and 003h		;d8bb   ; Devuelve el slot primario, 0 a 3
	ret			;d8bd

; ----------------------------------------------------------------------
; DATOS relleno_d8be: Dos bytes 0xFF de relleno entre la rutina recolocable y
;   la de carga
;   0xd8be..0xd8c0  (2 bytes)
DATA_relleno_d8be:
	defb 0ffh,0ffh	; d8be

; ======================================================================
; CODIGO 0xd8c0..0xd981  (193 bytes)
; ======================================================================



; ----------------------------------------------------------------------
; Leer un bloque de la cinta: IX destino, DE longitud, A bandera
; ----------------------------------------------------------------------
CARGA_BLOQUE:		; Lee de la cinta DE bytes a IX. Acarreo puesto al salir = bien
	di			;d8c0
	ld hl,FIN_DE_CARGA		;d8c1   ; Se apila 0xD972 como retorno: acabe como acabe, el motor se para ahi
	push hl			;d8c4
	push af			;d8c5
	ld a,007h		;d8c6   ; Registro 7 del PSG
	out (0a0h),a		;d8c8
	ld a,03fh		;d8ca   ; 0x3F: los tres tonos y los tres ruidos, callados
	out (0a1h),a		;d8cc
	ld a,008h		;d8ce   ; Puerto 0xAB en modo poner/quitar bit: bit 4 del puerto C a 0, motor EN MARCHA
	out (0abh),a		;d8d0
	ld a,00eh		;d8d2   ; Y deja el PSG apuntando al registro 14, por donde el MSX oye la cinta
	out (0a0h),a		;d8d4
	pop af			;d8d6
	inc d			;d8d7   ; inc d / ex af,af' / dec d: mete un NO CERO en AF', la marca de "el proximo byte es la bandera"
	ex af,af'			;d8d8
	dec d			;d8d9
	di			;d8da
	ld a,005h		;d8db   ; C lleva el estado del ultimo flanco visto
	ld c,a			;d8dd
	cp a			;d8de   ; cp a: pone el cero y borra el acarreo sin tocar A
BUSCA_CABECERA:		; Vuelve aqui cada vez que se pierde la senal
	call UN_FLANCO		;d8df   ; Primer flanco de la cabecera de tono
	jr nc,BUSCA_CABECERA		;d8e2   ; Aqui el original del Spectrum abandonaba: esta version vuelve a intentarlo
	ld hl,00415h		;d8e4   ; 0x0415 vueltas de 256: hay que oir silencio antes de dar la cabecera por buena
ESPERA_SILENCIO:		; Un rato largo sin mirar la cinta
	djnz ESPERA_SILENCIO		;d8e7   ; Bucle de dos pisos: B por dentro y HL por fuera
	dec hl			;d8e9
	ld a,h			;d8ea
	or l			;d8eb
	jr nz,ESPERA_SILENCIO		;d8ec
	call DOS_FLANCOS		;d8ee
	jr nc,BUSCA_CABECERA		;d8f1
MIDE_CABECERA:		; Cuenta ciclos enteros de la cabecera de tono
	ld b,09ch		;d8f3   ; B arranca en 0x9C: lo que sube durante el ciclo es la medida del tiempo
	call DOS_FLANCOS		;d8f5
	jr nc,BUSCA_CABECERA		;d8f8
	ld a,0c6h		;d8fa   ; Un ciclo mas corto de 0xC6-0x9C no vale como cabecera
	cp b			;d8fc
	jr nc,BUSCA_CABECERA		;d8fd
	inc h			;d8ff   ; Hacen falta 256 ciclos buenos seguidos (H da la vuelta)
	jr nz,MIDE_CABECERA		;d900
BUSCA_SINCRONISMO:		; El medio ciclo corto que separa la cabecera de los datos
	ld b,0c9h		;d902
	call UN_FLANCO		;d904
	jr nc,BUSCA_CABECERA		;d907
	ld a,b			;d909
	cp 0d4h		;d90a   ; Mientras el medio ciclo sea largo (0xD4 o mas), sigue siendo cabecera
	jr nc,BUSCA_SINCRONISMO		;d90c
	call UN_FLANCO		;d90e   ; El otro medio del bit de sincronismo; detras vienen ya los datos
	ret nc			;d911
	ld h,000h		;d912   ; H acumula la paridad: el XOR de bandera, datos y byte final
	ld b,0b0h		;d914   ; 0xB0 es el punto de partida del cronometro de cada medio bit
	jr OCHO_BITS		;d916
GUARDA_O_COMPRUEBA:		; Primer byte: la bandera; los demas, a memoria
	ex af,af'			;d918   ; Recupera la marca de AF': cero quiere decir "ya son datos"
	jr nz,MIRA_LA_BANDERA		;d919
	ld (ix+000h),l		;d91b   ; A memoria. Aqui el original tenia ademas el camino de VERIFICAR, que aqui no esta
	jr SIGUIENTE_BYTE		;d91e
MIRA_LA_BANDERA:		; Compara el primer byte con la bandera que pidio el llamador
	rr c		;d920
	xor l			;d922   ; L trae la bandera leida; A, la que se esperaba
	ret nz			;d923   ; No es el bloque que se buscaba: se sale sin acarreo
	ld a,c			;d924   ; rr c / rla es solo para no perder el acarreo en medio del xor
	rla			;d925
	ld c,a			;d926
	inc de			;d927   ; inc de y dec de: la bandera no cuenta en la longitud
	jr DESCUENTA		;d928
SIGUIENTE_BYTE:		; Avanza el destino
	inc ix		;d92a   ; IX pasa al siguiente hueco de memoria
DESCUENTA:		; Un byte menos, y a por los ocho bits del siguiente
	dec de			;d92c
	ex af,af'			;d92d
	ld b,0b2h		;d92e   ; 0xB2 y 0xB0: los dos puntos de partida del cronometro segun el medio bit
OCHO_BITS:		; L = 1; cuando ese 1 sale por arriba, el byte esta completo
	ld l,001h		;d930   ; L arranca con un 1 que hace de cuentabits
UN_BIT:		; Dos flancos por bit; el tiempo entre ellos dice si es 0 o 1
	call DOS_FLANCOS		;d932
	ret nc			;d935
	ld a,0cbh		;d936   ; 0xCB es el umbral: por debajo el bit es 0, por encima 1
	cp b			;d938
	rl l		;d939   ; El bit entra por la derecha de L y empuja al 1 de arriba
	ld b,0b0h		;d93b
	jp nc,UN_BIT		;d93d
	ld a,h			;d940   ; Cada byte completo entra en la paridad
	xor l			;d941
	ld h,a			;d942
	ld a,d			;d943   ; Y asi hasta que DE llega a cero
	or e			;d944
	jr nz,GUARDA_O_COMPRUEBA		;d945
	ld a,h			;d947
	cp 001h		;d948   ; La paridad de todo tiene que dar 0: entonces el cp deja el acarreo, que es la senal de bien
	ret			;d94a
DOS_FLANCOS:		; Un ciclo entero: dos cambios de nivel seguidos
	call UN_FLANCO		;d94b   ; Si el primero falla, ni se busca el segundo
	ret nc			;d94e
UN_FLANCO:		; Espera a que cambie el nivel de la cinta; B mide cuanto tarda
	ld a,016h		;d94f   ; Retardo de entrada fijo antes de empezar a mirar
RETARDO_FLANCO:		; Cuenta atras sin hacer nada
	dec a			;d951   ; Retardo puro: A vueltas sin mirar la cinta
	jr nz,RETARDO_FLANCO		;d952
	and a			;d954
MUESTREA:		; Lee la cinta hasta que el nivel cambie
	inc b			;d955   ; B es el cronometro; si da la vuelta a cero, se acabo la paciencia
	nop			;d956
	ret z			;d957
	ld a,000h		;d958   ; Ese 0 no sirve para nada: el `in` de abajo pisa A inmediatamente
	in a,(0a2h)		;d95a   ; El PSG quedo en el registro 14: el bit 7 es la entrada del casete
	cpl			;d95c   ; En el MSX la senal llega al reves que en la maquina original
	xor c			;d95d   ; Contra el ultimo nivel: mientras no cambie, se sigue contando
	and 080h		;d95e
	jp z,MUESTREA		;d960
	ld a,c			;d963   ; Cambio: se apunta el nivel nuevo
	cpl			;d964
	ld c,a			;d965
	ld a,r		;d966   ; Los cuatro bits bajos del registro de refresco: un color practicamente al azar
	and 00fh		;d968
	out (099h),a		;d96a   ; Registro 7 del VDP; por eso el borde parpadea mientras carga
	ld a,087h		;d96c
	out (099h),a		;d96e
	scf			;d970   ; Acarreo puesto = flanco encontrado
	ret			;d971
FIN_DE_CARGA:		; El retorno que apila 0xD8C1: para el motor y apaga el parpadeo
	ld e,013h		;d972   ; E no lo mira nadie despues; esta instruccion sobra
	ld a,009h		;d974
	out (0abh),a		;d976   ; Bit 4 del puerto C del PPI a 1: motor del casete PARADO
	ld a,001h		;d978   ; Registro 7 del VDP a 1: se acaba el parpadeo y el borde queda negro
	out (099h),a		;d97a
	ld a,087h		;d97c
	out (099h),a		;d97e
	ret			;d980   ; Y de aqui se vuelve al que llamo a 0xD8C0, con su acarreo intacto
