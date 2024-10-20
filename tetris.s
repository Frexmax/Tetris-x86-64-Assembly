# ADD BORDER TO GRID???

.include "input/input.s"
.include "utils/utils.s"
.include "colors/colors.s"
.include "config/config.s"
.include "grid/grid.s"
.include "audio/audio.s"
.include "grid/blocks/block_config.s"
.include "info_screen/info_screen.s"
.include "info_screen/fonts.s"

.data   
    roundsPlayed: .quad 0
    roundRunning: .quad 0
    
.text
    digitOut: .asciz "%ld\n"
    keyOut: .asciz "Current Key: %d\n"
    printRegisters: .asciz "RAX: %d, RDI, %d, RSI, %d, RDX: %d\n"
    out: .asciz "x: %d, y: %d\n"
    testStringRight: .asciz "WENT RIGHT\n"
    testStringLeft: .asciz "WENT LEFT\n"
    testStringUp: .asciz "ROTATE\n"

	.globl	main
	.type	main, @function

    .type takeAction @function

    .type generateNextTetrino @function

main:
    prologue                            # set up stack frame

    # call readBestScore                  # read best score from file
    
    # INITALIZE THE RAYLIB WINDOW
    initializeScreenSize                # initialize screen width and height based on cell size and grid size
    movq screenWidth, %rdi              # arg 1 - int - screen width
    movq screenHeight, %rsi             # arg 2 - int - screen height
    movq $windowTitle, %rdx             # arg 3 - string - message
    call InitWindow                     # call raylib to initialize window

    # AUDIO SET UP
    call InitAudioDevice                # call raylib to initialize audio          
    setUpAudio                          # macro to get music struct
    passMusicStruct                     # pass received music struct as argument
    call PlayMusicStream                # play music

    # FONT SET UP
    setUpFont                           # load custom font - under development

    # WINDOW FPS
	movq targetFPS, %rdi                # first arg for SetTargetFPS - targetFPS
	call SetTargetFPS                   # call raylib to set target frame rate
    
    # BLOCK CONFIG
    setUpFallingInfo                    # calculate values for the fall rate of blocks   
    setUpBlocksForRound                 # prepare current block and next block for the start of the round

    jmp roundWaitLoop                 # loop to wait for user decision

roundWaitLoop:
    call WindowShouldClose              # check if the window should be closed: when escape key pressed or window close icon clicked
    cmpq $0, %rax                       # if WindowShouldClose returns true (anything else than 0) then exit program
	jne quitGame                        # quit game
    
    passMusicStruct                     # pass music struct
    call UpdateMusicStream              # play the next part of the music
    cleanMusicStruct

    call BeginDrawing                   # Setup raylib canvas to start drawing
        movq INFOSCREENBACKGROUND, %rdi # arg 1 - 32-bits RGBA - color
        call ClearBackground            # clear background with color in struct on stack

        call drawGrid                   # draw based on the value of the buffer (our grid)
        call drawInfoScreen             # draw information of the info screen

        cmpq $0, roundsPlayed
        je gameStartDisplay
        jmp gameOverDisplay

        gameStartDisplay:
            call drawStartGameText
            
            call GetKeyPressed                  # call raylib to get currently pressed key
            cmpq KEY_S, %rax                    # if the user presses S start a new round
            je mainGameLoop                     # go to main game loop
            jmp continueFromDisplays

        gameOverDisplay:
            call drawGameOverText
            
            call GetKeyPressed                  # call raylib to get currently pressed key
            cmpq KEY_R, %rax                    # also if the user presses R, then start new round (after game over)
            je mainGameLoop                     # go to main game loop
            jmp continueFromDisplays

        continueFromDisplays:

    call EndDrawing                     # End canvas drawing

    jmp roundWaitLoop

mainGameLoop:
    call WindowShouldClose              # check if the window should be closed: when escape key pressed or window close icon clicked
    cmpq $0, %rax                       # if WindowShouldClose returns true (anything else than 0) then exit program
	jne quitGame                        # quit game
    
    passMusicStruct                     # pass music struct
    call UpdateMusicStream              # play the next part of the music
    cleanMusicStruct

    call tryFall                        # update block fall
    cmpq TRUE, %rax
    je roundWaitLoop

    call takeAction                     # handle potential user input

    call BeginDrawing                   # Setup raylib canvas to start drawing
        movq INFOSCREENBACKGROUND, %rdi # arg 1 - 32-bits RGBA - color
        call ClearBackground            # clear background with color in struct on stack

        call drawGrid                   # draw based on the value of the buffer (our grid)
        call drawInfoScreen             # draw information of the info screen
    call EndDrawing                     # End canvas drawing
    
    jmp mainGameLoop                    # next iteration of the game

quitGame:
    call CloseWindow                    # close window
    call CloseAudioDevice

    # call checkAndUpdateScore          # write the best score to file

    epilogue	                        # close stack frame
    movq $0, %rdi                       # error code 0, all successful
    call exit                           

