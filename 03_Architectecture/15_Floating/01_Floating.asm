# ==============================================================================
# RISC-V Assembly Lab: Floating-Point Operations & Fused Multiply-Add
# Target Simulator: RARS
#
# Task Overview:
# 1. Load single-precision float literals from memory using 'flw'.
# 2. Perform integer-to-float conversion using 'fcvt.s.w'.
# 3. Execute floating-point addition ('fadd.s') and multiply-add ('fmadd.s').
# 4. Store the final floating-point result back to memory using 'fsw'.
# ==============================================================================

.data
val_a:   .float 2.5
val_b:   .float 4.0
val_c:   .float 1.5
res_out: .float 0.0

.text
.globl main
main:
# --------------------------------------------------------------------------
# Task 1: Memory Load and Integer-to-Float Conversion
#
# TODO:
# 1. Load address of 'val_a' into t0, and load its float value into ft0 (flw).
# 2. Load address of 'val_b' into t0, and load its float value into ft1 (flw).
# 3. Load address of 'val_c' into t0, and load its float value into ft2 (flw).
# 4. Load immediate integer 3 into register t1.
# 5. Convert integer in t1 to single-precision float in ft3 using 'fcvt.s.w'.
#
# Expected Results (viewed under RARS "Floating Point" register tab):
#   ft0 = 2.5
#   ft1 = 4.0
#   ft2 = 1.5
#   ft3 = 3.0
# --------------------------------------------------------------------------

# [Write your Task 1 code here]

la t0, val_a
flw ft0, 0(t0)

la t0, val_b
flw ft1, 0(t0)

la t0, val_c
flw ft2, 0(t0)

addi t0,zero,3
fcvt.s.w ft3, t0

# --------------------------------------------------------------------------
# Task 2: Floating-Point Arithmetic and Fused Multiply-Add
#
# Arithmetic formulas:
#   Step A: ft4 = ft0 + ft1
#           ft4 = 2.5 + 4.0 = 6.5
#
#   Step B: ft5 = (ft0 * ft1) + ft2
#           ft5 = (2.5 * 4.0) + 1.5 = 10.0 + 1.5 = 11.5
#           Use 'fmadd.s' instruction: fmadd.s rd, rs1, rs2, rs3
#
#   Step C: Store result of ft5 into 'res_out' using 'fsw'.
#
# TODO:
# 1. Compute ft4 = ft0 + ft1 using 'fadd.s'.
# 2. Compute ft5 = (ft0 * ft1) + ft2 using 'fmadd.s'.
# 3. Load address of 'res_out' into t0, and store ft5 into memory (fsw).
#
# Expected Results:
#   ft4 = 6.5
#   ft5 = 11.5
#   Memory at 'res_out' = 11.5
# --------------------------------------------------------------------------

# [Write your Task 2 code here]

fadd.s ft4, ft0, ft1
fmadd.s ft5, ft0, ft1, ft2

la t0, res_out
fsw ft5, 0(t0)


# Exit program (ecall 10)
li a7, 10
ecall