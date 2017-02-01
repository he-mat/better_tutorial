this is a tutorial on how to write 32bit (x86) NASM Assembly code, compile and run it

first make sure you have nasm installed in your linux machine!
 $ sudo apt-get install nasm (for debian based systems)
 $ sudo dnf install nasm (for fedora23 or newer)

nasm files have the file extension .asm

to compile your code just run the "compile" program, use ./compile --help for first use
    for convinience I have created the directory /bin/scripts and put the compile file there
    then added the directory to my PATH in the bashrc file (google is your friend)
    now I only need to write compile filename [-y] to compile with nasm
    (the compile32 program automatically names your program "filename32", if you don't want that use the switch -n)

    or just use this code to compile manually
     $ nasm -f elf64 -o filename.o filename.asm
     $ ld -o filename filename.o

to run the programs you've compiled enter
 $ ./filename
    nasm automatically adds execute rights to the program

comments - comment your code! you can make the end of line a comment by using '; ex:
 CODE_WORKING ; COMMENT CODE_NOT_WORKING
;COMMENT
 CODE_WORKING

stack - continuous area of memory addressable for special registers, in RAM afaik

sections - every assembly program consists of these three sections (even if you don't use one explicitly)
    .data - used for declaring initialized data or constants
    .bss  - used for declaring uninitialized variables
    .text - used for code (all code goes here)

get 64bit syscalls here:
http://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/
important registers when using 64bit syntax:
 rax - temporary register, when using a syscall rax must contain a syscall number
 rdi - used to pass 1st argument to function
 rsi - pointer used to pass 2nd argument to function
 rdx - used to pass 3rd argument to function
 rcx - 4th
 r8  - 5th
 r9  - 6th

get 32bit syscalls here:
http://syscalls.kernelgrok.com/

important registers when using 32bit syntax:
 eax - temporary register, when using a syscall rax must contain a syscall number
 ebx - used to pass 1st argument to function
 ecx - pointer used to pass 2nd argument to function
 edx - used to pass 3rd argument to function
 esi - 4th
 edi - 5th

data types
 name           size in bytes   size in bits    abbreviation	uninitialized abbr.
 byte           1               8               db		resb
 word           2               16              dw		resw
 doubleword     4               32              dd		resd
 quadword       8               64              dq		resq
 tword          10              80              dt		rest
 ocotword       16              128             do		reso
 yword          32              256             dy		resy
 zword          64              512             dz		resz

while db, dw, dd, dq, dt, do, dy and dz are used for declaring initialized data,
      resb, resw, resd, resq, rest, reso, resy and resz are used for declaring uninitialized variables

incbin - includes external binary files

equ - defines constants ex:
 one equ 1

times - repeating instructions or data

arithmetic operations:
 add    add
 sub    substract
 mul    unsigned multiply
 imul   signed multiply
 div    unsigned division
 idiv   signed division
 inc    increment
 dec    decrement
 neg    negate

cmp - compares values ex:
 cmp rax, 50

cmp on its own doesn't do anything. to do something we have conditionals
 je     - if equal
 jz     - if zero
 jne    - if not equal
 jnz    - if not zero
 jg     - if first operand is greater than second
 jge    - if first operand is greater or equal to second
 ja     - same as jg but unsigned
 jae    - same as jge but unsigned

ex:
C CODE:
if (rax!=50) {
    exit();
} else {
    right();
}
NASM x64:
 cmp rax, 50    ; compare rax with 50
 jne .exit      ; perform .exit if rax is not equal to 50
 jmp .right     ; execute .right if that is not the case

jmp - unconditional jump, goto function (label) ex:
-------------------
_start:
 ;; ...
 ;; some code
 ;; ...
 jmp exit

exit:
 mov rax, 60
 mov rdi, 0
 syscall
-------------------

that's the most important things to get started done!
either try writing your own code, look at the following more advanced notes
or go to the individual lessons in the respective directories.

stack is a special region in the memory that operates on the lifo principle (Last Input, First Output)

there are 16 general-purpose registers for temporary data storage, (in a 64bit CPU)
rax, rbx, rcx, rdx, rdi, rsi, rbp, rsp, and r8-15
that's not a whole lot for serious applications, so we should store data in the stack
also: when we call a function the return address is copied to the stack
ex:

section .text

global _start
_start:
 mov rax, 1
 call incRax
 cmp rax, 2
 jne exit
 ; ...
 ; do something
 ; ...

incRax:
 inc rax
 ret

the code will be executed because rax is 2 after incRax

imagine a function like this:
int foo(int a1, int a2, int a2, int a4, int a5, int a6, int a7) {
    return (a1 + a2 - a3 - a4 + a5 - a6) * a7;
}
the first six arguments will be passed in registers, the 7th will be passed in stack

there are two stack pointers, the first one being rbp, or base pointer
 which points to the base of the current stack
and the other one being rsp, or stack pointer
 which points to the top of the current stack

the two commands for working with the stack are:
 push - increments rsp and stores argument in location pointed by pointer
 pop  - copies data to argument from location pointed by rsp
ex:

-------------------
section .text
 global _start

_start:
 mov rax, 1
 mov rdx, 2
 push rax
 push rdx

 mov rax, [rsp +8]

 ; ...
 ; do something
 ; ...

-------------------
we put 1 into rax and 2 into rdx registers. afterwards we push these values to the stack
since the stack works with the lifo principle (Last Input, First Output) the stack will
have the following structure:

        ###
RSP ->   2
         1
        ###

now lets write a simple program that will take two arguments, and output the sum
-------------------
section .data
 SYS_WRITE      equ 1
 STD_IN         equ 1
 SYS_EXIT       equ 60
 NEW_LINE       db  0xa
 WRONG_ARGC     db  "Must be two command line arguments!", 0xa
 len            equ $ - WRONG_ARGC

; we first declare some constants for ease of use and convenience
; and also two strings, one being the newline symbol and the other one an error message
; terminating with the new line symbol instead of NUL

section .text
 global _start

_start:
 pop rcx        ; put the argument count into rcx

 ;;
 ;; check argc
 ;;
 cmp rcx, 3     ; check wether we have 2 arguments supplied
                ; why 3? the first argument is always the program name
 jne argcError

 ;;
 ;; get arguments as strings, add them
 ;;
 add rsp, 8     ; skip argv[0] - program name
 pop rsi        ; get argv[1] - put into rsi
 call str_to_int; convert argv[1] to string, put into rax
 mov r10, rax   ; put first number into r10

 add rsp, 8     ; get to the second argument
 pop rsi        ; get argv[2] - put into rsi
 call str_to_int; convert argv[2] to string, put into rax
 mov r11, rax   ; put  second number into r11

 add r10, r11   ; add both numbers, save in r10

 ;;
 ;; convert to string
 ;;
 mov rax, r10
 xor r12, r12
 jmp int_to_str

;;
;; print argc error
;;
argcError:
 mov rax, SYS_WRITE
 mov rdi, STD_IN
 mov rsi, WRONG_ARGC
 mov rdx, len
 syscall
 jmp exit

;;
;; convert int to string
;;
int_to_str:
 mov rdx, 0
 mov rbx, 10
 div rbx        ; rax = rax / 10
 add rdx, 48
 add rdx, 0x0
 push rdx
 inc r12
 cmp rax, 0x0
 jne int_to_str
 jmp print

str_to_int:
 xor rax, rax
 mov rcx, 10

next:
 cmp [rsi], byte 0      ; check if it is the end of the string
 je return_str          ; return int
 mov bl, [rsi]          ; mov current char to bl
 sub bl, 48             ; get number
 mul rcx                ; rax = rax * 10
 add rax, rbx           ; ax = ax + digit
 inc rsi
 jmp next

return_str:
 ret

;;
;; print number
;;
print:
 ;;
 ;; calculate number length
 ;;
 mov rax, 1
 mul r12
 mov r12, 8
 mul r12
 mov rdx, rax

 ;;
 ;; print sum
 ;;
 mov rax, SYS_WRITE
 mov rdi, STD_IN
 mov rsi, rsp
 syscall

 jmp printNewLine

;;
;; prints new line symbol
;;
printNewline:
 mov rax, SYS_WRITE
 mov rdi, STD_IN
 mov rsi, NEW_LINE
 mov rdx, 1
 syscall
 jmp exit

;;
;; exit from program
;;

exit:
 mov rax, SYS_EXIT
 mov rdi, EXIT_CODE
 syscall
-------------------
lets try to understand what's happening here:
the first instruction gets the first value from the stack and puts it into the rcx register
at program start everything will be in this order:
 [rsp]      - top of stack will contain argument count
 [rsp + 8]  - will contain argv[0]
 [rsp + 16] - will contain argv[1]
 etc...

also: why do we compare the argument count to 3 instead of 2?
the first argument is always the program name, so argument 1 is the first
that is also why we shift rsp to 8 before comparing
then we put the first argument into rsi and call the str_to_int function
after out function ends we will have the integer value in rax and will save it to r10
then we do the same thing with r11
now we can get the sum with the add command


the two programs described here are provided within the package as program1 and program2
run with ./program1 or ./program2 {value1} {value2}