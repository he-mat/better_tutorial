%include 	'functions.asm'

SECTION .text
 global _start

_start:
 mov	ecx, 0

nextnumber:
 inc	ecx
 mov	eax, ecx
 call	iprintLF	; NOTE that we are calling our new integer printing function
 cmp	ecx, 10
 jne	nextnumber

 call quit

;------------------
; expected output
; 1
; 2
; 3
; 4
; 5
; 6
; 7
; 8
; 9
; 10