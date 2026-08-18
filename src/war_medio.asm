; ==========================================================================
; WAR IN MIDDLE EARTH - MSX - bloque medio (0x5E00): el juego
; ==========================================================================
; Generado por tools/mkasm.py a partir del trazado de flujo real.
; Los comentarios provienen de tools/../src/*.notes y estan anclados a
; direccion, de modo que sobreviven a un retrazado.
; ==========================================================================

	org 0x05e00


; ----------------------------------------------------------------------
; Direcciones que solo aparecen como VALOR -en un `ld`, no en
; un salto-: son punteros que el codigo se pasa o numeros que
; casualmente coinciden con una direccion. No hay nada que
; trazar en ellas; el equ existe para que el listado ensamble.
; ----------------------------------------------------------------------
l5fb7h:	equ 0x05fb7
l688dh:	equ 0x0688d
l68e7h:	equ 0x068e7
l8dfah:	equ 0x08dfa

; ======================================================================
; CODIGO 0x5e00..0x5fb8  (440 bytes)
; ======================================================================


L_5E00:
	di			;5e00
	ld sp,05bffh		;5e01
	ld a,0c3h		;5e04
	ld (00038h),a		;5e06
	ld hl,00400h		;5e09
	ld (00039h),hl		;5e0c
	ld hl,00428h		;5e0f
	ld (00415h),hl		;5e12
	ld hl,00200h		;5e15
	xor a			;5e18
	ld b,a			;5e19
L_5E1A:
	push af			;5e1a
	call 0049fh		;5e1b
	ld (hl),a			;5e1e
	inc hl			;5e1f
	pop af			;5e20
	inc a			;5e21
	djnz L_5E1A		;5e22
	ld hl,07f43h		;5e24
	push hl			;5e27
	call L_9366		;5e28
L_5E2B:
	ld hl,0610eh		;5e2b
	call L_8280		;5e2e
L_5E31:
	ld a,(096f0h)		;5e31
	add a,a			;5e34
	add a,0f0h		;5e35
	ld l,a			;5e37
	adc a,05fh		;5e38
	sub l			;5e3a
	ld h,a			;5e3b
	ld e,(hl)			;5e3c
	inc hl			;5e3d
	ld d,(hl)			;5e3e
	ld hl,04865h		;5e3f
	ex de,hl			;5e42
	call L_8280		;5e43
	call L_5F33		;5e46
	call 005b7h		;5e49
	cp 031h		;5e4c
	jr nz,L_5E53		;5e4e
	xor a			;5e50
	jr L_5E61		;5e51
L_5E53:
	cp 032h		;5e53
	jr nz,L_5E5B		;5e55
	ld a,001h		;5e57
	jr L_5E61		;5e59
L_5E5B:
	cp 033h		;5e5b
	jr nz,L_5E66		;5e5d
	ld a,003h		;5e5f
L_5E61:
	ld (096f0h),a		;5e61
	jr L_5E31		;5e64
L_5E66:
	cp 035h		;5e66
	jp z,L_5EBA		;5e68
	cp 036h		;5e6b
	jr nz,L_5E82		;5e6d
	ld a,001h		;5e6f
L_5E71:
	inc a			;5e71
	and 00fh		;5e72
	jr z,L_5E71		;5e74
	ld (05e70h),a		;5e76
	ld hl,061cah		;5e79
	call L_7113		;5e7c
	jp L_5E2B		;5e7f
L_5E82:
	cp 030h		;5e82
	jr nz,L_5E31		;5e84
	ld a,(05e70h)		;5e86
	ld c,a			;5e89
	ld hl,0bd00h		;5e8a
L_5E8D:
	ld a,(hl)			;5e8d
	and 00fh		;5e8e
	cp 005h		;5e90
	jr nz,L_5E9D		;5e92
	ld h,0c1h		;5e94
	ld a,(hl)			;5e96
	and 0f0h		;5e97
	or c			;5e99
	ld (hl),a			;5e9a
	ld h,0bdh		;5e9b
L_5E9D:
	inc l			;5e9d
	jr nz,L_5E8D		;5e9e
	ret			;5ea0
L_5EA1:
	ld hl,060cdh		;5ea1
	ld b,01eh		;5ea4
L_5EA6:
	ld (hl),020h		;5ea6
	inc hl			;5ea8
	djnz L_5EA6		;5ea9
	ret			;5eab
L_5EAC:
	ld de,l5fb7h		;5eac
L_5EAF:
	inc de			;5eaf
	dec c			;5eb0
	ret z			;5eb1
L_5EB2:
	ld a,(de)			;5eb2
	or a			;5eb3
	jp p,L_5EAF		;5eb4
	inc de			;5eb7
	jr L_5EB2		;5eb8
L_5EBA:
	ld a,002h		;5eba
	ld (05edbh),a		;5ebc
	ld bc,060ceh		;5ebf
	ld (05f10h),bc		;5ec2
	call L_5EA1		;5ec6
	ld hl,06067h		;5ec9
	call L_8280		;5ecc
	ld hl,006e5h		;5ecf
L_5ED2:
	push hl			;5ed2
	call 00667h		;5ed3
	call 005b7h		;5ed6
	pop hl			;5ed9
	ld b,000h		;5eda
	ld ix,06008h		;5edc
L_5EE0:
	cp (ix+000h)		;5ee0
	jr z,L_5ED2		;5ee3
	inc ix		;5ee5
	djnz L_5EE0		;5ee7
	ld (hl),d			;5ee9
	inc hl			;5eea
	ld (hl),e			;5eeb
	inc hl			;5eec
	push hl			;5eed
	ld (ix+000h),a		;5eee
	call L_5F0B		;5ef1
	pop hl			;5ef4
	ld ix,05edbh		;5ef5
	inc (ix+000h)		;5ef9
	ld a,(ix+000h)		;5efc
	cp 007h		;5eff
	jr nz,L_5ED2		;5f01
	call 00667h		;5f03
	ld a,003h		;5f06
	jp L_5E61		;5f08
L_5F0B:
	ld c,a			;5f0b
	call 00627h		;5f0c
	ld bc,00000h		;5f0f
	call 00659h		;5f12
	ld hl,(05f10h)		;5f15
	ld bc,00006h		;5f18
	add hl,bc			;5f1b
	ld (05f10h),hl		;5f1c
	ld hl,06067h		;5f1f
	jp L_8280		;5f22
L_5F25:
	ld a,(de)			;5f25
	or a			;5f26
	jp p,L_5F31		;5f27
	and 07fh		;5f2a
	ld (bc),a			;5f2c
	inc de			;5f2d
	inc bc			;5f2e
L_5F2F:
	jr L_5F2F		;5f2f
L_5F31:
	ld (bc),a			;5f31
	ret			;5f32
L_5F33:
	call L_5EA1		;5f33
	ld hl,0600ah		;5f36
	ld c,(hl)			;5f39
	call 00627h		;5f3a
	ld bc,060ceh		;5f3d
	call 00659h		;5f40
	inc hl			;5f43
	ld c,(hl)			;5f44
	call 00627h		;5f45
	ld bc,060d4h		;5f48
	call 00659h		;5f4b
	inc hl			;5f4e
	ld c,(hl)			;5f4f
	call 00627h		;5f50
	ld bc,060dah		;5f53
	call 00659h		;5f56
	inc hl			;5f59
	ld c,(hl)			;5f5a
	call 00627h		;5f5b
	ld bc,060e0h		;5f5e
	call 00659h		;5f61
	inc hl			;5f64
	ld c,(hl)			;5f65
	call 00627h		;5f66
	ld bc,060e6h		;5f69
	call 00659h		;5f6c
	ld hl,06067h		;5f6f
	jp L_8280		;5f72
L_5F75:
	xor a			;5f75
	in a,(0feh)		;5f76
	cpl			;5f78
	and 01fh		;5f79
L_5F7B:
	jr nz,L_5F7B		;5f7b
	ret			;5f7d
L_5F7E:
	push hl			;5f7e
	push bc			;5f7f
L_5F80:
	call 00667h		;5f80
	inc d			;5f83
	jr nz,L_5F80		;5f84
L_5F86:
	call L_5F98		;5f86
	jr nz,L_5F86		;5f89
	inc d			;5f8b
	jr z,L_5F86		;5f8c
	push de			;5f8e
	xor a			;5f8f
	call L_65FF		;5f90
	pop de			;5f93
	ld a,d			;5f94
	pop bc			;5f95
	pop hl			;5f96
	ret			;5f97
L_5F98:
	ld de,0ff2fh		;5f98
	ld bc,0fefeh		;5f9b
L_5F9E:
	in a,(c)		;5f9e
	cpl			;5fa0
	and 01fh		;5fa1
	jr z,L_5FB1		;5fa3
	inc d			;5fa5
	ret nz			;5fa6
	ld h,a			;5fa7
	ld a,e			;5fa8
L_5FA9:
	sub 008h		;5fa9
	srl h		;5fab
	jr nc,L_5FA9		;5fad
	ret nz			;5faf
	ld d,a			;5fb0
L_5FB1:
	dec e			;5fb1
	rlc b		;5fb2
	jr c,L_5F9E		;5fb4
	cp a			;5fb6
L_5FB7:
	ret			;5fb7

; ----------------------------------------------------------------------
; DATOS nombres_de_tecla_spectrum: Nombres de tecla en el orden de la matriz
;   del Spectrum, con codigos >=0x80 para las teclas especiales (ld de,0x5FB7
;   en 0x5EAC, que empieza con inc de; ld hl,0x5FBD en 0x708A)
;   0x5fb8..0x5ff0  (56 bytes)
DATA_nombres_de_tecla_spectrum:
	defb 042h,048h,059h,036h,035h,054h,047h,056h,04eh,04ah,055h,037h,034h,052h,046h,043h	; 5fb8  BHY65TGVNJU74RFC
	defb 04dh,04bh,049h,038h,033h,045h,044h,058h,0d3h,0d9h,04dh,04ch,04fh,039h,032h,057h	; 5fc8  MKI83EDX..MLO92W
	defb 053h,05ah,0d3h,0d0h,043h,0c5h,0ceh,054h,050h,030h,031h,051h,041h,0c3h,0c1h,050h	; 5fd8  SZ..C..TP01QA..P
	defb 0f8h,05fh,0fah,05fh,001h,060h,008h,060h	; 5fe8  ._._.`.`

; ----------------------------------------------------------------------
; DATOS punteros_de_control_actual: Punteros a los cuatro rotulos de "Control
;   Actual" (0x5E31 indexa con (0x96F0)*2)
;   0x5ff0..0x5ff8  (8 bytes)
DATA_punteros_de_control_actual:
	defw 0600fh	; 5ff0  -> DATA_textos_del_menu
	defw 06025h	; 5ff2
	defw 0603bh	; 5ff4
	defw 06051h	; 5ff6

; ----------------------------------------------------------------------
; DATOS tabla_de_teclas_definidas: Tabla de la lectura de teclas definidas (ld
;   hl,0x600A en 0x5F36)
;   0x5ff8..0x6008  (16 bytes)
DATA_tabla_de_teclas_definidas:
	defb 031h,052h,031h,052h,018h,015h,016h,017h,011h,00eh,025h,01ch,014h,004h,00ch,024h	; 5ff8  1R1R......%....$

; ----------------------------------------------------------------------
; DATOS teclas_definidas: Las cinco teclas definidas: "1RQAOP" y un byte (ld
;   ix,0x6008 en 0x5EDC; ld hl,0x6010 en 0x9144)
;   0x6008..0x600f  (7 bytes)
DATA_teclas_definidas:
	defb 031h,052h,051h,041h,04fh,050h,011h	; 6008

; ----------------------------------------------------------------------
; DATOS textos_del_menu: Textos del menu: rotulos de control, "Las Teclas
;   Actuales Son", "War In Middle Earth / 1. Usa Joystick ... 0. Empieza
;   Juego", "Pausa/Abandona - 1 / Menu - R", creditos "Programado por
;   C.J.Pink. Conversion por ANIMAGIC" y la frase en ingles
;   0x600f..0x62ff  (752 bytes)
DATA_textos_del_menu:
	defb 021h,020h,04ah,06fh,079h,073h,074h,069h,063h,06bh,020h,053h,074h,061h,06eh,064h	; 600f  ! Joystick Stand
	defb 061h,072h,064h,020h,021h,000h,021h,020h,054h,065h,063h,06ch,061h,073h,020h,044h	; 601f  ard !.! Teclas D
	defb 065h,06ch,020h,043h,075h,072h,073h,06fh,072h,020h,021h,000h,021h,020h,020h,020h	; 602f  el Cursor !.!   
	defb 049h,06eh,074h,065h,072h,066h,061h,063h,065h,020h,054h,077h,06fh,020h,020h,020h	; 603f  Interface Two   
	defb 021h,000h,021h,020h,054h,065h,063h,06ch,061h,064h,06fh,020h,044h,065h,066h,069h	; 604f  !.! Teclado Defi
	defb 06eh,069h,064h,06fh,020h,020h,021h,000h,0d0h,060h,023h,022h,022h,022h,022h,022h	; 605f  nido  !..`#"""""
	defb 022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h	; 606f  """"""""""""""""
	defb 022h,022h,022h,022h,022h,022h,022h,022h,022h,023h,0b7h,021h,020h,020h,020h,04ch	; 607f  """""""""#.!   L
	defb 061h,073h,020h,054h,065h,063h,06ch,061h,073h,020h,041h,063h,074h,075h,061h,06ch	; 608f  as Teclas Actual
	defb 065h,073h,020h,053h,06fh,06eh,03ah,020h,020h,020h,021h,0b7h,021h,02dh,041h,052h	; 609f  es Son:   !.!-AR
	defb 052h,049h,02dh,020h,041h,042h,041h,04ah,02dh,020h,049h,05ah,044h,041h,02dh,020h	; 60af  RI- ABAJ- IZDA- 
	defb 044h,043h,048h,041h,02dh,046h,055h,045h,047h,04fh,02dh,021h,0b7h,021h,020h,020h	; 60bf  DCHA-FUEGO-!.!  
	defb 020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h	; 60cf                  
	defb 020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,021h,0b7h,023h,022h	; 60df              !.#"
	defb 022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h	; 60ef  """"""""""""""""
	defb 022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,023h,000h,0c0h	; 60ff  """""""""""""#..
	defb 005h,023h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h	; 610f  .#""""""""""""""
	defb 022h,022h,022h,022h,022h,023h,0b7h,021h,057h,061h,072h,020h,049h,06eh,020h,04dh	; 611f  """""#.!War In M
	defb 069h,064h,064h,06ch,065h,020h,045h,061h,072h,074h,068h,021h,0b7h,023h,022h,022h	; 612f  iddle Earth!.#""
	defb 022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h	; 613f  """"""""""""""""
	defb 022h,023h,0b7h,021h,031h,02eh,020h,055h,073h,061h,020h,04ah,06fh,079h,073h,074h	; 614f  "#.!1. Usa Joyst
	defb 069h,063h,06bh,020h,020h,020h,020h,021h,0b7h,021h,032h,02eh,020h,055h,073h,061h	; 615f  ick    !.!2. Usa
	defb 020h,043h,075h,072h,073h,06fh,072h,065h,073h,020h,020h,020h,020h,021h,0b7h,021h	; 616f   Cursores    !.!
	defb 033h,02eh,020h,055h,073h,061h,020h,054h,065h,063h,06ch,061h,064h,06fh,020h,020h	; 617f  3. Usa Teclado  
	defb 020h,020h,020h,021h,0b7h,021h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h	; 618f     !.!          
	defb 020h,020h,020h,020h,020h,020h,020h,020h,020h,021h,0b7h,021h,035h,02eh,020h,044h	; 619f           !.!5. D
	defb 065h,066h,069h,06eh,065h,020h,054h,065h,063h,06ch,061h,073h,020h,020h,020h,021h	; 61af  efine Teclas   !
	defb 0b7h,021h,036h,02eh,020h,04eh,069h,076h,065h,06ch,020h,030h,030h,031h,020h,020h	; 61bf  .!6. Nivel 001  
	defb 020h,020h,020h,020h,020h,021h,0b7h,021h,030h,02eh,020h,045h,06dh,070h,069h,065h	; 61cf       !.!0. Empie
	defb 07ah,061h,020h,04ah,075h,065h,067h,06fh,020h,020h,020h,021h,0b7h,021h,020h,043h	; 61df  za Juego   !.! C
	defb 06fh,06eh,074h,072h,06fh,06ch,020h,041h,063h,074h,075h,061h,06ch,03ah,020h,020h	; 61ef  ontrol Actual:  
	defb 020h,021h,0b7h,0b7h,023h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h	; 61ff   !..#"""""""""""
	defb 022h,022h,022h,022h,022h,022h,022h,022h,023h,0b7h,021h,050h,061h,075h,073h,061h	; 620f  """"""""#.!Pausa
	defb 02fh,041h,062h,061h,06eh,064h,06fh,06eh,061h,02dh,020h,020h,031h,020h,021h,0b7h	; 621f  /Abandona-  1 !.
	defb 021h,04dh,065h,06eh,075h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,02dh	; 622f  !Menu          -
	defb 020h,020h,052h,020h,021h,0b7h,023h,022h,022h,022h,022h,022h,022h,022h,022h,022h	; 623f    R !.#"""""""""
	defb 022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,023h,000h,050h,072h,06fh,067h	; 624f  """"""""""#.Prog
	defb 072h,061h,06dh,061h,064h,06fh,020h,070h,06fh,072h,020h,043h,02eh,04ah,02eh,050h	; 625f  ramado por C.J.P
	defb 069h,06eh,06bh,02eh,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h	; 626f  ink.            
	defb 020h,020h,020h,020h,043h,06fh,06eh,076h,065h,072h,073h,069h,06fh,06eh,020h,070h	; 627f      Conversion p
	defb 06fh,072h,020h,041h,04eh,049h,04dh,041h,047h,049h,043h,020h,020h,020h,020h,020h	; 628f  or ANIMAGIC     
	defb 020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,059h,06fh,075h,072h	; 629f              Your
	defb 020h,06fh,06eh,06ch,079h,020h,061h,073h,020h,067h,06fh,06fh,064h,020h,061h,073h	; 62af   only as good as
	defb 020h,074h,068h,065h,020h,06ch,061h,073h,074h,020h,067h,072h,065h,061h,074h,020h	; 62bf   the last great 
	defb 074h,068h,069h,06eh,067h,020h,079h,06fh,075h,020h,064h,069h,064h,02ch,020h,077h	; 62cf  thing you did, w
	defb 068h,065h,072h,065h,020h,068h,061h,076h,065h,020h,079h,06fh,075h,020h,062h,065h	; 62df  here have you be
	defb 065h,06eh,020h,073h,069h,06eh,063h,065h,020h,074h,068h,065h,06eh,000h,000h,000h	; 62ef  en since then...

; ----------------------------------------------------------------------
; DATOS dibujo_del_cursor: Dibujo de 24 bytes de la marca del cursor (ld
;   de,0x62FF en 0x64DC: 8 columnas de 3)
;   0x62ff..0x6317  (24 bytes)
DATA_dibujo_del_cursor:
	defb 0adh,0adh,0adh	; 62ff
	defb 0adh,0adh,0adh	; 6302
	defb 0adh,0adh,0adh	; 6305
	defb 0adh,0adh,0adh	; 6308
	defb 0adh,0adh,0adh	; 630b
	defb 0adh,0adh,0adh	; 630e
	defb 0adh,0adh,0adh	; 6311
	defb 0adh,0adh,0adh	; 6314

; ----------------------------------------------------------------------
; DATOS tabla_6317: Tabla que leen 0x6593-0x659C (formato pendiente)
;   0x6317..0x63fb  (228 bytes)
DATA_tabla_6317:
	defb 0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh	; 6317  ................
	defb 0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,02dh,000h,000h,008h	; 6327  ............-...
	defb 004h,00ch,002h,00ah,006h,00eh,001h,009h,005h,00dh,003h,00bh,007h,00fh,03ch,070h	; 6337  ..............<p
	defb 043h,09eh,060h,051h,0e0h,07eh,0c0h,090h,0c7h,060h,099h,0c0h,0e0h,000h,0c3h,08fh	; 6347  C.`Q.~...`......
	defb 080h,001h,080h,000h,000h,001h,000h,00fh,000h,01fh,006h,03fh,01fh,0ffh,06fh,063h	; 6357  ...........?..oc
	defb 084h,063h,099h,063h,0aeh,063h,0c3h,063h,02dh,000h,005h,000h,002h,000h,001h,000h	; 6367  .c.c.c.c-.......
	defb 001h,000h,001h,000h,001h,000h,001h,000h,001h,000h,001h,000h,001h,00ch,000h,003h	; 6377  ................
	defb 000h,00ch,000h,000h,000h,002h,000h,000h,000h,000h,000h,00ch,000h,038h,000h,022h	; 6387  .............8."
	defb 000h,064h,028h,000h,021h,000h,003h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 6397  .d(.!...........
	defb 000h,000h,000h,000h,000h,000h,005h,046h,000h,02dh,000h,001h,000h,003h,000h,003h	; 63a7  .......F.-......
	defb 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,00fh,064h,000h,002h,000h	; 63b7  ............d...
	defb 003h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 63c7  ................
	defb 028h,0d0h,0e0h,020h,045h,06ch,065h,067h,069h,072h,03ah,020h,041h,072h,072h,069h	; 63d7  (.. Elegir: Arri
	defb 062h,061h,02ch,020h,041h,062h,061h,06ah,06fh,020h,079h,020h,046h,075h,065h,067h	; 63e7  ba, Abajo y Fueg
	defb 06fh,02eh,020h,000h	; 63f7

; ======================================================================
; CODIGO 0x63fb..0x64da  (223 bytes)
; ======================================================================


L_63FB:
	ld hl,0fedch		;63fb
	ld a,h			;63fe
	rra			;63ff
	xor l			;6400
	rra			;6401
	rr h		;6402
	rr l		;6404
	ld (063fch),hl		;6406
	ret			;6409
L_640A:
	ld (064c5h),a		;640a
	ld de,00020h		;640d
	ld (064c2h),de		;6410
	ld a,(hl)			;6414
	ld (06496h),a		;6415
	jr L_642A		;6418
L_641A:
	xor a			;641a
	ld (064c5h),a		;641b
	ld de,00040h		;641e
	ld (064c2h),de		;6421
	ld a,(hl)			;6425
	ld (06496h),a		;6426
	add a,a			;6429
L_642A:
	call 006efh		;642a
	ld c,a			;642d
	ld a,016h		;642e
	sub c			;6430
	rra			;6431
	inc hl			;6432
	ld b,a			;6433
	ld a,(hl)			;6434
	ld (L_64CD+1),a		;6435
	ld c,a			;6438
	inc hl			;6439
	push hl			;643a
	ld a,020h		;643b
	sub c			;643d
	srl a		;643e
	ld c,a			;6440
	ld a,b			;6441
	and 0f8h		;6442
	add a,040h		;6444
	ld h,a			;6446
	ld a,b			;6447
	and 007h		;6448
	rrca			;644a
	rrca			;644b
	rrca			;644c
	add a,c			;644d
	ld l,a			;644e
	ld (0827eh),hl		;644f
	ld a,h			;6452
	rrca			;6453
	rrca			;6454
	rrca			;6455
	and 003h		;6456
	or 058h		;6458
	ld h,a			;645a
	ld (L_64BE+1),hl		;645b
	call L_7599		;645e
	call L_7F10		;6461
	pop hl			;6464
	ld a,006h		;6465
	ld (082f6h),a		;6467
	call L_827D		;646a
	ld hl,063d8h		;646d
	call L_827D		;6470
	ld a,047h		;6473
	call L_64BE		;6475
L_6478:
	ld a,004h		;6478
	call L_65FF		;647a
L_647D:
	call 0066dh		;647d
	and a			;6480
	jr z,L_647D		;6481
	ld b,a			;6483
	ld a,(064c5h)		;6484
	bit 0,b		;6487
	jr z,L_6491		;6489
	and a			;648b
	jr z,L_6478		;648c
	dec a			;648e
	jr L_649A		;648f
L_6491:
	bit 1,b		;6491
	jr z,L_64AC		;6493
	cp 000h		;6495
	jr nc,L_6478		;6497
	inc a			;6499
L_649A:
	ld c,a			;649a
	ld a,006h		;649b
	call L_64BE		;649d
	ld a,c			;64a0
	ld (064c5h),a		;64a1
	ld a,047h		;64a4
	call L_64BE		;64a6
	jp L_6478		;64a9
L_64AC:
	bit 4,b		;64ac
	jr z,L_64B2		;64ae
	jr L_64B8		;64b0
L_64B2:
	bit 5,b		;64b2
	jp z,L_6478		;64b4
	xor a			;64b7
L_64B8:
	push af			;64b8
	call L_7599		;64b9
	pop af			;64bc
	ret			;64bd
L_64BE:
	ld hl,00000h		;64be
	ld de,00000h		;64c1
	ld b,000h		;64c4
	inc b			;64c6
	dec b			;64c7
	jr z,L_64CD		;64c8
L_64CA:
	add hl,de			;64ca
	djnz L_64CA		;64cb
L_64CD:
	ld b,000h		;64cd
L_64CF:
	ld (hl),a			;64cf
	inc hl			;64d0
	djnz L_64CF		;64d1
	push bc			;64d3
	call 00604h		;64d4
	pop bc			;64d7
	ret			;64d8
L_64D9:
	ret			;64d9

; ----------------------------------------------------------------------
; DATOS dos_nop_64da: Dos nop tras el ret-interruptor de 0x64D9 (que 0x65FB
;   convierte en ld hl,0x0000)
;   0x64da..0x64dc  (2 bytes)
DATA_dos_nop_64da:
	defb 000h,000h	; 64da

; ======================================================================
; CODIGO 0x64dc..0x6712  (566 bytes)
; ======================================================================


L_64DC:
	ld de,062ffh		;64dc
	ld c,008h		;64df
L_64E1:
	ld b,003h		;64e1
	ld a,h			;64e3
	cp 058h		;64e4
	jr nc,L_6507		;64e6
	push hl			;64e8
L_64E9:
	ld a,(de)			;64e9
	ld (hl),a			;64ea
	inc hl			;64eb
	inc de			;64ec
	djnz L_64E9		;64ed
	pop hl			;64ef
	inc h			;64f0
	ld a,h			;64f1
	and 007h		;64f2
	jr nz,L_6504		;64f4
	ld a,h			;64f6
	sub 008h		;64f7
	ld h,a			;64f9
	ld a,l			;64fa
	add a,020h		;64fb
	ld l,a			;64fd
	jr nc,L_6504		;64fe
	ld a,008h		;6500
	add a,h			;6502
	ld h,a			;6503
L_6504:
	dec c			;6504
	jr nz,L_64E1		;6505
L_6507:
	ld a,0c9h		;6507
	ld (064d9h),a		;6509
	ret			;650c
L_650D:
	call 0066dh		;650d
	ld a,000h		;6510
	ld d,a			;6512
	ld hl,0b8e8h		;6513
	ld a,(06544h)		;6516
	rr d		;6519
	jr nc,L_6521		;651b
	or a			;651d
	jr z,L_6521		;651e
	dec a			;6520
L_6521:
	rr d		;6521
	jr nc,L_652A		;6523
	inc a			;6525
	cp h			;6526
	jr c,L_652A		;6527
	ld a,h			;6529
L_652A:
	ld h,a			;652a
	ld a,(06543h)		;652b
	rr d		;652e
	jr nc,L_6536		;6530
	or a			;6532
	jr z,L_6536		;6533
	dec a			;6535
L_6536:
	rr d		;6536
	jr nc,L_653E		;6538
	cp l			;653a
	jr nc,L_653E		;653b
	inc a			;653d
L_653E:
	ld l,a			;653e
	ld (06543h),hl		;653f
	ld de,03a2ah		;6542
	ld hl,00000h		;6545
	or a			;6548
	sbc hl,de		;6549
	ret z			;654b
	ld (06546h),de		;654c
	push de			;6550
	call L_64D9		;6551
	pop de			;6554
	ld a,d			;6555
	and 0c0h		;6556
	rra			;6558
	scf			;6559
	rra			;655a
	rrca			;655b
	xor d			;655c
	and 0f8h		;655d
	xor d			;655f
	ld h,a			;6560
	ld a,e			;6561
	rlca			;6562
	rlca			;6563
	rlca			;6564
	xor d			;6565
	and 0c7h		;6566
	xor d			;6568
	rlca			;6569
	rlca			;656a
	ld l,a			;656b
	ld a,e			;656c
	and 007h		;656d
	ld (0659fh),a		;656f
	ld (064dah),hl		;6572
	push hl			;6575
	pop iy		;6576
	ld hl,(06543h)		;6578
	ld ix,06345h		;657b
	exx			;657f
	ld hl,062ffh		;6580
	ld de,00002h		;6583
	ld b,008h		;6586
L_6588:
	exx			;6588
	defb 0fdh,07ch	;ld a,iyh		;6589
	cp 058h		;658b
	jr nc,L_65F9		;658d
	ld hl,0ff00h		;658f
	ld b,(ix+000h)		;6592
	ld c,(ix+001h)		;6595
	ld e,(ix+010h)		;6598
	ld d,(ix+011h)		;659b
	ld a,000h		;659e
	or a			;65a0
	jr z,L_65B4		;65a1
L_65A3:
	or a			;65a3
	rr b		;65a4
	rr c		;65a6
	rr l		;65a8
	scf			;65aa
	rr e		;65ab
	rr d		;65ad
	rr h		;65af
	dec a			;65b1
	jr nz,L_65A3		;65b2
L_65B4:
	ld a,(iy+000h)		;65b4
	exx			;65b7
	ld (hl),a			;65b8
	inc hl			;65b9
	exx			;65ba
	and e			;65bb
	or b			;65bc
	ld (iy+000h),a		;65bd
	ld a,(iy+001h)		;65c0
	exx			;65c3
	ld (hl),a			;65c4
	inc hl			;65c5
	exx			;65c6
	and d			;65c7
	or c			;65c8
	ld (iy+001h),a		;65c9
	ld a,(iy+002h)		;65cc
	exx			;65cf
	ld (hl),a			;65d0
	inc hl			;65d1
	exx			;65d2
	and h			;65d3
	or l			;65d4
	ld (iy+002h),a		;65d5
	defb 0fdh,024h	;inc iyh		;65d8
	defb 0fdh,07ch	;ld a,iyh		;65da
	ld c,a			;65dc
	and 007h		;65dd
	jr nz,L_65F4		;65df
	ld a,c			;65e1
	sub 008h		;65e2
	defb 0fdh,067h	;ld iyh,a		;65e4
	defb 0fdh,07dh	;ld a,iyl		;65e6
	add a,020h		;65e8
	defb 0fdh,06fh	;ld iyl,a		;65ea
	jr nc,L_65F4		;65ec
	ld a,008h		;65ee
	defb 0fdh,084h	;add a,iyh		;65f0
	defb 0fdh,067h	;ld iyh,a		;65f2
L_65F4:
	exx			;65f4
	add ix,de		;65f5
	djnz L_6588		;65f7
L_65F9:
	ld a,021h		;65f9
	ld (064d9h),a		;65fb
	ret			;65fe
L_65FF:
	ret			;65ff
L_6600:
	add a,a			;6600
	add a,065h		;6601
	ld l,a			;6603
	adc a,063h		;6604
	sub l			;6606
	ld h,a			;6607
	ld a,(hl)			;6608
	inc hl			;6609
	ld h,(hl)			;660a
	ld l,a			;660b
	call L_6714		;660c
	ld (L_667F+1),de		;660f
	call L_6714		;6613
	ld (066bah),de		;6616
	call L_6714		;661a
	ld (L_66AD+1),de		;661d
	call L_6714		;6621
	ld (L_66E6+1),de		;6624
	call L_6714		;6628
	ld (06683h),de		;662b
	call L_6714		;662f
	ld (066bdh),de		;6632
	call L_6714		;6636
	ld (066c6h),de		;6639
	call L_6714		;663d
	ld (L_6705+1),de		;6640
	call L_6714		;6644
	ld (0668ch),de		;6647
	call L_6714		;664b
	ld (L_66F8+1),de		;664e
	ld a,(hl)			;6652
L_6653:
	push af			;6653
	ld hl,(L_667F+1)		;6654
	ld a,h			;6657
	or l			;6658
	jr z,L_667F		;6659
	ld bc,(066bah)		;665b
	ld a,b			;665f
	or c			;6660
	jr z,L_667F		;6661
	ld (0667ah),hl		;6663
	xor a			;6666
	ex af,af'			;6667
L_6668:
	ex af,af'			;6668
	out (0feh),a		;6669
	xor 010h		;666b
	ex af,af'			;666d
L_666E:
	dec hl			;666e
	ld a,l			;666f
	or h			;6670
	jp nz,L_666E		;6671
	dec bc			;6674
	ld a,c			;6675
	or b			;6676
	jr z,L_667F		;6677
	ld hl,00000h		;6679
	jp L_6668		;667c
L_667F:
	ld hl,00000h		;667f
	ld de,00000h		;6682
	add hl,de			;6685
	ld a,000h		;6686
	or a			;6688
	jr z,L_66F8		;6689
	ld de,00000h		;668b
	sbc hl,de		;668e
	add hl,de			;6690
	jr c,L_66AD		;6691
	ld c,000h		;6693
L_6695:
	ld hl,(L_667F+1)		;6695
	ld de,(06683h)		;6698
	ld a,0ffh		;669c
	xor d			;669e
	ld d,a			;669f
	ld a,0ffh		;66a0
	xor e			;66a2
	ld e,a			;66a3
	inc de			;66a4
	ld (06683h),de		;66a5
	ld a,c			;66a9
	ld (06687h),a		;66aa
L_66AD:
	ld de,00000h		;66ad
	ld a,h			;66b0
	xor d			;66b1
	ld h,a			;66b2
	ld a,l			;66b3
	xor e			;66b4
	ld l,a			;66b5
	ld (L_667F+1),hl		;66b6
	ld hl,00000h		;66b9
	ld de,00000h		;66bc
	add hl,de			;66bf
	ld a,000h		;66c0
	or a			;66c2
	jr z,L_6705		;66c3
	ld de,00000h		;66c5
	sbc hl,de		;66c8
	jr c,L_66E6		;66ca
	ld c,000h		;66cc
L_66CE:
	ld hl,(066bah)		;66ce
	ld de,(066bdh)		;66d1
	ld a,0ffh		;66d5
	xor d			;66d7
	ld d,a			;66d8
	ld a,0ffh		;66d9
	xor e			;66db
	ld e,a			;66dc
	inc de			;66dd
	ld (066bdh),de		;66de
	ld a,c			;66e2
	ld (066c1h),a		;66e3
L_66E6:
	ld de,00000h		;66e6
	ld a,h			;66e9
	xor d			;66ea
	ld h,a			;66eb
	ld a,l			;66ec
	xor e			;66ed
	ld l,a			;66ee
	ld (066bah),hl		;66ef
	pop af			;66f2
	dec a			;66f3
	jp nz,L_6653		;66f4
	ret			;66f7
L_66F8:
	ld de,00000h		;66f8
	sbc hl,de		;66fb
	add hl,de			;66fd
	jr nc,L_66AD		;66fe
	ld c,000h		;6700
	jp L_6695		;6702
L_6705:
	ld de,00000h		;6705
	sbc hl,de		;6708
	add hl,de			;670a
	jr nc,L_66E6		;670b
	ld c,000h		;670d
	jp L_66CE		;670f

; ----------------------------------------------------------------------
; DATOS cola_del_motor_de_sonido: Pop af / ret al que no llega nadie: cola del
;   motor de sonido del Spectrum
;   0x6712..0x6714  (2 bytes)
DATA_cola_del_motor_de_sonido:
	defb 0f1h,0c9h	; 6712

; ======================================================================
; CODIGO 0x6714..0x6af5  (993 bytes)
; ======================================================================


L_6714:
	ld e,(hl)			;6714
	inc hl			;6715
	ld d,(hl)			;6716
	inc hl			;6717
	ret			;6718
L_6719:
	ld a,0ffh		;6719
	inc a			;671b
	ld (0671ah),a		;671c
	ld l,a			;671f
	push af			;6720
	jr nz,L_6728		;6721
	push hl			;6723
	call L_6AAF		;6724
	pop hl			;6727
L_6728:
	ld h,0bdh		;6728
	ld a,(hl)			;672a
	and 00fh		;672b
	add a,a			;672d
	add a,a			;672e
	add a,a			;672f
	add a,a			;6730
	add a,047h		;6731
	ld l,a			;6733
	adc a,06dh		;6734
	sub l			;6736
	ld h,a			;6737
	ld de,06d37h		;6738
	ld bc,00010h		;673b
	ldir		;673e
	pop af			;6740
	ld l,a			;6741
	ld h,0c6h		;6742
	ld a,(hl)			;6744
	bit 6,a		;6745
	jr nz,L_6759		;6747
	or a			;6749
	jp m,L_6945		;674a
	dec (hl)			;674d
	jr nz,L_679B		;674e
	ld h,0c2h		;6750
	dec (hl)			;6752
	ld a,(hl)			;6753
	cp 00bh		;6754
	jp c,L_6951		;6756
L_6759:
	ld a,l			;6759
	call L_6956		;675a
	ld a,(hl)			;675d
	dec h			;675e
	ld l,(hl)			;675f
	ld h,a			;6760
	or l			;6761
	ret z			;6762
	call L_67A5		;6763
	push hl			;6766
	res 7,h		;6767
	res 7,l		;6769
	ld (06777h),hl		;676b
	pop hl			;676e
	ld a,h			;676f
	or l			;6770
	call nz,L_67B0		;6771
	ld d,h			;6774
	ld e,l			;6775
	ld hl,00000h		;6776
	ld a,l			;6779
	and 07fh		;677a
	sub e			;677c
	jr nc,L_6780		;677d
	cpl			;677f
L_6780:
	cp 002h		;6780
	jr nc,L_678F		;6782
	ld a,h			;6784
	and 07fh		;6785
	sub d			;6787
	jr nc,L_678B		;6788
	cpl			;678a
L_678B:
	cp 002h		;678b
	jr c,L_6791		;678d
L_678F:
	ld d,h			;678f
	ld e,l			;6790
L_6791:
	ld a,(0671ah)		;6791
	ld l,a			;6794
	ld h,0b9h		;6795
	ld (hl),e			;6797
	inc h			;6798
	ld (hl),d			;6799
	ret			;679a
L_679B:
	ld a,l			;679b
	call L_6956		;679c
	ld a,(hl)			;679f
	dec h			;67a0
	ld l,(hl)			;67a1
	ld h,a			;67a2
	or l			;67a3
	ret z			;67a4
L_67A5:
	ld (08f78h),hl		;67a5
	push hl			;67a8
	push de			;67a9
	call L_8F70		;67aa
	pop de			;67ad
	pop hl			;67ae
	ret			;67af
L_67B0:
	ld c,000h		;67b0
	ld a,h			;67b2
	or a			;67b3
	jp p,L_67C5		;67b4
	and 07fh		;67b7
	ld h,a			;67b9
	ld c,002h		;67ba
	ld a,l			;67bc
	or a			;67bd
	jp p,L_67C5		;67be
	inc c			;67c1
	and 07fh		;67c2
	ld l,a			;67c4
L_67C5:
	ld a,c			;67c5
	or a			;67c6
	push af			;67c7
	ld (067dah),hl		;67c8
	ld (067d7h),de		;67cb
	call L_8108		;67cf
	pop af			;67d2
	jp nz,L_68BD		;67d3
	ld de,00000h		;67d6
	ld hl,00000h		;67d9
	ld a,l			;67dc
	ld iy,06b34h		;67dd
	cp e			;67e1
	ld a,h			;67e2
	jr z,L_67F3		;67e3
	jr nc,L_67FF		;67e5
	ld c,002h		;67e7
	cp d			;67e9
	jr z,L_6809		;67ea
	inc c			;67ec
	jr c,L_6809		;67ed
	ld c,001h		;67ef
	jr L_6809		;67f1
L_67F3:
	cp d			;67f3
	jp z,L_6A0D		;67f4
	ld c,004h		;67f7
	jr c,L_6809		;67f9
	ld c,000h		;67fb
	jr L_6809		;67fd
L_67FF:
	ld c,006h		;67ff
	cp d			;6801
	jr z,L_6809		;6802
	inc c			;6804
	jr nc,L_6809		;6805
	ld c,005h		;6807
L_6809:
	ld b,003h		;6809
	ld a,c			;680b
	ld (06864h),a		;680c
L_680F:
	call L_63FB		;680f
	and 00fh		;6812
	add a,023h		;6814
	ld l,a			;6816
	adc a,06bh		;6817
	sub l			;6819
	ld h,a			;681a
	ld a,(hl)			;681b
	add a,c			;681c
	ld (06822h),a		;681d
	ld a,(iy+000h)		;6820
	call L_68AB		;6823
	jp p,L_691F		;6826
	djnz L_680F		;6829
	push ix		;682b
	ld iy,06b34h		;682d
	ld a,03ch		;6831
	call L_686E		;6833
	ld a,e			;6836
	ld (06844h),a		;6837
	pop ix		;683a
	ld a,03dh		;683c
	call L_686E		;683e
	ld d,000h		;6841
	ld a,000h		;6843
	cp 0ffh		;6845
	jr nz,L_684D		;6847
	sub e			;6849
	jr c,L_6854		;684a
	add a,e			;684c
L_684D:
	ld e,a			;684d
	call L_685D		;684e
	set 7,h		;6851
	ret			;6853
L_6854:
	ld e,a			;6854
	call L_685D		;6855
	set 7,h		;6858
	set 7,l		;685a
	ret			;685c
L_685D:
	ld a,(0671ah)		;685d
	ld l,a			;6860
	ld h,0c6h		;6861
	ld a,000h		;6863
	set 6,a		;6865
	ld (hl),a			;6867
	inc h			;6868
	ld (hl),e			;6869
	ld hl,(067dah)		;686a
	ret			;686d
L_686E:
	ld (l688dh),a		;686e
	ld e,000h		;6871
L_6873:
	ld a,(06864h)		;6873
	ld (068a3h),a		;6876
	ld (06884h),a		;6879
	ld b,008h		;687c
	inc e			;687e
	jr z,L_6895		;687f
L_6881:
	ex af,af'			;6881
	ld a,(iy+000h)		;6882
	call L_68AB		;6885
	or a			;6888
	jp p,L_6898		;6889
	ex af,af'			;688c
L_688D:
	inc a			;688d
	and 007h		;688e
	ld (06884h),a		;6890
	djnz L_6881		;6893
L_6895:
	ld e,0ffh		;6895
	ret			;6897
L_6898:
	push de			;6898
	ex af,af'			;6899
	ld e,a			;689a
	add a,a			;689b
	sbc a,a			;689c
	ld d,a			;689d
	add ix,de		;689e
	pop de			;68a0
	ld a,(iy+000h)		;68a1
	call L_68AB		;68a4
	jp m,L_6873		;68a7
	ret			;68aa
L_68AB:
	ld (068b0h),a		;68ab
	ld a,(ix+000h)		;68ae
	and 00fh		;68b1
	add a,037h		;68b3
	ld l,a			;68b5
	adc a,06dh		;68b6
	sub l			;68b8
	ld h,a			;68b9
	ld a,(hl)			;68ba
	or a			;68bb
	ret			;68bc
L_68BD:
	ld a,(0671ah)		;68bd
	ld l,a			;68c0
	ld h,0c6h		;68c1
	push hl			;68c3
	ld a,(hl)			;68c4
	and 00fh		;68c5
	ex af,af'			;68c7
	ld a,03ch		;68c8
	bit 1,c		;68ca
	jr z,L_68CF		;68cc
	inc a			;68ce
L_68CF:
	ld (l68e7h),a		;68cf
	ex af,af'			;68d2
	ld (068dfh),a		;68d3
	ld iy,06b34h		;68d6
	ld b,008h		;68da
L_68DC:
	ex af,af'			;68dc
	ld a,(iy+000h)		;68dd
	call L_68AB		;68e0
	jp p,L_68F4		;68e3
	ex af,af'			;68e6
L_68E7:
	inc a			;68e7
	and 007h		;68e8
	ld (068dfh),a		;68ea
	djnz L_68DC		;68ed
	pop hl			;68ef
	ld hl,(067dah)		;68f0
	ret			;68f3
L_68F4:
	ld hl,(067dah)		;68f4
	ex af,af'			;68f7
	add a,a			;68f8
	add a,013h		;68f9
	ld e,a			;68fb
	adc a,06bh		;68fc
	sub e			;68fe
	ld d,a			;68ff
	ld a,(de)			;6900
	add a,h			;6901
	ld h,a			;6902
	inc de			;6903
	ld a,(de)			;6904
	add a,l			;6905
	ld l,a			;6906
	ex (sp),hl			;6907
	inc h			;6908
	ld e,(hl)			;6909
	dec e			;690a
	ld (hl),e			;690b
	jr nz,L_6913		;690c
	dec h			;690e
	ld (hl),001h		;690f
	pop hl			;6911
	ret			;6912
L_6913:
	ld a,(l68e7h)		;6913
	pop hl			;6916
	set 7,h		;6917
	cp 03dh		;6919
	ret nz			;691b
	set 7,l		;691c
	ret			;691e
L_691F:
	ld (06942h),a		;691f
	ld a,(06822h)		;6922
	add a,a			;6925
	add a,013h		;6926
	ld l,a			;6928
	adc a,06bh		;6929
	sub l			;692b
	ld h,a			;692c
	ld d,(hl)			;692d
	inc hl			;692e
	ld e,(hl)			;692f
	ld a,(067dbh)		;6930
	add a,d			;6933
	ld h,a			;6934
	ld a,(067dah)		;6935
	add a,e			;6938
	ld l,a			;6939
	push hl			;693a
	ld a,(0671ah)		;693b
	ld l,a			;693e
	ld h,0c6h		;693f
	ld (hl),000h		;6941
	pop hl			;6943
	ret			;6944
L_6945:
	ld h,0c2h		;6945
	inc (hl)			;6947
	ld a,(hl)			;6948
	cp 028h		;6949
	ret c			;694b
	ld h,0c6h		;694c
	res 7,(hl)		;694e
	ret			;6950
L_6951:
	ld h,0c6h		;6951
	set 7,(hl)		;6953
	ret			;6955
L_6956:
	ld c,000h		;6956
	ld l,a			;6958
	ld h,0bch		;6959
	ld a,(hl)			;695b
	cp 0feh		;695c
	jr c,L_6974		;695e
	ld b,l			;6960
L_6961:
	inc c			;6961
	jr z,L_6979		;6962
	dec h			;6964
	ld l,(hl)			;6965
	inc h			;6966
	ld a,(hl)			;6967
	cp 0feh		;6968
	jr nc,L_6961		;696a
	dec h			;696c
	ld e,(hl)			;696d
	ld c,l			;696e
	ld l,b			;696f
	dec h			;6970
	jp L_6977		;6971
L_6974:
	dec h			;6974
	ld e,(hl)			;6975
	dec h			;6976
L_6977:
	ld d,a			;6977
	ret			;6978
L_6979:
	ld h,0b9h		;6979
	ld e,(hl)			;697b
	inc h			;697c
	ld d,(hl)			;697d
	ld c,l			;697e
	ld l,b			;697f
	ret			;6980
L_6981:
	ld hl,06b46h		;6981
	ld bc,000b5h		;6984
	ld a,0b7h		;6987
	inc e			;6989
L_698A:
	dec e			;698a
	jr z,L_6992		;698b
	cpir		;698d
	jp L_698A		;698f
L_6992:
	ret			;6992
L_6993:
	push hl			;6993
	ld bc,(067dah)		;6994
	ld hl,06cfbh		;6998
	ld a,00fh		;699b
	call L_69F3		;699d
	ld d,h			;69a0
	ld e,l			;69a1
	call L_63FB		;69a2
	bit 7,h		;69a5
	jr z,L_69AA		;69a7
	inc de			;69a9
L_69AA:
	ld a,(de)			;69aa
	add a,a			;69ab
	add a,a			;69ac
	add a,0fbh		;69ad
	ld l,a			;69af
	adc a,06ch		;69b0
	sub l			;69b2
	ld h,a			;69b3
	ld e,(hl)			;69b4
	inc hl			;69b5
	ld d,(hl)			;69b6
	pop hl			;69b7
	ld h,0bbh		;69b8
	ld (hl),e			;69ba
	inc h			;69bb
	ld (hl),d			;69bc
	ld hl,(067dah)		;69bd
	ret			;69c0
L_69C1:
	push hl			;69c1
	ld bc,(067dah)		;69c2
	ld hl,06bfbh		;69c6
	ld a,040h		;69c9
	call L_69F3		;69cb
	ld d,h			;69ce
	ld e,l			;69cf
	call L_63FB		;69d0
	bit 7,h		;69d3
	jr z,L_69D8		;69d5
	inc de			;69d7
L_69D8:
	ld a,(de)			;69d8
	add a,a			;69d9
	ld l,a			;69da
	ld h,000h		;69db
	add hl,hl			;69dd
	ld a,l			;69de
	add a,0fbh		;69df
	ld l,a			;69e1
	ld a,h			;69e2
	adc a,06bh		;69e3
	ld h,a			;69e5
	ld e,(hl)			;69e6
	inc hl			;69e7
	ld d,(hl)			;69e8
	pop hl			;69e9
	ld h,0bbh		;69ea
	ld (hl),e			;69ec
	inc h			;69ed
	ld (hl),d			;69ee
	ld hl,(067dah)		;69ef
	ret			;69f2
L_69F3:
	ld (06a08h),hl		;69f3
L_69F6:
	ex af,af'			;69f6
	ld e,(hl)			;69f7
	inc hl			;69f8
	ld a,(hl)			;69f9
	inc hl			;69fa
	cp b			;69fb
	jr nz,L_6A01		;69fc
	ld a,e			;69fe
	cp c			;69ff
	ret z			;6a00
L_6A01:
	inc hl			;6a01
	inc hl			;6a02
	ex af,af'			;6a03
	dec a			;6a04
	jr nz,L_69F6		;6a05
	ld hl,00000h		;6a07
	inc hl			;6a0a
	inc hl			;6a0b
	ret			;6a0c
L_6A0D:
	ld a,(0671ah)		;6a0d
	ld l,a			;6a10
	ld h,0c2h		;6a11
	inc (hl)			;6a13
	jr nz,L_6A17		;6a14
	dec (hl)			;6a16
L_6A17:
	cp 0ddh		;6a17
	jp nc,L_6993		;6a19
	cp 078h		;6a1c
	jp nc,L_69C1		;6a1e
	cp 016h		;6a21
	jp z,L_69C1		;6a23
	cp 017h		;6a26
	jp z,L_6993		;6a28
	ld h,0c6h		;6a2b
	ld (hl),001h		;6a2d
	ld hl,(067dah)		;6a2f
	ret			;6a32
L_6A33:
	ld e,l			;6a33
	ld d,0b9h		;6a34
	ld h,0bbh		;6a36
	ld a,(de)			;6a38
	and 07fh		;6a39
	ld (hl),a			;6a3b
	inc d			;6a3c
	inc h			;6a3d
	ld a,(de)			;6a3e
	and 07fh		;6a3f
	ld (hl),a			;6a41
	xor a			;6a42
	ld (06a48h),a		;6a43
	ret			;6a46
L_6A47:
	ld a,000h		;6a47
	or a			;6a49
	ret z			;6a4a
	ld hl,0bb00h		;6a4b
	ld a,(hl)			;6a4e
	dec h			;6a4f
	ld b,(hl)			;6a50
	dec h			;6a51
	ld c,(hl)			;6a52
	ld l,a			;6a53
	ld a,b			;6a54
	or c			;6a55
	jr z,L_6A33		;6a56
	ld a,(hl)			;6a58
	and 07fh		;6a59
	res 7,c		;6a5b
	cp c			;6a5d
	ret nz			;6a5e
	inc h			;6a5f
	ld a,(hl)			;6a60
	and 07fh		;6a61
	res 7,b		;6a63
	cp b			;6a65
	ret nz			;6a66
	inc h			;6a67
	ld (hl),c			;6a68
	inc h			;6a69
	ld (hl),b			;6a6a
	inc h			;6a6b
	set 4,(hl)		;6a6c
	ld h,0c0h		;6a6e
	ld a,(hl)			;6a70
	and 00fh		;6a71
	jp z,L_83E1		;6a73
	ld a,(08333h)		;6a76
	push bc			;6a79
	ld b,a			;6a7a
	add a,a			;6a7b
	add a,a			;6a7c
	add a,a			;6a7d
	add a,a			;6a7e
	ld (08333h),a		;6a7f
	ld a,(06a4ch)		;6a82
	ld l,a			;6a85
	ld a,(hl)			;6a86
	and 0f0h		;6a87
	ld e,a			;6a89
	ld a,b			;6a8a
	rrca			;6a8b
	rrca			;6a8c
	rrca			;6a8d
	rrca			;6a8e
	and 00fh		;6a8f
	jr z,L_6A94		;6a91
	dec a			;6a93
L_6A94:
	or e			;6a94
	ld (hl),a			;6a95
	ld h,0bdh		;6a96
	res 4,(hl)		;6a98
	pop bc			;6a9a
	dec h			;6a9b
	ld (hl),b			;6a9c
	dec h			;6a9d
	ld (hl),c			;6a9e
	ld a,004h		;6a9f
	call L_65FF		;6aa1
	ld hl,06af5h		;6aa4
	ld (08242h),hl		;6aa7
	xor a			;6aaa
	ld (06a48h),a		;6aab
	ret			;6aae
L_6AAF:
	ld hl,05800h		;6aaf
	ld bc,00300h		;6ab2
L_6AB5:
	ld a,078h		;6ab5
	cp (hl)			;6ab7
	jr z,L_6ABC		;6ab8
	ld (hl),030h		;6aba
L_6ABC:
	inc hl			;6abc
	dec bc			;6abd
	ld a,b			;6abe
	or c			;6abf
	jr nz,L_6AB5		;6ac0
	ld hl,0b900h		;6ac2
L_6AC5:
	ld a,(hl)			;6ac5
	rrca			;6ac6
	rrca			;6ac7
	and 01fh		;6ac8
	ld e,a			;6aca
	inc h			;6acb
	ld a,(hl)			;6acc
	and 07fh		;6acd
	dec h			;6acf
	sub 004h		;6ad0
	rlca			;6ad2
	rlca			;6ad3
	rlca			;6ad4
	ld b,a			;6ad5
	and 003h		;6ad6
	or 058h		;6ad8
	ld d,a			;6ada
	ld a,b			;6adb
	and 0e0h		;6adc
	or e			;6ade
	ld e,a			;6adf
	ld a,070h		;6ae0
	ld (de),a			;6ae2
L_6AE3:
	inc l			;6ae3
	ld a,l			;6ae4
	cp 016h		;6ae5
	jr z,L_6AE3		;6ae7
	cp 017h		;6ae9
	jr z,L_6AE3		;6aeb
	cp 078h		;6aed
	jr c,L_6AC5		;6aef
	call 00604h		;6af1
	ret			;6af4

; ----------------------------------------------------------------------
; DATOS textos_y_tablas_del_anillo: Textos ("El Anillo se ha perdido.") y
;   tablas (0x6B13, 0x6B34, 0x6B3D, 0x6B46, 0x6BE4 los apuntan; formato
;   pendiente)
;   0x6af5..0x6de7  (754 bytes)
DATA_textos_y_tablas_del_anillo:
	defb 045h,06ch,020h,041h,06eh,069h,06ch,06ch,06fh,020h,073h,065h,020h,068h,061h,020h	; 6af5  El Anillo se ha 
	defb 070h,065h,072h,064h,069h,064h,06fh,02eh,020h,020h,020h,020h,020h,000h,0ffh,000h	; 6b05  perdido.     ...
	defb 0ffh,001h,000h,001h,001h,001h,001h,000h,001h,0ffh,000h,0ffh,0ffh,0ffh,000h,001h	; 6b15  ................
	defb 000h,0ffh,000h,001h,000h,000h,001h,000h,000h,0ffh,000h,000h,000h,001h,099h,0ffh	; 6b25  ................
	defb 065h,066h,067h,001h,09bh,09ah,099h,0ffh,015h,009h,056h,075h,065h,06ch,076h,065h	; 6b35  efg.......Vuelve
	defb 0b7h,047h,061h,06eh,064h,061h,06ch,066h,0b7h,041h,072h,061h,067h,06fh,072h,06eh	; 6b45  .Gandalf.Aragorn
	defb 0b7h,042h,06fh,072h,06fh,06dh,069h,072h,0b7h,04ch,065h,067h,06fh,06ch,061h,073h	; 6b55  .Boromir.Legolas
	defb 0b7h,047h,069h,06dh,06ch,069h,0b7h,046h,072h,06fh,064h,06fh,0b7h,053h,061h,06dh	; 6b65  .Gimli.Frodo.Sam
	defb 0b7h,04dh,065h,072h,072h,079h,0b7h,050h,069h,070h,070h,069h,06eh,0b7h,045h,06ch	; 6b75  .Merry.Pippin.El
	defb 072h,06fh,06eh,064h,0b7h,044h,061h,069h,06eh,020h,049h,049h,0b7h,043h,065h,06ch	; 6b85  rond.Dain II.Cel
	defb 065h,062h,06fh,072h,06eh,0b7h,054h,068h,072h,061h,06eh,064h,075h,069h,06ch,0b7h	; 6b95  eborn.Thranduil.
	defb 042h,072h,061h,06eh,064h,020h,049h,049h,049h,0b7h,054h,068h,065h,06fh,064h,072h	; 6ba5  Brand III.Theodr
	defb 065h,064h,0b7h,054h,068h,065h,06fh,064h,065h,06eh,0b7h,045h,06fh,077h,079h,06eh	; 6bb5  ed.Theoden.Eowyn
	defb 0b7h,045h,06fh,06dh,065h,072h,0b7h,049h,06dh,072h,061h,068h,069h,06ch,0b7h,044h	; 6bc5  .Eomer.Imrahil.D
	defb 065h,06eh,065h,074h,068h,06fh,072h,0b7h,046h,061h,072h,061h,06dh,069h,072h,0b7h	; 6bd5  enethor.Faramir.
	defb 047h,06fh,06ch,06ch,075h,06dh,0b7h,053h,061h,075h,072h,06fh,06eh,0b7h,053h,061h	; 6be5  Gollum.Sauron.Sa
	defb 072h,075h,06dh,061h,06eh,0b7h,06fh,040h,005h,003h,068h,03fh,000h,000h,068h,046h	; 6bf5  ruman.o@..h?..hF
	defb 001h,003h,063h,041h,004h,005h,05fh,040h,003h,009h,064h,03ah,000h,007h,061h,03ch	; 6c05  ..cA.._@..d:..a<
	defb 005h,005h,060h,037h,01eh,013h,05ch,043h,013h,004h,05bh,046h,008h,00ah,059h,046h	; 6c15  ..`7..\C..[F..YF
	defb 009h,00bh,057h,046h,012h,015h,05ch,04bh,009h,009h,060h,056h,00ch,00ch,063h,05ah	; 6c25  ..WF..\K..`V..cZ
	defb 00dh,00dh,044h,063h,00eh,00eh,051h,049h,00bh,012h,046h,04ch,010h,017h,04eh,046h	; 6c35  ..Dc..QI..FL..NF
	defb 011h,017h,05bh,03eh,007h,014h,05ah,03eh,03eh,015h,058h,03fh,016h,03eh,056h,03fh	; 6c45  ..[>..Z>>.X?.>V?
	defb 016h,016h,048h,044h,010h,018h,042h,03eh,017h,019h,041h,03bh,01ah,018h,041h,03ah	; 6c55  ..HD..B>..A;..A:
	defb 019h,01dh,042h,038h,01ch,01ah,041h,036h,01dh,02bh,047h,039h,03eh,01bh,05dh,032h	; 6c65  ..B8..A6.+G9>.]2
	defb 01fh,014h,05ah,028h,020h,021h,054h,027h,029h,01eh,05ah,01ah,022h,023h,064h,00fh	; 6c75  ..Z( !T').Z."#d.
	defb 021h,021h,051h,019h,024h,029h,04ch,019h,025h,025h,046h,019h,026h,027h,045h,017h	; 6c85  !!Q.$)L.%%F.&'E.
	defb 027h,028h,043h,019h,032h,028h,045h,01eh,029h,027h,04eh,021h,028h,02ah,049h,024h	; 6c95  '(C.2(E.)'N!(*I$
	defb 03fh,03fh,038h,02ah,01ch,02ch,035h,028h,02bh,02dh,033h,022h,02bh,02eh,02fh,022h	; 6ca5  ??8*.,5(+-3"+./"
	defb 02dh,02fh,02ch,021h,02eh,030h,025h,01eh,031h,038h,025h,01bh,02fh,02fh,03ch,019h	; 6cb5  -/,!.0%.18%.//<.
	defb 033h,033h,035h,019h,034h,034h,033h,01ah,035h,02dh,030h,01bh,036h,02fh,02bh,019h	; 6cc5  335.443.5-0.6/+.
	defb 037h,037h,029h,019h,038h,039h,029h,01bh,031h,02fh,028h,016h,031h,03ah,022h,017h	; 6cd5  77).89).1/(.1:".
	defb 03bh,039h,01fh,017h,03ah,03ch,019h,019h,03bh,03dh,014h,01eh,03ch,030h,04eh,03ch	; 6ce5  ;9..:<..;=..<0N<
	defb 01dh,015h,044h,02fh,01dh,01dh,057h,046h,003h,003h,04eh,046h,000h,000h,05ah,03eh	; 6cf5  ..D/..WF..NF..Z>
	defb 004h,004h,058h,03fh,003h,00dh,056h,03fh,004h,004h,048h,044h,001h,001h,042h,03eh	; 6d05  ..X?..V?..HD..B>
	defb 005h,005h,041h,03bh,006h,00bh,041h,03ah,007h,00ch,042h,038h,008h,00bh,041h,036h	; 6d15  ..A;..A:..B8..A6
	defb 009h,00eh,047h,039h,00dh,00ah,038h,02ah,00ah,00ah,04eh,03ch,00bh,003h,044h,02fh	; 6d25  ..G9..8*..N<..D/
	defb 008h,00bh,003h,0ffh,0ffh,00fh,003h,003h,003h,00fh,003h,003h,00fh,003h,0ffh,003h	; 6d35  ................
	defb 0ffh,003h,003h,0ffh,0ffh,003h,003h,003h,002h,00fh,003h,003h,003h,003h,00fh,003h	; 6d45  ................
	defb 00fh,003h,003h,0ffh,0ffh,00fh,003h,003h,002h,00fh,003h,003h,003h,003h,00fh,00fh	; 6d55  ................
	defb 00fh,003h,003h,0ffh,0ffh,00fh,003h,003h,002h,00fh,003h,003h,003h,003h,00fh,00fh	; 6d65  ................
	defb 00fh,003h,003h,0ffh,0ffh,003h,003h,003h,002h,00fh,003h,003h,003h,003h,00fh,003h	; 6d75  ................
	defb 00fh,003h,003h,0ffh,0ffh,00fh,003h,003h,002h,00fh,003h,003h,003h,003h,00fh,00fh	; 6d85  ................
	defb 003h,002h,003h,0ffh,0ffh,00fh,003h,003h,002h,003h,003h,003h,003h,003h,00fh,00fh	; 6d95  ................
	defb 003h,002h,003h,0ffh,0ffh,00fh,003h,003h,002h,00fh,003h,003h,003h,003h,00fh,003h	; 6da5  ................
	defb 00fh,003h,003h,0ffh,0ffh,003h,003h,003h,002h,00fh,003h,003h,003h,003h,00fh,003h	; 6db5  ................
	defb 00fh,003h,003h,0ffh,0ffh,00fh,003h,003h,002h,00fh,003h,003h,003h,003h,00fh,00fh	; 6dc5  ................
	defb 00fh,003h,003h,0ffh,0ffh,00fh,003h,003h,002h,00fh,003h,003h,003h,003h,00fh,00fh	; 6dd5  ................
	defb 00fh,003h	; 6de5

; ======================================================================
; CODIGO 0x6de7..0x7697  (2224 bytes)
; ======================================================================


L_6DE7:
	exx			;6de7
	ld h,0bch		;6de8
	ld a,(hl)			;6dea
	ld h,0bdh		;6deb
	cp 0feh		;6ded
	jr z,L_6E12		;6def
	ld a,(hl)			;6df1
	exx			;6df2
L_6DF3:
	and 00fh		;6df3
	ld b,a			;6df5
	ld hl,07d39h		;6df6
	call L_6E98		;6df9
	ld de,07c2fh		;6dfc
	call L_6E78		;6dff
	ex af,af'			;6e02
	ret c			;6e03
L_6E04:
	ld hl,07d90h		;6e04
	jp L_6E78		;6e07
L_6E0A:
	or a			;6e0a
	ex af,af'			;6e0b
	ld l,c			;6e0c
	ld h,0bdh		;6e0d
	ld a,(hl)			;6e0f
	jr L_6DF3		;6e10
L_6E12:
	ld a,l			;6e12
	exx			;6e13
	call L_6956		;6e14
	ld a,c			;6e17
	cp 017h		;6e18
	jr nc,L_6E0A		;6e1a
	ld e,a			;6e1c
	call L_6981		;6e1d
	ld de,07c2fh		;6e20
L_6E23:
	ld a,(hl)			;6e23
	cp 0b7h		;6e24
	jr z,L_6E04		;6e26
	ld (de),a			;6e28
	inc de			;6e29
	inc hl			;6e2a
	jr L_6E23		;6e2b
L_6E2D:
	call L_6E50		;6e2d
	ret c			;6e30
	push bc			;6e31
	ex de,hl			;6e32
	inc hl			;6e33
	ld a,(hl)			;6e34
	rra			;6e35
	rra			;6e36
	rra			;6e37
	rra			;6e38
	and 00fh		;6e39
	ld c,a			;6e3b
	ld a,(hl)			;6e3c
	inc hl			;6e3d
	and 00fh		;6e3e
	ex de,hl			;6e40
	ld hl,05e1eh		;6e41
	or a			;6e44
	ld b,000h		;6e45
	sbc hl,bc		;6e47
	ld b,c			;6e49
	ld c,a			;6e4a
	call L_70D6		;6e4b
	pop hl			;6e4e
	ret			;6e4f
L_6E50:
	ld b,h			;6e50
	ld c,l			;6e51
	ld hl,07a5eh		;6e52
L_6E55:
	ld e,(hl)			;6e55
	inc hl			;6e56
	ld d,(hl)			;6e57
	inc hl			;6e58
	or a			;6e59
	ex de,hl			;6e5a
	sbc hl,bc		;6e5b
	ex de,hl			;6e5d
	jr z,L_6E70		;6e5e
	ld a,(hl)			;6e60
	or a			;6e61
	jr z,L_6E6C		;6e62
	add a,l			;6e64
	ld l,a			;6e65
	adc a,h			;6e66
	sub l			;6e67
	ld h,a			;6e68
	jp L_6E55		;6e69
L_6E6C:
	ld h,b			;6e6c
	ld l,c			;6e6d
	scf			;6e6e
	ret			;6e6f
L_6E70:
	ex de,hl			;6e70
	ld h,b			;6e71
	ld l,c			;6e72
	ret			;6e73
L_6E74:
	ld a,(hl)			;6e74
	cp 0a0h		;6e75
	ret z			;6e77
L_6E78:
	ld a,(hl)			;6e78
	or a			;6e79
	jp m,L_6E83		;6e7a
	ld (de),a			;6e7d
	inc hl			;6e7e
	inc de			;6e7f
	jp L_6E78		;6e80
L_6E83:
	and 07fh		;6e83
	ld (de),a			;6e85
	inc de			;6e86
	ret			;6e87
L_6E88:
	ld c,002h		;6e88
	jr L_6E8E		;6e8a
L_6E8C:
	ld c,020h		;6e8c
L_6E8E:
	ld b,007h		;6e8e
L_6E90:
	sub c			;6e90
	jr c,L_6E95		;6e91
	djnz L_6E90		;6e93
L_6E95:
	ld hl,07d9ah		;6e95
L_6E98:
	inc b			;6e98
L_6E99:
	inc hl			;6e99
	djnz L_6E9D		;6e9a
	ret			;6e9c
L_6E9D:
	ld a,(hl)			;6e9d
	or a			;6e9e
	jp m,L_6E99		;6e9f
	inc hl			;6ea2
	jp L_6E9D		;6ea3
L_6EA6:
	ld a,h			;6ea6
	or l			;6ea7
	ret z			;6ea8
	ex de,hl			;6ea9
	ld b,000h		;6eaa
L_6EAC:
	ld hl,0b900h		;6eac
	ld a,(hl)			;6eaf
	and 07fh		;6eb0
	cp e			;6eb2
	jr nz,L_6ECD		;6eb3
	inc h			;6eb5
	ld a,(hl)			;6eb6
	dec h			;6eb7
	and 07fh		;6eb8
	cp d			;6eba
	jr nz,L_6ECD		;6ebb
	ld a,l			;6ebd
	cp 078h		;6ebe
	jr nc,L_6ECD		;6ec0
	cp 016h		;6ec2
	jr z,L_6ECD		;6ec4
	cp 017h		;6ec6
	jr z,L_6ECD		;6ec8
	ex de,hl			;6eca
	scf			;6ecb
	ret			;6ecc
L_6ECD:
	inc l			;6ecd
	ld (L_6EAC+1),hl		;6ece
	djnz L_6EAC		;6ed1
	ex de,hl			;6ed3
	or a			;6ed4
	ret			;6ed5
L_6ED6:
	ld a,h			;6ed6
	or l			;6ed7
	ret z			;6ed8
	ex de,hl			;6ed9
	ld b,000h		;6eda
L_6EDC:
	ld hl,(L_6EAC+1)		;6edc
	ld a,(hl)			;6edf
	and 07fh		;6ee0
	cp e			;6ee2
	jr nz,L_6EFF		;6ee3
	inc h			;6ee5
	ld a,(hl)			;6ee6
	dec h			;6ee7
	and 07fh		;6ee8
	cp d			;6eea
	jr nz,L_6EFF		;6eeb
	ld a,l			;6eed
	cp 078h		;6eee
	jr nc,L_6EFF		;6ef0
	cp 016h		;6ef2
	jp z,L_6EFF		;6ef4
	cp 017h		;6ef7
	jp z,L_6EFF		;6ef9
	ex de,hl			;6efc
	scf			;6efd
	ret			;6efe
L_6EFF:
	dec l			;6eff
	ld (L_6EAC+1),hl		;6f00
	djnz L_6EDC		;6f03
	ex de,hl			;6f05
	or a			;6f06
	ret			;6f07
L_6F08:
	push hl			;6f08
	jr L_6F1A		;6f09
L_6F0B:
	push hl			;6f0b
	ld hl,060abh		;6f0c
	ld bc,01801h		;6f0f
	ld a,(071cfh)		;6f12
	cp 010h		;6f15
	jp nz,L_708D		;6f17
L_6F1A:
	ld hl,07c17h		;6f1a
	ld d,h			;6f1d
	ld e,l			;6f1e
	inc de			;6f1f
	ld bc,000d7h		;6f20
	ld (hl),020h		;6f23
	ldir		;6f25
	ld a,(L_6EAC+1)		;6f27
	ld l,a			;6f2a
	exx			;6f2b
	cp 018h		;6f2c
	jr nc,L_6F42		;6f2e
	ld e,a			;6f30
	ex af,af'			;6f31
	call L_6981		;6f32
	ld de,07c18h		;6f35
L_6F38:
	ld a,(hl)			;6f38
	cp 0b7h		;6f39
	jr z,L_6F6E		;6f3b
	ld (de),a			;6f3d
	inc de			;6f3e
	inc hl			;6f3f
	jr L_6F38		;6f40
L_6F42:
	ex af,af'			;6f42
	ld hl,07d84h		;6f43
	ld de,07c17h		;6f46
	call L_6E78		;6f49
	ld h,0bdh		;6f4c
	ld a,(L_6EAC+1)		;6f4e
	ld l,a			;6f51
	ld a,(hl)			;6f52
	and 00fh		;6f53
	exx			;6f55
	ld b,a			;6f56
	ld hl,07d06h		;6f57
	call L_6E98		;6f5a
	ld de,07c28h		;6f5d
	call L_6E78		;6f60
	exx			;6f63
	ld h,0c5h		;6f64
	ld a,(hl)			;6f66
	exx			;6f67
	ld hl,07c24h		;6f68
	call L_7113		;6f6b
L_6F6E:
	exx			;6f6e
	ld h,0bdh		;6f6f
	ld a,(hl)			;6f71
	exx			;6f72
	and 010h		;6f73
	jr z,L_6F7C		;6f75
	ld a,05fh		;6f77
	ld (07c46h),a		;6f79
L_6F7C:
	call L_6DE7		;6f7c
	ld bc,00008h		;6f7f
	ld hl,07c01h		;6f82
	ld de,07c47h		;6f85
	ldir		;6f88
	ld a,(L_6EAC+1)		;6f8a
	call L_6956		;6f8d
	push de			;6f90
	ld h,d			;6f91
	ld l,e			;6f92
	call L_6E50		;6f93
	jr c,L_6FC2		;6f96
	inc de			;6f98
	ld a,(de)			;6f99
	and 00fh		;6f9a
	ld c,a			;6f9c
	ld a,(de)			;6f9d
	call L_7096		;6f9e
	ld b,a			;6fa1
	ld hl,07c50h		;6fa2
	inc de			;6fa5
L_6FA6:
	ex af,af'			;6fa6
L_6FA7:
	ld a,(de)			;6fa7
	ld (hl),a			;6fa8
	inc hl			;6fa9
	inc de			;6faa
	cp 020h		;6fab
	jr z,L_6FB6		;6fad
	djnz L_6FA7		;6faf
	ld (hl),020h		;6fb1
	inc hl			;6fb3
	jr L_6FBA		;6fb4
L_6FB6:
	inc de			;6fb6
	djnz L_6FB6		;6fb7
	dec de			;6fb9
L_6FBA:
	ex af,af'			;6fba
	ld b,a			;6fbb
	dec c			;6fbc
	jr nz,L_6FA6		;6fbd
	pop de			;6fbf
	jr L_6FDC		;6fc0
L_6FC2:
	pop de			;6fc2
	ld a,d			;6fc3
	ld hl,07c50h		;6fc4
	call L_710F		;6fc7
	ld (hl),05eh		;6fca
	inc hl			;6fcc
	ld (hl),04eh		;6fcd
	inc hl			;6fcf
	ld (hl),02ch		;6fd0
	inc hl			;6fd2
	ld a,e			;6fd3
	call L_7113		;6fd4
	ld (hl),05eh		;6fd7
	inc hl			;6fd9
	ld (hl),045h		;6fda
L_6FDC:
	ld h,0c0h		;6fdc
	ld a,(L_6EAC+1)		;6fde
	ld l,a			;6fe1
	ld a,(hl)			;6fe2
	exx			;6fe3
	and 00fh		;6fe4
	call L_6E88		;6fe6
	ld de,07ca7h		;6fe9
	call L_6E74		;6fec
	ld hl,07defh		;6fef
	call L_6E78		;6ff2
	ld a,02ch		;6ff5
	ld (de),a			;6ff7
	exx			;6ff8
	call L_7095		;6ff9
	exx			;6ffc
	call L_6E88		;6ffd
	ld de,07c8fh		;7000
	call L_6E74		;7003
	ld hl,07de6h		;7006
	call L_6E78		;7009
	ld a,02ch		;700c
	ld (de),a			;700e
	exx			;700f
	inc h			;7010
	ld a,(hl)			;7011
	and 00fh		;7012
	exx			;7014
	call L_6E88		;7015
	ld de,07cbfh		;7018
	call L_6E74		;701b
	ld hl,07df7h		;701e
	call L_6E74		;7021
	ld a,02ch		;7024
	ld (de),a			;7026
	exx			;7027
	call L_7095		;7028
	exx			;702b
	call L_6E88		;702c
	ld de,07cd7h		;702f
	call L_6E74		;7032
	ld hl,07dfch		;7035
	call L_6E78		;7038
	ld a,02ch		;703b
	ld (de),a			;703d
	exx			;703e
	inc h			;703f
	ld a,(hl)			;7040
	exx			;7041
	call L_6E8C		;7042
	ld de,07c5fh		;7045
	call L_6E74		;7048
	ld hl,07dd3h		;704b
	call L_6E78		;704e
	ld a,02ch		;7051
	ld (de),a			;7053
	exx			;7054
	inc h			;7055
	ld a,(hl)			;7056
	exx			;7057
	call L_6E8C		;7058
	ld de,07c77h		;705b
	call L_6E74		;705e
	ld hl,07ddch		;7061
	call L_6E78		;7064
	ld a,02ch		;7067
	ld (de),a			;7069
	exx			;706a
	ld h,0bdh		;706b
	ld a,(hl)			;706d
	rlca			;706e
	rlca			;706f
	and 003h		;7070
	ld b,a			;7072
	ld hl,07d6ah		;7073
	call L_6E98		;7076
	ld de,07cf9h		;7079
	call L_6E78		;707c
	ld a,020h		;707f
	ex de,hl			;7081
L_7082:
	cp (hl)			;7082
	ld (hl),a			;7083
	inc hl			;7084
	jr nz,L_7082		;7085
	ld bc,0180ah		;7087
	ld hl,05fbdh		;708a
L_708D:
	ld de,07c17h		;708d
	call L_70D6		;7090
	pop hl			;7093
	ret			;7094
L_7095:
	ld a,(hl)			;7095
L_7096:
	rrca			;7096
	rrca			;7097
	rrca			;7098
	rrca			;7099
	and 00fh		;709a
	ret			;709c
L_709D:
	push hl			;709d
	ld a,h			;709e
	and 07fh		;709f
	push af			;70a1
	ld a,l			;70a2
	and 07fh		;70a3
	ld hl,07c12h		;70a5
	call L_7113		;70a8
	ld hl,07c0ch		;70ab
	pop af			;70ae
	call L_710F		;70af
	ld de,07c01h		;70b2
	jr L_70CB		;70b5
L_70B7:
	push hl			;70b7
	ld a,h			;70b8
	push af			;70b9
	ld a,l			;70ba
	ld hl,07bfch		;70bb
	call L_7113		;70be
	ld hl,07bf6h		;70c1
	pop af			;70c4
	call L_710F		;70c5
	ld de,07bebh		;70c8
L_70CB:
	ld hl,05e00h		;70cb
	ld bc,00b02h		;70ce
	call L_70D6		;70d1
	pop hl			;70d4
	ret			;70d5
L_70D6:
	ld (hl),0e7h		;70d6
	inc hl			;70d8
	push bc			;70d9
	ld a,0e8h		;70da
L_70DC:
	ld (hl),a			;70dc
	inc hl			;70dd
	djnz L_70DC		;70de
	ld (hl),0e9h		;70e0
	pop bc			;70e2
	call L_7106		;70e3
L_70E6:
	ld (hl),0eah		;70e6
	inc hl			;70e8
	push bc			;70e9
L_70EA:
	ld a,(de)			;70ea
	inc de			;70eb
	ld (hl),a			;70ec
	inc hl			;70ed
	djnz L_70EA		;70ee
	ld (hl),0ebh		;70f0
	pop bc			;70f2
	call L_7106		;70f3
	dec c			;70f6
	jp nz,L_70E6		;70f7
	ld (hl),0ech		;70fa
	inc hl			;70fc
	ld a,0edh		;70fd
L_70FF:
	ld (hl),a			;70ff
	inc hl			;7100
	djnz L_70FF		;7101
	ld (hl),0eeh		;7103
	ret			;7105
L_7106:
	ld a,021h		;7106
	sub b			;7108
	add a,l			;7109
	ld l,a			;710a
	adc a,h			;710b
	sub l			;710c
	ld h,a			;710d
	ret			;710e
L_710F:
	ld c,a			;710f
	ld a,063h		;7110
	sub c			;7112
L_7113:
	ld c,064h		;7113
	call L_711F		;7115
	ld c,00ah		;7118
	call L_711F		;711a
	ld c,001h		;711d
L_711F:
	ld (hl),02fh		;711f
L_7121:
	inc (hl)			;7121
	sub c			;7122
	jp nc,L_7121		;7123
	add a,c			;7126
	inc hl			;7127
	ret			;7128
L_7129:
	push hl			;7129
	ld a,l			;712a
	cp 007h		;712b
	jr nc,L_713C		;712d
	ld a,007h		;712f
	sub l			;7131
	add a,a			;7132
	ld c,a			;7133
	ld hl,05e00h		;7134
	call L_7192		;7137
	jr L_7151		;713a
L_713C:
	cp 078h		;713c
	jr c,L_7151		;713e
	sub 077h		;7140
	add a,a			;7142
	ld c,a			;7143
	ld a,020h		;7144
	sub c			;7146
	add a,000h		;7147
	ld l,a			;7149
	adc a,05eh		;714a
	sub l			;714c
	ld h,a			;714d
	call L_7192		;714e
L_7151:
	pop hl			;7151
	ld a,h			;7152
	cp 005h		;7153
	jr nc,L_7174		;7155
	ld a,005h		;7157
	sub h			;7159
	add a,a			;715a
	ld c,a			;715b
	ld b,000h		;715c
	add a,a			;715e
	add a,a			;715f
	add a,a			;7160
	ld l,a			;7161
	ld h,b			;7162
	add hl,hl			;7163
	add hl,bc			;7164
	add hl,hl			;7165
	dec hl			;7166
	ld c,l			;7167
	ld b,h			;7168
	ld hl,05e00h		;7169
	ld (hl),0d5h		;716c
	ld d,h			;716e
	ld e,l			;716f
	inc de			;7170
	ldir		;7171
	ret			;7173
L_7174:
	cp 05ch		;7174
	ret c			;7176
	sub 05bh		;7177
	add a,a			;7179
	ld c,a			;717a
	ld b,000h		;717b
	add a,a			;717d
	add a,a			;717e
	add a,a			;717f
	ld l,a			;7180
	ld h,b			;7181
	add hl,hl			;7182
	add hl,bc			;7183
	add hl,hl			;7184
	ld c,l			;7185
	ld b,h			;7186
	ld hl,061b6h		;7187
	ld d,h			;718a
	ld e,l			;718b
	dec de			;718c
	ld (hl),0d5h		;718d
	lddr		;718f
	ret			;7191
L_7192:
	ld a,0d5h		;7192
	ld de,00022h		;7194
L_7197:
	push hl			;7197
	ld b,01ah		;7198
L_719A:
	ld (hl),a			;719a
	add hl,de			;719b
	djnz L_719A		;719c
	pop hl			;719e
	inc hl			;719f
	dec c			;71a0
	jr nz,L_7197		;71a1
	ret			;71a3
L_71A4:
	push hl			;71a4
	push hl			;71a5
	exx			;71a6
	ld hl,05e00h		;71a7
	ld de,05e01h		;71aa
	ld bc,00351h		;71ad
	ld (hl),080h		;71b0
	ldir		;71b2
	exx			;71b4
	inc h			;71b5
	call L_8108		;71b6
	ld de,0fd30h		;71b9
	add ix,de		;71bc
	call L_7643		;71be
	pop hl			;71c1
	call L_7129		;71c2
	pop hl			;71c5
	ld a,000h		;71c6
	xor 001h		;71c8
	ld (071c7h),a		;71ca
	ret nz			;71cd
	ld a,010h		;71ce
	ld iy,05f62h		;71d0
	add a,a			;71d4
	add a,a			;71d5
	add a,0b5h		;71d6
	ld e,a			;71d8
	adc a,077h		;71d9
	sub e			;71db
	ld d,a			;71dc
	ld a,(de)			;71dd
	ld (iy+000h),a		;71de
	inc de			;71e1
	ld a,(de)			;71e2
	ld (iy+001h),a		;71e3
	inc de			;71e6
	ld a,(de)			;71e7
	ld (iy+022h),a		;71e8
	inc de			;71eb
	ld a,(de)			;71ec
	ld (iy+023h),a		;71ed
	ret			;71f0
L_71F1:
	call L_7599		;71f1
L_71F4:
	ld a,010h		;71f4
	ld (071cfh),a		;71f6
L_71F9:
	call L_71A4		;71f9
	ld a,(071cfh)		;71fc
	cp 010h		;71ff
	jr z,L_720B		;7201
	call L_6F0B		;7203
	call L_709D		;7206
	jr L_7214		;7209
L_720B:
	call L_70B7		;720b
	call L_6EA6		;720e
	call c,L_6F0B		;7211
L_7214:
	call L_6E2D		;7214
	push hl			;7217
	call L_75A5		;7218
	pop hl			;721b
	call 0066dh		;721c
	bit 6,a		;721f
	call nz,L_72F5		;7221
	push af			;7224
	call L_734B		;7225
	pop af			;7228
	bit 4,a		;7229
	jr z,L_71F9		;722b
	ld a,(071cfh)		;722d
	cp 010h		;7230
	jp nz,L_72A6		;7232
	call L_6EA6		;7235
	ret nc			;7238
	call L_7751		;7239
	jr c,L_71F9		;723c
	ld a,000h		;723e
	or a			;7240
	jp nz,L_71F4		;7241
	push hl			;7244
	ld hl,07e02h		;7245
	call L_641A		;7248
	push af			;724b
	call L_7F40		;724c
	pop af			;724f
	pop hl			;7250
	or a			;7251
	jp z,L_71F4		;7252
	dec a			;7255
	jr nz,L_726B		;7256
	push af			;7258
	push hl			;7259
	ld hl,07e38h		;725a
	call L_641A		;725d
	ld (072b4h),a		;7260
	call L_7F40		;7263
	pop hl			;7266
	ld (07282h),hl		;7267
	pop af			;726a
L_726B:
	ld (072afh),a		;726b
	ld a,012h		;726e
	ld (071cfh),a		;7270
	push hl			;7273
	call L_8108		;7274
	ld (L_72C1+1),hl		;7277
	set 6,(hl)		;727a
	pop hl			;727c
	jp L_71F9		;727d
L_7280:
	exx			;7280
	ld hl,00000h		;7281
	call L_6EA6		;7284
	ld (072a0h),a		;7287
L_728A:
	inc a			;728a
	ld (L_6EAC+1),a		;728b
	call L_6EA6		;728e
	exx			;7291
	ld l,a			;7292
	res 7,(hl)		;7293
	inc h			;7295
	res 7,(hl)		;7296
	inc h			;7298
	ld (hl),e			;7299
	inc h			;729a
	ld (hl),d			;729b
	ld h,0b9h		;729c
	exx			;729e
	cp 000h		;729f
	jr nz,L_728A		;72a1
	exx			;72a3
	jr L_72C1		;72a4
L_72A6:
	call L_7599		;72a6
	ld d,h			;72a9
	ld e,l			;72aa
	ld hl,(L_6EAC+1)		;72ab
	ld a,000h		;72ae
	or a			;72b0
	jr nz,L_72CA		;72b1
	ld a,000h		;72b3
	or a			;72b5
	jr nz,L_7280		;72b6
	res 7,(hl)		;72b8
	inc h			;72ba
	res 7,(hl)		;72bb
	inc h			;72bd
	ld (hl),e			;72be
	inc h			;72bf
	ld (hl),d			;72c0
L_72C1:
	ld hl,00000h		;72c1
	res 6,(hl)		;72c4
	ex de,hl			;72c6
	jp L_71F4		;72c7
L_72CA:
	push de			;72ca
	push hl			;72cb
	ex de,hl			;72cc
	call L_6EA6		;72cd
	pop hl			;72d0
	pop de			;72d1
	jp nc,L_72C1		;72d2
	push de			;72d5
	push hl			;72d6
	ex de,hl			;72d7
	call L_773F		;72d8
	pop hl			;72db
	pop de			;72dc
	jr c,L_72C1		;72dd
	ld a,(L_6EAC+1)		;72df
	res 7,(hl)		;72e2
	inc h			;72e4
	res 7,(hl)		;72e5
	inc h			;72e7
	ld (hl),a			;72e8
	inc h			;72e9
	ld (hl),0ffh		;72ea
	ld a,(072afh)		;72ec
	dec a			;72ef
	jr nz,L_72C1		;72f0
	dec (hl)			;72f2
	jr L_72C1		;72f3
L_72F5:
	push hl			;72f5
	xor a			;72f6
	ld (06be4h),a		;72f7
	call L_733E		;72fa
	ld (07316h),a		;72fd
	inc a			;7300
	ld hl,06b3dh		;7301
	call L_640A		;7304
	push af			;7307
	ld hl,06be4h		;7308
	ld (hl),0b7h		;730b
	call L_7F40		;730d
	pop af			;7310
	pop hl			;7311
	or a			;7312
	ret z			;7313
	dec a			;7314
	cp 000h		;7315
	ret z			;7317
	push hl			;7318
	ld h,0b9h		;7319
	ld c,a			;731b
	ld l,a			;731c
	ld a,(hl)			;731d
	inc h			;731e
	or (hl)			;731f
	and 07fh		;7320
	jr z,L_733A		;7322
	ld a,(07316h)		;7324
	ld (06a4ch),a		;7327
	ld l,a			;732a
	dec h			;732b
	res 7,(hl)		;732c
	inc h			;732e
	res 7,(hl)		;732f
	inc h			;7331
	ld (hl),c			;7332
	inc h			;7333
	ld a,0ffh		;7334
	ld (hl),a			;7336
	ld (06a48h),a		;7337
L_733A:
	pop hl			;733a
	jp L_7599		;733b
L_733E:
	ld hl,0bd00h		;733e
L_7341:
	ld a,(hl)			;7341
	and 010h		;7342
	jr nz,L_7349		;7344
	inc l			;7346
	jr L_7341		;7347
L_7349:
	ld a,l			;7349
	ret			;734a
L_734B:
	ld d,a			;734b
	ld e,000h		;734c
	ld bc,0809ch		;734e
	ld a,h			;7351
	rr d		;7352
	sbc a,e			;7354
	adc a,e			;7355
	rr d		;7356
	adc a,c			;7358
	sbc a,c			;7359
	ld h,a			;735a
	ld a,l			;735b
	rr d		;735c
	sbc a,e			;735e
	adc a,e			;735f
	rr d		;7360
	adc a,b			;7362
	sbc a,b			;7363
	ld l,a			;7364
	ret			;7365
L_7366:
	ld c,000h		;7366
L_7368:
	ld e,00fh		;7368
	ld a,(ix-067h)		;736a
	and e			;736d
	cp d			;736e
	jr nz,L_7373		;736f
	set 7,c		;7371
L_7373:
	ld a,(ix-001h)		;7373
	and e			;7376
	cp d			;7377
	jr nz,L_737C		;7378
	set 6,c		;737a
L_737C:
	ld a,(ix+065h)		;737c
	and e			;737f
	cp d			;7380
	jr nz,L_7385		;7381
	set 5,c		;7383
L_7385:
	ld a,(ix-066h)		;7385
	and e			;7388
	cp d			;7389
	jr nz,L_738E		;738a
	set 4,c		;738c
L_738E:
	ld a,(ix+066h)		;738e
	and e			;7391
	cp d			;7392
	jr nz,L_7397		;7393
	set 3,c		;7395
L_7397:
	ld a,(ix-065h)		;7397
	and e			;739a
	cp d			;739b
	jr nz,L_73A0		;739c
	set 2,c		;739e
L_73A0:
	ld a,(ix+001h)		;73a0
	and e			;73a3
	cp d			;73a4
	jr nz,L_73A9		;73a5
	set 1,c		;73a7
L_73A9:
	ld a,(ix+067h)		;73a9
	and e			;73ac
	cp d			;73ad
	jr nz,L_73B1		;73ae
	inc c			;73b0
L_73B1:
	ld a,c			;73b1
	ret			;73b2
L_73B3:
	and 05ah		;73b3
	cp c			;73b5
	ld c,a			;73b6
	jr nz,L_73D2		;73b7
	ld (iy+000h),081h		;73b9
	ld (iy+001h),081h		;73bd
	ld (iy+022h),081h		;73c1
	ld (iy+023h),081h		;73c5
	ret			;73c9
L_73CA:
	ld a,c			;73ca
	ld (L_73D2+1),hl		;73cb
	ld (073f3h),de		;73ce
L_73D2:
	ld hl,00000h		;73d2
L_73D5:
	cp (hl)			;73d5
	jr c,L_73B3		;73d6
	inc hl			;73d8
	ld d,(hl)			;73d9
	inc hl			;73da
	ld e,(hl)			;73db
	inc hl			;73dc
	jr z,L_73F0		;73dd
L_73DF:
	srl d		;73df
	jr nc,L_73E4		;73e1
	inc hl			;73e3
L_73E4:
	jr nz,L_73DF		;73e4
L_73E6:
	srl e		;73e6
	jr nc,L_73EB		;73e8
	inc hl			;73ea
L_73EB:
	jr nz,L_73E6		;73eb
	jp L_73D5		;73ed
L_73F0:
	ld a,e			;73f0
	ex af,af'			;73f1
	ld bc,00000h		;73f2
	ld e,c			;73f5
	rl d		;73f6
	jr nc,L_7405		;73f8
	ld a,(hl)			;73fa
	inc hl			;73fb
	add a,e			;73fc
	ld c,a			;73fd
	adc a,b			;73fe
	sub c			;73ff
	ld b,a			;7400
	ld a,(bc)			;7401
	ld (iy-023h),a		;7402
L_7405:
	rl d		;7405
	jr nc,L_7414		;7407
	ld a,(hl)			;7409
	inc hl			;740a
	add a,e			;740b
	ld c,a			;740c
	adc a,b			;740d
	sub c			;740e
	ld b,a			;740f
	ld a,(bc)			;7410
	ld (iy-022h),a		;7411
L_7414:
	rl d		;7414
	jr nc,L_7423		;7416
	ld a,(hl)			;7418
	inc hl			;7419
	add a,e			;741a
	ld c,a			;741b
	adc a,b			;741c
	sub c			;741d
	ld b,a			;741e
	ld a,(bc)			;741f
	ld (iy-021h),a		;7420
L_7423:
	rl d		;7423
	jr nc,L_7432		;7425
	ld a,(hl)			;7427
	inc hl			;7428
	add a,e			;7429
	ld c,a			;742a
	adc a,b			;742b
	sub c			;742c
	ld b,a			;742d
	ld a,(bc)			;742e
	ld (iy-020h),a		;742f
L_7432:
	rl d		;7432
	jr nc,L_7441		;7434
	ld a,(hl)			;7436
	inc hl			;7437
	add a,e			;7438
	ld c,a			;7439
	adc a,b			;743a
	sub c			;743b
	ld b,a			;743c
	ld a,(bc)			;743d
	ld (iy-001h),a		;743e
L_7441:
	rl d		;7441
	jr nc,L_7450		;7443
	ld a,(hl)			;7445
	inc hl			;7446
	add a,e			;7447
	ld c,a			;7448
	adc a,b			;7449
	sub c			;744a
	ld b,a			;744b
	ld a,(bc)			;744c
	ld (iy+000h),a		;744d
L_7450:
	rl d		;7450
	jr nc,L_745F		;7452
	ld a,(hl)			;7454
	inc hl			;7455
	add a,e			;7456
	ld c,a			;7457
	adc a,b			;7458
	sub c			;7459
	ld b,a			;745a
	ld a,(bc)			;745b
	ld (iy+001h),a		;745c
L_745F:
	rl d		;745f
	jr nc,L_746E		;7461
	ld a,(hl)			;7463
	inc hl			;7464
	add a,e			;7465
	ld c,a			;7466
	adc a,b			;7467
	sub c			;7468
	ld b,a			;7469
	ld a,(bc)			;746a
	ld (iy+002h),a		;746b
L_746E:
	ex af,af'			;746e
	ld d,a			;746f
	rl d		;7470
	jr nc,L_747F		;7472
	ld a,(hl)			;7474
	inc hl			;7475
	add a,e			;7476
	ld c,a			;7477
	adc a,b			;7478
	sub c			;7479
	ld b,a			;747a
	ld a,(bc)			;747b
	ld (iy+021h),a		;747c
L_747F:
	rl d		;747f
	jr nc,L_748E		;7481
	ld a,(hl)			;7483
	inc hl			;7484
	add a,e			;7485
	ld c,a			;7486
	adc a,b			;7487
	sub c			;7488
	ld b,a			;7489
	ld a,(bc)			;748a
	ld (iy+022h),a		;748b
L_748E:
	rl d		;748e
	jr nc,L_749D		;7490
	ld a,(hl)			;7492
	inc hl			;7493
	add a,e			;7494
	ld c,a			;7495
	adc a,b			;7496
	sub c			;7497
	ld b,a			;7498
	ld a,(bc)			;7499
	ld (iy+023h),a		;749a
L_749D:
	rl d		;749d
	jr nc,L_74AC		;749f
	ld a,(hl)			;74a1
	inc hl			;74a2
	add a,e			;74a3
	ld c,a			;74a4
	adc a,b			;74a5
	sub c			;74a6
	ld b,a			;74a7
	ld a,(bc)			;74a8
	ld (iy+024h),a		;74a9
L_74AC:
	rl d		;74ac
	jr nc,L_74BB		;74ae
	ld a,(hl)			;74b0
	inc hl			;74b1
	add a,e			;74b2
	ld c,a			;74b3
	adc a,b			;74b4
	sub c			;74b5
	ld b,a			;74b6
	ld a,(bc)			;74b7
	ld (iy+043h),a		;74b8
L_74BB:
	rl d		;74bb
	jr nc,L_74CA		;74bd
	ld a,(hl)			;74bf
	inc hl			;74c0
	add a,e			;74c1
	ld c,a			;74c2
	adc a,b			;74c3
	sub c			;74c4
	ld b,a			;74c5
	ld a,(bc)			;74c6
	ld (iy+044h),a		;74c7
L_74CA:
	rl d		;74ca
	jr nc,L_74D6		;74cc
	ld a,(hl)			;74ce
	inc hl			;74cf
	add a,e			;74d0
	ld c,a			;74d1
	ld a,(bc)			;74d2
	ld (iy+045h),a		;74d3
L_74D6:
	rl d		;74d6
	ret nc			;74d8
	ld a,(hl)			;74d9
	inc hl			;74da
	add a,e			;74db
	ld c,a			;74dc
	ld a,(bc)			;74dd
	ld (iy+046h),a		;74de
	ret			;74e1
L_74E2:
	ld a,01ch		;74e2
	jr L_74E8		;74e4
L_74E6:
	ld a,01dh		;74e6
L_74E8:
	ld (L_74EE),a		;74e8
	ld de,0bd00h		;74eb
L_74EE:
	inc e			;74ee
	ld a,(de)			;74ef
	bit 5,a		;74f0
	jr z,L_74EE		;74f2
	ld a,e			;74f4
	ld (074ech),a		;74f5
	cp 078h		;74f8
	jr nc,L_74EE		;74fa
	cp 016h		;74fc
	jr z,L_74EE		;74fe
	cp 017h		;7500
	jr z,L_74EE		;7502
L_7504:
	ld (L_6EAC+1),a		;7504
	ret			;7507
L_7508:
	ld a,01ch		;7508
	jr L_750E		;750a
L_750C:
	ld a,01dh		;750c
L_750E:
	ld (L_7514),a		;750e
	ld de,0bd00h		;7511
L_7514:
	inc e			;7514
	ld a,(de)			;7515
	bit 5,a		;7516
	jr z,L_7514		;7518
	ld a,e			;751a
	ld (07512h),a		;751b
	cp 078h		;751e
	jr nc,L_7504		;7520
	cp 016h		;7522
	jr z,L_7504		;7524
	cp 017h		;7526
	jr nz,L_7514		;7528
	jr L_7504		;752a
L_752C:
	ld a,001h		;752c
	ld (071c7h),a		;752e
	ld a,(071cfh)		;7531
	ld (L_7593+1),a		;7534
	ld a,017h		;7537
	ld (071cfh),a		;7539
	push hl			;753c
	call L_7F40		;753d
	pop hl			;7540
	call L_74E2		;7541
	call L_7599		;7544
L_7547:
	call L_71A4		;7547
	call L_70B7		;754a
	call L_6F08		;754d
	call L_6E2D		;7550
	push hl			;7553
	ld de,077a0h		;7554
	ld hl,05e8ch		;7557
	ld bc,01501h		;755a
	call L_70D6		;755d
	call L_75A5		;7560
	pop hl			;7563
L_7564:
	call 0066dh		;7564
	bit 4,a		;7567
	jr nz,L_7593		;7569
	bit 5,a		;756b
	jr nz,L_7593		;756d
	bit 0,a		;756f
	jr z,L_7578		;7571
	call L_74E2		;7573
	jr L_7547		;7576
L_7578:
	bit 1,a		;7578
	jr z,L_7581		;757a
	call L_74E6		;757c
	jr L_7547		;757f
L_7581:
	bit 2,a		;7581
	jr z,L_758A		;7583
	call L_750C		;7585
	jr L_7547		;7588
L_758A:
	bit 3,a		;758a
	jr z,L_7564		;758c
	call L_7508		;758e
	jr L_7547		;7591
L_7593:
	ld a,000h		;7593
	ld (071cfh),a		;7595
	ret			;7598
L_7599:
	push hl			;7599
	push af			;759a
L_759B:
	call 0066dh		;759b
	bit 4,a		;759e
	jr nz,L_759B		;75a0
	pop af			;75a2
	pop hl			;75a3
	ret			;75a4
L_75A5:
	ld hl,04000h		;75a5
	exx			;75a8
	ld hl,05800h		;75a9
	ld c,018h		;75ac
	ld de,05e00h		;75ae
L_75B1:
	ld b,020h		;75b1
L_75B3:
	ld a,(de)			;75b3
	inc de			;75b4
	exx			;75b5
	ld c,a			;75b6
	res 7,c		;75b7
	add a,a			;75b9
	jp nc,L_7616		;75ba
	ld d,000h		;75bd
	add a,a			;75bf
	rl d		;75c0
	add a,a			;75c2
	rl d		;75c3
	add a,c			;75c5
	ld e,a			;75c6
	ld a,09eh		;75c7
	adc a,d			;75c9
	ld d,a			;75ca
	ld c,h			;75cb
	ld a,(de)			;75cc
	ld (hl),a			;75cd
	inc de			;75ce
	inc h			;75cf
	ld a,(de)			;75d0
	ld (hl),a			;75d1
	inc de			;75d2
	inc h			;75d3
	ld a,(de)			;75d4
	ld (hl),a			;75d5
	inc de			;75d6
	inc h			;75d7
	ld a,(de)			;75d8
	ld (hl),a			;75d9
	inc de			;75da
	inc h			;75db
	ld a,(de)			;75dc
	ld (hl),a			;75dd
	inc de			;75de
	inc h			;75df
	ld a,(de)			;75e0
	ld (hl),a			;75e1
	inc de			;75e2
	inc h			;75e3
	ld a,(de)			;75e4
	ld (hl),a			;75e5
	inc de			;75e6
	inc h			;75e7
	ld a,(de)			;75e8
	ld (hl),a			;75e9
	inc de			;75ea
	ld a,(de)			;75eb
L_75EC:
	exx			;75ec
	ld (hl),a			;75ed
	inc hl			;75ee
	exx			;75ef
	ld h,c			;75f0
	inc hl			;75f1
	ld a,l			;75f2
	or a			;75f3
	jr nz,L_75FA		;75f4
	ld a,h			;75f6
	add a,007h		;75f7
	ld h,a			;75f9
L_75FA:
	exx			;75fa
	djnz L_75B3		;75fb
	inc de			;75fd
	inc de			;75fe
	dec c			;75ff
	jp nz,L_75B1		;7600
	ld de,00000h		;7603
	ld b,018h		;7606
L_7608:
	push de			;7608
	push bc			;7609
	ld bc,00120h		;760a
	call 0074eh		;760d
	pop bc			;7610
	pop de			;7611
	inc d			;7612
	djnz L_7608		;7613
	ret			;7615
L_7616:
	ld d,032h		;7616
	add a,a			;7618
	rl d		;7619
	add a,a			;761b
	rl d		;761c
	ld e,a			;761e
	ld c,h			;761f
	ld a,(de)			;7620
	ld (hl),a			;7621
	inc e			;7622
	inc h			;7623
	ld a,(de)			;7624
	ld (hl),a			;7625
	inc e			;7626
	inc h			;7627
	ld a,(de)			;7628
	ld (hl),a			;7629
	inc e			;762a
	inc h			;762b
	ld a,(de)			;762c
	ld (hl),a			;762d
	inc e			;762e
	inc h			;762f
	ld a,(de)			;7630
	ld (hl),a			;7631
	inc e			;7632
	inc h			;7633
	ld a,(de)			;7634
	ld (hl),a			;7635
	inc e			;7636
	inc h			;7637
	ld a,(de)			;7638
	ld (hl),a			;7639
	inc e			;763a
	inc h			;763b
	ld a,(de)			;763c
	ld (hl),a			;763d
	ld a,078h		;763e
	jp L_75EC		;7640
L_7643:
	ld (L_7656+2),ix		;7643
	ld hl,L_7687		;7647
	call L_7656		;764a
	ld hl,07714h		;764d
	call L_7656		;7650
	ld hl,07708h		;7653
L_7656:
	ld ix,L_7656		;7656
	ld iy,05e00h		;765a
	ld (L_766C+1),hl		;765e
	ld c,00dh		;7661
L_7663:
	ld b,010h		;7663
	ld de,00066h		;7665
L_7668:
	ld a,(ix+000h)		;7668
	exx			;766b
L_766C:
	call L_766C		;766c
	exx			;766f
	inc iy		;7670
	inc iy		;7672
	add ix,de		;7674
	djnz L_7668		;7676
	ld de,0f9a1h		;7678
	add ix,de		;767b
	ld de,00024h		;767d
	add iy,de		;7680
	dec c			;7682
	jp nz,L_7663		;7683
	ret			;7686
L_7687:
	add a,a			;7687
	and 01eh		;7688
	ld hl,07697h		;768a
	add a,l			;768d
	ld l,a			;768e
	adc a,h			;768f
	sub l			;7690
	ld h,a			;7691
	ld e,(hl)			;7692
	inc hl			;7693
	ld d,(hl)			;7694
	push de			;7695
L_7696:
	ret			;7696

; ----------------------------------------------------------------------
; DATOS tabla_de_16_palabras_7697: Tabla de 16 palabras que 0x7687 indexa con
;   A*2 & 0x1E y despacha con push de / ret
;   0x7697..0x76b7  (32 bytes)
DATA_tabla_de_16_palabras_7697:
	defw 07696h	; 7697  -> L_7696
	defw 076b7h	; 7699  -> L_76B7
	defw 07696h	; 769b  -> L_7696
	defw 076c7h	; 769d  -> L_76C7
	defw 076e4h	; 769f  -> L_76E4
	defw 07696h	; 76a1  -> L_7696
	defw 076f0h	; 76a3  -> L_76F0
	defw 07696h	; 76a5  -> L_7696
	defw 07696h	; 76a7  -> L_7696
	defw 07696h	; 76a9  -> L_7696
	defw 07696h	; 76ab  -> L_7696
	defw 07696h	; 76ad  -> L_7696
	defw 07696h	; 76af  -> L_7696
	defw 07696h	; 76b1  -> L_7696
	defw 07696h	; 76b3  -> L_7696
	defw 07696h	; 76b5  -> L_7696

; ======================================================================
; CODIGO 0x76b7..0x77a0  (233 bytes)
; ======================================================================


L_76B7:
	ld d,002h		;76b7
	call L_7366		;76b9
	cpl			;76bc
	ld c,a			;76bd
	ld hl,0797dh		;76be
	ld de,07819h		;76c1
	jp L_73CA		;76c4
L_76C7:
	ld d,003h		;76c7
	call L_7366		;76c9
	ld d,002h		;76cc
	call L_7368		;76ce
	ld d,004h		;76d1
	call L_7368		;76d3
	ld d,005h		;76d6
	call L_7368		;76d8
	ld hl,0784dh		;76db
	ld de,0782dh		;76de
	jp L_73CA		;76e1
L_76E4:
	ld a,(ix-001h)		;76e4
	cp 006h		;76e7
	ld a,014h		;76e9
	jr z,L_7717		;76eb
	dec a			;76ed
	jr L_7717		;76ee
L_76F0:
	ld d,006h		;76f0
	call L_7366		;76f2
	ld d,004h		;76f5
	call L_7368		;76f7
	ld d,005h		;76fa
	call L_7368		;76fc
	ld hl,0784dh		;76ff
	ld de,0783dh		;7702
	jp L_73CA		;7705
L_7708:
	or a			;7708
	ret p			;7709
	bit 6,a		;770a
	ld a,011h		;770c
	jr nz,L_7717		;770e
	ld a,015h		;7710
	jr L_7717		;7712
L_7714:
	and 00fh		;7714
	ret z			;7716
L_7717:
	add a,a			;7717
	add a,a			;7718
	add a,0b5h		;7719
	ld l,a			;771b
	adc a,077h		;771c
	sub l			;771e
	ld h,a			;771f
	ld a,(hl)			;7720
	or a			;7721
	jr z,L_7727		;7722
	ld (iy+000h),a		;7724
L_7727:
	inc hl			;7727
	ld a,(hl)			;7728
	or a			;7729
	jr z,L_772F		;772a
	ld (iy+001h),a		;772c
L_772F:
	inc hl			;772f
	ld a,(hl)			;7730
	or a			;7731
	jr z,L_7737		;7732
	ld (iy+022h),a		;7734
L_7737:
	inc hl			;7737
	ld a,(hl)			;7738
	or a			;7739
	ret z			;773a
	ld (iy+023h),a		;773b
	ret			;773e
L_773F:
	ld de,06f08h		;773f
	ld (07794h),de		;7742
	call L_7751		;7746
	ld de,06f0bh		;7749
	ld (07794h),de		;774c
	ret			;7750
L_7751:
	xor a			;7751
	ld (0723fh),a		;7752
	call L_7599		;7755
L_7758:
	call 0066dh		;7758
	bit 4,a		;775b
	jp nz,L_7599		;775d
	bit 5,a		;7760
	jp z,L_7767		;7762
	scf			;7765
	ret			;7766
L_7767:
	bit 0,a		;7767
	jr z,L_7777		;7769
	ld a,(06eadh)		;776b
	inc a			;776e
	ld (06eadh),a		;776f
	call L_6EA6		;7772
	jr L_7785		;7775
L_7777:
	bit 1,a		;7777
	jr z,L_7758		;7779
	ld a,(06eadh)		;777b
	dec a			;777e
	ld (06eadh),a		;777f
	call L_6ED6		;7782
L_7785:
	ld a,001h		;7785
	ld (0723fh),a		;7787
	call L_71A4		;778a
	call L_70B7		;778d
	call L_6EA6		;7790
	call c,L_6F0B		;7793
	call L_6E2D		;7796
	push hl			;7799
	call L_75A5		;779a
	pop hl			;779d
	jr L_7758		;779e

; ----------------------------------------------------------------------
; DATOS textos_y_tablas_de_batalla: Textos de batalla ("Comienza la Batalla")
;   y tablas (0x7554, 0x76C1, 0x76DE, 0x7702, 0x76DB, 0x76BE las apuntan;
;   formato pendiente)
;   0x77a0..0x7e4f  (1711 bytes)
DATA_textos_y_tablas_de_batalla:
	defb 043h,06fh,06dh,069h,065h,06eh,07ah,061h,020h,06ch,061h,020h,042h,061h,074h,061h	; 77a0  Comienza la Bata
	defb 06ch,06ch,061h,02eh,02eh,000h,000h,000h,000h,000h,000h,000h,000h,081h,081h,081h	; 77b0  lla.............
	defb 081h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h	; 77c0  ................
	defb 000h,08ah,08bh,08ch,08dh,08eh,08fh,090h,091h,092h,093h,094h,095h,096h,097h,098h	; 77d0  ................
	defb 099h,09ah,09bh,09ch,09dh,09eh,09fh,0a0h,0a1h,0a2h,0a3h,0a4h,0a5h,0a6h,0a7h,08ch	; 77e0  ................
	defb 0a8h,0a9h,0aah,0abh,0ach,0e5h,0e6h,0e6h,0e5h,0e1h,0e2h,0e3h,0e4h,0e4h,0e3h,0e2h	; 77f0  ................
	defb 0e1h,0b3h,0b4h,0b5h,0b6h,0b7h,0b8h,0b9h,0bah,0d1h,0d2h,0d3h,0d4h,0d5h,0d6h,0d7h	; 7800  ................
	defb 0d8h,0d9h,0dah,0dbh,0dch,0ddh,0deh,0dfh,0e0h,086h,087h,088h,089h,0afh,0b0h,0b1h	; 7810  ................
	defb 0b2h,0c1h,0c2h,0c3h,0c4h,0c5h,0c6h,0c7h,0c8h,0c9h,0cah,0cbh,0cch,082h,083h,084h	; 7820  ................
	defb 085h,0bbh,0bch,0bdh,0beh,0bfh,0c0h,080h,080h,080h,080h,000h,000h,086h,087h,088h	; 7830  ................
	defb 089h,0adh,0aeh,0afh,0b0h,0b1h,0b2h,0cdh,0ceh,0cfh,0d0h,000h,000h,001h,006h,070h	; 7840  ...............p
	defb 000h,001h,002h,005h,001h,002h,006h,060h,000h,001h,007h,009h,004h,006h,064h,000h	; 7850  .......`......d.
	defb 001h,004h,003h,003h,005h,006h,074h,000h,001h,004h,005h,001h,003h,008h,006h,060h	; 7860  ......t........`
	defb 000h,008h,002h,006h,00ch,006h,064h,000h,008h,004h,006h,003h,010h,006h,060h,008h	; 7870  ......d.......`.
	defb 001h,006h,003h,011h,006h,070h,008h,001h,006h,005h,001h,018h,006h,060h,008h,008h	; 7880  .....p.......`..
	defb 006h,006h,01ah,006h,060h,008h,008h,00ch,00dh,020h,026h,060h,000h,000h,004h,002h	; 7890  ....`.... &`....
	defb 003h,021h,026h,070h,000h,000h,004h,002h,005h,001h,022h,026h,060h,000h,000h,004h	; 78a0  .!&p......"&`...
	defb 007h,009h,024h,026h,064h,000h,000h,004h,004h,003h,003h,025h,026h,074h,000h,000h	; 78b0  ..$&d......%&t..
	defb 004h,004h,005h,001h,003h,030h,026h,060h,000h,008h,004h,006h,003h,031h,026h,070h	; 78c0  .....0&`.....1&p
	defb 000h,008h,004h,006h,005h,001h,040h,006h,060h,007h,009h,002h,003h,041h,006h,070h	; 78d0  ......@.`....A.p
	defb 007h,009h,002h,005h,001h,042h,006h,060h,007h,009h,007h,009h,044h,006h,064h,007h	; 78e0  .....B.`....D.d.
	defb 009h,004h,003h,003h,045h,006h,074h,007h,009h,004h,005h,001h,003h,04ah,006h,060h	; 78f0  ....E.t......J.`
	defb 007h,00bh,007h,00dh,052h,006h,060h,00ah,009h,00ch,009h,058h,006h,060h,00ah,00bh	; 7900  ....R.`....X.`..
	defb 006h,006h,05ah,006h,060h,00ah,00bh,00ch,00dh,080h,00eh,060h,002h,005h,001h,002h	; 7910  ..Z.`......`....
	defb 003h,081h,00eh,070h,002h,005h,001h,002h,005h,001h,082h,00eh,060h,002h,005h,001h	; 7920  ...p........`...
	defb 007h,009h,084h,00eh,064h,002h,005h,001h,004h,003h,003h,085h,00eh,074h,002h,005h	; 7930  ....d........t..
	defb 001h,004h,005h,001h,003h,088h,00eh,060h,002h,005h,008h,002h,006h,08ch,00eh,064h	; 7940  .......`.......d
	defb 002h,005h,008h,004h,006h,003h,0a0h,02eh,060h,000h,002h,005h,004h,002h,003h,0a1h	; 7950  ........`.......
	defb 02eh,070h,000h,002h,005h,004h,002h,005h,001h,0a2h,02eh,060h,000h,002h,005h,004h	; 7960  .p.........`....
	defb 007h,009h,0a4h,02eh,064h,000h,002h,005h,004h,004h,003h,003h,0ffh,007h,006h,060h	; 7970  ....d..........`
	defb 00eh,011h,009h,00ch,00fh,006h,060h,00eh,00dh,009h,004h,017h,006h,060h,00dh,011h	; 7980  ......`......`..
	defb 004h,00ch,01fh,006h,060h,00dh,00dh,004h,004h,029h,006h,060h,00eh,009h,00ah,00bh	; 7990  ....`....).`....
	defb 02bh,006h,060h,00eh,009h,008h,007h,02fh,006h,060h,00eh,009h,009h,003h,03fh,006h	; 79a0  +.`..../.`....?.
	defb 060h,00dh,009h,004h,003h,069h,006h,060h,008h,007h,00ah,00bh,06bh,006h,060h,008h	; 79b0  `....i.`....k.`.
	defb 007h,008h,007h,06fh,006h,060h,008h,007h,009h,003h,094h,006h,060h,00ch,011h,00fh	; 79c0  ...o.`......`...
	defb 013h,096h,006h,060h,00ch,011h,005h,010h,097h,006h,060h,00ch,011h,002h,00ch,09fh	; 79d0  ...`......`.....
	defb 006h,060h,00ch,00dh,002h,004h,0bfh,006h,060h,00ch,009h,002h,003h,0d4h,006h,060h	; 79e0  .`......`......`
	defb 005h,010h,00fh,013h,0d6h,006h,060h,005h,010h,005h,010h,0d7h,006h,060h,005h,010h	; 79f0  ......`......`..
	defb 002h,00ch,0e0h,006h,060h,00bh,00fh,00ah,013h,0e8h,006h,060h,00bh,006h,00ah,012h	; 7a00  ....`......`....
	defb 0e9h,006h,060h,00bh,001h,00ah,00bh,0ebh,006h,060h,00bh,001h,008h,007h,0efh,006h	; 7a10  ..`......`......
	defb 060h,00bh,001h,009h,003h,0f0h,006h,060h,006h,00fh,012h,013h,0f4h,006h,060h,000h	; 7a20  `......`......`.
	defb 00fh,00fh,013h,0f6h,006h,060h,000h,00fh,005h,010h,0f7h,006h,060h,000h,00fh,002h	; 7a30  .....`......`...
	defb 00ch,0f8h,006h,060h,006h,006h,012h,012h,0f9h,006h,060h,006h,001h,012h,00bh,0fch	; 7a40  ...`......`.....
	defb 006h,060h,000h,006h,00fh,012h,0fdh,006h,060h,000h,001h,00fh,00bh,0ffh,041h,036h	; 7a50  .`......`.....A6
	defb 009h,071h,04fh,072h,074h,068h,061h,06eh,063h,068h,03fh,00ah,081h,04fh,072h,06fh	; 7a60  .qOrthanch?..Oro
	defb 064h,072h,075h,069h,06eh,060h,037h,00ah,081h,04dh,06fh,072h,061h,06eh,06eh,06fh	; 7a70  druin`7..Moranno
	defb 06eh,056h,03fh,00eh,062h,04dh,069h,06eh,061h,073h,020h,054h,069h,072h,069h,074h	; 7a80  nV?.bMinas Tirit
	defb 068h,05fh,040h,00eh,062h,04dh,069h,06eh,061h,073h,020h,04dh,06fh,072h,067h,075h	; 7a90  h_@.bMinas Morgu
	defb 06ch,045h,017h,00bh,091h,052h,069h,076h,065h,06eh,064h,065h,06ch,06ch,064h,03ah	; 7aa0  lE...Rivendelld:
	defb 00ch,0a1h,049h,073h,065h,06eh,06dh,06fh,075h,074h,068h,065h,06fh,040h,00bh,091h	; 7ab0  ..Isenmoutheo@..
	defb 042h,061h,072h,061h,064h,02dh,044h,075h,072h,063h,041h,00eh,062h,043h,069h,072h	; 7ac0  Barad-DurcA.bCir
	defb 069h,074h,068h,055h,06eh,067h,06fh,06ch,020h,061h,03ch,00ah,081h,044h,075h,072h	; 7ad0  ithUngol a<..Dur
	defb 074h,068h,061h,06eh,067h,054h,027h,00eh,062h,044h,06fh,06ch,020h,020h,020h,047h	; 7ae0  thangT'.bDol   G
	defb 075h,06ch,064h,075h,072h,044h,063h,007h,051h,055h,06dh,062h,061h,072h,014h,01eh	; 7af0  uldurDc.QUmbar..
	defb 009h,071h,048h,061h,072h,06ch,06fh,06eh,064h,064h,00fh,006h,041h,044h,061h,06ch	; 7b00  .qHarlondd..ADal
	defb 065h,035h,019h,006h,041h,042h,072h,065h,065h,033h,010h,009h,071h,046h,06fh,072h	; 7b10  e5..ABree3..qFor
	defb 06eh,06fh,073h,074h,030h,01bh,00ah,081h,042h,075h,063h,06bh,06ch,061h,06eh,064h	; 7b20  nost0...Buckland
	defb 028h,016h,009h,071h,042h,079h,077h,061h,074h,065h,072h,025h,01bh,00ah,081h,048h	; 7b30  (..qBywater%...H
	defb 06fh,062h,062h,069h,074h,06fh,06eh,022h,017h,010h,072h,04dh,069h,063h,068h,065h	; 7b40  obbiton"..rMiche
	defb 06ch,020h,044h,065h,06ch,076h,069h,06eh,067h,01fh,017h,00bh,091h,046h,061h,072h	; 7b50  l Delving....Far
	defb 020h,044h,06fh,077h,06eh,073h,035h,028h,009h,071h,054h,068h,061h,072h,062h,061h	; 7b60   Downs5(.qTharba
	defb 064h,045h,038h,008h,061h,045h,064h,06fh,072h,061h,073h,041h,03bh,00ch,052h,048h	; 7b70  dE8.aEdorasA;.RH
	defb 065h,06ch,06dh,073h,044h,065h,065h,070h,020h,046h,04ch,00eh,062h,044h,06fh,06ch	; 7b80  elmsDeep FL.bDol
	defb 020h,020h,020h,041h,06dh,072h,06fh,074h,068h,051h,049h,008h,061h,04ch,069h,06eh	; 7b90     AmrothQI.aLin
	defb 068h,069h,072h,05ch,043h,00ah,081h,050h,065h,06ch,061h,072h,067h,069h,072h,049h	; 7ba0  hir\C..PelargirI
	defb 007h,012h,082h,04dh,06fh,06eh,074h,065h,020h,020h,020h,047h,075h,06eh,064h,061h	; 7bb0  ...Monte   Gunda
	defb 062h,061h,064h,019h,019h,00eh,062h,047h,072h,065h,079h,020h,020h,048h,061h,076h	; 7bc0  bad...bGrey  Hav
	defb 065h,06eh,073h,00ah,004h,000h,0a2h,048h,065h,063h,068h,06fh,020h,070h,06fh,072h	; 7bd0  ens....Hecho por
	defb 03ah,020h,043h,02eh,04ah,02eh,050h,069h,06eh,06bh,020h,020h,050h,06fh,073h,069h	; 7be0  : C.J.Pink  Posi
	defb 063h,069h,06fh,06eh,03ah,020h,023h,023h,023h,05eh,04eh,02ch,023h,023h,023h,05eh	; 7bf0  cion: ###^N,###^
	defb 045h,044h,065h,073h,074h,069h,06eh,06fh,03ah,020h,020h,020h,023h,023h,023h,05eh	; 7c00  EDestino:   ###^
	defb 04eh,02ch,023h,023h,023h,05eh,045h,041h,020h,043h,06fh,06dh,061h,06eh,064h,06fh	; 7c10  N,###^EA Comando
	defb 020h,064h,065h,020h,023h,023h,023h,020h,045h,06eh,061h,06eh,06fh,073h,020h,045h	; 7c20   de ### Enanos E
	defb 06eh,061h,06eh,06fh,03ah,063h,061h,072h,061h,063h,074h,065h,072h,03ah,020h,020h	; 7c30  nano:caracter:  
	defb 020h,020h,020h,020h,020h,020h,020h,064h,065h,073h,074h,069h,06eh,06fh,03ah,020h	; 7c40         destino: 
	defb 023h,023h,023h,05eh,04eh,02ch,023h,023h,023h,05eh,057h,020h,020h,020h,020h,04eh	; 7c50  ###^N,###^W    N
	defb 06fh,020h,06dh,075h,079h,020h,065h,06eh,065h,072h,067h,069h,063h,06fh,020h,020h	; 7c60  o muy energico  
	defb 020h,020h,020h,020h,020h,020h,020h,04eh,06fh,020h,06dh,075h,079h,020h,064h,065h	; 7c70         No muy de
	defb 063h,069h,064h,069h,064h,06fh,020h,020h,020h,020h,020h,020h,020h,020h,020h,04eh	; 7c80  cidido         N
	defb 06fh,020h,06dh,075h,079h,020h,068h,061h,062h,069h,06ch,020h,020h,020h,020h,020h	; 7c90  o muy habil     
	defb 020h,020h,020h,020h,020h,020h,020h,04eh,06fh,020h,06dh,075h,079h,020h,076h,061h	; 7ca0         No muy va
	defb 06ch,065h,072h,06fh,073h,06fh,020h,020h,020h,020h,020h,020h,020h,020h,020h,04eh	; 7cb0  leroso         N
	defb 06fh,020h,06dh,075h,079h,020h,062h,072h,061h,076h,06fh,020h,020h,020h,020h,020h	; 7cc0  o muy bravo     
	defb 020h,020h,020h,020h,020h,020h,020h,04eh,06fh,020h,06dh,075h,079h,020h,066h,075h	; 7cd0         No muy fu
	defb 065h,072h,074h,065h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,046h	; 7ce0  erte           F
	defb 06fh,072h,06dh,061h,020h,075h,06eh,061h,020h,061h,06ch,069h,061h,06eh,07ah,061h	; 7cf0  orma una alianza
	defb 020h,020h,020h,020h,020h,020h,020h,042h,072h,075h,06ah,06fh,073h,0a0h,04eh,061h	; 7d00         Brujos.Na
	defb 07ah,067h,075h,0ech,048h,075h,0edh,045h,06ch,066h,06fh,0f3h,045h,06eh,061h,06eh	; 7d10  zgu.Hu.Elfo.Enan
	defb 06fh,073h,0a0h,04fh,072h,063h,0f3h,048h,06fh,062h,062h,069h,074h,0f3h,042h,072h	; 7d20  os.Orc.Hobbit.Br
	defb 075h,06ah,06fh,0a0h,047h,06fh,06ch,06ch,075h,0edh,042h,072h,075h,06ah,06fh,0a0h	; 7d30  ujo.Gollu.Brujo.
	defb 04eh,061h,07ah,067h,075h,0ech,048h,075h,0edh,045h,06ch,0e6h,045h,06eh,061h,06eh	; 7d40  Nazgu.Hu.El.Enan
	defb 0efh,04fh,072h,0e3h,048h,06fh,062h,062h,069h,0f4h,042h,072h,075h,06ah,06fh,0a0h	; 7d50  .Or.Hobbi.Brujo.
	defb 047h,06fh,06ch,06ch,075h,0edh,04dh,075h,06ah,065h,0f2h,020h,053h,06fh,063h,069h	; 7d60  Gollu.Muje. Soci
	defb 065h,064h,061h,064h,020h,0a0h,0adh,020h,075h,06eh,069h,06fh,06eh,0a0h,020h,075h	; 7d70  edad .. union. u
	defb 06eh,069h,06fh,0eeh,046h,06fh,072h,06dh,061h,063h,069h,06fh,06eh,020h,064h,0e5h	; 7d80  nio.Formacion d.
	defb 03ah,063h,061h,072h,061h,063h,074h,065h,072h,03ah,0a0h,052h,065h,061h,06ch,06dh	; 7d90  :caracter:.Realm
	defb 065h,06eh,074h,065h,0a0h,020h,04dh,075h,079h,0a0h,020h,045h,073h,020h,06dh,075h	; 7da0  ente. Muy. Es mu
	defb 0f9h,0a0h,020h,045h,073h,020h,061h,06ch,067h,06fh,0a0h,020h,04eh,06fh,020h,06dh	; 7db0  .. Es algo. No m
	defb 075h,079h,020h,0a0h,020h,04eh,06fh,0a0h,020h,04eh,06fh,020h,065h,073h,020h,06dh	; 7dc0  uy . No. No es m
	defb 075h,079h,0a0h,020h,045h,06eh,065h,072h,067h,069h,063h,0efh,020h,044h,065h,063h	; 7dd0  uy. Energic. Dec
	defb 069h,064h,069h,064h,06fh,0a0h,020h,048h,061h,062h,069h,06ch,020h,020h,0a0h,020h	; 7de0  idido. Habil  . 
	defb 056h,061h,06ch,069h,06fh,073h,0efh,020h,044h,075h,072h,0efh,020h,042h,072h,061h	; 7df0  Valios. Dur. Bra
	defb 076h,0efh,003h,011h,056h,075h,065h,06ch,076h,065h,0b7h,0b7h,045h,06ch,069h,067h	; 7e00  v...Vuelve..Elig
	defb 065h,020h,064h,065h,073h,074h,069h,06eh,06fh,020h,020h,0b7h,0b7h,045h,06ch,069h	; 7e10  e destino  ..Eli
	defb 067h,065h,020h,055h,06eh,069h,06fh,06eh,0b7h,0b7h,045h,06ch,069h,067h,065h,020h	; 7e20  ge Union..Elige 
	defb 063h,061h,06dh,069h,06eh,06fh,020h,000h,001h,00bh,049h,06eh,064h,069h,076h,069h	; 7e30  camino ...Indivi
	defb 064h,075h,061h,06ch,0b7h,0b7h,054h,06fh,064h,06fh,073h,020h,020h,020h,000h	; 7e40  dual..Todos   .

; ======================================================================
; CODIGO 0x7e4f..0x8030  (481 bytes)
; ======================================================================


L_7E4F:
	ld a,b			;7e4f
	and 0c0h		;7e50
	rra			;7e52
	scf			;7e53
	rra			;7e54
	rrca			;7e55
	xor b			;7e56
	and 0f8h		;7e57
	xor b			;7e59
	ld h,a			;7e5a
	ld a,c			;7e5b
	rlca			;7e5c
	rlca			;7e5d
	rlca			;7e5e
	xor b			;7e5f
	and 0c7h		;7e60
	xor b			;7e62
	rlca			;7e63
	rlca			;7e64
	ld l,a			;7e65
	ld a,c			;7e66
	rrca			;7e67
	and 003h		;7e68
	ld b,a			;7e6a
	inc b			;7e6b
	ld a,0fch		;7e6c
L_7E6E:
	rrca			;7e6e
	rrca			;7e6f
	djnz L_7E6E		;7e70
	ld b,a			;7e72
	cpl			;7e73
	ld c,a			;7e74
	ld a,0ffh		;7e75
	and c			;7e77
	ld c,a			;7e78
	ret			;7e79
L_7E7A:
	and 003h		;7e7a
	add a,0f8h		;7e7c
	ld l,a			;7e7e
	ld h,083h		;7e7f
	ld a,(hl)			;7e81
	ld (07e76h),a		;7e82
	ret			;7e85
L_7E86:
	ld a,l			;7e86
	rrca			;7e87
	and 003h		;7e88
	add a,0fch		;7e8a
	ld e,a			;7e8c
	adc a,083h		;7e8d
	sub e			;7e8f
	ld d,a			;7e90
	ld a,(de)			;7e91
	ld c,a			;7e92
	ld a,h			;7e93
	and 007h		;7e94
	add a,000h		;7e96
	ld e,a			;7e98
	adc a,000h		;7e99
	sub e			;7e9b
	ld d,a			;7e9c
	ld a,b			;7e9d
	cpl			;7e9e
	ld b,a			;7e9f
	ld a,(de)			;7ea0
	and b			;7ea1
	ld c,a			;7ea2
	ld a,b			;7ea3
	cpl			;7ea4
	ld b,a			;7ea5
	ld a,(hl)			;7ea6
	and b			;7ea7
	or c			;7ea8
	ld (hl),a			;7ea9
	ret			;7eaa
L_7EAB:
	call L_7E86		;7eab
L_7EAE:
	inc h			;7eae
	ld a,h			;7eaf
	and 007h		;7eb0
	ret nz			;7eb2
	ld a,h			;7eb3
	sub 008h		;7eb4
	ld h,a			;7eb6
	ld a,l			;7eb7
	add a,020h		;7eb8
	ld l,a			;7eba
	ret nc			;7ebb
	ld a,h			;7ebc
	add a,008h		;7ebd
	ld h,a			;7ebf
	ret			;7ec0
L_7EC1:
	call L_7E86		;7ec1
L_7EC4:
	dec h			;7ec4
	ld a,h			;7ec5
	and 007h		;7ec6
	cp 007h		;7ec8
	ret nz			;7eca
	ld a,h			;7ecb
	add a,008h		;7ecc
	ld h,a			;7ece
	ld a,l			;7ecf
	sub 020h		;7ed0
	ld l,a			;7ed2
	ret nc			;7ed3
	ld a,h			;7ed4
	sub 008h		;7ed5
	ld h,a			;7ed7
	ret			;7ed8
L_7ED9:
	call L_7E86		;7ed9
L_7EDC:
	rrc c		;7edc
	rrc c		;7ede
	rrc b		;7ee0
	rrc b		;7ee2
	ret c			;7ee4
	inc hl			;7ee5
	ret			;7ee6
L_7EE7:
	call L_7E86		;7ee7
L_7EEA:
	rlc c		;7eea
	rlc c		;7eec
	rlc b		;7eee
	rlc b		;7ef0
	ret c			;7ef2
	dec hl			;7ef3
	ret			;7ef4
L_7EF5:
	ld a,(hl)			;7ef5
	and b			;7ef6
	or c			;7ef7
	ld (hl),a			;7ef8
	ret			;7ef9
L_7EFA:
	ld de,00000h		;7efa
	ld a,d			;7efd
	and 007h		;7efe
	rrca			;7f00
	rrca			;7f01
	rrca			;7f02
	or e			;7f03
	ld e,a			;7f04
	ld a,d			;7f05
	and 018h		;7f06
	or 040h		;7f08
	ld d,a			;7f0a
	ld (0827eh),de		;7f0b
	ret			;7f0f
L_7F10:
	ld a,047h		;7f10
L_7F12:
	ld (07f2ch),a		;7f12
	call 0049fh		;7f15
	ld hl,02000h		;7f18
	ld bc,01800h		;7f1b
	call 00429h		;7f1e
	ld hl,00000h		;7f21
	ld bc,01800h		;7f24
	xor a			;7f27
	call 00429h		;7f28
	ld a,000h		;7f2b
	ld hl,05affh		;7f2d
	ld de,05afeh		;7f30
	ld bc,00300h		;7f33
	ld (hl),a			;7f36
	lddr		;7f37
	ld (hl),c			;7f39
	ld bc,017ffh		;7f3a
	lddr		;7f3d
	ret			;7f3f
L_7F40:
	xor a			;7f40
	jr L_7F12		;7f41
L_7F43:
	ld hl,0c600h		;7f43
	ld de,0c601h		;7f46
	ld bc,000feh		;7f49
	ld (hl),e			;7f4c
	ldir		;7f4d
	ld a,0ffh		;7f4f
	ld (08333h),a		;7f51
L_7F54:
	call L_8166		;7f54
L_7F57:
	call 007c3h		;7f57
	ld a,(06511h)		;7f5a
	bit 5,a		;7f5d
	call nz,L_812E		;7f5f
	call L_650D		;7f62
	call L_6719		;7f65
	call L_6A47		;7f68
	call L_831B		;7f6b
	call L_733E		;7f6e
	ld l,a			;7f71
	ld h,0b9h		;7f72
	ld a,(hl)			;7f74
	cp 068h		;7f75
	jr nz,L_7F80		;7f77
	inc h			;7f79
	ld a,(hl)			;7f7a
	cp 03fh		;7f7b
	jp z,L_83D9		;7f7d
L_7F80:
	call L_92DE		;7f80
	ld a,(06511h)		;7f83
	bit 4,a		;7f86
	jp z,L_7F57		;7f88
	ld hl,(064dah)		;7f8b
	ld a,h			;7f8e
	rrca			;7f8f
	rrca			;7f90
	rrca			;7f91
	and 003h		;7f92
	or 058h		;7f94
	ld h,a			;7f96
	inc hl			;7f97
	ld a,(hl)			;7f98
	cp 078h		;7f99
	jr z,L_7FFF		;7f9b
	ld hl,(06543h)		;7f9d
	ld a,l			;7fa0
	srl a		;7fa1
	add a,008h		;7fa3
	ld c,a			;7fa5
	ld a,h			;7fa6
	srl a		;7fa7
	add a,003h		;7fa9
	ld b,a			;7fab
L_7FAC:
	push bc			;7fac
	call L_7F40		;7fad
	ld c,000h		;7fb0
L_7FB2:
	ld a,c			;7fb2
	cp 016h		;7fb3
	jr z,L_7FCE		;7fb5
	cp 017h		;7fb7
	jr z,L_7FCE		;7fb9
	ld b,0b9h		;7fbb
	ld a,(bc)			;7fbd
	and 07fh		;7fbe
	ld l,a			;7fc0
	inc b			;7fc1
	ld a,(bc)			;7fc2
	and 07fh		;7fc3
	ld h,a			;7fc5
	or l			;7fc6
	jr z,L_7FCE		;7fc7
	call L_8108		;7fc9
	set 7,(hl)		;7fcc
L_7FCE:
	inc c			;7fce
	ld a,c			;7fcf
	cp 078h		;7fd0
	jr nz,L_7FB2		;7fd2
	pop hl			;7fd4
	call L_71F1		;7fd5
	ld (06546h),hl		;7fd8
	ld a,h			;7fdb
	add a,a			;7fdc
	sub 006h		;7fdd
	ld h,a			;7fdf
	ld a,l			;7fe0
	add a,a			;7fe1
	sub 010h		;7fe2
	ld l,a			;7fe4
	ld (06543h),hl		;7fe5
	ld hl,0cc00h		;7fe8
	ld e,07fh		;7feb
	ld bc,033cch		;7fed
L_7FF0:
	ld a,(hl)			;7ff0
	and e			;7ff1
	ld (hl),a			;7ff2
	inc hl			;7ff3
	dec bc			;7ff4
	ld a,b			;7ff5
	or c			;7ff6
	jr nz,L_7FF0		;7ff7
	jp L_7F54		;7ff9
L_7FFC:
	jp L_7F57		;7ffc
L_7FFF:
	ld a,(06544h)		;7fff
	cp 062h		;8002
	jr c,L_7FFC		;8004
	cp 081h		;8006
	jp nc,L_81EA		;8008
	ld hl,08400h		;800b
	call L_641A		;800e
	and a			;8011
	jp z,L_7F54		;8012
	ld hl,09627h		;8015
	dec a			;8018
	jr z,L_8024		;8019
	ld hl,09654h		;801b
	dec a			;801e
	jr z,L_8024		;801f
	jp L_7F54		;8021
L_8024:
	ld (06546h),hl		;8024
	ld (0802bh),hl		;8027
	call 00000h		;802a   ; BIOS CHKRAM - Tests RAM and sets RAM slot for the system  [alias: STARTUP, RESET, BOOT]
	jp L_7F54		;802d

; ----------------------------------------------------------------------
; DATOS tabla_de_10_palabras_8030: Tabla de 10 palabras (indice 1..10) que
;   0x804D-0x805B indexa con A y salta con jp (hl)
;   0x8030..0x8044  (20 bytes)
DATA_tabla_de_10_palabras_8030:
	defw 08071h	; 8030  -> L_8071
	defw 08062h	; 8032  -> L_8062
	defw 08068h	; 8034  -> L_8068
	defw 08068h	; 8036  -> L_8068
	defw 0805ch	; 8038  -> L_805C
	defw 080aeh	; 803a  -> L_80AE
	defw 080adh	; 803c  -> L_80AD
	defw 080adh	; 803e  -> L_80AD
	defw 080adh	; 8040  -> L_80AD
	defw 080adh	; 8042  -> L_80AD

; ======================================================================
; CODIGO 0x8044..0x83f8  (948 bytes)
; ======================================================================


L_8044:
	and a			;8044
	ret z			;8045
	push bc			;8046
	push af			;8047
	call L_7E7A		;8048
	pop af			;804b
	pop bc			;804c
	ld e,a			;804d
	add a,a			;804e
	add a,02eh		;804f
	ld l,a			;8051
	adc a,080h		;8052
	sub l			;8054
	ld h,a			;8055
	ld a,(hl)			;8056
	inc hl			;8057
	ld h,(hl)			;8058
	ld l,a			;8059
	ld a,e			;805a
	jp (hl)			;805b
L_805C:
	push bc			;805c
	ld a,001h		;805d
	ld e,a			;805f
	jr L_806D		;8060
L_8062:
	push bc			;8062
	ld a,002h		;8063
	ld e,a			;8065
	jr L_806D		;8066
L_8068:
	push bc			;8068
	ld a,001h		;8069
	ld e,003h		;806b
L_806D:
	call L_7E7A		;806d
	pop bc			;8070
L_8071:
	push bc			;8071
	sla b		;8072
	sla c		;8074
	call L_7E4F		;8076
	call L_7EF5		;8079
	call L_7EDC		;807c
	ld a,(iy+066h)		;807f
	and 00fh		;8082
	cp e			;8084
	call z,L_7EF5		;8085
	call L_7EAE		;8088
	ld a,(iy+067h)		;808b
	and 00fh		;808e
	cp e			;8090
	call z,L_7EF5		;8091
	call L_7EEA		;8094
	ld a,(iy+001h)		;8097
	and 00fh		;809a
	cp e			;809c
	call z,L_7EF5		;809d
	call L_7EEA		;80a0
	ld a,(iy-065h)		;80a3
	and 00fh		;80a6
	cp e			;80a8
	call z,L_7EF5		;80a9
	pop bc			;80ac
L_80AD:
	ret			;80ad
L_80AE:
	push bc			;80ae
	sla b		;80af
	sla c		;80b1
	call L_7E4F		;80b3
	call L_7EF5		;80b6
	pop bc			;80b9
	ret			;80ba
L_80BB:
	pop af			;80bb
	ret			;80bc
L_80BD:
	push af			;80bd
	ld a,b			;80be
	cp 061h		;80bf
	jr nc,L_80BB		;80c1
	pop af			;80c3
	ld hl,0848fh		;80c4
	jr z,L_80DE		;80c7
	dec a			;80c9
	ld hl,0847fh		;80ca
	jr z,L_80DE		;80cd
	dec a			;80cf
	ld hl,08487h		;80d0
	jr z,L_80DE		;80d3
	dec a			;80d5
	ld hl,0846fh		;80d6
	jr z,L_80DE		;80d9
	ld hl,08477h		;80db
L_80DE:
	ld a,l			;80de
	ld (07e97h),a		;80df
	ld a,h			;80e2
	ld (07e9ah),a		;80e3
	push bc			;80e6
	sla b		;80e7
	sla c		;80e9
	call L_7E4F		;80eb
	call L_7ED9		;80ee
	call L_7EAB		;80f1
	call L_7EEA		;80f4
	call L_7EC1		;80f7
	call L_7EEA		;80fa
	call L_7ED9		;80fd
	call L_7EC4		;8100
	call L_7E86		;8103
	pop bc			;8106
	ret			;8107
L_8108:
	ld a,h			;8108
	and 07fh		;8109
	res 7,l		;810b
	ld h,000h		;810d
	ld e,l			;810f
	ld d,h			;8110
	add hl,hl			;8111
	push hl			;8112
	add hl,hl			;8113
	add hl,de			;8114
	add hl,hl			;8115
	ld e,l			;8116
	ld d,h			;8117
	add hl,hl			;8118
	add hl,hl			;8119
	add hl,de			;811a
	add hl,hl			;811b
	pop de			;811c
	add hl,de			;811d
	ld de,00067h		;811e
	add hl,de			;8121
	ld e,a			;8122
	ld d,0cch		;8123
	add hl,de			;8125
	ld a,(hl)			;8126
	ex de,hl			;8127
	defb 0ddh,06bh	;ld ixl,e		;8128
	defb 0ddh,062h	;ld ixh,d		;812a
	ex de,hl			;812c
	ret			;812d
L_812E:
	call L_8274		;812e
	ld a,002h		;8131
	call 0049fh		;8133
	push af			;8136
L_8137:
	pop af			;8137
	call 00467h		;8138
	xor 002h		;813b
	push af			;813d
	call 0066dh		;813e
	bit 4,a		;8141
	jr z,L_8137		;8143
	pop af			;8145
	xor a			;8146
	call 00467h		;8147
	jp L_7599		;814a
L_814D:
	call 0049fh		;814d
	ld hl,02000h		;8150
	ld bc,01800h		;8153
	call 00429h		;8156
	ld hl,05800h		;8159
	ld d,h			;815c
	ld e,l			;815d
	inc e			;815e
	ld (hl),a			;815f
	ld bc,00300h		;8160
	ldir		;8163
	ret			;8165
L_8166:
	ld a,078h		;8166
	ld (082f6h),a		;8168
	ld hl,04000h		;816b
	ld de,04001h		;816e
	ld (hl),l			;8171
	ld bc,01affh		;8172
	ldir		;8175
	xor a			;8177
	call L_7F12		;8178
	ld a,003h		;817b
	call L_7E7A		;817d
	ld iy,0ff60h		;8180
	ld c,07eh		;8184
L_8186:
	ld b,05dh		;8186
L_8188:
	ld a,(iy+000h)		;8188
	and 00fh		;818b
	sub 00ah		;818d
	inc b			;818f
	call nc,L_80BD		;8190
	dec b			;8193
	dec iy		;8194
	djnz L_8188		;8196
	ld de,0fff7h		;8198
	add iy,de		;819b
	dec c			;819d
	jr nz,L_8186		;819e
	ld iy,0ff62h		;81a0
	ld c,07eh		;81a4
L_81A6:
	ld b,05fh		;81a6
L_81A8:
	ld a,(iy+000h)		;81a8
	and 00fh		;81ab
	cp 00ah		;81ad
	call c,L_8044		;81af
	dec iy		;81b2
	dec b			;81b4
	jp p,L_81A8		;81b5
	ld de,0fffah		;81b8
	add iy,de		;81bb
	dec c			;81bd
	jp p,L_81A6		;81be
	call 005bdh		;81c1
	ld a,030h		;81c4
	call L_814D		;81c6
	ld hl,08499h		;81c9
	call L_827D		;81cc
	ld a,0b7h		;81cf
	ld (08504h),a		;81d1
	ld hl,084e1h		;81d4
	call L_827D		;81d7
	xor a			;81da
	ld (08504h),a		;81db
	ld hl,L_8274		;81de
	ld (07f66h),hl		;81e1
	ld (07f6ch),hl		;81e4
	jp L_6AAF		;81e7
L_81EA:
	call L_7599		;81ea
	ld a,(07f67h)		;81ed
	cp 082h		;81f0
	jr nz,L_8206		;81f2
	ld hl,06719h		;81f4
	ld (07f66h),hl		;81f7
	ld hl,L_831B		;81fa
	ld (07f6ch),hl		;81fd
	call L_7599		;8200
	jp L_7F57		;8203
L_8206:
	ld hl,(08242h)		;8206
	push hl			;8209
	ld hl,0846ah		;820a
	ld de,050a1h		;820d
	call L_8280		;8210
L_8213:
	ld e,008h		;8213
L_8215:
	ld hl,050ceh		;8215
	ld c,008h		;8218
L_821A:
	push hl			;821a
	ld b,00eh		;821b
	or a			;821d
L_821E:
	rl (hl)		;821e
	dec hl			;8220
	djnz L_821E		;8221
	pop hl			;8223
	inc h			;8224
	dec c			;8225
	jr nz,L_821A		;8226
	push de			;8228
	ld de,01601h		;8229
	ld bc,0010eh		;822c
	call 00702h		;822f
	pop de			;8232
	ld bc,00012h		;8233
	call L_8274		;8236
	dec e			;8239
	jr nz,L_8215		;823a
	pop hl			;823c
	ld a,(hl)			;823d
	and a			;823e
	jr nz,L_8247		;823f
	ld hl,0855eh		;8241
	dec hl			;8244
	ld a,020h		;8245
L_8247:
	inc hl			;8247
	push hl			;8248
	ld de,050ceh		;8249
	ld l,a			;824c
	call L_82DC		;824d
	call 0066dh		;8250
	bit 4,a		;8253
	jr z,L_8213		;8255
	ld hl,0855eh		;8257
	ld (08242h),hl		;825a
	pop hl			;825d
	ld hl,084e1h		;825e
	call L_8280		;8261
	inc hl			;8264
	ld de,050c1h		;8265
	ld hl,084f5h		;8268
	call L_8280		;826b
	call L_7599		;826e
	jp L_7F57		;8271
L_8274:
	ld bc,00006h		;8274
L_8277:
	djnz L_8277		;8277
	dec c			;8279
	jr nz,L_8277		;827a
	ret			;827c
L_827D:
	ld de,00000h		;827d
L_8280:
	ld a,(hl)			;8280
	inc hl			;8281
	or a			;8282
	ret z			;8283
	jp m,L_8296		;8284
	push hl			;8287
	ld l,a			;8288
	call L_82DC		;8289
	pop hl			;828c
	inc e			;828d
	jr nz,L_8280		;828e
	ld a,008h		;8290
	add a,d			;8292
	ld d,a			;8293
	jr L_8280		;8294
L_8296:
	and 07fh		;8296
	bit 6,a		;8298
	jr z,L_82A5		;829a
	ld d,a			;829c
	ld e,(hl)			;829d
	inc hl			;829e
	ld (L_827D+1),de		;829f
	jr L_8280		;82a3
L_82A5:
	ld c,a			;82a5
	and 003h		;82a6
	ld b,a			;82a8
	ld a,c			;82a9
	rra			;82aa
	rra			;82ab
	and 00fh		;82ac
	ld c,a			;82ae
	ld a,b			;82af
	or a			;82b0
	jr z,L_8280		;82b1
	dec a			;82b3
	jr nz,L_82C2		;82b4
	ld a,c			;82b6
	inc a			;82b7
	add a,e			;82b8
	ld e,a			;82b9
	jr nc,L_8280		;82ba
	ld a,008h		;82bc
	add a,d			;82be
	ld d,a			;82bf
	jr L_8280		;82c0
L_82C2:
	dec a			;82c2
	jr z,L_8280		;82c3
	ld de,(L_827D+1)		;82c5
	ld a,e			;82c9
	add a,020h		;82ca
	ld e,a			;82cc
	ld a,000h		;82cd
	rla			;82cf
	add a,a			;82d0
	add a,a			;82d1
	add a,a			;82d2
	add a,d			;82d3
	ld d,a			;82d4
	ld (L_827D+1),de		;82d5
	jp L_8280		;82d9
L_82DC:
	ld h,019h		;82dc
	add hl,hl			;82de
	add hl,hl			;82df
	add hl,hl			;82e0
	push de			;82e1
	push hl			;82e2
	call 004deh		;82e3
	push de			;82e6
	ld bc,00008h		;82e7
	call 00439h		;82ea
	pop hl			;82ed
	ld de,02000h		;82ee
	add hl,de			;82f1
	ld bc,00008h		;82f2
	ld a,047h		;82f5
	ld (08317h),a		;82f7
	call 0049fh		;82fa
	call 00429h		;82fd
	pop hl			;8300
	pop de			;8301
	ld c,d			;8302
	ld b,007h		;8303
L_8305:
	ld a,(hl)			;8305
	ld (de),a			;8306
	inc l			;8307
	inc d			;8308
	djnz L_8305		;8309
	ld a,(hl)			;830b
	ld (de),a			;830c
	ld a,c			;830d
	rra			;830e
	rra			;830f
	rra			;8310
	and 003h		;8311
	or 058h		;8313
	ld d,a			;8315
	ld a,000h		;8316
	ld (de),a			;8318
	ld d,c			;8319
	ret			;831a
L_831B:
	ld a,0ffh		;831b
	inc a			;831d
	ld (L_831B+1),a		;831e
	ret nz			;8321
	ld hl,084f6h		;8322
	ld a,000h		;8325
	inc a			;8327
	ld c,a			;8328
	cp 03dh		;8329
	jr nz,L_8360		;832b
	sub 03ch		;832d
	ld c,a			;832f
	push af			;8330
	push hl			;8331
	ld a,000h		;8332
	dec a			;8334
	ld (08333h),a		;8335
	jp z,L_83E1		;8338
	ld a,004h		;833b
	call L_65FF		;833d
	ld hl,0853ah		;8340
	ld (08242h),hl		;8343
	ld l,000h		;8346
	ld h,0c3h		;8348
L_834A:
	inc (hl)			;834a
	jr nz,L_834F		;834b
	ld (hl),0ffh		;834d
L_834F:
	inc l			;834f
	jr nz,L_834A		;8350
	pop hl			;8352
	pop af			;8353
	ld a,001h		;8354
	inc a			;8356
	cp 00dh		;8357
	jr nz,L_835D		;8359
	sub 00ch		;835b
L_835D:
	ld (08355h),a		;835d
L_8360:
	ld a,(08355h)		;8360
	call L_8383		;8363
	ld a,c			;8366
	ld (08326h),a		;8367
	ld (hl),020h		;836a
	inc hl			;836c
	call L_8383		;836d
L_8370:
	ld a,(hl)			;8370
	cp 021h		;8371
	jr z,L_837A		;8373
	ld (hl),020h		;8375
	inc hl			;8377
	jr L_8370		;8378
L_837A:
	ld hl,084f5h		;837a
	ld de,050c1h		;837d
	jp L_8280		;8380
L_8383:
	ld de,08538h		;8383
	cp 031h		;8386
	jr z,L_83B1		;8388
	cp 032h		;838a
	jr c,L_8393		;838c
	sub 032h		;838e
	ld (hl),04ch		;8390
	inc hl			;8392
L_8393:
	ld b,000h		;8393
L_8395:
	inc b			;8395
	sub 00ah		;8396
	jr nc,L_8395		;8398
	add a,00ah		;839a
	dec b			;839c
	jr z,L_83A4		;839d
L_839F:
	ld (hl),058h		;839f
	inc hl			;83a1
	djnz L_839F		;83a2
L_83A4:
	and a			;83a4
	jr z,L_83C0		;83a5
	dec a			;83a7
	add a,a			;83a8
	add a,a			;83a9
	add a,016h		;83aa
	ld e,a			;83ac
	adc a,085h		;83ad
	sub e			;83af
	ld d,a			;83b0
L_83B1:
	ld a,(de)			;83b1
	and a			;83b2
	jp m,L_83BC		;83b3
	ld (hl),a			;83b6
	inc hl			;83b7
	inc de			;83b8
	jp L_83B1		;83b9
L_83BC:
	and 07fh		;83bc
	ld (hl),a			;83be
	inc hl			;83bf
L_83C0:
	ret			;83c0
L_83C1:
	call L_7F40		;83c1
	ld hl,08427h		;83c4
	call L_8280		;83c7
L_83CA:
	call 0066dh		;83ca
	bit 4,a		;83cd
	jr nz,L_83CA		;83cf
L_83D1:
	call 0066dh		;83d1
	bit 4,a		;83d4
	jr z,L_83D1		;83d6
	ret			;83d8
L_83D9:
	call L_83C1		;83d9
	ld hl,0094fh		;83dc
	jr L_83E7		;83df
L_83E1:
	call L_83C1		;83e1
	ld hl,0244fh		;83e4
L_83E7:
	ld de,04000h		;83e7
	ld bc,01b00h		;83ea
	ldir		;83ed
	call 005bdh		;83ef
	call 00604h		;83f2
	di			;83f5
L_83F6:
	jr L_83F6		;83f6

; ----------------------------------------------------------------------
; DATOS textos_de_los_paneles: Textos y marcos de los paneles:
;   "Volver/Cargar/Salvar", "Pulsa Fuego", File/Memo/Time, numeros romanos
;   I..VII, "El Anillo corrompe al que lo usa", "Ningun mensaje" (los leen
;   0x7E81-0x7EA0 y 0x8280)
;   0x83f8..0x8572  (378 bytes)
DATA_textos_de_los_paneles:
	defb 000h,0ffh,0aah,055h,003h,00ch,030h,0c0h,003h,00bh,056h,06fh,06ch,076h,065h,072h	; 83f8  ...U..0...Volver
	defb 0b7h,0b7h,043h,061h,072h,067h,061h,072h,020h,020h,020h,0b7h,0b7h,053h,061h,06ch	; 8408  ..Cargar   ..Sal
	defb 076h,061h,072h,020h,020h,020h,0b7h,0b7h,056h,06fh,06ch,076h,065h,072h,000h,0c0h	; 8418  var   ..Volver..
	defb 000h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h	; 8428  .               
	defb 020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h	; 8438                  
	defb 020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,050h,075h,06ch,073h,061h	; 8448             Pulsa
	defb 020h,046h,075h,065h,067h,06fh,02eh,020h,020h,020h,020h,020h,020h,020h,020h,020h	; 8458   Fuego.         
	defb 020h,000h,020h,020h,020h,020h,000h,044h,0aah,0eeh,044h,022h,055h,077h,022h,0ddh	; 8468   .    .D..D"Uw".
	defb 0beh,06eh,0c4h,09bh,07dh,0f7h,0e3h,022h,077h,077h,000h,022h,077h,077h,000h,0aah	; 8478  .n..}.."ww."ww..
	defb 055h,0aah,055h,0aah,055h,0aah,055h,022h,041h,091h,03bh,064h,082h,008h,01ch,000h	; 8488  U.U.U.U"A.;d....
	defb 000h,0c8h,060h,023h,022h,022h,022h,022h,023h,0b7h,021h,020h,020h,020h,020h,021h	; 8498  ..`#""""#.!    !
	defb 0b7h,021h,020h,07bh,07dh,020h,021h,0b7h,021h,020h,07eh,07fh,020h,021h,0b7h,021h	; 84a8  .! {} !.! ~. !.!
	defb 046h,069h,06ch,065h,021h,0b7h,021h,020h,020h,020h,020h,021h,0b7h,021h,020h,07bh	; 84b8  File!.!    !.! {
	defb 07dh,020h,021h,0b7h,021h,020h,07eh,07fh,020h,021h,0b7h,021h,04dh,065h,06dh,06fh	; 84c8  } !.! ~. !.!Memo
	defb 021h,0b7h,021h,020h,020h,020h,020h,021h,000h,0d0h,0a0h,021h,054h,069h,06dh,065h	; 84d8  !.!    !...!Time
	defb 023h,022h,022h,022h,022h,022h,022h,022h,022h,022h,023h,0b7h,021h,020h,020h,020h	; 84e8  #"""""""""#.!   
	defb 020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h,021h,0b7h,023h,022h,022h	; 84f8             !.#""
	defb 022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,022h,023h,000h,0c9h,020h	; 8508  """"""""""""#.. 
	defb 020h,020h,049h,0c9h,020h,020h,049h,049h,0c9h,020h,049h,0d6h,020h,020h,0d6h,020h	; 8518    I.  II. I.  . 
	defb 020h,020h,056h,0c9h,020h,020h,056h,049h,0c9h,020h,056h,049h,049h,0c9h,049h,0d8h	; 8528    V.  VI. VII.I.
	defb 049h,0cch,045h,06ch,020h,041h,06eh,069h,06ch,06ch,06fh,020h,063h,06fh,072h,072h	; 8538  I.El Anillo corr
	defb 06fh,06dh,070h,065h,020h,061h,06ch,020h,071h,075h,065h,020h,06ch,06fh,020h,075h	; 8548  ompe al que lo u
	defb 073h,061h,02eh,020h,020h,000h,04eh,069h,06eh,067h,075h,06eh,020h,06dh,065h,06eh	; 8558  sa.  .Ningun men
	defb 073h,061h,06ah,065h,020h,020h,020h,02eh,020h,000h	; 8568  saje   . .

; ======================================================================
; CODIGO 0x8572..0x8a51  (1247 bytes)
; ======================================================================


L_8572:
	xor a			;8572
	ld (hl),a			;8573
	ld (de),a			;8574
	dec de			;8575
	dec hl			;8576
	ld (hl),a			;8577
	ld (de),a			;8578
	inc de			;8579
	inc hl			;857a
	ret			;857b
L_857C:
	push hl			;857c
	push de			;857d
	call L_8E6E		;857e
	pop de			;8581
	ld a,(hl)			;8582
	ld c,a			;8583
	pop hl			;8584
	ld b,001h		;8585
	or a			;8587
	jr z,L_8592		;8588
	inc b			;858a
	inc a			;858b
	jr z,L_8592		;858c
	inc b			;858e
	inc a			;858f
	jr nz,L_8599		;8590
L_8592:
	ld a,b			;8592
	ld (de),a			;8593
	inc de			;8594
	ld (de),a			;8595
	jp L_86F8		;8596
L_8599:
	dec c			;8599
	push hl			;859a
	ld b,0beh		;859b
	ld a,(bc)			;859d
	ld b,0c4h		;859e
	bit 6,a		;85a0
	ld a,(bc)			;85a2
	ld b,0c8h		;85a3
	jr z,L_85AE		;85a5
	ex af,af'			;85a7
	ld a,(bc)			;85a8
	and 001h		;85a9
	jr nz,L_8608		;85ab
	ex af,af'			;85ad
L_85AE:
	add a,a			;85ae
	add a,a			;85af
	add a,a			;85b0
	add a,0c7h		;85b1
	ld l,a			;85b3
	adc a,094h		;85b4
	sub l			;85b6
	ld h,a			;85b7
	ld a,(bc)			;85b8
	ld c,a			;85b9
	and 003h		;85ba
	add a,a			;85bc
	add a,a			;85bd
	add a,l			;85be
	ld l,a			;85bf
	adc a,h			;85c0
	sub l			;85c1
	ld h,a			;85c2
	set 6,c		;85c3
L_85C5:
	push de			;85c5
	push de			;85c6
	pop iy		;85c7
	pop ix		;85c9
	ld a,(hl)			;85cb
	inc hl			;85cc
	ld (ix+001h),a		;85cd
	ld (ix+000h),c		;85d0
	defb 0ddh,07ch	;ld a,ixh		;85d3
	add a,003h		;85d5
	defb 0ddh,067h	;ld ixh,a		;85d7
	ld a,(hl)			;85d9
	inc hl			;85da
	ld (ix-01fh),a		;85db
	ld (ix-020h),c		;85de
	ld a,(hl)			;85e1
	inc hl			;85e2
	ld (ix-03fh),a		;85e3
	ld (ix-040h),c		;85e6
	ld a,(hl)			;85e9
	or a			;85ea
	jr z,L_8603		;85eb
	ld a,(ix-05fh)		;85ed
	or a			;85f0
	jr z,L_85FC		;85f1
	ld (iy-05fh),a		;85f3
	ld a,(ix-060h)		;85f6
	ld (iy-060h),a		;85f9
L_85FC:
	ld a,(hl)			;85fc
	ld (ix-05fh),a		;85fd
	ld (ix-060h),c		;8600
L_8603:
	pop hl			;8603
	inc de			;8604
	jp L_86F8		;8605
L_8608:
	ex af,af'			;8608
	add a,a			;8609
	add a,a			;860a
	add a,a			;860b
	add a,037h		;860c
	ld l,a			;860e
	adc a,095h		;860f
	sub l			;8611
	ld h,a			;8612
	ld a,(bc)			;8613
	ld c,a			;8614
	and 002h		;8615
	add a,a			;8617
	add a,a			;8618
	add a,l			;8619
	ld l,a			;861a
	adc a,h			;861b
	sub l			;861c
	ld h,a			;861d
	set 6,c		;861e
	push de			;8620
	push de			;8621
	pop iy		;8622
	pop ix		;8624
	ld a,003h		;8626
	defb 0ddh,084h	;add a,ixh		;8628
	defb 0ddh,067h	;ld ixh,a		;862a
	ld a,c			;862c
	or a			;862d
	jp p,L_8642		;862e
	ld a,e			;8631
	and 01fh		;8632
	cp 01eh		;8634
	jr z,L_86A8		;8636
	inc ix		;8638
	inc ix		;863a
	inc iy		;863c
	inc iy		;863e
	jr L_864F		;8640
L_8642:
	ld a,e			;8642
	and 01fh		;8643
	jr z,L_86A8		;8645
	dec ix		;8647
	dec ix		;8649
	dec iy		;864b
	dec iy		;864d
L_864F:
	inc hl			;864f
	ld a,(hl)			;8650
	inc hl			;8651
	or a			;8652
	jr z,L_866C		;8653
	ex af,af'			;8655
	ld a,(ix-01fh)		;8656
	or a			;8659
	jr z,L_8665		;865a
	ld (iy-01fh),a		;865c
	ld a,(ix-020h)		;865f
	ld (iy-020h),a		;8662
L_8665:
	ex af,af'			;8665
	ld (ix-01fh),a		;8666
	ld (ix-020h),c		;8669
L_866C:
	ld a,(hl)			;866c
	inc hl			;866d
	or a			;866e
	jr z,L_8688		;866f
	ex af,af'			;8671
	ld a,(ix-03fh)		;8672
	or a			;8675
	jr z,L_8681		;8676
	ld (iy-03fh),a		;8678
	ld a,(ix-040h)		;867b
	ld (iy-040h),a		;867e
L_8681:
	ex af,af'			;8681
	ld (ix-03fh),a		;8682
	ld (ix-040h),c		;8685
L_8688:
	ld a,(hl)			;8688
	inc hl			;8689
	or a			;868a
	jp z,L_85C5		;868b
	ex af,af'			;868e
	ld a,(ix-05fh)		;868f
	or a			;8692
	jr z,L_869E		;8693
	ld (iy-05fh),a		;8695
	ld a,(ix-060h)		;8698
	ld (iy-060h),a		;869b
L_869E:
	ex af,af'			;869e
	ld (ix-05fh),a		;869f
	ld (ix-060h),c		;86a2
	jp L_85C5		;86a5
L_86A8:
	inc hl			;86a8
	inc hl			;86a9
	inc hl			;86aa
	inc hl			;86ab
	jp L_85C5		;86ac
L_86AF:
	ld hl,0e800h		;86af
	push hl			;86b2
	ld de,0e801h		;86b3
	ld bc,004ffh		;86b6
	ld (hl),000h		;86b9
	ldir		;86bb
	pop de			;86bd
	ld hl,(08e0eh)		;86be
	ld a,h			;86c1
	sub 008h		;86c2
	ld h,a			;86c4
	ld a,l			;86c5
	sub 008h		;86c6
	ld (086d0h),a		;86c8
	exx			;86cb
	ld c,013h		;86cc
L_86CE:
	exx			;86ce
	ld l,000h		;86cf
	ld a,h			;86d1
	or a			;86d2
	jp m,L_86DA		;86d3
	cp 020h		;86d6
	jr c,L_86E5		;86d8
L_86DA:
	ld b,020h		;86da
	ld a,001h		;86dc
L_86DE:
	ld (de),a			;86de
	inc de			;86df
	djnz L_86DE		;86e0
	jp L_86FE		;86e2
L_86E5:
	exx			;86e5
	ld b,010h		;86e6
L_86E8:
	exx			;86e8
	ld a,l			;86e9
	or a			;86ea
	jp m,L_86F3		;86eb
	cp 020h		;86ee
	jp c,L_857C		;86f0
L_86F3:
	ld a,001h		;86f3
	ld (de),a			;86f5
	inc de			;86f6
	ld (de),a			;86f7
L_86F8:
	inc de			;86f8
	inc l			;86f9
	exx			;86fa
	djnz L_86E8		;86fb
	exx			;86fd
L_86FE:
	inc h			;86fe
	exx			;86ff
	dec c			;8700
	jr nz,L_86CE		;8701
	ld ix,0e910h		;8703
	ld iy,0ec10h		;8707
	ld b,(ix+000h)		;870b
	ld c,(ix+001h)		;870e
	ld a,b			;8711
	cp 004h		;8712
	jr c,L_8722		;8714
	ld a,(iy+000h)		;8716
	or a			;8719
	jr nz,L_872F		;871a
	ld (iy+000h),b		;871c
	ld (iy+001h),c		;871f
L_8722:
	ld (ix+000h),003h		;8722
	ld (ix+001h),003h		;8726
	ld a,0ffh		;872a
	ld (0ef10h),a		;872c
L_872F:
	ld b,000h		;872f
	ld ix,0f000h		;8731
	ld iy,0ee00h		;8735
	ld de,0eb00h		;8739
	ld hl,0e800h		;873c
L_873F:
	ld a,(hl)			;873f
	cp (iy+000h)		;8740
	ld (iy+000h),a		;8743
	jr z,L_875D		;8746
	ld a,(de)			;8748
	ld (ix+000h),a		;8749
L_874C:
	inc hl			;874c
	inc de			;874d
	inc ix		;874e
	inc iy		;8750
	ld a,(hl)			;8752
	ld (iy+000h),a		;8753
L_8756:
	ld a,(de)			;8756
	ld (ix+000h),a		;8757
	jp L_877F		;875a
L_875D:
	ld a,(de)			;875d
	cp (ix+000h)		;875e
	ld (ix+000h),a		;8761
	jr nz,L_874C		;8764
	inc de			;8766
	inc hl			;8767
	inc ix		;8768
	inc iy		;876a
	ld a,(hl)			;876c
	cp (iy+000h)		;876d
	ld (iy+000h),a		;8770
	jr nz,L_8756		;8773
	ld a,(de)			;8775
	cp (ix+000h)		;8776
	ld (ix+000h),a		;8779
	call z,L_8572		;877c
L_877F:
	inc hl			;877f
	inc de			;8780
	inc ix		;8781
	inc iy		;8783
	djnz L_873F		;8785
	ld de,04040h		;8787
	ld hl,0e800h		;878a
	exx			;878d
	ld c,010h		;878e
L_8790:
	exx			;8790
	ld (08836h),de		;8791
	exx			;8795
	ld b,010h		;8796
L_8798:
	exx			;8798
	ld (L_8825+1),de		;8799
	ld (087dch),hl		;879d
	ld a,(hl)			;87a0
	or a			;87a1
	jp z,L_8825		;87a2
	ld c,a			;87a5
	inc hl			;87a6
	ld a,(hl)			;87a7
	dec a			;87a8
	jp z,L_885C		;87a9
	dec a			;87ac
	jp z,L_8856		;87ad
	dec a			;87b0
	jp z,L_8850		;87b1
	dec a			;87b4
	ld l,a			;87b5
	ld h,000h		;87b6
	add hl,hl			;87b8
	add hl,hl			;87b9
	add hl,hl			;87ba
	add hl,hl			;87bb
	add hl,hl			;87bc
	ld a,l			;87bd
	add a,0e8h		;87be
	ld l,a			;87c0
	ld a,h			;87c1
	adc a,0a2h		;87c2
	ld h,a			;87c4
	inc hl			;87c5
	ld a,c			;87c6
	or a			;87c7
	jp m,L_88C8		;87c8
L_87CB:
	call L_88F3		;87cb
	call L_88F3		;87ce
	call L_88F3		;87d1
	call L_88F3		;87d4
L_87D7:
	ld de,(L_8825+1)		;87d7
	ld hl,00000h		;87db
	ld a,h			;87de
	add a,003h		;87df
	ld h,a			;87e1
	ld a,(hl)			;87e2
	or a			;87e3
	jp z,L_8825		;87e4
	ld c,a			;87e7
	inc hl			;87e8
	ld a,(hl)			;87e9
	sub 004h		;87ea
	ld l,a			;87ec
	ld h,000h		;87ed
	add hl,hl			;87ef
	add hl,hl			;87f0
	add hl,hl			;87f1
	add hl,hl			;87f2
	add hl,hl			;87f3
	ld a,l			;87f4
	add a,0e8h		;87f5
	ld l,a			;87f7
	ld a,h			;87f8
	adc a,0a2h		;87f9
	ld h,a			;87fb
	ld a,c			;87fc
	or a			;87fd
	jp m,L_8898		;87fe
	call L_887B		;8801
	call L_887B		;8804
	call L_887B		;8807
	ld a,(de)			;880a
	and (hl)			;880b
	inc hl			;880c
	or (hl)			;880d
	inc hl			;880e
	ld (de),a			;880f
	inc e			;8810
	ld a,(de)			;8811
	and (hl)			;8812
	inc hl			;8813
	or (hl)			;8814
	inc hl			;8815
	ld (de),a			;8816
	inc d			;8817
	ld a,(de)			;8818
	and (hl)			;8819
	inc hl			;881a
	or (hl)			;881b
	inc hl			;881c
	ld (de),a			;881d
	dec e			;881e
	ld a,(de)			;881f
	and (hl)			;8820
	inc hl			;8821
	or (hl)			;8822
	inc hl			;8823
	ld (de),a			;8824
L_8825:
	ld de,00000h		;8825
	ld hl,(087dch)		;8828
	inc e			;882b
	inc e			;882c
	inc l			;882d
	inc hl			;882e
	exx			;882f
	dec b			;8830
	jp nz,L_8798		;8831
	exx			;8834
	ld de,00000h		;8835
	ld a,e			;8838
	add a,020h		;8839
	ld e,a			;883b
	ld a,000h		;883c
	rla			;883e
	add a,a			;883f
	add a,a			;8840
	add a,a			;8841
	add a,d			;8842
	ld d,a			;8843
	exx			;8844
	dec c			;8845
	jp nz,L_8790		;8846
	call 005bdh		;8849
	call 00604h		;884c
	ret			;884f
L_8850:
	ld hl,095a8h		;8850
	jp L_87CB		;8853
L_8856:
	ld hl,09608h		;8856
	jp L_87CB		;8859
L_885C:
	ex de,hl			;885c
	push hl			;885d
	xor a			;885e
	call L_886A		;885f
	call L_886A		;8862
	pop hl			;8865
	ex de,hl			;8866
	jp L_87D7		;8867
L_886A:
	ld (hl),a			;886a
	inc l			;886b
	ld (hl),a			;886c
	inc h			;886d
	ld (hl),a			;886e
	dec l			;886f
	ld (hl),a			;8870
	inc h			;8871
	ld (hl),a			;8872
	inc l			;8873
	ld (hl),a			;8874
	inc h			;8875
	ld (hl),a			;8876
	dec l			;8877
	ld (hl),a			;8878
	inc h			;8879
	ret			;887a
L_887B:
	ld a,(de)			;887b
	and (hl)			;887c
	inc hl			;887d
	or (hl)			;887e
	inc hl			;887f
	ld (de),a			;8880
	inc e			;8881
	ld a,(de)			;8882
	and (hl)			;8883
	inc hl			;8884
	or (hl)			;8885
	inc hl			;8886
	ld (de),a			;8887
	inc d			;8888
	ld a,(de)			;8889
	and (hl)			;888a
	inc hl			;888b
	or (hl)			;888c
	inc hl			;888d
	ld (de),a			;888e
	dec e			;888f
	ld a,(de)			;8890
	and (hl)			;8891
	inc hl			;8892
	or (hl)			;8893
	inc hl			;8894
	ld (de),a			;8895
	inc d			;8896
	ret			;8897
L_8898:
	inc e			;8898
	ld b,003h		;8899
	call L_88AD		;889b
	inc d			;889e
	call L_88AD		;889f
	inc d			;88a2
	call L_88AD		;88a3
	inc d			;88a6
	call L_88AD		;88a7
	jp L_8825		;88aa
L_88AD:
	call L_88B9		;88ad
	dec e			;88b0
	call L_88B9		;88b1
	inc d			;88b4
	call L_88B9		;88b5
	inc e			;88b8
L_88B9:
	ld c,(hl)			;88b9
	inc hl			;88ba
	ld a,(bc)			;88bb
	ld c,a			;88bc
	ld a,(de)			;88bd
	and c			;88be
	ld (de),a			;88bf
	ld c,(hl)			;88c0
	inc hl			;88c1
	ld a,(bc)			;88c2
	ld c,a			;88c3
	ld a,(de)			;88c4
	or c			;88c5
	ld (de),a			;88c6
	ret			;88c7
L_88C8:
	inc e			;88c8
	ld b,003h		;88c9
	call L_88DA		;88cb
	call L_88DA		;88ce
	call L_88DA		;88d1
	call L_88DA		;88d4
	jp L_87D7		;88d7
L_88DA:
	ld c,(hl)			;88da
	ld a,(bc)			;88db
	ld (de),a			;88dc
	inc hl			;88dd
	inc hl			;88de
	dec e			;88df
	ld c,(hl)			;88e0
	ld a,(bc)			;88e1
	ld (de),a			;88e2
	inc hl			;88e3
	inc hl			;88e4
	inc d			;88e5
	ld c,(hl)			;88e6
	ld a,(bc)			;88e7
	ld (de),a			;88e8
	inc hl			;88e9
	inc hl			;88ea
	inc e			;88eb
	ld c,(hl)			;88ec
	ld a,(bc)			;88ed
	ld (de),a			;88ee
	inc hl			;88ef
	inc hl			;88f0
	inc d			;88f1
	ret			;88f2
L_88F3:
	ld a,(hl)			;88f3
	ld (de),a			;88f4
	inc e			;88f5
	inc hl			;88f6
	inc hl			;88f7
	ld a,(hl)			;88f8
	ld (de),a			;88f9
	inc hl			;88fa
	inc hl			;88fb
	inc d			;88fc
	ld a,(hl)			;88fd
	ld (de),a			;88fe
	inc hl			;88ff
	inc hl			;8900
	dec e			;8901
	ld a,(hl)			;8902
	ld (de),a			;8903
	inc hl			;8904
	inc hl			;8905
	inc d			;8906
	ret			;8907
L_8908:
	ld a,c			;8908
	cp e			;8909
	ld a,b			;890a
	jr z,L_8915		;890b
	jr c,L_891D		;890d
	cp d			;890f
	jr nc,L_895C		;8910
	jp L_893E		;8912
L_8915:
	cp d			;8915
	jr z,L_897A		;8916
	jr nc,L_895C		;8918
	jp L_896B		;891a
L_891D:
	cp d			;891d
	jr c,L_896B		;891e
	jr z,L_896B		;8920
	jp L_894D		;8922
L_8925:
	ld a,b			;8925
	cp d			;8926
	ld a,c			;8927
	jr z,L_8933		;8928
	jr c,L_893B		;892a
	cp e			;892c
	jr c,L_894D		;892d
	jr z,L_894D		;892f
	jr L_895C		;8931
L_8933:
	cp e			;8933
	jr z,L_897A		;8934
	jr nc,L_893E		;8936
	jp L_894D		;8938
L_893B:
	cp e			;893b
	jr c,L_896B		;893c
L_893E:
	ld a,b			;893e
	cp 01eh		;893f
	jr nc,L_894A		;8941
	ld a,c			;8943
	cp 002h		;8944
	jr c,L_894A		;8946
	inc b			;8948
	dec c			;8949
L_894A:
	ld a,080h		;894a
	ret			;894c
L_894D:
	ld a,b			;894d
	cp 002h		;894e
	jr c,L_8959		;8950
	ld a,c			;8952
	cp 01eh		;8953
	jr nc,L_8959		;8955
	inc c			;8957
	dec b			;8958
L_8959:
	ld a,002h		;8959
	ret			;895b
L_895C:
	ld a,c			;895c
	cp 002h		;895d
	jr c,L_8968		;895f
	ld a,b			;8961
	cp 002h		;8962
	jr c,L_8968		;8964
	dec b			;8966
	dec c			;8967
L_8968:
	ld a,000h		;8968
	ret			;896a
L_896B:
	ld a,b			;896b
	cp 01eh		;896c
	jr nc,L_8977		;896e
	ld a,c			;8970
	cp 01eh		;8971
	jr nc,L_8977		;8973
	inc b			;8975
	inc c			;8976
L_8977:
	ld a,082h		;8977
	ret			;8979
L_897A:
	ex (sp),hl			;897a
	pop hl			;897b
	ret			;897c
L_897D:
	ld hl,0be00h		;897d
	ld a,0d0h		;8980
	ld (08af3h),a		;8982
L_8985:
	ld a,l			;8985
	ld (08afdh),a		;8986
	inc a			;8989
	ld (08af5h),a		;898a
	cp 000h		;898d
	jr nc,L_8996		;898f
	ld a,0d8h		;8991
	ld (08af3h),a		;8993
L_8996:
	ld a,(hl)			;8996
	and 060h		;8997
	jp nz,L_8A61		;8999
	ld a,l			;899c
	inc a			;899d
	ld (08a5fh),a		;899e
	ld a,(hl)			;89a1
	and 01fh		;89a2
	ld c,a			;89a4
	push hl			;89a5
	inc h			;89a6
	ld b,(hl)			;89a7
	ld (08a54h),bc		;89a8
	push bc			;89ac
	push hl			;89ad
	call L_8AD6		;89ae
	pop hl			;89b1
	pop bc			;89b2
	exx			;89b3
	call L_63FB		;89b4
	and 004h		;89b7
	ld de,L_8925		;89b9
	jr nz,L_89C1		;89bc
	ld de,L_8908		;89be
L_89C1:
	ld (L_8A06+1),de		;89c1
	exx			;89c5
	ld h,0c7h		;89c6
	ld a,(hl)			;89c8
	cp 0ffh		;89c9
	jp z,L_8A86		;89cb
	ld (089fdh),a		;89ce
	ld l,a			;89d1
	ld h,0beh		;89d2
	bit 5,(hl)		;89d4
	jp nz,L_8A7D		;89d6
	ld a,(hl)			;89d9
	and 01fh		;89da
	ld e,a			;89dc
	inc h			;89dd
	ld d,(hl)			;89de
	pop hl			;89df
	push hl			;89e0
	ld h,0c8h		;89e1
	ld a,b			;89e3
	sub d			;89e4
	jr nc,L_89E9		;89e5
	neg		;89e7
L_89E9:
	cp 002h		;89e9
	jr nc,L_8A06		;89eb
	ld a,c			;89ed
	sub e			;89ee
	jr nc,L_89F3		;89ef
	neg		;89f1
L_89F3:
	cp 002h		;89f3
	jr nc,L_8A06		;89f5
	pop hl			;89f7
	set 6,(hl)		;89f8
	ld a,l			;89fa
	push hl			;89fb
	ld hl,0be00h		;89fc
	set 6,(hl)		;89ff
	ld h,0c7h		;8a01
	ld (hl),a			;8a03
	jr $+92		;8a04
L_8A06:
	call L_8925		;8a06
	call L_8AC4		;8a09
	jr z,L_8A30		;8a0c
	call L_63FB		;8a0e
	and 003h		;8a11
	add a,a			;8a13
	add a,0bfh		;8a14
	ld l,a			;8a16
	add a,094h		;8a17
	sub l			;8a19
	ld h,a			;8a1a
	ld e,(hl)			;8a1b
	inc hl			;8a1c
	ld d,(hl)			;8a1d
	ld (L_8A26+1),de		;8a1e
	ld bc,(08a54h)		;8a22
L_8A26:
	call L_8A26		;8a26
	ld h,0c8h		;8a29
	call L_8AC4		;8a2b
	jr nz,$+50		;8a2e
L_8A30:
	ld a,b			;8a30
	and 01fh		;8a31
	ld b,a			;8a33
	ld a,c			;8a34
	and 01fh		;8a35
	ld c,a			;8a37
	push bc			;8a38
	ld a,002h		;8a39
	ld bc,00000h		;8a3b
	pop bc			;8a3e
	pop hl			;8a3f
	ld a,(hl)			;8a40
	and 0e0h		;8a41
	or c			;8a43
	ld (hl),a			;8a44
	inc h			;8a45
	ld (hl),b			;8a46
	ld h,0c8h		;8a47
	ld a,(hl)			;8a49
	xor 001h		;8a4a
	ld (hl),a			;8a4c
	ld h,0beh		;8a4d
	jr $+3		;8a4f

; ----------------------------------------------------------------------
; DATOS pop_hl_sin_uso: Un pop hl que el jr de 0x8A4F salta y al que nadie
;   llega (entrada alternativa sin uso)
;   0x8a51..0x8a52  (1 bytes)
DATA_pop_hl_sin_uso:
	defb 0e1h	; 8a51

; ======================================================================
; CODIGO 0x8a52..0x8a68  (22 bytes)
; ======================================================================


L_8A52:
	push hl			;8a52
	ld bc,00000h		;8a53
	call L_8DFE		;8a56
	ld (hl),000h		;8a59
	ld hl,00000h		;8a5b
	ld (hl),000h		;8a5e
L_8A60:
	pop hl			;8a60
L_8A61:
	dec l			;8a61
	ld a,l			;8a62
	inc a			;8a63
	jp nz,L_8985		;8a64
	ret			;8a67

; ----------------------------------------------------------------------
; DATOS interruptor_por_opcode: Interruptor por opcode: en la cinta ret / 00 /
;   BE; 0x8BEE escribe 0x21 y 0x8BCC el byte de 0x8A69, y queda ld hl,0xBExx
;   que cae en 0x8A6B
;   0x8a68..0x8a6b  (3 bytes)
DATA_interruptor_por_opcode:
	defb 0c9h,000h,0beh	; 8a68

; ======================================================================
; CODIGO 0x8a6b..0x93d9  (2414 bytes)
; ======================================================================


L_8A6B:
	ld e,l			;8a6b
	inc e			;8a6c
	ld a,(hl)			;8a6d
	and 01fh		;8a6e
	ld c,a			;8a70
	inc h			;8a71
	ld a,(hl)			;8a72
	call L_8DFF		;8a73
	ld (hl),e			;8a76
	ld a,0c9h		;8a77
	ld (08a68h),a		;8a79
	ret			;8a7c
L_8A7D:
	pop hl			;8a7d
	ld h,0c7h		;8a7e
	ld (hl),0ffh		;8a80
	ld h,0beh		;8a82
	jr $-35		;8a84
L_8A86:
	ld a,l			;8a86
	cp 000h		;8a87
	jr nc,$-41		;8a89
	ld (08abfh),a		;8a8b
	call L_63FB		;8a8e
	and 03fh		;8a91
	or 010h		;8a93
	ld e,a			;8a95
	ld a,0ffh		;8a96
	ld (08abch),a		;8a98
	ld hl,0be00h		;8a9b
L_8A9E:
	bit 5,(hl)		;8a9e
	jr nz,L_8AB5		;8aa0
	ld a,l			;8aa2
	ld (08abch),a		;8aa3
	ld a,(hl)			;8aa6
	and 01fh		;8aa7
	ld d,a			;8aa9
	inc h			;8aaa
	ld a,(hl)			;8aab
	dec h			;8aac
	and 01fh		;8aad
	add a,d			;8aaf
	sub b			;8ab0
	sub c			;8ab1
	cp e			;8ab2
	jr c,L_8ABD		;8ab3
L_8AB5:
	inc l			;8ab5
	ld a,l			;8ab6
	cp 000h		;8ab7
	jr nz,L_8A9E		;8ab9
	ld l,0ffh		;8abb
L_8ABD:
	ld a,l			;8abd
	ld hl,0c700h		;8abe
	ld (hl),a			;8ac1
	jr $-98		;8ac2
L_8AC4:
	ld e,a			;8ac4
	ld a,(hl)			;8ac5
	and 001h		;8ac6
	or e			;8ac8
	ld (hl),a			;8ac9
	call L_8DFE		;8aca
	ld (08a5ch),hl		;8acd
	ld a,(hl)			;8ad0
	or a			;8ad1
	ret z			;8ad2
	cp 0ffh		;8ad3
	ret			;8ad5
L_8AD6:
	call L_8DFE		;8ad6
	push hl			;8ad9
	pop iy		;8ada
	ld a,(iy-021h)		;8adc
	call L_8AF1		;8adf
	ld a,(iy-01fh)		;8ae2
	call L_8AF1		;8ae5
	ld a,(iy+01fh)		;8ae8
	call L_8AF1		;8aeb
	ld a,(iy+021h)		;8aee
L_8AF1:
	cp 000h		;8af1
	ret c			;8af3
	cp 000h		;8af4
	ret z			;8af6
	or a			;8af7
	ret z			;8af8
	cp 0ffh		;8af9
	ret z			;8afb
	ld hl,0c700h		;8afc
	dec a			;8aff
	push hl			;8b00
	ld l,a			;8b01
	ld h,0beh		;8b02
	bit 5,(hl)		;8b04
	jr z,L_8B15		;8b06
	push af			;8b08
	push bc			;8b09
	push de			;8b0a
	ld e,a			;8b0b
	inc e			;8b0c
	call L_8BD1		;8b0d
	pop de			;8b10
	pop bc			;8b11
	pop af			;8b12
	pop hl			;8b13
	ret			;8b14
L_8B15:
	pop hl			;8b15
	ld (hl),a			;8b16
	ret			;8b17
L_8B18:
	ld a,000h		;8b18
	cp 0fdh		;8b1a
	jr nc,L_8B50		;8b1c
	or a			;8b1e
	jr z,L_8B50		;8b1f
	ld c,a			;8b21
	ld a,000h		;8b22
	or a			;8b24
	jr z,L_8B5C		;8b25
	cp c			;8b27
	jr z,L_8B70		;8b28
	ld l,a			;8b2a
	ld a,c			;8b2b
	ld c,l			;8b2c
	dec c			;8b2d
	dec a			;8b2e
	cp 000h		;8b2f
	jr nc,L_8B54		;8b31
	ld h,0c7h		;8b33
	ld l,c			;8b35
	ld (hl),a			;8b36
	xor a			;8b37
	ld (08b23h),a		;8b38
	ld de,095a8h		;8b3b
	ld (08851h),de		;8b3e
	ld a,005h		;8b42
L_8B44:
	ld (09190h),a		;8b44
L_8B47:
	call 0066dh		;8b47
	or a			;8b4a
	jr nz,L_8B47		;8b4b
	jp L_7599		;8b4d
L_8B50:
	ld a,006h		;8b50
	jr L_8B44		;8b52
L_8B54:
	ld a,003h		;8b54
	jr L_8B44		;8b56
L_8B58:
	ld a,004h		;8b58
	jr L_8B44		;8b5a
L_8B5C:
	ld a,c			;8b5c
	cp 000h		;8b5d
	jr c,L_8B58		;8b5f
	ld a,c			;8b61
	ld (08b23h),a		;8b62
	ld de,095c8h		;8b65
	ld (08851h),de		;8b68
	ld a,002h		;8b6c
	jr L_8B44		;8b6e
L_8B70:
	ld l,c			;8b70
	dec l			;8b71
	ld h,0beh		;8b72
	bit 6,(hl)		;8b74
	ret nz			;8b76
	ld (08be8h),hl		;8b77
	ld h,0c7h		;8b7a
	ld (hl),0ffh		;8b7c
	ld a,0c9h		;8b7e
	ld (L_8E0D),a		;8b80
	ld de,095e8h		;8b83
	ld (08851h),de		;8b86
	ld hl,(L_8E0D+1)		;8b8a
	ld (L_8BE4+1),hl		;8b8d
	ld hl,00000h		;8b90
	ld (08bfah),hl		;8b93
	ld a,c			;8b96
	dec a			;8b97
	ld (08c63h),a		;8b98
	call L_8BAA		;8b9b
	ld de,L_8BE4		;8b9e
	ld (094bdh),de		;8ba1
	pop hl			;8ba5
	pop hl			;8ba6
	jp L_8B47		;8ba7
L_8BAA:
	push af			;8baa
	push hl			;8bab
	ld a,(08c63h)		;8bac
	ld e,a			;8baf
	inc e			;8bb0
	call L_8BD1		;8bb1
	ld hl,(L_8E0D+1)		;8bb4
	push hl			;8bb7
	call L_8E6E		;8bb8
	ld a,(08c63h)		;8bbb
	ld e,a			;8bbe
	inc e			;8bbf
	ld (hl),e			;8bc0
	pop de			;8bc1
	ld l,a			;8bc2
	ld h,0beh		;8bc3
	ld (hl),d			;8bc5
	inc h			;8bc6
	ld (hl),e			;8bc7
	pop hl			;8bc8
	ld a,(08c63h)		;8bc9
	ld (08a69h),a		;8bcc
	pop af			;8bcf
	ret			;8bd0
L_8BD1:
	ld hl,05e00h		;8bd1
	ld bc,00400h		;8bd4
L_8BD7:
	ld a,(hl)			;8bd7
	cp e			;8bd8
	jr nz,L_8BDD		;8bd9
	ld (hl),000h		;8bdb
L_8BDD:
	inc hl			;8bdd
	dec bc			;8bde
	ld a,b			;8bdf
	or c			;8be0
	jr nz,L_8BD7		;8be1
	ret			;8be3
L_8BE4:
	ld hl,00000h		;8be4
	ld a,(00000h)		;8be7
	call L_8BAA		;8bea
	push af			;8bed
	ld a,021h		;8bee
	ld (08a68h),a		;8bf0
	pop af			;8bf3
	and 040h		;8bf4
	jr nz,L_8C6C		;8bf6
	xor a			;8bf8
	ld (00000h),a		;8bf9
	push hl			;8bfc
	call 0066dh		;8bfd
	pop hl			;8c00
	bit 5,a		;8c01
	jr z,L_8C0B		;8c03
	ld a,(08c63h)		;8c05
	jp L_8C67		;8c08
L_8C0B:
	rra			;8c0b
	jr nc,L_8C15		;8c0c
	ld c,080h		;8c0e
	ld de,0ff01h		;8c10
	jr L_8C31		;8c13
L_8C15:
	rra			;8c15
	jr nc,L_8C1F		;8c16
	ld c,002h		;8c18
	ld de,001ffh		;8c1a
	jr L_8C31		;8c1d
L_8C1F:
	rra			;8c1f
	jr nc,L_8C29		;8c20
	ld c,000h		;8c22
	ld de,0ffffh		;8c24
	jr L_8C31		;8c27
L_8C29:
	rra			;8c29
	jr nc,L_8C8D		;8c2a
	ld c,082h		;8c2c
	ld de,00101h		;8c2e
L_8C31:
	ld a,c			;8c31
	ld (08cc1h),a		;8c32
	push hl			;8c35
	ld a,h			;8c36
	add a,d			;8c37
	jp m,L_8C4B		;8c38
	cp 020h		;8c3b
	jr nc,L_8C4B		;8c3d
	ld h,a			;8c3f
	ld a,l			;8c40
	add a,e			;8c41
	jp m,L_8C4B		;8c42
	cp 020h		;8c45
	jr nc,L_8C4B		;8c47
	ld l,a			;8c49
	ex (sp),hl			;8c4a
L_8C4B:
	pop hl			;8c4b
	push hl			;8c4c
	call L_8E6E		;8c4d
	ld a,(hl)			;8c50
	or a			;8c51
	jr z,L_8C96		;8c52
	inc a			;8c54
	jr z,L_8C96		;8c55
	pop hl			;8c57
	dec a			;8c58
	dec a			;8c59
	cp 000h		;8c5a
	jr nc,L_8C8D		;8c5c
	ld l,a			;8c5e
	ld c,a			;8c5f
	ld h,0c7h		;8c60
	ld a,000h		;8c62
	ld (hl),a			;8c64
	ld l,a			;8c65
	ld (hl),c			;8c66
L_8C67:
	ld hl,(08bfah)		;8c67
	inc a			;8c6a
	ld (hl),a			;8c6b
L_8C6C:
	ld a,021h		;8c6c
	ld (L_8E0D),a		;8c6e
	ld (08a68h),a		;8c71
	ld de,095a8h		;8c74
	ld (08851h),de		;8c77
	ld a,001h		;8c7b
	ld (09190h),a		;8c7d
	ld hl,L_8F19		;8c80
	ld (094bdh),hl		;8c83
	xor a			;8c86
	ld (08b23h),a		;8c87
	jp L_8BAA		;8c8a
L_8C8D:
	ld a,(08c63h)		;8c8d
	inc a			;8c90
	ld hl,(08bfah)		;8c91
	ld (hl),a			;8c94
	ret			;8c95
L_8C96:
	ld a,(08c63h)		;8c96
	inc a			;8c99
	ld (hl),a			;8c9a
	ld (08bfah),hl		;8c9b
	pop hl			;8c9e
	ld (L_8E0D+1),hl		;8c9f
	ld bc,(L_8BE4+1)		;8ca2
	ld (L_8BE4+1),hl		;8ca6
	ld e,h			;8ca9
	ld d,l			;8caa
	push de			;8cab
	dec a			;8cac
	ld e,a			;8cad
	ld d,0beh		;8cae
	ex de,hl			;8cb0
	ld a,(hl)			;8cb1
	and 0e0h		;8cb2
	or d			;8cb4
	ld (hl),a			;8cb5
	inc h			;8cb6
	ld (hl),e			;8cb7
	pop de			;8cb8
	ld h,0c8h		;8cb9
	ld a,(hl)			;8cbb
	xor 001h		;8cbc
	and 001h		;8cbe
	or 000h		;8cc0
	ld (hl),a			;8cc2
	ret			;8cc3
L_8CC4:
	push bc			;8cc4
	ld a,b			;8cc5
	cp d			;8cc6
	ld a,c			;8cc7
	jr c,L_8CD3		;8cc8
	ld b,080h		;8cca
	cp e			;8ccc
	jr c,L_8CDA		;8ccd
	ld b,000h		;8ccf
	jr L_8CDA		;8cd1
L_8CD3:
	ld b,082h		;8cd3
	cp e			;8cd5
	jr c,L_8CDA		;8cd6
	ld b,002h		;8cd8
L_8CDA:
	ld a,(hl)			;8cda
	and 001h		;8cdb
	or b			;8cdd
	ld (hl),a			;8cde
	pop bc			;8cdf
	ret			;8ce0
L_8CE1:
	bit 5,(hl)		;8ce1
	ret z			;8ce3
	bit 4,(hl)		;8ce4
	jr z,L_8CF7		;8ce6
	ld a,001h		;8ce8
	ld (09120h),a		;8cea
	ld a,l			;8ced
	ld (09273h),a		;8cee
	ld a,(08d7ch)		;8cf1
	ld (092d9h),a		;8cf4
L_8CF7:
	push hl			;8cf7
	ld a,(hl)			;8cf8
	and 00fh		;8cf9
	cp 009h		;8cfb
	jr c,L_8D01		;8cfd
	ld a,002h		;8cff
L_8D01:
	cp 001h		;8d01
	jr z,L_8D08		;8d03
	ld (09125h),a		;8d05
L_8D08:
	cp 007h		;8d08
	jr nz,L_8D0E		;8d0a
	ld a,001h		;8d0c
L_8D0E:
	cp 008h		;8d0e
	jr nz,L_8D14		;8d10
	ld a,004h		;8d12
L_8D14:
	add a,a			;8d14
	ld (08d8bh),a		;8d15
	call L_8DC0		;8d18
	ld a,c			;8d1b
	ld (08d9eh),a		;8d1c
	ld a,l			;8d1f
	ld (08da2h),a		;8d20
	ld h,0c1h		;8d23
	ld a,(hl)			;8d25
	and 00fh		;8d26
	ld c,a			;8d28
	call L_8DB5		;8d29
	ld (08d98h),a		;8d2c
	call L_7095		;8d2f
	ld (08d9bh),a		;8d32
	ld h,0c2h		;8d35
	ld a,(hl)			;8d37
	ld (08d45h),a		;8d38
	push hl			;8d3b
	call L_8DE4		;8d3c
	pop hl			;8d3f
	ld a,0ffh		;8d40
	sub c			;8d42
	sub d			;8d43
	ld c,000h		;8d44
	call L_8DB5		;8d46
	ld a,d			;8d49
	or 001h		;8d4a
	ld (08d94h),a		;8d4c
	ld h,0c5h		;8d4f
	ld a,(hl)			;8d51
	or a			;8d52
	jr nz,L_8D56		;8d53
	inc a			;8d55
L_8D56:
	ld b,a			;8d56
	call L_63FB		;8d57
	ld (08da8h),a		;8d5a
L_8D5D:
	push bc			;8d5d
L_8D5E:
	call L_63FB		;8d5e
	ld h,003h		;8d61
	ld a,(hl)			;8d63
	ld b,a			;8d64
	and 001h		;8d65
	ld c,a			;8d67
	call L_63FB		;8d68
	and 01fh		;8d6b
	ld l,a			;8d6d
	and 001h		;8d6e
	cp c			;8d70
	jr nz,L_8D5E		;8d71
	ld c,l			;8d73
	call L_8DFE		;8d74
	ld a,(hl)			;8d77
	or a			;8d78
	jr nz,L_8D5E		;8d79
	ld a,000h		;8d7b
	cp 0feh		;8d7d
	jr z,L_8DB0		;8d7f
	inc a			;8d81
	ld (hl),a			;8d82
	ld (08d7ch),a		;8d83
	dec a			;8d86
	ld l,a			;8d87
	ld h,0c4h		;8d88
	ld (hl),000h		;8d8a
	ld h,0beh		;8d8c
	ld (hl),c			;8d8e
	inc h			;8d8f
	ld (hl),b			;8d90
	ld h,0e3h		;8d91
	ld (hl),000h		;8d93
	ld h,0e4h		;8d95
	ld (hl),000h		;8d97
	inc h			;8d99
	ld (hl),000h		;8d9a
	inc h			;8d9c
	ld (hl),000h		;8d9d
	ld h,0c6h		;8d9f
	ld (hl),000h		;8da1
	inc h			;8da3
	ld (hl),0ffh		;8da4
	inc h			;8da6
	ld a,000h		;8da7
	ld (hl),a			;8da9
	inc a			;8daa
	and 003h		;8dab
	ld (08da8h),a		;8dad
L_8DB0:
	pop bc			;8db0
	djnz L_8D5D		;8db1
	pop hl			;8db3
	ret			;8db4
L_8DB5:
	ld e,a			;8db5
	xor a			;8db6
	ld d,a			;8db7
L_8DB8:
	add a,e			;8db8
	jr nc,L_8DBC		;8db9
	inc d			;8dbb
L_8DBC:
	dec c			;8dbc
	jr nz,L_8DB8		;8dbd
	ret			;8dbf
L_8DC0:
	ld c,000h		;8dc0
	cp 002h		;8dc2
	jr c,L_8DC9		;8dc4
	cp 007h		;8dc6
	ret nz			;8dc8
L_8DC9:
	ld c,004h		;8dc9
	ret			;8dcb
L_8DCC:
	ld a,000h		;8dcc
	ld e,a			;8dce
	and 00fh		;8dcf
	ld d,000h		;8dd1
	cp 007h		;8dd3
	ret c			;8dd5
	cp 00ch		;8dd6
	ret nc			;8dd8
	cp 00ah		;8dd9
	ret z			;8ddb
	ld d,032h		;8ddc
	cp 00bh		;8dde
	ret z			;8de0
	ld d,064h		;8de1
	ret			;8de3
L_8DE4:
	add a,a			;8de4
	add a,a			;8de5
	add a,a			;8de6
	add a,047h		;8de7
	or 000h		;8de9
	ld l,a			;8deb
	adc a,06dh		;8dec
	sub l			;8dee
	ld h,a			;8def
	ld a,(hl)			;8df0
	add a,a			;8df1
	add a,a			;8df2
	add a,a			;8df3
	ld c,a			;8df4
	call L_8DCC		;8df5
	bit 4,e		;8df8
L_8DFA:
	ret nz			;8dfa
	ld d,000h		;8dfb
	ret			;8dfd
L_8DFE:
	ld a,b			;8dfe
L_8DFF:
	add a,a			;8dff
	add a,a			;8e00
	add a,a			;8e01
	ld h,000h		;8e02
	ld l,a			;8e04
	add hl,hl			;8e05
	add hl,hl			;8e06
	ld a,b			;8e07
	ld b,05eh		;8e08
	add hl,bc			;8e0a
	ld b,a			;8e0b
	ret			;8e0c
L_8E0D:
	ld hl,00000h		;8e0d
	call 0066dh		;8e10
	bit 4,a		;8e13
	push hl			;8e15
	call nz,L_8B18		;8e16
	pop hl			;8e19
	ld b,a			;8e1a
	ld de,00000h		;8e1b
	rra			;8e1e
	jr nc,L_8E24		;8e1f
	ld de,0ff01h		;8e21
L_8E24:
	rra			;8e24
	jr nc,L_8E2A		;8e25
	ld de,001ffh		;8e27
L_8E2A:
	rra			;8e2a
	jr nc,L_8E30		;8e2b
	ld de,0ffffh		;8e2d
L_8E30:
	rra			;8e30
	jr nc,L_8E36		;8e31
	ld de,00101h		;8e33
L_8E36:
	rra			;8e36
	rra			;8e37
	jr nc,L_8E49		;8e38
	xor a			;8e3a
	ld (08b23h),a		;8e3b
	inc a			;8e3e
	ld (09190h),a		;8e3f
	ld bc,095a8h		;8e42
	ld (08851h),bc		;8e45
L_8E49:
	push hl			;8e49
	ld a,h			;8e4a
	add a,d			;8e4b
	jp m,L_8E5F		;8e4c
	cp 020h		;8e4f
	jr nc,L_8E5F		;8e51
	ld h,a			;8e53
	ld a,l			;8e54
	add a,e			;8e55
	jp m,L_8E5F		;8e56
	cp 020h		;8e59
	jr nc,L_8E5F		;8e5b
	ld l,a			;8e5d
	ex (sp),hl			;8e5e
L_8E5F:
	pop hl			;8e5f
	ld (L_8E0D+1),hl		;8e60
	call L_8E6E		;8e63
	ld (08b91h),hl		;8e66
	ld a,(hl)			;8e69
	ld (L_8B18+1),a		;8e6a
	ret			;8e6d
L_8E6E:
	push af			;8e6e
	push bc			;8e6f
	push hl			;8e70
	ld e,h			;8e71
	ld a,l			;8e72
	add a,a			;8e73
	add a,a			;8e74
	add a,a			;8e75
	ld h,000h		;8e76
	ld l,a			;8e78
	add hl,hl			;8e79
	add hl,hl			;8e7a
	ld a,l			;8e7b
	or e			;8e7c
	ld l,a			;8e7d
	ld a,h			;8e7e
	add a,05eh		;8e7f
	ld h,a			;8e81
	pop bc			;8e82
	ld a,b			;8e83
	xor c			;8e84
	and 001h		;8e85
	jr z,L_8E92		;8e87
	ld a,(hl)			;8e89
	or a			;8e8a
	jr z,L_8E92		;8e8b
	inc a			;8e8d
	jr z,L_8E92		;8e8e
	ld (hl),000h		;8e90
L_8E92:
	pop bc			;8e92
	pop af			;8e93
	ret			;8e94
L_8E95:
	ld hl,0be00h		;8e95
L_8E98:
	bit 5,(hl)		;8e98
	jp nz,L_8F13		;8e9a
	bit 6,(hl)		;8e9d
	jp z,L_8F13		;8e9f
	push hl			;8ea2
	ld a,(hl)			;8ea3
	and 01fh		;8ea4
	ld b,a			;8ea6
	inc h			;8ea7
	ld c,(hl)			;8ea8
	push bc			;8ea9
	push hl			;8eaa
	ld e,l			;8eab
	inc e			;8eac
	ld a,c			;8ead
	ld c,b			;8eae
	call L_8DFF		;8eaf
	ld (hl),e			;8eb2
	pop hl			;8eb3
	pop bc			;8eb4
	ld e,l			;8eb5
	ld h,0c7h		;8eb6
	ld l,(hl)			;8eb8
	ld (hl),e			;8eb9
	ld h,0beh		;8eba
	ld a,(hl)			;8ebc
	and 01fh		;8ebd
	ld d,a			;8ebf
	inc h			;8ec0
	ld e,(hl)			;8ec1
	pop hl			;8ec2
	push hl			;8ec3
	ld h,0c8h		;8ec4
	call L_8CC4		;8ec6
	ld c,l			;8ec9
	ld a,(hl)			;8eca
	xor 001h		;8ecb
	ld (hl),a			;8ecd
	dec h			;8ece
	ld b,(hl)			;8ecf
	call L_63FB		;8ed0
	ld l,c			;8ed3
	ld h,0e4h		;8ed4
	cp (hl)			;8ed6
	jr c,L_8EE1		;8ed7
	bit 3,a		;8ed9
	jp nz,L_8F10		;8edb
	jp L_8F10		;8ede
L_8EE1:
	inc h			;8ee1
	ld a,(hl)			;8ee2
	ld (08eebh),a		;8ee3
	ld l,b			;8ee6
	ld h,0e3h		;8ee7
	ld a,(hl)			;8ee9
	sub 000h		;8eea
	ld (hl),a			;8eec
	jr nc,L_8F10		;8eed
	ld h,0e6h		;8eef
	ld a,(hl)			;8ef1
	or a			;8ef2
	jr z,L_8EFD		;8ef3
	dec a			;8ef5
	ld (hl),a			;8ef6
	ld h,0e3h		;8ef7
	ld (hl),0ffh		;8ef9
	jr L_8F10		;8efb
L_8EFD:
	call L_8F4C		;8efd
	ld l,b			;8f00
	ld h,0c6h		;8f01
	ld l,(hl)			;8f03
	ld h,0c5h		;8f04
	ld a,(hl)			;8f06
	and a			;8f07
	jr z,L_8F0D		;8f08
	dec (hl)			;8f0a
	jr nz,L_8F10		;8f0b
L_8F0D:
	call L_8F1A		;8f0d
L_8F10:
	pop hl			;8f10
	ld h,0beh		;8f11
L_8F13:
	ld a,l			;8f13
	dec l			;8f14
	or a			;8f15
	jp nz,L_8E98		;8f16
L_8F19:
	ret			;8f19
L_8F1A:
	ld h,0b9h		;8f1a
	ld (hl),000h		;8f1c
	inc h			;8f1e
	ld (hl),000h		;8f1f
	ld c,l			;8f21
	ld h,0bdh		;8f22
	ld a,(hl)			;8f24
	and 00fh		;8f25
	cp 005h		;8f27
	jp z,L_930D		;8f29
	xor a			;8f2c
L_8F2D:
	push af			;8f2d
	call L_6956		;8f2e
	ld a,d			;8f31
	or e			;8f32
	jr nz,L_8F47		;8f33
	pop af			;8f35
	push af			;8f36
	ld l,a			;8f37
	ld h,0b9h		;8f38
	ld e,a			;8f3a
	ld d,0bbh		;8f3b
	ld a,(hl)			;8f3d
	and 07fh		;8f3e
	ld (de),a			;8f40
	inc hl			;8f41
	inc de			;8f42
	ld a,(hl)			;8f43
	and 07fh		;8f44
	ld (de),a			;8f46
L_8F47:
	pop af			;8f47
	inc a			;8f48
	jr nz,L_8F2D		;8f49
	ret			;8f4b
L_8F4C:
	push bc			;8f4c
	ld h,0bfh		;8f4d
	ld b,(hl)			;8f4f
	dec h			;8f50
	ld a,(hl)			;8f51
	set 5,(hl)		;8f52
	and 01fh		;8f54
	ld c,a			;8f56
	call L_8DFE		;8f57
	ld (hl),000h		;8f5a
	pop bc			;8f5c
	ld hl,0c700h		;8f5d
L_8F60:
	ld a,(hl)			;8f60
	cp b			;8f61
	jr nz,L_8F6C		;8f62
	ld (hl),0ffh		;8f64
	ld h,0beh		;8f66
	res 6,(hl)		;8f68
	ld h,0c7h		;8f6a
L_8F6C:
	inc l			;8f6c
	jr nz,L_8F60		;8f6d
	ret			;8f6f
L_8F70:
	ld hl,00000h		;8f70
	ld de,00000h		;8f73
	exx			;8f76
	ld de,00000h		;8f77
	ld hl,0b900h		;8f7a
L_8F7D:
	call L_934F		;8f7d
	jr nz,L_8FA5		;8f80
	ld c,a			;8f82
	ld a,l			;8f83
	cp 078h		;8f84
	jr nc,L_8F9A		;8f86
	cp 016h		;8f88
	jr z,L_8F9A		;8f8a
	cp 017h		;8f8c
	jr z,L_8F9A		;8f8e
	ld a,c			;8f90
	exx			;8f91
	add a,l			;8f92
	ld l,a			;8f93
	jr nc,L_8FA2		;8f94
	ld l,0ffh		;8f96
	jr L_8FA2		;8f98
L_8F9A:
	ld a,c			;8f9a
	exx			;8f9b
	add a,e			;8f9c
	ld e,a			;8f9d
	jr nc,L_8FA2		;8f9e
	ld e,0ffh		;8fa0
L_8FA2:
	exx			;8fa2
	ld h,0b9h		;8fa3
L_8FA5:
	inc l			;8fa5
	jr nz,L_8F7D		;8fa6
	exx			;8fa8
	ld a,l			;8fa9
	or a			;8faa
	ret z			;8fab
	ld a,e			;8fac
	or a			;8fad
	ret z			;8fae
	ld a,l			;8faf
	add a,e			;8fb0
	jr c,L_8FB7		;8fb1
	cp 0fbh		;8fb3
	jr c,L_8FD1		;8fb5
L_8FB7:
	ld a,l			;8fb7
	cp 05bh		;8fb8
	jr nc,L_8FC2		;8fba
	ld a,0fah		;8fbc
	sub l			;8fbe
	ld e,a			;8fbf
	jr L_8FD1		;8fc0
L_8FC2:
	ld a,e			;8fc2
	cp 0a1h		;8fc3
	jr c,L_8FCD		;8fc5
	ld l,05ah		;8fc7
	ld e,0a0h		;8fc9
	jr L_8FD1		;8fcb
L_8FCD:
	ld a,0fah		;8fcd
	sub e			;8fcf
	ld l,a			;8fd0
L_8FD1:
	ld a,l			;8fd1
	inc a			;8fd2
	ld (08ffdh),a		;8fd3
	ld a,e			;8fd6
	inc a			;8fd7
	ld (0900eh),a		;8fd8
	ld hl,00000h		;8fdb
	exx			;8fde
	ld hl,0b900h		;8fdf
	ld de,(08f78h)		;8fe2
L_8FE6:
	call L_934F		;8fe6
	jr nz,L_901B		;8fe9
	ld c,a			;8feb
	ld a,l			;8fec
	cp 016h		;8fed
	jr z,L_900A		;8fef
	cp 017h		;8ff1
	jr z,L_900A		;8ff3
	cp 078h		;8ff5
	jr nc,L_900A		;8ff7
	ld a,c			;8ff9
	exx			;8ffa
	add a,l			;8ffb
	cp 000h		;8ffc
	jr nc,L_901A		;8ffe
	ld l,a			;9000
	exx			;9001
	ld h,0bdh		;9002
	set 5,(hl)		;9004
	ld h,0b9h		;9006
	jr L_901B		;9008
L_900A:
	ld a,c			;900a
	exx			;900b
	add a,h			;900c
	cp 000h		;900d
	jr nc,L_901A		;900f
	exx			;9011
	ld h,0bdh		;9012
	set 5,(hl)		;9014
	ld h,0b9h		;9016
	exx			;9018
	ld h,a			;9019
L_901A:
	exx			;901a
L_901B:
	inc l			;901b
	jr nz,L_8FE6		;901c
	ld hl,(08f78h)		;901e
	call L_752C		;9021
	ld hl,(08f78h)		;9024
	call L_8108		;9027
	ld (L_8DCC+1),a		;902a
	and 00fh		;902d
	ld (08deah),a		;902f
	call L_9394		;9032
	ld b,040h		;9035
	ld hl,05800h		;9037
	ld a,046h		;903a
	ld (082f6h),a		;903c
L_903F:
	ld (hl),a			;903f
	inc hl			;9040
	djnz L_903F		;9041
	ld hl,05a40h		;9043
	xor a			;9046
	ld b,0c0h		;9047
L_9049:
	ld (hl),a			;9049
	inc hl			;904a
	djnz L_9049		;904b
	ld hl,05e00h		;904d
	ld de,05e01h		;9050
	ld bc,004ffh		;9053
	ld (hl),000h		;9056
	ldir		;9058
	ld hl,0c700h		;905a
	ld c,0ffh		;905d
	ld de,0c701h		;905f
	ld (hl),c			;9062
	ldir		;9063
	ld c,0ffh		;9065
	ld hl,0be00h		;9067
	ld de,0be01h		;906a
	ld (hl),c			;906d
	ldir		;906e
	ld b,00fh		;9070
L_9072:
	push bc			;9072
	call L_63FB		;9073
	and 01fh		;9076
	ld c,a			;9078
	and 001h		;9079
	ld l,a			;907b
	ld a,h			;907c
	and 01fh		;907d
	ld b,a			;907f
	and 001h		;9080
	cp l			;9082
	jr z,L_908A		;9083
	call L_8DFE		;9085
	ld (hl),0ffh		;9088
L_908A:
	pop bc			;908a
	djnz L_9072		;908b
	ld hl,00300h		;908d
	ld a,020h		;9090
	ld e,01fh		;9092
L_9094:
	ld d,004h		;9094
L_9096:
	ld b,a			;9096
L_9097:
	ld (hl),e			;9097
	inc l			;9098
	jr z,L_90A6		;9099
	djnz L_9097		;909b
	dec e			;909d
	dec d			;909e
	jr nz,L_9096		;909f
	inc a			;90a1
	srl a		;90a2
	jr L_9094		;90a4
L_90A6:
	call 00604h		;90a6
	xor a			;90a9
	ld (08d7ch),a		;90aa
	ld (09120h),a		;90ad
	ld de,095a8h		;90b0
	ld (08851h),de		;90b3
	ld a,0c8h		;90b7
	ld (l8dfah),a		;90b9
	ld hl,0bd16h		;90bc
	call L_8CE1		;90bf
	inc l			;90c2
	call L_8CE1		;90c3
	ld l,078h		;90c6
L_90C8:
	call L_8CE1		;90c8
	inc l			;90cb
	jr nz,L_90C8		;90cc
	ld a,0c0h		;90ce
	ld (l8dfah),a		;90d0
	ld a,(08d7ch)		;90d3
	inc a			;90d6
	ld (L_8AF1+1),a		;90d7
	ld (08b5eh),a		;90da
	ld (0898eh),a		;90dd
	dec a			;90e0
	ld (08a9ch),a		;90e1
	ld (08a88h),a		;90e4
	ld (08c5bh),a		;90e7
	ld (08b30h),a		;90ea
	dec a			;90ed
	ld (091c1h),a		;90ee
	ld (L_91A8+1),a		;90f1
	ld hl,00300h		;90f4
L_90F7:
	ld a,01fh		;90f7
	sub (hl)			;90f9
	ld (hl),a			;90fa
	inc l			;90fb
	jr nz,L_90F7		;90fc
	ld hl,0bd77h		;90fe
L_9101:
	call L_8CE1		;9101
	dec l			;9104
	jp m,L_9112		;9105
	ld a,l			;9108
	cp 017h		;9109
	jr nz,L_9101		;910b
	ld l,015h		;910d
	jp L_9101		;910f
L_9112:
	ld a,(08d7ch)		;9112
	ld (0897eh),a		;9115
	ld (08e96h),a		;9118
	inc a			;911b
	ld (08ab8h),a		;911c
	ld a,000h		;911f
	ld (L_926E+1),a		;9121
	xor 000h		;9124
	ld (09282h),a		;9126
	ld hl,00300h		;9129
	xor a			;912c
L_912D:
	ld b,080h		;912d
L_912F:
	rlca			;912f
	rr b		;9130
	jr nc,L_912F		;9132
	ld (hl),b			;9134
	inc a			;9135
	inc l			;9136
	jr nz,L_912D		;9137
	ld a,001h		;9139
	ld (09190h),a		;913b
	ld hl,01010h		;913e
	ld (L_8E0D+1),hl		;9141
	ld hl,06010h		;9144
	ld a,(hl)			;9147
	ld (L_8B18+1),a		;9148
	call L_8C6C		;914b
L_914E:
	ld hl,0bf00h		;914e
L_9151:
	ld a,01fh		;9151
	and (hl)			;9153
	ld (hl),a			;9154
	inc l			;9155
	jr nz,L_9151		;9156
	ld a,(06511h)		;9158
	bit 6,a		;915b
	call nz,L_926E		;915d
	call L_86AF		;9160
	ld a,000h		;9163
	inc a			;9165
	and 003h		;9166
	ld (09164h),a		;9168
	add a,a			;916b
	add a,0b7h		;916c
	ld l,a			;916e
	adc a,094h		;916f
	sub l			;9171
	ld h,a			;9172
	ld a,(hl)			;9173
	inc hl			;9174
	ld h,(hl)			;9175
	ld l,a			;9176
	ld (L_917A+1),hl		;9177
L_917A:
	call L_917A		;917a
	call L_8E0D		;917d
	ld hl,093e5h		;9180
	ld de,04000h		;9183
	call L_8280		;9186
	ld hl,09402h		;9189
	ld (09181h),hl		;918c
	ld a,000h		;918f
	or a			;9191
	jr z,L_91A8		;9192
	dec a			;9194
	add a,a			;9195
	add a,0d9h		;9196
	ld l,a			;9198
	adc a,093h		;9199
	sub l			;919b
	ld h,a			;919c
	ld e,(hl)			;919d
	inc hl			;919e
	ld d,(hl)			;919f
	ld (09181h),de		;91a0
	xor a			;91a4
	ld (09190h),a		;91a5
L_91A8:
	ld hl,0be00h		;91a8
L_91AB:
	bit 5,(hl)		;91ab
	jr z,L_91BC		;91ad
	ld a,l			;91af
	dec l			;91b0
	or a			;91b1
	jr nz,L_91AB		;91b2
	ld hl,L_8F19		;91b4
	ld de,L_8F1A		;91b7
	jr L_91D1		;91ba
L_91BC:
	ld a,(0897eh)		;91bc
	ld l,a			;91bf
	ld a,000h		;91c0
L_91C2:
	bit 5,(hl)		;91c2
	jp z,L_914E		;91c4
	dec l			;91c7
	cp l			;91c8
	jr nz,L_91C2		;91c9
	ld de,L_8F19		;91cb
	ld hl,L_8F1A		;91ce
L_91D1:
	ld (091eeh),hl		;91d1
	ld (L_91F2+1),de		;91d4
	ld hl,0bd00h		;91d8
L_91DB:
	bit 5,(hl)		;91db
	jr z,L_91F6		;91dd
	push hl			;91df
	ld a,l			;91e0
	cp 016h		;91e1
	jr z,L_91F2		;91e3
	cp 017h		;91e5
	jr z,L_91F2		;91e7
	cp 078h		;91e9
	jr nc,L_91F2		;91eb
	call 00000h		;91ed   ; BIOS CHKRAM - Tests RAM and sets RAM slot for the system  [alias: STARTUP, RESET, BOOT]
	jr L_91F5		;91f0
L_91F2:
	call 00000h		;91f2   ; BIOS CHKRAM - Tests RAM and sets RAM slot for the system  [alias: STARTUP, RESET, BOOT]
L_91F5:
	pop hl			;91f5
L_91F6:
	inc l			;91f6
	jr nz,L_91DB		;91f7
	call L_9236		;91f9
	call L_9366		;91fc
	ld hl,0b916h		;91ff
	ld a,(hl)			;9202
	inc h			;9203
	or (hl)			;9204
	jr nz,L_920A		;9205
	call L_922C		;9207
L_920A:
	call L_7F40		;920a
	call L_92DE		;920d
	call L_733E		;9210
	ld h,0b9h		;9213
	ld a,(hl)			;9215
	inc h			;9216
	or (hl)			;9217
	jr z,L_9229		;9218
	call L_7F40		;921a
	ld sp,05bffh		;921d
	ld hl,07fach		;9220
	push hl			;9223
	ld bc,(08f78h)		;9224
	ret			;9228
L_9229:
	jp L_83E1		;9229
L_922C:
	ld (hl),040h		;922c
	dec h			;922e
	ld (hl),06fh		;922f
	ld h,0c2h		;9231
	ld (hl),0ffh		;9233
	ret			;9235
L_9236:
	call L_86AF		;9236
	ld hl,0c600h		;9239
	ld de,0c601h		;923c
	ld bc,000feh		;923f
	ld (hl),000h		;9242
	ldir		;9244
	ld hl,0bd00h		;9246
L_9249:
	bit 5,(hl)		;9249
	jr z,L_9255		;924b
	ld h,0c6h		;924d
	ld (hl),018h		;924f
	ld h,0bdh		;9251
	res 5,(hl)		;9253
L_9255:
	inc l			;9255
	jr nz,L_9249		;9256
	call L_7599		;9258
	ld hl,09403h		;925b
	ld de,04000h		;925e
	call L_8280		;9261
L_9264:
	call 0066dh		;9264
	bit 4,a		;9267
	jr z,L_9264		;9269
	jp L_7599		;926b
L_926E:
	ld a,000h		;926e
	or a			;9270
	ret z			;9271
	ld hl,0c000h		;9272
	ld a,(hl)			;9275
	and 0f0h		;9276
	ld b,a			;9278
	ld a,(hl)			;9279
	and 00fh		;927a
	dec a			;927c
	jr z,L_9229		;927d
	or b			;927f
	ld (hl),a			;9280
	ld a,000h		;9281
	or a			;9283
	ret z			;9284
	push hl			;9285
	ld hl,(08f78h)		;9286
	call L_8108		;9289
	pop hl			;928c
	ld h,0bdh		;928d
	ld a,(hl)			;928f
	and 00fh		;9290
	add a,a			;9292
	add a,a			;9293
	add a,a			;9294
	add a,a			;9295
	add a,047h		;9296
	defb 0fdh,06fh	;ld iyl,a		;9298
	adc a,06dh		;929a
	defb 0fdh,095h	;sub iyl		;929c
	defb 0fdh,067h	;ld iyh,a		;929e
	push hl			;92a0
	ld de,06b34h		;92a1
	ld hl,06b13h		;92a4
	ld b,007h		;92a7
L_92A9:
	ld a,(de)			;92a9
	ld (092afh),a		;92aa
	ld a,(ix+000h)		;92ad
	and 00fh		;92b0
	ld (092b7h),a		;92b2
	ld a,(iy+000h)		;92b5
	or a			;92b8
	jp p,L_92C3		;92b9
	inc de			;92bc
	inc hl			;92bd
	inc hl			;92be
	djnz L_92A9		;92bf
	pop hl			;92c1
	ret			;92c2
L_92C3:
	ld c,(hl)			;92c3
	inc hl			;92c4
	ld b,(hl)			;92c5
	pop hl			;92c6
	ld h,0b9h		;92c7
	ld a,(hl)			;92c9
	and 07fh		;92ca
	add a,c			;92cc
	ld (hl),a			;92cd
	inc h			;92ce
	ld a,(hl)			;92cf
	and 07fh		;92d0
	add a,b			;92d2
	ld (hl),a			;92d3
	xor a			;92d4
	ld (L_926E+1),a		;92d5
	ld l,000h		;92d8
	ld b,l			;92da
	jp L_8F4C		;92db
L_92DE:
	ld hl,0b900h		;92de
	ld bc,00000h		;92e1
L_92E4:
	ld a,(hl)			;92e4
	cp 056h		;92e5
	jr nz,L_9301		;92e7
	inc h			;92e9
	ld a,(hl)			;92ea
	dec h			;92eb
	cp 03fh		;92ec
	jr nz,L_9301		;92ee
	ld a,l			;92f0
	cp 016h		;92f1
	jr z,L_9300		;92f3
	cp 017h		;92f5
	jr z,L_9300		;92f7
	cp 078h		;92f9
	jr nc,L_9300		;92fb
	inc b			;92fd
	jr L_9301		;92fe
L_9300:
	inc c			;9300
L_9301:
	inc l			;9301
	jr nz,L_92E4		;9302
	ld a,b			;9304
	or a			;9305
	ret nz			;9306
	ld a,c			;9307
	or a			;9308
	jp nz,L_9229		;9309
	ret			;930c
L_930D:
	push bc			;930d
	ld h,0bah		;930e
	call L_922C		;9310
	ld b,000h		;9313
	ld hl,0bd00h		;9315
	ld a,l			;9318
L_9319:
	inc b			;9319
	jr z,L_9348		;931a
	inc a			;931c
	cp 016h		;931d
	jr z,L_9319		;931f
	cp 017h		;9321
	jr z,L_9319		;9323
	cp 078h		;9325
	jr nc,L_9319		;9327
	ld l,a			;9329
	bit 5,(hl)		;932a
	jr z,L_9319		;932c
	ld h,0b9h		;932e
	ld a,(hl)			;9330
	inc h			;9331
	or (hl)			;9332
	ld h,0bdh		;9333
	jr z,L_9319		;9335
	ld a,l			;9337
	ld (09316h),a		;9338
L_933B:
	ld h,0bbh		;933b
	ld l,c			;933d
	ld (hl),a			;933e
	inc h			;933f
	ld (hl),0ffh		;9340
	ld h,0c5h		;9342
	ld (hl),01fh		;9344
	pop bc			;9346
	ret			;9347
L_9348:
	push hl			;9348
	call L_733E		;9349
	pop hl			;934c
	jr L_933B		;934d
L_934F:
	ld a,(hl)			;934f
	and 07fh		;9350
	cp e			;9352
	ret nz			;9353
	inc h			;9354
	ld a,(hl)			;9355
	dec h			;9356
	and 07fh		;9357
	cp d			;9359
	ret nz			;935a
	ld h,0c5h		;935b
	ld a,(hl)			;935d
	or a			;935e
	jr nz,L_9362		;935f
	inc a			;9361
L_9362:
	cp a			;9362
	ld h,0b9h		;9363
	ret			;9365
L_9366:
	ld a,009h		;9366
	call L_814D		;9368
	ld hl,0cc00h		;936b
	ld de,04000h		;936e
	ld bc,016edh		;9371
	push hl			;9374
	push de			;9375
	ldir		;9376
	ld bc,033cdh		;9378
	pop hl			;937b
	pop de			;937c
	push bc			;937d
	exx			;937e
	pop hl			;937f
	exx			;9380
L_9381:
	ld b,(hl)			;9381
	inc hl			;9382
	ld a,(hl)			;9383
	inc hl			;9384
L_9385:
	ld (de),a			;9385
	inc de			;9386
	exx			;9387
	ex af,af'			;9388
	dec hl			;9389
	ld a,h			;938a
	or l			;938b
	ret z			;938c
	ex af,af'			;938d
	exx			;938e
	djnz L_9385		;938f
	jp L_9381		;9391
L_9394:
	ld a,009h		;9394
	call L_814D		;9396
	ld hl,0cc00h		;9399
	ld de,04000h		;939c
	ld bc,033cch		;939f
	push hl			;93a2
	push de			;93a3
	call L_93B3		;93a4
	ld bc,016ech		;93a7
	pop hl			;93aa
	pop de			;93ab
	ldir		;93ac
	ld a,020h		;93ae
	jp L_7F12		;93b0
L_93B3:
	push bc			;93b3
	exx			;93b4
	pop hl			;93b5
	exx			;93b6
L_93B7:
	ld c,(hl)			;93b7
	ld b,000h		;93b8
	jr L_93C0		;93ba
L_93BC:
	ld a,c			;93bc
	cp (hl)			;93bd
	jr nz,L_93CD		;93be
L_93C0:
	inc hl			;93c0
	inc b			;93c1
	jr z,L_93CD		;93c2
	exx			;93c4
	dec hl			;93c5
	ld a,h			;93c6
	or l			;93c7
	exx			;93c8
	jr z,L_93D2		;93c9
	jr L_93BC		;93cb
L_93CD:
	call L_93D2		;93cd
	jr L_93B7		;93d0
L_93D2:
	ld a,b			;93d2
	ld (de),a			;93d3
	inc de			;93d4
	ld a,c			;93d5
	ld (de),a			;93d6
	inc de			;93d7
	ret			;93d8

; ----------------------------------------------------------------------
; DATOS punteros_de_los_mensajes: Seis punteros a los mensajes de abajo
;   (0x9180, 0x9189, 0x925B)
;   0x93d9..0x93e5  (12 bytes)
DATA_punteros_de_los_mensajes:
	defw 093e5h	; 93d9  -> DATA_mensajes_de_abajo
	defw 09421h	; 93db
	defw 0943fh	; 93dd
	defw 0945dh	; 93df
	defw 0947bh	; 93e1
	defw 09499h	; 93e3

; ----------------------------------------------------------------------
; DATOS mensajes_de_abajo: Mensajes: "La Batalla ha comenzado/finalizado",
;   "Elige el enemigo a atacar", "No puedes atacar a un amigo", "No pertenece
;   a tu Alianza", "Nuevo destino elegido", "Aqui no hay nadie"
;   0x93e5..0x94b7  (210 bytes)
DATA_mensajes_de_abajo:
	defb 04ch,061h,020h,042h,061h,074h,061h,06ch,06ch,061h,020h,068h,061h,020h,063h,06fh	; 93e5  La Batalla ha co
	defb 06dh,065h,06eh,07ah,061h,064h,06fh,02eh,020h,020h,020h,020h,020h,000h,04ch,061h	; 93f5  menzado.     .La
	defb 020h,042h,061h,074h,061h,06ch,06ch,061h,020h,068h,061h,020h,066h,069h,06eh,061h	; 9405   Batalla ha fina
	defb 06ch,069h,07ah,061h,064h,06fh,02eh,020h,020h,020h,020h,000h,045h,06ch,069h,067h	; 9415  lizado.    .Elig
	defb 065h,020h,065h,06ch,020h,065h,06eh,065h,06dh,069h,067h,06fh,020h,061h,020h,061h	; 9425  e el enemigo a a
	defb 074h,061h,063h,061h,072h,02eh,020h,020h,020h,000h,04eh,06fh,020h,070h,075h,065h	; 9435  tacar.   .No pue
	defb 064h,065h,073h,020h,061h,074h,061h,063h,061h,072h,020h,061h,020h,075h,06eh,020h	; 9445  des atacar a un 
	defb 061h,06dh,069h,067h,06fh,02eh,020h,000h,04eh,06fh,020h,070h,065h,072h,074h,065h	; 9455  amigo. .No perte
	defb 06eh,065h,063h,065h,020h,061h,020h,074h,075h,020h,041h,06ch,069h,061h,06eh,07ah	; 9465  nece a tu Alianz
	defb 061h,02eh,020h,020h,020h,000h,04eh,075h,065h,076h,06fh,020h,064h,065h,073h,074h	; 9475  a.   .Nuevo dest
	defb 069h,06eh,06fh,020h,065h,06ch,065h,067h,069h,064h,06fh,02eh,020h,020h,020h,020h	; 9485  ino elegido.    
	defb 020h,020h,020h,000h,041h,071h,075h,069h,020h,06eh,06fh,020h,068h,061h,079h,020h	; 9495     .Aqui no hay 
	defb 06eh,061h,064h,069h,065h,02eh,020h,020h,020h,020h,020h,020h,020h,020h,020h,020h	; 94a5  nadie.          
	defb 020h,000h	; 94b5

; ----------------------------------------------------------------------
; DATOS tabla_del_despachador_9163: Tabla de 4 palabras del despachador de
;   0x9163 (la CUARTA, 0x94BD, es una variable: 0x8BA1 mete 0x8BE4 y 0x8C83
;   devuelve 0x8F19)
;   0x94b7..0x94bf  (8 bytes)
DATA_tabla_del_despachador_9163:
	defw 08e95h	; 94b7  -> L_8E95
	defw 08f19h	; 94b9  -> L_8F19
	defw 0897dh	; 94bb  -> L_897D
	defw 08f19h	; 94bd  -> L_8F19

; ----------------------------------------------------------------------
; DATOS tabla_del_despachador_8A11: Tabla de 4 palabras que 0x8A11-0x8A1E
;   indexa con A&3
;   0x94bf..0x94c7  (8 bytes)
DATA_tabla_del_despachador_8A11:
	defw 0894dh	; 94bf  -> L_894D
	defw 0895ch	; 94c1  -> L_895C
	defw 0896bh	; 94c3  -> L_896B
	defw 0893eh	; 94c5  -> L_893E

; ----------------------------------------------------------------------
; DATOS tablas_de_caracteres_y_datos: Tablas de codigos de caracter/tile y
;   datos (0x95A8 lo apuntan 0x8850, 0x8B3B, 0x8C74, 0x8E42, 0x90B0; formato
;   pendiente)
;   0x94c7..0x9627  (352 bytes)
DATA_tablas_de_caracteres_y_datos:
	defb 02fh,02eh,02dh,02ch,033h,032h,031h,030h,027h,026h,025h,024h,02bh,02ah,029h,028h	; 94c7  /.-,3210'&%$+*)(
	defb 04fh,04eh,04dh,04ch,053h,052h,051h,050h,047h,046h,045h,044h,04bh,04ah,049h,048h	; 94d7  ONMLSRQPGFEDKJIH
	defb 03fh,03eh,03dh,03ch,043h,042h,041h,040h,037h,036h,035h,034h,03bh,03ah,039h,038h	; 94e7  ?>=<CBA@7654;:98
	defb 01fh,01eh,01dh,01ch,023h,022h,021h,020h,017h,016h,015h,014h,01bh,01ah,019h,018h	; 94f7  ....#"! ........
	defb 05ch,05bh,05ah,000h,05fh,05eh,05dh,000h,056h,055h,054h,000h,059h,058h,057h,000h	; 9507  \[Z._^].VUT.YXW.
	defb 00fh,00eh,00dh,00ch,013h,012h,011h,010h,007h,006h,005h,004h,00bh,00ah,009h,008h	; 9517  ................
	defb 068h,067h,066h,000h,06bh,06ah,069h,000h,062h,061h,060h,000h,065h,064h,063h,000h	; 9527  hgf.kji.ba`.edc.
	defb 000h,000h,08bh,08ah,08fh,08eh,08dh,08ch,000h,085h,084h,000h,089h,088h,087h,086h	; 9537  ................
	defb 000h,000h,09fh,000h,0a3h,0a2h,0a1h,0a0h,000h,000h,09ah,000h,09eh,09dh,09ch,09bh	; 9547  ................
	defb 000h,000h,095h,000h,099h,098h,097h,096h,000h,000h,090h,000h,094h,093h,092h,091h	; 9557  ................
	defb 000h,000h,07fh,000h,083h,082h,081h,080h,000h,07ah,079h,000h,07eh,07dh,07ch,07bh	; 9567  .........zy.~}|{
	defb 000h,000h,000h,000h,0ach,0abh,0aah,000h,000h,0a6h,0a5h,0a4h,0a9h,0a8h,0a7h,000h	; 9577  ................
	defb 000h,000h,074h,073h,078h,077h,076h,075h,000h,06eh,06dh,06ch,072h,071h,070h,06fh	; 9587  ..tsxwvu.nmlrqpo
	defb 000h,000h,000h,000h,0b3h,0b2h,0b1h,000h,000h,000h,0adh,000h,0b0h,0afh,0aeh,000h	; 9597  ................
	defb 0e0h,01fh,007h,0f8h,0f9h,006h,09fh,060h,07fh,080h,0feh,001h,0feh,001h,07fh,080h	; 95a7  .......`........
	defb 07fh,080h,0feh,001h,0feh,001h,07fh,080h,09fh,060h,0f9h,006h,007h,0f8h,0e0h,01fh	; 95b7  .........`......
	defb 003h,0fch,0c0h,03fh,0f1h,00eh,08fh,070h,0d3h,02ch,0cbh,034h,03fh,0c0h,0fch,003h	; 95c7  ...?...p.,.4?...
	defb 0fch,003h,03fh,0c0h,0cbh,034h,0d3h,02ch,08fh,070h,0f1h,00eh,0c0h,03fh,003h,0fch	; 95d7  ..?..4.,.p...?..
	defb 0e0h,01fh,007h,0f8h,051h,0aeh,095h,06ah,02ah,0d5h,0aah,055h,054h,0abh,055h,0aah	; 95e7  ....Q..j*..UT.U.
	defb 02ah,0d5h,0aah,055h,054h,0abh,055h,0aah,08ah,075h,0a9h,056h,007h,0f8h,0e0h,01fh	; 95f7  *..UT.U..u.V....
	defb 0ffh,000h,0ffh,000h,0ffh,000h,0ffh,000h,0bfh,040h,0ffh,000h,0ffh,000h,05bh,0a4h	; 9607  .........@....[.
	defb 0d5h,02ah,0cfh,030h,0b7h,048h,0feh,001h,0f8h,007h,07fh,080h,0ffh,000h,0f6h,009h	; 9617  .*.0.H..........

; ======================================================================
; CODIGO 0x9627..0x9687  (96 bytes)
; ======================================================================


L_9627:
	call L_966C		;9627
	ret c			;962a
	ld hl,09687h		;962b
	call L_8280		;962e
	ld ix,0b900h		;9631
	ld de,01000h		;9635
	ld a,0fch		;9638
L_963A:
	push ix		;963a
	push de			;963c
	push af			;963d
	scf			;963e
	call 007f9h		;963f
	jr c,L_964A		;9642
	pop af			;9644
	pop de			;9645
	pop ix		;9646
	jr L_963A		;9648
L_964A:
	pop af			;964a
	pop de			;964b
	pop ix		;964c
L_964E:
	xor a			;964e
	call 00467h		;964f
	ei			;9652
	ret			;9653
L_9654:
	call L_966C		;9654
	ret c			;9657
	ld hl,096aah		;9658
	call L_8280		;965b
	ld ix,0b900h		;965e
	ld de,01000h		;9662
	ld a,0fch		;9665
	call 008b2h		;9667
	jr L_964E		;966a
L_966C:
	ld hl,096cdh		;966c
	call L_8280		;966f
	call L_7599		;9672
L_9675:
	call 0066dh		;9675
	bit 5,a		;9678
	jr nz,L_9685		;967a
	bit 4,a		;967c
	jr z,L_9675		;967e
	call L_7599		;9680
	or a			;9683
	ret			;9684
L_9685:
	scf			;9685
	ret			;9686

; ----------------------------------------------------------------------
; DATOS rotulos_de_cinta: Rotulos "Cargando Posiciones" y compania para
;   cargar/salvar la partida en cinta (0x962B, 0x9658, 0x966C)
;   0x9687..0x96f0  (105 bytes)
DATA_rotulos_de_cinta:
	defb 0d0h,0e0h,020h,020h,020h,020h,020h,020h,020h,043h,061h,072h,067h,061h,06eh,064h	; 9687  ..       Cargand
	defb 06fh,020h,050h,06fh,073h,069h,063h,069h,06fh,06eh,065h,073h,020h,020h,020h,020h	; 9697  o Posiciones    
	defb 020h,020h,000h,0d0h,0e0h,020h,020h,053h,061h,06ch,076h,061h,06eh,064h,06fh,020h	; 96a7    ...  Salvando 
	defb 050h,06fh,073h,069h,063h,069h,06fh,06eh,065h,073h,020h,064h,065h,06ch,020h,06ah	; 96b7  Posiciones del j
	defb 075h,065h,067h,06fh,020h,000h,0d0h,0e0h,020h,020h,050h,06fh,06eh,020h,065h,06ch	; 96c7  uego ...  Pon el
	defb 020h,063h,061h,073h,073h,065h,074h,074h,065h,020h,079h,020h,070h,075h,06ch,073h	; 96d7   cassette y puls
	defb 061h,020h,046h,075h,065h,067h,06fh,020h,000h	; 96e7  a Fuego .

; ----------------------------------------------------------------------
; DATOS modo_de_control: Variable: modo de control (0 joystick, 1 cursores, 3
;   teclado); la lee 0x5E31 y 0x0698, la escribe 0x5E61
;   0x96f0..0x96f1  (1 bytes)
DATA_modo_de_control:
	defb 000h	; 96f0
