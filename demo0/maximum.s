# find maximum element

# %edi - 保存正在检测的数据索引
# %ebx - 当前找到的最大数据项
# %eax - 当前比较的数据项
# 
# data_items - 数据项目，0表示数据结束

.section .data
data_items:
.long 3, 100, 34, 23, 12, 43, 99, 12, 2, 1, 89, 0

.section .text
.globl _start

_start:
movl $0, %edi                       # 
movl data_items(,%edi,4), %eax      # 最大值
movl %eax, %ebx                     # 设置最大值

start_loop:
cmpl $0, %eax                       # 检查结束标志
je loop_exit                        # 等于0时候退出
incl %edi                           # 自增序号
movl data_items(,%edi,4), %eax      # 拿到需要对比的数据放到%eax
cmpl %ebx, %eax                     # 比较
jle start_loop                      # %ebx <= %eax，之后跳转继续
movl %eax, %ebx                     # 否则移动数据到%eax
jmp start_loop                      # 继续循环

loop_exit:
movl $1, %eax                       # 设置退出的系统调用符号，此时ebx保存最大值，并且返回没问题
int $0x80                           # 系统调用
