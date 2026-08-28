/*
  File: 02_typedef.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Practice using 'typedef' to create aliases for structures and simplify code.
*/

#include <stdio.h>

// 1. Combining 'typedef' with 'struct'
// Syntax: typedef struct { members } AliasName;
typedef struct {
    int motor_id;
    int target_rpm;
    int current_rpm;
} MotorController; // <-- This is our new alias! Capitalizing the first letter is a standard convention.

int main(void) {
    printf("=== Typedef Magic ===\n\n");

    // 2. No need to write the 'struct' keyword anymore when declaring variables!
    // We can use 'MotorController' directly, just like using built-in types like 'int' or 'float'.
    MotorController motor_A = {1, 3000, 2950};
    MotorController motor_B = {2, 1500, 1500};

    printf("--- Motor A Status ---\n");
    printf("Motor ID: %d\n", motor_A.motor_id);
    printf("Target RPM: %d\n", motor_A.target_rpm);
    
    // Check if the motor has reached its target speed
    if (motor_A.current_rpm >= motor_A.target_rpm) {
        printf("Status: Target Reached.\n");
    } else {
        printf("Status: Speeding up...\n");
    }

        printf("\n\n\n--- Motor B Status ---\n");
    printf("Motor ID: %d\n", motor_B.motor_id);
    printf("Target RPM: %d\n", motor_B.target_rpm);
    
    // Check if the motor has reached its target speed
    if (motor_B.current_rpm >= motor_B.target_rpm) {
        printf("Status: Target Reached.\n");
    } else {
        printf("Status: Speeding up...\n");
    }

    printf("Size of motor_A is %d\n",sizeof(motor_A));//4+4+4
    printf("Size of motor_B is %d\n",sizeof(motor_B));//4+4+4
    
    return 0;
}