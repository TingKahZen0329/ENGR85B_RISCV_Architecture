/*
  File: 03_unavoidable_prototypes.c
  Author: Ting Kah Zen
  Date: 2026-08-25
  Description: Demonstrate why function prototypes are unavoidable in mutually recursive functions (like state machines).
*/

#include <stdio.h>

// Task: Try commenting out the line below (the function prototype) and see how the compiler complains.
void state_B(int counter); 

// State A function: Calls State B after execution
void state_A(int counter) {
    if (counter <= 0) {
        printf("[System] State machine halted.\n");
        return;
    }
    printf("Currently in State A, switching... (Jumps remaining: %d)\n", counter);
    state_B(counter - 1); // Calling state_B here
}

// State B function: Calls State A after execution
void state_B(int counter) {
    if (counter <= 0) {
        printf("[System] State machine halted.\n");
        return;
    }
    printf("Currently in State B, switching... (Jumps remaining: %d)\n", counter);
    state_A(counter - 1); // Calling state_A here
}

int main(void) {
    printf("=== Hardware State Machine Ping-Pong Test ===\n");
    // Start the state machine with an initial energy of 4
    state_A(4); 
    
    return 0;
}