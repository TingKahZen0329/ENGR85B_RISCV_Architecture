/*
  File: 04_ascii_test.c
  Author: Ting Kah Zen
  Date: 2026-08-24
  Description: Experiment on the Low-Level Conversion Between ASCII Characters and Numbers
*/

#include <stdio.h>

int main(void) {
    char letter;

    printf("=== Case Conversion  (ASCII) ===\n");
    printf("Please enter an uppercase English letter(A-Z): ");
    
    // ' %c' = Discard *all* whitespace, tabs, and newlines (\n) as junk.
    scanf(" %c", &letter);
    
    // Use %c to print the character, and use %d to print its actual underlying decimal value.
    printf("\nYour input character is '%c',The numbers in memory is %d\n", letter, letter);
    
    // Implementing case conversion: Add 32 to the number.
    char lower_letter = letter + 32;
    
    printf("\n[Calculation Result] After adding 32 to the number, it becomes...: %d\n", lower_letter);
    printf("Printing the new numbers as characters results in:'%c'\n", lower_letter);
    
    return 0;
}