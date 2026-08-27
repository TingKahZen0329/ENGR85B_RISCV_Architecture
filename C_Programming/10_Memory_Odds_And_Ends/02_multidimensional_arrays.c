/*
  File: 02_multidimensional_arrays.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Demonstrates the contiguous memory layout of multidimensional arrays (row-major order).
*/

#include <stdio.h>

int main(void) {
    printf("=== Multidimensional Arrays in Memory ===\n\n");

    /*
      Declare a 2x3 2D array.
      In C, multidimensional arrays are stored in strictly contiguous memory.
      The last dimension varies the fastest (Row-Major Order).
    */
    int matrix[2][3] = {
        {10, 20, 30}, /* Row 0 */
        {40, 50, 60}  /* Row 1 */
    };

    printf("--- 2D Array Memory Map ---\n");
    for (int row = 0; row < 2; row++) {
        for (int col = 0; col < 3; col++) {
            printf("Address of matrix[%d][%d]: %p | Value: %d\n", 
                   row, col, (void*)&matrix[row][col], matrix[row][col]);
        }
    }

    /*
      Demonstrate a 3D array layout similar to the course slide: double field[2][3][3].
      Using a smaller 3D array (2x2x2) with 'short' type (2 bytes) to observe address increments.
    */
    short field[2][2][2] = {
        { {1, 2}, {3, 4} },
        { {5, 6}, {7, 8} }
    };

    printf("\n--- 3D Array Memory Map (field[2][2][2]) ---\n");
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            for (int k = 0; k < 2; k++) {
                printf("Address of field[%d][%d][%d]: %p\n", 
                       i, j, k, (void*)&field[i][j][k]);
            }
        }
    }

    return 0;
}