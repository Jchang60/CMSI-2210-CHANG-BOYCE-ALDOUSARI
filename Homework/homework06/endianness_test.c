#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

void check_endian(uint16_t nu) {
    uint8_t *ptr = (uint8_t *)&nu;

    if (ptr[0] == 0x01) {
        printf("Little-endian\n");
    } else {
        printf("Big-endian\n");
    }
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        printf("Please provide at least one value.\n");
        return 1;
    }

    for (int i = 1; i < argc; i++) {
        uint16_t nu = (uint16_t)strtol(argv[i], NULL, 16);  // Convert hex string to uint16_t
        printf("Testing value 0x%04x: ", nu);
        check_endian(nu);
    }

    return 0;
}
