        !cpu 6502
        !to "sprite.prg",cbm

        *= $1000
start
        sei
        lda #$7f
        sta $dc0d
        sta $dd0d
        lda $dc0d
        lda $dd0d
        lda #$01
        sta $d01a
        lda #$f8
        sta $d012
        lda #<irqmain
        sta $fffe
        lda #>irqmain
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
        sta $07fc
        sta $07fd
        sta $07fe
        sta $07ff
        lda #$ff
        sta $d015
        lda #$01
        sta $d027
        sta $d028
        sta $d029
        sta $d02a
        sta $d02b
        sta $d02c
        sta $d02d
        sta $d02e
        sta $d02f
        cli
        jmp *


advspr
        lda ytable,x
        sta $d001,y
        lda xtable,x
        sta $d000,y
        rts


irqmain
        pha
        txa
        pha
        tya
        pha

nextirl lda #<irqspr
        sta $fffe
nextirh lda #>irqspr
        sta $ffff

        inc $d012
        lda #$01
        sta $d019
        tsx
        cli

        nop
        nop
        nop
        nop
        nop
        nop
        nop
        nop

irqspr
        txs
        ldx #$08
        dex
        bne *-1
        bit $00
        lda $d012
        cmp $d012
        beq *+2

        lda #$13    ;open t/b borders
        sta $d011

        ldy #$00    ;spr0
off0    ldx #$00
        jsr advspr
        inx
        stx off0+1
        ldy #$02    ;spr1
off1    ldx #$08
        jsr advspr
        inx
        stx off1+1
        ldy #$04    ;spr2
off2    ldx #$10
        jsr advspr
        inx
        stx off2+1
        ldy #$06    ;spr3
off3    ldx #$18
        jsr advspr
        inx
        stx off3+1
        ldy #$08    ;spr4
off4    ldx #$20
        jsr advspr
        inx
        stx off4+1
        ldy #$0a    ;spr5
off5    ldx #$28
        jsr advspr
        inx
        stx off5+1
        ldy #$0c    ;spr6
off6    ldx #$30
        jsr advspr
        inx
        stx off6+1
        ldy #$0e    ;spr7
off7    ldx #$38
        jsr advspr
        inx
        stx off7+1

        lda #$00
        sta $d012
        lda #<irqmain
        sta $fffe
        lda #>irqmain
        sta $ffff
        lda #<irqfix
        sta nextirl+1
        lda #>irqfix
        sta nextirh+1

        lda #$01
        sta $d019
        pla
        tay
        pla
        tax
        pla
        rti


irqfix
        txs
        ldx #$08
        dex
        bne *-1
        bit $00
        lda $d012
        cmp $d012
        beq *+2

        lda #$3b    ;reset mode
        sta $d011

        lda #$f8    ;setup for next irq
        sta $d012
        lda #<irqmain
        sta $fffe
        lda #>irqmain
        sta $ffff
        lda #<irqspr
        sta nextirl+1
        lda #>irqspr
        sta nextirh+1

        lda #$01
        sta $d019
        pla
        tay
        pla
        tax
        pla
        rti

        *= $2000
        !bin "res/dot.spr"

