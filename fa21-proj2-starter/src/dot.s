.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int vectors
# Arguments:
#   a0 (int*) is the pointer to the start of v0
#   a1 (int*) is the pointer to the start of v1
#   a2 (int)  is the length of the vectors
#   a3 (int)  is the stride of v0
#   a4 (int)  is the stride of v1
# Returns:
#   a0 (int)  is the dot product of v0 and v1
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 57
# - If the stride of either vector is less than 1,
#   this function terminates the program with error code 58
# =======================================================
dot:

    # Prologue
    addi t0, x0, 1
    blt a2, t0, exit_element
    blt a3, t0, exit_stride
    blt a4, t0, exit_stride

loop_start:
    addi t0, x0, 0 # rep arr1 index
    addi t1, x0, 0 # rep arr2 index
    addi sp, sp, -4
    sw ra, 0(sp)

    addi t2, x0, 0 # rep the elements used compared to a2
    addi t3, x0, 0 # rep ans

loop_continue:
    bge t2, a2, loop_end
    
    mul t0, a3, t2 # striding
    mul t1, a4, t2
    slli t0, t0, 2
    slli t1, t1, 2

    add t0, t0, a0
    add t1, t1, a1
    lw t0, 0(t0)
    lw t1, 0(t1)
    
    mul t0, t0, t1
    add t3, t3, t0

    addi t2, t2, 1

    j loop_continue

loop_end:
    lw ra, 0(sp)
    addi sp, sp, 4
    
    add a0, x0, t3
    
    ret

exit_element:
    li a1, 57
    call exit2

exit_stride:
    li a1, 58
    call exit2
