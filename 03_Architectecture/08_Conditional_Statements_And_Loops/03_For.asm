# ------------------------------------------------------------------------------
# Part 3: For Loop with slt Comparison
# Translate the following C logic into assembly:
#   int sum = 0;
#   int i;
#   for (i = 1; i < 101; i = i * 2) {
#       sum = sum + i;
#   }
#
# Register Mapping:
#   s7 = sum, s8 = i
#
# Target:
#   - Initialize s7 = 0, s8 = 1
#   - Use slt to check condition i < 101
#   - Accumulate powers of 2 (1 + 2 + 4 + 8 + 16 + 32 + 64 = 127)
#   Expected: s7 = 127 (0x0000007F), s8 = 128 (0x00000080)
# ------------------------------------------------------------------------------

addi s7, zero, 0
addi s8, zero, 1
addi t0, zero, 101
addi t1, zero, 0
addi t2, zero, 2

For:
slt t1, s8, t0 #if i<101 then t1 is 1,else 0
beq t1, zero, Done # if t1 is no less than 101,then done
add s7, s7, s8 #sum = sum +i
slli s8, s8, 1 #i = i*2
j For 

Done:
li a7, 10
ecall