.globl argmax

.text
# =================================================================
# FUNCTION: Given a int vector, return the index of the largest
#	element. If there are multiple, return the one
#	with the smallest index.
# Arguments:
# 	a0 (int*) is the pointer to the start of the vector
#	a1 (int)  is the # of elements in the vector
# Returns:
#	a0 (int)  is the first index of the largest element
# Exceptions:
# - If the length of the vector is less than 1,
#   this function terminates the program with error code 57
# =================================================================
argmax:

    # Prologue
    addi t0, x0, 1
    blt a1, t0, exit
    
    addi sp, sp, -4
    sw ra, 0(sp)

loop_start:
    # t0 rep the MAX INDEX
    addi t0, x0, 0
    
    # t1 rep the MAX NUM
    lw t1, 0(a0)

    # t2 rep the current index to traverse
    addi t2, x0, 0

    # t6...
    addi t6, x0, 0

loop_continue:
    addi t2, t2, 1
    bge t2, a1, loop_end        #bge >= && bgt >
    # t3 rep the ptr, t4 rep the cur num, t6 rep the lens a0 needed to add
    slli t6, t2, 1
    add t3, t6, a0
    lw t4, 0(t3)

    bge t1, t4, loop_continue
    ## if found a smaller num, update t0
    mv t0, t2
    mv t1, t4
    j loop_continue

loop_end:


    # Epilogue
    lw ra, 0(sp)
    addi sp, sp, 4
    add a0, x0, t0

    ret

exit:
    li a1, 57
    call exit2