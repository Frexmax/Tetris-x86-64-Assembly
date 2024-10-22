.text
    audioPath: .asciz "audio/resources/tetris-theme-korobeiniki-piano.mp3"

.macro setUpAudio 
    subq $80, %rsp                      # save space for Music struct
    leaq -80(%rbp), %rdi				# pass the address of the beginning of the struct rdi

    movq $audioPath, %rsi				# audio file path as second argument
    call LoadMusicStream
.endm

.macro passMusicStruct
    leaq -80(%rbp), %rdi			 	# again load address of beginning of the Music struct (first argument)
    
    subq	$8, %rsp					
	pushq	-32(%rbp)					# push the values of the struct onto the stack
	pushq	-40(%rbp)					
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	pushq	-72(%rbp)
	pushq	-80(%rbp)
.endm

.macro cleanMusicStruct    
	popq	%rax						# remove the values of the Music struct from the stack
	popq	%rax
	popq	%rax
	popq	%rax
	popq	%rax
	popq	%rax
	popq	%rax
    addq $8, %rsp
.endm
