.text

/* 
Get the keyboard command - left, right arrows
@return - rax - the value of the command key, return 0 if none of the valid commands
*/
getCurrentCommand:
    pushq %rdi
                                        
    movq KEY_RIGHT, %rdi                # check if the right arrow is pressed 
    call IsKeyDown                                
    cmpq FALSE, %rax                    # if function returns TRUE (not 0), return the value of KEY_RIGHT, else continue and check left arrow key
    jne rightArrowReturn                

    movq KEY_LEFT, %rdi                 # check if the left arrow is pressed
    call IsKeyDown                       
    cmpq FALSE, %rax                    # if function returns TRUE (not 0), return the value of KEY_LEFT 
    jne leftArrowReturn

    jmp noKeyOrNotValid                 # if neither KEY_RIGHT or KEY_LEFT key pressed, then return 0 in rax

    rightArrowReturn:
        movq KEY_RIGHT, %rax            # copy KEY_RIGHT value to rax, to be returned
        jmp exitGetCurrentCommand

    leftArrowReturn:
        movq KEY_LEFT, %rax             # copy KEY_LEFT value to rax, to be returned
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
