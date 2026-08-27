/*
  File: 02_strings.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Demonstrate that strings are just character arrays ending with a null terminator (\0).
*/

#include <stdio.h>

int main(void) {
    printf("=== The Truth About Strings ===\n\n");

    // Method 1: The explicit way (Array of characters)
    // We MUST include '\0' at the end, otherwise C won't know where the string stops!
    char greeting_array[] = {'H', 'e', 'l', 'l', 'o', '\0'};
    
    // Method 2: The syntactic sugar way (Double quotes)
    // C automatically appends the '\0' for you at the end of "World"
    char greeting_literal[] = "World";

    // %s is the placeholder for strings. It prints characters until it hits '\0'.
    printf("Message 1: %s\n", greeting_array);
    printf("Message 2: %s\n", greeting_literal);

    printf("\n=== The Null Terminator Proof ===\n");
    // Let's check the size of the "World" array in memory.
    // 'W', 'o', 'r', 'l', 'd' is 5 letters. But the size will be 6!
    printf("Size of greeting_literal: %zu bytes\n", sizeof(greeting_literal));
    
    // What happens if we manually put a '\0' in the middle of a string?
    printf("\n=== The Cutting Magic ===\n");
    char secret_message[] = "Hardware\0Engineer";
    // It will only print "Hardware" because %s stops immediately when it sees '\0'
    printf("Secret Message: %s\n", secret_message);

    return 0;
}