/*
已知x、y为int类型； unsigned int ux = x; unsigned int uy = y.
判断 (x|-x)>>31 == -1
*/
#include <stdio.h>

int main()
{
	int x = 0;
	printf("x=%d,-x=%d\n",x ,-x);
	int r = (x|-x);
	printf("r=%d\n",r);
	r = r>>31;
	printf("r=%d\n",r);
	return 0;
}