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
; void exit()
; exit program with no errors
quit:
 mov    eax, 1
 mov    ebx, 0
 int    80h
 ret