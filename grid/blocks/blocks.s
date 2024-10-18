.include "grid/blocks/t_block/t_block.s"
.include "grid/blocks/o_block/o_block.s"
.include "grid/blocks/i_block/i_block.s"
.include "grid/blocks/s_block/s_block.s"


.data
    currentBlockType: .quad 1           # the type of block that is currently falling, e.g. 1  == tBlock
    currentState: .quad 1               # rotation state of the current tetrino
    randomNumberBuffer: .space 4, 0     # buffer where getrandom will output the random number    
    randomNumberBufferSize: .quad 4     # size of the buffer, needed for getrandom syscall

    fallingCounter: .quad 0                   # counter to keep track how many game loops were skipped before the next fall update
    fallingRatePerSecond: .quad 1             # how many times to update the fall per second
    framesPerFall: .quad 0
    fallRateMultiplier: .quad 1

.text
	.globl	spawnBlock
    .type	spawnBlock, @function

	.globl	checkCanFall
    .type	checkCanFall, @function

	.globl	checkCanRotate
    .type	checkCanRotate, @function

	.globl	checkCanGoRight
    .type	checkCanGoLeft, @function

	.globl	fall
    .type	fall, @function

	.globl	rotate
    .type	rotate, @function

	.globl	goRight
    .type	goRight, @function

	.globl	goLeft
    .type	goLeft, @function

	.globl	clearTetrino
    .type	clearTetrino, @function

	.globl	setTetrino
    .type	setTetrino, @function

    .globl getColorFromType
    .type getColorFromType, @function

.macro setUpFallingInfo
    movq fallingRatePerSecond, %rdi
    imulq targetFPS, %rdi
    movq %rdi, framesPerFall
.endm

.macro resetFallingInfo
    movq $0, fallingCounter
    movq $1, fallRateMultiplier
.endm


/* 
@return - rax - the color value for this block type
*/
getColorFromType:
    pushq %rdi

    movq currentBlockType, %rdi

    cmpq tBlockType, %rdi
    je setColorTBlock
    
    cmpq iBlockType, %rdi
    je setColorIBlock

    cmpq jBlockType, %rdi
    je setColorJBlock

    cmpq lBlockType, %rdi
    je setColorIBlock

    cmpq sBlockType, %rdi
    je setColorIBlock

    cmpq zBlockType, %rdi
    je setColorIBlock

    setColorTBlock:
        movq TBLOCKCOLOR, %rax
        jmp exitGetColorFromType

    setColorIBlock:
        movq IBLOCKCOLOR, %rax
        jmp exitGetColorFromType

    setColorJBlock:
        movq JBLOCKCOLOR, %rax
        jmp exitGetColorFromType

    setColorLBlock:
        movq LBLOCKCOLOR, %rax
        jmp exitGetColorFromType

    setColorOBlock:
        movq OBLOCKCOLOR, %rax
        jmp exitGetColorFromType

    setColorSBlock:
        movq SBLOCKCOLOR, %rax
        jmp exitGetColorFromType

    setColorZBlock:
        movq ZBLOCKCOLOR, %rax
        jmp exitGetColorFromType

    exitGetColorFromType:
        popq %rdi
        ret

/* 
Wrapper function for the tetrino spawnBlock subroutine, 
depending on the type, the subroutine for the specific tetrino will be called
@param - rdi - tetrino type
@return - rax - TRUE (1) spawn possible, FALSE (0) spawn impossible - game over
*/
spawnBlock:
    resetFallingInfo

    cmpq tBlockType, %rdi               # check if the current block is a T-block
    je tBlockSpawnBlock                 # if it is then call the spawnBlock subro

    cmpq iBlockType, %rdi
    je iBlockSpawnBlock

    cmpq oBlockType, %rdi
    je oBlockSpawnBlock

    cmpq sBlockType, %rdi
    je sBlockSpawnBlock

    jmp exitSpawnBlock

    exitSpawnBlock:
        ret

/* 
Wrapper function for the tetrino checkCanFall subroutine, 
depending on the type, the subroutine for the specific tetrino will be called
@param - rdi - tetrino type
@return - boolean value TRUE (1) => fall possible, or FALSE (0) => fall impossible, in (rax) for this specific type of tetrino
*/
checkCanFall:
    cmpq tBlockType, %rdi                   # check if the current block is a T-block
    je tBlockCheckCanFall                   # if it is then call the checkCanFall subroutine for the T-block

    cmpq iBlockType, %rdi
    je iBlockCheckCanFall

    cmpq oBlockType, %rdi
    je oBlockCheckCanFall

    cmpq sBlockType, %rdi
    je sBlockCheckCanFall

    jmp exitCheckCanFall

    exitCheckCanFall:
        ret

