# ==============================================================================
# RISC-V Register Quick Reference (32-bit Architecture)
# ==============================================================================
# Name    | Number  | Description / Conventional Usage
# --------+---------+-----------------------------------------------------------
# zero    | x0      | Constant value 0 (hardwired)[cite: 2]
# ra      | x1      | Return address for function calls[cite: 2]
# sp      | x2      | Stack pointer (points to the top of stack)[cite: 2]
# gp      | x3      | Global pointer[cite: 2]
# tp      | x4      | Thread pointer[cite: 2]
# t0-t2   | x5-x7   | Temporaries (intermediate values, caller-saved)[cite: 2]
# s0/fp   | x8      | Saved register / Frame pointer[cite: 2]
# s1      | x9      | Saved register (variables, callee-saved)[cite: 2]
# a0-a1   | x10-x11 | Function arguments / Return values[cite: 2]
# a2-a7   | x12-x17 | Function arguments[cite: 2]
# s2-s11  | x18-x27 | Saved registers (variables, callee-saved)[cite: 2]
# t3-t6   | x28-x31 | Temporaries (intermediate values, caller-saved)[cite: 2]
# ==============================================================================

# x = y - z;
# x = s0, y = s1, z = s2
addi s1, zero, 100
addi s2, zero, 34
sub  s0, s1,   s2 