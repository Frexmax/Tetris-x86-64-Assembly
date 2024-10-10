.data
    windowTitle: .asciz "Tetris"        # title of the raylib window 
                                        
    ySize: .quad 20                     # number of cells in the x direction
    xSize: .quad 10                     # number of cells in the y direction
    cellSize: .quad 50                  # the length of the cell side - each cell is a square
    
    targetFPS: .quad 60                 # target FPS for raylib
    screenWidth: .quad 0                # the pixel width of the raylib window - xSize * cellSize (initialized in main)
    screenHeight: .quad 0               # the pixel height of the raylib window - ySize * cellSize (initialized in main)

.macro initializeScreenSize
    pushq %rax                          # save rax

    movq xSize, %rax                    # copy xSize to rax                   
    mulq cellSize                       # multiply xSize (rax) by cellSize
    movq %rax, screenWidth              # copy xSize * cellSize (rax) to screenWidth

    movq ySize, %rax                    # do the same but for ySize and screenHeight ...
    mulq cellSize
    movq %rax, screenHeight

    popq %rax                           # retrieve rax
.endm
