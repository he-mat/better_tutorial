; Hello World Program
; Run with: ./lesson_1
; the result will throw an error, but that's fine!

SECTION .data
msg     db      'Hello World!', 0Ah     ; assign msg variable with your message string

SECTION .text
global  _start

_start:

 mov	eax, 4      ; invoke SYS_WRITE (kernel opcode 4)
 mov	ebx, 1      ; write to the STDOUT file
 mov	ecx, msg    ; move the memory address of our message string into ecx
 mov	edx, 13     ; number of bytes to write - one for each letter plus 0Ah (line feed character)
 int	80h