/*
  File: 05_Debug_Timer.ino
  Author: Ting Kah Zen
  Date: 2026-08-29
  Description: Diagnostic script to verify the CLINT MTIME hardware 
               timer operation and increment rate via Serial output.
*/

#include "../04_EasyESP32/EasyESP32.h"

void setup() {
  // Initialize standard Serial communication for debugging
  Serial.begin(115200);
  
  // Attempt to start the hardware timer
  my_timer_init();
}

void loop() {
  // Read the lower 32 bits of the 64-bit MTIME register
  uint32_t current_timer_val = (uint32_t)(*ESP32_MTIME);
  
  // Output the raw hardware register value to the Serial Monitor
  Serial.print("MTIME Value: ");
  Serial.println(current_timer_val);
  
  // Utilize standard API temporarily to prevent Serial buffer overflow
  delay(1000); 
}