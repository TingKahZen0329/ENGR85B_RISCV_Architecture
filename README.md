# ENGR85B_RISCV_Architecture

Coursework and practice code for HarveyMuddX ENGR85B: Digital Design and Computer Architecture.

**Disclaimer / Attribution:**
This repository contains my personal practice code and hardware implementations based on the coursework from HarveyMuddX ENGR85B by Sarah Harris and David Harris.

---

## Learning Log

### 01_Basic
In this module, I explored the foundational concepts of C programming, focusing heavily on how the compiler interacts with system memory at a low level:

* **Signed vs. Unsigned & Overflow:** Investigated the memory boundaries of primitive data types (e.g., `int8_t`, `uint16_t`). Demonstrated how exceeding maximum limits causes overflow (circular memory behavior) and how negative inputs behave under unsigned conditions (underflow).
* **ASCII & Data Representation:** Verified that characters (`char`) are fundamentally stored as integers in memory. Successfully manipulated these underlying integer values (e.g., adding 32) to perform uppercase-to-lowercase conversions.
* **Macros (`#define`):** Practiced using `#define` to establish system-wide constants, making the codebase more readable, maintainable, and easier to modify in the future.