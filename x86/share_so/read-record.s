.include "record-def.s"
.include "linux.s"
#INPUT:The file descriptor and a buffer
#OUTUT:This function writes the data to the buffer and returns a status code
#stack procedural parameters
.equ ST_READ_BUFFER,8
.equ ST_FILEDES,12

.section .text
.globl read_record
.type read_record @function
read_record:
	pushl %ebp
	movl %esp,%ebp
	pushl %ebx
	movl ST_FILEDES(%ebp),%ebx
	movl ST_READ_BUFFER(%ebp),%ecx
	movl $RECORD_SIZE,%edx
	movl $SYS_READ,%eax
	int $LINUX_SYSCALL

#NOTE:%eax has the return value
	popl %ebx
	movl %ebp,%esp
	popl %ebp
	ret
