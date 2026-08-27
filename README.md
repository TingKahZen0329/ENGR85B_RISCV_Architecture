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

This section contains foundational C programming concepts, focusing on low-level memory interactions and hardware control. All source codes are located in the `C_Programming` directory.

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

---

## 2. Embedded Systems
*This section is currently under construction. It will contain hardware interfacing and bare-metal programming examples.*

---

## 3. Architecture
*This section is currently under construction. It will cover instruction set architectures (ISA) and assembly language integration.*

---

## 4. Microarchitecture
*This section is currently under construction. It will feature datapath designs, control units, and pipelining implementations.*