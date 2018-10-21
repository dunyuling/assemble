.include "linux.s"
.include "read-record.s"
.include "count-chars.s"
.include "write-newline.s"

.section .data
file_name:
	.ascii "test.dat\0"

.section .bss
	.lcomm record_buffer,RECORD_SIZE

.equ ST_INPUT_DESCRIPTOR,-4 	#These are locations 
.equ ST_OUTPUT_DESCRIPTOR,-8 	#Where we will store the 

.section .text
.globl _start
_start:
	movl %esp,%ebp
	subl $8,%esp	#Allocate space to hold the descriptor
	movl $SYS_OPEN,%eax
	movl $file_name,%ebx
	movl $0,%ecx 	#This says to open read-only
	movl $0666,%edx
	int $LINUX_SYSCALL

	movl %eax,ST_INPUT_DESCRIPTOR(%ebp) #Save file descriptor
	movl $STDOUT,ST_OUTPUT_DESCRIPTOR(%ebp)

record_read_loop:
	pushl ST_INPUT_DESCRIPTOR(%ebp)
	pushl $record_buffer	
	call read_record	#Get one record
	addl $8,%esp
	cmpl $RECORD_SIZE,%eax

	jne finished_reading
	#Otherwise,print out the firstname ,but first, we must know it's size

	pushl $RECORD_FIRSTNAME + record_buffer
	call count_chars
	addl $4,%esp
	movl %eax,%edx
	movl ST_OUTPUT_DESCRIPTOR(%ebp),%ebx
	movl $SYS_WRITE,%eax
	movl $RECORD_FIRSTNAME + record_buffer,%ecx
	int $LINUX_SYSCALL		#Print the firstname

	pushl ST_OUTPUT_DESCRIPTOR(%ebp)
	call write_newline
	addl $4,%esp
	jmp record_read_loop

finished_reading:
	###CLOSE THE FILES###
	movl $SYS_CLOSE,%eax
	movl ST_OUTPUT_DESCRIPTOR(%ebp),%ebx
	int $LINUX_SYSCALL

	###EXIT###
	movl $SYS_EXIT,%eax
	movl $0,%ebx
	int $LINUX_SYSCALL
