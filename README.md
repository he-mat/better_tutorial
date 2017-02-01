## better_tutorial

>in comparison to the first tutorial that I wrote and never published, because it wasn't any good.


## Synopsis

This project is aimed at people who want to learn the NASM x86 Assembler and have no prior experience with it.

It's best to start with reading the notes to about the middle, then you can either start the lessons, have a go at
programming with NASM yourself or continue reading the advanced notes.


## Code Example
```assembly
; Hello World Program

SECTION .data
msg     db      'Hello World!', 0Ah     ; assign msg variable with your message string

SECTION .text
global  _start

_start:

mov   eax, 4    ; invoke SYS_WRITE (kernel opcode 4)
mov   ebx, 1    ; write to the STDOUT file
mov   ecx, msg  ; move the memory address of our message string into ecx
mov   edx, 13   ; number of bytes to write - one for each letter plus 0Ah (line feed character)
int   80h

mov   eax, 1    ; invoke SYS_EXIT (kernel OPCODE 1)
mov   ebx, 0    ; return 0 status on exit - 'No Errors'
int   80h
```

## Motivation

I wanted to create this project because I wanted to learn Assembly and thought that if I write down notes in an orderly manner somebody else might benefit from this as well. (Mervs looking at you)


## Installation

Just copy this project on you PC and start reading the notes. After about half of it you can start doing the lessons.
