.data
array:
	.word 	-4,5,8,-1
msg1:
	.asciiz "\n The sum of the positive values = "
msg2:
	.asciiz "\n The sum of the negative values = "	

.globl main
.text
main:
	li $v0,4		#system call code for print_str
	la $a0,msg1  	#load address of msg1 into $a0
	syscall			#print the string
	la $a0,array	#initial address parameter
	li $a1,4		#initial length parameter
	jal sum			#call sum
	nop
	move $a0,$v0	#move value to be printed to $a0
	li	$v0,1		#system call code for print_int 		
	syscall			#print sum of pos

	li $v0,4		#system call code for print_str
	la $a0,msg2  	#load address of msg2 into $a0
	syscall			#print the string
	li $v0,1		#system call code for print_int 
	move $a0,$v1	#move value to be printed to $a0
	syscall 		#print sum of neg

	li $v0,10 		#terminate program run and return control to system
	syscall

sum:
	li $v0,0		
	li $v1,0 		#initialize v0 and v1 to zero
loop:
	blez $a1,retzz	#if(a1<=0) branch to return
	nop
	addi $a1,$a1,-1 #decrement loop count
	lw	$t0,0($a0)	#get a value from the array
	addi $a0,$a0,4	#increment array pointer to next
	bltz $t0 ,negg	#if value is negative branch to negg
	nop
	add $v0,$v0,$t0	#add to the positive sum 
	b loop 			#branch around the next two instructions

negg:
	add $v1,$v1,$t0	#add to the negative sum
	b loop			#branch to loop
	nop

retzz:
	jr $ra			#return
