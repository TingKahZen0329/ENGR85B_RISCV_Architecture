/*
  File: LIS3DH_Accelerometer.ino
  Author: Ting Kah Zen
  Date: 2026-08-28
  Description: Initializes the LIS3DH via I2C and reads raw X, Y, Z acceleration data.
*/
#include <Wire.h>

#define LIS3DH_ADDR 0x18
#define CTRL_REG1 0x20
#define OUT_X_L 0x28

void setup() {
  Wire.begin();
  Serial.begin(115200);
  delay(2000); 

  // Initialize LIS3DH: Set data rate to 400Hz and enable X, Y, Z axes
  Wire.beginTransmission(LIS3DH_ADDR);
  Wire.write(CTRL_REG1);
  Wire.write(0x77); // 0b01110111
  Wire.endTransmission();
  
  Serial.println("LIS3DH Initialized!");
}

void loop() {
  // Tell the sensor we want to start reading from the X-axis low byte register
  Wire.beginTransmission(LIS3DH_ADDR);
  Wire.write(OUT_X_L | 0x80); // Bitwise OR with 0x80 enables auto-increment for reading multiple bytes
  Wire.endTransmission();

  // Request 6 bytes of data (X, Y, Z axes, 2 bytes each)
  Wire.requestFrom(LIS3DH_ADDR, 6);

  if (Wire.available() == 6) {
    // Combine low and high bytes using bitwise shift and OR operations
    int16_t x = Wire.read() | (Wire.read() << 8);
    int16_t y = Wire.read() | (Wire.read() << 8);
    int16_t z = Wire.read() | (Wire.read() << 8);

    Serial.print("X: "); Serial.print(x);
    Serial.print(" \tY: "); Serial.print(y);
    Serial.print(" \tZ: "); Serial.println(z);
  }
  
  delay(100);
}
