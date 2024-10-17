.data
    windowTitle: .asciz "Tetris"        # title of the raylib window 
                                        
    ySize: .quad 20                     # number of cells in the x direction
    xSize: .quad 10                     # number of cells in the y direction
    cellNumber: .quad 200               # number of cells = ySize * xSize
    cellSize: .quad 50                  # the length of the cell side - each cell is a square
    
    targetFPS: .quad 30                 # target FPS for raylib - targetFPS also affects music play rate (minimum 30 FPS for good sound)
    screenWidth: .quad 0                # the pixel width of the raylib window - xSize * cellSize (initialized in main)
    screenHeight: .quad 0               # the pixel height of the raylib window - ySize * cellSize (initialized in main)

.macro initializeScreenSize
    pushq %rax                          # save rax

    movq xSize, %rax                    # copy xSize to rax                   
    mulq cellSize                       # multiply xSize (rax) by cellSize
    movq %rax, screenWidth              # copy xSize * cellSize (rax) to screenWidth

    movq ySize, %rax                    # copy ySize to rax   
    mulq cellSize                       # multiply ySize (rax) by cellSize
    movq %rax, screenHeight             # copy ySize * cellSize (rax) to screenWidth

    popq %rax                           # retrieve rax
.endm
