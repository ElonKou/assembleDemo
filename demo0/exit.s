# exit program

.section .data
.section .text
.globl _start
_start:
movl $1, %eax           # 系统调用的退出
movl $0, %ebx           # 返回操作系统的状态码

int $0x80               # 唤醒内核， 运行退出命令
