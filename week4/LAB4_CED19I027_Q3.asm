;LAB4 Q3: PALINDROME
section .data
    x db '3553'             
    length equ $-x
    size equ $ - x
    msg db  " is Palindrome"
    len equ $ - msg
    msg2 db " is not Palindrome",
    len2 db $ - msg2
section .text

global _start

_start:
   mov ecx,x                ;TO PRINT THE NUMBER
   mov edx,size                 
   mov ebx,1            
   mov eax,4
   int 0x80

   mov esi,length-1         ;index pointing to the rightmost end of the srting
   mov edi,0
   mov ecx,1 
palindrome:
   xor eax,eax              ;Initiate eax to 0
   xor ebx,ebx              ;Initiate ebx to 0
   mov al,[x+esi]           ;moves the right most digit in 'al' register
   mov bl,[x+edi]           ;moves the left most digit in 'bl' register
   dec esi                  ;al register index moves left
   inc edi                  ;bl register index moves right
   cmp al,bl                ;compare that digit in symmetrical position
   jne finish               ;if not equal , jump to finidh
loop palindrome

;TO PRINT IF IT IS A PALINDROME
   mov     ecx, msg  
   mov     edx, len
   mov     ebx, 1
   mov     eax, 4
   int     0x80
   jmp _exit
finish:                   ;PRINTS NOT A PALINDROME
    mov     ecx, msg2
    mov     edx, len2
    mov     ebx, 1
    mov     eax, 4
    int     0x80
_exit:
    mov     eax, 1
    int     0x80