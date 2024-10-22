.data
    windowTitle: .asciz "Tetris"        # title of the raylib window 
                                        
    ySize: .quad 20                     # number of cells in the x direction
    xInfoSize: .quad 7
    xSize: .quad 10                     # number of cells in the y direction
    cellNumber: .quad 200               # number of cells = ySize * xSize
    cellSize: .quad 50                  # the length of the cell side - each cell is a square
    halfCellSize: .quad 25              # half the length of a cell side
    borderWidth: .quad 10               # border width in pixels
    nextBlockOutlineWidth: .quad 15
    
    targetFPS: .quad 30                 # target FPS for raylib - targetFPS also affects music play rate (minimum 30 FPS for good sound)
    screenWidth: .quad 0                # the pixel width of the raylib window - xSize * cellSize (initialized in main)
    screenHeight: .quad 0               # the pixel height of the raylib window - ySize * cellSize (initialized in main)

.macro initializeScreenSize
    movq xSize, %rax                    # copy xSize to rax                   
    addq xInfoSize, %rax                # add the size of the menu to xSize for total screen width
    mulq cellSize                       # multiply xSize (rax) by cellSize
    addq borderWidth, %rax              # add border width to screen width
    movq %rax, screenWidth              # copy xSize * cellSize (rax) to screenWidth

    movq ySize, %rax                    # copy ySize to rax   
    mulq cellSize                       # multiply ySize (rax) by cellSize
    movq %rax, screenHeight             # copy ySize * cellSize (rax) to screenWidth
.endm

.macro resetScoreAndDifficulty
    movq $0, currentScore               # reset score
    movq $0, currentLevel               # reset difficulty level
    movq $0, generationCounter          # reset generation counter
.endm
