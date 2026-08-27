/*
  File: 03_struct_pointers.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Demonstrate the use of struct pointers and the arrow operator (->).
*/

#include <stdio.h>

typedef struct {
    int register_id;
    int data_value;
    int status_flag;
} HardwareRegister;

int main(void) {
    printf("=== Struct Pointers and the Arrow Operator ===\n\n");

    HardwareRegister timer_reg = {0x01, 255, 1};

    HardwareRegister *reg_ptr = &timer_reg;

    /*
      Method 1: Dereference followed by the dot operator.
      Parentheses are strictly required because the dot (.) operator 
      has higher precedence than the dereference (*) operator.
    */
    printf("--- Accessing via (*ptr).member ---\n");
    printf("Register ID : 0x%02X\n", (*reg_ptr).register_id);
    
    /*
      Method 2: The arrow operator (->).
      This operator automatically dereferences the pointer and accesses 
      the specified member. It is the standard syntax for manipulating 
      hardware structures via pointers.
    */
    printf("\n--- Accessing via ptr->member ---\n");
    printf("Data Value  : %d\n", reg_ptr->data_value);
    
    /*
      Modifying structure data remotely using the pointer.
    */
    reg_ptr->status_flag = 0;
    printf("Status Flag (Updated): %d\n", reg_ptr->status_flag);

    return 0;
}