/*
  File: 02_data_types.c
  Author: Ting Kah Zen
  Date: 2026-08-24
  Description: Testing the memory overflow phenomenon of `uint16_t` in conjunction with `scanf`
*/

#include <stdio.h>
#include <stdint.h>

int main(void) {
    // Declare a 16-bit unsigned integer to record the number of button presses (range: 0–65535)
    uint16_t button_presses = 0; 

    printf("=== Hardware Button Test System ===\n");
    printf("Please enter the number of times the machine was clicked today: ");
    
    //%u 32bits
    //%hu 16bits
    //if want a function return a number ,must give the address  to the function
    //so must use &
    scanf("%hu", &button_presses);
    
    // print %u (unsigned)
    printf("\n[System Log] The machine has been clicked a total of %u times.\n", button_presses);
    //if a number is 0-65535 ,number is normal(no change)
    
    //if a number is bigger than 65535 ,the number is overflow ,
    //70000 % 65536 = 4464(because 0 is a number,include 0)

    //if a number is negatif (such as -1),the answer is 65535
    //-1 = 1111 1111 1111 1111 = 65535
    return 0;
}