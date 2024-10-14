.text
	.globl	tBlockSpawnBlock
    .type	tBlockSpawnBlock, @function

	.globl	tBlockCheckCanFall
    .type	tBlockCheckCanFall, @function

	.globl	tBlockCheckCanRotate
    .type	tBlockCheckCanRotate, @function

	.globl	tBlockCheckCanGoRight
    .type	tBlockCheckCanGoRight, @function

	.globl	tBlockFall
    .type	tBlockFall, @function

	.globl	tBlockRotate
    .type	tBlockRotate, @function

	.globl	tBlockGoRight
    .type	tBlockGoRight, @function

	.globl	tBlockGoLeft
    .type	tBlockGoLeft, @function

	.globl	tBlockClearTetrino
    .type	tBlockClearTetrino, @function

	.globl	tBlockSetTetrino
    .type	tBlockSetTetrino, @function


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
Returns TRUE if block can fall, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
tBlockCheckCanFall:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je tBlockCheckCanFallState1     

    cmpq $2, currentState
    je tBlockCheckCanFallState2     

    cmpq $3, currentState
    je tBlockCheckCanFallState3     

    cmpq $4, currentState
    je tBlockCheckCanFallState4     

    jmp tBlockCheckCanFallInvalidState

    tBlockCheckCanFallState1:        
        # condition 1 - check if coordinate within the grid 
        movq a4Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl tBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanFallReturnFalse

        # condition 4 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanFallReturnFalse

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
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanFallReturnFalse

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
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanFallReturnFalse

        # condition 4 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanFallReturnFalse

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
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanFallReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanFallReturnFalse

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
        popq %rsi
        popq %rdi
        ret

/* 
Returns TRUE if block can rotate, depending on the current position and rotation state, else 0
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
tBlockCheckCanRotate:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je tBlockCheckCanRotateState1     

    cmpq $2, currentState
    je tBlockCheckCanRotateState2     

    cmpq $3, currentState
    je tBlockCheckCanRotateState3     

    cmpq $4, currentState
    je tBlockCheckCanRotateState4     

    jmp tBlockCheckCanRotateInvalidState

    tBlockCheckCanRotateState1:        
        # condition 1
        movq a4Y, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl tBlockCheckCanRotateReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanRotateReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        subq $2, %rsi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanRotateReturnFalse
        
        jmp tBlockCheckCanRotateReturnTrue

    tBlockCheckCanRotateState2:
        # condition 1 - check if coordinate within the grid 
        movq a4X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl tBlockCheckCanRotateReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanRotateReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        subq $2, %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanRotateReturnFalse

        jmp tBlockCheckCanRotateReturnTrue

    tBlockCheckCanRotateState3:
        # condition 1 - check if coordinate within the grid 
        movq a4Y, %rdi              
        incq %rdi
        cmpq ySize, %rdi
        jge tBlockCheckCanFallReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        incq %rsi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanRotateReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        addq $2, %rsi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanRotateReturnFalse

        jmp tBlockCheckCanRotateReturnTrue

    tBlockCheckCanRotateState4:
        # condition 1 - check if coordinate within the grid 
        movq a4X, %rdi              
        incq a4X
        cmpq xSize, %rdi
        jge tBlockCheckCanRotateReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanRotateReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        addq $2, %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanRotateReturnFalse

        jmp tBlockCheckCanRotateReturnTrue 

    tBlockCheckCanRotateInvalidState:
        movq $-1, %rax
        jmp exitTBlockCheckRotate

    tBlockCheckCanRotateReturnTrue:
        movq TRUE, %rax
        jmp exitTBlockCheckRotate    

    tBlockCheckCanRotateReturnFalse:
        movq FALSE, %rax
        jmp exitTBlockCheckRotate    

    exitTBlockCheckRotate:
        popq %rsi
        popq %rdi
        ret


/*
TO DO
*/
tBlockCheckCanGoRight:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je tBlockCheckCanGoRightState1     

    cmpq $2, currentState
    je tBlockCheckCanGoRightState2     

    cmpq $3, currentState
    je tBlockCheckCanGoRightState3     

    cmpq $4, currentState
    je tBlockCheckCanGoRightState4     

    jmp tBlockCheckCanGoRightInvalidState

    tBlockCheckCanGoRightState1:        
        # condition 1
        movq a3X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge tBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoRightReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoRightReturnFalse
        
        jmp tBlockCheckCanGoRightReturnTrue

    tBlockCheckCanGoRightState2:        
        # condition 1
        movq a1X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge tBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoRightReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoRightReturnFalse

        # condition 4  
        movq a3X, %rdi
        movq a3Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoRightReturnFalse

        jmp tBlockCheckCanGoRightReturnTrue

    tBlockCheckCanGoRightState3:        
        # condition 1
        movq a1X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge tBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoRightReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoRightReturnFalse
        
        jmp tBlockCheckCanGoRightReturnTrue

    tBlockCheckCanGoRightState4:        
        # condition 1
        movq a4X, %rdi              
        incq %rdi
        cmpq xSize, %rdi
        jge tBlockCheckCanGoRightReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoRightReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoRightReturnFalse

        # condition 4  
        movq a1X, %rdi
        movq a1Y, %rsi
        incq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoRightReturnFalse

        jmp tBlockCheckCanGoRightReturnTrue

    tBlockCheckCanGoRightReturnTrue:
        movq TRUE, %rax
        jmp exitTBlockCheckCanGoRight
    
    tBlockCheckCanGoRightReturnFalse:
        movq FALSE, %rax
        jmp exitTBlockCheckCanGoRight

    tBlockCheckCanGoRightInvalidState:
        movq -1, %rax
        jmp exitTBlockCheckCanGoRight

    exitTBlockCheckCanGoRight:
        popq %rsi
        popq %rdi
        ret


