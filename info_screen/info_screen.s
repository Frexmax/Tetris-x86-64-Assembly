.include "info_screen/info_screen_config.s"

.data
    infoA1X: .quad 100
    infoA1Y: .quad 100

    infoA2X: .quad 100
    infoA2Y: .quad 100

    infoA3X: .quad 100
    infoA3Y: .quad 100

    infoA4X: .quad 100
    infoA4Y: .quad 100

    tempIncrement: .quad 1

.text
    nextBlockInfoText: .asciz "NEXT: "
    gameStartInfoText: .asciz "TO START THE ROUND: \n   -PRESS 'S'\nTO QUIT THE GAME: \n    -PRESS 'ESC'"
    gameOverInfoText: .asciz "GAME OVER! \nTO START NEW ROUND: \n    -PRESS 'R'"
    scoreText: .string "SCORE: %d"
    currentRound: .asciz "CURRENT ROUND: %d"
    

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
@param - rdi - score
*/
drawScoreText:
    pushq %rbp
    movq %rsp, %rbp
    
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8
    
    subq $64, %rsp
    
    # TEXT
    movq $scoreText, %rdi    
    # SCORE FORMAT
    movq currentScore, %rsi
    movq $0, %rax
    call TextFormat

    movq %rax, %rdi

    # X
    movq $10, %rsi
    imulq cellSize, %rsi
    addq halfCellSize, %rsi
    addq $4, %rsi

    # Y
    movq $8, %rdx
    imulq cellSize, %rdx
    subq $10, %rdx

    # FONTSIZE
    movq $50, %rcx

    # COLOR
    movq BACKGROUND, %r8

    call DrawText
    
    addq $64, %rsp

    // popq %r8
    // popq %rcx
    // popq %rdx
    // popq %rsi
    // popq %rdi

    movq %rbp, %rsp
    popq %rbp
    ret

/* 
*/
drawRankingText:
    ret

/*  
*/
drawNextBlockText:
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8

    # TEXT
    movq $nextBlockInfoText, %rdi
    
    # X
    movq $11, %rsi
    imulq cellSize, %rsi

    # Y
    movq $1, %rdx
    imulq cellSize, %rdx
    subq $10, %rdx

    # FONTSIZE
    movq $70, %rcx

    # COLOR
    movq BACKGROUND, %r8

    call DrawText

    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    ret

/* 
*/
drawStartGameText:
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8

    # TEXT
    movq $gameStartInfoText, %rdi
    
    # X
    movq $0, %rsi
    imulq cellSize, %rsi
    # addq halfCellSize, %rsi
    addq $20, %rsi

    # Y
    movq $9, %rdx
    imulq cellSize, %rdx

    # FONTSIZE
    movq $39, %rcx

    # COLOR
    movq BLACK, %r8

    call DrawText

    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    ret

