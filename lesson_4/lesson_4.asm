; hello world program with subroutines

SECTION .data
 msg	db	'Hello, brave new world!', 0Ah

SECTION .text
 global _start

_start:

 mov	eax, msg	; move the addres of our message string into EAX
 call	strlen		; call our function to calculate the length of the string

 mov	edx, eax	; our function leaves the result in EAX
 mov	eax, 4		; this is all the same as before
 mov	ebx, 1
 mov	ecx, msg
 int	80h

 mov	eax, 1
 mov	ebx, 0

strlen:			; our first function declaration
 push	ebx		; push the value from EBX onto the stack to preserve it while
			; we are using EBX in our function
 mov	ebx, eax	; move the address in EAX into EBX (they both point at the same address now)

nextchar:
 cmp	byte [eax], 0
 jz	finished
 inc	eax
 jmp	nextchar

finished:
 sub	eax, ebx
 pop	ebx		; pop the value from the stack back into EBX
 ret			; return to where the function was called