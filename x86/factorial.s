.section .text
.globl factorial  #this is unneeded unless we want to share it

.globl _start
_start:
	pushl $4	#The factorial takes one argument-the argument we want a factorial of

	call factorial #run the factorial function
	addl $4,%esp   #restore the stack
	movl %eax,%ebx #factorial returns the answer in %eax,but we want it in %ebx
				   # to send it as our exit status
	
	movl $1,%eax   #call the kernel's exit function
	int $0x80

.type factorial @function
factorial:
	pushl %ebp
	movl %esp,%ebp
	movl 8(%ebp),%eax #This moves the first argument to %eax
	cmpl $1,%eax	  #If the number is 1,that is our base case,and
					  #we simply return(1 is already in %eax as the return value)
	je end_factorial  
	decl %eax       #otherwise ,decrease the value
	pushl %eax	    #push it for our call to factorial
	call factorial  #call itself
	movl 8(%ebp),%ebx #%eax has the return value, so we reload our parameter into %ebx
	imull %ebx,%eax	 #multiply that by the result of the last call to factorial(in %eax);
					 #the answer is stored in %eax

end_factorial:
	movl %ebp,%esp
	popl %ebp
	ret


#对于这个程序,存疑.因为递归时的过程跟c_ass_rfact.s 不一样.
#详细情况请对比这两个程序
