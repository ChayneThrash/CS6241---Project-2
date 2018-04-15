#include <stdio.h>

int temp = 0;

int main()
{
  int x;
  if (temp == 1)
  {
    x = 1;
  }
  else 
  {
    x = 2;
  }

  while (temp == 0)
  {
    ++temp;
  }

  printf("%d\n", x);

  int y = 0;

  if (temp == 1)
  {
    y = 1;
  }
  else 
  {
    y = 2;
  }

  return 0;


}