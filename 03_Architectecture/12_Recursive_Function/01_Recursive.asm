# ==============================================================================
# RISC-V Recursive Function Practice: Triangular Number (Summation)
# Target Simulator: RARS
#
# Task Overview:
#   Compute the recursive sum of numbers from n down to 1:
#     sum(n) = n + sum(n - 1)
#     Base case: if n <= 1, return n (or 1)
#
#   In main, calculate sum(5):
#     5 + 4 + 3 + 2 + 1 = 15 (0x0F)
# ==============================================================================

.text
.globl main
main:
    # --------------------------------------------------------------------------
    # Task 1: Caller Setup (main)
    #
    # TODO:
    # 1. Initialize s1 = 777 (used to verify s1 is preserved)
    # 2. Pass argument n = 5 into a0
    # 3. Call recursive_sum using 'jal'
    # 4. Save the returned value from a0 into s0 (s0 = result)
    # --------------------------------------------------------------------------

addi s1, zero, 777
addi a0, zero, 5


jal  recursive_sum
add  s0, zero,a0




li   a7, 10
ecall


# ------------------------------------------------------------------------------
# Task 2: Recursive Callee Implementation (recursive_sum)
#
# C Equivalent:
#   int recursive_sum(int n) {
#       if (n <= 1)
#           return n;
#       else
#           return n + recursive_sum(n - 1);
#   }
#
# Constraints & Guidelines:
#   - Because this function calls itself, it is a non-leaf function:
#     you MUST preserve 'ra' on the stack before calling recursive_sum.
#   - 'a0' holds argument n. To do 'n + recursive_sum(n - 1)', the current
#     n must be saved onto the stack before the recursive call.
#   - When returning from recursive_sum, retrieve n into a temporary register
#     (e.g., t1) so you don't overwrite the return value in a0!
#   - Always balance the stack pointer (addi sp, sp, imm) before returning.
# ------------------------------------------------------------------------------
recursive_sum:
# [Write your Prologue here: allocate stack space and save registers]
addi sp, sp, -8
sw a0, 4(sp)
sw ra, 0(sp)



# [Base Case Check: if n <= 1, jump to base_case]
addi t0,zero,1
bgt a0, t0, else

addi a0, zero, 1       
addi sp, sp, 8        
jr   ra 
# [Recursive Case: prepare n - 1, call recursive_sum]
else:
addi a0, a0, -1
jal recursive_sum
               	


# [Post-recursion: restore n into a temporary register (e.g., t1), restore ra]
# [Deallocate stack frame, compute: a0 = t1 + a0, return via 'jr ra']
lw t1, 4(sp)
lw ra, 0(sp) 
addi sp, sp, 8
add  a0, a0, t1
jr ra



