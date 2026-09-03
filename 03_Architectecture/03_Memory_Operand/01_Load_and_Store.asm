# 1. load base address s0 = 0x10010000 
# s0 = '0x'+'10010 ' +  '000'
#lui :a instruction can force the number << 3 
lui s0, 0x10010

# 2. prepare data
addi t2, zero, 42       
addi t3, zero, 99       

# 3. #word0(base address 0x10010000),   word1(address: 0x10010004)    word2(address: 0x10010008)     word3(address: 0x1001000c)
# sw destination, offset(base) 
# The addresses of adjacent Words increment by 4 each time.   +4
#sw = store/write the data in the address 
sw t2, 0(s0)            # store the data in address (s0 + 0) word1
sw t3, 12(s0)          #  store the data in address (s0 + 12) word3

# 4 load the address to read the data
# lw destination, offset(base)
lw t0, 0(s0)            #load address (s0 + 0) to read the data
lw t1, 12(s0)           #load address (s0 + 12) to read the data

li a7, 10      # ecall 10 = exit
ecall