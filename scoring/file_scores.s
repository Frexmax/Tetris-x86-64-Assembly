.data
    currentScore: .quad 0               # Holds current game score
    firstScore: .quad 0                 # holds the best score read from file
    secondScore: .quad 0 
    thirdScore: .quad 0 
    fourthScore: .quad 0 
    fifthScore: .quad 0 
                                                                                
    filename: .asciz "scoring/top_scores.txt"   # File containing the top score
    format: .asciz "%d\n"                       # format used to read from the file
    fileModeRead: .asciz "r"                    # Read mode
    fileModeWrite: .asciz "w"                   # Write mode
    filePointer: .quad 0                        # pointer to the file


.text
    .extern fopen                   
    .extern fread
    .extern fwrite
    .extern fclose

# Function to read the best score from TopScore.txt
# void
readBestScore:
    # Save used registers
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rax
    subq $8, %rsp                          # ensure 16-byte alligned
    
    # Open file for reading: fopen("TopScore.txt", "r")
    movq $filename, %rdi                   # File name
    movq $fileModeRead, %rsi               # Mode: read ("r")
    call fopen                             # fopen returns file pointer in %rax
    movq %rax, filePointer                 # Save file pointer

    # Load 1st best score
    movq filePointer, %rdi                 # Address of bestScore
    movq $format, %rsi                     # Size of a long (8 bytes)
    movq $firstScore, %rdx                 # Number of items to read
    call fscanf                            # fread(&bestScore, 8, 1, filePointer)

    # Load 2nd best score
    movq filePointer, %rdi                 # Address of bestScore
    movq $format, %rsi                     # Size of a long (8 bytes)
    movq $secondScore, %rdx                # Number of items to read
    call fscanf                            # fread(&bestScore, 8, 1, filePointer)

    # Load 3rd best score
    movq filePointer, %rdi                 # Address of bestScore
    movq $format, %rsi                     # Size of a long (8 bytes)
    movq $thirdScore, %rdx                 # Number of items to read
    call fscanf                            # fread(&bestScore, 8, 1, filePointer)

    # Load 4th best score
    movq filePointer, %rdi                 # Address of bestScore
    movq $format, %rsi                     # Size of a long (8 bytes)
    movq $fourthScore, %rdx                # Number of items to read
    call fscanf                            # fread(&bestScore, 8, 1, filePointer)

    # Load 5th best score
    movq filePointer, %rdi                 # Address of bestScore
    movq $format, %rsi                     # Size of a long (8 bytes)
    movq $fifthScore, %rdx                 # Number of items to read
    call fscanf                            # fread(&bestScore, 8, 1, filePointer)

    # Close the file: fclose(filePointer)
    movq filePointer, %rdi                 # File pointer
    call fclose                            # fclose(filePointer)


    addq $8, %rsp
    # Retrieve saved registers
    popq %rax
    popq %rdx
    popq %rsi
    popq %rdi
    ret

# Function to write the best score to TopScore.txt
writeBestScore:
    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %rax

    # Open file for writing: fopen("TopScore.txt", "w")
    movq $filename, %rdi                   # File name
    movq $fileModeWrite, %rsi              # Mode: write ("w")
    call fopen                             # fopen returns file pointer in %rax
    movq %rax, filePointer                 # Save file pointer

    # write 1st best score 
    movq filePointer, %rdi
    movq $format, %rsi
    movq firstScore, %rdx
    call fprintf

    # write 2nd best score 
    movq filePointer, %rdi
    movq $format, %rsi
    movq secondScore, %rdx
    call fprintf

    # write 3rd best score 
    movq filePointer, %rdi
    movq $format, %rsi
    movq thirdScore, %rdx
    call fprintf

    # write 4th best score 
    movq filePointer, %rdi
    movq $format, %rsi
    movq fourthScore, %rdx
    call fprintf

    # write 5th best score 
    movq filePointer, %rdi
    movq $format, %rsi
    movq fifthScore, %rdx
    call fprintf

    # Close the file: fclose(filePointer)
    movq filePointer, %rdi                 # File pointer
    call fclose                            # fclose(filePointer)

    popq %rax
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    ret

# Function to check if currentScore is greater than bestScore
# void
checkAndUpdateTopScore:
    pushq %rax

    movq currentScore, %rax                # Load currentScore
    cmpq fifthScore, %rax                  # Compare currentScore with bestScore
    jle skipUpdate                         # If currentScore <= bestScore, skip update

    cmpq fourthScore, %rax                 # Compare currentScore with bestScore
    jle newScoreFifthScore                 # If currentScore <= bestScore, skip update 

    cmpq thirdScore, %rax                  # Compare currentScore with bestScore
    jle newScoreFourthScore                # If currentScore <= bestScore, skip update 

    cmpq secondScore, %rax                 # Compare currentScore with bestScore
    jle newScoreThirdScore                 # If currentScore <= bestScore, skip update 

    cmpq firstScore, %rax                  # Compare currentScore with bestScore
    jle newScoreSecondScore                # If currentScore <= bestScore, skip update 

    jmp newScoreFirstScore

    # If currentScore > fifth scores  - update ranking table
    newScoreFirstScore:
        movq fourthScore, %rdi
        movq thirdScore, %rsi
        movq secondScore, %rdx
        movq firstScore, %rcx
        movq %rax, firstScore
        movq %rcx, secondScore
        movq %rdx, thirdScore
        movq %rsi, fourthScore
        movq %rdi, fifthScore

        jmp writeNewScores

    newScoreSecondScore:
        movq fourthScore, %rdi
        movq thirdScore, %rsi
        movq secondScore, %rdx
        movq %rax, secondScore
        movq %rdx,thirdScore
        movq %rsi, fourthScore
        movq %rdi, fifthScore

        jmp writeNewScores

    newScoreThirdScore:
        movq fourthScore, %rdi
        movq thirdScore, %rsi
        movq %rax, thirdScore
        movq %rsi, fourthScore
        movq %rdi, fifthScore

        jmp writeNewScores

    newScoreFourthScore:
        movq fourthScore, %rdi
        movq %rax, fourthScore
        movq %rdi, fifthScore
        jmp writeNewScores

    newScoreFifthScore:
        movq %rax, fifthScore
        jmp writeNewScores

    writeNewScores:
        call writeBestScore                    # Write new bestScore to file

skipUpdate:
    popq %rax
    ret
