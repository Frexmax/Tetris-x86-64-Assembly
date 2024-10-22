.data
    buffer: .space 200, 0                  # create buffer to store the grid values
                                         
.text
    .globl writeToBufferFromCell
    .type writeToBufferFromCell, @function

    .globl writeToBufferFromXY
    .type writeToBufferFromXY, @function

	.globl	drawGrid
    .type	drawGrid, @function

	.globl	getBlockValue
    .type	getBlockValue, @function

	.globl	checkLine
    .type	checkLine, @function

	.globl	copyLineAbove
    .type	copyLineAbove, @function

	.globl	gridShift
    .type	gridShift, @function

	.globl	checkGrid
    .type	checkGrid, @function

    .globl	drawCell
    .type	drawCell, @function

    .globl	clearGrid
    .type	clearGrid, @function

/* 
Write to buffer based on the cell number
@param - #cell - rdi - cell number 
@param -value - rsi - the value to write in the cell
*/
writeToBufferFromCell:
    pushq %rcx
                                        
    movq $buffer, %rcx                  # move the address of buffer to rcx
    addq %rdi, %rcx                     # add the cell number to the address (to get buffer[cell number])
    movb %sil, (%rcx)                   # the buffer consists of bytes, so move the last byte of rsi to buffer[cell number]
    
    popq %rcx
    ret

/*
Write to buffer based on indexX and indexY
@param - indexX - rdi - x index of our container (not referring to raylib window positions)
@param - indexY - rsi - y index of our container (not referring to raylib window positions)
@param - value - rdx - the value to write in the cell
*/
writeToBufferFromXY:
    # save used registers
    pushq %rcx
    pushq %rax
                                        
    call xyToCell                       # cell number returned in rax (xIndex, yIndex passed already stored in rdi and rsi)
    movq $buffer, %rcx                  # move the address of the buffer to rcx
    addq %rax, %rcx                     # add the cell number to the address (to get buffer[cell number])
    movb %dl, (%rcx)                    # the buffer consists of bytes, so move the last byte of rdx to buffer[cell number]

    # retrieve used registers
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

    movq $0, %r9                        # initialize loop at #cell = 0
    loopCellNumber:
        cmpq cellNumber, %r9            # if #cell >= cellNumber, exit loop
        jge exitDrawGrid
                                        
        movq %r9, %rdi                  # arg 1 - int - #cell 
        call cellToXY                   # get indexX (al) and indexY (ah) based on the #cell
    
        movq $buffer, %r11
        movzbq (%r11, %r9, 1), %r10     # get value of grid at #cell %r9 from the buffer
        cmpq $0, %r10                   # if the value in the buffer == 0, then no block present
        je drawBackground

        drawColor:
            movzbq %al, %rdi            # arg 1 - indexX in our coordinate system where the block should be drawn
            movb %ah, %al               # only al can be access in movzbq, so move ah to al
            movzbq %al, %rsi            # arg 2 - indexY in our coordinate system where the block should be drawn

            pushq %rdi                  # save indexX before passing subroutine arguments
            movq %r10, %rdi             # pass the value in the grid, which represents the type of block and determines the color
            call getColorFromType       # get the color from type, output color value RGBA in rax   
            movq %rax, %rdx             # arg 3 - color value 
            popq %rdi                   # retrieve indexX

            call drawCell               
            jmp nextLoopIteration       

        drawBackground:
            movzbq %al, %rdi            # arg 1 - indexX in our coordinate system where the block should be drawn
            movb %ah, %al               # only al can be access in movzbq, so move ah to al
            movzbq %al, %rsi            # arg 2 - indexY in our coordinate system where the block should be drawn
          
            movq BACKGROUND, %rdx       # arg 3 - color value 
            call drawCell               
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
getBlockValue:
    # save registers used in subroutine
    pushq %rdi
    pushq %rsi

    call xyToCell                       # get #cell corresponding to indexX, indexY (store in rax)
    movq %rax, %rdi                     # copy rax to rdi, to later store the value of buffer in rax
    movq $buffer, %rsi                  # store buffer address in rsi to allow for indirect addressing
    movzbq (%rsi, %rdi, 1), %rax        # get value of buffer at #cell

    # retrieve registers used in subroutine
    popq %rsi
    popq %rdi
    ret

