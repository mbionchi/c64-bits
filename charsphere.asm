        !cpu 6502
        !to "cs.prg",cbm
        *= $1000
start
        lda #$00
        ldx #$00
clr     sta $0400,x
        sta $0500,x
        sta $0600,x
        sta $06e8,x
        inx
        bne clr

        lda #$00
        sta $d020
        sta $d021

        jsr drawsphere

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
        lda #$18
        sta $d018
        cli
        jmp *

        sphereloc = $04ac
drawsphere
        ldx #$00
draw
hhh0    lda #$00
        sta sphereloc,x
        adc #$10
        sta sphereloc+40,x
        adc #$10
        sta sphereloc+80,x
        adc #$10
        sta sphereloc+120,x
        adc #$10
        sta sphereloc+160,x
        adc #$10
        sta sphereloc+200,x
        adc #$10
        sta sphereloc+240,x
        adc #$10
        sta sphereloc+280,x
        adc #$10
        sta sphereloc+320,x
        adc #$10
        sta sphereloc+360,x
        adc #$10
        sta sphereloc+400,x
        adc #$10
        sta sphereloc+440,x
        adc #$10
        sta sphereloc+480,x
        adc #$10
        sta sphereloc+520,x
        adc #$10
        sta sphereloc+560,x
        adc #$10
        sta sphereloc+600,x
        inx
        inc hhh0+1
        cpx #$10
        beq quit
        jmp draw
quit
        rts

        row0col = $d8ac
        row1col = row0col+40
        row2col = row1col+40
        row3col = row2col+40
        row4col = row3col+40
        row5col = row4col+40
        row6col = row5col+40
        row7col = row6col+40
        row8col = row7col+40
        row9col = row8col+40
        rowacol = row9col+40
        rowbcol = rowacol+40
        rowccol = rowbcol+40
        rowdcol = rowccol+40
        rowecol = rowdcol+40
        rowfcol = rowecol+40

