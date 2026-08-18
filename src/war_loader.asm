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


L_D6D8:
	di			;d6d8
	ld sp,0fde8h		;d6d9
	call L_D7C4		;d6dc
	call L_D78D		;d6df
	call L_D792		;d6e2
	call L_D797		;d6e5
	ld hl,0dac0h		;d6e8
	ld de,0012ch		;d6eb
	ld bc,00064h		;d6ee
	ldir		;d6f1
	call L_D766		;d6f3
	ld ix,088b8h		;d6f6
	ld de,03064h		;d6fa
	xor a			;d6fd
	scf			;d6fe
	call L_D8C0		;d6ff
	ld hl,0891ch		;d702
	ld de,00000h		;d705
	ld bc,01800h		;d708
	call L_D748		;d70b
	ld hl,0a11ch		;d70e
	ld de,02000h		;d711
	ld bc,01800h		;d714
	call L_D748		;d717
	call L_D772		;d71a
	ld ix,00190h		;d71d
	ld de,03dbfh		;d721
	xor a			;d724
	scf			;d725
	call L_D8C0		;d726
	ld ix,03f4fh		;d729
	ld de,038f1h		;d72d
	xor a			;d730
	scf			;d731
	call L_D8C0		;d732
	ld ix,088b8h		;d735
	ld de,04878h		;d739
	xor a			;d73c
	scf			;d73d
	call L_D8C0		;d73e
	jp 00190h		;d741

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


L_D748:
	di			;d748
	ex de,hl			;d749
	call L_D759		;d74a
	ex de,hl			;d74d
L_D74E:
	ld a,(hl)			;d74e
	out (098h),a		;d74f
	inc hl			;d751
	dec bc			;d752
	ld a,b			;d753
	or c			;d754
	jp nz,L_D74E		;d755
	ret			;d758
L_D759:
	ld a,l			;d759
	out (099h),a		;d75a
	ld a,h			;d75c
	and 03fh		;d75d
	or 040h		;d75f
	out (099h),a		;d761
	ex (sp),hl			;d763
	ex (sp),hl			;d764
	ret			;d765
L_D766:
	di			;d766
	in a,(099h)		;d767
	ld a,0a0h		;d769
	out (099h),a		;d76b
	ld a,081h		;d76d
	out (099h),a		;d76f
	ret			;d771
L_D772:
	di			;d772
	in a,(099h)		;d773
	ld a,0e0h		;d775
	out (099h),a		;d777
	ld a,081h		;d779
	out (099h),a		;d77b
	ret			;d77d
L_D77E:
	ld hl,0d745h		;d77e
	jr L_D79C		;d781
L_D783:
	ld hl,0d745h		;d783
	jr L_D7A2		;d786
L_D788:
	ld hl,0d745h		;d788
	jr L_D7A8		;d78b
L_D78D:
	ld hl,0d747h		;d78d
	jr L_D79C		;d790
L_D792:
	ld hl,0d747h		;d792
	jr L_D7A2		;d795
L_D797:
	ld hl,0d747h		;d797
	jr L_D7A8		;d79a
L_D79C:
	ld d,003h		;d79c
	ld e,0fch		;d79e
	jr L_D7AC		;d7a0
L_D7A2:
	ld d,00ch		;d7a2
	ld e,0f3h		;d7a4
	jr L_D7AC		;d7a6
L_D7A8:
	ld d,030h		;d7a8
	ld e,0cfh		;d7aa
L_D7AC:
	di			;d7ac
	ld a,(hl)			;d7ad
	and d			;d7ae
	ld b,a			;d7af
	ld a,(0ffffh)		;d7b0
	cpl			;d7b3
	and e			;d7b4
	or b			;d7b5
	ld (0ffffh),a		;d7b6
	dec hl			;d7b9
	ld a,(hl)			;d7ba
	and d			;d7bb
	ld b,a			;d7bc
	in a,(0a8h)		;d7bd
	and e			;d7bf
	or b			;d7c0
	out (0a8h),a		;d7c1
	ret			;d7c3
