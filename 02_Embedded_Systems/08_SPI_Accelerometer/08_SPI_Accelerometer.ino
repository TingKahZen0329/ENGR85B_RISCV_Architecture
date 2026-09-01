/*
  File: 08_SPI_Accelerometer.ino
  Author: Ting Kah Zen
  Date: 2026-08-31
  Description: Bare-metal SPI data acquisition from the LIS3DH accelerometer. 
               Implements 16-bit register reads/writes and reconstructs two's 
               complement acceleration data without external libraries.
*/

#include "../04_EasyESP32/EasyESP32.h"  // Include custom GPIO and Timer HAL
#include "../07_SPI/EasyESP32_SPI.h"    // Include custom SPI HAL

// Define hardware pins
#define SCK_PIN   7
#define MOSI_PIN  6
#define MISO_PIN  5
#define CS_PIN    14

// Write to register: RWbar = 0[cite: 1]
void spiWrite(uint8_t address, uint8_t value) {
    my_digitalWrite(CS_PIN, 0);       // 1. Pull CS low to initiate communication[cite: 1]
    my_spi_transfer(address & 0x7F);  // 2. Transmit 6-bit address, ensuring the MSB (RW) is 0 for write operation[cite: 1]
    my_spi_transfer(value);           // 3. Transmit the data byte to be written (ignore return value)[cite: 1]
    my_digitalWrite(CS_PIN, 1);       // 4. Pull CS high to terminate communication
}

// Read from register: RWbar = 1[cite: 1]
uint8_t spiRead(uint8_t address) {
    uint8_t result;
    my_digitalWrite(CS_PIN, 0);       // 1. Pull CS low to initiate communication[cite: 1]
    my_spi_transfer(address | 0x80);  // 2. Transmit address, applying bitwise OR to set the MSB (RW) to 1 for read operation[cite: 1]
    result = my_spi_transfer(0x00);   // 3. Transmit dummy payload (0x00) to clock out the sensor's return data[cite: 1]
    my_digitalWrite(CS_PIN, 1);       // 4. Pull CS high to terminate communication
    return result;
}

void setup() {
    Serial.begin(115200); 
    
    my_timer_init();
    my_delay(1000);
    Serial.println("Starting 100% Pure Bare-Metal Accelerometer...");

    // 1. Initialize GPIO and IO MUX
    my_pinMode(CS_PIN, MY_OUTPUT);
    my_digitalWrite(CS_PIN, 1);
    my_pinMode(SCK_PIN, MY_OUTPUT);
    my_pinMode(MOSI_PIN, MY_OUTPUT);
    my_pinMode(MISO_PIN, MY_INPUT); 

    // 2. Initialize SPI engine
    my_spi_pin_routing(SCK_PIN, MOSI_PIN, MISO_PIN, CS_PIN);
    my_spi_init();

    // 3. Wake up and configure the LIS3DH 
    // Write to CTRL_REG1 (0x20): Enable X, Y, Z axes, set 400Hz sampling rate[cite: 1]
    spiWrite(0x20, 0x77); 
    // Write to CTRL_REG4 (0x23): Enable Block Data Update (BDU) and high-resolution mode[cite: 1]
    spiWrite(0x23, 0x88); 
    
    my_delay(100); // Allow sensor time to boot
}

void loop() {
    // Read WHO_AM_I register to verify connection
    uint8_t id = spiRead(0x0F);
    
    // Read X, Y, and Z axis data (combine low and high bytes)[cite: 1]
    // Merge two 8-bit registers into a 16-bit signed integer using bitwise shift (<< 8) and OR (|) operations[cite: 1]
    int16_t x = spiRead(0x28) | (spiRead(0x29) << 8); 
    int16_t y = spiRead(0x2A) | (spiRead(0x2B) << 8); 
    int16_t z = spiRead(0x2C) | (spiRead(0x2D) << 8); 

    // Output the results
    Serial.print("ID: 0x"); Serial.print(id, HEX);
    Serial.print(" | X: "); Serial.print(x);
    Serial.print(" | Y: "); Serial.print(y);
    Serial.print(" | Z: "); Serial.println(z);
    
    my_delay(200); // Short delay to prevent excessive serial output
}
