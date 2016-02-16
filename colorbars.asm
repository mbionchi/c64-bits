    !cpu 6502
    !to "cb.prg",cbm

    *= $1000

    lda #$00
    sta $d020
    sta $d021

    jsr clrscr

    sei
    lda #$7f
    sta $dc0d
    sta $dd0d
    lda $dc0d
    lda $dd0d
    lda #$01
    sta $d01a
    lda #$34
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


clrscr
    ldx #$00
clrscr_loop
    lda #$20
    sta $0400,x
    sta $0500,x
    sta $0600,x
    sta $06e8,x
    lda #$00
    sta $d800,x
    sta $d900,x
    sta $da00,x
    sta $dae8,x
    inx
    bne clrscr_loop
    rts

irqmain
    pha
    txa
    pha
    tya
    pha

    lda #<irq0
    sta $fffe
    lda #>irq0
    sta $ffff

    inc $d012

    lda #$01
    sta $d019

    tsx

    cli

    nop         ;
    nop         ;
    nop         ;
    nop         ;
    nop         ;
    nop         ;
    nop         ;
    nop         ; 16

!align 255,0
irq0
    txs         ; 2     2
    ldx #$08    ; 2     4
    dex         ;
    bne *-1     ;48     52
    bit $00     ; 3     55
    lda $d012   ; 4     59
    cmp $d012   ; 4     63
    beq *+2     ; 3
    nop         ; 2

line0   ; $36
    lda coltbl  ; 4
    sta $d020   ; 4
    sta $d021   ; 4

    ldy #$08    ; 2
    dey         ; 2*
    bne *-1     ; 3  = 48
    nop         ; 2
    nop         ; 2
    nop         ; 2
    nop         ; 2

line1   ; $37
    lda coltbl+1 ; 4
    sta $d020   ; 4
    sta $d021   ; 4

    ldy #$08    ; 2
    dey         ; 2*
    bne *-1     ; 3 = 48
    nop         ; 2
    nop         ; 2
    nop         ; 2
    nop         ; 2

line2
    lda coltbl+2 ; 4
    sta $d020   ; 4
    sta $d021   ; 4

    ldy #$08    ; 2
    dey         ; 2*
    bne *-1     ; 3 = 48
    nop         ; 2
    nop         ; 2
    nop         ; 2
    nop         ; 2

line3   ; $38
    lda coltbl+3 ; 4
    sta $d020   ; 4
    sta $d021   ; 4

    ldy #$08    ; 2
    dey         ; 2*
    bne *-1     ; 3 = 48
    nop         ; 2
    nop         ; 2
    nop         ; 2
    nop         ; 2

line4   ; $39
    lda coltbl+4 ; 4
    sta $d020   ; 4
    sta $d021   ; 4

    ldy #$08    ; 2
    dey         ; 2*
    bne *-1     ; 3 = 48
    nop         ; 2
    nop         ; 2
    nop         ; 2
    nop         ; 2

line5   ; $3a   BADLINE
    lda coltbl+5 ; 4
    sta $d020   ; 4
    sta $d021   ; 4

    ldy #$02    ; 2
    dey         ; 2*
    bne *-1     ; 3 = 12
    nop         ; 2
    nop         ; 2
    nop         ; 2

line6   ; $3b
    lda coltbl+6 ; 4
    sta $d020   ; 4
    sta $d021   ; 4

    ldy #$08    ; 2
    dey         ; 2*
    bne *-1     ; 3 = 48
    nop         ; 2
    nop         ; 2
    nop         ; 2
    nop         ; 2

line7   ; $3c
    lda coltbl+7 ; 4
    sta $d020   ; 4
    sta $d021   ; 4

    ldy #$06    ; 2
    dey         ; 2*
    bne *-1     ; 3 = 42
    nop         ; 2
    nop         ; 2
    nop
    nop

loopcount
    lda #$10    ; 2 cycles
    cmp #$00    ; 2 cycles
    beq finish_up ; 3 cycles
    dec loopcount+1 ; 6 cycles
    jmp line0 ; 3 cycles
finish_up

    nop         ; 2
    nop         ; 2
    lda #$00    ; 2
    sta $d020
    sta $d021

    lda #$10
    sta loopcount+1

    inc line0+1
    inc line1+1
    inc line2+1
    inc line3+1
    inc line4+1
    inc line5+1
    inc line6+1
    inc line7+1

    lda #$34
    sta $d012
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

!align 255,0
coltbl
    !byte $d, $3, $e, $4, $6, $4, $e, $d
    !byte $7, $a, $8, $2, $9, $2, $8, $a
    !byte $d, $3, $e, $4, $6, $4, $e, $d
    !byte $7, $a, $8, $2, $9, $2, $8, $a
    !byte $d, $3, $e, $4, $6, $4, $e, $d
    !byte $7, $a, $8, $2, $9, $2, $8, $a
    !byte $d, $3, $e, $4, $6, $4, $e, $d
    !byte $7, $a, $8, $2, $9, $2, $8, $a
    !byte $d, $3, $e, $4, $6, $4, $e, $d
    !byte $7, $a, $8, $2, $9, $2, $8, $a
    !byte $d, $3, $e, $4, $6, $4, $e, $d
    !byte $7, $a, $8, $2, $9, $2, $8, $a
    !byte $d, $3, $e, $4, $6, $4, $e, $d
    !byte $7, $a, $8, $2, $9, $2, $8, $a
    !byte $d, $3, $e, $4, $6, $4, $e, $d
    !byte $7, $a, $8, $2, $9, $2, $8, $a
    !byte $d, $3, $e, $4, $6, $4, $e, $d
    !byte $7, $a, $8, $2, $9, $2, $8, $a
    !byte $d, $3, $e, $4, $6, $4, $e, $d
    !byte $7, $a, $8, $2, $9, $2, $8, $a
    !byte $d, $3, $e, $4, $6, $4, $e, $d
    !byte $7, $a, $8, $2, $9, $2, $8, $a
    !byte $d, $3, $e, $4, $6, $4, $e, $d
    !byte $7, $a, $8, $2, $9, $2, $8, $a
    !byte $d, $3, $e, $4, $6, $4, $e, $d
    !byte $7, $a, $8, $2, $9, $2, $8, $a
    !byte $d, $3, $e, $4, $6, $4, $e, $d
    !byte $7, $a, $8, $2, $9, $2, $8, $a
    !byte $d, $3, $e, $4, $6, $4, $e, $d
    !byte $7, $a, $8, $2, $9, $2, $8, $a
    !byte $d, $3, $e, $4, $6, $4, $e, $d
    !byte $7, $a, $8, $2, $9, $2, $8, $a
