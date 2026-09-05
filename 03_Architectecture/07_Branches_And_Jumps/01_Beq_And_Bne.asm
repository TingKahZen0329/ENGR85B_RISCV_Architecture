# ------------------------------------------------------------------------------
# Part 1: Equality Branching (beq & bne)
# Target:
# 1. Set t0 = 12, t1 = 12, t2 = 15
# 2. Complete tasks:
#    - Task 1.1: Compare t0 and t1 using beq. If equal, branch to label_equal.
#                If not equal, set s0 = 0.
#                At label_equal, set s0 = 1.
#    - Task 1.2: Compare t0 and t2 using bne. If not equal, branch to label_diff.
#                If equal, set s1 = 0.
#                At label_diff, set s1 = 1.
# ------------------------------------------------------------------------------

addi t0, zero, 12
addi t1, zero, 12
addi t2, zero, 15

beq t0, t1, label_equal
addi s0, zero, 0
j end_task1

label_equal:
addi s0, zero, 1

end_task1:
bne t0, t2, label_diff
addi s1, zero, 0
j end_task2

label_diff:
addi s1, zero, 1

end_task2:
li a7, 10             
ecall #exit the program