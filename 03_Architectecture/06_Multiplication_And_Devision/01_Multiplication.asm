# ------------------------------------------------------------------------------
# Part 1: Basic Multiplication & Upper Bits Extraction
# Target:
# 1. Load initial values into t0 and t1:
#    - Set t0 = 0x10000000 (Decimal 268435456, a large positive number)
#    - Set t1 = 0x00000010 (Decimal 16)
# 2. Complete tasks using R-type multiplication instructions:
#    - Task 1.1: Calculate t0 * t1 and store the LOWER 32 bits into s0.
#    - Task 1.2: Calculate t0 * t1 and store the UPPER 32 bits into s1.
#    (Hint: The 64-bit full mathematical product is 0x00000001_00000000)
# ------------------------------------------------------------------------------
lui  t0, 0x10000
addi t1, zero, 0x10

mul  s0, t0, t1
mulh s1, t0, t1