.text
.global _start

_start:
	popl %ecx	#argc
vnext:
	popl %ecx   #argv
	test %ecx, %ecx
	jz exit
	movl %ecx,%ebx
	xorl %edx,%edx
strlen:
	movb (%ebx),%al
	inc  %edx
	inc  %ebx
	test %al,%al
	jnz  strlen
	movb $10, -1(%ebx)
	movl $4,  %eax
	movl $1,  %ebx
	int  $0x80
	jmp  vnext


exit:
	movl $1,%eax  #syscall(sys_exit)
	xorl %ebx,%ebx #
	int $0x80

#只能在32bit下运行成功