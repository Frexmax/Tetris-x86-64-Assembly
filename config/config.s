.data
    windowTitle: .asciz "Tetris"        # title of the raylib window 
                                        
    ySize: .quad 20                     # number of cells in the x direction
    xSize: .quad 10                     # number of cells in the y direction
    cellNumber: .quad 200               # number of cells = ySize * xSize
    cellSize: .quad 50                  # the length of the cell side - each cell is a square
    
    targetFPS: .quad 30                 # target FPS for raylib - targetFPS also affects music play rate (minimum 30 FPS for good sound)
    screenWidth: .quad 0                # the pixel width of the raylib window - xSize * cellSize (initialized in main)
    screenHeight: .quad 0               # the pixel height of the raylib window - ySize * cellSize (initialized in main)

    currentScore:    .quad 0               # Holds current game score
    bestScore:       .quad 0               # Holds best score read from file
    filename:        .string "TopScore.txt" # File containing the top score
    fileModeRead:    .string "r"           # Read mode
    fileModeWrite:   .string "w"           # Write mode
    filePointer:     .quad 0


.macro initializeScreenSize
    pushq %rax                          # save rax

    movq xSize, %rax                    # copy xSize to rax                   
    mulq cellSize                       # multiply xSize (rax) by cellSize
    movq %rax, screenWidth              # copy xSize * cellSize (rax) to screenWidth

    movq ySize, %rax                    # copy ySize to rax   
    mulq cellSize                       # multiply ySize (rax) by cellSize
    movq %rax, screenHeight             # copy ySize * cellSize (rax) to screenWidth

    popq %rax                           # retrieve rax
.endm

.text
    .extern fopen
    .extern fread
    .extern fwrite
    .extern fclose

# Function to read the best score from TopScore.txt
# void
readBestScore:
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rax
    subq $8, %rsp
    # Open file for reading: fopen("TopScore.txt", "r")
    movq $filename, %rdi                   # File name
    movq $fileModeRead, %rsi               # Mode: read ("r")
    call fopen                             # fopen returns file pointer in %rax
    movq %rax, filePointer                 # Save file pointer

    # Read the score: fread(&bestScore, sizeof(long), 1, filePointer)
    movq $bestScore, %rdi                  # Address of bestScore
    movq $8, %rsi                          # Size of a long (8 bytes)
    movq $1, %rdx                          # Number of items to read
    movq filePointer, %r10                 # File pointer
    call fread                             # fread(&bestScore, 8, 1, filePointer)

    # Close the file: fclose(filePointer)
    movq filePointer, %rdi                 # File pointer
    call fclose                            # fclose(filePointer)

    addq $8, %rsp
    popq %rax
    popq %r10
    popq %rdx
    popq %rsi
    popq %rdi
    ret

# Function to write the best score to TopScore.txt
#void
writeBestScore:
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %r10
    pushq %rax
    subq $8, %rsp

    # Open file for writing: fopen("TopScore.txt", "w")
    movq $filename, %rdi                   # File name
    movq $fileModeWrite, %rsi              # Mode: write ("w")
    call fopen                             # fopen returns file pointer in %rax
    movq %rax, filePointer                 # Save file pointer

    # Write the score: fwrite(&currentScore, sizeof(long), 1, filePointer)
    movq $currentScore, %rdi               # Address of currentScore
    movq $8, %rsi                          # Size of a long (8 bytes)
    movq $1, %rdx                          # Number of items to write
    movq filePointer, %r10                 # File pointer
    call fwrite                            # fwrite(&currentScore, 8, 1, filePointer)

    # Close the file: fclose(filePointer)
    movq filePointer, %rdi                 # File pointer
    call fclose                            # fclose(filePointer)

    addq $8, %rsp
    popq %rax
    popq %r10
    popq %rdx
    popq %rsi
    popq %rdi
    ret

# Function to check if currentScore is greater than bestScore
# void
checkAndUpdateScore:
    pushq %rax

    movq currentScore, %rax                # Load currentScore
    cmpq bestScore, %rax                   # Compare currentScore with bestScore
    jle .skipUpdate                        # If currentScore <= bestScore, skip update

    # If currentScore > bestScore, update bestScore
    movq %rax, bestScore                   # Update bestScore
    call writeBestScore                    # Write new bestScore to file

.skipUpdate:
    popq %rax
    ret
    