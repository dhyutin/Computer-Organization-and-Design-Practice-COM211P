;LAB4 Q1: TO DETERMINE IF A GIVEN NUMBER IS PRIME OR NOT
section .data             
	msg1 db "Given Number is not a Prime Number "
	len1 equ $ - msg1
    msg2 db "Given Number is a Prime Number"
    len2 equ $-msg2

section .text    
	global _start

_start: 

	mov eax,23       ;assign value for which we should determine if its prime or not
	push eax
	mov ebx,2
	div ebx
	mov ecx,eax      ;loop counter , count = number/2
	pop eax
	mov esi,1        ; index
	

prime_no:            ;Loop to check from 1 to n/2 if the number divides n or not
    mov edx,0        ; edx register will store the value of reminder
    inc esi          ;increment esi
    mov ebx,esi      ;move esi to ebx register 
    div ebx          ;divide number by esi
    cmp edx,0        ;compare the reminder with 0
    je is_not_prime  ;if reminder =0 ,it means that number has a divisor other than 1 and the number itself =>NOT PRIME
    mov eax,23
loop prime_no
    
is_prime:             ; prints "Number is prime"
    mov     ecx, msg2
    mov     edx, len2
    mov     ebx, 1
    mov     eax, 4
    int     0x80      ;Call kernel
    jmp exit

	
is_not_prime:            ;prints "Number not prime"
    mov     ecx, msg1
    mov     edx, len1
    mov     ebx, 1
    mov     eax, 4
    int     0x80         ;Call Kernel


exit:
	mov eax, 1   ;exit the program
	int 0x80