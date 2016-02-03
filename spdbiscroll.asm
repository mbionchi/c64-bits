        !cpu 6502
        !to "ts.prg",cbm
        *= $1000
        scrmem = $0770
start
        lda #$20
        ldx #$00
clr     sta $0400,x
        sta $0500,x
        sta $0600,x
        sta $06e8,x
        inx
        bne clr

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
        cli
        jmp *

irq
        sta rega+1
        stx regx+1
        sty regy+1
        lsr $d019

        lda $d016
        and #$07
rstcmp  cmp #$07
        bne shiftrastr
        lda $d016
rstres  and #$f8
        sta $d016

shift1  ldx #$00
shift2  jsr shifttext0

txtoff1 ldx #$00
txtoff2 cpx #$0a
        beq endall
data    lda text0,x
putchr  sta $0770
        inx
        stx txtoff1+1
shiftrastr
        inc $d016
        jmp endall2
endall
        ldx #$00
        cpx #$28
        beq what1
        inx
        stx endall+1
        jmp endall2
what1
        ; scroller over: what do now?
        inc $d020
where1  jsr scroll_rtl
endall2

rega    lda #$00
regx    ldx #$de
regy    ldy #$ad
        rti

scroll_ltr
        lda #$07
        sta rstcmp+1
        lda #$29        ; can XOR
        sta rstres
        lda #$f8
        sta rstres+1
        lda #$00
        sta shift1+1
        lda #<shifttext0
        sta shift2+1
        lda #>shifttext0
        sta shift2+2
        lda #$00
        sta txtoff1+1
        lda #$70
        sta putchr+1
        lda #$ee        ; can XOR
        sta shiftrastr
        lda #$00
        sta endall+1
        lda #<text0
        sta data+1
        lda #>text0
        sta data+2
        lda #<scroll_rtl
        sta where1+1
        lda #>scroll_rtl
        sta where1+2
        rts

scroll_rtl
        lda #$00
        sta rstcmp+1
        lda #$09        ; can XOR
        sta rstres
        lda #$07
        sta rstres+1
        lda #$02
        sta shift1+1
        lda #<shifttext2
        sta shift2+1
        lda #>shifttext2
        sta shift2+2
        lda #$00
        sta txtoff1+1
        lda #$97
        sta putchr+1
        lda #$ce        ; can XOR
        sta shiftrastr
        lda #$00
        sta endall+1
        lda #<text1
        sta data+1
        lda #>text1
        sta data+2
        lda #<scroll_ltr
        sta where1+1
        lda #>scroll_rtl
        sta where1+2
        rts

        ; speedcode from codebase64
shifttext2
        lda scrmem+1
        sta scrmem
shifttext0
        lda scrmem,x
        ldy scrmem+1,x
        sta scrmem+1
        lda scrmem+2,x
        sty scrmem+2
        ldy scrmem+3,x
        sta scrmem+3
        lda scrmem+4,x
        sty scrmem+4
        ldy scrmem+5,x
        sta scrmem+5
        lda scrmem+6,x
        sty scrmem+6
        ldy scrmem+7,x
        sta scrmem+7
        lda scrmem+8,x
        sty scrmem+8
        ldy scrmem+9,x
        sta scrmem+9
        lda scrmem+10,x
        sty scrmem+10
        ldy scrmem+11,x
        sta scrmem+11
        lda scrmem+12,x
        sty scrmem+12
        ldy scrmem+13,x
        sta scrmem+13
        lda scrmem+14,x
        sty scrmem+14
        ldy scrmem+15,x
        sta scrmem+15
        lda scrmem+16,x
        sty scrmem+16
        ldy scrmem+17,x
        sta scrmem+17
        lda scrmem+18,x
        sty scrmem+18
        ldy scrmem+19,x
        sta scrmem+19
        lda scrmem+20,x
        sty scrmem+20
        ldy scrmem+21,x
        sta scrmem+21
        lda scrmem+22,x
        sty scrmem+22
        ldy scrmem+23,x
        sta scrmem+23
        lda scrmem+24,x
        sty scrmem+24
        ldy scrmem+25,x
        sta scrmem+25
        lda scrmem+26,x
        sty scrmem+26
        ldy scrmem+27,x
        sta scrmem+27
        lda scrmem+28,x
        sty scrmem+28
        ldy scrmem+29,x
        sta scrmem+29
        lda scrmem+30,x
        sty scrmem+30
        ldy scrmem+31,x
        sta scrmem+31
        lda scrmem+32,x
        sty scrmem+32
        ldy scrmem+33,x
        sta scrmem+33
        lda scrmem+34,x
        sty scrmem+34
        ldy scrmem+35,x
        sta scrmem+35
        lda scrmem+36,x
        sty scrmem+36
        ldy scrmem+37,x
        sta scrmem+37
        lda scrmem+38,x
        sty scrmem+38
        ldy scrmem+39,x
        sta scrmem+39
        rts

text0
        !scr "woem woem "
text1
        !scr "woof woof "