/* 
@param - rdi - type of block
@returns - TRUE (1) is game over, FALSE (0) game continues
*/
checkGameOver:
    pushq %rdi
    pushq %rdi
    
    call generateNextTetrino
    movq currentBlockType, %rdi
    call spawnBlock
    
    cmpq FALSE, %rax
    je gameOver
    movq FALSE, %rax
    jmp exitCheckGameOver

    gameOver:
        movq $0, currentScore
        movq $0, currentLevel
        movq $0, generationCounter
        incq roundsPlayed
        call clearGrid
        setUpFallingInfo
        resetFallingInfo
        setUpBlocksForRound
        movq TRUE, %rax

    exitCheckGameOver:
        popq %rdi
        popq %rdi
        ret

/*
Randomly generate the type of the next tetrino to be spawned
@return - the type of the next tetrino (rax)
*/
generateNextTetrino:
    pushq %rdi
    pushq %rsi
    pushq %rdx

    # CHECK IF DIFFICULTY LEVEL SHOULD BE INCREMENTED
    incq generationCounter
    movq generationCounter, %rdi
    cmpq generationPerLevelIncrease, %rdi
    jge nextLevel
    jmp keepLevel

    nextLevel:
        incq currentLevel
        decq framesPerFall
        movq $0, generationCounter
    keepLevel:

    movq nextBlockType, %rdi
    movq %rdi, currentBlockType

    # Call GetRandomValue(min, max) with min = 1, max = 7
    movq $1, %rdi                # min argument
    movq blockCount, %rsi        # max argument (7)
    call GetRandomValue          # call the raylib function

    movq %rax, nextBlockType
    # movq %rax, currentBlockType  # store the result as the current block type

    movq nextBlockType, %rdi
    call setInfoPointsFromNextType

    popq %rdx
    popq %rsi
    popq %rdi
    ret                         
/*
TO DO
@return - TRUE (1) is game over, FALSE (0) game continues
*/
tryFall:
    # save registers used
    pushq %rdi
    pushq %rsi

    incq fallingCounter
    movq framesPerFall, %rdi
    movq fallingCounter, %rsi
    imulq fallRateMultiplier, %rsi

    cmpq %rdi, %rsi
    jge attemptFall 

    movq FALSE, %rax
    jmp exitTryFall

    attemptFall:
        # subq %rdi, fallingCounter        
        movq $0, fallingCounter

        movq currentBlockType, %rdi     # arg 1 of checkCanGoLeft - the type of the current block 
        call checkCanFall               # returns if moving left is possible
        
        cmpq TRUE, %rax                 # if moving left is possible:
        je executeFall
        jmp fallNotPossible
        
        executeFall:
            movq currentBlockType, %rdi
            call clearTetrino

            movq currentBlockType, %rdi
            call fall                       # then move the tetrino left

            movq currentBlockType, %rdi
            call setTetrino

            movq FALSE, %rax
            jmp exitTryFall

        fallNotPossible:
            call checkGrid                  # BUGGY
            call checkGameOver

        jmp exitTryFall

    exitTryFall:
        popq %rsi
        popq %rdi
        ret

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

    #movq $windowTitle, %rdi            # pass text to DrawText
    #movq 0, %rsi                        # X position
    #movq 0, %rdx                        # Y position
    #movq $16, %r8                  # font size
    #movq $0xFFFFFFFF, %r9               # text color (white)
    #call DrawText                       # draw the text on the screen
    
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
        movq $1, fallRateMultiplier    # if the user pressed another key, reset fallRateMultiplier to default
        
        movq currentBlockType, %rdi     # arg 1 of checkCanGoRight - the type of the current block 
        call checkCanGoRight            # returns if moving right is possible

        cmpq TRUE, %rax                 # if moving right is possible:
        jne exitTakeAction

        call clearTetrino
        call goRight                       # then move the tetrino left
        call setTetrino

        jmp exitTakeAction              # action performed, exit subroutine

    moveLeftCommand:
        movq $1, fallRateMultiplier    # if the user pressed another key, reset fallRateMultiplier to default

        movq currentBlockType, %rdi     # arg 1 of checkCanGoLeft - the type of the current block 
        call checkCanGoLeft             # returns if moving left is possible
        
        cmpq TRUE, %rax                 # if moving left is possible:
        jne exitTakeAction                     # then move the tetrino left

        call clearTetrino
        call goLeft                       # then move the tetrino left
        call setTetrino

        jmp exitTakeAction              # action performed, exit subroutine

    rotateCommand:
        movq $1, fallRateMultiplier    # if the user pressed another key, reset fallRateMultiplier to default

        movq currentBlockType, %rdi     # arg 1 of checkCanRotate - the type of the current block  
        call checkCanRotate             # returns if rotating the tetrino is possible

        cmpq TRUE, %rax                 # if rotating the tetrino is possible:
        jne exitTakeAction                     # then rotate the tetrino

        call clearTetrino
        movq currentBlockType, %rdi
        call rotate                       # then move the tetrino left
        call setTetrino

        jmp exitTakeAction              # action performed, exit subroutine

    accelerateFallCommand:
        # movq $4, fallRateMultiplier
        addq $2, fallRateMultiplier
        jmp exitTakeAction

    exitTakeAction:
        # retrieve register used in the subroutine
        popq %r9
        popq %r8
        popq %rdx
        popq %rsi
        popq %rdi             
        ret
