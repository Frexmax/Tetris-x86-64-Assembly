.text
	.globl	iBlockSpawnBlock
    .type	iBlockSpawnBlock, @function

	.globl	iBlockCheckCanFall
    .type	iBlockCheckCanFall, @function

	.globl	iBlockCheckCanRotate
    .type	iBlockCheckCanRotate, @function

	.globl	iBlockCheckCanGoRight
    .type	iBlockCheckCanGoRight, @function

    .globl iBlockCheckCanGoLeft
    .type iBlockCheckCanGoLeft, @function

	.globl	iBlockRotate
    .type	iBlockRotate, @function


/* 
Initialize a1 (x and y) to a4 for the T-block
Set rotation state to 1
@return - rax - TRUE (1) spawn possible, FALSE (0) spawn impossible - game over
*/
iBlockSpawnBlock:
    movq $1, currentState

    # point a1
    movq $3, a1X                        
    movq $19, a1Y                        

    # point a2                            
    movq $4, a2X
    movq $19, a2Y

    # point a3
    movq $5, a3X
    movq $19, a3Y

    # point 4
    movq $6, a4X
    movq $19, a4Y
                                        
    call iBlockCheckCanFall                   # check if fall possible, if not, game over
    ret

iBlockSetInfoPoint:
    # point a1
    movq $11, infoA1X                        
    movq $16, infoA1Y                        

    # point a2                            
    movq $12, infoA2X
    movq $16, infoA2Y

    # point a3
    movq $13, infoA3X
    movq $16, infoA3Y

    # point 4
    movq $14, infoA4X
    movq $16, infoA4Y
    ret

