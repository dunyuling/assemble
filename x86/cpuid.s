.section	.data
output:
			.asciz "The Processor vendor id is '%s'\n"

.section	.bss	#readable,writable and not initialized
			.lcomm	buffer,	12

.section	.text
.globl		_start
_start:
			movl	$0,%eax
			cpuid
			movl	$buffer,%edi
			movl	%ebx,(%edi)
			movl	%edx,4(%edi) #把以下两行注释掉只能输出部分字符
			movl	%ecx,8(%edi)
			push	$buffer
			push	$output
			call	printf
			addl	$8,	%esp
			push 	$0
			call	exit

#第一个可以成功运行的汇编程序
#文件最后一定添加一个空行

#32bit
#成功运行

#64bit
#./cpuid(汇编,链接都成功,但是不能运行),'段错误 (核心已转储)'
