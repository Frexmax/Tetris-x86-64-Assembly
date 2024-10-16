.data

.text
    audioPath: .asciz "audio/resources/tetris-theme-korobeiniki-piano.mp3"

.macro setUpAudio 
    subq $80, %rsp                     # look why 80 works and 72 doesn't ????
    leaq -80(%rbp), %rax

    movq $audioPath, %rdx
    movq %rdx, %rsi
    movq %rax, %rdi
    call LoadMusicStream
.endm

.macro passMusicStruct
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
.endm
