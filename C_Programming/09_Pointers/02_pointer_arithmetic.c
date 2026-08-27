/*
  File: 02_pointer_arithmetic.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Unveiling the truth about arrays and exploring pointer arithmetic.
*/

#include <stdio.h>

int main(void) {
    printf("=== The Truth About Arrays ===\n\n");

    int sensor_data[4] = {10, 20, 30, 40};

    // 1. The Array Name IS a Pointer
    printf("Address of sensor_data[0] (&sensor_data[0]): %p\n", (void*)&sensor_data[0]);
    printf("Value of the array name (sensor_data)      : %p\n", (void*)sensor_data);
    

    printf("\n=== Pointer Arithmetic (Pointer Math) ===\n");
    int *ptr = sensor_data; // ptr now points to the first element (10)

    // 2. Moving the pointer
    // Magic: When we add 1 to an 'int' pointer, it moves exactly 4 bytes (the size of an int)!
    printf("Pointer ptr      : %p (Dereferenced Value: %d)\n", (void*)ptr, *ptr);
    printf("Pointer ptr + 1  : %p (Dereferenced Value: %d)\n", (void*)(ptr + 1), *(ptr + 1));
    printf("Pointer ptr + 2  : %p (Dereferenced Value: %d)\n", (void*)(ptr + 2), *(ptr + 2));

    printf("\n=== The Ultimate Proof (Syntactic Sugar) ===\n");
    // 3. Array brackets [] are basically fake. 
    // The compiler translates array[i] into *(array + i) behind the scenes!
    printf("Using array syntax   (sensor_data[2])     : %d\n", sensor_data[2]);
    printf("Using pointer syntax (*(sensor_data + 2)) : %d\n", *(sensor_data + 2));

    return 0;
}