# ------------------------------------------------------------------------------
# Part 3: Shift (R-type)
# Target:
# 1. Set t3 = 0xF0000010 (A 32-bit negative value)
# 2. Set t4 = 4          (Shift amount register)
# 3. Use ONLY R-type shift instructions (sll, srl, sra):
#    - Task 3.1: Perform a logical left shift on t3 by the amount in t4.
#                Store result in s6.
#    - Task 3.2: Perform a logical right shift on t3 by the amount in t4.
#                Observe whether upper bits become 0. Store result in s7.
#    - Task 3.3: Perform an arithmetic right shift on t3 by the amount in t4.
#                Observe sign extension (preserving negative bits). Store in s8.
# ------------------------------------------------------------------------------

lui t0, 0xF0000
addi t3, t0, 0x010
addi t4, zero, 4
#0000 0100
sll s6, t3, t4

#0F00 0001
srl s7, t3, t4

#FF00 0001
sra s8, t3, t4
    