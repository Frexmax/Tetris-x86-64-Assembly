.include "utils/utils.s"
.include "colors/colors.s"
.include "config/config.s"
.include "grid/grid.s"

.data

.text
    out: .asciz "x: %d, y: %d\n"

	.globl	main
	.type	main, @function

main:
    prologue                            # set up stack frame

    movq $out, %rdi
    movzbq %al, %rsi
    movb %ah, %al
    movzbq %al, %rdx
    movq $0, %rax
    call printf


    initializeScreenSize                # initialize screen width and height based on cell size and grid size
    movq screenWidth, %rdi              # arg 1 - int - screen width
    movq screenHeight, %rsi             # arg 2 - int - screen height
    movq $windowTitle, %rdx             # arg 3 - string - message
    call InitWindow                     # call raylib to initialize window

	movq targetFPS, %rdi                # first arg for SetTargetFPS - targetFPS
	call SetTargetFPS                   # call raylib to set target frame rate

    jmp mainGameLoop                    # go to main game loop 

mainGameLoop:
	call WindowShouldClose              # check if the window should be closed: when escape key pressed or window close icon clicked
    cmpq $0, %rax                       # if WindowShouldClose returns true (anything else than 0) then exit program
	jne quitGame                        # quit game

    call BeginDrawing                   # Setup raylib canvas to start drawing
        movq WHITE, %rdi                # arg 1 - 32-bits RGBA - color
        call ClearBackground            # clear background with color in struct on stack
    call EndDrawing                     # End canvas drawing

    jmp mainGameLoop                    # next iteration of the game

quitGame:                               #yay that's the end
    call CloseWindow                    # close window
    epilogue	                        # close stack frame
    movq $0, %rdi                       # error code 0, all successful
    call exit                           
