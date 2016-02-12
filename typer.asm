        !cpu 6502
        !to "typer.prg",cbm

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
        lda #$00
        sta $d012
        lda #<irqmain
        sta $fffe
        lda #>irqmain
        sta $ffff
        lda #$1b
        sta $d011
        lda #$35
        sta $01
        cli
        jmp *


; typer:
;   x register: offset in the text/time
;               tables
;   
;   typer_skip+1,
;   typer+1:    low byte of timedata
;   typer_skip+2,
;   typer+2:    high byte of timedata
;   typer_putc+1:
;               low byte of textdata
;   typer_putc+2:
;               high byte of textdata
;   typer_putc+4:
;               low byte of screenmem
;   typer_putc+5:
;               high byte of screenmem
;
;   on return:  acc=0 => char put
typer
    lda timedata,x
    cmp #$00
    bne typer_skip
typer_putc
    lda textdata,x
    sta $0770,x
    lda #$08        ; optional:
    sta blinky+1    ; reset blinky
    lda #$00
    rts
typer_skip
    dec timedata,x
    rts


; blinky:
;   x register: offset in scrmem
;
;   blinky+1:   internal counter
;   blinky+10,
;   blinky+14:  low byte of scrmem
;   blinky+11,
;   blinky+15:  high byte of scrmem
;   blinky+13:  EOR value
blinky
    lda #$08
    and #$0f
    cmp #$08
    bne blinky_skip
    lda $0770,x
    eor #$80
    sta $0770,x
blinky_skip
    inc blinky+1
    rts


irqmain
        pha
        txa
        pha
        tya
        pha

typeoff ldx #$00    ;offset in text data
        jsr blinky
        jsr typer
        cmp #$00
        bne skippy
        inc typeoff+1
skippy

        lda #$01
        sta $d019

        pla
        tay
        pla
        tax
        pla
        rti

textdata
       !scr "login: mike "
textdata1
       !scr "password: ******* "

timedata  ;    l   o   g   i   n   :       m   i   k   e
       !byte $00,$00,$00,$00,$00,$00,$00,$48,$0b,$10,$07,$FF
timedata1   ;  p   a   s   s   w   o   r   d   :       *   *
       !byte $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$41,$0a
            ;  *   *   *   *   *       
       !byte $04,$08,$09,$0f,$03,$FF
