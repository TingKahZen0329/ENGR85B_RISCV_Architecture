# ------------------------------------------------------------------------------
# Part 2: String Length Calculation (Byte-level Access & ASCII Null-Check)
# Translate the following C logic into assembly:
#   int len = 0;
#   while (str_data[len] != '\0') {
#       len++;
#   }
#
# Register Mapping:
#   s2 = str_data base address
#   s3 = len (string length accumulator)
#
# Target:
#   - Load address of str_data using 'la s2, str_data'
#   - Calculate byte address: t0 = s2 + len (byte step is 1, no shift needed)
#   - Load unsigned byte: lbu t1, 0(t0)
#   - Exit loop when t1 == 0 (null terminator '\0')
#   - Increment len (s3)
#   - Expected result: s3 = 10 (0x0000000A, because "HELLOWORLD" has 10 letters)
# ------------------------------------------------------------------------------
.data
str_data:   .asciz "HELLOWORLD"

.text
.globl main
main:

la s2, str_data
addi s3, zero, 0

while:
add t0, s2, s3 # char = 1 byte
lbu t1, 0(t0) #  convert char  the number to ASCII 
beq t1, zero, done #/0:exit the program
addi s3, s3, 1# len++
j while

done:
li a7 10
ecall