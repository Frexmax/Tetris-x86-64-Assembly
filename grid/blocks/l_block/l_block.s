.text
	.globl	lBlockSpawnBlock
    .type	lBlockSpawnBlock, @function

	.globl	lBlockCheckCanFall
    .type	lBlockCheckCanFall, @function

	.globl	lBlockCheckCanRotate
    .type	lBlockCheckCanRotate, @function

	.globl	lBlockCheckCanGoRight
    .type	lBlockCheckCanGoRight, @function

    .globl lBlockCheckCanGoLeft
    .type lBlockCheckCanGoLeft, @function

	.globl	lBlockRotate
    .type	lBlockRotate, @function


/* 
Initialize a1 (x and y) to a4 for the T-block
Set rotation state to 1
@return - rax - TRUE (1) spawn possible, FALSE (0) spawn impossible - game over
*/
lBlockSpawnBlock:
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
    movq $6, a4X
    movq $18, a4Y
                                        
    call lBlockCheckCanFall                   # check if fall possible, if not, game over
    ret

lBlockSetInfoPoint:
    # point a1
    movq $12, infoA1X                        
    movq $16, infoA1Y                        

    # point a2                            
    movq $13, infoA2X
    movq $16, infoA2Y

    # point a3
    movq $14, infoA3X
    movq $16, infoA3Y

    # point 4
    movq $14, infoA4X
    movq $15, infoA4Y
    ret