shiftcols
        ; begin horrible speedcode
        lda row0col+6
        sta row0col+5
        lda row0col+7
        sta row0col+6
        lda row0col+8
        sta row0col+7
        lda row0col+9
        sta row0col+8
        lda row0col+10
        sta row0col+9

        lda row1col+4
        sta row1col+3
        lda row1col+5
        sta row1col+4
        lda row1col+6
        sta row1col+5
        lda row1col+7
        sta row1col+6
        lda row1col+8
        sta row1col+7
        lda row1col+9
        sta row1col+8
        lda row1col+10
        sta row1col+9
        lda row1col+11
        sta row1col+10
        lda row1col+12
        sta row1col+11

        lda row2col+3
        sta row2col+2
        lda row2col+4
        sta row2col+3
        lda row2col+5
        sta row2col+4
        lda row2col+6
        sta row2col+5
        lda row2col+7
        sta row2col+6
        lda row2col+8
        sta row2col+7
        lda row2col+9
        sta row2col+8
        lda row2col+10
        sta row2col+9
        lda row2col+11
        sta row2col+10
        lda row2col+12
        sta row2col+11

        lda row3col+3
        sta row3col+1
        sta row3col+2
        lda row3col+4
        sta row3col+3
        lda row3col+5
        sta row3col+4
        lda row3col+6
        sta row3col+5
        lda row3col+8
        sta row3col+6
        sta row3col+7
        lda row3col+10
        sta row3col+8
        sta row3col+9
        lda row3col+11
        sta row3col+10
        lda row3col+12
        sta row3col+11
        lda row3col+13
        sta row3col+12

        lda row4col+2
        sta row4col+1
        lda row4col+4
        sta row4col+2
        lda row4col+5
        sta row4col+3
        sta row4col+4
        lda row4col+7
        sta row4col+5
        lda row4col+9
        sta row4col+6
        sta row4col+7
        lda row4col+10
        sta row4col+8
        sta row4col+9
        lda row4col+12
        sta row4col+10
        lda row4col+13
        sta row4col+11
        sta row4col+12
        lda row4col+14
        sta row4col+13

        lda row5col+2
        sta row5col+0
        sta row5col+1
        lda row5col+3
        sta row5col+2
        lda row5col+5
        sta row5col+3
        lda row5col+6
        sta row5col+4
        sta row5col+5
        lda row5col+9
        sta row5col+6
        sta row5col+7
        lda row5col+11
        sta row5col+8
        sta row5col+9
        lda row5col+12
        sta row5col+10
        sta row5col+11
        lda row5col+13
        sta row5col+12
        lda row5col+14
        sta row5col+13

        lda row6col+2
        sta row6col+0
        sta row6col+1
        lda row6col+3
        sta row6col+2
        lda row6col+4
        sta row6col+3
        lda row6col+6
        sta row6col+4
        sta row6col+5
        lda row6col+8
        sta row6col+6
        sta row6col+7
        lda row6col+10
        sta row6col+8
        sta row6col+9
        lda row6col+12
        sta row6col+10
        sta row6col+11
        lda row6col+13
        sta row6col+12
        lda row6col+14
        sta row6col+13

        lda row7col+2
        sta row7col+0
        sta row7col+1
        lda row7col+3
        sta row7col+2
        lda row7col+4
        sta row7col+3
        lda row7col+6
        sta row7col+4
        sta row7col+5
        lda row7col+8
        sta row7col+6
        sta row7col+7
        lda row7col+10
        sta row7col+8
        sta row7col+9
        lda row7col+12
        sta row7col+10
        sta row7col+11
        lda row7col+13
        sta row7col+12
        lda row7col+14
        sta row7col+13

        lda row8col+2
        sta row8col+0
        sta row8col+1
        lda row8col+3
        sta row8col+2
        lda row8col+4
        sta row8col+3
        lda row8col+6
        sta row8col+4
        sta row8col+5
        lda row8col+8
        sta row8col+6
        sta row8col+7
        lda row8col+10
        sta row8col+8
        sta row8col+9
        lda row8col+12
        sta row8col+10
        sta row8col+11
        lda row8col+13
        sta row8col+12
        lda row8col+14
        sta row8col+13

        lda row9col+2
        sta row9col+0
        sta row9col+1
        lda row9col+3
        sta row9col+2
        lda row9col+4
        sta row9col+3
        lda row9col+6
        sta row9col+4
        sta row9col+5
        lda row9col+8
        sta row9col+6
        sta row9col+7
        lda row9col+10
        sta row9col+8
        sta row9col+9
        lda row9col+12
        sta row9col+10
        sta row9col+11
        lda row9col+13
        sta row9col+12
        lda row9col+14
        sta row9col+13

        lda rowacol+2
        sta rowacol+0
        sta rowacol+1
        lda rowacol+3
        sta rowacol+2
        lda rowacol+5
        sta rowacol+3
        lda rowacol+6
        sta rowacol+4
        sta rowacol+5
        lda rowacol+9
        sta rowacol+6
        sta rowacol+7
        lda rowacol+11
        sta rowacol+8
        sta rowacol+9
        lda rowacol+12
        sta rowacol+10
        sta rowacol+11
        lda rowacol+13
        sta rowacol+12
        lda rowacol+14
        sta rowacol+13

        lda rowbcol+2
        sta rowbcol+1
        lda rowbcol+4
        sta rowbcol+2
        lda rowbcol+5
        sta rowbcol+3
        sta rowbcol+4
        lda rowbcol+7
        sta rowbcol+5
        lda rowbcol+9
        sta rowbcol+6
        sta rowbcol+7
        lda rowbcol+10
        sta rowbcol+8
        sta rowbcol+9
        lda rowbcol+12
        sta rowbcol+10
        lda rowbcol+13
        sta rowbcol+11
        sta rowbcol+12
        lda rowbcol+14
        sta rowbcol+13

        lda rowccol+3
        sta rowccol+1
        sta rowccol+2
        lda rowccol+4
        sta rowccol+3
        lda rowccol+5
        sta rowccol+4
        lda rowccol+6
        sta rowccol+5
        lda rowccol+8
        sta rowccol+6
        sta rowccol+7
        lda rowccol+10
        sta rowccol+8
        sta rowccol+9
        lda rowccol+11
        sta rowccol+10
        lda rowccol+12
        sta rowccol+11
        lda rowccol+13
        sta rowccol+12

        lda rowdcol+3
        sta rowdcol+2
        lda rowdcol+4
        sta rowdcol+3
        lda rowdcol+5
        sta rowdcol+4
        lda rowdcol+6
        sta rowdcol+5
        lda rowdcol+7
        sta rowdcol+6
        lda rowdcol+8
        sta rowdcol+7
        lda rowdcol+9
        sta rowdcol+8
        lda rowdcol+10
        sta rowdcol+9
        lda rowdcol+11
        sta rowdcol+10
        lda rowdcol+12
        sta rowdcol+11

        lda rowecol+4
        sta rowecol+3
        lda rowecol+5
        sta rowecol+4
        lda rowecol+6
        sta rowecol+5
        lda rowecol+7
        sta rowecol+6
        lda rowecol+8
        sta rowecol+7
        lda rowecol+9
        sta rowecol+8
        lda rowecol+10
        sta rowecol+9
        lda rowecol+11
        sta rowecol+10
        lda rowecol+12
        sta rowecol+11

        lda rowfcol+6
        sta rowfcol+5
        lda rowfcol+7
        sta rowfcol+6
        lda rowfcol+8
        sta rowfcol+7
        lda rowfcol+9
        sta rowfcol+8
        lda rowfcol+10
        sta rowfcol+9
        ; end horrible speedcode
        rts

