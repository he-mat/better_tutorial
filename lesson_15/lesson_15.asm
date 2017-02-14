%include	'functions.asm'

SECTION .data
 msg1	db	' remainder '		; a message string to correctly output result

SECTION .text
 global _start

_start:
 mov	eax, 90		; move our first number into EAX
 mov	ebx, 9		; move our second number into EBX
 div	ebx		; divide EAX by EBX
 call	iprint		; call our integer printing function
 mov	eax, msg1	; move our message into EAX for printing
 call	sprint		; call our string printing function
 mov	eax, edx	; move the remainder into EAX for printing
 call	iprintLF	; call our integer printing function with linefeed

 call	quit