# ------------------------------------------------------------------------------
# Part 1: Integer Array Traversal & Modification (Word-level Access)
# Translate the following C logic into assembly:
#   int i;
#   for (i = 0; i < 5; i++) {
#       int_array[i] = int_array[i] * 8;
#   }
#
# Register Mapping:
#   s0 = int_array base address
#   s1 = loop counter (i)
#   t2 = boundary limit (5)
#
# Target:
#   - Load address of int_array using 'la s0, int_array'
#   - Multiply offset: t0 = i * 4 (use 'slli t0, s1, 2')
#   - Add base address: t0 = t0 + s0
#   - Load word: lw t1, 0(t0)
#   - Multiply value by 8: t1 = t1 * 8 (use 'slli t1, t1, 3')
#   - Store word: sw t1, 0(t0)
#   - Expected in Data Segment: 24, 40, 64, 96, 160
#     Hex: 0x00000018, 0x00000028, 0x00000040, 0x00000060, 0x000000A0
# ------------------------------------------------------------------------------
.data
int_array:  .word 3, 5, 8, 12, 20

.text                 #change back the text
.globl main
main:
la  s0, int_array#get the int_array address
addi s1, zero, 0 #count
addi t2, zero, 5 #limit


for:
slt t3, s1,   t2 # t3 = 1 if (s1<t2) else t3 = 0
beq t3, zero, done

slli t0, s1, 2 # offset = i * 4
add  t0, t0, s0 # base address + offset

lw t1, 0(t0) #t1 =int_array[i]
slli  t1, t1, 3#t1 =t1 << 3 (*8)
sw t1, 0(t0)#int_array[i] = t1

addi s1, s1, 1# i++
j for

done:
li a7 10
ecall


