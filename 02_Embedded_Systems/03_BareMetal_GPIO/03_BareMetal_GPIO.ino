/*
  File: 03_BareMetal_GPIO.ino
  Author: Ting Kah Zen
  Date: 2026-08-28
  Description: Bare-metal LED blink using direct Memory-Mapped I/O pointers.
               Demonstrates W1TS (Write 1 To Set) and W1TC (Write 1 To Clear) 
               hardware register manipulation on the ESP32-C6.
*/

// Define absolute physical memory addresses for ESP32-C6 GPIO registers.
// The 'volatile' keyword strictly prevents the compiler from optimizing these hardware addresses.
volatile uint32_t* MY_GPIO_ENABLE_W1TS_REG = (volatile uint32_t*)0x60091024; // The "Main Gate" to enable output
volatile uint32_t* MY_GPIO_OUT_W1TS_REG    = (volatile uint32_t*)0x60091008; // The "Turn ON" button (Write 1 to set HIGH)
volatile uint32_t* MY_GPIO_OUT_W1TC_REG    = (volatile uint32_t*)0x6009100C; // The "Turn OFF" button (Write 1 to set LOW)

// The built-in red LED on the Adafruit ESP32-C6 Feather is connected to GPIO 15.
const int LED_PIN = 15; 

void setup() {
  // 1. Enable the GPIO pin as an output.
  // Think of this as opening the "Main Gate" for the electrical current.
  // (1 << LED_PIN) creates a "Target Mask" (e.g., 0b...1000000000000000) so we only affect GPIO 15.
  *MY_GPIO_ENABLE_W1TS_REG = (1 << LED_PIN);
}

void loop() {
  // 2. Turn ON the LED.
  // write '1' to the W1TS (Set) register. 
  // This acts like a momentary "Push Button" (a pulse or trigger): it tells the hardware to 
  // pull the pin HIGH, and then the register immediately springs back to 0.
  *MY_GPIO_OUT_W1TS_REG = (1 << LED_PIN);
  
  // Delay for half a second. During this time, no buttons are pushed, so the LED stays ON.
  delay(500);

  // 3. Turn OFF the LED.
  // write '1' to the W1TC (Clear) register.
  // Like the Set button, this also acts as a pulse: it tells the hardware to pull 
  // the pin LOW, and then immediately springs back to 0. Set and Clear never conflict!
  *MY_GPIO_OUT_W1TC_REG = (1 << LED_PIN);
  
  // Delay for half a second. The LED stays OFF.
  delay(500);
}