# ==============================================================================
# Exercise: Construct 32-bit Constant with Sign-Extension Compensation
# 
# Target Constant to Load into register s0:
# Constant = 0x00ABC912
# 1010 1101 1100 1001 0001 0010
# Task 1 (Calculation):
# 1. Split into upper 20 bits and lower 12 bits:
#    - Raw upper 20 bits (hex) = 0x00ABC
#    - Lower 12 bits (hex) = 912
# 2. Check Bit 11 of lower 12 bits:
#    - What is the most significant hex digit of lower 12 bits? 1
#    - Does it cause negative sign-extension (Yes/No)? Yes
# 3. Calculate adjusted upper 20 bits:
#    - Adjusted upper 20 bits = ?
# if bit 11 of lower 12bits is 1,then 0bits of upper 20bits plus 1
#0x00ABD
# 
# Task 2 (Assembly Code):
# Write the exact two instructions to load 0x00ABC912 into register s0:
# ==============================================================================
# Write your answers below:

lui  s0,     0x00ABD
addi s0, s0, -1774 # 912 =1001 0001 0010 =2322 
# -912 =FFFF FFFF FFFF F912 1 001 0001 0010 
# 1111 1111 1111 =4095 +1 4096 statues
# 4096-2322 = 1774 = -1774
# signed -2048~2047 unsigned  0~4095
