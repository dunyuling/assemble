int logical(int x, int y)
{
	int t1 = x^y;
	int t2 = t1 >> 17;
	int mask = (1<<13) - 7;
	int rval = t2 & mask;
	return rval;
}


/*
movl    12(%ebp), %eax   //eax = y
xorl    8(%ebp), %eax   //eax = x ^ y (t1)
sarl    $17, %eax       //eax = t1 >> 17 (t2)
andl    $8185, %eax     //eax = 8185 & t2 (rval)
*/