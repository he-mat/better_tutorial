%include	'functions.asm'

SECTION .text
 global _start

_start:
 mov	eax, 90		; move our first number into EAX
 mov	ebx, 9		; move our second number into EBX
 mul	ebx		; multiply EAX by EBX
 call	iprintLF	; call our integer print with linefeed function

 call	quit