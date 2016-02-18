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

drawsphere
        ldx #$00
draw
hhh0    lda #$00
        sta $0400,x
hhh1    lda #$10
        sta $0428,x
hhh2    lda #$20
        sta $0450,x
hhh3    lda #$30
        sta $0478,x
hhh4    lda #$40
        sta $04a0,x
hhh5    lda #$50
        sta $04c8,x
hhh6    lda #$60
        sta $04f0,x
hhh7    lda #$70
        sta $0518,x
hhh8    lda #$80
        sta $0540,x
hhh9    lda #$90
        sta $0568,x
hhha    lda #$a0
        sta $0590,x
hhhb    lda #$b0
        sta $05b8,x
hhhc    lda #$c0
        sta $05e0,x
hhhd    lda #$d0
        sta $0608,x
hhhe    lda #$e0
        sta $0630,x
hhhf    lda #$f0
        sta $0658,x
        inx
        inc hhh0+1
        inc hhh1+1
        inc hhh2+1
        inc hhh3+1
        inc hhh4+1
        inc hhh5+1
        inc hhh6+1
        inc hhh7+1
        inc hhh8+1
        inc hhh9+1
        inc hhha+1
        inc hhhb+1
        inc hhhc+1
        inc hhhd+1
        inc hhhe+1
        inc hhhf+1
        cpx #$10
        beq quit
        jmp draw
quit
        rts

        row0col = $d800     ; 0
        row1col = $d828     ; 1
        row2col = $d850     ; 2
        row3col = $d878     ; 3
        row4col = $d8a0     ; 4
        row5col = $d8c8     ; 5
        row6col = $d8f0     ; 6
        row7col = $d918     ; 7
        row8col = $d940     ; 8
        row9col = $d968     ; 9
        rowacol = $d990     ; a
        rowbcol = $d9b8     ; b
        rowccol = $d9e0     ; c
        rowdcol = $da08     ; d
        rowecol = $da30     ; e
        rowfcol = $da58     ; f

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

xoffs   ldx #$00
        jsr shiftcols
        lda coltable,x
        sta row0col+10
        sta row1col+12
        sta row2col+12
        sta row3col+13
        sta row4col+14
        sta row5col+15
        sta row5col+14
        sta row6col+15
        sta row6col+14
        sta row7col+15
        sta row7col+14
        sta row8col+15
        sta row8col+14
        sta row9col+15
        sta row9col+14
        sta rowacol+15
        sta rowacol+14
        sta rowbcol+14
        sta rowccol+13
        sta rowdcol+12
        sta rowecol+12
        sta rowfcol+10
        inx
        cpx #$0f
        bne goon
        ldx #00
goon
        stx xoffs+1

        lda #$01
        sta $d019
rega    lda #$00
regx    ldx #$de
regy    ldy #$ad
        rti

coltable
        !byte $f,$f,$f,$f,$3,$3,$3,$3,$d,$d,$d,$d,$7,$7,$7,$7

        *= $2000
        !bin "res/halfsphere.map"
