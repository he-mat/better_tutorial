%include	'functions.asm'

SECTION .data
 childMsg	db	'this is the child process', 0h
 parentMsg	db	'this is the parent process', 0h

SECTION .text
 global _start

_start:
 mov	eax, 2		; invoke SYS_FORK (kernel OPCODE 2)
 int	80h

 cmp	eax, 0		; if the return value is zero, jump to child process
 jz	.child

 .parent:
  mov	eax, parentMsg
  call	sprintLF
  call	quit

 .child:
  mov	eax, childMsg
  call	sprintLF
  call	quit