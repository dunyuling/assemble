/*int arith(int x, int y, int z)
{
	int t1 = x + y;
	int t2 = z + t1;
	int t3 = x + 4;
	int t4 = y * 48;
	int t5 = t3 + t4;
	int rval = t2 * t5;
	return rval;
}*/

int arith(int x, int y, int z)
{
	int t1 = x*y;
	int t2 = z - t1;
	int t3 = x + 40;
	int t4 = y*2;
	int t5 = t3>>t4;
	int rval = t2 * t5;
	return rval;
}


/*
movl    12(%ebp), %edx    //edx = y
movl    8(%ebp), %ebx     //ebx = x
leal    (%edx,%edx,2), %ecx //ecx = 3*y
addl    %ebx, %edx        // edx = x + y (t1)
addl    16(%ebp), %edx    // edx = z + t1 (t2)
sall    $4, %ecx          //ecx = 3 * y * (2<<4) = y * 48 (t4)
leal    4(%ebx,%ecx), %eax // eax = 4 + x + t4 = t3 + t4 (t5)
imull   %edx, %eax        //exax = t5 * t2   (rval)
*/


/*
int arith(int x, int y, int z)
{
	int t1 = x*y;
	int t2 = z - t1;
	int t3 = x + 40;
	int t4 = y*2;
	int t5 = t3>>t4;
	int rval = t2 * t5;
	return rval;
}


push %ebp
movl %esp, %ebp
movl 8(%ebp), %edx  //edx = x
movl 12(%ebp), %ecx //ecx = y
push %ebx
movl 16(%ebp), %eax //eax = z
movl %edx ,%ebx     //ebx = x
addl $40, %edx      //t3 = x+40 , edx = t3
imull %ecx  , %ebx      // t1 = x*y  ebx = t1
addl %ecx, %ecx     //t4 = y*2 ,ecx = t4
sarl %cl, %edx      //edx >>= cl (cl = t4, edx = t5)
subl %ebx, %eax     //t2=z-t1 ,eax=t2
imull %edx,%eax     //rval=t2*t5 ,eax=rval
popl  %ebx
popl  %ebp
ret
*/