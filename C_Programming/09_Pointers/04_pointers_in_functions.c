/*
  File: 04_pointers_in_functions.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Demonstrate pass-by-value versus pass-by-reference using pointers.
*/

#include <stdio.h>

/*
  Function: swap_by_value
  Attempts to swap two integers. 
  Result: Fails to modify the original variables because 'x' and 'y' are local copies.
*/
void swap_by_value(int x, int y) {
    int temp = x;
    x = y;
    y = temp;
}

/*
  Function: swap_by_reference
  Swaps two integers by manipulating their memory addresses directly.
  Result: Successfully modifies the original variables.
*/
void swap_by_reference(int *x_ptr, int *y_ptr) {
    int temp = *x_ptr;
    *x_ptr = *y_ptr;
    *y_ptr = temp;
}

int main(void) {
    int val_A = 10;
    int val_B = 99;

    printf("=== Pointers in Functions ===\n\n");
    printf("Initial values : val_A = %d, val_B = %d\n", val_A, val_B);

    /* Test 1: Pass by Value */
    swap_by_value(val_A, val_B);
    printf("After swap_by_value : val_A = %d, val_B = %d\n", val_A, val_B);

    /* 
      Test 2: Pass by Reference 
      Requires passing the addresses (&) of the variables.
    */
    swap_by_reference(&val_A, &val_B);
    printf("After swap_by_reference : val_A = %d, val_B = %d\n", val_A, val_B);

    return 0;
}