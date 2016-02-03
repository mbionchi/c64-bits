        !cpu 6502
        !to "mus.prg",cbm

        *= $1000
        !bin "res/blaster.sid",,$7c+2

        ; this example uses
        ; Blaster.sid by Fameboy
        ; 
        ; sid file not included

        sid_init = $1000
        sid_play = $1003

        *= $2000
start
        jsr sid_init

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

        jsr sid_play

rega    lda #$00
regx    ldx #$de
regy    ldy #$ad
        rti
