# ------------------------------------------------------------------------------
# Part 1: Logical (R-type)
# Target:
# 1. Load initial test values:
#    - Set t0 = 0x00FF00FF
#    - Set t1 = 0x12345678
# 2. Complete the tasks using ONLY R-type logical instructions (and, or, xor):
#    - Task 1.1: Use t0 as a mask on t1 so that only bytes 0 and 2 are kept,
#                and bytes 1 and 3 are cleared to 0. Store result in s0.
#    - Task 1.2: Combine t0 and t1 such that any bit set in either appears in s1.
#    - Task 1.3: Toggle (invert) the bits of t1 corresponding to the 1-bits of t0.
#                Store result in s2.
# ------------------------------------------------------------------------------
#define t0 = 0x00FF00FF , t1 = 0x12345678
lui t2, 0x00FF0
lui t3, 0x12345
addi t0, t2, 0x0FF
addi t1, t3, 0x678

#1.1
# 0x 00 FF 00 FF
# 0x 12 34 56 78
# 0x 00 34 00 78(target)
and s0, t0, t1

#1.2
# 0x 00 FF 00 FF
# 0x 12 34 56 78
# 0x 12 FF 56 FF(target)
or s1, t0, t1

#1.3
# 0x 00 FF 00 FF 0000 0000 1111 1111 0000 0000 1111 1111
# 0x 12 34 56 78 0001 0010 0011 0100 0101 0110 0111 1000
# 0x 12 CB 56 87 0001 0010 1100 1011 0101 0110 1000 0111 (target)
xor s2, t0, t1

  

