#Open the file
#Attempt to read a record If we are at the end of the file ,exit
#Otherwise, count the characters of the first name 
#Write the firstname to STDOUT
#Write a newline to STDOUT
#Go back to read another record

#INPUT:The address of the chars
#OUTPUT:Returns the count in %eax
.section .text
.type count_chars,@function
.globl count_chars
.equ ST_STRING_START_ADDRESS,8	#stack procedural parameter

count_chars:
	pushl %ebp
	movl %esp,%ebp
	movl $0,%ecx	#Counter starts at zero
	movl ST_STRING_START_ADDRESS(%ebp),%edx	#Starting address of data

count_loop_begin:
	movb (%edx),%al	#Grab the current character
	cmpb $0,%al		#Is it null
	je count_loop_end #If yes, we are done 
	incl %ecx
	incl %edx
	jmp count_loop_begin

count_loop_end:
	movl %ecx,%eax #Move the count into %eax
	popl %ebp
	ret
	