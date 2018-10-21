/*
已知x、y为int类型； 
unsigned int ux = x; unsigned int uy = y.
判断(x>y)==(-x<-y)
*/

#include <stdio.h>

int main() 
{
	int x = -1;
	int y=-2147483648;
	unsigned int ux = x; unsigned int uy = y;
	printf("ux = %ud,uy = %ud\n", ux, uy);
	printf("x= %d,y=%d\n",x, y);
	printf("-x= %d,-y=%d\n",-x, -y);
	return 0;	
}