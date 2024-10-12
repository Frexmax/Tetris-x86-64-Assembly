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
@param - value - rdx - the value to write in the cell
*/
writeToBufferFromXY:
    pushq %rcx
    pushq %rax
    
    call xyToCell  #cellno in %rax
    movq $buffer, %rcx
    addq %rax, %rcx
    movb %dl, (%rcx)

    popq %rax
    popq %rcx
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

    # TEST checkForBlock
    movq $1, %rdi                       
    movq $0, %rsi
    call checkForBlock                  # return value of #cell 1 -> 23

    movq $1, %rdi                       
    movq $1, %rsi
    call checkForBlock                  # return value of #cell 11 -> 0

    movq $0, %rdi
    movq $1, %rsi
    call checkForBlock                  # return value of #cell 10 -> 1

    # TEST checkLine
    movq $0, %rdi       
    call checkLine                      # returns FALSE (0)

    movq $3, %rdi
    call checkLine                      # returns TRUE (1)

    movq $2, %rdi
    call checkLine                      # return FALSE (0)

    movq $0, %r9                        # initialize loop at #cell = 0
    loopCellNumber:
        cmpq cellNumber, %r9            # if #cell >= cellNumber, exit loop
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
            incq %r9                    # go to next #cell by incrementing by 1
            jmp loopCellNumber          # start next loop iteration

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
Subroutine checking if the whole line is filled with blocks, returns TRUE (1) if it is, otherwise FALSE (0)
@param - indexY - rdi - the index of the (horizontal) line, i.e. at which height is it positioned
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
checkLine:
    pushq %rdi
    pushq %rsi
    pushq %r10
    pushq %r11
                                        
    movq %rdi, %r11                     # store indexY in r11, as rdi will be used to pass arguments to checkForBlock
    movq $0, %r10                       # loop counter going from 0 to xSize - 1 (inclusive) 
    loopX:
        cmpq xSize, %r10
        jge lineFull

        movq %r10, %rdi                 # arg 1 of checkForBlock - indexX, which is equal to the current iteration of the loop
        movq %r11, %rsi                 # arg 2 of checkForBlock - indexY, which is the y of the line being checked
        call checkForBlock              # get the value at indexX, indexY in the buffer

        cmpq $0, %rax                   # if the value in the buffer is equal to 0, then a spot is empty and the line is not filled
        je lineNotFull                  # exit the loop
        
        incq %r10
        jmp loopX                       # start the next iteration of the loop

    lineFull:
        movq TRUE, %rax                 # return value TRUE (1), line is filled
        jmp exitCheckLine

    lineNotFull:
        movq FALSE, %rax                # return value FALSE (0), line is not filled
        jmp exitCheckLine

    exitCheckLine:
        popq %r11
        popq %r10
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
