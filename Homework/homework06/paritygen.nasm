section .data
    msg db "Parity bit: ", 0  ; Message to print before the parity bit value
    msg_len equ $ - msg         ; Length of the message

section .bss
    byte_value resb 1          ; Reserve a byte for input byte (0-255)

section .text
;    global _start
    global _main

;_start:
_main:
    ; Let's assume the byte to check is loaded into AL
    mov al, 0b11010101         ;

    ; Initialize the counter for ones
    xor ecx, ecx               ; Clear ECX, we will use it to count ones

    ; Count the number of 1 bits in AL
count_ones:
    test al, 1                  ; Test if the lowest bit of AL is 1
    jz skip_increment           ; If not, skip the increment
    inc ecx                     ; Increment counter if bit is 1
skip_increment:
    shr al, 1                   ; Shift AL right by 1 to check the next bit
    test al, al                 ; Test if AL is zero (all bits checked)
    jnz count_ones              ; If AL is not zero, continue the loop

    ; Now ECX contains the count of 1s in the byte

    ; Check if the count of ones is even or odd
    test ecx, 1                 ; Test if ECX is odd or even
    jz even_parity              ; Jump to even_parity if even
;    mov byte_value, 0           ; If odd, set parity bit to 0 (we need even parity)
    mov byte [byte_value], 0
    jmp print_parity

even_parity:
;    mov byte_value, 1           ; If even, set parity bit to 1 (odd parity)
    mov byte [byte_value], 1

print_parity:
    ; Print the message "Parity bit: "
    mov eax, 4                  ; syscall number for sys_write
    mov ebx, 1                  ; file descriptor 1 (stdout)
    mov edx, msg_len            ; message length
    lea ecx, [msg]              ; load address of msg
    int 0x80                    ; make syscall

    ; Print the parity bit
    mov eax, 4                  ; syscall number for sys_write
    mov ebx, 1                  ; file descriptor 1 (stdout)
    lea ecx, [byte_value]       ; load address of byte_value
    mov edx, 1                  ; we want to print 1 byte
    int 0x80                    ; make syscall

    ; Exit the program
    mov eax, 1                  ; syscall number for sys_exit
    xor ebx, ebx                ; return code 0
    int 0x80                    ; make syscall
