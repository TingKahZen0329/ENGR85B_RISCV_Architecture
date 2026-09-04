# ------------------------------------------------------------------------------
# Part 2: Division and Remainder (Quotient & Modulo)
# Target:
# 1. Load initial values into t2 and t3:
#    - Set t2 = 85
#    - Set t3 = 6
# 2. Complete tasks using R-type division instructions:
#    - Task 2.1: Divide t2 by t3 and store the quotient in s2.
#                (Expected: 85 / 6 = 14)
#    - Task 2.2: Compute the remainder of t2 divided by t3 and store it in s3.
#                (Expected: 85 % 6 = 1)
# ------------------------------------------------------------------------------

addi t2, zero, 85
addi t3, zero, 6

div s2, t2, t3
rem s3, t2, t3