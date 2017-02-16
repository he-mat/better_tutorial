;------------------
; int atoi(Integer number)
; ASCII to integer function (atoi)
atoi:
 push	ebx		; preserve EBX, ECX, EDX, ESI on the stack
 push	ecx
 push	edx
 push	esi
 mov	esi, eax	; move pointer in EAX into ESI (our number to convert)
 mov	eax, 0		; initialize EAX and ECX with decimal 0
 mov	ecx, 0

 .multiplyloop:
  xor	ebx, ebx	; resets both lower and upper bytes of EBX to be 0
  mov	bl, [esi+ecx]	; move a single byte into EBXs registers lower half
  cmp	bl, 48		; compare EBX lower half against ASCII value 48 (character '0')
  jl	.finished	; jump if less than to label ".finished"
  cmp	bl, 57		; compare EBX lower half against ASCII value 57 (character '9')
  jg	.finished	; jump if greater than to label ".finished"
  cmp	bl, 10		; compare EBX lower half against ASCII value 10 (linefeed character)
  je	.finished	; jump if equal to label ".finished"
  cmp	bl, 0		; compare EBX lower half against ASCII value 0 (NULL character, the terminating bit)
  jz	.finished	; jump if zero to label ".finished"

  sub	bl, 48		; convert EBXs lower half to decimal representation
  add	eax, ebx	; add EBX to our integer value in EAX
  mov	ebx, 10		; move decimal value 10 into EBX
  mul	ebx		; multiply EAX by EBX to get place value
  inc	ecx		; increment ECX (our counter register)
  jmp	.multiplyloop	; continue our loop

 .finished:
  mov	ebx, 10
  div	ebx		; divide EAX by EBX (10)
  pop	esi		; restore all previous values
  pop	edx
  pop	ecx
  pop	ebx
  ret

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