tBlockCheckCanGoLeftt:
    pushq %rdi
    pushq %rsi

    cmpq $1, currentState
    je tBlockCheckCanGoLeftState1     

    cmpq $2, currentState
    je tBlockCheckCanGoLeftState2     

    cmpq $3, currentState
    je tBlockCheckCanGoLeftState3     

    cmpq $4, currentState
    je tBlockCheckCanGoLeftState4     

    jmp tBlockCheckCanGoLeftInvalidState

    tBlockCheckCanGoLeftState1:        
        # condition 1
        movq a1X, %rdi              
        decq %rdi
        cmpq $0, %rdi
        jl tBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoLeftReturnFalse

        # condition 3 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoLeftReturnFalse
        
        jmp tBlockCheckCanGoLeftReturnTrue

    tBlockCheckCanGoLeftState2:        
        # condition 1
        movq a4X, %rdi              
        decq %rdi
        cmpq xSize, %rdi
        jge tBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoLeftReturnFalse

        # condition 3 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoLeftReturnFalse

        # condition 4  
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoLeftReturnFalse

        jmp tBlockCheckCanGoLeftReturnTrue

    tBlockCheckCanGoLeftState3:        
        # condition 1
        movq a3X, %rdi              
        decq %rdi
        cmpq xSize, %rdi
        jge tBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoLeftReturnFalse

        # condition 3 - 
        movq a4X, %rdi
        movq a4Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoLeftReturnFalse
        
        jmp tBlockCheckCanGoLeftReturnTrue

    tBlockCheckCanGoLeftState4:        
        # condition 1
        movq a1X, %rdi              
        decq %rdi
        cmpq xSize, %rdi
        jge tBlockCheckCanGoLeftReturnFalse

        # condition 2 - 
        movq a1X, %rdi
        movq a1Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoLeftReturnFalse

        # condition 3 - 
        movq a2X, %rdi
        movq a2Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoLeftReturnFalse

        # condition 4  
        movq a3X, %rdi
        movq a3Y, %rsi
        decq %rdi
        call getBlockValue
        cmpq $0, %rax
        jne tBlockCheckCanGoLeftReturnFalse

        jmp tBlockCheckCanGoLeftReturnTrue

    tBlockCheckCanGoLeftReturnTrue:
        movq TRUE, %rax
        jmp exitTBlockCheckCanGoLeft
    
    tBlockCheckCanGoLeftReturnFalse:
        movq FALSE, %rax
        jmp exitTBlockCheckCanGoLeft

    tBlockCheckCanGoLeftInvalidState:
        movq -1, %rax
        jmp exitTBlockCheckCanGoLeft

    exitTBlockCheckCanGoLeft:
        popq %rsi
        popq %rdi
        ret

/* 
TO DO
*/
tBlockClearTetrino:
    ret

/* 
TO DO
*/
tBlockSetTetrino:
    ret