/* 
Returns TRUE if T-block can fall, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
iBlockCheckCanFall:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je iBlockCheckCanFallState1     

    cmpq $2, currentState
    je iBlockCheckCanFallState2     

    jmp iBlockCheckCanFallInvalidState

    iBlockCheckCanFallState1:        
        # condition 1 - check if coordinate within the grid 
        movq a1Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl iBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanFallReturnFalse

        # condition 4 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanFallReturnFalse

        # condition 5 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanFallReturnFalse

        jmp iBlockCheckCanFallReturnTrue

    iBlockCheckCanFallState2:
        # condition 1 - check if coordinate within the grid 
        movq a1Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl iBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanFallReturnFalse

        jmp iBlockCheckCanFallReturnTrue

    iBlockCheckCanFallInvalidState:
        movq $-1, %rax
        jmp exitiBlockCheckFall

    iBlockCheckCanFallReturnTrue:
        movq TRUE, %rax
        jmp exitiBlockCheckFall    

    iBlockCheckCanFallReturnFalse:
        movq FALSE, %rax
        jmp exitiBlockCheckFall    

    exitiBlockCheckFall:
        popq %rsi
        popq %rdi
        ret

/* 
Returns TRUE if I-block can rotate, depending on the current position and rotation state, else 0
Need modifications for advanced physics - OLEG
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
iBlockCheckCanRotate:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je iBlockCheckCanRotateState1     

    cmpq $2, currentState
    je iBlockCheckCanRotateState2     

    jmp iBlockCheckCanRotateInvalidState

    iBlockCheckCanRotateState1:        
        # condition 1
        movq a3Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl iBlockCheckCanRotateReturnFalse

        # condition 2
        movq a3Y, %rdi              
        addq $2, %rdi
        cmpq ySize, %rdi
        jge iBlockCheckCanRotateReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanRotateReturnFalse

        # condition 4 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        incq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanRotateReturnFalse
        
        # condition 5 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        addq $2, %rsi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanRotateReturnFalse

        jmp iBlockCheckCanRotateReturnTrue

    iBlockCheckCanRotateState2:
        # condition 1
        movq a2X, %rdi              
        subq $2, %rdi
        cmpq $0, %rdi
        jl iBlockCheckCanRotateReturnFalse

        # condition 2
        movq a2X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge iBlockCheckCanRotateReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanRotateReturnFalse

        # condition 4 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanRotateReturnFalse
        
        # condition 5 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        subq $2, %rdi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanRotateReturnFalse

        jmp iBlockCheckCanRotateReturnTrue

    iBlockCheckCanRotateInvalidState:
        movq $-1, %rax
        jmp exitiBlockCheckRotate

    iBlockCheckCanRotateReturnTrue:
        movq TRUE, %rax
        jmp exitiBlockCheckRotate    

    iBlockCheckCanRotateReturnFalse:
        movq FALSE, %rax
        jmp exitiBlockCheckRotate    

    exitiBlockCheckRotate:
        popq %rsi
        popq %rdi
        ret


/*
Returns TRUE if T-block can go right, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
iBlockCheckCanGoRight:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je iBlockCheckCanGoRightState1     

    cmpq $2, currentState
    je iBlockCheckCanGoRightState2     

    jmp iBlockCheckCanGoRightInvalidState

    iBlockCheckCanGoRightState1:        
        # condition 1
        movq a4X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge iBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanGoRightReturnFalse
        
        jmp iBlockCheckCanGoRightReturnTrue

    iBlockCheckCanGoRightState2:        
        # condition 1
        movq a4X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge iBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanGoRightReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanGoRightReturnFalse
        
        # condition 4 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanGoRightReturnFalse

        # condition 5 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanGoRightReturnFalse

        jmp iBlockCheckCanGoRightReturnTrue

    iBlockCheckCanGoRightReturnTrue:
        movq TRUE, %rax
        jmp exitiBlockCheckCanGoRight
    
    iBlockCheckCanGoRightReturnFalse:
        movq FALSE, %rax
        jmp exitiBlockCheckCanGoRight

    iBlockCheckCanGoRightInvalidState:
        movq -1, %rax
        jmp exitiBlockCheckCanGoRight

    exitiBlockCheckCanGoRight:
        popq %rsi
        popq %rdi
        ret


/*
Returns TRUE if T-block can go left, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
iBlockCheckCanGoLeft:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je iBlockCheckCanGoLeftState1     

    cmpq $2, currentState
    je iBlockCheckCanGoLeftState2     

    jmp iBlockCheckCanGoLeftInvalidState

     iBlockCheckCanGoLeftState1:        
        # condition 1
        movq a1X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl iBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanGoLeftReturnFalse
        
        jmp iBlockCheckCanGoLeftReturnTrue

    iBlockCheckCanGoLeftState2:        
        # condition 1
        movq a1X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl iBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanGoLeftReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanGoLeftReturnFalse
        
        # condition 4 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanGoLeftReturnFalse

        # condition 5 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne iBlockCheckCanGoLeftReturnFalse

        jmp iBlockCheckCanGoLeftReturnTrue

    iBlockCheckCanGoLeftReturnTrue:
        movq TRUE, %rax
        jmp exitiBlockCheckCanGoLeft
    
    iBlockCheckCanGoLeftReturnFalse:
        movq FALSE, %rax
        jmp exitiBlockCheckCanGoLeft

    iBlockCheckCanGoLeftInvalidState:
        movq -1, %rax
        jmp exitiBlockCheckCanGoLeft

    exitiBlockCheckCanGoLeft:
        popq %rsi
        popq %rdi
        ret

/*
Rotate the T-block, meaning move it to the next (one of the 4) rotation states
*/
iBlockRotate:
    pushq %rdi

    cmpq $1, currentState
    je iBlockRotateState1     

    cmpq $2, currentState
    je iBlockRotateState2     

    jmp exitiBlockCheckRotate

    iBlockRotateState1:
        movq $2, currentState
        movq a3X, %rdi
        
        # a1 changes
        movq %rdi, a1X
        decq a1Y

        # a2 changes
        movq %rdi, a2X
        
        # a3 changes
        incq a3Y

        # a4 changes
        movq %rdi, a4X
        addq $2, a4Y
        
        jmp exitiBlockRotate
            
    iBlockRotateState2:
        movq $1, currentState
        movq a2Y, %rdi
    
        # a1 changes
        movq %rdi, a1Y
        subq $2, a1X

        # a2 changes
        decq a2X
        
        # a3 changes
        movq %rdi, a3Y

        # a4 changes
        movq %rdi, a4Y
        incq a4X

        jmp exitiBlockRotate

    exitiBlockRotate:
        popq %rdi
        ret
