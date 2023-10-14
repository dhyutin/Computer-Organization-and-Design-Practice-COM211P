;Lab 2 Q1: Add 2 positive 3-digit numbers in the range [100,999] 

section .data
   msg3 db "Sum is : "      ; assigning all constant values
   len3 equ $-msg3         ; assigning size of msg3 to len3

   msg db 0xA
   n1 db '999'     ;assigning number 1
   n2 db '111'      ;assigning number 2
   sum db ''    ; creating a variable 'sum' whose value will be determined by the end of the ALP

section .text      
   global _start

_start:

   mov eax,4            ;prints "Sum is: "    
   mov ebx,1 
   mov ecx,msg3     
   mov edx,len3
   int 0x80     ;call kernel - prints it on the screen


   mov esi,2             ;index pointer(rightmost digit)
   mov ecx,3             ;loop counter(no. of digits)
   clc                    ;clear carry flag

;adding of the 2 numbers 
add_sum:
   mov al,[n1+esi]        ;select char add digit
   adc al,[n2+esi]       ;add corresponding char
   aaa                    ;adjust after adding 
   pushf                  ;push carry flag into stack
   or al, 0x30            ;ascii to char
   popf                   ;pops the carry from stack to carry flag to add in next iteration

   mov [sum+esi+1],al     ;store digit in sum
   dec esi                ;next digit index
   
   loop add_sum


   jnc print

   mov al,'0'             ;select digit
   adc al,'0'             ;add corresponding digits
   aaa                    ;adjust string to ascii
   or al, 0x30            ;ascii to int
   mov [sum+0],al          ;store digit in result

print:    ;print final sum
   mov eax,4
   mov ebx,1
   mov ecx,sum
   mov edx,4
   int 0x80

   mov eax,1       ;Exiting the program
   int 0x80
