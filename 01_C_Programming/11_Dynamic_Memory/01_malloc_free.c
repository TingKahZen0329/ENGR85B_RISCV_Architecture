/*
  File: 01_malloc_free.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Practice dynamic memory allocation using malloc() and free().
*/

#include <stdio.h>
#include <stdlib.h> /* Required for malloc, free, NULL */

int main(void) {
    printf("=== Dynamic Memory Allocation ===\n\n");

    int required_size = 5;

    /*
      1. Allocate Memory (malloc)
      Request memory for 5 integers.
      malloc returns a void* pointer, so we cast it to (int*).
    */
    int *dynamic_array = (int *)malloc(required_size * sizeof(int));

    /*
      2. Check for Allocation Failure
      If the system is out of memory, malloc returns NULL.
      Hardware engineers MUST always check this!
    */
    if (dynamic_array == NULL) {
        printf("[Error] Memory allocation failed!\n");
        return 1; 
    }

    printf("Memory successfully allocated at address: %p\n\n", (void*)dynamic_array);

    /*
      3. Use the allocated memory just like a normal array
    */
    for (int i = 0; i < required_size; i++) {
        dynamic_array[i] = (i + 1) * 10;
    }

    printf("--- Array Contents ---\n");
    for (int i = 0; i < required_size; i++) {
        printf("Index %d: %d\n", i, dynamic_array[i]);
    }

    /*
      4. Free the Memory (Crucial Step)
      Return the borrowed memory back to the OS Heap to prevent memory leaks.
    */
    free(dynamic_array);
    
    /*
      Good Practice: Set the pointer to NULL after freeing it to avoid "dangling pointers".
    */
    dynamic_array = NULL;

    printf("\nMemory freed successfully. System is safe.\n");

    return 0;
}