#include <stdio.h>
#include <stdint.h>

int main() {
    uint16_t number = 0x0001;
    
    uint8_t *ptr = (uint8_t *)&number;
    
    if (ptr[0] == 0x01) {
        printf("This system is LITTLE-ENDIAN\n");
    } else {
        printf("This system is BIG-ENDIAN\n");
    }
}