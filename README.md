# ENGR85B_RISCV_Architecture

Coursework and practice code for HarveyMuddX ENGR85B: Digital Design and Computer Architecture.

**Disclaimer / Attribution:**
This repository contains my personal practice code and hardware implementations based on the coursework from HarveyMuddX ENGR85B by Sarah Harris and David Harris.

---

## Learning Log

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