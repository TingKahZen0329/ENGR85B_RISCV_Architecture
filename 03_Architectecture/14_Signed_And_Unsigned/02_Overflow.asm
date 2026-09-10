# ==============================================================================
# RISC-V Assembly Lab 2: Multiplication & Overflow Detection
# Target Simulator: RARS
#
# Task Overview:
# 1. Observe how 64-bit multiplication products differ in high-order bits
#    using 'mulh' (signed) and 'mulhu' (unsigned).
# 2. Implement hardware-efficient unsigned overflow detection.
# ==============================================================================

.text
.globl main
main:
# --------------------------------------------------------------------------
# Task 1: Multiplication Upper & Lower Words (mul, mulh, mulhu)
#
# Given:
#   t1 = 0x80000000 (Signed: -2^31, Unsigned: 2^31)
#   t2 = 0xC0000000 (Signed: -2^30, Unsigned: 3 * 2^30)
#
# TODO:
# 1. Load t1 and t2 with the given values.
#    (Hint: you can use 'lui' or 'li')
# 2. Compute the lower 32 bits into s0 using 'mul'.
# 3. Compute the upper 32 bits into s1 using 'mulh'  (Signed).
# 4. Compute the upper 32 bits into s2 using 'mulhu' (Unsigned).
#
# Expected Results:
#   s0 = 0x00000000 (Lower 32 bits are identical for both)
#   s1 = 0x20000000 (Signed: (-2^31) * (-2^30) = +2^61 -> upper bits)
#   s2 = 0x60000000 (Unsigned: (2^31) * (3 * 2^30) = 3 * 2^61 -> upper bits)
# --------------------------------------------------------------------------

li t1, 0x80000000
li t2, 0xC0000000

mul   s0, t1, t2
mulh  s1, t1, t2
mulhu s2, t1, t2




# --------------------------------------------------------------------------
# Task 2: Unsigned Overflow Detection
#
# Arithmetic rule:
#   In unsigned addition (sum = a + b), overflow occurs if and only if
#   sum < a (the sum wraps around).
#
# Test cases:
#   Case A (Overflow):
#     t3 = 0xFFFFFFFF
#     t4 = 0x00000001
#     sum_A = t3 + t4 = 0x00000000 (overflows!)
#
#   Case B (No Overflow):
#     t5 = 0x00000005
#     t6 = 0x00000002
#     sum_B = t5 + t6 = 0x00000007 (no overflow)
#
# TODO:
# 1. For Case A:
#      Compute sum in t0.
#      Check overflow using 'bltu':
#        If overflow occurs, set s3 = 1, else set s3 = 0.
# 2. For Case B:
#      Compute sum in t0.
#      Check overflow using 'bltu':
#        If overflow occurs, set s4 = 1, else set s4 = 0.
#
# Expected Results:
#   s3 = 1 (Overflow detected)
#   s4 = 0 (No overflow)
# --------------------------------------------------------------------------

# [Write your Task 2 code here]
li t3,0xFFFFFFFF
addi t4, zero, 1
addi t5, zero, 5
addi t6, zero, 2

add  t0, t3, t4
bltu t0,t3,overflow_1
addi s3,zero,0
j Test_2
overflow_1:
addi s3,zero,1
Test_2:


add t0, t5, t6
bltu t0,t5,overflow_2
addi s4,zero,0
j Test_3
overflow_2:
addi s4,zero,1
Test_3:




# Exit program (ecall 10)
li a7, 10
ecall