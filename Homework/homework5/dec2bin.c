#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void printBinary(unsigned int num) {
    char binary[33];
    binary[32] = '\0';
    
    for (int i = 0; i < 32; i++) {
        binary[i] = '0';
    }

    for (int i = 31; i >= 0; i--) {
        binary[i] = (num & 1) + '0';
        num >>= 1;
    }
    
    printf("%s", binary);
}

int main(int argc, char *argv[]) {
    unsigned int number;
    
    if (argc > 0) {
        number = (unsigned int)strtoul(argv[1], NULL, 10);
        printBinary(number);
    } else if (argc == 1) {
        printf("Argument not given. ");
    }
    
    return 0;
}