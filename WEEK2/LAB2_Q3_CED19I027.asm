;Lab 2 Q3: multiply 2 positive 3-digit numbers in the range [100,999] 

section .data             ;assigning all constants
	msg db "product = "
	len equ $ - msg
	StrAns db '000000'
    len2 equ $ - StrAns

section .text
	global _start

_start: 
	mov eax, 999     ; number 1
	mov ebx, 999     ; number 2
	mul ebx          ; multiplies number 1 of eax register with number 2 of ebx register and stores in integer value
	
; Conversion of integer to string that is printable
    mov ecx, 10
    xor bx, bx      ; counts the digits in the answer

    jump:
    xor edx, edx
    div ecx         ; when we divide by 10 , we get the right most digit
    push dx         ; pushing each digit into the stack
    inc bx          ; digit counter is incremented
    test eax, eax   ; check if eax is 0
    jnz jump        ; if eax is not zero then jump

    ; length adjust
    xor eax, eax
    mov ax, len2
    sub ax, bx

    mov cx, bx      ; bx is number of digit digits , which is now moved to count register
    mov esi, eax    ; we shift accumulator register to source index register for string operations

    loop1:
    pop ax               ;popping a stack into eax
    add al, '0'          ; converting the integer to ascii
    mov [StrAns+esi], al ; move the ascii to answer
    inc esi              ; index to the next digit
    loop loop1


print:
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

	mov eax, 1   ;exit the program
	int 0x80