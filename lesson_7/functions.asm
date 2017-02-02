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

 push	eax		; push EAX onto the stack to preserve it while we use EAX in this function
 mov	eax, 0Ah	; move 0Ah into EAX - 0Ah is the ASCII character for a linefeed
 push	eax		; push the linefeed character onto the stack so we can get the address
 mov	eax, esp	; move the address of the current stack pointer into EAX for sprint
 call	sprint		; call our sprint function
 pop	eax		; remove our linefeed character from the stack
 pop	eax		; restore the original value of EAX before our function was called
 ret			; return to our program

;------------------
; void exit()
; exit program with no errors
quit:
 mov    eax, 1
 mov    ebx, 0
 int    80h
 ret