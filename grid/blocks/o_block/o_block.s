.text
	.globl	oBlockSpawnBlock
    .type	oBlockSpawnBlock, @function

	.globl	oBlockCheckCanFall
    .type	oBlockCheckCanFall, @function

	.globl	oBlockCheckCanRotate
    .type	oBlockCheckCanRotate, @function

	.globl	oBlockCheckCanGoRight
    .type	oBlockCheckCanGoRight, @function

    .globl oBlockCheckCanGoLeft
    .type oBlockCheckCanGoLeft, @function

	.globl	oBlockRotate
    .type	oBlockRotate, @function

	.globl	oBlockClearTetrino
    .type	oBlockClearTetrino, @function

	.globl	oBlockSetTetrino
    .type	oBlockSetTetrino, @function


/* 
Initialize a1 (x and y) to a4 for the T-block
Set rotation state to 1
@return - rax - TRUE (1) spawn possible, FALSE (0) spawn impossible - game over
*/
oBlockSpawnBlock:
    movq $1, currentState

    # point a1
    movq $4, a1X                        
    movq $19, a1Y                        

    # point a2                            
    movq $5, a2X
    movq $19, a2Y

    # point a3
    movq $4, a3X
    movq $18, a3Y

    # point 4
    movq $5, a4X
    movq $18, a4Y
                                        
    call oBlockCheckCanFall                   # check if fall possible, if not, game over
    ret

oBlockSetInfoPoint:
    # point a1
    movq $12, infoA1X                        
    movq $17, infoA1Y                        

    # point a2                            
    movq $13, infoA2X
    movq $17, infoA2Y

    # point a3
    movq $12, infoA3X
    movq $16, infoA3Y

    # point 4
    movq $13, infoA4X
    movq $16, infoA4Y
    ret

/* 
Returns TRUE if T-block can fall, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
oBlockCheckCanFall:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je oBlockCheckCanFallState1     
 
    jmp oBlockCheckCanFallInvalidState

    oBlockCheckCanFallState1:        
        # condition 1 - check if coordinate within the grid 
        movq a3Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl oBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne oBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne oBlockCheckCanFallReturnFalse

        jmp oBlockCheckCanFallReturnTrue

    oBlockCheckCanFallInvalidState:
        movq $-1, %rax
        jmp exitoBlockCheckFall

    oBlockCheckCanFallReturnTrue:
        movq TRUE, %rax
        jmp exitoBlockCheckFall    

    oBlockCheckCanFallReturnFalse:
        movq FALSE, %rax
        jmp exitoBlockCheckFall    

    exitoBlockCheckFall:
        popq %rsi
        popq %rdi
        ret

/* 
Returns TRUE if T-block can rotate, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
oBlockCheckCanRotate:
    movq $0, %rax
    ret

/*
Returns TRUE if T-block can go right, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
oBlockCheckCanGoRight:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je oBlockCheckCanGoRightState1     

    jmp oBlockCheckCanGoRightInvalidState

    oBlockCheckCanGoRightState1:        
        # condition 1
        movq a2X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge oBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne oBlockCheckCanGoRightReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne oBlockCheckCanGoRightReturnFalse
        
        jmp oBlockCheckCanGoRightReturnTrue

    oBlockCheckCanGoRightReturnTrue:
        movq TRUE, %rax
        jmp exitoBlockCheckCanGoRight
    
    oBlockCheckCanGoRightReturnFalse:
        movq FALSE, %rax
        jmp exitoBlockCheckCanGoRight

    oBlockCheckCanGoRightInvalidState:
        movq -1, %rax
        jmp exitoBlockCheckCanGoRight

    exitoBlockCheckCanGoRight:
        popq %rsi
        popq %rdi
        ret


/*
Returns TRUE if T-block can go left, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
oBlockCheckCanGoLeft:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je oBlockCheckCanGoLeftState1     
 
    jmp oBlockCheckCanGoLeftInvalidState

    oBlockCheckCanGoLeftState1:        
        # condition 1
        movq a1X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl oBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne oBlockCheckCanGoLeftReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne oBlockCheckCanGoLeftReturnFalse
        
        jmp oBlockCheckCanGoLeftReturnTrue

    oBlockCheckCanGoLeftReturnTrue:
        movq TRUE, %rax
        jmp exitoBlockCheckCanGoLeft
    
    oBlockCheckCanGoLeftReturnFalse:
        movq FALSE, %rax
        jmp exitoBlockCheckCanGoLeft

    oBlockCheckCanGoLeftInvalidState:
        movq -1, %rax
        jmp exitoBlockCheckCanGoLeft

    exitoBlockCheckCanGoLeft:
        popq %rsi
        popq %rdi
        ret

/*
Rotate the T-block, meaning move it to the next (one of the 4) rotation states
*/
oBlockRotate:
    ret
