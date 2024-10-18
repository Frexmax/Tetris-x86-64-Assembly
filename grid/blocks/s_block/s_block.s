.text
	.globl	sBlockSpawnBlock
    .type	sBlockSpawnBlock, @function

	.globl	sBlockCheckCanFall
    .type	sBlockCheckCanFall, @function

	.globl	sBlockCheckCanRotate
    .type	sBlockCheckCanRotate, @function

	.globl	sBlockCheckCanGoRight
    .type	sBlockCheckCanGoRight, @function

    .globl sBlockCheckCanGoLeft
    .type sBlockCheckCanGoLeft, @function

	.globl	sBlockRotate
    .type	sBlockRotate, @function


/* 
Initialize a1 (x and y) to a4 for the T-block
Set rotation state to 1
@return - rax - TRUE (1) spawn possible, FALSE (0) spawn impossible - game over
*/
sBlockSpawnBlock:
    movq $1, currentState

    # point a1
    movq $4, a1X                        
    movq $18, a1Y                        

    # point a2                            
    movq $5, a2X
    movq $18, a2Y

    # point a3
    movq $5, a3X
    movq $19, a3Y

    # point 4
    movq $6, a4X
    movq $19, a4Y
                                        
    call sBlockCheckCanFall                   # check if fall possible, if not, game over
    ret

/* 
Returns TRUE if T-block can fall, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
sBlockCheckCanFall:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je sBlockCheckCanFallState1     

    cmpq $2, currentState
    je sBlockCheckCanFallState2     

    jmp sBlockCheckCanFallInvalidState

    sBlockCheckCanFallState1:        
        # condition 1 - check if coordinate within the grid 
        movq a1Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl sBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanFallReturnFalse

        # condition 4 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanFallReturnFalse

        jmp sBlockCheckCanFallReturnTrue

    sBlockCheckCanFallState2:
        # condition 1 - check if coordinate within the grid 
        movq a1Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl sBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanFallReturnFalse

        jmp sBlockCheckCanFallReturnTrue

    sBlockCheckCanFallInvalidState:
        movq $-1, %rax
        jmp exitsBlockCheckFall

    sBlockCheckCanFallReturnTrue:
        movq TRUE, %rax
        jmp exitsBlockCheckFall    

    sBlockCheckCanFallReturnFalse:
        movq FALSE, %rax
        jmp exitsBlockCheckFall    

    exitsBlockCheckFall:
        popq %rsi
        popq %rdi
        ret

/* 
Returns TRUE if I-block can rotate, depending on the current position and rotation state, else 0
Need modifications for advanced physics - OLEG
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
sBlockCheckCanRotate:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je sBlockCheckCanRotateState1     

    cmpq $2, currentState
    je sBlockCheckCanRotateState2     

    jmp sBlockCheckCanRotateInvalidState

    sBlockCheckCanRotateState1:        
        # condition 1
        movq a4Y, %rdi              
        incq %rdi
        cmpq $ySize, %rdi
        jge sBlockCheckCanRotateReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        incq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanRotateReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanRotateReturnFalse
        
        jmp sBlockCheckCanRotateReturnTrue

    sBlockCheckCanRotateState2:
        # condition 1
        movq a4X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl sBlockCheckCanRotateReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanRotateReturnFalse

        # condition 3 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        subq $2, %rdi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanRotateReturnFalse
        
        jmp sBlockCheckCanRotateReturnTrue

    sBlockCheckCanRotateInvalidState:
        movq $-1, %rax
        jmp exitsBlockCheckRotate

    sBlockCheckCanRotateReturnTrue:
        movq TRUE, %rax
        jmp exitsBlockCheckRotate    

    sBlockCheckCanRotateReturnFalse:
        movq FALSE, %rax
        jmp exitsBlockCheckRotate    

    exitsBlockCheckRotate:
        popq %rsi
        popq %rdi
        ret


/*
Returns TRUE if T-block can go right, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
sBlockCheckCanGoRight:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je sBlockCheckCanGoRightState1     

    cmpq $2, currentState
    je sBlockCheckCanGoRightState2     

    jmp sBlockCheckCanGoRightInvalidState

    sBlockCheckCanGoRightState1:        
        # condition 1
        movq a4X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge sBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanGoRightReturnFalse
        
        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanGoRightReturnFalse

        jmp sBlockCheckCanGoRightReturnTrue

    sBlockCheckCanGoRightState2:        
        # condition 1
        movq a1X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge sBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanGoRightReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanGoRightReturnFalse
        
        # condition 4 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanGoRightReturnFalse

        jmp sBlockCheckCanGoRightReturnTrue

    sBlockCheckCanGoRightReturnTrue:
        movq TRUE, %rax
        jmp exitsBlockCheckCanGoRight
    
    sBlockCheckCanGoRightReturnFalse:
        movq FALSE, %rax
        jmp exitsBlockCheckCanGoRight

    sBlockCheckCanGoRightInvalidState:
        movq -1, %rax
        jmp exitsBlockCheckCanGoRight

    exitsBlockCheckCanGoRight:
        popq %rsi
        popq %rdi
        ret


/*
Returns TRUE if T-block can go left, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
sBlockCheckCanGoLeft:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je sBlockCheckCanGoLeftState1     

    cmpq $2, currentState
    je sBlockCheckCanGoLeftState2     

    jmp sBlockCheckCanGoLeftInvalidState

     sBlockCheckCanGoLeftState1:        
        # condition 1
        movq a1X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl sBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanGoLeftReturnFalse
        
        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanGoLeftReturnFalse

        jmp sBlockCheckCanGoLeftReturnTrue

    sBlockCheckCanGoLeftState2:        
        # condition 1
        movq a4X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl sBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanGoLeftReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanGoLeftReturnFalse
        
        # condition 4 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne sBlockCheckCanGoLeftReturnFalse

        jmp sBlockCheckCanGoLeftReturnTrue

    sBlockCheckCanGoLeftReturnTrue:
        movq TRUE, %rax
        jmp exitsBlockCheckCanGoLeft
    
    sBlockCheckCanGoLeftReturnFalse:
        movq FALSE, %rax
        jmp exitsBlockCheckCanGoLeft

    sBlockCheckCanGoLeftInvalidState:
        movq -1, %rax
        jmp exitsBlockCheckCanGoLeft

    exitsBlockCheckCanGoLeft:
        popq %rsi
        popq %rdi
        ret

/*
Rotate the T-block, meaning move it to the next (one of the 4) rotation states
*/
sBlockRotate:
    pushq %rdi

    cmpq $1, currentState
    je sBlockRotateState1     

    cmpq $2, currentState
    je sBlockRotateState2     

    jmp exitsBlockCheckRotate

    sBlockRotateState1:
        movq $2, currentState
        
        # a1 changes
        addq $2, a1X
        
        # a2 changes
        incq a2X
        incq a2Y

        # a3 changes
    
        # a4 changes
        decq a4X
        incq a4Y

        jmp exitsBlockRotate
            
    sBlockRotateState2:
        movq $1, currentState
    
        # a1 changes
        subq $2, a1X

        # a2 changes
        decq a2X
        decq a2Y

        # a3 changes
 
        # a4 changes
        incq a4X
        decq a4Y

        jmp exitsBlockRotate

    exitsBlockRotate:
        popq %rdi
        ret
