.include "input/input_config.s"

.text
    outCommand: .asciz "%d"

/* 
Get the keyboard command - left, right arrows
@return - rax - the value of the command key, return 0 if none of the valid commands
*/
getCurrentCommand:
    pushq %rdi

    call GetKeyPressed                       # get the current key pressed

    cmpq KEY_RIGHT, %rax
    je rightArrowReturn

    cmpq KEY_LEFT, %rax
    je leftArrowReturn

    jmp noKeyOrNotValid                 # if neither KEY_RIGHT or KEY_LEFT key pressed, then return 0 in rax

    rightArrowReturn:
        # movq KEY_RIGHT, %rax            # copy KEY_RIGHT value to rax, to be returned
        movq RIGHT, %rax
        jmp exitGetCurrentCommand

    leftArrowReturn:
        # movq KEY_LEFT, %rax             # copy KEY_LEFT value to rax, to be returned
        movq LEFT, %rax
        jmp exitGetCurrentCommand       

    noKeyOrNotValid:
        movq $0, %rax                   # copy 0 to rax, to be returned
        jmp exitGetCurrentCommand
  

    exitGetCurrentCommand:
        popq %rdi
        ret


/*
@param - rdi - value of command
*/
handleCommand:
    cmpq KEY_RIGHT, %rdi
    je handleRightArrowInput
    jmp handleLeftArrowInput

    # TO DO ...

    ret

/*
TO DO
*/
handleRightArrowInput: 
    ret

/*
TO DO
*/
handleLeftArrowInput:
    ret
