%include	'functions.asm'

SECTION .text
 global _start

_start:
 pop	ecx		; first value on the stack is the number of arguments
 mov	edx, 0		; initialize our data register

nextarg:
 cmp	ecx, 0h		; check to see if we have any arguments left
 jz	nomoreargs	; if zero flag is set jump to nomoreargs label (effectively exiting the loop)
 pop	eax		; pop the next argument off the stack
 call	atoi		; convert our ascii string to decimal integer
 add	edx, eax	; perform our addition logic
 dec	ecx		; decrease our counter (number of arguments left)
 jmp	nextarg		; loop around

nomoreargs:
 mov	eax, edx	; move our data result into eax for printing
 call	iprintLF	; call our integer printing function

 call	quit