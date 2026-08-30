/*
  File: 06_Morse_Code.ino
  Author: Ting Kah Zen
  Date: 2026-08-29
  Description: Morse code generator utilizing custom Hardware Abstraction Layer (HAL).
               Includes array bounds checking and explicit null-terminator evaluation 
               to prevent memory overflow and infinite loops.
*/

#include "../04_EasyESP32/EasyESP32.h"

#define DUR 100            // Base duration unit in milliseconds
const int LED_PIN = 15;    // Onboard LED pin for Adafruit ESP32-C6 Feather

// Lookup table defining Morse code sequences for letters A-Z.
// Dots are represented by '.', dashes by '-', and null-terminated.
const char codes[26][5] = {
  ".-",   // A
  "-...", // B
  "-.-.", // C
  "-..",  // D
  ".",    // E
  "..-.", // F
  "--.",  // G
  "....", // H
  "..",   // I
  ".---", // J
  "-.-",  // K
  ".-..", // L
  "--",   // M
  "-.",   // N
  "---",  // O
  ".--.", // P
  "--.-", // Q
  ".-.",  // R
  "...",  // S
  "-",    // T
  "..-",  // U
  "...-", // V
  ".--",  // W
  "-..-", // X
  "-.--", // Y
  "--.."  // Z
};

// Function to parse a single character and output its corresponding Morse sequence.
void playChar(char c) {
  // 1. Safety Check: Only process uppercase letters A-Z
  if (c >= 'A' && c <= 'Z') {
    int i = 0;
    
    // 2. Explicitly check for the null terminator '\0'
    while (codes[c - 'A'][i] != '\0') {
      my_digitalWrite(LED_PIN, 1); // Turn ON LED
      
      if (codes[c - 'A'][i] == '.') {
        my_delay(DUR);             // Dot duration
      } else {
        my_delay(3 * DUR);         // Dash duration
      }
      
      my_digitalWrite(LED_PIN, 0); // Turn OFF LED
      my_delay(DUR);               // Pause between elements
      i++;
    }
    my_delay(DUR * 2);             // Extra pause between characters
    
  } 
  // 3. Handle spaces (Pause between words)
  else if (c == ' ') {
    my_delay(DUR * 4);
  }
}

// Function to iterate through a null-terminated string and play each character.
void playStr(const char msg[]) {
  int i = 0;
  while (msg[i] != '\0') {
    playChar(msg[i]);
    i++;
  }
}

void setup() {
  // Initialize the hardware timer prior to using my_delay()
  my_timer_init();
  
  // Initialize the GPIO pin as an output using the custom HAL.
  my_pinMode(LED_PIN);
}

void loop() {
  // Transmit the standard distress signal continuously.
  playStr("SOS");
  
  // Pause between words before repeating the sequence.
  my_delay(DUR * 4);
}