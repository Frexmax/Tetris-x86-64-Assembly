.include "input/input.s"
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
    
    initializeScreenSize                # initialize screen width and height based on cell size and grid size
    movq screenWidth, %rdi              # arg 1 - int - screen width
    movq screenHeight, %rsi             # arg 2 - int - screen height
    movq $windowTitle, %rdx             # arg 3 - string - message
    call InitWindow                     # call raylib to initialize window

	movq targetFPS, %rdi                # first arg for SetTargetFPS - targetFPS
	call SetTargetFPS                   # call raylib to set target frame rate
    

movq $buffer, %r9
    movb $0, (%r9)
    movb $23, 1(%r9)
    movb $0, 2(%r9)
    movb $1, 3(%r9)
    movb $0, 4(%r9)
    movb $1, 5(%r9)
    movb $0, 6(%r9)
    movb $1, 7(%r9)
    movb $0, 8(%r9)
    movb $1, 9(%r9)

    movb $1, 10(%r9)
    movb $0, 11(%r9)
    movb $1, 12(%r9)
    movb $0, 13(%r9)
    movb $1, 14(%r9)
    movb $0, 15(%r9)
    movb $1, 16(%r9)
    movb $0, 17(%r9)
    movb $1, 18(%r9)
    movb $0, 19(%r9)

    movb $0, 20(%r9)
    movb $1, 21(%r9)
    movb $0, 22(%r9)
    movb $1, 23(%r9)
    movb $0, 24(%r9)
    movb $1, 25(%r9)
    movb $0, 26(%r9)
    movb $1, 27(%r9)
    movb $0, 28(%r9)
    movb $1, 29(%r9)

    movb $1, 30(%r9)
    movb $1, 31(%r9)
    movb $1, 32(%r9)
    movb $1, 33(%r9)
    movb $1, 34(%r9)
    movb $1, 35(%r9)
    movb $1, 36(%r9)
    movb $1, 37(%r9)
    movb $1, 38(%r9)
    movb $1, 39(%r9)

    movb $0, 180(%r9)
    movb $0, 181(%r9)
    movb $0, 182(%r9)
    movb $1, 183(%r9)
    movb $1, 184(%r9)
    movb $1, 185(%r9)
    movb $0, 186(%r9)
    movb $0, 187(%r9)
    movb $0, 188(%r9)
    movb $0, 189(%r9)

    movb $0, 190(%r9)
    movb $0, 191(%r9)
    movb $0, 192(%r9)
    movb $0, 193(%r9)
    movb $1, 194(%r9)
    movb $0, 195(%r9)
    movb $0, 196(%r9)
    movb $0, 197(%r9)
    movb $0, 198(%r9)
    movb $0, 199(%r9)


    jmp mainGameLoop                    # go to main game loop 

mainGameLoop:
    call WindowShouldClose              # check if the window should be closed: when escape key pressed or window close icon clicked
    cmpq $0, %rax                       # if WindowShouldClose returns true (anything else than 0) then exit program
	jne quitGame                        # quit game

    call getCurrentCommand

    call BeginDrawing                   # Setup raylib canvas to start drawing
        movq WHITE, %rdi                # arg 1 - 32-bits RGBA - color
        call ClearBackground            # clear background with color in struct on stack
        
        # movq $1, %rdi
        # movq $0, %rsi
        # movq $0, %rdx
        # call writeToBufferFromXY

        movq $0, %rdi
        call gridShift

        call drawGrid

    call EndDrawing                     # End canvas drawing

    jmp mainGameLoop                    # next iteration of the game

quitGame:
    call CloseWindow                    # close window
    epilogue	                        # close stack frame
    movq $0, %rdi                       # error code 0, all successful
    call exit                           
