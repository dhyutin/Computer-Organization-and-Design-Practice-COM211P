; Lab2 Q10 : Left shift by 3 bits
section .data
	msg db "After Left shift , value = "
	len equ $ - msg
	nl db 10             ;assigning value to variable n1
	StrAns db '0000'     ;answer string
    len2 equ $ - StrAns

section .text
	global _start

_start: 
	mov eax, 999       ; Number to be left shifted is selected
	mov ebx, 8         
	mul ebx            ; Selected number is multiplied by 8
	
    mov ecx, 10     ;conversion of the integer to ASCII to print it out
    xor bx, bx      ; to count the number of digits in answer

    jump:
    xor edx, edx
    div ecx         ; we divide with 10 to get the right most digit
    push dx         ; push that digit into stack
    inc bx          ; count that digit as a part of solution by increasing count by 1
    test eax, eax   ; check if any other digits are left by checking if eax is 0
    jnz jump        ; if eax is not 0 , then jum

    xor eax, eax
    mov ax, len2
    sub ax, bx

    mov cx, bx      ; bx is the number of digits
    mov esi, eax    

    loop1:
    pop ax               ; popping that stack into eax
    add al, '0'          ; converting the digit into ascii
    mov [StrAns+esi], al ; store the digit in StrAns
    inc esi              ;move to next index
    loop loop1

  
print:           ;Print the ansewer
	mov ecx, msg
	mov edx, len
	mov ebx, 1
	mov eax, 4
	int 0x80

	mov eax, 4
	mov ebx, 1
	mov ecx, StrAns
	mov edx, len2
	int 0x80

	mov ecx, nl
	mov edx, 1
	mov ebx,1
	mov eax,4
	int 0x80

	mov eax, 1   ;Exit the program
	int 0x80