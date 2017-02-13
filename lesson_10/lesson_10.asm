%include	'functions.asm'

SECTION .text
 global _start

_start:
 mov	ecx, 0		; ECX is initialized as zero

nextnumber:
 inc	ecx		; increment ECX (by one)

 mov	eax, ecx	; move the address of our integer into EAX
 add	eax, 48		; add 48 to our number to convert from integer to ASCII for printing
 push	eax		; push EAX to the stack
 mov	eax, esp	; get the address of the character on the stack
 call	sprintLF	; call our print function

 pop	eax		; clean up the stack so we don't have unneeded bytes taking up space
 cmp	ecx, 10		; have we reacged 10 yet? compare our counter with decimal 10
 jne	nextnumber	; jump if not equal (effectively making this a loop)

 call quit

;------------------
; expected output:
; 1
; 2
; 3
; 4
; 5
; 6
; 7
; 8
; 9
; :
;
; we will fix this in the next lesson