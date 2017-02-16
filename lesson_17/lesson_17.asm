%include	'functions.asm'

SECTION .data
 msg1	db	'Jumping to finished label.', 0h
 msg2	db	'Inside subroutine number: ', 0h
 msg3	db	'Inside subroutine "finished".', 0h

SECTION .text
 global _start

_start:

subroutineOne:
 mov	eax, msg1
 call	sprintLF
 jmp	.finished	; jump to the local label in subroutineOne scope

 .finished:
  mov	eax, msg2
  call	sprint
  mov	eax, 1
  call	iprintLF

subroutineTwo:
 mov	eax, msg1
 call	sprintLF
 jmp	.finished	; jump to the local label in subroutineTwo scope

 .finished:
  mov	eax, msg2
  call	sprint
  mov	eax, 2
  call	iprintLF

  mov	eax, msg1
  call	sprintLF
  jmp	finished	; jump to the global label finished

finished:
 mov	eax, msg3
 call	sprintLF
 call	quit

;------------------
; expected output:
; Jumping to finished label.
; Inside subroutine number: 1
; Jumping to finished label.
; Inside subroutine number: 2
; Jumping to finished label.
; Inside subroutine "finished".