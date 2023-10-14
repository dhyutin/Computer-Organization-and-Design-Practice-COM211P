;Lab4 Q2 : ARMSTRONG NUMBER
section .data
	res db '000000',0xa
    rlen equ $ - res

   msg1 db "Given Number is an Armstrong Number"
   len1 equ $ - msg1
   msg2 db "Given Number is not an Armstrong Number"
   len2 equ $ - msg2

section .text
	global _start
_start:
    xor ecx,ecx          ;to make ecx register 0
    xor ebx,ebx          ;to make ebx register 0
	mov eax,154          ;the number which should be checked if it's armstrong or not
	push eax             ; push the number (in eax) into the stack

	
	mov ecx,10           ;Loop Counter
	mov esi,0            ; digit counter

	
get_digit:              ;TO GET THE NUMBER OF DIGITS IN THE NUMBER
    xor edx, edx        ;initiate edx register to 0
    div ecx             ;divide the number by 10 .Now the reminder ,i.e the right most element will be save in edx 
    push dx             ; push the reminder (right most digit of the number) from stack
    inc esi             ;increment esi
    cmp eax,0           ;check if the number became 0 after division
    jne get_digit       ;If number is not 0 , then run "get_digit" again


    xor edx,edx         ;Initiate edx register as 0
    xor eax,eax         ;initiate eac register as 0
    mov edi,esi         ; edi has the value of number of digits in the number
    clc                 ;Flag
    
jump:
   pop bx               
   mov eax,1            ;Initializing eax to 1
   mov ecx,esi          ;ecx had the number of digits in the number
   push edx             ;push the digit back
mult:                   ;TO MULTIPLY THE DIGIT WITH ITSELF FOR AS MANY TIMES AS THE NUMBER OF DIGITS
   mul bx               
   loop mult
   
   pop edx              ;Pop the final exponent of the digit 
   adc edx,eax          ; add that value to edx register

   dec edi
   cmp edi,0            ;check if all digits are multiplied to themselves
   jne jump             ;if not , jump 

check:                  ;TO CHECK IF THE NUMBER IS ARMSTRONG NUMBER OR NOT
   pop eax              ;pop the number
   cmp eax,edx          ;Compare the number with our calculation
   je yes               ; If both are equal => ARMSTRONG NUMBER
   jne no               ;If both are not equal => NOT ARMSTRONG NUMBER

yes:
   mov eax,4
   mov ebx,1
   mov ecx,msg1
   mov edx,len1
   int 0x80
   
   jmp exit
   
no:
   mov eax,4
   mov ebx,1
   mov ecx,msg2
   mov edx,len2
   int 0x80

exit:
   mov eax,1           ;exit
   int 0x80