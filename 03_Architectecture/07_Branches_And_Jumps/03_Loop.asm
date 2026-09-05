# ------------------------------------------------------------------------------
# Part 3: Unconditional Jump & Basic Loop Implementation
# Target:
# 1. Implement a basic loop that calculates the sum of numbers from 1 to 5:
#    - Initialize counter t0 = 1
#    - Initialize accumulator s4 = 0
#    - Loop logic:
#        Add t0 into s4 (s4 = s4 + t0)
#        Increment t0 by 1
#        If t0 <= 5 (can use blt or bge logic), repeat the loop.
#        Otherwise, jump (j) to loop_end.
#    - Expected result: s4 = 1 + 2 + 3 + 4 + 5 = 15 (0x0000000F)
# ------------------------------------------------------------------------------



addi t0, zero, 1
addi t1, zero, 6
addi s4, zero, 0

loop:
add s4, s4, t0 
addi t0, t0, 1

blt t0, t1, loop

li a7, 10
ecall