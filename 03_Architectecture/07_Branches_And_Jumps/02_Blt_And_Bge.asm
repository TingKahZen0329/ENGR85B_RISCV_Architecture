# ------------------------------------------------------------------------------
# Part 2: Relational Branching (blt & bge) - Signed Comparison
# Target:
# 1. Set t3 = -5, t4 = 10
# 2. Complete tasks:
#    - Task 2.1: Compare t3 and t4 using blt. Since -5 < 10, branch to label_less.
#                If not less, set s2 = 0.
#                At label_less, set s2 = 100.
#    - Task 2.2: Set t5 = 20, t6 = 20.
#                Compare t5 and t6 using bge. Since 20 >= 20, branch to label_gte.
#                If not greater/equal, set s3 = 0.
#                At label_gte, set s3 = 200.
# ------------------------------------------------------------------------------

addi t3, zero, -5
addi t4, zero, 10

blt t3, t4, label_less
addi s2, zero, 0
j end_task1

label_less:
addi s2, zero, 100

end_task1:
addi t5, zero, 20
addi t6, zero, 20

bge  t5, t6, label_gte
addi s3, zero, 0
j end_task2

label_gte:
addi s3, zero, 200

end_task2:
li a7, 10
ecall