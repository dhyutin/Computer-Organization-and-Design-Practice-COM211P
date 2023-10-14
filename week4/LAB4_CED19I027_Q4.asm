;LAB4 Q4
section .data
    msg db  "Hello IIITDM Kancheepuram"      ;message to be evaluated
    len equ $ - msg
    w_count db '001'                         ;To store number of words in msg
    lenw equ $- w_count
    v_count db '000'                         ;To store number of vowels in msg
    lenv equ $- v_count
    c_count db '000'                         ;To store number of consonants in msg
    lenc equ $- c_count
    s_count db '000'                         ;To store number of characters in msg
    lens equ $- s_count
    spc db 0xA                               ;To go to the next line
    msg1 db "Number of Words ="
    len1 equ $- msg1
    msg2 db "Number of Characters="
    len2 equ $- msg2
    msg3 db "Number of Vowels ="
    len3 equ $- msg3
    msg4 db "Number of Consonants ="
    len4 equ $- msg4

section .text

global _start

_start:
   xor ebx,ebx                 ;Initiates ebc to 0
   mov esi,0                   ;Index to point the position 
   mov ecx,len                 ;Counter equated to the length of string
   
counting:
   mov al,[msg+esi]            ;moves the character at index to al
   mov edi,2                   
   inc esi                     ;Index pointer moves to next character of msg
   cmp al," "                  ;Compare character with " " space
   je words                    ;If it is space,go to words
   cmp al,'a'                  ;Compare character with "a"
   je vowel                    ;If equal , count it as vowel
   cmp al,"A"
   je vowel
   cmp al,'e'
   je vowel
   cmp al,"E"
   je vowel
   cmp al,'i'
   je vowel
   cmp al,'I'
   je vowel
   cmp al,'o'
   je vowel
   cmp al,"O"
   je vowel
   cmp al,'u'
   je vowel
   cmp al,"U"
   je vowel
   cmp byte[s_count+edi],'9'   ;TO COUNT THE NUMBER OF CHARACTERS IN msg (bitwise addition)
   je next_s
   string:
   inc byte [s_count+edi]
   jmp last
 next_s:
   mov byte[s_count+edi],'0'
   dec edi
   jmp string
   last:
   dec ecx
   cmp ecx,0
   jnz counting
jmp consonants

words:                      ;bitwise incrementing w_count by 1
   cmp byte[w_count+edi],'9'
   je next_w
   cw:
   inc byte [w_count+edi]
   jmp counting
next_w: 
   mov byte[w_count+edi],'0'
   dec edi
   jmp cw

vowel:                      ;bitwise incrementing v_count by 1
   cmp byte[v_count+edi],'9'
   je next_v
   cv:
   inc byte [v_count+edi]
   jmp counting
next_v:
   mov byte[v_count+edi],'0'
   dec edi
   jmp cv

;CONSONANTS = CHARACTERS - VOWELS - WORDS + 1 
consonants:
   mov esi,2                ;index pointer(rightmost digit)
   mov ecx,3                ;loop counter(no. of digits)
   clc                      ;clear carry flag

subtract_vowel_num:         ;CHARACTERS - VOWELS
   mov al,[s_count+esi]     ;select digit
   sbb al,[v_count+esi]     ;subtract corresponding digits
   aas                      ;adjust after subtraction 
   pushf                    ;push carry flag into stack
   or al, 0x30              ;converts the ascii character to int
   popf                     ;pops carry value from stack to carry flag to subtract in next iteration

   mov [c_count+esi],al     ;store digit in result
   dec esi                  ;next digit index
   
   loop subtract_vowel_num
 
   mov esi,2                ;index pointer(rightmost digit)
   mov ecx,3                ;loop counter(no. of digits)
   clc 
subtract_word_num:          ;(CHARACTERS-VOWELS) -WORDS
   mov al,[c_count+esi]     ;select digit
   sbb al,[w_count+esi]     ;subtract corresponding digits
   aas                      ;adjust after subtraction 
   pushf                    ;push carry flag into stack
   or al, 0x30              ;converts the ascii character to int
   popf                     ;pops carry value from stack to carry flag to subtract in next iteration

   mov [c_count+esi],al     ;store digit in result
   dec esi                  ;next digit index
   loop subtract_word_num

add_one:                   ;CHARACTERS-VOWELS-WORDS+1
   mov esi,2
   cmp byte[c_count+esi],'9'
   je next_c
   cc:
   inc byte [c_count+esi]
   jmp print                ;PRINT ALL VALUES
next_c:
   mov byte[c_count+esi],'0'
   dec esi
   jmp cc
   
print:
  	mov ecx, msg1
	mov edx, len1
	mov ebx, 1
	mov eax, 4
	int 0x80
	
   mov     bl,[w_count]
   add     bl,'0'
   mov     ecx, w_count
   mov     edx, lenw
   mov     ebx, 1
   mov     eax, 4
   int     0x80
   
   mov     ecx, spc
   mov     edx, 1
   mov     ebx, 1
   mov     eax, 4
   int     0x80
   
    mov ecx, msg2
	mov edx, len2
	mov ebx, 1
	mov eax, 4
	int 0x80
	
  mov     bl,[s_count]
   mov     ecx, s_count
   mov     edx, lens
   mov     ebx, 1
   mov     eax, 4
   int     0x80
   
   mov     ecx, spc
   mov     edx, 1
   mov     ebx, 1
   mov     eax, 4
   int     0x80
   
    mov ecx, msg3
	mov edx, len3
	mov ebx, 1
	mov eax, 4
	int 0x80
   
   mov     bl,[v_count]
   add     bl,'0'
   mov     ecx, v_count
   mov     edx, lenv
   mov     ebx, 1
   mov     eax, 4
   int     0x80
   
   mov     ecx, spc
   mov     edx, 1
   mov     ebx, 1
   mov     eax, 4
   int     0x80
   
    mov ecx, msg4
	mov edx, len4
	mov ebx, 1
	mov eax, 4
	int 0x80

   mov     bl,[c_count]
   add     bl,'0'
   mov     ecx, c_count
   mov     edx, lenc
   mov     ebx, 1
   mov     eax, 4
   int     0x80
exit:
    mov     eax, 1
    int     0x80