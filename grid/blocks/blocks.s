.data

.text
	.globl	drawBlock
    .type	drawBlock, @function

/*
TO DO 
@param - indexX - rdi - x index of our container (not referring to raylib window positions)
@param - indexY - rsi - y index of our container (not referring to raylib window positions)
@param - rdx - color of the block (32-bit RGBA)
*/
drawBlock:
    imulq cellSize, %rdi                # scale indexX by cellSize to get pixelX in raylib

    # convert y-coordinate from our system to raylib 
    movq ySize, %rcx                    # store ySize in rcx
    subq %rcx, %rsi                     # ySize - y
    subq $1, %rsi                       # ySize - y - 1 <- done because y starts at 0
    imulq cellSize, %rsi                # get pixelX (in raylib)

    # TO DO - DRAWING ...

    ret
