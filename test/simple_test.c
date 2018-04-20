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

  int y = 0;

  if (temp == 1)
  {
    y = 1;
  }
  else 
  {
    y = 2;
  }

  x + x;

  int z = 1;
  if (temp == 3)
  {
    z = 3;
  }
  else
  {
    z = 4;
  }

  y + y;

  return 0;


}
