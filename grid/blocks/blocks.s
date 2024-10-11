.data

.text
	.globl	drawBlock
    .type	drawBlock, @function

/*
Draw block cellSize x cellSize at position indexX, indexY in our coordinate system in the raylib window.
Beforehand indexY is converted to match the raylib coordinate system 
@param - indexX - rdi - x index of our container (not referring to raylib window positions)
@param - indexY - rsi - y index of our container (not referring to raylib window positions)
@param - rdx - color of the block (32-bit RGBA)
*/
drawBlock:
    # save registers used in subroutine
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8

    imulq cellSize, %rdi                # scale indexX by cellSize to get pixelX in raylib (arg 1 of raylib DrawRectangle)

    # convert y-coordinate from our system to raylib 
    movq ySize, %rcx                    # store ySize in rcx
    subq %rsi, %rcx                     # ySize - y
    subq $1, %rcx                       # ySize - y - 1 <- done because y starts at 0
    imulq cellSize, %rcx                # get pixelY (in raylib)
    movq %rcx, %rsi                     # copy pixelY to rsi (arg 2 of raylib DrawRectangle) from rcx

    movq %rdx, %r8                      # arg-4 of raylib DrawRectangle - 32-bit RGBA - color of the block     
    movq cellSize, %rdx                 # arg 2 of raylib DrawRectangle - int - width of block
    movq cellSize, %rcx                 # arg 3 of raylib DrawRectangle - int - height of block
    
    saveRegisters
    call DrawRectangle                  # call raylib function to draw block in the window 
    retrieveAllRegisters
    
    # retrieve register used in subroutine
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    ret
