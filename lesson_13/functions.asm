;------------------
; void iprint(Integer number)
; Integer printing function (itoa)
iprint:
 push	eax
 push	ecx
 push	edx
 push	esi
 mov	ecx, 0

divideloop:
 inc	ecx
 mov	edx, 0
 mov	esi, 10
 idiv	esi
 add	edx, 48
 push	edx
 cmp	eax, 0
 jnz	divideloop

printloop:
 dec	ecx
 mov	eax, esp
 call	sprint
 pop	eax
 cmp	ecx, 0
 jnz	printloop

 pop	esi
 pop	edx
 pop	ecx
 pop	eax
 ret

;------------------
; void iprintLF(Integer number)
; Integer printing function with linefeed (itoa)
iprintLF:
 call	iprint

 push	eax
 mov	eax, 0Ah
 push	eax
 mov	eax, esp
 call	sprint
 pop	eax
 pop	eax
 ret

;------------------
; int slen(String message)
; String length calculation function
slen:
 push   ebx
 mov    ebx, eax

nextchar:
 cmp    byte [eax], 0
 jz     finished
 inc    eax
 jmp    nextchar

finished:
 sub    eax, ebx
 pop    ebx
 ret

;------------------
; void sprint(String message)
; String printing function
sprint:
 push   edx
 push   ecx
 push   ebx
 push   eax
 call   slen

 mov    edx, eax
 pop    eax

 mov    ecx, eax
 mov    ebx, 1
 mov    eax, 4
 int    80h

 pop    ebx
 pop    ecx
 pop    edx
 ret

;------------------
; void sprintLF(String message)
; String printing with line feed
sprintLF:
 call	sprint

 push	eax
 mov	eax, 0Ah
 push	eax
 mov	eax, esp
 call	sprint
 pop	eax
 pop	eax
 ret

;------------------
; void quit()
; exit program with no errors
quit:
 mov    eax, 1
 mov    ebx, 0
 int    80h
 ret