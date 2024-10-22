.data
    infoA1X: .quad 0
    infoA1Y: .quad 0

    infoA2X: .quad 0
    infoA2Y: .quad 0

    infoA3X: .quad 0
    infoA3Y: .quad 0

    infoA4X: .quad 0
    infoA4Y: .quad 0

.text
    nextBlockInfoText: .asciz "NEXT: "
    gameStartInfoText: .asciz "TO START THE ROUND: \n   -PRESS 'S'\nTO QUIT THE GAME: \n    -PRESS 'ESC'"
    gameOverInfoText: .asciz "GAME OVER! \nTO START NEW ROUND: \n    -PRESS 'R'"
    scoreText: .asciz "SCORE: %d"
    currentLevelText: .asciz "LEVEL: %d"
    currentRoundText: .asciz "ROUND: %d"
    topScoreText: .asciz "TOP SCORES:"
    firstPlace: .asciz "1. %d"
    secondPlace: .asciz "2. %d"
    thirdPlace: .asciz "3. %d"
    fourthPlace: .asciz "4. %d"
    fifthPlace: .asciz "5. %d"

	.globl	drawInfoScreen
    .type	drawInfoScreen, @function

	.globl	setNextBlockInfoPointsFromSpawn
    .type	setNextBlockInfoPointsFromSpawn, @function

    .globl	drawNextBlock
    .type	drawNextBlock, @function

    .globl	drawNextBlockOutline
    .type	drawNextBlockOutline, @function

    .globl	drawInfoBorder
    .type	drawInfoBorder, @function

    .globl	drawNextBlockText
    .type	drawNextBlockText, @function

    .globl	drawScoreText
    .type	drawScoreText, @function

    .globl	drawLevelText
    .type	drawLevelText, @function

    .globl	drawRoundText
    .type	drawRoundText, @function

    .globl	drawTopScoreText
    .type	drawTopScoreText, @function

    .globl	drawFirstPlaceText
    .type	drawFirstPlaceText, @function

    .globl	drawSecondPlaceText
    .type	drawSecondPlaceText, @function
    
    .globl	drawThirdPlaceText
    .type	drawThirdPlaceText, @function
    
    .globl	drawFourthPlaceText
    .type	drawFourthPlaceText, @function

    .globl	drawFifthPlaceText
    .type	drawFifthPlaceText, @function

/*
Wrapper function for setInfoPoint, 
it sets the infoA1 to infoA4 coordinates based on the next type of block
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
Display the current user score on the screen as a raylib text
*/
drawScoreText:
    prologue

    # save registers used in the subroutine
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8
    
    # save stack space for TextFormat output
    subq $64, %rsp
                                            
    # TEXT      
    movq $scoreText, %rdi                   # text to display with format value
    # SCORE FORMAT
    movq currentScore, %rsi                 # argument to fill the format
    movq $0, %rax
    call TextFormat

    movq %rax, %rdi                         # pass the output of TextFormat as argument to DrawText

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
    
    # clear stack
    addq $64, %rsp

    # retrieve registers
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi

    epilogue
    ret

/*
Display the current level as a raylib text
*/
drawLevelText:
    prologue
    
    # save registers used in the subroutine
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8
    
    subq $64, %rsp
    
    # TEXT
    movq $currentLevelText, %rdi    
    # SCORE FORMAT
    movq currentLevel, %rsi
    movq $0, %rax
    call TextFormat

    movq %rax, %rdi

    # X
    movq $10, %rsi
    imulq cellSize, %rsi
    addq halfCellSize, %rsi
    addq $4, %rsi

    # Y
    movq $9, %rdx
    imulq cellSize, %rdx
    subq $10, %rdx

    # FONTSIZE
    movq $50, %rcx

    # COLOR
    movq BACKGROUND, %r8

    call DrawText
    
    addq $64, %rsp

    # retrieve registers
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi

    epilogue
    ret

