# ENGR85B_RISCV_Architecture

Coursework and practice code for HarveyMuddX ENGR85B: Digital Design and Computer Architecture.

**Disclaimer / Attribution:**
This repository contains my personal practice code and hardware implementations based on the coursework from HarveyMuddX ENGR85B by Sarah Harris and David Harris.

---

## 📑 Table of Contents
* [C Programming](#1-c-programming)
* [Embedded Systems](#2-embedded-systems) *(Coming Soon)*
* [Architecture](#3-architecture) *(Coming Soon)*
* [Microarchitecture](#4-microarchitecture) *(Coming Soon)*

---

## 1. C Programming

This section contains foundational C programming concepts, focusing on low-level memory interactions and hardware control. All source codes are located in the `01_C_Programming` directory.

<details>
  <summary><strong>01_Basic: Types, Overflow, and ASCII</strong></summary>
  
  In this module, I explored the foundational concepts of C programming, focusing heavily on how the compiler interacts with system memory at a low level:
  * **Signed vs. Unsigned & Overflow:** Investigated the memory boundaries of primitive data types. Demonstrated how exceeding maximum limits causes overflow and underflow.
  * **ASCII & Data Representation:** Verified that characters (`char`) are fundamentally stored as integers in memory and manipulated them via math operations.
  * **Macros (`#define`):** Practiced using `#define` to establish system-wide constants.
</details>

<details>
  <summary><strong>02_Function: Prototypes, Pass-by-Value, and State Machines</strong></summary>
  
  This module focused on function architecture and memory scoping:
  * **Function Prototypes:** Demonstrated why declaring functions before calling them is strictly required.
  * **Pass by Value vs. Pointers:** Proved that C passes variables by value (copying them) by default. Successfully implemented pointers (`&` and `*`) to bypass this limitation and modify memory by reference.
  * **Mutually Recursive FSM:** Built a simulated Hardware State Machine to prove that function prototypes are unavoidable when two functions call each other.
</details>

<details>
  <summary><strong>03_Operators: The Ultimate C Cheat Sheet</strong></summary>
  
  Consolidated all essential C operators into a single mastery program to understand how the ALU and compiler handle low-level operations:
  * **Unary & Memory:** Differentiated between pre-increment (`++a`) and post-increment (`a++`). Explored Two's Complement hardware logic using bitwise NOT (`~`) and utilized `sizeof()` and type casting.
  * **Logical vs. Bitwise:** Proved the critical difference between boolean logic (`&&`, `||`) and bitwise operations (`&`, `|`, `^`).
  * **Shift & Binary Literals:** Used binary literals (`0b`) and bitwise shift operators (`<<`, `>>`) to simulate hardware register manipulation and efficient math multiplication/division.
  * **Ternary & Assignment:** Implemented ternary operators (`? :`) for compact conditional logic and tested all compound assignment operators (e.g., `<<=`, `&=`, `%=`).
</details>

<details>
  <summary><strong>04_Control_Flow: Conditionals and Switch Statements</strong></summary>
  
  This module covers decision-making structures in C, essential for routing program execution:
  * **If/Else Logic:** Implemented `if`, `else if`, and `else` statements to handle multiple condition branches (e.g., simulating temperature warnings and battery modes).
  * **Switch Statement:** Built a state machine simulator using `switch` cases. Explored the critical "fall-through" trap that occurs when the `break` keyword is omitted.
</details>

<details>
  <summary><strong>05_Loops: Iteration and Hardware Polling</strong></summary>
  
  This module separated the three primary loop structures used for repetitive execution:
  * **While Loop:** Practiced pre-condition checking. Intentionally triggered and escaped an infinite loop by disabling the update condition.
  * **Do-While Loop:** Proved that the block executes at least once before checking the condition, a pattern frequently used for polling hardware sensors.
  * **For Loop:** Utilized block-scoped variables to execute a sequence a predetermined number of times (e.g., simulating LED blinks).
</details>

<details>
  <summary><strong>06_Arrays_and_Strings: Memory Blocks and Null Terminators</strong></summary>
  
  This module explored how C handles contiguous memory blocks and character sequences:
  * **Numeric Arrays & Out-of-Bounds:** Declared, initialized, and iterated through 1D arrays. Verified that C prioritizes performance over safety by intentionally accessing out-of-bounds indices, which yields memory "garbage values" instead of crashing.
  * **The Truth About Strings:** Demonstrated that strings do not exist as a native type in C; they are simply arrays of characters ending with a Null Terminator (`\0`). 
  * **Null Terminator Mechanics:** Used `sizeof()` to prove the compiler automatically appends `\0` to string literals. Successfully truncated a string mid-way by manually inserting a `\0` character.
</details>

<details>
  <summary><strong>07_Structures: Custom Data Types and Typedef</strong></summary>
  
  This module focused on grouping mixed data types into cohesive units, a crucial skill for hardware data management:
  * **Struct Basics:** Defined custom structures (`struct`) to represent complex entities (e.g., a sensor node with an ID, temperature, and status). Practiced member initialization and access using the dot (`.`) operator.
  * **The String Assignment Trap:** Demonstrated that character arrays within structures cannot be directly reassigned using the `=` operator; utilized `strcpy()` from `<string.h>` as the correct approach.
  * **Typedef Aliasing:** Applied the `typedef` keyword to create clean, simplified aliases for structures. This eliminated the need for repetitive `struct` keyword usage, aligning the code with professional industry standards (e.g., `MotorController`).
</details>

<details>
  <summary><strong>08_Memory: Addresses, Stack, and Alignment</strong></summary>
  
  This module explored the physical reality of how variables are stored in the system's memory:
  * **Memory Addresses:** Utilized the address-of operator (`&`) and the `%p` format specifier (casting to `void*`) to reveal the physical hexadecimal addresses of variables.
  * **Stack Behavior & Contiguous Memory:** Verified that arrays are stored in contiguous memory blocks. Observed how local variables are sequentially placed in the Stack, growing from high to low memory addresses.
  * **Memory Padding:** Identified compiler-injected memory padding (wasted bytes) introduced to satisfy hardware alignment requirements, demonstrating the importance of struct/variable declaration order.
</details>

<details>
  <summary><strong>09_Pointers: Direct Memory Manipulation</strong></summary>
  
  This module tackled the core of C's power: pointers and direct memory access.
  * **Pointer Basics:** Mastered the use of pointers to store memory addresses and the dereference operator (`*`) to read or modify values remotely.
  * **Pointer Arithmetic & Arrays:** Proved that arrays do not exist as a native type; they are simply a base pointer to a contiguous block. Demonstrated that adding to a pointer scales automatically by the data type's size.
  * **Struct Pointers:** Used the arrow operator (`->`) as the industry-standard method for accessing structure members via pointers, essential for hardware register manipulation.
  * **Pass-by-Reference:** Bypassed C's default pass-by-value limitation by passing pointers into functions, allowing local modifications to reflect globally.
  * **Advanced Pointers:** Successfully implemented double pointers (`**`) to store pointer addresses, and function pointers to pass executable code blocks as variables.
</details>

<details>
  <summary><strong>10_Memory_Odds_And_Ends: Endianness, Padding, and Multi-D Arrays</strong></summary>
  
  This module covered advanced memory layout concepts critical for hardware-level programming:
  * **Endianness:** Inspected raw memory bytes to determine the system's byte order (Little-Endian architecture).
  * **Struct Padding:** Demonstrated how compilers inject invisible padding bytes to satisfy hardware alignment rules, proving that member declaration order heavily impacts total memory footprint.
  * **Multidimensional Arrays:** Verified that 2D and 3D arrays are fundamentally flattened into strictly contiguous 1D memory blocks, varying the last dimension fastest (Row-Major Order).
</details>

<details>
  <summary><strong>11_Dynamic_Memory: Heap Allocation and Matrix Simulation</strong></summary>
  
  This module shifted focus from the Stack to the OS Heap for runtime memory management:
  * **Malloc and Free:** Utilized `<stdlib.h>` functions to dynamically request memory blocks and strictly return them using `free()` to prevent memory leaks.
  * **Pointer Casting & Safety:** Practiced casting the generic `void*` returned by `malloc` into specific types (e.g., `double*`) and checking for `NULL` allocation failures.
  * **Variable Dimension Matrices:** Successfully simulated a 2D matrix using a dynamically allocated 1D array by calculating indices manually with the formula $j + i \times n$.
</details>

---

## 2. Embedded Systems

This section bridges the gap between low-level software and physical hardware. The projects below are implemented on the **Adafruit ESP32-C6 Feather**, showcasing practical hardware interfacing and modern microcontroller capabilities. All source codes are located in the `02_Embedded_Systems` directory.

<details>
  <summary><strong>01_I2C_Scanner: Hardware Interfacing and Verification</strong></summary>
  
  As the foundational first step in hardware development, this program verifies the physical communication link between the ESP32-C6 (Microcontroller) and the LIS3DH Accelerometer (Peripheral Sensor).
  * **Hardware Wiring:** Established the I2C bus connection using four standard lines: Power (3V), Ground (GND), Data (SDA), and Clock (SCL).
  * **Bus Scanning:** Programmed the ESP32-C6 to continuously scan the entire 7-bit I2C address space (1 to 127) to confirm that the sensor is properly wired, powered, and responsive.
  * **Address Identification:** Successfully detected the LIS3DH sensor at address `0x18` and an on-board battery monitor at `0x36`, proving the hardware communication protocol is functional and ready for data extraction.
</details>

<details>
  <summary><strong>02_LIS3DH_Accelerometer: Sensor Initialization and Data Extraction</strong></summary>
  
  This project advances beyond basic I2C scanning to actual device configuration and data retrieval, extracting 16-bit X, Y, and Z-axis acceleration data from the MEMS sensor.
  * **Register Configuration:** Communicated via I2C to write specific command bytes to the sensor's control registers (e.g., `CTRL_REG1` at `0x20`), waking the device from sleep mode and configuring the data sampling rate.
  * **Bitwise Data Assembly:** Overcame the 8-bit transmission limit of the I2C protocol by reading separated Low and High bytes, then reconstructing the original 16-bit signed integers using bitwise left-shifts (`<< 8`) and OR (`|`) operations.
  * **Physical-to-Digital Verification:** Successfully validated the sensor's functionality by observing the 1G gravitational pull on the Z-axis while resting, connecting physical MEMS mechanics to digital data arrays.
</details>

<details>
  <summary><strong>03_BareMetal_GPIO: Direct Memory-Mapped I/O Control</strong></summary>
  
  This project completely bypasses standard high-level APIs (like Arduino's `digitalWrite`) to control hardware directly using pure C pointers, demonstrating a deep understanding of microcontroller memory architecture.
  * **Pointer Manipulation:** Cast absolute physical memory addresses from the ESP32-C6 Technical Reference Manual to `volatile uint32_t*` pointers, strictly preventing compiler optimizations on hardware registers.
  * **W1TS / W1TC Architecture:** Utilized the modern SoC design pattern of isolated "Write-1-To-Set" and "Write-1-To-Clear" registers, eliminating race conditions without relying on traditional Read-Modify-Write (`|=`, `&= ~`) operations.
  * **Targeted Bit Masking:** Generated dynamic bit masks (e.g., `1 << LED_PIN`) to send precise pulse triggers to hardware gates, toggling specific GPIO pins without disturbing the state of neighboring pins.
</details>

---

## 3. Architecture
*This section is currently under construction. It will cover instruction set architectures (ISA) and assembly language integration.*

---

## 4. Microarchitecture
*This section is currently under construction. It will feature datapath designs, control units, and pipelining implementations.*