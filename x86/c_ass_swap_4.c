#include "c_ass_swap_1.c"

long sum = 0;

// 本题目的测试效果跟老师讲解不同
void swap_ele_su(long a[], int i)
{
	swap(&a[i], &a[i+1]);
	sum += a[i];
}