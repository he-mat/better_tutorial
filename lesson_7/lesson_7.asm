%include	'functions.asm'

SECTION .data
 msg1	db	'Hello, brave new world!', 0h		; NOTE that we've removed the NULL terminating byte
 msg2   db      'This is how we recycle in NASM.', 0h	; NOTE that we've removed the NULL terminating byte

SECTION .text
 global _start

_start:
 mov	eax, msg1
 call 	sprintLF	; NOTE we are calling our new print with linefeed function

 mov	eax, msg2
 call	sprintLF        ; NOTE we are calling our new print with linefeed function

 call	quit

; expected output:
;
; Hello, brave new world!
; This is how we recycle in NASM.