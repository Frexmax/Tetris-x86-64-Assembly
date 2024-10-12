.include "grid/blocks/blocks.s"

.data
    buffer: .space 200, 0               # create buffer to store the grid values

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

    # JUST FOR TESTING PURPOSES
    movq $buffer, %r9
    movb $0, (%r9)
    movb $2, 1(%r9)
    movb $4, 2(%r9)
    movb $6, 3(%r9)
    movb $8, 4(%r9)
    movb $10, 5(%r9)
    movb $12, 6(%r9)
    movb $14, 7(%r9)
    movb $16, 8(%r9)
    movb $18, 9(%r9)

    # movb $20, 10(%r9)
    # movb $22, 11(%r9)
    # movb $24, 12(%r9)
    # movb $26, 13(%r9)


    # TEST CHECK BLOCK
    movq $5, %rdi
    movq $0, %rsi
    call checkForBlock

    movq $8, %rdi
    movq $0, %rsi
    call checkForBlock

    # TEST CHECK LINE
    # movq $0, %rdi
    # call checkLine

    # movq $1, %rdi
    # call checkLine

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

xyToCell:     
    # save registers used in subroutine
    pushq %rsi
    pushq %rdi

    imulq xSize, %rsi                   # Multiply y (in %rsi) by xMax, result in %rsi (y * xMax)
    addq %rdi, %rsi                     # Add x (in %rdi) to the result (y * xMax + x)
    movq %rsi, %rax                     # Store the final result (cellno) into %rax

    # retrieve register used in subroutine
    popq %rdi
    popq %rsi
    ret

/*
Call XYToCell and check buffer at #cell
@param - indexX - rdi - x index of our container (not referring to raylib window positions)
@param - indexY - rsi - y index of our container (not referring to raylib window positions)
@return - value of buffer at indexX, indexY (rax)
*/
checkForBlock:
    pushq %rdi
    pushq %rsi

    call xyToCell                       # get #cell corresponding to indexX, indexY (store in rax)
    movq %rax, %rdi                     # copy rax to rdi, to later store the value of buffer in rax
    movq $buffer, %rsi                  # store buffer address in rsi to allow for indirect addressing
    movzbq (%rsi, %rdi, 1), %rax        # get value of buffer at #cell

    popq %rsi
    popq %rdi
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
