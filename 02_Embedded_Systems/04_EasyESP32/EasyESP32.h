/*
  File: EasyESP32.h
  Author: Ting Kah Zen
  Date: 2026-08-30 (True Bare-Metal Edition)
  Description: Custom Hardware Abstraction Layer (HAL) for ESP32-C6.
*/

#ifndef EASY_ESP32_H
#define EASY_ESP32_H

#include <stdint.h>
#include <soc/io_mux_reg.h> 
#include <soc/gpio_struct.h> // Include the official GPIO matrix structure definition

#define MY_INPUT  0
#define MY_OUTPUT 1

// ---------------------------------------------------------
// Section 1: GPIO Module
// ---------------------------------------------------------

typedef struct {
    volatile uint32_t dummy;        
    volatile uint32_t out;          
    volatile uint32_t out_w1ts;     
    volatile uint32_t out_w1tc;     
    volatile uint32_t padding[4];   
    volatile uint32_t enable;       
    volatile uint32_t enable_w1ts;  
    volatile uint32_t enable_w1tc;  
} ESP32_GPIO_Regs;

#define ESP32_GPIO ((ESP32_GPIO_Regs*)0x60091000)

void my_pinMode(int pin, int mode) {
    if (mode == MY_OUTPUT) {
        ESP32_GPIO->enable_w1ts = (1 << pin);
        
        // Ensure the GPIO matrix is routed back to simple GPIO output mode.
        // On the ESP32-C6, the SIG_GPIO_OUT_IDX code is fixed at 128.
        GPIO.func_out_sel_cfg[pin].val = 128; 
    } else {
        ESP32_GPIO->enable_w1tc = (1 << pin);
    }

    // Offset correction: The ESP32-C6 IO_MUX registers start at a 0x04 offset.
    // Correct address formula: Base address + 4 (skip CTRL register) + (pin * 4)
    volatile uint32_t* io_mux_reg = (volatile uint32_t*)(DR_REG_IO_MUX_BASE + 4 + (pin * 4));
    *io_mux_reg = 0x00001A02; 
}

void my_digitalWrite(int pin, int val) {
    if (val == 1) {
        ESP32_GPIO->out_w1ts = (1 << pin);
    } else {
        ESP32_GPIO->out_w1tc = (1 << pin);
    }
}

// ---------------------------------------------------------
// Section 2: Hardware Timer Module
// ---------------------------------------------------------

volatile uint32_t* ESP32_MTIMECTL = (volatile uint32_t*)0x20001804; 
volatile uint64_t* ESP32_MTIME    = (volatile uint64_t*)0x20001808; 

void my_timer_init() {
    *ESP32_MTIMECTL |= 1; 
}

void my_delay(uint32_t ms) {
    uint64_t doneTime = *ESP32_MTIME + ((uint64_t)ms * 160000); 
    while (*ESP32_MTIME < doneTime) {}
}

#endif // EASY_ESP32_H