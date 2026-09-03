# ------------------------------------------------------------------------------
# Part 2: Logical (I-type)
# Target:
# 1. Set t2 = 0x00000ABC
# 2. Use ONLY I-type logical instructions (andi, ori, xori):
#    - Task 2.1: Extract only the lowest 4 bits (nibble) of t2 using an immediate
#                mask. Store result in s3. (Expected: 0x0000000C)
#    - Task 2.2: Force bit 8 of t2 to become 1 without changing other bits.
#                Store result in s4.
#    - Task 2.3: Invert the lowest 8 bits of t2 using a single immediate instruction.
#                Store result in s5.
# ------------------------------------------------------------------------------


lui t0, 0x00001
addi t2, t0, -1348

#2.1
# 0x 00 00 0A BC
# 0x 00 00 00 0C(target)
andi s3, t2, 0x0000000F

#2.1
# 0x 00 00 0A BC
# 0x 00 00 0B BC(target)
ori s4, t2, 0x00000100

#2.1
# 0x 00 00 0A BC 1010 1011 1100 
# 0x 00 00 0A 0C 1010 0100 0011(target) 
xori s5, t2, 0x000000FF
    
    