         *= $1000
start
         ldx #$00
         stx $d020 ; this sets bg colour
         stx $d021 ; to black
clear
         lda #$20
         sta $0400,x ; clear char data
         sta $0500,x
         sta $0600,x
         sta $06e8,x
         lda #$00
         sta $d800,x ; clear foregrond
         sta $d900,x ; char colour data
         sta $da00,x
         sta $dae8,x
         inx
         bne clear

         sei ; disable interrupts
         ldy #$7f
         sty $dc0d
         sty $dd0d
         lda $dc0d
         lda $dd0d
         lda #$01
         sta $d01a
         lda #<irq
         ldx #>irq
         sta $0314
         stx $0315
         lda #$00
         sta $d012
         lda $d011
         and #$7f
         sta $d011
         cli
         jmp *

irq
         ldx waitoffset   ; 4   cycl
         lda wait1table,x ; 4-5 cycl
wait1                     ;
         cmp $d012        ; 4   cycl
         bne wait1        ; 3-4 cycl
         lda #$01         ; 2   cycl
         sta $d020        ; 4   cycl
         sta $d021       ; 4   cycl
        ;lda wait2table,x ; 4-5 cycl
        ;sta wait2byte    ; 4   cycl
         nop
         nop  ; 8 cycles of nops
         nop  ; instead of crap above
         nop
         ldx #$00         ; 2   cycl
wait2                     ;
         inx              ; 2   cycl
         cpx wait2byte    ; 4   cycl
         bne wait2        ; 3-4 cycl
         lda #$00         ; 2 cycl
         sta $d020        ; 4 cycl
         sta $d021        ; 4 cycl
         ldx waitoffset
         inx
         cpx #$14
         bne storeoffset
         ldx #$00
storeoffset
         stx waitoffset
skipshit
         asl $d019   ; ack intr
         pla         ; restore regs
         tay
         pla
         tax
         pla
         rti  ; return from call

wait1table
         .byte $a9,$a9,$a8,$a8
         .byte $a7,$a7,$a6,$a6
         .byte $a5,$a5,$a4,$a4
         .byte $a5,$a5,$a6,$a6
         .byte $a7,$a7,$a8,$a8
waitoffset
         .byte $00
wait2table
         .byte $04,$04,$04,$04
wait2byte
         .byte $04

 