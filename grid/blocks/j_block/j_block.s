.text
	.globl	jBlockSpawnBlock
    .type	jBlockSpawnBlock, @function

	.globl	jBlockCheckCanFall
    .type	jBlockCheckCanFall, @function

	.globl	jBlockCheckCanRotate
    .type	jBlockCheckCanRotate, @function

	.globl	jBlockCheckCanGoRight
    .type	jBlockCheckCanGoRight, @function

    .globl jBlockCheckCanGoLeft
    .type jBlockCheckCanGoLeft, @function

	.globl	jBlockRotate
    .type	jBlockRotate, @function


/* 
Initialize a1 (x and y) to a4 for the T-block
Set rotation state to 1
@return - rax - TRUE (1) spawn possible, FALSE (0) spawn impossible - game over
*/
jBlockSpawnBlock:
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
    movq $4, a4X
    movq $18, a4Y
                                        
    call jBlockCheckCanFall                   # check if fall possible, if not, game over
    ret

/* 
Returns TRUE if T-block can fall, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
jBlockCheckCanFall:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je jBlockCheckCanFallState1     

    cmpq $2, currentState
    je jBlockCheckCanFallState2     

    cmpq $3, currentState
    je jBlockCheckCanFallState3     

    cmpq $4, currentState
    je jBlockCheckCanFallState4     

    jmp jBlockCheckCanFallInvalidState

    jBlockCheckCanFallState1:        
        # condition 1 - check if coordinate within the grid 
        movq a4Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl jBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanFallReturnFalse

        # condition 4 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanFallReturnFalse

        jmp jBlockCheckCanFallReturnTrue

    jBlockCheckCanFallState2:
        # condition 1 - check if coordinate within the grid 
        movq a4Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl jBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanFallReturnFalse

        # condition 4 - not needed, because of tetrino position 

        jmp jBlockCheckCanFallReturnTrue

    jBlockCheckCanFallState3:
        # condition 1 - check if coordinate within the grid 
        movq a1Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl jBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanFallReturnFalse

        # condition 4 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanFallReturnFalse

        jmp jBlockCheckCanFallReturnTrue

    jBlockCheckCanFallState4:
        # condition 1 - check if coordinate within the grid 
        movq a1Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl jBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanFallReturnFalse

        # condition 4 - not needed, because of tetrino position 

        jmp jBlockCheckCanFallReturnTrue 

    jBlockCheckCanFallInvalidState:
        movq $-1, %rax
        jmp exitjBlockCheckFall

    jBlockCheckCanFallReturnTrue:
        movq TRUE, %rax
        jmp exitjBlockCheckFall    

    jBlockCheckCanFallReturnFalse:
        movq FALSE, %rax
        jmp exitjBlockCheckFall    

    exitjBlockCheckFall:
        popq %rsi
        popq %rdi
        ret

/* 
Returns TRUE if T-block can rotate, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
jBlockCheckCanRotate:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je jBlockCheckCanRotateState1     

    cmpq $2, currentState
    je jBlockCheckCanRotateState2     

    cmpq $3, currentState
    je jBlockCheckCanRotateState3     

    cmpq $4, currentState
    je jBlockCheckCanRotateState4     

    jmp jBlockCheckCanRotateInvalidState

    jBlockCheckCanRotateState1:        
        # condition 1
        movq a4Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl jBlockCheckCanRotateReturnFalse

        # condition 2 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        subq $2, %rsi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanRotateReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        subq $2, %rsi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanRotateReturnFalse
        
        jmp jBlockCheckCanRotateReturnTrue

    jBlockCheckCanRotateState2:
        # condition 1 - check if coordinate within the grid 
        movq a4X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl jBlockCheckCanRotateReturnFalse

        # condition 2 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        subq $2, %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanRotateReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        subq $2, %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanRotateReturnFalse

        jmp jBlockCheckCanRotateReturnTrue

    jBlockCheckCanRotateState3:
        # condition 1 - check if coordinate within the grid 
        movq a4Y, %rdi              
        incq %rdi
        cmpq ySize, %rdi
        jge jBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        addq $2, %rsi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanRotateReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        addq $2, %rsi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanRotateReturnFalse

        jmp jBlockCheckCanRotateReturnTrue

    jBlockCheckCanRotateState4:
        # condition 1 - check if coordinate within the grid 
        movq a4X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge jBlockCheckCanRotateReturnFalse

        # condition 2 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        addq $2, %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanRotateReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        addq $2, %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanRotateReturnFalse

        jmp jBlockCheckCanRotateReturnTrue 

    jBlockCheckCanRotateInvalidState:
        movq $-1, %rax
        jmp exitjBlockCheckRotate

    jBlockCheckCanRotateReturnTrue:
        movq TRUE, %rax
        jmp exitjBlockCheckRotate    

    jBlockCheckCanRotateReturnFalse:
        movq FALSE, %rax
        jmp exitjBlockCheckRotate    

    exitjBlockCheckRotate:
        popq %rsi
        popq %rdi
        ret


/*
Returns TRUE if T-block can go right, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
jBlockCheckCanGoRight:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je jBlockCheckCanGoRightState1     

    cmpq $2, currentState
    je jBlockCheckCanGoRightState2     

    cmpq $3, currentState
    je jBlockCheckCanGoRightState3     

    cmpq $4, currentState
    je jBlockCheckCanGoRightState4     

    jmp jBlockCheckCanGoRightInvalidState

    jBlockCheckCanGoRightState1:        
        # condition 1
        movq a3X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge jBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoRightReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoRightReturnFalse
        
        jmp jBlockCheckCanGoRightReturnTrue

    jBlockCheckCanGoRightState2:        
        # condition 1
        movq a1X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge jBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoRightReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoRightReturnFalse

        # condition 4  
        movq a3X, %rdi
        movq a3Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoRightReturnFalse

        jmp jBlockCheckCanGoRightReturnTrue

    jBlockCheckCanGoRightState3:        
        # condition 1
        movq a1X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge jBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoRightReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoRightReturnFalse
        
        jmp jBlockCheckCanGoRightReturnTrue

    jBlockCheckCanGoRightState4:        
        # condition 1
        movq a4X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge jBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoRightReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoRightReturnFalse

        # condition 4  
        movq a4X, %rdi
        movq a4Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoRightReturnFalse

        jmp jBlockCheckCanGoRightReturnTrue

    jBlockCheckCanGoRightReturnTrue:
        movq TRUE, %rax
        jmp exitjBlockCheckCanGoRight
    
    jBlockCheckCanGoRightReturnFalse:
        movq FALSE, %rax
        jmp exitjBlockCheckCanGoRight

    jBlockCheckCanGoRightInvalidState:
        movq -1, %rax
        jmp exitjBlockCheckCanGoRight

    exitjBlockCheckCanGoRight:
        popq %rsi
        popq %rdi
        ret


/*
Returns TRUE if T-block can go left, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
jBlockCheckCanGoLeft:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je jBlockCheckCanGoLeftState1     

    cmpq $2, currentState
    je jBlockCheckCanGoLeftState2     

    cmpq $3, currentState
    je jBlockCheckCanGoLeftState3     

    cmpq $4, currentState
    je jBlockCheckCanGoLeftState4     

    jmp jBlockCheckCanGoLeftInvalidState

    jBlockCheckCanGoLeftState1:        
        # condition 1
        movq a1X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl jBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoLeftReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoLeftReturnFalse
        
        jmp jBlockCheckCanGoLeftReturnTrue

    jBlockCheckCanGoLeftState2:        
        # condition 1
        movq a4X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl jBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoLeftReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoLeftReturnFalse

        # condition 4  
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoLeftReturnFalse

        jmp jBlockCheckCanGoLeftReturnTrue

    jBlockCheckCanGoLeftState3:        
        # condition 1
        movq a3X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl jBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoLeftReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoLeftReturnFalse
        
        jmp jBlockCheckCanGoLeftReturnTrue

    jBlockCheckCanGoLeftState4:        
        # condition 1
        movq a1X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl jBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoLeftReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoLeftReturnFalse

        # condition 4  
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne jBlockCheckCanGoLeftReturnFalse

        jmp jBlockCheckCanGoLeftReturnTrue

    jBlockCheckCanGoLeftReturnTrue:
        movq TRUE, %rax
        jmp exitjBlockCheckCanGoLeft
    
    jBlockCheckCanGoLeftReturnFalse:
        movq FALSE, %rax
        jmp exitjBlockCheckCanGoLeft

    jBlockCheckCanGoLeftInvalidState:
        movq -1, %rax
        jmp exitjBlockCheckCanGoLeft

    exitjBlockCheckCanGoLeft:
        popq %rsi
        popq %rdi
        ret

/*
Rotate the T-block, meaning move it to the next (one of the 4) rotation states
*/
jBlockRotate:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je jBlockRotateState1     

    cmpq $2, currentState
    je jBlockRotateState2     

    cmpq $3, currentState
    je jBlockRotateState3     

    cmpq $4, currentState
    je jBlockRotateState4

    jmp exitjBlockCheckRotate

    jBlockRotateState1:
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
        incq a4X
        incq a4Y
    
        jmp exitjBlockRotate
            
    jBlockRotateState2:
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
        incq a4X
        decq a4Y

        jmp exitjBlockRotate

    jBlockRotateState3:
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
        decq a4X
        decq a4Y
        
        jmp exitjBlockRotate  

    jBlockRotateState4:
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
        decq a4X
        incq a4Y

        jmp exitjBlockRotate    

    exitjBlockRotate:
        popq %rsi
        popq %rdi
        ret
