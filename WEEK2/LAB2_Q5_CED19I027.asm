; Lab2 Q5 :Increment of a number from the range [100,999]
section	.data
msg	db	'After increment , value ='	
len	equ	$ - msg 	

n db '0909'      ; assigning number to the variable n

msg1 db 0xA


section	.text
	global _start       
_start: 
                      ;Prints msg
    mov	eax, 4	    
    mov	ebx, 1	    
    mov	ecx, msg   
	mov	edx, len    
	int	0x80       
	
    mov esi,3          ;index
    mov ecx,3
    
    increment:
    mov al,[n+esi]      ; select the number n
    cmp al,'9'          ; compares the digit with 9
    jl jump             ; if digit < 9 , then jump
  
    mov al,'0'          ; if digit = 9  then make it equal to 0
    mov [n+esi],al      ; store this value in n
    dec esi             ; go to next digit to check for the same
    loop increment
    
    jump:
    inc al              ; increment the next digit
    mov [n+esi],al      ; index to next number
    
	;printing the incremented value
	mov	eax, 4	    
	mov	ebx, 1	   
	mov	ecx, n      
	mov	edx, 4      
	int	0x80        
	
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,4
	int 0x80
	
	mov	eax, 1	    ; Exit the program
	int	0x80       