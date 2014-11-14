
.section .data
arr:
	.long 20,30,40,50,100,99,250,0 #这里最大值只能是255，如果使用更大的值，结果会不是预期的值

.section .text
.global _start

_start:
	movl $0,%ebx   #使用ebx作为索引i index
	movl arr(,%ebx,8),%eax #使用eax 代表arr[index]
	
	movl %eax,%ecx #使用ecx保存最大的值
foreach:
	cmpl $0,%eax  #使用0和arr[index]比较，确定是不是最后一个
	je exit
	
	incl %ebx #i++
	movl arr(,%ebx,4),%eax #不仅要递增索引，更重要的是递增索引的引用对象




	cmpl %ecx,%eax
	jle foreach


	movl  %eax,%ecx #如果arr[index]最大，就把他的值赋值给ecx
	jg foreach

#jg jge jl jle 这个跳转指令的操作数只能是地址（在这里就是标签）
#便签声明的必须以：结尾，但是使用的适合，可以直接使用
#注意这里不是var a = 1 而是 = 1 a的形式，也就是第二个操作数才是变量

exit:
	movl %ecx,%ebx #放在ebx中是为了能够让echo $?访问到
	movl $1,%eax #使用退出系统调用调用号
	int  $0x80 #执行系统调用


