#Open the file
#Write three records
#Close the file

.include "linux.s"
.include "record-def.s"
.include "write-record.s"

.section .data
record1:
	.ascii "Fredrick\0"
	.rept 31 #Padding to 40bytes
	.byte 0
	.endr
	.ascii "Bartlett\0"
	.rept 31 #Padding to 40bytes
	.byte 0
	.endr
	.ascii "4242 S Prairie\nTulsa, OK 55555\0"
	.rept 209 #padding to 240bytes
	.byte 0
	.endr
	.long 45

record2:
	.ascii "Gredrick\0"
	.rept 31 #Padding to 40bytes
	.byte 0
	.endr
	.ascii "Cartlett\0"
	.rept 31 #Padding to 40bytes
	.byte 0
	.endr
	.ascii "5242 S Prairie\nTulsa, OK 55555\0"
	.rept 209 #padding to 240bytes
	.byte 0
	.endr
	.long 55

record3:
	.ascii "Hredrick\0"
	.rept 31 #Padding to 40bytes
	.byte 0
	.endr
	.ascii "Dartlett\0"
	.rept 31 #Padding to 40bytes
	.byte 0
	.endr
	.ascii "6242 S Prairie\nTulsa, OK 55555\0"
	.rept 209 #padding to 240bytes
	.byte 0
	.endr
	.long 65

#This is the name of the file we will write to
file_name:
	.ascii "test.dat\0"	
.equ ST_FILE_DESCRIPTOR, -4
.globl _start
_start:
	movl %esp,%ebp
	subl $4,%esp	#Allocate space to hold the descriptor
	movl $SYS_OPEN,%eax	 
	movl $file_name,%ebx
	movl $0101,%ecx	#This says to create if it doesn't exist, and open for writing
	movl $0666,%edx
	int $LINUX_SYSCALL
	movl %eax,ST_FILE_DESCRIPTOR(%ebp) #store the file descriptor
	pushl ST_FILE_DESCRIPTOR(%ebp) #Write the first record
	pushl $record1
	call write_record
	addl $8,%esp

	pushl ST_FILE_DESCRIPTOR(%ebp)
	pushl $record2
	call write_record
	addl $8,%esp

	pushl ST_FILE_DESCRIPTOR(%ebp)
	pushl $record3
	call write_record
	addl $8,%esp

	###CLOSE THE FILES###
	movl $SYS_CLOSE,%eax
	movl ST_FILE_DESCRIPTOR(%ebp),%ebx
	int $LINUX_SYSCALL

	###EXIT###
	movl $SYS_EXIT,%eax
	movl $0,%ebx
	int $LINUX_SYSCALL