/*
Display the number of rounds played as a raylib user 
*/
drawRoundText:
    prologue

    # save registers used in the subroutine
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8
    
    subq $64, %rsp
    
    # TEXT
    movq $currentRoundText, %rdi    
    # SCORE FORMAT
    movq roundsPlayed, %rsi
    movq $0, %rax
    call TextFormat

    movq %rax, %rdi

    # X
    movq $10, %rsi
    imulq cellSize, %rsi
    addq halfCellSize, %rsi
    addq $4, %rsi

    # Y
    movq $10, %rdx
    imulq cellSize, %rdx
    subq $10, %rdx

    # FONTSIZE
    movq $50, %rcx

    # COLOR
    movq BACKGROUND, %r8

    call DrawText
    
    addq $64, %rsp

    # retrieve registers
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi

    epilogue
    ret


/* 
Display the 'Top Scores' header as a raylib text
*/
drawTopScoreText:
    # save registers used in the subroutine
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8

    # TEXT
    movq $topScoreText, %rdi
    # X
    movq $10, %rsi
    imulq cellSize, %rsi
    addq halfCellSize, %rsi
    # Y
    movq $12, %rdx
    imulq cellSize, %rdx
    # FONTSIZE
    movq $48, %rcx
    # COLOR
    movq BACKGROUND, %r8
    call DrawText

    # retrieve registers
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    ret

/*
Display the top score (read from the file)
*/
drawFirstPlaceText:
    prologue

    # save registers used in the subroutine
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8

    subq $64, %rsp
    
    # TEXT
    movq $firstPlace, %rdi    
    # SCORE FORMAT
    movq firstScore, %rsi
    movq $0, %rax
    call TextFormat
    movq %rax, %rdi

    # X
    movq $10, %rsi
    imulq cellSize, %rsi
    addq halfCellSize, %rsi
    addq $4, %rsi

    # Y
    movq $13, %rdx
    imulq cellSize, %rdx
    # FONTSIZE
    movq $40, %rcx
    # COLOR
    movq BACKGROUND, %r8
    call DrawText
    
    addq $64, %rsp

    # retrieve registers
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi

    epilogue
    ret

/* 
Display the 2nd best score (read from the file)
*/
drawSecondPlaceText:
    prologue
    
     # save registers used in the subroutine
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8
    subq $64, %rsp
    
    # TEXT
    movq $secondPlace, %rdi    
    # SCORE FORMAT
    movq secondScore, %rsi
    movq $0, %rax
    call TextFormat
    movq %rax, %rdi

    # X
    movq $10, %rsi
    imulq cellSize, %rsi
    addq halfCellSize, %rsi
    addq $4, %rsi

    # Y
    movq $14, %rdx
    imulq cellSize, %rdx
    # FONTSIZE
    movq $40, %rcx
    # COLOR
    movq BACKGROUND, %r8
    call DrawText
    
    addq $64, %rsp

    # retrieve registers
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi

    epilogue
    ret

/*
Display the 3rd best score (read from the file)
*/
drawThirdPlaceText:
    prologue
    
    # save registers used in the subroutine
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8
    subq $64, %rsp
    
    # TEXT
    movq $thirdPlace, %rdi    
    # SCORE FORMAT
    movq thirdScore, %rsi
    movq $0, %rax
    call TextFormat
    movq %rax, %rdi

    # X
    movq $10, %rsi
    imulq cellSize, %rsi
    addq halfCellSize, %rsi
    addq $4, %rsi

    # Y
    movq $15, %rdx
    imulq cellSize, %rdx
    # FONTSIZE
    movq $40, %rcx
    # COLOR
    movq BACKGROUND, %r8
    call DrawText
    
    addq $64, %rsp

    # retrieve registers
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi

    epilogue
    ret

