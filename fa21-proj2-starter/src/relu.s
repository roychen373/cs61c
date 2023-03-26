.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
# 	a0 (int*) is the pointer to the array
#	a1 (int)  is the # of elements in the array
# Returns:
#	None
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 57
# ==============================================================================
relu:
    # Prologue
    addi t0, x0, 1
    blt a1, t0, exceptions
    # why not save a0 or a1, cuz no return, and maybe some func will call "relu", 
    # so we are expected, to save ra, and 真tm难打中文 in ubuntu VMware
    addi sp, sp, -4
    sw ra, 0(sp)

loop_start:
    #设置t0表示判断数组是否越界
    addi t0, x0, 0
    #设置t1表示数组递增的下标
    addi t1, x0, 0
loop_continue:
    bgt t0, a1, loop_end

    #其中t2为当前指向a[j]的指针，t3代表当前(*ptr--->a[j])[0]的值
    add t2, a0, t1
    #这里只能用load指令来读取指针指向的值
    lw t3, 0(t2)

    #自增
    addi t0, t0, 1
    slli t1, t0, 2

    bgt t3, x0, loop_continue
    #这里只能用save指令来改变指针指向的值
    sw x0, 0(t2)

    j loop_continue

loop_end:
    # Epilogue
    lw ra, 0(sp)
    addi sp, sp, 4

	ret

exceptions:
    #Exceptions: Wrong length  
    li a1, 57
    call exit2