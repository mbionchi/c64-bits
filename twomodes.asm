!cpu 6502
        !to "rc_intro.prg",cbm

        sid_init = $1000
        sid_play = $1003

        *= $0900

start
        jsr sid_init
        lda #$00
        sta $d020
        sta $d021
        ldx #$00
loaddccimage
        lda $3f40,x
        sta $d800,x
        lda $4040,x
        sta $d900,x
        lda $4140,x
        sta $da00,x
        lda $4240,x
        sta $db00,x
        inx
        bne loaddccimage
        lda #$18
        sta $d016
        lda #$78
        sta $d018

        lda #$20
        ldx #$00
clr     sta $0400,x
        sta $0500,x
        sta $0600,x
        sta $06e8,x
        inx
        bne clr

        lda #$01
        ldx #$00
col     sta $db70,x
        inx
        cpx #$28
        bne col

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
        lda #<irqmain
        sta $fffe
        lda #>irqmain
        sta $ffff
        lda #$3b  ;mode
        sta $d011
        lda #$35
        sta $01
        cli
        jmp *

irqmain
        pha
        txa
        pha
        tya
        pha

nextil  lda #<irqscroll
        sta $fffe
nextih  lda #>irqscroll
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

        *= $1000
        !bin "res/blaster.sid",,$7c+2

        *= $1c00
        !bin "res/recurse.scr"
        *= $2000
        !bin "res/recurse.map"
        *= $3f40
        !bin "res/recurse.col"

        *= $4400

irqbmp
        txs
        ldx #$08
        dex
        bne *-1
        bit $00
        lda $d012
        cmp $d012
        beq *+2

        lda #$3b  ;mode
        sta $d011
        lda #$18
        sta $d016
        lda #$78
        sta $d018

        jsr sid_play

        lda #$01
        sta $d020

        lda #$b1
        sta $d012
sirql   lda #<irqscroll
        sta nextil+1
sirqh   lda #>irqscroll
        sta nextih+1
        lda #<irqmain
        sta $fffe
        lda #>irqmain
        sta $ffff

        lda #$01
        sta $d019
        pla
        tay
        pla
        tax
        pla
        rti

irqscroll
        txs
        ldx #$08
        dex
        bne *-1
        bit $00
        lda $d012
        cmp $d012
        beq *+2

        lda #$1b  ;text mode
        sta $d011
sixteen lda #$c8  ;multicol off
        sta $d016
        lda #$14  ;
        sta $d018

        jsr softscroll

        lda #$00
        sta $d012
        lda #<irqbmp
        sta nextil+1
        lda #>irqbmp
        sta nextih+1
        lda #<irqmain
        sta $fffe
        lda #>irqmain
        sta $ffff

        lda #$01
        sta $d019
        pla
        tay
        pla
        tax
        pla
        rti

        scrmem = $0770

softscroll
        lda $d016
        and #$07
rstcmp  cmp #$00
        bne shiftrastr
        lda $d016
rstres  ora #$07
        sta $d016

shift1  ldx #$02
shift2  jsr shifttext2

txtoff1 ldx #$00
txtoff2 cpx #$19
        beq endall
data    lda text0,x
putchr  sta $0797
        inx
        stx txtoff1+1
shiftrastr
        dec $d016
        jmp endall2
endall
        ldx #$00
when1   cpx #$29
wherea  beq what1
damninc inx
        stx endall+1
        jmp endall2
what1
        ; scroller over: what do now?
        jsr change_dir
whothis
        lda #$00
        sta endall+1
nextt   jsr ldtext1
where1  ;jsr scroll_rtl
endall2
        lda $d016
        sta sixteen+1
        rts


change_dir
        lda rstcmp+1
        eor #$07
        sta rstcmp+1

        lda rstres
        eor #$20
        sta rstres

        lda rstres+1
        eor #$ff
        sta rstres+1

        lda shift1+1
        eor #$02
        cmp #$02
        bne shiftzero
        ldx #<shifttext2
        ldy #>shifttext2
        jmp shiftstore
shiftzero
        ldx #<shifttext0
        ldy #>shifttext0
shiftstore
        stx shift2+1
        sty shift2+2
        sta shift1+1

        lda putchr+1
        eor #$e7
        sta putchr+1

        lda shiftrastr
        eor #$20
        sta shiftrastr

        rts

