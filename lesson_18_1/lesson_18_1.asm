%include	'functions.asm'

SECTION .bss
 number	resb	255

SECTION .data
 welcome	db	'maximum number: ', 0h
 fizz		db	'Fizz', 0h
 buzz		db	'Buzz', 0h

SECTION .text
 global _start

_start:

 mov	eax, welcome	; print our welcoming string
 call	sprint

 mov	eax, 3		; invoke SYS_READ (OPCODE 3)
 mov	ebx, 0		; read from STDIN
 mov	ecx, number	; write to number
 mov	edx, 255	; maximum length in bytes
 int	80h

 mov	esi, 0		; initialize our checkFizz variable
 mov	edi, 0		; initialize our checkBuzz variable
 mov	ecx, 0		; initialize our counter variable

nextnumber:
 inc	ecx		; increment our counter variable

 .checkFizz:
  mov	edx, 0		; clear the EDX register - this will hold our remainder after division
  mov	eax, ecx	; move the value of our counter into EAX for division
  mov	ebx, 3		; move our number to divide by into EBX (in this case 3)
  div	ebx		; divide EAX by EBX
  mov	edi, edx	; move our remainder into EDI
  cmp	edi, 0		; compare the remainder to 0 (meaning the counter is divisible by 3)
  jne	.checkBuzz	; if it is not, go to label checkbuzz
  mov	eax, fizz	; else move the address of our fizz string into EAX for printing
  call	sprint		; print the string using our function

 .checkBuzz:
  mov	edx, 0		; clear the EDX register - this will hold our remainder after division
  mov	eax, ecx	; move the value of our counter into eax for division
  mov   ebx, 5		; move our number to divide by into ebx (in this case 5)
  div   ebx		; divide EAX by EBX
  mov   esi, edx	; move our remainder into EDI
  cmp   esi, 0		; compare the remainder to 0 (meaning the counter is divisible by 5)
  jne   .checkint	; if it is not, go to label checkint
  mov   eax, buzz	; else move the address of our fizz string into EAX for printing
  call  sprint		; print the string using our function

 .checkint:
  cmp	edi, 0		; EDI contains the remainder after the division in checkfizz
  je	.continue	; if equal (counter is divisible by 3) skip printing integer
  cmp	esi, 0		; ESI contains the reameinder after the division in checkbuzz
  je	.continue	; if equal (counter is divisible by 5) skip printing integer
  mov	eax, ecx	; else move the value in ECX (our counter) into eax for printing
  call	iprint		; call our integer printing function

 .continue:
  mov	eax, 0Ah	; move an ASCII linefeed character into EAX
  push	eax		; push the address of EAX onto the stack for printing
  mov	eax, esp	; get the stack pointer (address pointing towards the last item on the stack -> linefeed)
  call	sprint		; call our string printing function
  pop	eax		; pop EAX off of the stack as not to waste memory
  mov	eax, number	; put the user input number into eax to convert (atoi)
  call	atoi		; call our atoi function
  cmp	ecx, eax	; check if our counter has reached the user input number
  jne	nextnumber	; if not jump to the start of the loop

 call	quit