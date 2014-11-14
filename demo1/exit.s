.section .data
.section .text
.global _start
_start:
#完成系统调用后，系统返回的工作状态是保存在ebx中的，可以用echo $?来查看
	movl $1,%eax
	movl $8,%ebx
	int $0x80