xtable
!byte $50,$50,$50,$50,$50,$50,$50,$51,$51,$52,$52,$53,$53,$54,$55,$55
!byte $56,$57,$58,$59,$5A,$5B,$5C,$5D,$5E,$60,$61,$62,$64,$65,$66,$68
!byte $69,$6B,$6C,$6E,$70,$71,$73,$75,$77,$78,$7A,$7C,$7E,$80,$82,$84
!byte $86,$88,$8A,$8C,$8E,$90,$92,$94,$96,$99,$9B,$9D,$9F,$A1,$A3,$A5
!byte $A8,$AA,$AC,$AE,$B0,$B2,$B4,$B7,$B9,$BB,$BD,$BF,$C1,$C3,$C5,$C7
!byte $C9,$CB,$CD,$CF,$D1,$D3,$D5,$D6,$D8,$DA,$DC,$DD,$DF,$E1,$E2,$E4
!byte $E5,$E7,$E8,$EA,$EB,$ED,$EE,$EF,$F0,$F1,$F3,$F4,$F5,$F6,$F6,$F7
!byte $F8,$F9,$FA,$FA,$FB,$FC,$FC,$FD,$FD,$FD,$FE,$FE,$FE,$FE,$FE,$FE
!byte $FE,$FE,$FE,$FE,$FE,$FE,$FD,$FD,$FD,$FC,$FC,$FB,$FA,$FA,$F9,$F8
!byte $F7,$F6,$F6,$F5,$F4,$F3,$F1,$F0,$EF,$EE,$ED,$EB,$EA,$E8,$E7,$E5
!byte $E4,$E2,$E1,$DF,$DD,$DC,$DA,$D8,$D6,$D5,$D3,$D1,$CF,$CD,$CB,$C9
!byte $C7,$C5,$C3,$C1,$BF,$BD,$BB,$B9,$B7,$B4,$B2,$B0,$AE,$AC,$AA,$A8
!byte $A5,$A3,$A1,$9F,$9D,$9B,$99,$96,$94,$92,$90,$8E,$8C,$8A,$88,$86
!byte $84,$82,$80,$7E,$7C,$7A,$78,$77,$75,$73,$71,$70,$6E,$6C,$6B,$69
!byte $68,$66,$65,$64,$62,$61,$60,$5E,$5D,$5C,$5B,$5A,$59,$58,$57,$56
!byte $55,$55,$54,$53,$53,$52,$52,$51,$51,$50,$50,$50,$50,$50,$50,$50

ytable
!byte $A7,$A5,$A3,$A1,$9E,$9C,$9A,$98,$96,$94,$92,$90,$8E,$8B,$89,$87
!byte $85,$83,$81,$80,$7E,$7C,$7A,$78,$76,$74,$73,$71,$6F,$6E,$6C,$6A
!byte $69,$67,$66,$65,$63,$62,$61,$5F,$5E,$5D,$5C,$5B,$5A,$59,$58,$57
!byte $56,$55,$54,$54,$53,$53,$52,$52,$51,$51,$50,$50,$50,$50,$50,$50
!byte $50,$50,$50,$50,$50,$50,$51,$51,$51,$52,$52,$53,$53,$54,$55,$56
!byte $56,$57,$58,$59,$5A,$5B,$5C,$5D,$5F,$60,$61,$62,$64,$65,$67,$68
!byte $6A,$6B,$6D,$6E,$70,$72,$74,$75,$77,$79,$7B,$7D,$7F,$80,$82,$84
!byte $86,$88,$8A,$8C,$8F,$91,$93,$95,$97,$99,$9B,$9D,$9F,$A2,$A4,$A6
!byte $A8,$AA,$AC,$AF,$B1,$B3,$B5,$B7,$B9,$BB,$BD,$BF,$C2,$C4,$C6,$C8
!byte $CA,$CC,$CE,$CF,$D1,$D3,$D5,$D7,$D9,$DA,$DC,$DE,$E0,$E1,$E3,$E4
!byte $E6,$E7,$E9,$EA,$EC,$ED,$EE,$EF,$F1,$F2,$F3,$F4,$F5,$F6,$F7,$F8
!byte $F8,$F9,$FA,$FB,$FB,$FC,$FC,$FD,$FD,$FD,$FE,$FE,$FE,$FE,$FE,$FE
!byte $FE,$FE,$FE,$FE,$FE,$FE,$FD,$FD,$FC,$FC,$FB,$FB,$FA,$FA,$F9,$F8
!byte $F7,$F6,$F5,$F4,$F3,$F2,$F1,$F0,$EF,$ED,$EC,$EB,$E9,$E8,$E7,$E5
!byte $E4,$E2,$E0,$DF,$DD,$DB,$DA,$D8,$D6,$D4,$D2,$D0,$CE,$CD,$CB,$C9
!byte $C7,$C5,$C3,$C0,$BE,$BC,$BA,$B8,$B6,$B4,$B2,$B0,$AD,$AB,$A9,$A7
