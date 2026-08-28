/*
  File: 01_if_else.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Practice control flow using single if and if-else if-else statements.
*/

#include <stdio.h>

int main(void) {
    printf("=== 1. Single 'if' Statement ===\n");
    int temperature = 30;
    printf("Current chip temperature: %d C\n", temperature);
    
    // The code block executes only if the condition is true
    if (temperature > 40) {
        printf("[WARNING] Temperature too high! Activating cooling fan...\n");
    }

    printf("\n=== 2. 'if / else if / else' Statements ===\n");
    int battery_level = 20;
    printf("Current battery level: %d%%\n", battery_level);

    if (battery_level >= 80) {
        printf("[Status] Battery sufficient. High Performance Mode activated.\n");
    } else if (battery_level >= 20) {
        printf("[Status] Battery normal. Normal Mode activated.\n");
    } else {
        // Fallback condition if none of the above are met
        printf("[Status] Battery critically low! Entering Power Saving Mode.\n");
    }

    return 0;
}