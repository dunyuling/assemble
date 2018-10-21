#/bin/sh
:<<EOF
本文件为生成.c文件的可执行文件的脚本文件,宿主机器为x86_64,包含三个过程
1.编译:从源代码生成相应的汇编代码(.c->.s) ,对应命令gcc
    a.32bit:
        gcc -O2 -S hello.c -m32 -fno-omit-frame-pointer
    b.64bit
        gcc -O2 -S hello.c -fno-omit-frame-pointer
2.汇编:从汇编代码生成相应的目标文件(.s->.o),对应命令as
    a.32bit:
        as -o hello.o hello.s --32
    b.64bit:
        as -o hello.o hello.s
3.链接:从目标文件生成可执行文件(.o->exe),对应命令ld
    a.32bit:
        ld -melf_i386 -dynamic-linker /lib32/ld-linux.so.2 hello.o /usr/lib32/crt1.o /usr/lib32/crti.o /usr/lib32/crtn.o -lc -o hello
    b.64bit:
        ld -dynamic-linker /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 hello.o /usr/lib/x86_64-linux-gnu/crt1.o /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/x86_64-linux-gnu/crtn.o -lc -o hello
EOF

echo '请输入要执行的文件:'
read filename
sub_filename=${filename%.*}
if test -e $filename;then
    echo '如果您想生成x86_32平台的相应代码,请输入32;如果您想生成x86_64平台的相应代码,请输入64:'
    read bits
    #if test $bits -ne 32 -a $bits -ne 64 
    if test $bits -eq 32;then
        echo '将要进行32bit系统上的相关操作'
        gcc -O2 -S $filename -m32 -fno-omit-frame-pointer
	    if test $? -eq 0;then
            echo '编译完成'
            as -o ${sub_filename}.o ${sub_filename}.s --32
    	    if test $? -eq 0;then
    	        echo '汇编完成'
                ld -melf_i386 -dynamic-linker /lib32/ld-linux.so.2 ${sub_filename}.o /usr/lib32/crt1.o /usr/lib32/crti.o /usr/lib32/crtn.o -lc -o ${sub_filename} 
                if test $? -eq 0;then 
                    echo '链接完成'
                    echo '可执行文件'${sub_filename}'生成成功'
                else
                    echo '链接失败'
                fi
            else
                echo '汇编失败'
            fi
        else
	        echo '编译失败'
        fi

    elif test $bits -eq 64;then
        echo '将要进行64bit系统上的相关操作' 
        gcc -O2 -S $filename -fno-omit-frame-pointer
        if test $? -eq 0;then
            echo '编译完成'
            as -o ${sub_filename}.o ${sub_filename}.s	
            if test $? -eq 0;then
                echo '汇编完成'
                ld -dynamic-linker /lib/x86_64-linux-gnu/ld-linux-x86-64.so.2 ${sub_filename}.o /usr/lib/x86_64-linux-gnu/crt1.o /usr/lib/x86_64-linux-gnu/crti.o /usr/lib/x86_64-linux-gnu/crtn.o -lc -o ${sub_filename} 	
                if test $? -eq 0;then                
                    echo '链接完成'
                    echo '可执行文件'${sub_filename}'生成成功'
                else
                    echo '链接失败'
                fi
            else
                echo '汇编失败'
            fi
        else
            echo '编译失败'
        fi
    else
	    echo '期望数值为32或64'
        exit 2
    fi
else
    echo '文件不存在'
fi