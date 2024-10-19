.text
	.globl	zBlockSpawnBlock
    .type	zBlockSpawnBlock, @function

	.globl	zBlockCheckCanFall
    .type	zBlockCheckCanFall, @function

	.globl	zBlockCheckCanRotate
    .type	zBlockCheckCanRotate, @function

	.globl	zBlockCheckCanGoRight
    .type	zBlockCheckCanGoRight, @function

    .globl zBlockCheckCanGoLeft
    .type zBlockCheckCanGoLeft, @function

	.globl	zBlockRotate
    .type	zBlockRotate, @function


/* 
Initialize a1 (x and y) to a4 for the T-block
Set rotation state to 1
@return - rax - TRUE (1) spawn possible, FALSE (0) spawn impossible - game over
*/
zBlockSpawnBlock:
    movq $1, currentState

    # point a1
    movq $6, a1X                        
    movq $18, a1Y                        

    # point a2                            
    movq $5, a2X
    movq $18, a2Y

    # point a3
    movq $5, a3X
    movq $19, a3Y

    # point 4
    movq $4, a4X
    movq $19, a4Y
                                        
    call zBlockCheckCanFall                   # check if fall possible, if not, game over
    ret

zBlockSetInfoPoint:
    # point a1
    movq $14, infoA1X                        
    movq $16, infoA1Y                        

    # point a2                            
    movq $13, infoA2X
    movq $16, infoA2Y

    # point a3
    movq $13, infoA3X
    movq $17, infoA3Y

    # point 4
    movq $12, infoA4X
    movq $17, infoA4Y
    ret

/* 
Returns TRUE if T-block can fall, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
zBlockCheckCanFall:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je zBlockCheckCanFallState1     

    cmpq $2, currentState
    je zBlockCheckCanFallState2     

    jmp zBlockCheckCanFallInvalidState

    zBlockCheckCanFallState1:        
        # condition 1 - check if coordinate within the grid 
        movq a1Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl zBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanFallReturnFalse

        # condition 4 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanFallReturnFalse

        jmp zBlockCheckCanFallReturnTrue

    zBlockCheckCanFallState2:
        # condition 1 - check if coordinate within the grid 
        movq a1Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl zBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanFallReturnFalse

        jmp zBlockCheckCanFallReturnTrue

    zBlockCheckCanFallInvalidState:
        movq $-1, %rax
        jmp exitzBlockCheckFall

    zBlockCheckCanFallReturnTrue:
        movq TRUE, %rax
        jmp exitzBlockCheckFall    

    zBlockCheckCanFallReturnFalse:
        movq FALSE, %rax
        jmp exitzBlockCheckFall    

    exitzBlockCheckFall:
        popq %rsi
        popq %rdi
        ret

/* 
Returns TRUE if I-block can rotate, depending on the current position and rotation state, else 0
Need modifications for advanced physics - OLEG
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
zBlockCheckCanRotate:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je zBlockCheckCanRotateState1     

    cmpq $2, currentState
    je zBlockCheckCanRotateState2     

    jmp zBlockCheckCanRotateInvalidState

    zBlockCheckCanRotateState1:        
        # condition 1
        movq a4Y, %rdi              
        incq %rdi
        cmpq ySize, %rdi
        jge zBlockCheckCanRotateReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        incq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanRotateReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanRotateReturnFalse
        
        jmp zBlockCheckCanRotateReturnTrue

    zBlockCheckCanRotateState2:
        # condition 1
        movq a4X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge zBlockCheckCanRotateReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanRotateReturnFalse

        # condition 3 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        addq $2, %rdi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanRotateReturnFalse
        
        jmp zBlockCheckCanRotateReturnTrue

    zBlockCheckCanRotateInvalidState:
        movq $-1, %rax
        jmp exitzBlockCheckRotate

    zBlockCheckCanRotateReturnTrue:
        movq TRUE, %rax
        jmp exitzBlockCheckRotate    

    zBlockCheckCanRotateReturnFalse:
        movq FALSE, %rax
        jmp exitzBlockCheckRotate    

    exitzBlockCheckRotate:
        popq %rsi
        popq %rdi
        ret


/*
Returns TRUE if T-block can go right, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
zBlockCheckCanGoRight:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je zBlockCheckCanGoRightState1     

    cmpq $2, currentState
    je zBlockCheckCanGoRightState2     

    jmp zBlockCheckCanGoRightInvalidState

    zBlockCheckCanGoRightState1:        
        # condition 1
        movq a1X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge zBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanGoRightReturnFalse
        
        # condition 3 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanGoRightReturnFalse

        jmp zBlockCheckCanGoRightReturnTrue

    zBlockCheckCanGoRightState2:        
        # condition 1
        movq a4X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge zBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanGoRightReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanGoRightReturnFalse
        
        # condition 4 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanGoRightReturnFalse

        jmp zBlockCheckCanGoRightReturnTrue

    zBlockCheckCanGoRightReturnTrue:
        movq TRUE, %rax
        jmp exitzBlockCheckCanGoRight
    
    zBlockCheckCanGoRightReturnFalse:
        movq FALSE, %rax
        jmp exitzBlockCheckCanGoRight

    zBlockCheckCanGoRightInvalidState:
        movq -1, %rax
        jmp exitzBlockCheckCanGoRight

    exitzBlockCheckCanGoRight:
        popq %rsi
        popq %rdi
        ret


/*
Returns TRUE if T-block can go left, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
zBlockCheckCanGoLeft:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je zBlockCheckCanGoLeftState1     

    cmpq $2, currentState
    je zBlockCheckCanGoLeftState2     

    jmp zBlockCheckCanGoLeftInvalidState

     zBlockCheckCanGoLeftState1:        
        # condition 1
        movq a4X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl zBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanGoLeftReturnFalse
        
        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanGoLeftReturnFalse

        jmp zBlockCheckCanGoLeftReturnTrue

    zBlockCheckCanGoLeftState2:        
        # condition 1
        movq a1X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl zBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanGoLeftReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanGoLeftReturnFalse
        
        # condition 4 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne zBlockCheckCanGoLeftReturnFalse

        jmp zBlockCheckCanGoLeftReturnTrue

    zBlockCheckCanGoLeftReturnTrue:
        movq TRUE, %rax
        jmp exitzBlockCheckCanGoLeft
    
    zBlockCheckCanGoLeftReturnFalse:
        movq FALSE, %rax
        jmp exitzBlockCheckCanGoLeft

    zBlockCheckCanGoLeftInvalidState:
        movq -1, %rax
        jmp exitzBlockCheckCanGoLeft

    exitzBlockCheckCanGoLeft:
        popq %rsi
        popq %rdi
        ret

/*
Rotate the T-block, meaning move it to the next (one of the 4) rotation states
*/
zBlockRotate:
    pushq %rdi

    cmpq $1, currentState
    je zBlockRotateState1     

    cmpq $2, currentState
    je zBlockRotateState2     

    jmp exitzBlockCheckRotate

    zBlockRotateState1:
        movq $2, currentState
        
        # a1 changes
        subq $2, a1X
        
        # a2 changes
        decq a2X
        incq a2Y

        # a3 changes
    
        # a4 changes
        incq a4X
        incq a4Y

        jmp exitzBlockRotate
            
    zBlockRotateState2:
        movq $1, currentState
    
        # a1 changes
        addq $2, a1X

        # a2 changes
        incq a2X
        decq a2Y

        # a3 changes
 
        # a4 changes
        decq a4X
        decq a4Y

        jmp exitzBlockRotate

    exitzBlockRotate:
        popq %rdi
        ret
