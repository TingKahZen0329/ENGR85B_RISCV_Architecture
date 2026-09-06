# ------------------------------------------------------------------------------
# Part 1: If-Else Statement Conversion (Opposite Case Testing)
# Translate the following C logic into assembly:
#   if (i == j)
#       f = g + h;
#   else
#       f = f - i;
#
# Register Mapping:
#   s0 = f, s1 = g, s2 = h, s3 = i, s4 = j
#
# Test Case:
#   Set g = 10, h = 20, f = 50, i = 5, j = 5 (i == j is TRUE)
#   Expected: f = g + h = 30 (0x0000001E)
# ------------------------------------------------------------------------------

addi s0, zero, 50 # f
addi s1, zero, 10 # g
addi s2, zero, 20 # h
addi s3, zero, 5  # i
addi s4, zero, 5  # j

bne s3, s4, Else
add s0, s1, s2
j Done

Else:
sub s0, s0, s3

Done:
li a7, 10
ecall
    
    