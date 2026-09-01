/*
  File: 10_BareMetal_Digital_Level.ino
  Author: Ting Kah Zen
  Date: 2026-08-31
  Description: Digital level application integrating bare-metal SPI control for 
               both the LIS3DH accelerometer and MAX7219 LED matrix. Maps real-time 
               gravitational data to a visual 2D coordinate on an 8x8 display.
*/

#include "../04_EasyESP32/EasyESP32.h"  
#include "../07_SPI/EasyESP32_SPI.h"    

// Define hardware pins for shared SPI bus
#define SCK_PIN       7
#define MOSI_PIN      6
#define MISO_PIN      5

// Define independent Chip Select (CS) pins for dual-device operation
#define CS_ACCEL      14 // CS for LIS3DH Accelerometer
#define CS_MATRIX     15 // CS for MAX7219 LED Matrix

// LIS3DH Register Addresses
#define LIS_CTRL_REG1 0x20
#define LIS_CTRL_REG4 0x23
#define LIS_OUT_X_L   0x28
#define LIS_OUT_X_H   0x29
#define LIS_OUT_Y_L   0x2A
#define LIS_OUT_Y_H   0x2B

// MAX7219 Register Addresses
#define MAX_DECODE    0x09
#define MAX_INTENSITY 0x0A
#define MAX_SCAN      0x0B
#define MAX_SHUTDOWN  0x0C
#define MAX_TEST      0x0F

// ---------------------------------------------------------
// Device 1: LIS3DH Accelerometer SPI Functions
// ---------------------------------------------------------

// Write to LIS3DH register (MSB = 0 for write)
void spiWriteAccel(uint8_t address, uint8_t value) {
    my_digitalWrite(CS_ACCEL, 0);       
    my_spi_transfer(address & 0x7F);  
    my_spi_transfer(value);           
    my_digitalWrite(CS_ACCEL, 1);       
}

// Read from LIS3DH register (MSB = 1 for read)
uint8_t spiReadAccel(uint8_t address) {
    uint8_t result;
    my_digitalWrite(CS_ACCEL, 0);       
    my_spi_transfer(address | 0x80);  
    result = my_spi_transfer(0x00);   
    my_digitalWrite(CS_ACCEL, 1);       
    return result;
}

// ---------------------------------------------------------
// Device 2: MAX7219 LED Matrix SPI Function
// ---------------------------------------------------------

// Write to MAX7219 register (Standard 16-bit transfer)
void spiWriteMatrix(uint8_t address, uint8_t value) {
    my_digitalWrite(CS_MATRIX, 0);       
    my_spi_transfer(address);         
    my_spi_transfer(value);           
    my_digitalWrite(CS_MATRIX, 1);       
}

// ---------------------------------------------------------
// Main Program
// ---------------------------------------------------------

void setup() {
    Serial.begin(115200); 
    
    my_timer_init();
    my_delay(1000);
    Serial.println("Starting Dual-SPI Bare-Metal Digital Level...");

    // 1. Initialize GPIO states for CS pins (Default HIGH = inactive)
    my_pinMode(CS_ACCEL, MY_OUTPUT);
    my_digitalWrite(CS_ACCEL, 1);
    
    my_pinMode(CS_MATRIX, MY_OUTPUT);
    my_digitalWrite(CS_MATRIX, 1);

    // Initialize SPI bus pins
    my_pinMode(SCK_PIN, MY_OUTPUT);
    my_pinMode(MOSI_PIN, MY_OUTPUT);
    my_pinMode(MISO_PIN, MY_INPUT); 

    // 2. Initialize Hardware SPI Engine
    // Route physical pins to the internal SPI controller
    my_spi_pin_routing(SCK_PIN, MOSI_PIN, MISO_PIN, CS_ACCEL);
    my_spi_init();

    // 3. Configure LIS3DH Accelerometer
    spiWriteAccel(LIS_CTRL_REG1, 0x77); // Enable X, Y, Z axes, 400Hz rate
    spiWriteAccel(LIS_CTRL_REG4, 0x88); // Enable Block Data Update (BDU), High-Res mode
    
    // 4. Configure MAX7219 LED Matrix
    spiWriteMatrix(MAX_TEST, 0x00);     // Disable display test mode
    spiWriteMatrix(MAX_DECODE, 0x00);   // LED matrix mode (No BCD)
    spiWriteMatrix(MAX_SCAN, 0x07);     // Scan all 8 rows
    spiWriteMatrix(MAX_INTENSITY, 0x02);// Low brightness
    spiWriteMatrix(MAX_SHUTDOWN, 0x01); // Turn on display

    my_delay(100); 
}

void loop() {
    // Read raw X and Y acceleration data (16-bit two's complement)
    int16_t x_raw = spiReadAccel(LIS_OUT_X_L) | (spiReadAccel(LIS_OUT_X_H) << 8); 
    int16_t y_raw = spiReadAccel(LIS_OUT_Y_L) | (spiReadAccel(LIS_OUT_Y_H) << 8); 

    // Map the raw accelerometer values to an 8x8 matrix coordinate (0 to 7)
    // Adjust the boundary limits (-8000 to 8000) based on actual physical calibration
    int col = map(x_raw, -8000, 8000, 0, 7);
    int row = map(y_raw, -8000, 8000, 0, 7);

    // Constrain the coordinates to prevent matrix addressing overflow
    col = constrain(col, 0, 7);
    row = constrain(row, 0, 7);

    // Clear the previous frame on the LED matrix
    for (int i = 1; i <= 8; i++) {
        spiWriteMatrix(i, 0x00);
    }

    // Render the new "bubble" coordinate
    // The MAX7219 uses 1-based indexing for rows (1 to 8)
    // Bitwise left shift (1 << col) activates the specific LED in that row
    spiWriteMatrix(row + 1, 1 << col);
    
    // Refresh rate delay
    my_delay(50); 
}