/*
Wrapper function for the tetrino checkCanRotate subroutine, 
depending on the type, the subroutine for the specific tetrino will be called
@param - rdi - tetrino type
@return - boolean value TRUE (1) => rotation possible, or FALSE (0) => rotation impossible, in (rax) for this specific type of tetrino
*/
checkCanRotate:
    cmpq tBlockType, %rdi
    je tBlockCheckCanRotate

    cmpq iBlockType, %rdi
    je iBlockCheckCanRotate

    cmpq oBlockType, %rdi
    je oBlockCheckCanRotate

    cmpq sBlockType, %rdi
    je sBlockCheckCanRotate

    jmp exitCheckCanRotate

    exitCheckCanRotate:
        ret

/* 
Wrapper function for the tetrino checkCanGoRight subroutine, 
depending on the type, the subroutine for the specific tetrino will be called
@param - rdi - tetrino type
@return - boolean value TRUE (1) => going right possible, or FALSE (0) => going right impossible, in (rax) for this specific type of tetrino
*/
checkCanGoRight:
    cmpq tBlockType, %rdi
    je tBlockCheckCanGoRight

    cmpq iBlockType, %rdi
    je iBlockCheckCanGoRight

    cmpq oBlockType, %rdi
    je oBlockCheckCanGoRight

    cmpq sBlockType, %rdi
    je sBlockCheckCanGoRight

    jmp exitCheckCanGoRight

    exitCheckCanGoRight:
        ret

/*
Wrapper function for the tetrino checkCanGoLeft subroutine, 
depending on the type, the subroutine for the specific tetrino will be called
@param - rdi - tetrino type
@return - boolean value TRUE (1) => going left possible, or FALSE (0) => going left impossible, in (rax) for this specific type of tetrino
*/
checkCanGoLeft:
    cmpq tBlockType, %rdi
    je tBlockCheckCanGoLeft

    cmpq iBlockType, %rdi
    je iBlockCheckCanGoLeft

    cmpq oBlockType, %rdi
    je oBlockCheckCanGoLeft

    cmpq sBlockType, %rdi
    je sBlockCheckCanGoLeft

    jmp exitCheckCanGoLeft
    
    exitCheckCanGoLeft:
        ret

/* 
Move tetrino down
depending on the type, the subroutine for the specific tetrino will be called
@param - rdi - tetrino type
*/
fall:
    decq a1Y
    decq a2Y
    decq a3Y
    decq a4Y
    ret

/* 
Wrapper function for the tetrino rotate subroutine, 
depending on the type, the subroutine for the specific tetrino will be called
@param - rdi - tetrino type
*/
rotate:
    cmpq tBlockType, %rdi
    je tBlockRotate

    jmp exitRotate

    exitRotate:
        ret

/* 
Move tetrino right
depending on the type, the subroutine for the specific tetrino will be called
*/
goRight:
    incq a1X
    incq a2X
    incq a3X
    incq a4X
    ret

/* 
Move tetrino left
depending on the type, the subroutine for the specific tetrino will be called
@param - rdi - tetrino type
*/
goLeft:
    decq a1X
    decq a2X
    decq a3X
    decq a4X
    ret

/* 
Clear tetrino from the grid
depending on the type, the subroutine for the specific tetrino will be called
*/
clearTetrino:
    pushq %rdi
    pushq %rsi

    movq a1X, %rdi
    movq a1Y, %rsi
    movq $0, %rdx
    call writeToBufferFromXY

    movq a2X, %rdi
    movq a2Y, %rsi
    movq $0, %rdx
    call writeToBufferFromXY

    movq a3X, %rdi
    movq a3Y, %rsi
    movq $0, %rdx
    call writeToBufferFromXY

    movq a4X, %rdi
    movq a4Y, %rsi
    movq $0, %rdx
    call writeToBufferFromXY

    popq %rdi
    popq %rsi
    ret


/* 
Set tetrino on the grid
depending on the type, the subroutine for the specific tetrino will be called
*/
setTetrino:
    pushq %rdi
    pushq %rsi

    movq a1X, %rdi
    movq a1Y, %rsi
    movq $1, %rdx
    call writeToBufferFromXY

    movq a2X, %rdi
    movq a2Y, %rsi
    movq $1, %rdx
    call writeToBufferFromXY

    movq a3X, %rdi
    movq a3Y, %rsi
    movq $1, %rdx
    call writeToBufferFromXY

    movq a4X, %rdi
    movq a4Y, %rsi
    movq $1, %rdx
    call writeToBufferFromXY

    popq %rdi
    popq %rsi
    ret