/*
Subroutine checking if the whole line is filled with blocks, returns TRUE (1) if it is, otherwise FALSE (0)
@param - indexY - rdi - the index of the (horizontal) line, i.e. at which height is it positioned
@return - boolean value TRUE (1) or FALSE (0) in (rax)
*/
checkLine:
    # save registers used in subroutine
    pushq %rdi
    pushq %rsi
    pushq %r10
    pushq %r11
                                        
    movq %rdi, %r11                     # store indexY in r11, as rdi will be used to pass arguments to getBlockValue
    movq $0, %r10                       # loop counter going from 0 to xSize - 1 (inclusive) 
    loopX:
        cmpq xSize, %r10
        jge lineFull

        movq %r10, %rdi                 # arg 1 of getBlockValue - indexX, which is equal to the current iteration of the loop
        movq %r11, %rsi                 # arg 2 of getBlockValue - indexY, which is the y of the line being checked
        call getBlockValue              # get the value at indexX, indexY in the buffer

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
        # retrieve registers used in subroutine
        popq %r11
        popq %r10
        popq %rsi
        popq %rdi
        ret
/*
Copy the buffer values from the line above to this line
Edge case: if indexY = ySize - 1, then fill line with 0s
@param - indexY - rdi - the index of the (horizontal) line, i.e. at which height is it positioned
*/
copyLineAbove:
    # save registers used in subroutine
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %r10
    pushq %r11

    movq %rdi, %r11                     # store indexY in r11, as rdi will be used to pass arguments to getBlockValue
    movq %rdi, %r12                     # copy indexY to r12, to later get the indexY of next line 
    incq %r12                           # indexY of the line above
    movq $0, %r10                       # loop counter going from 0 to xSize - 1 (inclusive) 
    
    cmpq ySize, %r12                    # if next line is out of bounds
    jge edgeCaseFill0                   # edge case: fill 0s

    # loop for indexY in the range 0 : ySize - 2 (inclusive), loop x from 0 to xSize - 1 (inclusive), then fill current line with the value from above
    fillNextLine:
        cmpq xSize, %r10                # if x >= xSize, exit loop, all values already copied
        jge exitCopyLineAbove

        movq %r10, %rdi                 # arg 1 of getBlockValue - indexX, which is equal to the current iteration of the loop
        movq %r12, %rsi                 # arg 2 of getBlockValue - indexY, which is the y of the line above
        call getBlockValue              # get the value at indexX, indexY in the buffer
        
        movq %r10, %rdi
        movq %r11, %rsi                 # arg 2 of writeToBufferFromXY - indexY, which is the y of the line being copied to
        movq %rax, %rdx                 # arg 3 of writeToBufferFromXY - value, which will be written in the cell, here the value returned by getBlockValue
        call writeToBufferFromXY        # (note: indexX is already in rdi)

        incq %r10                       # get next xIndex
        jmp fillNextLine                # next loop iteration

    # edge case when indexY = ySize - 1, loop x from 0 to xSize - 1 (inclusive), then fill the line with 0s
    edgeCaseFill0:
        cmpq xSize, %r10                # if x >= xSize, exit loop, all values already copied
        jge exitCopyLineAbove
        
        movq %r10, %rdi                 # arg 1 of writeToBufferFromXY - indexX, which is equal to the current iteration of the loop
        movq %r11, %rsi                 # arg 2 of writeToBufferFromXY - indexY, which is the y of the line being copied to
        movq $0, %rdx                   # arg 3 of writeToBufferFromXY - value, which will be written in the cell
        call writeToBufferFromXY

        incq %r10                       # get next xIndex
        jmp edgeCaseFill0               # next loop iteration

    exitCopyLineAbove:
        # retrieve registers used in subroutine
        popq %r11
        popq %r10
        popq %rdx
        popq %rsi
        popq %rdi        
        ret
/*
Shift the grid downwards above to this line
@param - indexY - rdi - the index of the (horizontal) line, i.e. at which height is it positioned (where start shifting)
*/
gridShift:
    pushq %rdi                        # save y index
    incq currentScore                 # +1 for every cleared row

    loopShift:
        cmpq ySize, %rdi              # if y >= ySize, exit loop
        jge exitGridShift           

        call copyLineAbove            # copy line from above into current line

        incq %rdi                     # move to the next line
        jmp loopShift                 # repeat the loop

    exitGridShift:
        popq %rdi                     # restore y index
        ret

