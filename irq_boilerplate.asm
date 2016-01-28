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
         sta $d012 ; magic d012 word
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
         sta areg+1 ; store   regs  in
         stx xreg+1 ; the memory after
         sty yreg+1 ; the load opcodes

         lsr $d019  ; ack interrupt

         ; what do ?
         inc $d020

areg     lda #$00   ; restore regs
xreg     ldx #$00
yreg     ldy #$00
         rti

d