/*
int accum = 1;
s_helper(5, &accum);
*/
void s_helper(int x, int *accum)
{
	if(x<=1)
	{
		return;
	}
	else 
	{
		int z = *accum * x;
		*accum = z;
		s_helper(x-1, accum);
	}
}