/* 
Display the 4th best score (read from the file)
*/
drawFourthPlaceText:
    prologue
    
    # save registers used in the subroutine
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8
    subq $64, %rsp
    
    # TEXT
    movq $fourthPlace, %rdi    
    # SCORE FORMAT
    movq fourthScore, %rsi
    movq $0, %rax
    call TextFormat
    movq %rax, %rdi

    # X
    movq $10, %rsi
    imulq cellSize, %rsi
    addq halfCellSize, %rsi
    addq $4, %rsi

    # Y
    movq $16, %rdx
    imulq cellSize, %rdx
    # FONTSIZE
    movq $40, %rcx
    # COLOR
    movq BACKGROUND, %r8
    call DrawText
    
    addq $64, %rsp
    
    # retrieve registers
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi

    epilogue
    ret

/* 
Display the 5ht best score (read from the file)
*/
drawFifthPlaceText:
    prologue
    
    # save registers used in the subroutine
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8
    subq $64, %rsp
    
    # TEXT
    movq $fifthPlace, %rdi    
    # SCORE FORMAT
    movq fifthScore, %rsi
    movq $0, %rax
    call TextFormat
    movq %rax, %rdi

    # X
    movq $10, %rsi
    imulq cellSize, %rsi
    addq halfCellSize, %rsi
    addq $4, %rsi

    # Y
    movq $17, %rdx
    imulq cellSize, %rdx
    # FONTSIZE
    movq $40, %rcx
    # COLOR
    movq BACKGROUND, %r8
    call DrawText
    
    addq $64, %rsp
  
    # retrieve registers
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi

    epilogue
    ret

/*  
Display the 'NEXT' header above next block display as a raylib text
*/
drawNextBlockText:
    # save registers used in the subroutine
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

    # retrieve registers
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    ret

/* 
Display basic information in the start screen as a raylib text
*/
drawStartGameText:
    # save registers used in the subroutine
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
    addq $20, %rsi

    # Y
    movq $9, %rdx
    imulq cellSize, %rdx

    # FONTSIZE
    movq $39, %rcx

    # COLOR
    movq BLACK, %r8

    call DrawText

    # retrieve registers
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    ret

/*
Display basic information in the game over screen as a raylib text
*/
drawGameOverText:
    # save registers used in the subroutine
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
    addq $20, %rsi

    # Y
    movq $9, %rdx
    imulq cellSize, %rdx

    # FONTSIZE
    movq $39, %rcx

    # COLOR
    movq BLACK, %r8

    call DrawText

    # retrieve registers
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    ret

/*
Draw a border around the next block to spawned
*/
drawNextBlockOutline:
    # save registers used in the subroutine
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8

    # HORIZONTAL LINES OF NEXT BLOCK OUTLINE

    # LINE 1 - horizontal
    # xPos
    movq $11, %rdi
    imulq cellSize, %rdi
    # yPos
    movq $2, %rsi
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
    movq $6, %rsi
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

    # VERTICAL LINES OF NEXT BLOCK BORDER

    # LINE 3 - vertical
    # xPos
    movq $16, %rdi
    imulq cellSize, %rdi
    addq halfCellSize, %rdi
    subq nextBlockOutlineWidth, %rdi

    # yPos
    movq $2, %rsi
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
    movq $2, %rsi
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

    # retrieve registers
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    ret

/* 
Draw the next block in the next block section of the info screens based on infoA1 to infoA4
*/
drawNextBlock:
    # save registers used in the subroutine
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

    # retrieve registers
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
    # save registers used in the subroutine
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

    # retrieve registers
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    ret

/* 
*/
drawInfoScreen:
    # DISPLAY BORDER BETWEEN PLAYABLE GRID AND INFO SCREEN
    call drawInfoBorder

    # DISPLAY THE NEXT BLOCK VIEW
    call drawNextBlockText
    call drawNextBlock
    call drawNextBlockOutline
    
    # DISPLAY CURRENT ROUND INFO
    call drawScoreText
    call drawLevelText
    call drawRoundText

    # DISPLAY SCORE TABLE
    call drawTopScoreText
    call drawFirstPlaceText
    call drawSecondPlaceText
    call drawThirdPlaceText
    call drawFourthPlaceText
    call drawFifthPlaceText
    ret