ldtext1
        lda #$00
        sta txtoff1+1
        lda #$13
        sta txtoff2+1

        lda #$30
        sta when1+1

        lda #<text1
        sta data+1
        lda #>text1
        sta data+2

        lda #<ldtext2
        sta nextt+1
        lda #>ldtext2
        sta nextt+2
        rts

ldtext2
        lda #$00
        sta txtoff1+1
        lda #$0a
        sta txtoff2+1

        lda #$10
        sta when1+1

        lda #<text2
        sta data+1
        lda #>text2
        sta data+2

        lda #<ldtext3
        sta nextt+1
        lda #>ldtext3
        sta nextt+2
        rts

ldtext3
        lda #$00
        sta txtoff1+1
        lda #$1f
        sta txtoff2+1

        lda #$03
        sta when1+1

        lda #<text3
        sta data+1
        lda #>text3
        sta data+2

        lda #<ldtext4
        sta nextt+1
        lda #>ldtext4
        sta nextt+2
        rts

ldtext4
        lda #$00
        sta txtoff1+1
        lda #$FF
        sta txtoff2+1

        lda #$FF
        sta when1+1

        lda #<text4
        sta data+1
        lda #>text4
        sta data+2

        lda #$1a
        sta damninc
        sta damninc+1

        lda #<whothis
        sta wherea+1
        lda #>whothis
        sta wherea+2

        lda #<ldtext5
        sta nextt+1
        lda #>ldtext5
        sta nextt+2
        rts

ldtext5
        lda #$00
        sta txtoff1+1
        lda #$FF
        sta txtoff2+1

        lda #$FF
        sta when1+1

        lda #$1a
        sta damninc
        sta damninc+1

        lda #<whothis
        sta wherea+1
        lda #>whothis
        sta wherea+2

        lda #<text5
        sta data+1
        lda #>text5
        sta data+2

        lda #<ldtext6
        sta nextt+1
        lda #>ldtext6
        sta nextt+2
        rts

ldtext6
        lda #$00
        sta txtoff1+1
        lda #$FF
        sta txtoff2+1

        lda #$FF
        sta when1+1

        lda #<text6
        sta data+1
        lda #>text6
        sta data+2

        lda #$1a
        sta damninc
        sta damninc+1

        lda #<whothis
        sta wherea+1
        lda #>whothis
        sta wherea+2

        lda #<ldtext6
        sta nextt+1
        lda #>ldtext6
        sta nextt+2
        rts

irqthatscrollsthreelines
        txs
        ldx #$08
        dex
        bne *-1
        bit $00
        lda $d012
        cmp $d012
        beq *+2

        lda #$1b  ;text mode
        sta $d011
sixteen0 lda #$c8  ;multicol off
        sta $d016
        lda #$14  ;
        sta $d018

        lda $d016
        and #$07
        cmp #$00
        bne shiftrastr3
        lda $d016
        ora #$07
        sta $d016

        ldx #$00
load3lines
        lda $0771,x
        sta $0770,x
        lda $0749,x
        sta $0748,x
        lda $0721,x
        sta $0720,x
        inx
        cpx #$28
        bne load3lines

txtoff3 ldx #$00
        cpx #$f0
        beq endall3
        lda text4,x
        sta $0797
        lda text5,x
        sta $076f
        lda text6,x
        sta $0747
        inx
        stx txtoff3+1
shiftrastr3
        dec $d016
        jmp endall4
endall3
        ldx #$00
when2   cpx #$FF
        beq what2
        inx
        stx endall3+1
        jmp endall2
what2
        ; scroller over: what do now?
        inc $d020
        jsr change_dir
        lda #$00
        sta endall3+1
endall4
        lda $d016
        sta sixteen0+1
        rts

        lda #$00
        sta $d012
        lda #<irqbmp
        sta nextil+1
        lda #>irqbmp
        sta nextih+1
        lda #<irqmain
        sta $fffe
        lda #>irqmain
        sta $ffff

        lda #$01
        sta $d019
        pla
        tay
        pla
        tax
        pla
        rti

        ; horrible speedcode 
        ; needs to be generated
        ; procedurally
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
        !scr "look, i can do scrollers!"
text1
        !scr "...oot esrever dna "
text2
        !scr "anyway... "
