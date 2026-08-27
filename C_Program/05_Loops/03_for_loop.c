/*
  File: 03_for_loop.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Practice the 'for' loop structure, ideal for executing a block a specific number of times.
*/

#include <stdio.h>

int main(void) {
    printf("=== The 'for' Loop ===\n");
    // Best for executing a block a specific number of times.
    // Syntax: for (initialization; condition; update)
    printf("Blinking LED 4 times:\n");
    
    for (int i = 1; i <= 4; i++) {
        printf("LED blink %d: ON -> OFF\n", i);
    }
    
    // Note: The variable 'i' is only alive inside the for loop block (Block Scope).

    return 0;
}