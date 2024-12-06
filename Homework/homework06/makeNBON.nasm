section .data
    msg db 'Running the endianness test on various values:', 0x0A, 0x00  ; Print message, newline and null terminator.

section .text
    global _start

_start:
    ; Print the message
    mov rax, 0x1        ; syscall number for write (stdout)
    mov rdi, 0x1        ; file descriptor (stdout)
    mov rsi, msg        ; address of the message
    mov rdx, 40         ; message length
    syscall

    ; Call the C program with values (example: 0x0001, 0x1234, etc.)
    ; Prepare arguments for the execv system call
    ; Using execvp to call the compiled C program

    ; execvp arguments
    mov rdi, r8         ; Path to the program (executable)
    mov rsi, r9         ; Arguments array

    ; execvp system call
    mov rax, 59         ; execvp syscall number
    syscall

    ; Exit
    mov rax, 60         ; Exit syscall
    xor rdi, rdi        ; Exit code 0
    syscall
