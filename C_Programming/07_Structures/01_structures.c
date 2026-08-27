/*
  File: 01_structures.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: Practice defining, initializing, and accessing C structures (struct).
*/

#include <stdio.h>
#include <stdbool.h>
#include <string.h> // Required for strcpy()

// 1. Define the structure blueprint OUTSIDE of main()
// This creates a new custom data type called 'struct SensorNode'
struct SensorNode {
    int id;
    float temperature;
    bool is_active;
    char location[20];
};

int main(void) {
    printf("=== Structures (struct) in C ===\n\n");

    // 2. Initialization Method 1: Directly assigning values in order
    struct SensorNode sensor1 = {101, 36.5, true, "Engine Room"};

    // 3. Accessing members using the dot (.) operator
    printf("--- Sensor 1 Data ---\n");
    printf("ID: %d\n", sensor1.id);
    printf("Temperature: %.1f C\n", sensor1.temperature);
    printf("Active: %s\n", sensor1.is_active ? "Yes" : "No");
    printf("Location: %s\n", sensor1.location);

    // 4. Initialization Method 2: Setting members one by one
    struct SensorNode sensor2;
    sensor2.id = 102;
    sensor2.temperature = 42.8;
    sensor2.is_active = false;
    
    // WARNING: In C, you CANNOT assign a string to an array directly like this:
    // sensor2.location = "CPU Fan"; // This will cause a compiler error!
    // Instead, we must use strcpy() from <string.h> to copy the string.
    strcpy(sensor2.location, "CPU Fan");

    printf("\n--- Sensor 2 Data (Manual Assignment) ---\n");
    printf("ID: %d\n", sensor2.id);
    printf("Temperature: %.1f C\n", sensor2.temperature);
    printf("Active: %s\n", sensor2.is_active ? "Yes" : "No");
    printf("Location: %s\n", sensor2.location);

    printf("Size of Sensor 1 is %d\n",sizeof(sensor1));//20+4+4+4
    printf("Size of Sensor 2 is %d\n",sizeof(sensor2));//20+4+4+4

    return 0;
}