;LAB 3 Q2 :Choose a random number 20 ≤ R ≤ 100, write ALP by using loops for printing the numbers (i.e. from 1 toR) and display the result as the output.
section	.data
n db '000'      ; assigning number to the variable n
new_line db 0xA
section	.text
	global _start       
_start: 
       
    mov esi,2        ;index
    mov edi,15       ;number till where we should print
    mov ecx,2
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
    dec edi
    print_loop:
	mov	eax, 4	    
	mov	ebx, 1	   
	mov	ecx, n      
	mov	edx, 3     
	int	0x80 
	
	mov	eax, 4	    
	mov	ebx, 1	   
	mov	ecx,new_line  
	mov	edx, 1    
	int	0x80 

    cmp edi,0
    je finish
    mov esi,2        ;index
    mov ecx,2
    
    jmp increment
finish:
mov	eax, 1	    ; Exit the program
int	0x80