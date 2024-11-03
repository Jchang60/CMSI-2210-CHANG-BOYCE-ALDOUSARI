#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    int N = atoi(argv[1]);;
    
    printf("%5c", 0);
    for (int i = 2; i <= N; i++) {
        printf("%4d", i);
    }
    printf("\n");
    
    printf("%5c", 0);
    for (int i = 0; i < N-1; i++) {
        printf("====");
    }
    printf("\n");
    
    for (int i = 2; i <= N; i++) {
        printf("%2d |", i);
        for (int j = 2; j <= N; j++) {
            printf("%4d", i * j);
        }
        printf("\n");
    }
    
    return 0;
}