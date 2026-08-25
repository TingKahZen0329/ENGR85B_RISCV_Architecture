/*
  File: 01_function_prototype.c
  Author: Ting Kah Zen
  Date: 2026-08-25
  Description: Practice using function prototypes to declare a function before it is called in main.
*/
#include <stdio.h>

// 函式原型
void try_to_change(int *x);

int main(void) {
    int my_var = 10;
    
    printf("before function,my var is %d\n", my_var);
    
    
    try_to_change(& my_var);
    
    
    printf("after function ,my_var is %d\n", my_var); 
    
    return 0;
}


void try_to_change(int *x) {
    *x = 99;
    printf("the internal function is already change my_var,the number is %d\n", *x);
}