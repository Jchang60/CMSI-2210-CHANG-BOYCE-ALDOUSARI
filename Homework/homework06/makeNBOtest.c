#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>

bool isLittleEndian();
uint32_t makeNBO(uint32_t val);

void printBytes(uint32_t val) {
    unsigned char *bytes = (unsigned char *)&val;
    printf("%02X %02X %02X %02X\n", 
           bytes[0], bytes[1], bytes[2], bytes[3]);
}

int main() {
    uint32_t testVals[] = {
        0x05192004,
        0xABCDEFED,
        0x12345678,
        0xFFFFFFFF,
        0x00000000
    };

    if(isLittleEndian()) {
        printf("System is little endian.\n");
    }
    else {
        printf("System is big endian.\n");
    }
    
    //TESTING
    printf("TESTS:\n");
    for (int i = 0; i < 5; i++) {
        uint32_t originalVal = testVals[i];
        uint32_t convertedVal = makeNBO(originalVal);
        
        printf("Test %d\n", i + 1);
        printf("Original value: 0x%08X\n", originalVal);
        printf("Original bytes: ");
        printBytes(originalVal);
        printf("Converted value: 0x%08X\n", convertedVal);
        printf("Converted bytes: ");
        printBytes(convertedVal);
        printf("\n");
    }
}