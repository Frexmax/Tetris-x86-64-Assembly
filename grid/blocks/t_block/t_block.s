.text
	.globl	tBlockSpawnBlock
    .type	spawnBlock, @function

	.globl	tBlockCheckCanFall
    .type	checkCanFall, @function

	.globl	tBlockCheckCanRotate
    .type	checkCanRotate, @function

	.globl	tBlockCheckCanGoRight
    .type	checkCanGoLeft, @function

	.globl	tBlockFall
    .type	fall, @function

	.globl	tBlockRotate
    .type	rotate, @function

	.globl	tBlockGoRight
    .type	goRight, @function

	.globl	tBlockGoLeft
    .type	goLeft, @function

	.globl	tBlockClearTetrino
    .type	clearTetrino, @function

	.globl	tBlockSetTetrino
    .type	setTetrino, @function


/* 
Initialize a1 (x and y) to a4 for the T block
Set rotation state to 1
*/
tBlockSpawnBlock:
    movq $1, currentState

    # point a1
    movq $4, a1X                        
    movq $19, a1Y                        

    # point a2                            
    movq $5, a2X
    movq $19, a2Y

    # point a3
    movq $6, a3X
    movq $19, a3Y

    # point 4
    movq $5, a4X
    movq $18, a4Y
    ret

/* 
TO DO
*/
tBlockCheckCanFall:
    cmpq $1, currentState
    je tBlockCheckCanFallState1     

    cmpq $2, currentState
    je tBlockCheckCanFallState1     

    cmpq $3, currentState
    je tBlockCheckCanFallState1     

    cmpq $4, currentState
    je tBlockCheckCanFallState1     

    jmp tBlockCheckCanFallInvalidState

    tBlockCheckCanFallState1:
        movq $1, $1
        
        # condition 1 - check if coordinate within the grid 
        movq a4Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl tBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rsi
        getBlockValue
        cmpq $0, %rax
        jg tBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        getBlockValue
        cmpq $0, %rax
        jg tBlockCheckCanFallReturnFalse

        # condition 4 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rsi
        getBlockValue
        cmpq $0, %rax
        jg tBlockCheckCanFallReturnFalse

        jmp tBlockCheckCanFallReturnTrue

    tBlockCheckCanFallState2:
        # condition 1 - check if coordinate within the grid 
        movq a3Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl tBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rsi
        getBlockValue
        cmpq $0, %rax
        jg tBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        getBlockValue
        cmpq $0, %rax
        jg tBlockCheckCanFallReturnFalse

        # condition 4 - not needed, because of tetrino position 

        jmp tBlockCheckCanFallReturnTrue

    tBlockCheckCanFallState3:
        # condition 1 - check if coordinate within the grid 
        movq a1Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl tBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rsi
        getBlockValue
        cmpq $0, %rax
        jg tBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rsi
        getBlockValue
        cmpq $0, %rax
        jg tBlockCheckCanFallReturnFalse

        # condition 4 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        getBlockValue
        cmpq $0, %rax
        jg tBlockCheckCanFallReturnFalse

        jmp tBlockCheckCanFallReturnTrue

    tBlockCheckCanFallState4:
        # condition 1 - check if coordinate within the grid 
        movq a1Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl tBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rsi
        getBlockValue
        cmpq $0, %rax
        jg tBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rsi
        getBlockValue
        cmpq $0, %rax
        jg tBlockCheckCanFallReturnFalse

        # condition 4 - not needed, because of tetrino position 

        jmp tBlockCheckCanFallReturnTrue 

    tBlockCheckCanFallInvalidState:
        movq $-1, %rax
        jmp exitTBlockCheckFall

    tBlockCheckCanFallReturnTrue:
        movq TRUE, %rax
        jmp exitTBlockCheckFall    

    tBlockCheckCanFallReturnFalse:
        movq FALSE, %rax
        jmp exitTBlockCheckFall    

    exitTBlockCheckFall:
        ret
/* 
TO DO
*/
clearTetrino:
    state2:


    ret

/* 
TO DO
*/
setTetrino:
    ret
