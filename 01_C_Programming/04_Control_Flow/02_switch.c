/*
  File: 02_switch.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Practice control flow using the switch statement and demonstrate the fall-through trap.
*/

#include <stdio.h>

int main(void) {
    printf("=== Switch Statement (State Machine) ===\n");
    
    // Switch is ideal for checking a variable against specific integer/character values
    int system_state = 4;
    printf("Attempting to switch to state code: %d\n", system_state);

    switch (system_state) {
        case 1:
            printf("[Switch] Executing State 1: System Initialization (Init)\n");
            break; // 'break' is crucial to prevent falling through to the next case
        case 2:
            printf("[Switch] Executing State 2: Reading Sensor Data (Read Data)\n");
            break; // Task: Try commenting out this break statement and see what happens!
        case 3:
            printf("[Switch] Executing State 3: Entering Sleep Mode (Sleep)\n");
            break;
        default:
            // Executes if no cases match the variable
            printf("[Error] Unknown state code!\n");
            break; 
    }

    return 0;
}