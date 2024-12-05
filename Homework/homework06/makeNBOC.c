#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <arpa/inet.h>

bool isLittleEndian() {
    uint16_t number = 0x0001;
    uint8_t *ptr = (uint8_t *)&number;
    return (ptr[0] == 0x01);
}

uint32_t makeNBO(uint32_t value) {
    if (isLittleEndian()) {
        return htonl(value);
    }
    return value;
}
