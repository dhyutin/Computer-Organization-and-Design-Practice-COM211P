;LAB 3 Q4 : sum of array elements
section	.data
sum db '0000'

array dd 999,999,999,999,999


section	.text
	global _start       ;must be declared for using gcc
_start:      ;tell linker entry point

    mov  ecx,array   ;ECX will point to the current element to be summed
	mov ebx,4
	mov eax,[array]
	clc
	jump:
	add ecx,4
	adc eax,[ecx]
    dec ebx
	jnz jump
	
	;converting integer into character
	mov ecx,10
	mov esi,3
	
	convert_string:
	xor edx,edx
	div ecx
    add dx,'0'
	mov [sum+esi],dl
	dec esi
	test eax,eax
	jne convert_string
	
	mov	edx, 4      ;message length
	mov	ecx,sum    ;message to write
	mov	ebx, 1	    ;file descriptor (stdout)
	mov	eax, 4	    ;system call number (sys_write)
	int	0x80        ;call kernel
	
	mov	eax, 1	    ;system call number (sys_exit)
	int	0x80        ;call kernel