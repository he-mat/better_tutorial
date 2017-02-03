%include	'functions.asm'

SECTION .text
 global _start

_start:

 pop	ecx		; the first value on the stack is the numbe of arguments passed

nextArg:
 cmp	ecx, 0h		; check to see if we have any arugments left
 jz	noMoreArgs	; if zero flag is set jump to noMoreArgs label (effectively exiting the loop)
 pop	eax		; pop the next argument off the stack
 call	sprintLF	; call our print with linefeed function
 dec	ecx		; decrement ECX by one
 jmp	nextArg		; jump to nextArg label, looping

noMoreArgs:
 call	quit