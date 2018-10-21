void swap_a(long *xp, long *yp)
{
	volatile long loc[2];
	loc[0] = *xp;
	loc[1] = *yp;
	*xp = loc[1];
	*yp = loc[0];
}