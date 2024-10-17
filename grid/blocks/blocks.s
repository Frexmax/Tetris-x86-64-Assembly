.include "grid/blocks/t_block/t_block.s"


.data
    currentBlockType: .quad 1           # the type of block that is currently falling, e.g. 1  == tBlock
    currentState: .quad 1               # rotation state of the current tetrino
    
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

    jmp exitCheckCanGoLeft
    
    exitCheckCanGoLeft:
        ret

/* 
Wrapper function for the tetrino fall subroutine, 
depending on the type, the subroutine for the specific tetrino will be called
@param - rdi - tetrino type
*/
fall:
    cmpq tBlockType, %rdi
    je tBlockFall

    jmp exitFall
    
    exitFall:
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
Wrapper function for the tetrino goRight subroutine, 
depending on the type, the subroutine for the specific tetrino will be called
@param - rdi - tetrino type
*/
goRight:
    cmpq tBlockType, %rdi
    je tBlockGoRight

    jmp exitGoRight

    exitGoRight:
        ret

/* 
Wrapper function for the tetrino goLeft subroutine, 
depending on the type, the subroutine for the specific tetrino will be called
@param - rdi - tetrino type
*/
goLeft:
    cmpq tBlockType, %rdi
    je tBlockGoLeft

    jmp exitGoLeft

    exitGoLeft:
        ret

/* 
Wrapper function for the tetrino clearTetrino subroutine, 
depending on the type, the subroutine for the specific tetrino will be called
@param - rdi - tetrino type
*/
clearTetrino:
    cmpq tBlockType, %rdi
    je tBlockClearTetrino

    jmp exitClearTetrino

    exitClearTetrino:
        ret

/* 
Wrapper function for the tetrino setTetrino subroutine, 
depending on the type, the subroutine for the specific tetrino will be called
@param - rdi - tetrino type
*/
setTetrino:
    cmpq tBlockType, %rdi
    je tBlockSetTetrino

    jmp exitSetTetrino

    exitSetTetrino:
        ret
