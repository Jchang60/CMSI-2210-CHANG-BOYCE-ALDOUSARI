#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

int main(int argc, char *argv[]) {
    int wordCount = 0;
    int isReadingWord = 0;
    int currChar;

    if( argc != 2 ) {
         puts( "Exactly two command line arguments needed" );
         return 1;
      } else {
         FILE* in = fopen( argv[1], "r" );
         if( !in ) {
            printf( "File %s does not exist\n", argv[1] );
            return 2;
         }
        while ((currChar = fgetc(in)) != EOF) {
            if (isspace(currChar)) {
                if (isReadingWord) {
                    isReadingWord = 0;
                }
            } else {
                // New word
                if (!isReadingWord) {
                    wordCount++;
                    isReadingWord = 1;
                }
            }
        }
        fclose(in);
    }
    printf("%d", wordCount);
    return 0;
}