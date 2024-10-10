.macro prologue
    pushq %rbp 											
	movq %rsp, %rbp
.endm

.macro epilogue
	movq %rbp, %rsp
	popq %rbp											
.endm


/*
TO DO: HOW IT WORKS
@param - indexX - rdi - x index of our container (not referring to raylib window positions)
@param - indexY - rsi - y index of our container (not referring to raylib window positions)
@return - #cell (rax)
*/
xyToCell:                               # TO Do
    ret

/*
TO DO: HOW IT WORKS
@param - #cell - rdi - cell number to convert
@return - indexX (ah), indexY (al)
*/
cellToXY:                               # TO DO
    ret
