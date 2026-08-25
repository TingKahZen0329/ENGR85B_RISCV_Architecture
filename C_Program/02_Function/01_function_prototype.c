/*
  File: 01_function_prototype.c
  Author: Ting Kah Zen
  Date: 2026-08-25
  Description: Practice using function prototypes to declare a function before it is called in main.
*/
#include <stdio.h>

//If the function appears after 'main', it must be declared before `main`.
int sum3(int a, int b, int c);
int main(void) {
    int answer = sum3(6, 7, 8);
    printf("The sum of 6,7,8 is  %d\n", answer);
    return 0;
}


int sum3(int a, int b, int c) {
    int result = a + b + c;
    return result;
}