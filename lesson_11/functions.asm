;------------------
; void iprint(Integer number)
; Integer printing function (itoa)
iprint:
 push	eax		; preserve EAX on the stack to be restored after function runs
 push	ecx		; preserve ECX on the stack to be restored after function runs
 push	edx		; preserve EDX on the stack to be restored after function runs
 push	esi		; preserve ESI on the stack to be restored after function runs
 mov	ecx, 0		; counter of how many bytes we need to print in the end

divideloop:
 inc	ecx		; count each byte to print - number of characters
 mov	edx, 0		; empty EDX
 mov	esi, 10		; mov 10 into ESI
 idiv	esi		; devide EAX by ESI
 add	edx, 48		; convert EDX to its ASCII representation - EDX holds the remainder after a divide instruction
 push	edx		; push EDX ( string representation of an integer) into the stack
 cmp	eax, 0		; can the integer be divided anymore?
 jnz	divideloop	; jump of not zero to the label divideloop

printloop:
 dec	ecx		; count down each byte that we put on the stack
 mov	eax, esp	; mov the stack pointer into EAX for printing
 call	sprint		; call our string printing function
 pop	eax		; remove last character from the stack to move ESP forward
 cmp	ecx, 0		; have we printed all bytes we pushed onto the stack?
 jnz	printloop	; jump if not zero to the label printloop

 pop	esi		; restore ESI to the value we pushed onto the stack at the start
 pop	edx		; restore ESI to the value we pushed onto the stack at the start
 pop	ecx		; restore ESI to the value we pushed onto the stack at the start
 pop	eax		; restore ESI to the value we pushed onto the stack at the start
 ret

;------------------
; void iprintLF(Integer number)
; Integer printing function with linefeed (itoa)
iprintLF:
 call	iprint		; call our integer printing function

 push	eax		; push EAX onto the stack to preserve it while we use the EAX register in this function
 mov	eax, 0Ah	; move 0Ah into EAX, this is the ASCII character for a linefeed
 push	eax		; push the linefeed onto the stack
 mov	eax, esp	; move the address of the linefeed character into EAX
 call	sprint		; call our string printing function
 pop	eax		; remove our linefeed character from the stack
 pop	eax		; restore EAX to what it was before calling this function
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