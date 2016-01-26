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
         sta $d800,x ; clear foreground
         sta $d900,x ; char colour data
         sta $da00,x
         sta $dae8,x
         inx
         bne clear

         ldx #$00
loadtxt
         lda line1,x
         and #$3f
         sta $05e5,x
         lda line2,x
         and #$3f
         sta $060d,x
         inx
         cpx #$1e
         bne loadtxt

         sei       ; disable interrupts
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

colwash
         ldy #$00
         ldx coloroffset
cycle
         cpx #$26
         bcc skip
         ldx #$00
skip
         lda colortbl,x
         sta $d9e5,y
         iny
         inx
         cpy #$1e
         bne cycle

         sec
         lda #$26
         sbc coloroffset
         tax
         ldy #$00
cycle2
         cpx #$26
         bcc skip2
         ldx #$00
skip2
         lda colortbl,x
         sta $da0d,y
         iny
         inx
         cpy #$1e
         bne cycle2

         ldx coloroffset
         inx
         cpx #$26
         bne skip3
         ldx #$00
skip3
         stx coloroffset
         rts

line1
         .text "some awesome text"
         .text " goes here..."

line2
         .text "...brought to you"
         .text " by 0xb00fd0g"

colortbl
         .byte $09,$09,$02,$02
         .byte $08,$08,$0a,$0a
         .byte $0f,$0f,$07,$07
         .byte $01,$01,$01,$01
         .byte $01,$01,$01,$01
         .byte $01,$01,$01,$01
         .byte $01,$01,$01,$01
         .byte $0f,$0f,$0a,$0a
         .byte $08,$08,$02,$02
         .byte $09,$09

coloroffset
         .byte $00

irq
         dec $d019
         jsr colwash
         jmp $ea81

 
