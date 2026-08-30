/*
  File: 04_EasyESP32.ino
  Author: Ting Kah Zen
  Date: 2026-08-28
  Description: Implementation of the custom EasyESP32 HAL to control 
               the onboard LED via direct memory access.
*/

#include "EasyESP32.h"

// The built-in red LED on the Adafruit ESP32-C6 Feather is connected to GPIO 15.
const int LED_PIN = 15;

void setup() {
  // Initialize the GPIO pin as an output using the custom HAL.
  my_pinMode(LED_PIN);
}

void loop() {
  // Drive the pin HIGH
  my_digitalWrite(LED_PIN, 1);
  my_delay(500);
  
  // Drive the pin LOW
  my_digitalWrite(LED_PIN, 0);
  my_delay(500);
}