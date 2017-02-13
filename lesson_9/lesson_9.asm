%include	'functions.asm'

SECTION .data
 msg1	db	'Please enter your name: ', 0h	; message string asking user for input
 msg2	db	'Hello, ', 0h			; message string to use for output

SECTION .bss
 sinput:	resb	255			; reserve a 255 byte space in memory for users input string

SECTION .text
 global _start

_start:

 mov	eax, msg1
 call	sprint

 mov	eax, 3		; invoke SYS_READ
 mov	ebx, 0		; read from file descriptor STDIN
 mov	ecx, sinput	; reserved space to store our input (called buffer)
 mov	edx, 255	; number of bytes to read
 int	80h

 mov	eax, msg2
 call	sprint

 mov	eax, sinput	; move our buffer into EAX (Note: our input contains a linefeed)
 call	sprint		; call our printing function

 call	quit