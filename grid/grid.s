.include "grid/blocks/blocks.s"

.data
    buffer: .space 200                  # create buffer to store the grid values
                                         
.text
	.globl	drawGrid
    .type	drawGrid, @function

	.globl	checkForBlock
    .type	checkForBlock, @function

	.globl	checkLine
    .type	checkLine, @function

	.globl	copyLineAbove
    .type	copyLineAbove, @function

	.globl	gridShift
    .type	gridShift, @function

	.globl	checkGrid
    .type	checkGrid, @function



/*
Write to buffer based on indexX and indexY
@param - indexX - rdi - x index of our container (not referring to raylib window positions)
@param - indexY - rsi - y index of our container (not referring to raylib window positions)
*/
writeToBufferFromXY:
    ret

/*
Draw the xSize x ySize grid in the raylib window, 
by looping through the x and y coordinates and checking value in buffer
*/
drawGrid:
    # save registers used in subroutine
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %r9
    pushq %r10
    pushq %r11

    movq $buffer, %r9
    movb $0, (%r9)
    movb $1, 1(%r9)
    movb $1, 2(%r9)
    movb $1, 3(%r9)
    movb $1, 4(%r9)
    movb $1, 5(%r9)
    movb $1, 6(%r9)
    movb $1, 7(%r9)
    movb $1, 8(%r9)
    movb $1, 9(%r9)

    movq $0, %r9
    loopCellNumber:
        cmpq cellNumber, %r9
        jge exitDrawGrid
                                        
        movq %r9, %rdi                  # arg 1 - int - #cell 
        call cellToXY                   # get indexX (al) and indexY (ah) based on the #cell

        movq $buffer, %r11
        movzbq (%r11, %r9, 1), %r10     # get value of grid at #cell %r9 from the buffer
        cmpq $0, %r10                   # if the value in the buffer == 0, then no block present
        je nextLoopIteration

        draw:
            # TEST DRAW BLOCK
            movzbq %al, %rdi            # arg 1 - indexX in our coordinate system where the block should be drawn
            movb %ah, %al
            movzbq %al, %rsi            # arg 2 - indexY in our coordinate system where the block should be drawn
            movq BLACK, %rdx            # arg 3 - 32-bits RGBA - color of the block
            call drawBlock   
            jmp nextLoopIteration               

        nextLoopIteration:
            incq %r9
            jmp loopCellNumber

    
    exitDrawGrid:
        # retrieve register used in subroutine
        popq %r11
        popq %r10
        popq %r9
        popq %rdx
        popq %rsi
        popq %rdi
        ret

/*
TO DO
*/
checkForBlock:
    ret

/*
TO DO
*/
checkLine:
    ret

/*
TO DO
*/
copyLineAbove:
    ret

/* 
TO DO
*/
gridShift:
    ret

/* 
TO DO
*/
checkGrid:
    ret
