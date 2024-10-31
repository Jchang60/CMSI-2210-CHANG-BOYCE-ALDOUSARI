#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main() {
    time_t startTime, endTime;
    int seconds;
    int minutes;
    
    printf("This program will time how long you can hold your breath.\nTake a deep breath, then press the 'Enter' key.\nWhen you absolutely have to exhale, press the enter key again.\nThe duration will be displayed in minutes and seconds.\n");

    
    // Waits for new line (enter)
    getchar();

    
    time(&startTime);

    getchar();
    
    time(&endTime);
    
    double totalSeconds = difftime(endTime, startTime);
    
    minutes = (int)totalSeconds / 60;
    seconds = (int)totalSeconds % 60;
    
    printf("\nYou held your breath for %d minutes and %d seconds.\n", 
           minutes, seconds);
    
    return 0;
}