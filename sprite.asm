        !cpu 6502
        !to "sprite.prg",cbm

        *= $1000
start
;        lda #$20
;        ldx #$00
;clr     sta $0400,x
;        sta $0500,x
;        sta $0600,x
;        sta $06e8,x
;        inx
;        bne clr
;
        sei
        lda #$7f
        sta $dc0d
        sta $dd0d
        lda $dc0d
        lda $dd0d
        lda #$01
        sta $d01a
        lda #$00
        sta $d012
        lda #<irq
        sta $fffe
        lda #>irq
        sta $ffff
        lda #$1b
        sta $d011
        lda #$35
        sta $01
        lda #$80
        sta $07f8
        sta $07f9
        sta $07fa
        sta $07fb
        lda #$0f
        sta $d015
        lda #$f0
        sta $d000
        lda #$f4
        sta $d002
        lda #$f8
        sta $d004
        lda #$fc
        sta $d006
        lda #$01
        sta $d027
        sta $d028
        sta $d029
        sta $d02a
        cli
        jmp *

irq
        sta rega+1
        stx regx+1
        sty regy+1


        ; spr 0
offset0 ldx #$00
        lda table,x
        sta $d001
        inx
        stx offset0+1

        ldx $d000
indec0  inx
cpxval0 cpx #$ff
        bne store0
        lda indec0
        eor #$22
        sta indec0
        lda cpxval0+1
        eor #$ff
        sta cpxval0+1
store0
        stx $d000


        ; spr 1
offset1 ldx #$04
        lda table,x
        sta $d003
        inx
        stx offset1+1

        ldx $d002
indec1  inx
cpxval1 cpx #$ff
        bne store1
        lda indec1
        eor #$22
        sta indec1
        lda cpxval1+1
        eor #$ff
        sta cpxval1+1
store1
        stx $d002


        ; spr 2
offset2 ldx #$08
        lda table,x
        sta $d005
        inx
        stx offset2+1

        ldx $d004
indec2  inx
cpxval2 cpx #$ff
        bne store2
        lda indec2
        eor #$22
        sta indec2
        lda cpxval2+1
        eor #$ff
        sta cpxval2+1
store2
        stx $d004


        ; spr 3
offset3 ldx #$0c
        lda table,x
        sta $d007
        inx
        stx offset3+1

        ldx $d006
indec3  inx
cpxval3 cpx #$ff
        bne store3
        lda indec3
        eor #$22
        sta indec3
        lda cpxval3+1
        eor #$ff
        sta cpxval3+1
store3
        stx $d006


        lda #$01
        sta $d019
rega    lda #$00
regx    ldx #$de
regy    ldy #$ad
        rti

        *= $2000
        !bin "res/sprite1.prg"
        !bin "res/sprite1.prg"
        !bin "res/sprite1.prg"
        !bin "res/sprite1.prg"

table
!byte $96,$93,$91,$8E,$8C,$89,$87,$85,$82,$80,$7E,$7C,$7A,$78,$76,$74
!byte $72,$70,$6F,$6D,$6C,$6A,$69,$68,$67,$66,$66,$65,$64,$64,$64,$64
!byte $64,$64,$64,$64,$65,$65,$66,$67,$68,$69,$6A,$6B,$6C,$6E,$6F,$71
!byte $73,$75,$77,$79,$7B,$7D,$7F,$81,$83,$86,$88,$8A,$8D,$8F,$92,$94
!byte $97,$99,$9C,$9E,$A1,$A3,$A5,$A8,$AA,$AC,$AE,$B0,$B2,$B4,$B6,$B8
!byte $BA,$BC,$BD,$BF,$C0,$C1,$C2,$C3,$C4,$C5,$C6,$C6,$C7,$C7,$C7,$C7
!byte $C7,$C7,$C7,$C7,$C6,$C5,$C5,$C4,$C3,$C2,$C1,$BF,$BE,$BC,$BB,$B9
!byte $B7,$B5,$B3,$B1,$AF,$AD,$AB,$A9,$A6,$A4,$A2,$9F,$9D,$9A,$98,$96

!byte $96,$97,$98,$99,$9A,$9C,$9D,$9E,$9F,$A0,$A1,$A2,$A3,$A4,$A5,$A6
!byte $A7,$A8,$A9,$AA,$AA,$AB,$AC,$AC,$AD,$AD,$AD,$AE,$AE,$AE,$AE,$AE
!byte $AE,$AE,$AE,$AE,$AE,$AE,$AD,$AD,$AC,$AC,$AB,$AB,$AA,$A9,$A9,$A8
!byte $A7,$A6,$A5,$A4,$A3,$A2,$A1,$A0,$9F,$9D,$9C,$9B,$9A,$99,$97,$96
!byte $95,$94,$92,$91,$90,$8F,$8E,$8C,$8B,$8A,$89,$88,$87,$86,$85,$84
!byte $83,$82,$82,$81,$80,$80,$7F,$7F,$7E,$7E,$7D,$7D,$7D,$7D,$7D,$7D
!byte $7D,$7D,$7D,$7D,$7D,$7E,$7E,$7E,$7F,$7F,$80,$81,$81,$82,$83,$84
!byte $85,$86,$87,$88,$89,$8A,$8B,$8C,$8D,$8E,$8F,$91,$92,$93,$94,$96