L_D7C4:
	di			;d7c4
	ld a,(08000h)		;d7c5
	push af			;d7c8
	call L_D809		;d7c9
	ld hl,00024h		;d7cc
	ld (0d827h),hl		;d7cf
	ld hl,04000h		;d7d2
	call L_D81B		;d7d5
	ld hl,08000h		;d7d8
	call L_D81B		;d7db
	ld hl,L_D846		;d7de
	ld de,0afc8h		;d7e1
	ld bc,0007ah		;d7e4
	ldir		;d7e7
	ld hl,0afc8h		;d7e9
	ld (0d827h),hl		;d7ec
	ld hl,00000h		;d7ef
	call L_D81B		;d7f2
	call L_D80E		;d7f5
	ld a,(0d744h)		;d7f8
	out (0a8h),a		;d7fb
	ld a,(0d745h)		;d7fd
	ld (0ffffh),a		;d800
	pop af			;d803
	ld (08000h),a		;d804
	ei			;d807
	ret			;d808
L_D809:
	ld hl,0d744h		;d809
	jr L_D811		;d80c
L_D80E:
	ld hl,0d746h		;d80e
L_D811:
	in a,(0a8h)		;d811
	ld (hl),a			;d813
	inc hl			;d814
	ld a,(0ffffh)		;d815
	cpl			;d818
	ld (hl),a			;d819
	ret			;d81a
L_D81B:
	ld a,080h		;d81b
	ld c,004h		;d81d
L_D81F:
	and 083h		;d81f
	ld b,004h		;d821
L_D823:
	push af			;d823
	push bc			;d824
	push hl			;d825
	call 00024h		;d826   ; BIOS ENASLT - Switches to specified slot and page definitively
	pop hl			;d829
	ld (hl),020h		;d82a
	ld a,(hl)			;d82c
	cp 020h		;d82d
	jr nz,L_D838		;d82f
	ld (hl),0fah		;d831
	ld a,(hl)			;d833
	cp 0fah		;d834
	jr z,L_D843		;d836
L_D838:
	pop bc			;d838
	pop af			;d839
	add a,004h		;d83a
	djnz L_D823		;d83c
	inc a			;d83e
	dec c			;d83f
	jr nz,L_D81F		;d840
	ret			;d842
L_D843:
	pop bc			;d843
	pop af			;d844
	ret			;d845
L_D846:
	call 0afe8h		;d846
	jp m,0afd5h		;d849
	in a,(0a8h)		;d84c
	and c			;d84e
	or b			;d84f
	out (0a8h),a		;d850
	ret			;d852
L_D853:
	push hl			;d853
	call 0b00ch		;d854
	ld c,a			;d857
	ld b,000h		;d858
	ld a,l			;d85a
	and h			;d85b
	or d			;d85c
	ld hl,0fcc5h		;d85d
	add hl,bc			;d860
	ld (hl),a			;d861
	pop hl			;d862
	ld a,c			;d863
	jr L_D846		;d864
L_D866:
	push af			;d866
	ld a,h			;d867
	rlca			;d868
	rlca			;d869
	and 003h		;d86a
	ld e,a			;d86c
	ld a,0c0h		;d86d
L_D86F:
	rlca			;d86f
	rlca			;d870
	dec e			;d871
	jp p,0aff1h		;d872
	ld e,a			;d875
	cpl			;d876
	ld c,a			;d877
	pop af			;d878
	push af			;d879
	and 003h		;d87a
	inc a			;d87c
	ld b,a			;d87d
	ld a,0abh		;d87e
L_D880:
	add a,055h		;d880
	djnz L_D880		;d882
	ld d,a			;d884
	and e			;d885
	ld b,a			;d886
	pop af			;d887
	and a			;d888
	ret			;d889
L_D88A:
	push af			;d88a
	ld a,d			;d88b
	and 0c0h		;d88c
	ld c,a			;d88e
	pop af			;d88f
	push af			;d890
	ld d,a			;d891
	in a,(0a8h)		;d892
	ld b,a			;d894
	and 03fh		;d895
	or c			;d897
	out (0a8h),a		;d898
	ld a,d			;d89a
	rrca			;d89b
	rrca			;d89c
	and 003h		;d89d
	ld d,a			;d89f
	ld a,0abh		;d8a0
