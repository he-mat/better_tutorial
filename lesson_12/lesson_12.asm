%include	'functions.asm'

SECTION .text
 global _start

_start:
 mov	eax, 90		; move our first number into EAX
 mov	ebx, 9		; move our second number into EBX
 add	eax, ebx	; add the two numbers, leaving the result in the left register (EAX)
 call	iprintLF	; call our integer printing function

 call	quit