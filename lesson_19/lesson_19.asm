%include	'functions.asm'

SECTION .data
 command	db	'/bin/echo', 0h		; command to execute as string
 arg1		db	'Hello World!', 0h
 arguments	dd	command
		dd	arg1			; arguments to pass to commandline (in this case only one)
		dd	0h			; end of struct
 environment	dd	0h			; arguments to pass as environment variables (in this case none) end the struct

SECTION .text
 global _start

_start:
 mov	eax, 11		; invoke SYS_EXECVE
 mov	ebx, command	; address of the file to execute
 mov	ecx, arguments	; address of the arguments to pass to the commandline
 mov	edx, environment; address of the environment variables
 int	80h

 call	quit

;------------------
; here are some other commands to try:
; SECTION .data
;  command	db	'/bin/ls', 0h
;  arg1		db	'-l', 0h
;
; SECTION .data
;  command	db	'/bin/sleep', 0h
;  arg1		db	'5', 0h