#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void printHex(unsigned long num, int digits) {
    printf("0x");
    
    if (digits == 8) {
        printf("%08X", (unsigned int)num);
    } else {
        printf("%016lX", num);
    }
}

int main(int argc, char *argv[]) {

    if (argc == 1) {
        printf("Argument not given. ");
    } else {

        unsigned long number;
        int digits = 8;
        
        number = strtoul(argv[1], NULL, 10);
            
        if (argc > 2) {
            digits = atoi(argv[2]);
        }
            
        printHex(number, digits);
        
    }
    
    return 0;
}