.include "linux.s"

.section .data
newline:
	.ascii "\n"

.section .text
.equ ST_FILEDES,8
.globl write_newline
.type write_newline @function
write_newline:
	pushl %ebp
	movl %esp,%ebp
	movl $SYS_WRITE,%eax
	movl ST_FILEDES(%ebp),%ebx	#File descriptor
	movl $newline,%ecx
	movl $1,%edx
	int $LINUX_SYSCALL

	#Exit
	movl %ebp,%esp
	popl %ebp
	ret
