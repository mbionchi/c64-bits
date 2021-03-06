        !cpu 6502
        !to "ts.prg",cbm
        *= $1000
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

        lda $d016   ; check if we can
        and #$07    ; shift $d016
        cmp #$00
        bne shiftrastr
        lda $d016   ; reset raster and
        ora #$07    ; then shift chars
        sta $d016

        ldx #$00    ; shift existing
loop0               ; characters
        lda $0771,x
        sta $0770,x
        inx
        cpx #$28
        bne loop0

txtoffs ldx #$00    ; add a new char
        cpx #$09
        beq endall
        lda textdata,x
        sta $0797
        inx
        stx txtoffs+1
shiftrastr          ; horizontal raster
        dec $d016   ; shift
        jmp endall2
endall
        ldx #$00    ; a little thingy to
        cpx #$28    ; see whether text's
        beq what1   ; travelled 40 chars
        inx
        stx endall+1
        jmp endall2
what1
        ; scroller over: what do now?
endall2

rega    lda #$00
regx    ldx #$de
regy    ldy #$ad
        rti

textdata
        !scr "meow meow"
