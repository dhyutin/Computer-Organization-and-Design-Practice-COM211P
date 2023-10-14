;Register Adressing,Immediate Addressing , Indexed Addressing ,Auto Decrement,Auto Increment
section .data
   msg3 db "Sum is : "      
   len3 equ $-msg3         

   msg db 0xA
   n1 db '999'     
   n2 db '111'      
   sum db ''    

section .text      
   global _start

_start:

   mov eax,ebx            ;Register Addressing Mode

   mov eax,4              ;Immediate Addressing Mode    
   mov ebx,1              ;Immediate Addressing Mode    
   mov ecx,msg3     
   mov edx,len3
   int 0x80     


   mov esi,2              ;Immediate Addressing Mode    
   mov ecx,3              ;Immediate Addressing Mode  
   clc                  

add_sum:
   mov al,[n1+esi]        ;Indexed Addressing Mode
   adc al,[n2+esi]        ;Indexed Addressing Mode
   aaa                  
   pushf                 ;Auto-Increment Addressing Mode
   or al, 0x30      
   popf                   ;Auto-Decrement Addressing Moce

   mov [sum+esi+1],al     
   dec esi               

   loop add_sum


   jnc print
 
   mov al,'0'             ;Immediate Addressing Mode    
   adc al,'0'              ;Immediate Addressing Mode    
   aaa                   
   or al, 0x30           
   mov [sum+0],al        

print:   
   mov eax,4                ;Immediate Addressing Mode    
   mov ebx,1                ;Immediate Addressing Mode    
   mov ecx,sum
   mov edx,4                ;Immediate Addressing Mode    
   int 0x80

   mov eax,1                 ;Immediate Addressing Mode    
   int 0x80