/* 
*/
drawGameOverText:
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8

    # TEXT
    movq $gameOverInfoText, %rdi
    
    # X
    movq $0, %rsi
    imulq cellSize, %rsi
    # addq halfCellSize, %rsi
    addq $20, %rsi

    # Y
    movq $9, %rdx
    imulq cellSize, %rdx

    # FONTSIZE
    movq $39, %rcx

    # COLOR
    movq BLACK, %r8

    call DrawText

    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
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
drawNextBlockOutline:
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8

    # LINE 1 - horizontal
    # xPos
    movq $11, %rdi
    imulq cellSize, %rdi
    # yPos
    movq $1, %rsi
    # TEMP
    addq tempIncrement, %rsi
    imulq cellSize, %rsi
    # width
    movq $5, %rdx
    imulq cellSize, %rdx
    addq halfCellSize, %rdx
    # height
    movq nextBlockOutlineWidth, %rcx
    # color
    movq NEXTBLOCKOUTLINECOLOR, %r8
    # draw
    call DrawRectangle

    # LINE 2 - horizontal
    # xPos
    movq $11, %rdi
    imulq cellSize, %rdi    
    # yPos
    movq $5, %rsi
    # TEMP
    addq tempIncrement, %rsi
    imulq cellSize, %rsi
    # width
    movq $5, %rdx
    imulq cellSize, %rdx
    addq halfCellSize, %rdx
    # height
    movq nextBlockOutlineWidth, %rcx
    # color
    movq NEXTBLOCKOUTLINECOLOR, %r8
    # draw
    call DrawRectangle

    # VERTICALS

    # LINE 3 - vertical
    # xPos
    movq $16, %rdi
    imulq cellSize, %rdi
    addq halfCellSize, %rdi
    subq nextBlockOutlineWidth, %rdi

    # yPos
    movq $1, %rsi
    # TEMP
    addq tempIncrement, %rsi
    imulq cellSize, %rsi
    # width
    movq nextBlockOutlineWidth, %rdx
    # height
    movq $4, %rcx
    imulq cellSize, %rcx
    # color
    movq NEXTBLOCKOUTLINECOLOR, %r8
    # draw
    call DrawRectangle

    # LINE 4 - vertical
    # xPos
    movq $11, %rdi
    imulq cellSize, %rdi
    # yPos
    movq $1, %rsi
    # TEMP
    addq tempIncrement, %rsi
    imulq cellSize, %rsi
    # width
    movq nextBlockOutlineWidth, %rdx
    # height
    movq $4, %rcx
    imulq cellSize, %rcx
    # color
    movq NEXTBLOCKOUTLINECOLOR, %r8
    # draw
    call DrawRectangle

    popq %r8
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
    pushq %r13
    pushq %r14
    pushq %r15

    movq TRUE, %r14 

    movq nextBlockType, %rdi
    cmpq %rdi, iBlockType
    je setDownShiftFlag
    jmp unSetDownShiftFlag

    setDownShiftFlag:
        movq TRUE, %r13
        jmp continueFromDownShift
    unSetDownShiftFlag:
        movq FALSE, %r13
    continueFromDownShift:

    movq nextBlockType, %rdi
    cmpq %rdi, oBlockType
    je setRightShiftFlag
    
    movq nextBlockType, %rdi
    cmpq %rdi, iBlockType
    je setRightShiftFlag
    
    jmp unSetRightShiftFlag

    setRightShiftFlag:
        movq TRUE, %r15
        jmp continueFromRightShift
    unSetRightShiftFlag:
        movq FALSE, %r15
    continueFromRightShift:

    movq nextBlockType, %rdi
    call getColorFromType

    movq infoA1X, %rdi
    movq infoA1Y, %rsi

    # TEMP
    subq tempIncrement, %rsi

    movq %rax, %rdx
    call drawCell

    movq nextBlockType, %rdi
    call getColorFromType
    movq infoA2X, %rdi
    movq infoA2Y, %rsi

    # TEMP
    subq tempIncrement, %rsi

    movq %rax, %rdx
    call drawCell

    movq nextBlockType, %rdi
    call getColorFromType
    movq infoA3X, %rdi
    movq infoA3Y, %rsi

    # TEMP
    subq tempIncrement, %rsi

    movq %rax, %rdx
    call drawCell

    movq nextBlockType, %rdi
    call getColorFromType
    movq infoA4X, %rdi
    movq infoA4Y, %rsi

    # TEMP
    subq tempIncrement, %rsi

    movq %rax, %rdx
    call drawCell

    popq %r15
    popq %r14
    popq %r13
    popq %rdx
    popq %rdi
    popq %rsi
    ret

/* 
*/
drawInfoBorder:
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8

    movq xSize, %rdi
    imulq cellSize, %rdi

    movq $0, %rsi
    
    movq borderWidth, %rdx

    movq ySize, %rcx
    imulq cellSize, %rcx

    movq BORDERCOLOUR, %r8

    call DrawRectangle

    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    ret

/* 
*/
drawInfoScreen:
    call drawNextBlock
    call drawNextBlockOutline
    call drawInfoBorder
    call drawNextBlockText
    call drawScoreText
    ret
