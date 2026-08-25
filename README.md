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