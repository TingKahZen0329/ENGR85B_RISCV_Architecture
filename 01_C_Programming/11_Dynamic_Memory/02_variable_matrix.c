/*
  File: 02_variable_matrix.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Demonstrates creating and manipulating variable dimension matrices using a dynamically allocated 1D array.
*/

#include <stdio.h>
#include <stdlib.h>

/*
  Function: newMatrix
  Allocates memory for an m x n matrix of doubles.
*/
double* newMatrix(int m, int n) {
    double *mat = (double*)malloc(m * n * sizeof(double));
    return mat;
}

/*
  Function: newIdentityMatrix
  Creates an n x n identity matrix.
*/
double* newIdentityMatrix(int n) {
    double *mat = newMatrix(n, n);
    int i, j;
    for (i = 0; i < n; i++) {
        for (j = 0; j < n; j++) {
            /* Simulating 2D access: mapped to index [col + row * num_cols] */
            mat[j + i * n] = (i == j);
        }
    }
    return mat;
}

/*
  Function: scaleMatrix
  Multiplies a matrix by a scalar value and stores the result in another matrix.
*/
void scaleMatrix(double *mat, double *scaled, int m, int n, double c) {
    int i, j;
    for (i = 0; i < m; i++) {
        for (j = 0; j < n; j++) {
            scaled[j + i * n] = mat[j + i * n] * c;
        }
    }
}

int main(void) {
    printf("=== Variable Dimension Matrix Example ===\n\n");

    double *m1, *m2;
    int size = 3;

    m1 = newIdentityMatrix(size);
    m2 = newMatrix(size, size);
    
    scaleMatrix(m1, m2, size, size, 10.0);

    printf("--- Matrix m1 (Identity) ---\n");
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("%6.1f ", m1[j + i * size]);
        }
        printf("\n");
    }

    printf("\n--- Matrix m2 (Scaled by 10) ---\n");
    for (int i = 0; i < size; i++) {
        for (int j = 0; j < size; j++) {
            printf("%6.1f ", m2[j + i * size]);
        }
        printf("\n");
    }

    /* Freeing allocated memory */
    free(m1);
    free(m2); 

    return 0;
}