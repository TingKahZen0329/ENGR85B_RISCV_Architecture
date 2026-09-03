# ------------------------------------------------------------------------------
# Part 4: Shift (I-type)
# Target:
# 1. Set t5 = 0x00000005 (Decimal 5)
# 2. Set t6 = -32        (A negative decimal number)
# 3. Use ONLY I-type shift instructions (slli, srli, srai):
#    - Task 4.1: Multiply t5 by 8 using a single left shift immediate instruction.
#                Store result in s9. (Hint: 8 = 2^3)
#    - Task 4.2: Divide t6 by 4 using an arithmetic right shift immediate instruction
#                to ensure the quotient remains negative. Store result in s10.
# ------------------------------------------------------------------------------

addi t5, zero, 0x005
addi t6, zero, -32

# 5 << 3 = 40 
#0101 => 101000 =8+32 =40
slli s9,  t5, 3

#-32 >> 2 =- 8
#1010 0000 =>1110 1000=>-32
srai s10, t6, 2


    