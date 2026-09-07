# ==============================================================================
# RISC-V Pseudoinstruction Disassembly Lab
# Target Simulator: RARS
#
# Task:
# 1. Fill in Task 1 using pseudoinstructions.
# 2. Fill in Task 2 by manually writing the REAL hardware instructions
#    that produce the exact same operations.
# 3. Assemble and compare the "Basic" column in RARS Execute tab.
# ==============================================================================

.text
.globl main
main:
# --------------------------------------------------------------------------
# Task 1: Pseudoinstructions
# --------------------------------------------------------------------------
# TODO 1.1: Use 'li' to load large 32-bit value 0x12345678 into s0
li s0 0x12345678
    
# TODO 1.2: Use 'mv' to copy s0 into s1
mv s1, s0
    
# TODO 1.3: Use 'not' to bitwise-invert s1 and store result in s2
not s2, s1
    
# TODO 1.4: Use 'call' to invoke helper_func
call helper_func
    
# TODO 1.5: Use 'j' to jump to end_program
j end_program





end_program:
li   a7, 10
ecall


# ------------------------------------------------------------------------------
# Helper Function
# ------------------------------------------------------------------------------
helper_func:
addi a0, zero, 42
# --------------------------------------------------------------------------
# Task 2: Real Hardware Equivalent (Do NOT use pseudoinstructions here!)
# --------------------------------------------------------------------------
# TODO 2.1: Write the REAL instruction to do a bitwise-invert (NOT) on s2 into s3
# Hint: xori rd, rs, -1
xori s3, s2, -1    
    
# TODO 2.2: Write the REAL instruction that represents 'nop'
# Hint: addi zero, zero, 0
addi zero, zero, 0   
# TODO 3: Return from function using 'ret'
ret