/* 
Returns TRUE if T-block can fall, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
lBlockCheckCanFall:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je lBlockCheckCanFallState1     

    cmpq $2, currentState
    je lBlockCheckCanFallState2     

    cmpq $3, currentState
    je lBlockCheckCanFallState3     

    cmpq $4, currentState
    je lBlockCheckCanFallState4     

    jmp lBlockCheckCanFallInvalidState

    lBlockCheckCanFallState1:        
        # condition 1 - check if coordinate within the grid 
        movq a4Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl lBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanFallReturnFalse

        # condition 4 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanFallReturnFalse

        jmp lBlockCheckCanFallReturnTrue

    lBlockCheckCanFallState2:
        # condition 1 - check if coordinate within the grid 
        movq a4Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl lBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanFallReturnFalse

        # condition 4 - not needed, because of tetrino position 

        jmp lBlockCheckCanFallReturnTrue

    lBlockCheckCanFallState3:
        # condition 1 - check if coordinate within the grid 
        movq a1Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl lBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanFallReturnFalse

        # condition 4 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanFallReturnFalse

        jmp lBlockCheckCanFallReturnTrue

    lBlockCheckCanFallState4:
        # condition 1 - check if coordinate within the grid 
        movq a1Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl lBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanFallReturnFalse

        # condition 4 - not needed, because of tetrino position 

        jmp lBlockCheckCanFallReturnTrue 

    lBlockCheckCanFallInvalidState:
        movq $-1, %rax
        jmp exitlBlockCheckFall

    lBlockCheckCanFallReturnTrue:
        movq TRUE, %rax
        jmp exitlBlockCheckFall    

    lBlockCheckCanFallReturnFalse:
        movq FALSE, %rax
        jmp exitlBlockCheckFall    

    exitlBlockCheckFall:
        popq %rsi
        popq %rdi
        ret

/* 
Returns TRUE if T-block can rotate, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
lBlockCheckCanRotate:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je lBlockCheckCanRotateState1     

    cmpq $2, currentState
    je lBlockCheckCanRotateState2     

    cmpq $3, currentState
    je lBlockCheckCanRotateState3     

    cmpq $4, currentState
    je lBlockCheckCanRotateState4     

    jmp lBlockCheckCanRotateInvalidState

    lBlockCheckCanRotateState1:        
        # condition 1
        movq a4Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl lBlockCheckCanRotateReturnFalse

        # condition 2 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        subq $2, %rsi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanRotateReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        subq $2, %rsi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanRotateReturnFalse
        
        jmp lBlockCheckCanRotateReturnTrue

    lBlockCheckCanRotateState2:
        # condition 1 - check if coordinate within the grid 
        movq a4X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl lBlockCheckCanRotateReturnFalse

        # condition 2 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        subq $2, %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanRotateReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        subq $2, %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanRotateReturnFalse

        jmp lBlockCheckCanRotateReturnTrue

    lBlockCheckCanRotateState3:
        # condition 1 - check if coordinate within the grid 
        movq a4Y, %rdi              
        incq %rdi
        cmpq ySize, %rdi
        jge lBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        addq $2, %rsi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanRotateReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        addq $2, %rsi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanRotateReturnFalse

        jmp lBlockCheckCanRotateReturnTrue

    lBlockCheckCanRotateState4:
        # condition 1 - check if coordinate within the grid 
        movq a4X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge lBlockCheckCanRotateReturnFalse

        # condition 2 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        addq $2, %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanRotateReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        addq $2, %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanRotateReturnFalse

        jmp lBlockCheckCanRotateReturnTrue 

    lBlockCheckCanRotateInvalidState:
        movq $-1, %rax
        jmp exitlBlockCheckRotate

    lBlockCheckCanRotateReturnTrue:
        movq TRUE, %rax
        jmp exitlBlockCheckRotate    

    lBlockCheckCanRotateReturnFalse:
        movq FALSE, %rax
        jmp exitlBlockCheckRotate    

    exitlBlockCheckRotate:
        popq %rsi
        popq %rdi
        ret


/*
Returns TRUE if T-block can go right, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
lBlockCheckCanGoRight:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je lBlockCheckCanGoRightState1     

    cmpq $2, currentState
    je lBlockCheckCanGoRightState2     

    cmpq $3, currentState
    je lBlockCheckCanGoRightState3     

    cmpq $4, currentState
    je lBlockCheckCanGoRightState4     

    jmp lBlockCheckCanGoRightInvalidState

    lBlockCheckCanGoRightState1:        
        # condition 1
        movq a4X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge lBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoRightReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoRightReturnFalse
        
        jmp lBlockCheckCanGoRightReturnTrue

    lBlockCheckCanGoRightState2:        
        # condition 1
        movq a1X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge lBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoRightReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoRightReturnFalse

        # condition 4  
        movq a3X, %rdi
        movq a3Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoRightReturnFalse

        jmp lBlockCheckCanGoRightReturnTrue

    lBlockCheckCanGoRightState3:        
        # condition 1
        movq a1X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge lBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoRightReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoRightReturnFalse
        
        jmp lBlockCheckCanGoRightReturnTrue

    lBlockCheckCanGoRightState4:        
        # condition 1
        movq a4X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge lBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoRightReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoRightReturnFalse

        # condition 4  
        movq a4X, %rdi
        movq a4Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoRightReturnFalse

        jmp lBlockCheckCanGoRightReturnTrue

    lBlockCheckCanGoRightReturnTrue:
        movq TRUE, %rax
        jmp exitlBlockCheckCanGoRight
    
    lBlockCheckCanGoRightReturnFalse:
        movq FALSE, %rax
        jmp exitlBlockCheckCanGoRight

    lBlockCheckCanGoRightInvalidState:
        movq -1, %rax
        jmp exitlBlockCheckCanGoRight

    exitlBlockCheckCanGoRight:
        popq %rsi
        popq %rdi
        ret


/*
Returns TRUE if T-block can go left, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
lBlockCheckCanGoLeft:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je lBlockCheckCanGoLeftState1     

    cmpq $2, currentState
    je lBlockCheckCanGoLeftState2     

    cmpq $3, currentState
    je lBlockCheckCanGoLeftState3     

    cmpq $4, currentState
    je lBlockCheckCanGoLeftState4     

    jmp lBlockCheckCanGoLeftInvalidState

    lBlockCheckCanGoLeftState1:        
        # condition 1
        movq a1X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl lBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoLeftReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoLeftReturnFalse
        
        jmp lBlockCheckCanGoLeftReturnTrue

    lBlockCheckCanGoLeftState2:        
        # condition 1
        movq a4X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl lBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoLeftReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoLeftReturnFalse

        # condition 4  
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoLeftReturnFalse

        jmp lBlockCheckCanGoLeftReturnTrue

    lBlockCheckCanGoLeftState3:        
        # condition 1
        movq a4X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl lBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoLeftReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoLeftReturnFalse
        
        jmp lBlockCheckCanGoLeftReturnTrue

    lBlockCheckCanGoLeftState4:        
        # condition 1
        movq a1X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl lBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoLeftReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoLeftReturnFalse

        # condition 4  
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne lBlockCheckCanGoLeftReturnFalse

        jmp lBlockCheckCanGoLeftReturnTrue

    lBlockCheckCanGoLeftReturnTrue:
        movq TRUE, %rax
        jmp exitlBlockCheckCanGoLeft
    
    lBlockCheckCanGoLeftReturnFalse:
        movq FALSE, %rax
        jmp exitlBlockCheckCanGoLeft

    lBlockCheckCanGoLeftInvalidState:
        movq -1, %rax
        jmp exitlBlockCheckCanGoLeft

    exitlBlockCheckCanGoLeft:
        popq %rsi
        popq %rdi
        ret

/*
Rotate the T-block, meaning move it to the next (one of the 4) rotation states
*/
lBlockRotate:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je lBlockRotateState1     

    cmpq $2, currentState
    je lBlockRotateState2     

    cmpq $3, currentState
    je lBlockRotateState3     

    cmpq $4, currentState
    je lBlockRotateState4

    jmp exitlBlockCheckRotate

    lBlockRotateState1:
        movq $2, currentState
        movq a3X, %rdi
        movq a3Y, %rsi

        # a1
        movq %rdi, a1X
        movq %rsi, a1Y
        
        # a2
        incq a2X
        decq a2Y

        # a3
        subq $2, a3Y
        
        # a4
        decq a4X
        decq a4Y
    
        jmp exitlBlockRotate
            
    lBlockRotateState2:
        movq $3, currentState
        movq a3X, %rdi
        movq a3Y, %rsi

        # a1
        movq %rdi, a1X
        movq %rsi, a1Y
        
        # a2
        decq a2X
        decq a2Y

        # a3
        subq $2, a3X

        # a4
        decq a4X
        incq a4Y

        jmp exitlBlockRotate

    lBlockRotateState3:
        movq $4, currentState
        movq a3X, %rdi
        movq a3Y, %rsi

        # a1
        movq %rdi, a1X
        movq %rsi, a1Y
        
        # a2
        decq a2X
        incq a2Y

        # a3
        addq $2, a3Y

        # a4
        incq a4X
        incq a4Y
        
        jmp exitlBlockRotate  

    lBlockRotateState4:
        movq $1, currentState
        movq a3X, %rdi
        movq a3Y, %rsi
        
        # a1
        movq %rdi, a1X
        movq %rsi, a1Y
        
        # a2
        incq a2X
        incq a2Y

        # a3    
        addq $2, a3X

        # a4
        incq a4X
        decq a4Y

        jmp exitlBlockRotate    

    exitlBlockRotate:
        popq %rsi
        popq %rdi
        ret
