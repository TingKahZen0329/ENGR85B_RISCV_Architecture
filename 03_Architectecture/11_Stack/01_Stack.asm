# ==============================================================================
# RISC-V Stack Frame & Calling Convention Practice
# Target Simulator: RARS
#
# Task Overview:
#   Compute: F(a, b) = (a + 1)^2 + (b - 2)^2
#   In main, calculate F(5, 6):
#     Term 1: (5 + 1)^2 = 6^2 = 36
#     Term 2: (6 - 2)^2 = 4^2 = 16
#     Result: 36 + 16 = 52 (0x34)
# ==============================================================================
.text
.globl main
main:
# --------------------------------------------------------------------------
    # Task 1: Caller Setup (main)
    #
    # TODO:
    # 1. Initialize s1 = 1234 (to verify s1 is preserved after the call)
    # 2. Load argument a = 5 into a0, and b = 6 into a1
    # 3. Call func_F using 'jal'
    # 4. Save the returned value from a0 into s0 (s0 = result)
    # --------------------------------------------------------------------------
    
    
addi s1, zero, 1234
addi a0, zero, 5
addi a1, zero, 6

jal func_F
add s0, zero, a0

li a7, 10
ecall


# ------------------------------------------------------------------------------
# Task 2: Non-Leaf Callee Implementation (func_F)
# Arguments:
#   a0 = a, a1 = b
# Returns:
#   a0 = (a + 1)^2 + (b - 2)^2
#
# Constraints & Guidelines:
#   - This function MUST call calc_term twice (non-leaf function).
#   - You MUST preserve 'ra' on the stack before calling calc_term.
#   - You MUST store the result of the first term into register 's1',
#     which means you MUST save s1 to the stack and restore it before returning.
#   - Don't forget to save 'b' on the stack before the first call, because
#     a0 and a1 will be overwritten by calc_term!
# ------------------------------------------------------------------------------
func_F:


   


# [Compute Term 1: call calc_term(a, 1)]
# [Store the returned result from a0 into s1]

#borrow the stack
addi sp, sp, -12
sw  ra, 0(sp)
sw  a1, 4(sp)
sw  s1, 8(sp)

#Assignment and calculate
addi a1, zero, 1
jal calc_term
add s1, zero, a0

#return the stack
lw  a1, 4(sp)



# [Compute Term 2: restore/setup arguments, call calc_term(b, -2)]

 #Assignment and calculate   
add a0, zero, a1
addi a1, zero, -2
jal calc_term

# [Sum Term 1 (s1) and Term 2 (a0), put final answer into a0]
 #Assignment and calculate   
add a0, a0, s1



# [Write your Epilogue here: restore registers and deallocate stack space]
lw  ra, 0(sp)
lw  s1, 12(sp)
addi sp, sp, 12


# Return to main
jr   ra


# ------------------------------------------------------------------------------
# Task 3: Leaf Callee Implementation (calc_term)
# Arguments:
#   a0 = base, a1 = offset
# Returns:
#   a0 = (base + offset)^2
#
# Constraints:
#   - Do NOT modify any s-registers.
#   - Do NOT use the stack (Leaf function).
#   - Return to caller using 'jr ra'.
# ------------------------------------------------------------------------------
calc_term:
add a0, a0, a1
mul a0, a0, a0
jr ra
