/*
// AudioStream, custom audio stream
typedef struct AudioStream {
    1. (64 bit) rAudioBuffer *buffer;       // Pointer to internal data used by the audio system
    2. (64 bit) rAudioProcessor *processor; // Pointer to internal data processor, useful for audio effects

    3. (32 bit) unsigned int sampleRate;    // Frequency (samples per second)  
    4. (32 bit) unsigned int sampleSize;    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    5. (32 bit) unsigned int channels;      // Number of channels (1-mono, 2-stereo, ...)
} AudioStream; <-- size 224 bits, 28 bytes


// Music, audio stream, anything longer than ~10 seconds should be streamed
typedef struct Music {
    1. (224 bits) AudioStream stream;         // Audio stream
    2. (32 bits) unsigned int frameCount;    // Total number of frames (considering channels)
    3. (1 bit) bool looping;               // Music looping enable

    4. (32 bit) int ctxType;                // Type of music context (audio filetype)
    5. (64 bit) void *ctxData;              // Audio context data, depends on type
} Music; <--- 352 bits + 1 = 44 bytes + 1 bit

*/

.data

.text
    windowTitle: .asciz "music"
    audioPath: .asciz "tetris-theme-korobeiniki-piano.mp3"

	.globl	main
	.type	main, @function

main:
    pushq %rbp
    movq %rsp, %rbp
    
    movq $800, %rdi              # arg 1 - int - screen width
    movq $800, %rsi             # arg 2 - int - screen height
    movq $windowTitle, %rdx             # arg 3 - string - message
    call InitWindow                     # call raylib to initialize window

    call InitAudioDevice

    // KINDA DONT KNOW HOW THIS WORKS, BUT FINE FOR NOW!!!!!!! 80 seems to be the magic number!!!
    subq $80, %rsp                     # look why 80 works and 72 doesn't ????
    leaq -80(%rbp), %rax
    
    movq $audioPath, %rdx
    movq %rdx, %rsi
    movq %rax, %rdi
    call LoadMusicStream

	subq	$8, %rsp
	pushq	-32(%rbp)
	pushq	-40(%rbp)
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	pushq	-72(%rbp)
	pushq	-80(%rbp)
    
    call	PlayMusicStream    

	movq $60, %rdi                      # first arg for SetTargetFPS - targetFPS
	call SetTargetFPS                   # call raylib to set target frame rate
    
    jmp mainGameLoop                    # go to main game loop 

mainGameLoop:
    call WindowShouldClose              # check if the window should be closed: when escape key pressed or window close icon clicked
    cmpq $0, %rax                       # if WindowShouldClose returns true (anything else than 0) then exit program
	jne quitGame                        # quit game
    
    leaq -80(%rbp), %rax
    movq %rax, %rdi

	subq	$8, %rsp
	pushq	-32(%rbp)
	pushq	-40(%rbp)
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	pushq	-72(%rbp)
	pushq	-80(%rbp)
	call	UpdateMusicStream@PLT

    call BeginDrawing                   # Setup raylib canvas to start drawing
        movq $0xffffffff, %rdi                # arg 1 - 32-bits RGBA - color
        call ClearBackground            # clear background with color in struct on stack
    call EndDrawing                     # End canvas drawing
    
    jmp mainGameLoop                    # next iteration of the game

quitGame:
    call CloseWindow                    # close window
    call CloseAudioDevice
    
    movq %rbp, %rsp
    popq %rbp
            	                        # close stack frame
    movq $0, %rdi                       # error code 0, all successful
    call exit                           
