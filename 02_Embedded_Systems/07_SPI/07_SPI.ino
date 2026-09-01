/*
  File: 07_SPI.ino
  Author: Ting Kah Zen
  Date: 2026-08-31
  Description: Pure bare-metal SPI initialization and communication test. 
               Verifies the custom SPI hardware abstraction layer by successfully 
               reading the LIS3DH WHO_AM_I register.
*/

#include "../04_EasyESP32/EasyESP32.h"  // Include custom GPIO and Timer HAL
#include "EasyESP32_SPI.h"              // Include custom SPI HAL

#define SCK_PIN   7
#define MOSI_PIN  6
#define MISO_PIN  5
#define CS_PIN    14

void setup() {
    Serial.begin(115200); 
    
    my_timer_init();
    my_delay(1000);
    Serial.println("Starting 100% Pure Bare-Metal Phase...");

    // 1. Chip Select (CS) Pin Configuration
    my_pinMode(CS_PIN, MY_OUTPUT);
    my_digitalWrite(CS_PIN, 1);

    // 2. Physical Pin IO MUX Configuration (Mandatory for all SPI pins)
    my_pinMode(SCK_PIN, MY_OUTPUT);
    my_pinMode(MOSI_PIN, MY_OUTPUT);
    my_pinMode(MISO_PIN, MY_INPUT); // Unlock physical IO MUX for MISO input

    // 3. SPI Matrix Routing and Initialization
    my_spi_pin_routing(SCK_PIN, MOSI_PIN, MISO_PIN, CS_PIN);
    my_spi_init();
}

void loop() {
    uint8_t device_id;

    // Pull CS low to initiate SPI transaction
    my_digitalWrite(CS_PIN, 0);
    
    // Transmit register address (0x0F | 0x80 for read operation) and read response
    my_spi_transfer(0x8F);             
    device_id = my_spi_transfer(0x00); 
    
    // Pull CS high to terminate SPI transaction
    my_digitalWrite(CS_PIN, 1);

    Serial.print("100% Bare-Metal LIS3DH WHO_AM_I: 0x");
    Serial.println(device_id, HEX);
    
    my_delay(1000);
}