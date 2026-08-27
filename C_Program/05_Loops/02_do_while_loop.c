/*
  File: 02_do_while_loop.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Practice the 'do-while' loop structure, which guarantees at least one execution.
*/

#include <stdio.h>

int main(void) {
    printf("=== The 'do-while' Loop ===\n");
    // The block is executed at least ONCE before checking the condition.
    // This is very useful when waiting for hardware sensors to respond.
    int retries = 0;
    
    do {
        printf("[Hardware] Attempting to connect to sensor (Attempt %d)...\n", retries + 1);
        retries++;
    } while (retries < 2); 
    
    printf("Sensor connected successfully.\n");

    return 0;
}