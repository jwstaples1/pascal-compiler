#include <stdio.h>

void goo();

int sum100()
{
  int i, s;

  s = 0;
  for (i=1; i<=100; i++)
    s += i;
  return s;  
}

int sumI()
{
  static int up=10;
  int i, s;

  s = 0;
  for (i=1; i<=up; i++)
    s += i;
  up += 10;
  return s;
}

int foo()
{
  unsigned long addr = (unsigned  long) goo;
  printf("input the following two integers, press return after inputing the first number: %d %d\n", (int)addr, (int)(addr>>32)); 
  return 0;
}

void goo()
{
  printf("Your code is hacked. Segmentation fault after this output is expected for some machines!\n");
}