irq
        sta rega+1
        stx regx+1
        sty regy+1

        jmp xoffs

xoffs   ldx #$00
        jsr shiftcols
        lda row0coltable,x
        sta row0col+10
        lda row1coltable,x
        sta row1col+12
        lda row2coltable,x
        sta row2col+12
        lda row3coltable,x
        sta row3col+13
        lda row4coltable,x
        sta row4col+14
        lda row56coltable,x
        sta row5col+15
        sta row5col+14
        sta row6col+15
        sta row6col+14
        lda row78coltable,x
        sta row7col+15
        sta row7col+14
        sta row8col+15
        sta row8col+14
        lda row9acoltable,x
        sta row9col+15
        sta row9col+14
        sta rowacol+15
        sta rowacol+14
        lda rowbcoltable,x
        sta rowbcol+14
        lda rowccoltable,x
        sta rowccol+13
        lda rowdcoltable,x
        sta rowdcol+12
        lda rowecoltable,x
        sta rowecol+12
        lda rowfcoltable,x
        sta rowfcol+10
        inx
        stx xoffs+1

        lda #<nada0
        sta xoffs-2
        lda #>nada0
        sta xoffs-1
        jmp done
nada0
        lda #<nada1
        sta xoffs-2
        lda #>nada1
        sta xoffs-1
        jmp done
nada1
        lda #<xoffs
        sta xoffs-2
        lda #>xoffs
        sta xoffs-1
done

        lda #$01
        sta $d019
rega    lda #$00
regx    ldx #$de
regy    ldy #$ad
        rti


        *= $2000
        !bin "res/halfsphere.map"

    ; god this is awful....

row0coltable  !byte $7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7
row1coltable  !byte $7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d
row2coltable  !byte $d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d
row3coltable  !byte $d,$d,$7,$b,$b,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$b,$b,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$b,$b,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$1,$d,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$1,$d,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$b,$b,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d
row4coltable  !byte $d,$d,$b,$b,$7,$1,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$1,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$1,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$1,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$1,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$1,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d
row56coltable !byte $d,$d,$b,$b,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$7,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$7,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$7,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d
row78coltable !byte $d,$d,$d,$b,$b,$b,$b,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$7,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$7,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$7,$b,$b,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d
row9acoltable !byte $d,$d,$d,$d,$d,$d,$b,$b,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$b,$b,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$b,$b,$b,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$b,$b,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$b,$b,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d
rowbcoltable  !byte $d,$d,$b,$b,$d,$d,$b,$b,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$b,$b,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$b,$b,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$b,$b,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$b,$b,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$b,$b,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$b,$b,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d
rowccoltable  !byte $d,$d,$d,$b,$b,$b,$b,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$b,$b,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$b,$b,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$b,$b,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$b,$b,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$b,$b,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$b,$b,$b,$b,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d
rowdcoltable  !byte $d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d
rowecoltable  !byte $d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d
rowfcoltable  !byte $d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$d,$7,$7,$1,$d,$d
