	.file	"main.c"
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"raylib [audio] example - music playing (streaming)"
	.align 8
.LC1:
	.string	"tetris-theme-korobeiniki-piano.mp3"
.LC4:
	.string	"MUSIC SHOULD BE PLAYING!"
.LC6:
	.string	"PRESS SPACE TO RESTART MUSIC"
.LC7:
	.string	"PRESS P TO PAUSE/RESUME MUSIC"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$112, %rsp
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movl	$800, -88(%rbp)
	movl	$450, -84(%rbp)
	movl	-84(%rbp), %ecx
	movl	-88(%rbp), %eax
	leaq	.LC0(%rip), %rdx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	InitWindow@PLT
	call	InitAudioDevice@PLT
	leaq	-80(%rbp), %rax
	leaq	.LC1(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	LoadMusicStream@PLT
	subq	$8, %rsp
	pushq	-32(%rbp)
	pushq	-40(%rbp)
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	pushq	-72(%rbp)
	pushq	-80(%rbp)
	call	PlayMusicStream@PLT
	addq	$64, %rsp
	pxor	%xmm0, %xmm0
	movss	%xmm0, -92(%rbp)
	movb	$0, -93(%rbp)
	movl	$30, %edi
	call	SetTargetFPS@PLT
	jmp	.L2
.L8:
	subq	$8, %rsp
	pushq	-32(%rbp)
	pushq	-40(%rbp)
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	pushq	-72(%rbp)
	pushq	-80(%rbp)
	call	UpdateMusicStream@PLT
	addq	$64, %rsp
	movl	$32, %edi
	call	IsKeyPressed@PLT
	testb	%al, %al
	je	.L3
	subq	$8, %rsp
	pushq	-32(%rbp)
	pushq	-40(%rbp)
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	pushq	-72(%rbp)
	pushq	-80(%rbp)
	call	StopMusicStream@PLT
	addq	$64, %rsp
	subq	$8, %rsp
	pushq	-32(%rbp)
	pushq	-40(%rbp)
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	pushq	-72(%rbp)
	pushq	-80(%rbp)
	call	PlayMusicStream@PLT
	addq	$64, %rsp
.L3:
	movl	$80, %edi
	call	IsKeyPressed@PLT
	testb	%al, %al
	je	.L4
	movzbl	-93(%rbp), %eax
	testl	%eax, %eax
	setne	%al
	xorl	$1, %eax
	movzbl	%al, %eax
	movb	%al, -93(%rbp)
	andb	$1, -93(%rbp)
	cmpb	$0, -93(%rbp)
	je	.L5
	subq	$8, %rsp
	pushq	-32(%rbp)
	pushq	-40(%rbp)
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	pushq	-72(%rbp)
	pushq	-80(%rbp)
	call	PauseMusicStream@PLT
	addq	$64, %rsp
	jmp	.L4
.L5:
	subq	$8, %rsp
	pushq	-32(%rbp)
	pushq	-40(%rbp)
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	pushq	-72(%rbp)
	pushq	-80(%rbp)
	call	ResumeMusicStream@PLT
	addq	$64, %rsp
.L4:
	subq	$8, %rsp
	pushq	-32(%rbp)
	pushq	-40(%rbp)
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	pushq	-72(%rbp)
	pushq	-80(%rbp)
	call	GetMusicTimePlayed@PLT
	addq	$64, %rsp
	movd	%xmm0, %r12d
	subq	$8, %rsp
	pushq	-32(%rbp)
	pushq	-40(%rbp)
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	pushq	-72(%rbp)
	pushq	-80(%rbp)
	call	GetMusicTimeLength@PLT
	addq	$64, %rsp
	movaps	%xmm0, %xmm1
	movd	%r12d, %xmm0
	divss	%xmm1, %xmm0
	movss	%xmm0, -92(%rbp)
	movss	-92(%rbp), %xmm0
	movss	.LC3(%rip), %xmm1
	comiss	%xmm1, %xmm0
	jbe	.L6
	movss	.LC3(%rip), %xmm0
	movss	%xmm0, -92(%rbp)
.L6:
	call	BeginDrawing@PLT
	movb	$-11, %bl
	movl	$-11, %eax
	movb	%al, %bh
	movl	%ebx, %eax
	andl	$-16711681, %eax
	orl	$16056320, %eax
	movl	%eax, %ebx
	movl	%ebx, %eax
	orl	$-16777216, %eax
	movl	%eax, %ebx
	movl	%ebx, %edi
	call	ClearBackground@PLT
	movl	-100(%rbp), %ecx
	movb	$-56, %cl
	movl	$-56, %eax
	movb	%al, %ch
	andl	$-16711681, %ecx
	movl	%ecx, %eax
	orl	$13107200, %eax
	orl	$-16777216, %eax
	movl	%eax, -100(%rbp)
	movl	%eax, %r8d
	movl	$20, %ecx
	movl	$150, %edx
	movl	$255, %esi
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	call	DrawText@PLT
	movl	-104(%rbp), %edx
	movb	$-56, %dl
	movl	$-56, %eax
	movb	%al, %dh
	andl	$-16711681, %edx
	movl	%edx, %eax
	orl	$13107200, %eax
	orl	$-16777216, %eax
	movl	%eax, -104(%rbp)
	movl	%eax, %r8d
	movl	$12, %ecx
	movl	$400, %edx
	movl	$200, %esi
	movl	$200, %edi
	call	DrawRectangle@PLT
	movl	-108(%rbp), %ecx
	movb	$-66, %cl
	movl	$33, %eax
	movb	%al, %ch
	andl	$-16711681, %ecx
	movl	%ecx, %eax
	orl	$3604480, %eax
	orl	$-16777216, %eax
	movl	%eax, %ecx
	movl	%ecx, -108(%rbp)
	movss	-92(%rbp), %xmm1
	movss	.LC5(%rip), %xmm0
	mulss	%xmm1, %xmm0
	cvttss2sil	%xmm0, %eax
	movl	%ecx, %r8d
	movl	$12, %ecx
	movl	%eax, %edx
	movl	$200, %esi
	movl	$200, %edi
	call	DrawRectangle@PLT
	movl	-112(%rbp), %edx
	movb	$-126, %dl
	movl	$-126, %eax
	movb	%al, %dh
	andl	$-16711681, %edx
	movl	%edx, %eax
	orl	$8519680, %eax
	orl	$-16777216, %eax
	movl	%eax, -112(%rbp)
	movl	%eax, %r8d
	movl	$12, %ecx
	movl	$400, %edx
	movl	$200, %esi
	movl	$200, %edi
	call	DrawRectangleLines@PLT
	movl	-116(%rbp), %ecx
	movb	$-56, %cl
	movl	$-56, %eax
	movb	%al, %ch
	andl	$-16711681, %ecx
	movl	%ecx, %eax
	orl	$13107200, %eax
	orl	$-16777216, %eax
	movl	%eax, -116(%rbp)
	movl	%eax, %r8d
	movl	$20, %ecx
	movl	$250, %edx
	movl	$215, %esi
	leaq	.LC6(%rip), %rax
	movq	%rax, %rdi
	call	DrawText@PLT
	movl	-120(%rbp), %edx
	movb	$-56, %dl
	movl	$-56, %eax
	movb	%al, %dh
	andl	$-16711681, %edx
	movl	%edx, %eax
	orl	$13107200, %eax
	orl	$-16777216, %eax
	movl	%eax, -120(%rbp)
	movl	%eax, %r8d
	movl	$20, %ecx
	movl	$280, %edx
	movl	$208, %esi
	leaq	.LC7(%rip), %rax
	movq	%rax, %rdi
	call	DrawText@PLT
	call	EndDrawing@PLT
.L2:
	call	WindowShouldClose@PLT
	xorl	$1, %eax
	testb	%al, %al
	jne	.L8
	subq	$8, %rsp
	pushq	-32(%rbp)
	pushq	-40(%rbp)
	pushq	-48(%rbp)
	pushq	-56(%rbp)
	pushq	-64(%rbp)
	pushq	-72(%rbp)
	pushq	-80(%rbp)
	call	UnloadMusicStream@PLT
	addq	$64, %rsp
	call	CloseAudioDevice@PLT
	call	CloseWindow@PLT
	movl	$0, %eax
	movq	-24(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L10
	call	__stack_chk_fail@PLT
.L10:
	leaq	-16(%rbp), %rsp
	popq	%rbx
	popq	%r12
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC3:
	.long	1065353216
	.align 4
.LC5:
	.long	1137180672
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
