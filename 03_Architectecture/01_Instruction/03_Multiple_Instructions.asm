# a = b + c - d
#b = t0, c = t1 ,a = t2,temp = t3 ,d = t4
addi t0, zero, 5
addi t1, zero, 3
addi t4, zero, 2
add  t3, t0, t1
sub  t2, t3, t4