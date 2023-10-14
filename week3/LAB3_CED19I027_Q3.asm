;Lab 3 Q3 : FACTORIAL
section	.data
msg db 'Factorial  is:',0xa	
len equ $ - msg
fact db '000000000'
len2 equ $ - fact

section	.text
   global _start         ;must be declared for using gcc
	
_start:                  ;tell linker entry point

   mov ebx, 12       ;for calculating factorial of 12
   mov ax, 1
   call  rec
    mov ecx, 10
    xor bx, bx      ; digit counter

    jump:
    xor edx, edx
    div ecx         ; on div with 10, we get the rightmost digit(modulus function)
    push dx         ; pushing each digit into the stack
    inc bx          ; digit counter
    test eax, eax   ; is eax 0?
    jnz jump      ; if not zero jump

    ; length adjust
    xor eax, eax
    mov ax, len2
    sub ax, bx

   mov cx, bx     
   mov esi, eax 
   loop1:
    pop ax ;popping a stack into eax
    add al, '0' 
    mov [fact+esi], al
    inc esi
    loop loop1

    
   mov	  edx,len        ;message length
   mov	  ecx,msg        ;message to write
   mov	  ebx,1          ;file descriptor (stdout)
   mov	  eax,4          ;system call number (sys_write)
   int	  0x80           ;call kernel

   mov    edx,len2       ;message length
   mov	  ecx,fact       ;message to write
   mov	  ebx,1          ;file descriptor (stdout)
   mov	  eax,4          ;system call number (sys_write)
   int	  0x80           ;call kernel
    
   mov	  eax,1          ;system call number (sys_exit)
   int	  0x80           ;call kernel
	
rec:
   cmp   bx, 1
   jg    calc
   ret
	                          
calc:
   dec   bx
   call  rec
   inc   bx
   mul   ebx        ;ax = al * bl
   ret