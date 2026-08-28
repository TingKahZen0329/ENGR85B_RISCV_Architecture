/*
  File: 01_arrays.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Practice 1D array declaration, initialization, modification, and iteration.
*/

#include <stdio.h>

int main(void) {
    printf("=== 1D Array Basics ===\n\n");

    // Declare and initialize an array of 5 integers (like 5 sensor readings)
    int sensor_data[5] = {10, 25, 30, 15, 42};

    // Accessing elements using the index (Remember: index ALWAYS starts at 0!)
    printf("First element (index 0): %d\n", sensor_data[0]);
    printf("Third element (index 2): %d\n", sensor_data[2]);

    // Modifying an element
    printf("\n[Update] Modifying the second element (index 1) to 99...\n");
    sensor_data[1] = 99;

    // Using a 'for' loop to iterate through the entire array
    // This is why loops and arrays are best friends!
    printf("\nCurrent Array Contents:\n");
    for (int i = 0; i < 5; i++) {
        printf("sensor_data[%d] = %d\n", i, sensor_data[i]);
    }

    // ---------------------------------------------------------
    // The Out-of-Bounds Trap (Danger Zone for Hardware Engineers)
    // ---------------------------------------------------------
    printf("\n=== The Out-of-Bounds Trap ===\n");
    // C does NOT check if your index is valid! It just accesses the memory directly.
    // The valid indices are 0 to 4. What happens if we access index 5
    printf("Reading sensor_data[5] (out of bounds): %d\n", sensor_data[5]);
    printf("Note: This prints a 'garbage value' from adjacent memory!\n");

    return 0;
}