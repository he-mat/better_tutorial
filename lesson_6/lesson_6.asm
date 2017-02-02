%include	'functions.asm'

SECTION .data
 msg1	db	'Hello, brave new world!', 0Ah, 0h		; NOTE the NULL terminating byte
 msg2   db      'This is how we recycle in NASM.', 0Ah, 0h      ; NOTE the NULL terminating byte

SECTION .text
 global _start

_start:
 mov	eax, msg1
 call 	sprint

 mov	eax, msg2
 call	sprint

 call	quit

; expected output:
;
; Hello, brave new world!
; This is how we recycle in NASM.