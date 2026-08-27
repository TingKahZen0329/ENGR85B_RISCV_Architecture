/*
  File: 01_all_operators_mastery.c
  Author: Ting Kah Zen
  Date: 2026-08-27
  Description: A comprehensive showcase of C language operators, including unary, arithmetic, relational, logical, bitwise, and compound assignment operations.
*/

#include <stdio.h>

int main(void) {
    
  int a  = 3;
  int b  = 3;

  //use a  and  b first ,so print a and b first,and calculate
  printf("after a++ is %d\n",a++);//a = 4
  printf("after b-- is %d\n",b--);//b = 2

  //calclulate first,and a and b
  printf("after --a is %d\n",++a);//a = 5
  printf("after --b is %d\n",--b);//b = 1

  //&a =address of a
  int *x = &a;
  printf("x = &a = %p\n",x);

  //~y = -(y + 1)
  //0000 0101
  //1111 1010
  //because in the left is 1 ,computer know that is negatif number
  //so ~ again 0000 0101
  //and then plus 1,0000 0110
  //plus negatif =-6
  int y = ~a;
  printf("y = ~a = %d\n",y);
  
  //have any  things  = 0
  int z = !b;
  printf("z = !b = %d\n",z); 

  //nothings = 1
  z = !z;
  printf("z = !z = %d\n",z);

  //negatif the number
  y = -a;
  printf("y = -a = %d\n",y); //-5

  //change the variables type
  float f = (float)a;
  printf("f = (float)a = %0.2f\n",f); // 5.00

  //get the size of the a and f
  printf("sizeof (a) =  %d\n" ,sizeof(a)); //4
  printf("sizeof (f) =  %d\n" ,sizeof(f)); //4

  //basic operator
  b = 2;
  printf("a + b = %d\n",(a+b));  //5 + 2 = 7
  printf("a - b = %d\n",(a-b));  //5 - 2 = 3
  printf("a * b = %d\n",(a*b));  //5 * 2 = 10
  printf("a / b = %d\n",(a/b));  //5 / 2 = 2
  printf("a / b = %0.2f\n",((float)a/(float)b)); //5.00 / 2.00 = 2.50
  printf("a %% b = %d\n",(a%b)); //5 % 2 = 1
  printf("a >> b = %d\n",(a>>b)); // 5 >> 2 = 1  0101 =>0001
  printf("a << b = %d\n",(a<<b)); //5 << 2 = 20  0101 => 0001 0100 16+4 =20

  //boolean statement a = 5,b =2
  int judge = (a == b);
  printf("judge statement of (a == b): %s\n", judge ? "true" : "false");

  judge = (a == 5);
  printf("judge statement of (a == 5): %s\n", judge ? "true" : "false");

  judge = (a != b);
  printf("judge statement of (a != b): %s\n", judge ? "true" : "false");

  judge = (a != 5);
  printf("judge statement of (a != 5): %s\n", judge ? "true" : "false");

  //> <do not include the number 
  judge = (a > b);
  printf("judge statement of (a > b): %s\n", judge ? "true" : "false");

  judge = (a > 5);
  printf("judge statement of (a > 5): %s\n", judge ? "true" : "false");

  judge = (a < b);
  printf("judge statement of (a < b): %s\n", judge ? "true" : "false");

  judge = (a < 5);
  printf("judge statement of (a < 5): %s\n", judge ? "true" : "false");

  //>= <= can include the number

  judge = (a >= b);
  printf("judge statement of (a >= b): %s\n", judge ? "true" : "false");

  judge = (a >= 5);
  printf("judge statement of (a >= 5): %s\n", judge ? "true" : "false");

  judge = (a <= b);
  printf("judge statement of (a <= b): %s\n", judge ? "true" : "false");

  judge = (a <= 5);
  printf("judge statement of (a <= 5): %s\n", judge ? "true" : "false");

  printf("a & b = %d\n",(a & b));//and
  printf("a | b = %d\n",(a | b));//or
  printf("a ^ b = %d\n",(a ^ b));//xor

  //bool  0 =false ;have anythings =true
  printf("a && b = %d\n",(a && b));
  printf("a || b = %d\n",(a || b));
  
  //Assignment
  a += 3;
  printf("a += %d\n",a);
  a -= 2;
  printf("a -= %d\n",a);
  a *= 10;
  printf("a *= %d\n",a);
  a /= 3;
  printf("a /= %d\n",a);
  a %= 2;
  printf("a %%= %d\n",a);
  a >>= 2;
  printf("a >>= %d\n",a);
  a <<= 2;
  printf("a <<= %d\n",a);
  a &= 0b11111111;
  printf("a &= %d\n",a);
  a |= 0b11111111;
  printf("a |= %d\n",a);
  a ^= 0b11111111;
  printf("a ^= %d\n",a);
  return 0;
}