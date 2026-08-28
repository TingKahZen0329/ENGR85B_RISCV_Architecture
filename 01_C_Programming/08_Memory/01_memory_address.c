/*
  File: 01_memory_address.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Explore how variables are stored in memory and how to print their addresses.
*/

#include <stdio.h>

int main(void) {
    printf("=== Memory Addresses (The '&' Operator) ===\n\n");

    int a = 10;
    char c = 'Z';
    float f = 3.14;

    // To print a memory address, we use the '%p' format specifier.
    // The '&' symbol means "get the address of".
    // Note: We cast to (void*) to satisfy strict compiler warnings for %p.
    printf("Value of a: %10d | Address of a: %p\n", a, (void*)&a);
    printf("Value of c: %10c | Address of c: %p\n", c, (void*)&c);
    printf("Value of f: %10.2f | Address of f: %p\n", f, (void*)&f);

    printf("\n=== Array Memory (Contiguous Blocks) ===\n");
    // Let's look at how an array is placed on the memory street!
    int arr[3] = {100, 200, 300};
    
    printf("Address of arr[0]: %p\n", (void*)&arr[0]);
    printf("Address of arr[1]: %p\n", (void*)&arr[1]);
    printf("Address of arr[2]: %p\n", (void*)&arr[2]);
    
    // Hint: Look closely at the last digit/letter of the array addresses.
    // They should increase by exactly 4 bytes (the size of an 'int').

    return 0;
}