/* 
*/
checkGrid:                              
    pushq %rdi
    pushq %r10
    
    movq ySize, %r10
    decq %r10
    loopCheckGrid:
        cmpq $0, %r10
        jl exitCheckGrid

        movq %r10, %rdi                # arg 1 of checkLine - indexY, which is equal to the current iteration of the loop
        call checkLine                 # check if the current line is full
        cmpq TRUE, %rax
        je shiftGridFromLine

        jmp nextCheckGridLoopIteration

    shiftGridFromLine:
        movq %r10, %rdi
        call gridShift
        jmp nextCheckGridLoopIteration

    nextCheckGridLoopIteration:
        decq %r10
        jmp loopCheckGrid

    exitCheckGrid:
        popq %r10
        popq %rdi
        ret

/*
Draw block cellSize x cellSize at position indexX, indexY in our coordinate system in the raylib window.
Beforehand indexY is converted to match the raylib coordinate system 
@param - indexX - rdi - x index of our container (not referring to raylib window positions)
@param - indexY - rsi - y index of our container (not referring to raylib window positions)
@param - rdx - color of the block (32-bit RGBA)
@param - r13 - draw block half a cell lower
@param r14 - offset the border size
@param r15 - shift right by halfSize flag
*/
drawCell:
    # save registers used in subroutine
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8
    pushq %r9

    imulq cellSize, %rdi                # scale indexX by cellSize to get pixelX in raylib (arg 1 of raylib DrawRectangle)

    cmpq TRUE, %r14                     # for info screen it's necessary to shift pixels by border size
    je offsetBorder                     
    jmp skipBorderShift

    offsetBorder:
        addq borderWidth, %rdi
    skipBorderShift:

    cmpq TRUE, %r15                     # again for info screen to allign some blocks, we need to shift by halfCellSize
    je shiftRightHalfCellSize
    jmp skipRightShift

    shiftRightHalfCellSize:
        addq halfCellSize, %rdi 
    skipRightShift:

    # convert y-coordinate from our system to raylib 
    movq ySize, %rcx                    # store ySize in rcx
    subq %rsi, %rcx                     # ySize - y
    subq $1, %rcx                       # ySize - y - 1 <- done because y starts at 0
    imulq cellSize, %rcx                # get pixelY (in raylib)
    movq %rcx, %rsi                     # copy pixelY to rsi (arg 2 of raylib DrawRectangle) from rcx

    cmpq TRUE, %r13                     # again for info screen to allign graphics, shift by halfCellSize is needed
    je shiftDownHalfCellSize
    jmp skipDownShift

    shiftDownHalfCellSize:
        addq halfCellSize, %rsi
    skipDownShift:

    movq %rdx, %r8                      # arg-4 of raylib DrawRectangle - 32-bit RGBA - color of the block     
    movq cellSize, %rdx                 # arg 2 of raylib DrawRectangle - int - width of block
    movq cellSize, %rcx                 # arg 3 of raylib DrawRectangle - int - height of block
    
    call DrawRectangle                  # call raylib function to draw block in the window 
    
    # retrieve register used in subroutine
    popq %r9
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    ret

/*
Loop through the entire grid (200 cells) and write 0 to each cell, thereby clearing it
*/
clearGrid:
    # save registers used in subroutine
    pushq %rdi
    pushq %r10

    movq $0, %r10                       # initialize loop counter, starting from y = 0
    loopClearGrid:      
        cmpq cellNumber, %r10           # if loop counter is equal to the number of cells, quit
        jge exitClearGrid

        movq %r10, %rdi                 # pass the loop counter as cell number argument
        movq $0, %rsi                   # pass 0 as the value to be written
        call writeToBufferFromCell      # write to grid (buffer)

        incq %r10                       # add 1 to loop counter
        jmp loopClearGrid               # next iteration

exitClearGrid:
    # retrieve register used in subroutine
    popq %r10
    popq %rdi
    ret
