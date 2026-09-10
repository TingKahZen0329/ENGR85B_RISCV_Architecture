# ==============================================================================
# RISC-V Assembly Lab 1: Signed vs. Unsigned Operations
# Target Simulator: RARS
#
# Task Overview:
#   Implement conditional logic and memory loads demonstrating the difference
#   between signed (blt, lb) and unsigned (bltu, lbu) operations.
#
# Data Setup:
#   A test byte with MSB = 1 (0x8F) is stored in memory.
# ==============================================================================

.data
test_byte: .byte 0x8F       # Bit 7 is 1 (Signed: -113, Unsigned: 143)

.text
.globl main
main:
# --------------------------------------------------------------------------
# Task 1: Branch Comparison (blt vs. bltu)
#
# Given:
#   t1 = 0x80000000 (Signed: -2147483648, Unsigned: 2147483648)
#   t2 = 0x00000001 (Signed: 1,           Unsigned: 1)
#
# TODO:
# 1. Load t1 and t2 with the given values.
# 2. Use 'blt' to compare t1 and t2:
#      If t1 < t2, set s0 = 1, else set s0 = 0.
# 3. Use 'bltu' to compare t1 and t2:
#      If t1 < t2, set s1 = 1, else set s1 = 0.
#
# Expected Results:
#   s0 should be 1 (Signed: -2^31 < 1 is TRUE)
#   s1 should be 0 (Unsigned: 2^31 < 1 is FALSE)
# --------------------------------------------------------------------------

# [Write your Task 1 code here]
lui  t1, 0x80000
addi t2, zero, 1

blt  t1, t2,   lt
addi s0, zero, 0
j afterBlt
lt:
addi s0, zero, 1

afterBlt:
bltu  t1, t2,   ltu
addi  s1, zero, 0
j afterBltu
ltu:
addi  s1, zero, 1 

afterBltu:


# --------------------------------------------------------------------------
# Task 2: Sign-Extension vs. Zero-Extension (lb vs. lbu)
#
# TODO:
# 1. Load the address of 'test_byte' into temporary register t0.
# 2. Use 'lb' to load the byte into s2.
# 3. Use 'lbu' to load the byte into s3.
#
# Expected Results:
#   s2 should be 0xFFFFFF8F (Sign-extended: bit 7 propagates to bit 31)
#   s3 should be 0x0000008F (Zero-extended: bits 31:8 are all zeros)
# --------------------------------------------------------------------------

# [Write your Task 2 code here]

la  t0, test_byte
lb  s2, 0(t0)
lbu s3, 0(t0)


# Exit program (ecall 10)
li a7, 10
ecall