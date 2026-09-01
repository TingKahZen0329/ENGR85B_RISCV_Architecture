/*
  File: 09_BareMetal_LED_Matrix.ino
  Author: Ting Kah Zen
  Date: 2026-08-31
  Description: Bare-metal SPI implementation to control a MAX7219 8x8 LED matrix.
               Demonstrates direct hardware register access and display initialization 
               without relying on external high-level libraries.
*/

#include "../04_EasyESP32/EasyESP32.h"  
#include "../07_SPI/EasyESP32_SPI.h"    

// Define hardware pins
#define SCK_PIN   7
#define MOSI_PIN  6
#define MISO_PIN  5 // MISO is unused by MAX7219 but retained for the SPI matrix configuration
#define CS_PIN    14

// MAX7219 control register addresses
#define REG_DECODE_MODE  0x09
#define REG_INTENSITY    0x0A
#define REG_SCAN_LIMIT   0x0B
#define REG_SHUTDOWN     0x0C
#define REG_DISPLAY_TEST 0x0F

// SPI transmission function for MAX7219 (No RWbar processing required)
void max7219_write(uint8_t address, uint8_t value) {
    my_digitalWrite(CS_PIN, 0);       // 1. Pull CS low to initiate communication
    my_spi_transfer(address);         // 2. Transmit 8-bit register address
    my_spi_transfer(value);           // 3. Transmit 8-bit data
    my_digitalWrite(CS_PIN, 1);       // 4. Pull CS high to latch and execute
}

void setup() {
    Serial.begin(115200); 
    
    my_timer_init();
    my_delay(1000);
    Serial.println("Starting Bare-Metal LED Matrix...");

    // 1. Initialize GPIO and IO MUX 
    my_pinMode(CS_PIN, MY_OUTPUT);
    my_digitalWrite(CS_PIN, 1);
    my_pinMode(SCK_PIN, MY_OUTPUT);
    my_pinMode(MOSI_PIN, MY_OUTPUT);
    my_pinMode(MISO_PIN, MY_INPUT); 

    // 2. Initialize SPI engine
    my_spi_pin_routing(SCK_PIN, MOSI_PIN, MISO_PIN, CS_PIN);
    my_spi_init();

    // 3. Initialize MAX7219 display driver
    max7219_write(REG_DISPLAY_TEST, 0x00); // Disable display test mode
    max7219_write(REG_DECODE_MODE, 0x00);  // Set to LED matrix mode (Disable BCD decoding)
    max7219_write(REG_SCAN_LIMIT, 0x07);   // Scan all 8 rows (0-7)
    max7219_write(REG_INTENSITY, 0x02);    // Set intensity (0x00 to 0x0F, 0x02 for low brightness)
    max7219_write(REG_SHUTDOWN, 0x01);     // Exit shutdown mode to turn on display

    // Clear display (Write 0x00 to all 8 rows)
    for (int i = 1; i <= 8; i++) {
        max7219_write(i, 0x00);
    }
}

void loop() {
    // Define a smiley face bitmap
    uint8_t smiley[8] = {
        0b00111100,
        0b01000010,
        0b10011001,
        0b10100101,
        0b10000001,
        0b10100101,
        0b01000010,
        0b00111100
    };

    // Push array data to the 8x8 matrix row by row (Registers 1-8 correspond to Rows 1-8)
    for (int i = 0; i < 8; i++) {
        max7219_write(i + 1, smiley[i]); 
    }
    
    my_delay(1000);
}
