;Direct ,Indirect, Relative ,Register Indirect ,Direct Offset
section	.data

msg db "MAXIMUM OF THE 5 ELEMENTS: " 
len equ $-msg

array:                                
   dd 101,102,103,104,105


max db '000'

section	.text
	global _start                    
_start:                               

    mov ecx,array                  ;Direct Memory Addressing   
	mov ebx,4                         
	mov eax,[array]                ;Indirect Memory Addressing  
	mov eax,[array+0]              ;Direct Offset Addressing
	
find_max:
	add ecx,4       
	cmp eax,[ecx]              ;Register Indirect Memory Addressing
	jg continue                ;Relative Addressing Mode     
	mov eax,[ecx]              ;Register Indirect Memory Addressing
continue:
        dec ebx         
	jnz find_max               ;Relative Addressing Mode
	
	mov ecx,10                        
	mov esi,2
	
store_value:
	xor edx,edx                       
	div ecx
    add dx,'0'
	mov [max+esi],dl
	dec esi
	test eax,eax
	jne store_value              ;Relative Addressing Mode

print:	
    mov eax,4                         
    mov ebx,1 
    mov ecx,msg     
    mov edx,len
    int 0x80 

	mov	edx, 3                     
	mov	ecx, max    
	mov	ebx, 1	    
	mov	eax, 4	    
	int	0x80        
	
	mov	eax, 1	    
	int	0x80        