L_D8A2:
	add a,055h		;d8a2
	dec d			;d8a4
	jp p,0b024h		;d8a5
	and e			;d8a8
	ld d,a			;d8a9
	ld a,e			;d8aa
	cpl			;d8ab
	ld h,a			;d8ac
	ld a,(0ffffh)		;d8ad
	cpl			;d8b0
	ld l,a			;d8b1
	and h			;d8b2
	or d			;d8b3
	ld (0ffffh),a		;d8b4
	ld a,b			;d8b7
	out (0a8h),a		;d8b8
	pop af			;d8ba
	and 003h		;d8bb
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


L_D8C0:
	di			;d8c0
	ld hl,L_D972		;d8c1
	push hl			;d8c4
	push af			;d8c5
	ld a,007h		;d8c6
	out (0a0h),a		;d8c8
	ld a,03fh		;d8ca
	out (0a1h),a		;d8cc
	ld a,008h		;d8ce
	out (0abh),a		;d8d0
	ld a,00eh		;d8d2
	out (0a0h),a		;d8d4
	pop af			;d8d6
	inc d			;d8d7
	ex af,af'			;d8d8
	dec d			;d8d9
	di			;d8da
	ld a,005h		;d8db
	ld c,a			;d8dd
	cp a			;d8de
L_D8DF:
	call L_D94F		;d8df
	jr nc,L_D8DF		;d8e2
	ld hl,00415h		;d8e4
L_D8E7:
	djnz L_D8E7		;d8e7
	dec hl			;d8e9
	ld a,h			;d8ea
	or l			;d8eb
	jr nz,L_D8E7		;d8ec
	call L_D94B		;d8ee
	jr nc,L_D8DF		;d8f1
L_D8F3:
	ld b,09ch		;d8f3
	call L_D94B		;d8f5
	jr nc,L_D8DF		;d8f8
	ld a,0c6h		;d8fa
	cp b			;d8fc
	jr nc,L_D8DF		;d8fd
	inc h			;d8ff
	jr nz,L_D8F3		;d900
L_D902:
	ld b,0c9h		;d902
	call L_D94F		;d904
	jr nc,L_D8DF		;d907
	ld a,b			;d909
	cp 0d4h		;d90a
	jr nc,L_D902		;d90c
	call L_D94F		;d90e
	ret nc			;d911
	ld h,000h		;d912
	ld b,0b0h		;d914
	jr L_D930		;d916
L_D918:
	ex af,af'			;d918
	jr nz,L_D920		;d919
	ld (ix+000h),l		;d91b
	jr L_D92A		;d91e
L_D920:
	rr c		;d920
	xor l			;d922
	ret nz			;d923
	ld a,c			;d924
	rla			;d925
	ld c,a			;d926
	inc de			;d927
	jr L_D92C		;d928
L_D92A:
	inc ix		;d92a
L_D92C:
	dec de			;d92c
	ex af,af'			;d92d
	ld b,0b2h		;d92e
L_D930:
	ld l,001h		;d930
L_D932:
	call L_D94B		;d932
	ret nc			;d935
	ld a,0cbh		;d936
	cp b			;d938
	rl l		;d939
	ld b,0b0h		;d93b
	jp nc,L_D932		;d93d
	ld a,h			;d940
	xor l			;d941
	ld h,a			;d942
	ld a,d			;d943
	or e			;d944
	jr nz,L_D918		;d945
	ld a,h			;d947
	cp 001h		;d948
	ret			;d94a
L_D94B:
	call L_D94F		;d94b
	ret nc			;d94e
L_D94F:
	ld a,016h		;d94f
L_D951:
	dec a			;d951
	jr nz,L_D951		;d952
	and a			;d954
L_D955:
	inc b			;d955
	nop			;d956
	ret z			;d957
	ld a,000h		;d958
	in a,(0a2h)		;d95a
	cpl			;d95c
	xor c			;d95d
	and 080h		;d95e
	jp z,L_D955		;d960
	ld a,c			;d963
	cpl			;d964
	ld c,a			;d965
	ld a,r		;d966
	and 00fh		;d968
	out (099h),a		;d96a
	ld a,087h		;d96c
	out (099h),a		;d96e
	scf			;d970
	ret			;d971
L_D972:
	ld e,013h		;d972
	ld a,009h		;d974
	out (0abh),a		;d976
	ld a,001h		;d978
	out (099h),a		;d97a
	ld a,087h		;d97c
	out (099h),a		;d97e
	ret			;d980
