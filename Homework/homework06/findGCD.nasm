section .bss
    num1 resb 10            ; Reserve space for the first number (as string)
    num2 resb 10            ; Reserve space for the second number (as string)
    gcd_result resb 10      ; Reserve space for the GCD result

section .data
    prompt db "Enter two numbers (separated by space): ", 0
    output_msg db "GCD: ", 0

section .text
;global _start
global _main

;_start:
_main:
    ; Print prompt to stdout
    mov eax, 4              ; sys_write
    mov ebx, 1              ; file descriptor (stdout)
    mov ecx, prompt         ; pointer to the prompt string
    mov edx, 36             ; length of the prompt string
    int 0x80                ; make the system call

    ; Read input from stdin
    mov eax, 3              ; sys_read
    mov ebx, 0              ; file descriptor (stdin)
    mov ecx, num1           ; pointer to buffer to store input
    mov edx, 20             ; maximum bytes to read
    int 0x80                ; make the system call

    ; Parse input and convert to integers
    mov ecx, num1           ; pointer to buffer containing the input
    call string_to_int      ; convert first number to integer
    mov esi, eax            ; store first number in esi

    ; Find the next number in the buffer
    mov ecx, num1           ; pointer to buffer again
    call find_next_num      ; skip the space between numbers
    call string_to_int      ; convert second number to integer
    mov edi, eax            ; store second number in edi

    ; Calculate GCD using Euclidean algorithm
    mov eax, esi            ; move first number to eax
    mov ebx, edi            ; move second number to ebx
    call gcd                ; calculate GCD

    ; Convert result to string
    mov esi, eax            ; result in eax
    call int_to_string

    ; Print "GCD: " message
    mov eax, 4              ; sys_write
    mov ebx, 1              ; stdout
    mov ecx, output_msg     ; pointer to "GCD: " message
    mov edx, 5              ; length of "GCD: " message
    int 0x80

    ; Print the GCD result
    mov eax, 4              ; sys_write
    mov ebx, 1              ; stdout
    mov ecx, gcd_result     ; pointer to the result string
    mov edx, 10             ; maximum length of result
    int 0x80

    ; Exit the program
    mov eax, 1              ; sys_exit
    xor ebx, ebx            ; return code 0
    int 0x80

; Helper function to convert string to integer
string_to_int:
    xor eax, eax            ; clear eax (integer result)
    xor ebx, ebx            ; clear ebx (digit accumulator)
.loop:
    mov bl, byte [ecx]      ; load next byte from the string
    cmp bl, 0x20            ; check if space is encountered
    je .done                ; exit if space
    cmp bl, 0               ; check if null terminator
    je .done                ; exit if null terminator
    sub bl, '0'             ; convert ASCII to integer
    imul eax, eax, 10       ; multiply current result by 10
    add eax, ebx            ; add the current digit to eax
    inc ecx                 ; move to the next character
    jmp .loop
.done:
    ret                     ; return result in eax

; Helper function to find the next number in the input buffer
find_next_num:
    .skip_space:
        cmp byte [ecx], 0x20 ; check if current character is a space
        jne .found           ; if not space, we found the next number
        inc ecx              ; move to the next character
        jmp .skip_space
    .found:
        ret                  ; return with ecx pointing to the next number

; Helper function to calculate GCD using Euclidean algorithm
gcd:
    .start:
        cmp ebx, 0           ; if second number is 0
        je .done             ; GCD is the first number
        xor edx, edx         ; clear remainder (edx) before division
        div ebx              ; divide eax by ebx, quotient in eax, remainder in edx
        mov eax, ebx         ; move divisor to eax (new dividend)
        mov ebx, edx         ; move remainder to ebx (new divisor)
        jmp .start           ; repeat until remainder is 0
    .done:
        ret                  ; return the GCD in eax

; Helper function to convert integer to string
int_to_string:
    mov edi, gcd_result     ; point edi to result buffer
    xor ecx, ecx            ; clear ecx (digit count)
    xor edx, edx            ; clear remainder
    test esi, esi           ; check if the number is 0
    jnz .convert            ; if not zero, continue with conversion
    mov byte [edi], '0'     ; store '0' for 0
    inc edi                 ; move to next buffer position
    jmp .done               ; done for 0
.convert:
    .digit_loop:
        xor edx, edx        ; clear remainder
        div byte 10         ; divide esi by 10 (use byte for division)
        add dl, '0'         ; convert remainder to ASCII
        dec edi             ; move backward in buffer
        mov [edi], dl       ; store ASCII digit
        inc ecx             ; increment digit count
        test eax, eax       ; check if quotient is 0
        jnz .digit_loop     ; repeat if not
    add edi, ecx            ; move edi to end of string
.done:
    mov byte [edi], 0       ; null-terminate the string
    ret
