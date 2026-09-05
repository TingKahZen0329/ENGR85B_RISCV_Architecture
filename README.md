# ENGR85B_RISCV_Architecture

Coursework and practice code for HarveyMuddX ENGR85B: Digital Design and Computer Architecture.

**Disclaimer / Attribution:**
This repository contains my personal practice code and hardware implementations based on the coursework from HarveyMuddX ENGR85B by Sarah Harris and David Harris.

---

## 📑 Table of Contents
* [C Programming](#1-c-programming)
* [Embedded Systems](#2-embedded-systems)
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

<details>
<summary><strong>04_EasyESP32: Custom Hardware Abstraction Layer (HAL)</strong></summary>

Transitioning away from the standard Arduino API to build a reusable, custom Hardware Abstraction Layer (HAL) specifically tailored for the ESP32-C6 RISC-V architecture.
* **Register Encapsulation:** Structured the memory-mapped GPIO registers into a highly readable C `struct`, allowing for intuitive direct memory access without the overhead of standard libraries.
* **Hardware Timer Integration:** Bypassed software-based delay functions by establishing direct pointers to the RISC-V CLINT timer registers (`MTIME` and `MTIMECTL`).
* **Modular Foundation:** Created a unified header file (`EasyESP32.h`) that serves as the bare-metal foundation for all subsequent hardware interfacing projects.
</details>

<details>
<summary><strong>05_Debug_Timer: 160MHz RISC-V System Timer Calibration</strong></summary>

Validating and debugging the internal RISC-V machine timer to ensure microsecond-level accuracy for hardware operations.
* **64-bit Register Access:** Handled the reading of the volatile 64-bit `MTIME` counter to track precise system ticks.
* **Clock Source Calibration:** Calibrated the custom delay loop against the ESP32-C6's internal 160MHz CPU clock, calculating the exact target timestamp (160,000 ticks per millisecond) to achieve flawless, non-blocking hardware delays.
</details>

<details>
<summary><strong>06_Morse_Code: Applied Bare-Metal Timing and GPIO</strong></summary>

A practical application to stress-test the newly developed `EasyESP32` HAL, utilizing precise hardware delays and direct GPIO manipulation.
* **Timing-Critical Execution:** Translated string data into precise physical timing sequences (dots and dashes) based on standard Morse code timing rules.
* **Driver Validation:** Confirmed the absolute stability of the custom memory-mapped GPIO driver and the 160MHz hardware timer in a continuous, rapid-switching execution loop.
</details>

<details>
<summary><strong>07_SPI: 100% Bare-Metal SPI Controller & IO MUX Routing</strong></summary>

The most complex undertaking to date: engineering a complete, bare-metal SPI driver from scratch. This required adapting fundamental SPI concepts (originally studied via the Harvey Mudd ENGR85B curriculum for the SiFive FE310) to the radically different and highly complex ESP32-C6 architecture.
* **IO MUX (Pad Controller) Unlocking:** Decoded and bypassed standard APIs to manually unlock the physical metal pads by writing specific control hex values (e.g., `0x1A02`) directly to the IO MUX registers, overcoming critical hardware-level signal blockages.
* **Internal GPIO Matrix Routing:** Manipulated the ESP32-C6's internal signal router to map SPI state machine signals (`FSPICLK_OUT_IDX`, `FSPID_IN_IDX`, etc.) to arbitrary external pins, bypassing default hardware constraints.
* **State Machine & DMA Bypass:** Configured the official `spi_dev_t` structure to initialize the SPI Master engine, configured proper clock dividers for 1MHz transmission, and explicitly reset DMA FIFO buffers to prevent hardware stalls.
* **Register-Level Data Transfer:** Successfully implemented SPI transaction logic by pushing bytes directly into the `W0` hardware buffer (`data_buf[0]`) and triggering the `CMD_USR` execution bit, ultimately establishing flawless communication with the LIS3DH sensor without any external library dependencies.
</details>

<details>
<summary><strong>08_SPI_Accelerometer: Bare-Metal SPI Data Acquisition</strong></summary>

This project serves as the ultimate validation of the custom ESP32-C6 bare-metal ecosystem, successfully porting an accelerometer interface from a SiFive FE310 architecture to the ESP32-C6 without any external libraries.
* **16-bit SPI Protocol Implementation:** Engineered read and write functions conforming to the LIS3DH 16-bit transaction requirement[cite: 1]. Handled the MSB (RWbar) manipulation to precisely control read (1) and write (0) operations across the SPI bus[cite: 1].
* **Sensor Initialization:** Transmitted configuration bytes to control registers (CTRL_REG1 and CTRL_REG4) via the custom SPI driver to awaken the sensor, enable all three axes, and configure high-resolution block data updates[cite: 1].
* **Bitwise Data Reconstruction:** Retrieved separated 8-bit low and high byte data from the sensor's internal registers[cite: 1]. Reconstructed the original 16-bit two's complement acceleration values using bitwise left-shift (`<< 8`) and bitwise OR (`|`) operations[cite: 1].
* **System Integration:** Flawlessly integrated the custom GPIO matrix routing, 160MHz hardware timer, and SPI state machine into a cohesive, non-blocking data acquisition loop.
</details>

<details>
  <summary><strong>09_MAX7219_Matrix: Hardware Verification and Display Test</strong></summary>

  This project serves as a straightforward hardware test to verify the functionality of the MAX7219 8x8 LED matrix before integrating it into a more complex system.
  * **Hardware Verification:** Implemented basic SPI transmission logic to ensure the MAX7219 matrix powers on, receives data correctly without noise, and physical LEDs are functioning.
  * **Register Configuration:** Directly configured essential internal registers (`MAX_DECODE`, `MAX_SCAN`, `MAX_INTENSITY`) to exit test mode, disable BCD decoding, and control matrix brightness.
</details>

<details>
  <summary><strong>10_BareMetal_Digital_Level: Dual-SPI Bus Integration (Course Lab 8 Equivalent)</strong></summary>

  *Note: This project corresponds to "Lab 8: Digital Level" from the ENGR85B coursework, completely re-engineered and implemented on the ESP32-C6 architecture.*

  The capstone project integrating both the LIS3DH and MAX7219 on a single shared SPI bus to create a functional digital level.
  * **Shared Bus Architecture:** Successfully paralleled the SCK, MOSI, and MISO lines across two distinct peripheral devices operating at different logic levels (3.3V vs 5V).
  * **Independent Chip Select (CS) Logic:** Implemented precise GPIO toggling to selectively target devices, preventing bus collisions during rapid sequential read/write operations.
  * **Coordinate Mapping:** Translated raw physical gravitational data (-8000 to 8000) into constrained 2D grid coordinates (0 to 7) using math mapping functions, rendering real-time physics data onto the LED matrix.
</details>

---

## 3. Architecture

This section focuses on the RISC-V 32-bit Instruction Set Architecture (RV32I)[cite: 1]. It explores low-level assembly programming, register usage conventions, arithmetic logic, and memory hierarchy operations using the RARS (RISC-V Assembler and Runtime Simulator). All source files are located in the `03_Architecture` directory.

<details>
  <summary><strong>01_Instruction: Basic Instruction Execution and Registers</strong></summary>

  Explores fundamental RISC-V assembly instructions and the underlying 32-register architectural state[cite: 1].
  * **Register Architecture:** Introduced standard register naming conventions and roles, including zero (`x0`), temporary registers (`t0`-`t6`), and saved registers (`s0`-`s11`).
  * **Basic Arithmetic Operations:** Implemented foundational arithmetic instructions such as `add` and `sub` for register-to-register data computation[cite: 1].
  * **Execution Flow:** Verified instruction sequencing and register value updates inside the RARS simulation environment.
</details>

<details>
  <summary><strong>02_Operand: Immediate Operands and Register Arithmetic</strong></summary>

  Covers instruction formatting constraints and the integration of immediate constants for arithmetic manipulation[cite: 1].
  * **Immediate Arithmetic:** Implemented `addi` to handle sign-extended constant addition and subtraction without allocating extra registers[cite: 1].
  * **I-Type Instruction Mechanics:** Examined the 12-bit signed immediate limit ($-2048$ to $+2047$) and simulated multi-step arithmetic using pseudo-instructions like `li`[cite: 1].
  * **Environment Control:** Utilized system calls (`ecall` with service code `10`) for controlled and graceful program termination.
</details>

<details>
  <summary><strong>03_Memory_Operand: Byte-Addressable Memory, Load, and Store</strong></summary>

  Demonstrates the interaction between the CPU register file and memory using the standard byte-addressable model.
  * **Byte-Addressable Memory Access:** Applied word-to-byte address translation rules ($4\text{ bytes per word}$, resulting in step increments of $+4$).
  * **Load and Store Operations:** Executed `lw` (Load Word) and `sw` (Store Word) with base-offset addressing (`offset(base)`) to exchange data between registers and data segments.
  * **Large Immediate Construction:** Utilized `lui` (Load Upper Immediate) to construct upper 20-bit aligned base addresses (`0x10010000`) and observed memory manipulation directly via the RARS Data Segment viewer.
</details>

<details>
  <summary><strong>04_Generating_Constants: 32-Bit Constant Synthesis and Sign-Extension Compensation</strong></summary>

  Demonstrates how to manually construct arbitrary 32-bit constants using minimal instruction sequences while accounting for hardware sign-extension side effects.
  * **Instruction Constraints:** Handled the 12-bit signed immediate limit ($-2048$ to $+2047$) of `addi` and the 20-bit upper immediate placement of `lui`[cite: 1].
  * **Sign-Extension Hazard:** Analyzed how negative sign-extension corrupts upper bits when bit 11 of the target lower 12 bits is 1 (e.g., `0x912` sign-extends to `0xFFFFF912`, effectively acting as $-1774$).
  * **Pre-compensation Technique:** Applied the $+1$ offset rule to the upper 20 bits (`0x00ABC + 1 = 0x00ABD`) within `lui` to cancel out negative borrow, successfully synthesizing the full 32-bit value `0x00ABC912` inside register `s0`.
</details>

<details>
  <summary><strong>05_Logical_And_Shift: Bitwise Logic and Shift Operations (R-Type vs I-Type)</strong></summary>

  Explores bitwise manipulation and shift arithmetic in RISC-V across both Register (R-type) and Immediate (I-type) instruction encodings.
  * **Bitwise Logic:** Implemented bit masking with `and`/`andi`, bit field merging with `or`/`ori`, and bit toggling/inverting with `xor`/`xori`[cite: 2].
  * **Logical vs. Arithmetic Shifts:** Evaluated zero-filling behavior in logical shifts (`sll`/`slli`, `srl`/`srli`) versus sign-bit preservation in arithmetic right shifts (`sra`/`srai`)[cite: 2].
  * **Power-of-Two Arithmetic:** Demonstrated arithmetic multiplication by $2^n$ via `slli` and signed division preserving two's-complement negatives via `srai`[cite: 2].
  * **Instruction Encoding Rules:** Analyzed hardware field trade-offs between 3-register R-type formatting and 12-bit signed immediate I-type formatting[cite: 1, 2].
</details>

<details>
  <summary><strong>06_Multiplication_And_Devision: Integer Multiplication, Division, and Remainder (M Extension)</strong></summary>

  Explores signed 32-bit arithmetic operations involving full 64-bit product generation, division quotient, and modulo remainder extraction using R-type instructions.
  * **64-bit Multiplication Separation:** Utilized `mul` to capture the lower 32 bits and `mulh` to extract the signed upper 32 bits of a 64-bit product (`{s1, s0} = t0 * t1`)[cite: 2].
  * **Quotient Extraction:** Implemented signed division with `div` truncating towards zero (`85 / 6 = 14`, stored as `0x0000000E`)[cite: 2].
  * **Modulo Remainder:** Computed integer remainder via `rem` (`85 % 6 = 1`), preserving dividend sign conventions[cite: 2].
  * **Format Consistency:** Verified that all hardware multiplication and division operations conform to 3-register R-type instruction encodings[cite: 1, 2].
</details>

<details>
  <summary><strong>07_Branches_And_Jumps: Conditional Branching, Unconditional Jumps, and Loops</strong></summary>

  Demonstrates program control flow alteration using conditional branches, unconditional jumps, and loop constructs.
  * **Equality Testing:** Implemented conditional decision making using `beq` and `bne` with label-directed control flow.
  * **Relational Branching:** Applied signed relational operators `blt` and `bge` to evaluate positive and two's-complement negative quantities.
  * **Fall-Through Control:** Utilized unconditional jumps (`j`) to bypass alternative branches and prevent sequential instruction fall-through.
  * **Iterative Loop Design:** Constructed an accumulation loop (`1 + 2 + ... + 5 = 15`) managed by counter increments and dynamic conditional branch boundaries.
</details>

---

## 4. Microarchitecture
*This section is currently under construction. It will feature datapath designs, control units, and pipelining implementations.*