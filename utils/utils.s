.data
    TRUE: .quad 1
    FALSE: .quad 0

.text

.macro prologue
    pushq %rbp 											
	movq %rsp, %rbp
.endm

.macro epilogue
	movq %rbp, %rsp
	popq %rbp											
.endm

.macro saveRegisters
    pushq %rax
    pushq %rcx
    pushq %rdx
    pushq %rsi
    pushq %rdi
    pushq %r8
    pushq %r9
    pushq %r10
    pushq %r11
    pushq %r12
    pushq %r13
    pushq %r14
    pushq %r15
.endm

.macro retrieveAllRegisters
    popq %r15
    popq %r14
    popq %r13
    popq %r12
    popq %r11
    popq %r10
    popq %r9
    popq %r8

.endm


/*
Compute the absolute value of a number
@param - number to get the absolute value - rdi
@return - absolute value of the input (rax)
*/
getAbsoluteValue:
    cmpq $0, %rdi
    jge exitGetAbsoluteValue
    negq %rdi
    
    exitGetAbsoluteValue:
        movq %rdi, %rax
        ret

/*
indexX and indexY from our coordinate system are converted to the #cell in our buffer according to the formula:
    - y * xMax + x
@param - indexX - rdi - x index of our container (not referring to raylib window positions)
@param - indexY - rsi - y index of our container (not referring to raylib window positions)
@return - #cell (rax)
*/
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
#cell is converted to the respective indexX and indexY of our coordinate system according to the formula:
    - y = floor(#cell / xSize)
    - x = #cell % xSize
@param - #cell - rdi - cell number to convert
@return - indexX (al), indexY (ah)
*/
cellToXY:                               
    # save registers used in subroutine
    pushq %rbx
    pushq %rdx
    pushq %rdi

    # Load xMax
    movq xSize, %rbx                    # Load xSize into %rbx (divisor)

    # Compute y = #cell / xSize
    movq %rdi, %rax
    xorq %rdx, %rdx                     # Clear %rdx for division
    divq %rbx                           # %rax / %rbx -> quotient in %rax, remainder in %rdx
                                        # %rax = y (quotient), %rdx = x (remainder)

    # Store y in AH and x in AL (low byte)
    movb %al, %ah                       # result of division (y) store in ah           
    movb %dl, %al                       # remainder of division (x) store in al

    # retrieve register used in subroutine
    popq %rdi
    popq %rdx
    popq %rbx
    ret
