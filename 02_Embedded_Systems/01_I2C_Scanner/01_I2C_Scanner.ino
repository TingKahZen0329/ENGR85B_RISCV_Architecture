/*
  File: I2C_Scanner.ino
  Author: Ting Kah Zen
  Date: 2026-08-28
  Description: Scans the I2C bus for active devices and prints their addresses 
               to the Serial Monitor. Target Architecture: ESP32-C6.
*/
#include <Wire.h>

void setup() {
  // Initialize the I2C bus
  Wire.begin();
  
  // Initialize serial communication at 115200 baud rate
  Serial.begin(115200);
  
  // Delay to allow the native USB serial port to initialize properly 
  // (Required for boards with native USB capabilities to prevent missing early serial output)
  delay(2000); 
  
  Serial.println("\nI2C Scanner Initialized");
}

void loop() {
  byte error, address;
  int nDevices = 0;

  Serial.println("Scanning I2C bus...");

  // The I2C address space is 7-bit, ranging from 1 to 127
  for (address = 1; address < 127; address++) {
    
    // Begin transmission to the current address
    Wire.beginTransmission(address);
    // End transmission and capture the return status
    error = Wire.endTransmission();

    if (error == 0) {
      // Device acknowledged the transmission
      Serial.print("I2C device found at address 0x");
      if (address < 16) {
        Serial.print("0");
      }
      Serial.print(address, HEX);
      Serial.println("  !");
      nDevices++;
    } 
    else if (error == 4) {
      // Unknown error occurred during transmission
      Serial.print("Unknown error at address 0x");
      if (address < 16) {
        Serial.print("0");
      }
      Serial.println(address, HEX);
    }
  }
  
  if (nDevices == 0) {
    Serial.println("No I2C devices found\n");
  } else {
    Serial.println("Scan complete\n");
  }
  
  // Wait 5 seconds before initiating the next scan
  delay(5000);
}
