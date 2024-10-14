.include "grid/blocks/t_block/t_block.s"
.include "grid/blocks/block_config.s"

.data

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


/* 
Initialize a1 (x and y) to a4, call function for the specific tetrino
Set rotation state 1
@param - rdi - tetrino type
*/
spawnBlock:
    ret

/* 
TO DO
*/
checkCanFall:
    ret
/* 
TO DO
*/
clearTetrino:
    ret

/* 
TO DO
*/
setTetrino:
    ret
