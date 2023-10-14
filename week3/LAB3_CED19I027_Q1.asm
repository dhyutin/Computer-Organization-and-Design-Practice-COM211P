;LAB 3 Q1 : Choose five numbers between 100 and 999. Write ALP by using conditional instructions for finding the largest of these five numbers and display the result as the output.

section	.data

msg db "MAXIMUM OF THE 5 ELEMENTS: "  ;assigning constant values
len equ $-msg

array:                                ;assigning values of array elements
   dd 101,102,103,104,105


max db '000'

section	.text
	global _start                     ;must be declared for using gcc
_start:                               ;tell linker entry point

    mov ecx,array                     ;ecx will point to the current element to be compared
	mov ebx,4                         ;ebx counts the position of array element
	mov eax,[array]                   ;eax stores the current array element value
	
find_max:
	add ecx,4       
	cmp eax,[ecx]                     ;compare the element with next element
	jg continue                       ;if value stored in eax is greater than value stored in currently pointed array element, go to "continue"
	mov eax,[ecx]
continue:
        dec ebx         
	jnz find_max
	
	mov ecx,10                        ;to convert the integer to character
	mov esi,2
	
store_value:
	xor edx,edx                       ;to store tha value in max
	div ecx
    add dx,'0'
	mov [max+esi],dl
	dec esi
	test eax,eax
	jne store_value

print:	
    mov eax,4                        ;prints "Max of 5 elements: "    
    mov ebx,1 
    mov ecx,msg     
    mov edx,len
    int 0x80 

	mov	edx, 3                       ;prints max value
	mov	ecx, max    
	mov	ebx, 1	    
	mov	eax, 4	    
	int	0x80        
	
	mov	eax, 1	    
	int	0x80        