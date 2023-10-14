;LAB 2 :Q6 - AND operation

section .data              ;assigns all constant values
   msg3 db "AND operation result : "
   len3 equ $-msg3         ;allocates length of msg3 to len3

   msg db 0xA
   n1 db '303'            ;assigning n1 as number 1
   n2 db '111'            ;assigning value of number 2
   and_ db ' '            ;creating a variable and_ whose value will be determined by the end 

section .text
   global _start

_start:
   
   mov eax,4        ;to print msg3
   mov ebx,1
   mov ecx,msg3
   mov edx,len3
   int 0x80            ;call kernel

   mov esi,2                ;index pointer(rightmost digit)
   mov ecx,3                ;loop counter to count the number of digits

and_function:
   mov al,[n1+esi]         ;select char add digit
   sub al,'0'
   mov bl,[n2+esi] 
   sub bl,'0'
   and al,bl               ;and operation on the digits in same position of n1 and n2
   add al,'0'

   mov [and_+esi],al       ;store digit in and_
   dec esi                 ;next digit index
   
   loop and_function


print:
   mov eax,4
   mov ebx,1
   mov ecx,and_
   mov edx,3
   int 0x80

   mov eax,4
   mov ebx,1
   mov ecx,msg
   mov edx,1
   int 0x80

   mov eax,1             ;exit the program
   int 0x80