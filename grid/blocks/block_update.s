.text

/* 
Checks user keyboard input, if the user pressed:
    - RIGHT ARROW : check if it's possible to move the tetrino right, if yes, do it, else no changes
    - LEFT ARROW : check if it's possible to move the tetrino left, if yes, do it, else no changes
    - UP ARROW : check if it's possible to rotate the tetrino, if yes, do it, else no changes
    - ELSE : don't make any changes
*/
takeAction:
    # save register used in the subroutine
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %r8
    pushq %r9
    
    call GetKeyPressed                  # get currently pressed key in rax, 0 if no key pressed

    cmpq KEY_DOWN, %rax                 # if the current key pressed is the DOWN ARROW key:
    je accelerateFallCommand            # increase the fallRateMultiplier

    cmpq KEY_RIGHT, %rax                # if the current key pressed is the RIGHT ARROW key:
    je moveRightCommand                 # try to move the tetrino to the right

    cmpq KEY_LEFT, %rax                 # if the current key pressed is the LEFT ARROW key:
    je moveLeftCommand                  # try to move the tetrino to the left

    cmpq KEY_UP, %rax                   # if the current key pressed is the UP ARROW key:
    je rotateCommand                    # try to rotate the tetrino

    jmp exitTakeAction                  # if none of the above, then either no key was pressed or an invalid one, exit subroutine

    moveRightCommand:
        movq $1, fallRateMultiplier     # if the user pressed another key (not arrow down), reset fallRateMultiplier to default
        
        movq currentBlockType, %rdi     # arg 1 of checkCanGoRight - the type of the current block 
        call checkCanGoRight            # returns if moving right is possible

        cmpq TRUE, %rax                 # if moving right is not possible:
        jne exitTakeAction              # exit subroutine

        call clearTetrino               # clear the current position of the tetrino from the grid
        call goRight                    # move the tetrino right
        call setTetrino                 # write the position of the tetrino after moving to the grid

        jmp exitTakeAction              # action performed, exit subroutine

    moveLeftCommand:
        movq $1, fallRateMultiplier     # if the user pressed another key (not arrow down), reset fallRateMultiplier to default
        
        movq currentBlockType, %rdi     # arg 1 of checkCanGoLeft - the type of the current block 
        call checkCanGoLeft             # returns if moving left is possible
        
        cmpq TRUE, %rax                 # if moving left is not possible:
        jne exitTakeAction              # then exit subroutine

        call clearTetrino               # clear the current position of the tetrino from the grid
        call goLeft                     # then move the tetrino left
        call setTetrino                 # write the position of the tetrino after moving to the grid

        jmp exitTakeAction              # action performed, exit subroutine

    rotateCommand:
        movq $1, fallRateMultiplier     # if the user pressed another key, reset fallRateMultiplier to default

        movq currentBlockType, %rdi     # arg 1 of checkCanRotate - the type of the current block  
        call checkCanRotate             # returns if rotating the tetrino is possible

        cmpq TRUE, %rax                 # if rotating the tetrino is possible:
        jne exitTakeAction              # then rotate the tetrino

        call clearTetrino               # clear the current position of the tetrino from the grid
        movq currentBlockType, %rdi     # pass the type of the tetrino to rotate subroutine (rotation dependent on type)
        call rotate                     # rotate tetrino
        call setTetrino                 # write the position of the tetrino after rotation to the grid

        jmp exitTakeAction              # action performed, exit subroutine

    accelerateFallCommand:
        addq $2, fallRateMultiplier     # double the fall rate, for each down arrow press
        jmp exitTakeAction              

    exitTakeAction:
        # retrieve register used in the subroutine
        popq %r9
        popq %r8
        popq %rdx
        popq %rsi
        popq %rdi             
        ret

/*
Check if tetrino can fall, if yes, drop it down, else generate new one and check if it's game over
@return - TRUE (1) is game over, FALSE (0) game continues
*/
tryFall:
    # save registers used
    pushq %rdi
    pushq %rsi
                                        
    incq fallingCounter                 # increment counter for next fall 
    movq framesPerFall, %rdi            

    movq fallingCounter, %rsi
    imulq fallRateMultiplier, %rsi      

    cmpq %rdi, %rsi                     # check if the tetrino should fall this frame
    jge attemptFall                     

    movq FALSE, %rax                    # if not, then game continous (rax output 0)
    jmp exitTryFall

    attemptFall:
        movq $0, fallingCounter         # tetrino falls, so fallingCounter reset

        movq currentBlockType, %rdi     # arg 1 of checkCanFall - the type of the current block 
        call checkCanFall               # returns if falling is possible
        
        cmpq TRUE, %rax                 # if moving falling is possible:
        je executeFall                  # drop tetrino
        jmp fallNotPossible             # else
        
        executeFall:
            call clearTetrino           # clear current tetrino positions from the grid
            call fall                   # drop the tetrino by 1 (y)
            call setTetrino             # write the new position of the tetrino to the grid

            movq FALSE, %rax            # game continues (rax output 0)
            jmp exitTryFall

        fallNotPossible:    
            call checkGrid              # check grid for full lines and update if so    
            call checkGameOver          # check if the game is over

        jmp exitTryFall

    exitTryFall:
        popq %rsi
        popq %rdi
        ret
