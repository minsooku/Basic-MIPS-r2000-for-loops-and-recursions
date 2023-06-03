#include <stdio.h>

int l1, w1, l2, w2;
int rect1, rect2;
int result;

int main(void) {
  result= 0;

  scanf("%d", &l1);
  scanf("%d", &w1);
  scanf("%d", &l2);
  scanf("%d", &w2);

  if (l1 < 0 || w1 < 0 || l2 < 0 || w2 < 0)
    result= -2;
  else {
    rect1= l1 * w1;
    rect2= l2 * w2;

    if (rect1 < rect2)
      result= -1;
    else
      if (rect1 > rect2)
        result= 1;
  }

  printf("%d\n", result);

  return 0;
}
