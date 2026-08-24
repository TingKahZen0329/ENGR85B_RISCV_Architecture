/*
  File: 03_overflow_test.c
  Author: Ting Kah Zen
  Date: 2026-08-24
  Description: Interactive Signed Integer Overflow Exploitation Experiment
*/

#include <stdio.h>
#include <stdint.h> 

int main(void) {
    // Declare an 8-bit signed integer; the safe range is only -128 to 127.
    int8_t test_val = 0; 

    printf("=== Signed 8-bit Integer Destructive Test ===\n");
    printf("Please input a number (suggest -128~127, less than -129,bigger than 128): ");
    
    //%hhd 32 half  half  = 8
    //input need to limit,output don't need
    scanf("%hhd", &test_val);
    
    // %d is int number
    printf("\n[Actual Memory State] The final value stored by the system is: %d\n", test_val);
    
    //if input is -128~127 ,normal output same number

    //if input is less than -128,such as -129 ,the output is 127
    //126 127 -128 -127 -126 .... so the -129 is 127

    //if input is bigger than 127 such as 128  ,the output is -128
    //126 127 -128 -127 -126 .... so the 128 is -128
    return 0;
}