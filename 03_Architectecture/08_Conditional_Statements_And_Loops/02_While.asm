# ------------------------------------------------------------------------------
# Part 2: While Loop Conversion (Exponential Doubling)
# Translate the following C logic into assembly:
#   int pow = 1;
#   int x = 0;
#   while (pow != 64) {
#       pow = pow * 2;
#       x = x + 1;
#   }
#
# Register Mapping:
#   s5 = pow, s6 = x
#
# Target:
#   - Initialize s5 = 1, s6 = 0
#   - Use slli for multiplying by 2
#   - Test opposite case (beq) to exit when pow == 64
#   Expected: s5 = 64 (0x00000040), s6 = 6 (0x00000006)
# ------------------------------------------------------------------------------

addi s5, zero, 1
addi s6, zero, 0
addi t0, zero, 64


while:
slli s5, s5, 1
addi s6, s6, 1
beq  s5, t0, break
j while

break:
li a7, 10
ecall

