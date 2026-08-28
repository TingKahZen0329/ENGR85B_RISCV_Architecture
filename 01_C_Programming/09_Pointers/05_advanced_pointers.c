/*
  File: 05_advanced_pointers.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Demonstration of double pointers (pointer to a pointer) and function pointers.
*/

#include <stdio.h>

/*
  Function: add_numbers
  A simple function used to demonstrate function pointers.
*/
int add_numbers(int a, int b) {
    return a + b;
}

int main(void) {
    printf("=== Part 1: Double Pointers (**) ===\n\n");

    int data = 100;
    int *ptr1 = &data;       /* ptr1 stores the address of 'data' */
    int **ptr2 = &ptr1;      /* ptr2 stores the address of 'ptr1' */

    printf("Value of data                : %d\n", data);
    printf("Value via single pointer     : %d\n", *ptr1);
    printf("Value via double pointer     : %d\n", **ptr2);

    printf("\n--- Memory Layout ---\n");
    printf("Address of data              : %p\n", (void*)&data);
    printf("Address stored in ptr1       : %p\n", (void*)ptr1);
    printf("Address of ptr1              : %p\n", (void*)&ptr1);
    printf("Address stored in ptr2       : %p\n", (void*)ptr2);
    printf("Address stored in *ptr2      : %p\n", (void*)*ptr2);

    printf("\n=== Part 2: Function Pointers ===\n\n");

    /* 
      Declare a function pointer named 'operation'.
      It points to a function that takes two ints as arguments and returns an int.
    */
    int (*operation)(int, int) = add_numbers;

    /* 
      Invoke the function using the pointer. 
      Both (*operation)(x, y) and operation(x, y) are valid C syntax.
    */
    int result = operation(5, 7);
    
    printf("Calling add_numbers(5, 7) via function pointer: %d\n", result);

    return 0;


    // **ptr2 = *ptr1 
    // *ptr2 = ptr1
    // ptr2 = &ptr1
}