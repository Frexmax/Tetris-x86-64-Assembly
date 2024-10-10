.data

    windowTitle: .asciz "Tetris"

    ySize: .quad 20
    xSize: .quad 10
    cellSize: .quad 50
    
    targetFPS: .quad 60
    screenWidth: .quad 0
    screenHeight: .quad 0

.macro initializeScreenSize
    pushq %rax              

    movq xSize, %rax
    mulq cellSize
    movq %rax, screenWidth

    movq ySize, %rax
    mulq cellSize
    movq %rax, screenHeight

    popq %rax
.endm
