;Lab 2 Q2: subtract 2 positive 3-digit numbers in the range [100,999] 

section .data                           ;assigning all constant values
   msg3 db "Difference ="
   len3 equ $-msg3                    ;assigns size of msg3 to len3

   cmsg db " (10's complement) "     
   clen equ $-cmsg

   msg db 0xA       
   n1 db '999'                   ;assigns values of number 1
   n2 db '111'                   ;assigns value of number 2
   diff db ''                    ;creates a variable 'diff' whose value will be determined in the end

section .text
   global _start

_start:
   
   mov eax,4               ;prints "difference = "
   mov ebx,1
   mov ecx,msg3
   mov edx,len3
   int 0x80               ;calls kernel -prints on screen

  

   mov esi,2                ;index pointer(rightmost digit)
   mov ecx,3                ;loop counter(no. of digits)
   clc                      ;clear carry flag

subtract_diff:
   mov al,[n1+esi]          ;select digit
   sbb al,[n2+esi]          ;subtract corresponding digits
   aas                      ;adjust after subtraction 
   pushf                    ;push carry flag into stack
   or al, 0x30              ;converts the ascii character to int
   popf                     ;pops carry value from stack to carry flag to subtract in next iteration

   mov [diff+esi],al         ;store digit in result
   dec esi                  ;next digit index
   
   loop subtract_diff
   
                        ;Print difference
   mov eax,4
   mov ebx,1
   mov ecx,diff
   mov edx,3
   int 0x80

   jnc print
   
                  ;Print "10's complement"
   mov eax,4
   mov ebx,1
   mov ecx,cmsg
   mov edx,clen
   int 0x80

print:
                  
   mov eax,4
   mov ebx,1
   mov ecx,msg
   mov edx,1
   int 0x80

   mov eax,1    ;exits from the program
   int 0x80