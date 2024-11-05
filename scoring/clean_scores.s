.data
    filename: .asciz "scoring/TopScore.txt" # File containing the top score
    format: .asciz "%d\n"               # format used to read from the file
    fileModeRead: .asciz "r"            # Read mode
    fileModeWrite: .asciz "w"           # Write mode
    filePointer: .quad 0                # pointer to the file


.text
    .globl	main
    .type	main, @function

    .extern fopen                   
    .extern fread
    .extern fwrite
    .extern fclose


# Function to write the best score to TopScore.txt
main:
    pushq %rbp
    movq %rsp, %rbp

    pushq %rdi
    pushq %rsi
    pushq %rdx
    pushq %rcx

    # Open file for writing: fopen("TopScore.txt", "w")
    movq $filename, %rdi                   # File name
    movq $fileModeWrite, %rsi              # Mode: write ("w")
    call fopen                             # fopen returns file pointer in %rax
    movq %rax, filePointer                 # Save file pointer

    movq $0, %rcx
    fileWriteLoop:
        incq %rcx

        pushq %rcx
        pushq %rcx

        movq filePointer, %rdi
        movq $format, %rsi
        movq $0, %rdx
        call fprintf

        popq %rcx
        popq %rcx

        cmpq $5, %rcx
        jl fileWriteLoop

    # Close the file: fclose(filePointer)
    movq filePointer, %rdi                 # File pointer
    call fclose                            # fclose(filePointer)

    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    
    movq %rbp, %rsp
    popq %rbp
    ret
