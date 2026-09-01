/*
  File: EasyESP32_SPI.h
  Author: Ting Kah Zen
  Date: 2026-08-31
  Description: Custom Hardware Abstraction Layer (HAL) for ESP32-C6 SPI controller. 
               Configures IO MUX routing, SPI matrix, and handles direct register-level 
               data transmission, bypassing standard API overhead.
*/

#ifndef EASY_ESP32_SPI_H
#define EASY_ESP32_SPI_H

#include <stdint.h>
#include <soc/gpio_sig_map.h> 
#include <soc/gpio_struct.h>
#include <soc/spi_struct.h> // Include official SPI structure definitions to ensure accurate register addressing.
#include <soc/spi_reg.h>    // Required for the DR_REG_SPI2_BASE macro.
#include <hal/spi_ll.h>

// Cast the physical base address to the official SPI device structure pointer.
#define SPI2_DEV ((volatile spi_dev_t *)(DR_REG_SPI2_BASE))

// =========================================================
// 1. GPIO Matrix Routing Definitions
// =========================================================
#define SPI2_SCK_OUT_IDX  FSPICLK_OUT_IDX
#define SPI2_MOSI_OUT_IDX FSPID_IN_IDX   // Note: The ESP32-C6 routes MOSI (Output) using an "IN" index.
#define SPI2_MISO_IN_IDX  FSPIQ_OUT_IDX  // Note: The ESP32-C6 routes MISO (Input) using an "OUT" index.

void my_spi_pin_routing(int sck_pin, int mosi_pin, int miso_pin, int cs_pin) {
    // Configure output routing for SCK and MOSI.
    GPIO.func_out_sel_cfg[sck_pin].val = SPI2_SCK_OUT_IDX;
    GPIO.func_out_sel_cfg[mosi_pin].val = SPI2_MOSI_OUT_IDX;

    // Configure input routing for MISO and force the signal through the matrix.
    GPIO.func_in_sel_cfg[SPI2_MISO_IN_IDX].sig_in_sel = 1; 
    GPIO.func_in_sel_cfg[SPI2_MISO_IN_IDX].in_sel = miso_pin;
}

// =========================================================
// 2. SPI State Machine Initialization
// =========================================================
void my_spi_init(void) {
    // 1. Wake up the hardware (enable bus clock and reset the peripheral using LL functions).
    spi_ll_enable_bus_clock(SPI2_HOST, true);
    spi_ll_reset_register(SPI2_HOST);
    spi_ll_enable_clock(SPI2_HOST, true);

    // 2. Inject verified baseline parameters for stable SPI operation.
    SPI2_DEV->ctrl.val     = 0x00000000;
    SPI2_DEV->user.val     = 0x18000001; 
    SPI2_DEV->user1.val    = 0x00000000;
    SPI2_DEV->misc.val     = 0x00000000; 
    SPI2_DEV->clk_gate.val = 0x00000007; 
    SPI2_DEV->clock.val    = 0x00243002; // Configures the clock divider for 1MHz on the ESP32-C6.
    SPI2_DEV->dma_conf.val = 0x00000003; // Maintains the DMA FIFO in a ready state to prevent stalls.

    // 3. Trigger a hardware configuration update.
    SPI2_DEV->cmd.update = 1;
    while (SPI2_DEV->cmd.update != 0) {}
}

// =========================================================
// 3. SPI Transfer Function (ESP32-C6 specific implementation)
// =========================================================
uint8_t my_spi_transfer(uint8_t data_out) {
    // 1. Set the transmission length.
    // The ESP32-C6 consolidates TX and RX lengths into ms_data_bitlen.
    // The hardware requires (length_in_bits - 1), so 7 represents 8 bits.
    SPI2_DEV->ms_dlen.ms_data_bitlen = 7; 

    // 2. Write the outgoing data to the W0 buffer.
    SPI2_DEV->data_buf[0].val = data_out;

    // 3. Apply the configuration update.
    SPI2_DEV->cmd.update = 1;
    while (SPI2_DEV->cmd.update != 0) {}

    // 4. Trigger the SPI transfer (USR bit).
    SPI2_DEV->cmd.usr = 1;
    while (SPI2_DEV->cmd.usr != 0) {}

    // 5. Return the lowest 8 bits from the W0 buffer after completion.
    return (uint8_t)(SPI2_DEV->data_buf[0].val & 0xFF);
}

#endif // EASY_ESP32_SPI_H