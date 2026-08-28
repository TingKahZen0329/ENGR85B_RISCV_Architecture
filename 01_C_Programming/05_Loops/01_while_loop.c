/*
  File: 01_while_loop.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Practice the 'while' loop structure, where the condition is checked before execution.
*/

#include <stdio.h>

int main(void) {
    printf("=== The 'while' Loop ===\n");
    // The condition is checked BEFORE executing the block.
    int countdown = 3;
    printf("System shutdown sequence initiated...\n");
    
    while (countdown > 0) {
        printf("Shutting down in %d...\n", countdown);
        countdown--; // Critical: Update the variable to prevent an infinite loop!
        // Task: Comment out the line above (countdown--) to trigger an infinite loop! 
        // Use Ctrl+C in the terminal to escape.
    }
    printf("System offline.\n");

    return 0;
}