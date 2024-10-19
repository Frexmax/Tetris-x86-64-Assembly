.include "info_screen/info_screen_config.s"

.data
    infoA1X: .quad 1
    infoA1Y: .quad 1

    infoA2X: .quad 1
    infoA2Y: .quad 1

    infoA3X: .quad 1
    infoA3Y: .quad 1

    infoA4X: .quad 1
    infoA4Y: .quad 1

.text
	.globl	drawInfoScreen
    .type	drawInfoScreen, @function

	.globl	setNextBlockInfoPointsFromSpawn
    .type	setNextBlockInfoPointsFromSpawn, @function

    .globl	drawNextBlock
    .type	drawNextBlock, @function


/*
@param - rdi - type of next block
*/
setInfoPointsFromNextType:
    cmpq tBlockType, %rdi
    je tBlockSetInfoPoint

    cmpq iBlockType, %rdi
    je iBlockSetInfoPoint

    cmpq oBlockType, %rdi
    je oBlockSetInfoPoint

    cmpq sBlockType, %rdi
    je sBlockSetInfoPoint

    cmpq zBlockType, %rdi
    je zBlockSetInfoPoint

    cmpq lBlockType, %rdi
    je lBlockSetInfoPoint

    cmpq jBlockType, %rdi
    je jBlockSetInfoPoint

    jmp exitSetInfoPointsFromNextType

    exitSetInfoPointsFromNextType:
        ret 

/* 
*/
setNextBlockInfoPointsFromSpawn:
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx

    movq pointXOffset, %rdi
    movq pointYOffset, %rsi

    # info a1
    movq a1X, %rdx
    movq a1Y, %rcx
    
    movq %rdx, infoA1X
    movq %rcx, infoA1Y
    
    addq %rdi, infoA1X
    addq %rsi, infoA1Y

    # info a2
    movq a2X, %rdx
    movq a2Y, %rcx
    
    movq %rdx, infoA2X
    movq %rcx, infoA2Y
    
    addq %rdi, infoA2X
    addq %rsi, infoA2Y


    # info a3
    movq a3X, %rdx
    movq a3Y, %rcx
    
    movq %rdx, infoA3X
    movq %rcx, infoA3Y
    
    addq %rdi, infoA3X
    addq %rsi, infoA3Y

    # info a4
    movq a4X, %rdx
    movq a4Y, %rcx
    
    movq %rdx, infoA4X
    movq %rcx, infoA4Y
    
    addq %rdi, infoA4X
    addq %rsi, infoA4Y

    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    ret

/* 
*/
drawNextBlock:
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %r15

    movq nextBlockType, %rdi
    cmpq %rdi, oBlockType
    je setShiftFlag
    
    movq nextBlockType, %rdi
    cmpq %rdi, iBlockType
    je setShiftFlag
    
    jmp skipSet

    setShiftFlag:
        movq TRUE, %r15
        jmp continue
    skipSet:
        movq FALSE, %r15
    continue:

    movq nextBlockType, %rdi
    call getColorFromType

    movq infoA1X, %rdi
    movq infoA1Y, %rsi
    movq %rax, %rdx
    call drawCell


    movq nextBlockType, %rdi
    call getColorFromType
    movq infoA2X, %rdi
    movq infoA2Y, %rsi
    movq %rax, %rdx
    call drawCell

    movq nextBlockType, %rdi
    call getColorFromType
    movq infoA3X, %rdi
    movq infoA3Y, %rsi
    movq %rax, %rdx
    call drawCell

    movq nextBlockType, %rdi
    call getColorFromType
    movq infoA4X, %rdi
    movq infoA4Y, %rsi
    movq %rax, %rdx
    call drawCell

    popq %r15
    popq %rdx
    popq %rdi
    popq %rsi
    ret

/* 
*/
drawInfoScreen:
    call drawNextBlock
    ret
