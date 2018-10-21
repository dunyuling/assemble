#include "c_ass_swap_1.c"

// long scount = 0;

// 本题目的测试效果跟老师讲解不同
void swap_ele_se(long a[], int i)
{
	swap(&a[i], &a[i+1]);
	// scount++;
}