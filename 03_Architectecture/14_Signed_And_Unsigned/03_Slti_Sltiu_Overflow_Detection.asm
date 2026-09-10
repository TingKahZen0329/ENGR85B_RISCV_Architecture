# ==============================================================================
# RISC-V Assembly Lab 3: Signed Overflow Detection & Set Less Than
# Target Simulator: RARS
#
# Task Overview:
# 1. Implement RISC-V signed overflow detection algorithm using 'slti',
#    'slt', and 'bne'.
# 2. Observe the sign-extension quirk of 'sltiu' with negative immediates.
# ==============================================================================

.text
.globl main
main:
# --------------------------------------------------------------------------
# Task 1: Signed Overflow Detection
#
# Algorithm from architecture spec:
#   add t0, t1, t2
#   slti t3, t2, 0        # t3 = 1 if t2 is negative
#   slt  t4, t0, t1       # t4 = 1 if result < t1
#   bne  t3, t4, overflow # overflow if:
#                         #   (t2 is neg & result >= t1) OR
#                         #   (t2 is pos & result < t1)
#
# Test cases:
#   Case A (Positive Overflow: Max positive + 1 becomes negative):
#     t1 = 0x7FFFFFFF (+2147483647)
#     t2 = 0x00000001 (+1)
#     sum_A = t1 + t2 = 0x80000000 (-2147483648, overflows!)
#
#   Case B (No Overflow: Positive + Negative):
#     t5 = 0x7FFFFFFF (+2147483647)
#     t6 = 0xFFFFFFFF (-1)
#     sum_B = t5 + t6 = 0x7FFFFFFE (+2147483646, no overflow)
#
# TODO:
# 1. Test Case A:
#      Compute sum in t0.
#      Apply the 3-instruction detection sequence.
#      If overflow occurs, set s0 = 1, else set s0 = 0.
# 2. Test Case B:
#      Compute sum in t0.
#      Apply the 3-instruction detection sequence.
#      If overflow occurs, set s1 = 1, else set s1 = 0.
#
# Expected Results:
#   s0 = 1 (Signed overflow detected)
#   s1 = 0 (No overflow)
# --------------------------------------------------------------------------
li t1,0x7FFFFFFF
addi t2, zero, 1
add t0, t1, t2
slti t3, t2, 0        # t3 = 1 if t2 is negative
slt  t4, t0, t1       # t4 = 1 if result < t1
bne  t3, t4, overflow_1 # overflow if:
addi s0, zero, 0
j test_2
overflow_1:
addi s0, zero, 1
test_2:

addi t2, zero, -1
add t0, t1, t2
slti t3, t2, 0        # t3 = 1 if t2 is negative
slt  t4, t0, t1       # t4 = 1 if result < t1
bne  t3, t4, overflow_2 # overflow if:
addi s1, zero, 0
j test_3
overflow_2:
addi s1, zero, 1
test_3:






# --------------------------------------------------------------------------
# Task 2: Immediate Sign-Extension with 'slti' vs. 'sltiu'
#
# Key Architectural Concept:
#   RISC-V ALWAYS sign-extends 12-bit immediates, even for 'sltiu'!
#   Immediate -1 (0xFFF) becomes 0xFFFFFFFF (32-bit: 4294967295 in unsigned).
#
# Given:
#   t1 = 0x80000000 (Signed: -2147483648, Unsigned: 2147483648)
#
# TODO:
# 1. Compare t1 with immediate -1 using 'slti' into s2:
#      slti s2, t1, -1
# 2. Compare t1 with immediate -1 using 'sltiu' into s3:
#      sltiu s3, t1, -1
#
# Expected Results:
#   s2 = 1 (Signed: -2147483648 < -1 is TRUE)
#   s3 = 1 (Unsigned: 2147483648 < 4294967295 is TRUE)
# --------------------------------------------------------------------------

# [Write your Task 2 code here]
li t1, 0x80000000
slti s2, t1, -1
sltiu s3, t1, -1



# Exit program (ecall 10)
li a7, 10
ecall