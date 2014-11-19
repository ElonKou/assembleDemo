.section .data


.section .text 
.code32
#从这里开始执行的是方法
#计算2^3的函数
.type power, @function
power: 
	pushl %ebp #ebp是栈的基址，如同是数组的0位置，是谁调用的这个值就是谁提供的，所以对于_start他的ebp就是操作系统提供的
	movl  %esp,%ebp #esp是栈顶的位置，对于被调用的函数就是当前的指针，或者说就是你现在的位置的地址
	#到此通过ebp可以确定上一个方法的一端，通过esp可以确定另一端，而两点之间的部分是线性的，所以到此就算完整的保存了父环境的上下文
	subl $4 ,%esp #移动当前位置向下增长一个字节，用来作为临时变量使用
	
	movl 8(%ebp),%ebx #把第一个变量保存在ebx中
	movl 12(%ebp) ,%ecx #吧第二个变量保存在ecx中
	#之所以是从ebp上访第8个位开始而不是从第4个开始，是因为第4个位保存的是power符号的地址，是用作返回使用的地址，将来的ret就是返回到这个位置的
	

	movl %ebx,-4(%ebp) #-4(%ebp)就是刚才执行subl $4,%esp申请的局部变量，在高级语言就直接可以用var a 来操作，这里必须数数

loop:#这里不影响上面的逻辑顺下来，这里声明符号只是为了在后面使用循环的
	
	cmpl $1, %ecx  #表示3个2相乘的3个 用来计数的
	je return
	
	subl $1 ,%ecx #i--
	
	movl -4(%ebp),%eax #把局部变量的值转移到寄存器eax中
	imull %ebx,%eax #好像imull操作要求两个操作数，必须都是在寄存器中的，所以这里把局部变量的值取出来放入寄存器后，又进行的操作
	movl %eax,-4(%ebp) #吧寄存器中计算好的值写入到局部变量中
	
	jmp loop #for循环

return:
	movl -4(%ebp),%eax #把最终结果写入到eax中，这里其实eax里的值就是和局部变量中的值是相等的， 这里在写一下起到显式声明的作用
	movl %ebp ,%esp #把当前位置编程栈开始的位置
	popl %ebp #弹出值放入%ebp中，这个值就是之前保存的pushl %ebp的作用就是保存%ebp
	ret 


.global _start

_start: #main函数

	pushl $3
	pushl $2
	call power
	addl $8 ,%esp #栈平衡
	
	movl %eax,%ebx
	movl $1,%eax
	int $0x80
	

