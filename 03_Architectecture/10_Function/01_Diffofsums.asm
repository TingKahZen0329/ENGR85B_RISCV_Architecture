# --------------------------------------------------------------------------
    # Task 1: Caller Setup
    # Compute: y = diffofsums(2, 3, 4, 5)
    #
    # Formula in function: result = (f + g) - (h + i)
    # With arguments: (2 + 3) - (4 + 5) = 5 - 9 = -4 (0xFFFFFFFC)
    #
    # TODO:
    # 1. Load argument values 2, 3, 4, 5 into a0, a1, a2, a3
    # 2. Call the function diffofsums using 'jal'
    # 3. Save the returned value from a0 into s7 (s7 = y)
    # --------------------------------------------------------------------------
    
# ------------------------------------------------------------------------------
# Task 2: Callee Implementation (diffofsums)
# Arguments:
#   a0 = f, a1 = g, a2 = h, a3 = i
# Return Value:
#   a0 = (f + g) - (h + i)
#
# Constraints & Guidelines:
#   - Use temporary registers (e.g., t0, t1) to compute intermediate sums.
#   - Put the final calculated result into a0.
#   - Return to the caller using 'jr ra'.
# ------------------------------------------------------------------------------
.text
.globl main
main:
addi a0, zero, 2
addi a1, zero, 3
addi a2, zero, 4
addi a3, zero, 5

jal diff0fsums

add s7, zero, a0

li a7, 10
ecall

diff0fsums:
add a0, a0, a1
add a2, a2, a3
sub a0, a0, a2
jr ra
