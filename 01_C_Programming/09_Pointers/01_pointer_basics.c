/*
  File: 01_pointer_basics.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Introduction to pointers, storing addresses, and dereferencing (*).
*/

#include <stdio.h>

int main(void) {
    printf("=== Pointer Basics ===\n\n");

    // 1. A normal variable
    int target_value = 42;
    
    // 2. A pointer variable
    // The '*' here tells the compiler: "ptr is NOT a normal int. It's a POINTER to an int."
    int *ptr = &target_value; 
    //int* ptr = &target_value ,ptr store the address ,and *ptr can use the address's content

    // Let's verify what's inside them
    printf("1. target_value is: %d\n", target_value);
    printf("2. Address of target_value (&target_value): %p\n", (void*)&target_value);
    
    // 'ptr' simply stores the address of 'target_value'
    printf("3. The value stored inside ptr: %p\n", (void*)ptr);

    printf("\n=== The Magic of Dereferencing (*) ===\n");
    // When we put '*' in front of a pointer, it means "go to that address and open the box".
    printf("Reading data via pointer (*ptr): %d\n", *ptr);

    printf("\n=== Modifying Memory Remotely ===\n");
    // This is why pointers are powerful! We can change 'target_value' WITHOUT touching it directly.
    *ptr = 99; // "Go to the address stored in ptr, and overwrite the data with 99"
    
    printf("New value of target_value: %d\n", target_value);
    //  target_value is  99

    return 0;
}