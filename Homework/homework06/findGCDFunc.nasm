; findGCDFunc.nasm
global findGCD

section .text
findGCD:
    ; Function parameters are passed in eax (first number) and ebx (second number)

    .start:
        cmp ebx, 0           ; if second number (ebx) is 0
        je .done             ; if true, GCD is the first number (eax)
        xor edx, edx         ; clear the remainder (edx)
        div ebx              ; divide eax by ebx, quotient in eax, remainder in edx
        mov eax, ebx         ; move divisor to eax (new dividend)
        mov ebx, edx         ; move remainder to ebx (new divisor)
        jmp .start           ; repeat until remainder is 0

    .done:
        ret                  ; return the GCD in eax
