#!/usr/bin/python
#python version : 3.7.0

import os

"""
本文件为生成.s文件的可执行文件的脚本文件,宿主机器为x86_64,包含两个过程
1.汇编:从汇编代码生成相应的目标文件(.s->.o),对应命令as
    a.32bit:
        as -o hello.o hello.s --32
    b.64bit:
        as -o hello.o hello.s
2.链接:从目标文件生成可执行文件(.o->exe),对应命令ld
    a.32bit:
        ld -melf_i386 -dynamic-linker /lib32/ld-linux.so.2 hello.o /usr/lib32/crti.o /usr/lib32/crtn.o -lc -o hello
    b.64bit:
        ld -dynamic-linker /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 hello.o /usr/lib/x86_64-linux-gnu/crt1.o /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/x86_64-linux-gnu/crtn.o -lc -o hello  
"""

response = input('请输入要执行的文件:')
exists = os.path.isfile(response)
if not exists:
	print('文件不存在');
else:
	sub_filename = response[0:response.rindex('.')]	
	response = input('如果您想生成x86_32平台的相应代码,请输入32;如果您想生成x86_64平台的相应代码,请输入64:')
	if response == str(32):
		print('将要进行32bit系统上的相关操作')
		res = os.system('as -o %s.o %s.s --32' % (sub_filename,sub_filename))
		if res != 0:
			print('汇编失败')
		else:
			print('汇编完成')
			res = os.system('ld -melf_i386 -dynamic-linker /lib32/ld-linux.so.2 %s.o /usr/lib32/crti.o /usr/lib32/crtn.o -lc -o %s' % (sub_filename, sub_filename))
			if res != 0:
				print('链接失败')
			else:
				print('链接完成')
				print('可执行文件 %s 生成成功' % (sub_filename))	
			

	elif response == str(64):
		print('将要进行32bit系统上的相关操作')
		res = os.system('as -o %s.o %s.s ' % (sub_filename,sub_filename))
		if res != 0:
			print('汇编失败')
		else:
			print('汇编完成')
			res = os.system('ld -dynamic-linker /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 %s.o /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/x86_64-linux-gnu/crtn.o -lc -o %s' % (sub_filename, sub_filename))
			if res != 0:
				print('链接失败')
			else:
				print('链接完成')
				print('可执行文件 %s 生成成功' % (sub_filename))		
			

	else:
		print('期望数值为32或64')
