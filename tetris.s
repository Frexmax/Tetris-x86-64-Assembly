# LOAD ALL PROJECT FILES

.include "input/input_config.s"
.include "utils/utils.s"
.include "colors/colors.s"
.include "config/config.s"
.include "grid/grid.s"
.include "audio/audio.s"
.include "grid/blocks/block_config.s"
.include "info_screen/info_screen.s"
.include "grid/blocks/block_update.s"
.include "grid/blocks/blocks.s"
.include "scoring/file_scores.s"

.include "grid/blocks/t_block/t_block.s"
.include "grid/blocks/o_block/o_block.s"
.include "grid/blocks/i_block/i_block.s"
.include "grid/blocks/s_block/s_block.s"
.include "grid/blocks/z_block/z_block.s"
.include "grid/blocks/l_block/l_block.s"
.include "grid/blocks/j_block/j_block.s"

                                        
.data           
    roundsPlayed: .quad 0               # counter to track how many rounds have been played in this session (i.e. how many game overs)
    
.text

	.globl	main
	.type	main, @function

	.type	checkGameOver, @function


main:
    prologue                            # set up stack frame

    call readBestScore                  # read best score from file
    
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

    # WINDOW FPS
	movq targetFPS, %rdi                # first arg for SetTargetFPS - targetFPS
	call SetTargetFPS                   # call raylib to set target frame rate
    
    # BLOCK CONFIG
    setUpFallingInfo                    # calculate values for the fall rate of blocks   
    setUpBlocksForRound                 # prepare current block and next block for the start of the round

    jmp roundWaitLoop                   # loop to wait for user decision

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

        cmpq $0, roundsPlayed           # if it's the first round this session
        je gameStartDisplay             # go to the special gameStart display
        jmp gameOverDisplay             # else go to gameOver display

        gameStartDisplay:
            call drawStartGameText      # draw basic information text (game start version)
            
            call GetKeyPressed          # call raylib to get currently pressed key
            cmpq KEY_S, %rax            # if the user presses S start a new round
            je mainGameLoop             # go to main game loop
            jmp continueFromDisplays

        gameOverDisplay:
            call drawGameOverText       # draw basic information text (game over version)
            
            call GetKeyPressed          # call raylib to get currently pressed key
            cmpq KEY_R, %rax            # also if the user presses R, then start new round (after game over)
            je mainGameLoop             # go to main game loop
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

    epilogue	                        # close stack frame
    movq $0, %rdi                       # error code 0, all successful
    call exit                           

/* 
Checks if the game is finished, else generate and spawn new block
@param - rdi - type of block
@returns - TRUE (1) is game over, FALSE (0) game continues
*/
checkGameOver:
    pushq %rdi
    pushq %rdi
                                        
    call generateNextTetrino            # generate next tetrino type 
    movq currentBlockType, %rdi         # pass the current tetrino type to spawnBlock
    call spawnBlock                     # check if spawn possible and set a1 to a4 coordinates

    cmpq FALSE, %rax                    # if spawn not possible 
    je gameOver                         # it is game over
    
    movq FALSE, %rax                    # else game continues
    jmp exitCheckGameOver               # and exit subroutine

    gameOver:
        call checkAndUpdateTopScore     # update score, if sufficient value
        resetScoreAndDifficulty         

        incq roundsPlayed               # add this round to rounds played
        call clearGrid                  # set grid to all 0 (start grid)
        setUpFallingInfo                # recalculate falling rate info
        resetFallingInfo                # reset counters for falling
        setUpBlocksForRound             # generate blocks for new round

        movq TRUE, %rax                 # set game over (return value) to true 

    exitCheckGameOver:
        popq %rdi
        popq %rdi
        ret
