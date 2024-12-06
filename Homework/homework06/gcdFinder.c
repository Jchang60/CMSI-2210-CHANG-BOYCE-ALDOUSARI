#include <stdio.h>
#include <stdlib.h>

extern int findGCD(int a, int b); NASM function

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Usage: %s <num1> <num2>\n", argv[0]);
        return 1;
    }

    int num1 = atoi(argv[1]);  
    int num2 = atoi(argv[2]);  

    // Calculate GCD
    int gcd = findGCD(num1, num2);  // Pass the integers to the NASM function

    // Print the GCD
    printf("GCD of %d and %d is: %d\n", num1, num2, gcd);

    return 0;
}