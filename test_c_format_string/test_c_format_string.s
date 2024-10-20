	.file	"test_c_format_string.c"
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"raylib [text] example - text formatting"
.LC1:
	.string	"Score: %08i"
.LC2:
	.string	"HiScore: %08i"
.LC3:
	.string	"Lives: %02i"
.LC5:
	.string	"Elapsed Time: %02.02f ms"
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
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset 3, -24
	movl	$800, -36(%rbp)
	movl	$450, -32(%rbp)
	movl	-32(%rbp), %ecx
	movl	-36(%rbp), %eax
	leaq	.LC0(%rip), %rdx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	InitWindow@PLT
	movl	$100020, -28(%rbp)
	movl	$200450, -24(%rbp)
	movl	$5, -20(%rbp)
	movl	$60, %edi
	call	SetTargetFPS@PLT
	jmp	.L2
.L3:
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
	movl	-52(%rbp), %ecx
	movb	$-26, %cl
	movl	$41, %eax
	movb	%al, %ch
	andl	$-16711681, %ecx
	movl	%ecx, %eax
	orl	$3604480, %eax
	orl	$-16777216, %eax
	movl	%eax, -52(%rbp)
	movl	-28(%rbp), %eax	
	movl	%eax, %esi		# formating argument in rdi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi		# string to be printed in rdi
	movl	$0, %eax
	call	TextFormat@PLT
	movl	$0xff000000, %r8d	# color	
	movl	$20, %ecx	# font size
	movl	$80, %edx  # y pos
	movl	$200, %esi	# x pos
	movq	%rax, %rdi # formatted String
	call	DrawText@PLT
	movl	-56(%rbp), %edx
	movb	$0, %dl
	movl	$-28, %eax
	movb	%al, %dh
	andl	$-16711681, %edx
	movl	%edx, %eax
	orl	$3145728, %eax
	orl	$-16777216, %eax
	movl	%eax, -56(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	TextFormat@PLT
	movl	-56(%rbp), %r8d
	movl	$20, %ecx
	movl	$120, %edx
	movl	$200, %esi
	movq	%rax, %rdi
	call	DrawText@PLT
	movl	-60(%rbp), %ecx
	movb	$0, %cl
	movl	$121, %eax
	movb	%al, %ch
	andl	$-16711681, %ecx
	movl	%ecx, %eax
	orl	$15794176, %eax
	orl	$-16777216, %eax
	movl	%eax, -60(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, %esi
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	TextFormat@PLT
	movl	-60(%rbp), %r8d
	movl	$40, %ecx
	movl	$160, %edx
	movl	$200, %esi
	movq	%rax, %rdi
	call	DrawText@PLT
	movl	-64(%rbp), %edx
	movb	$0, %dl
	movl	$0, %eax
	movb	%al, %dh
	andl	$-16711681, %edx
	movl	%edx, %eax
	orl	$-16777216, %eax
	movl	%eax, -64(%rbp)
	call	GetFrameTime@PLT
	movss	.LC4(%rip), %xmm1
	mulss	%xmm1, %xmm0
	pxor	%xmm2, %xmm2
	cvtss2sd	%xmm0, %xmm2
	movq	%xmm2, %rax
	movq	%rax, %xmm0
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	movl	$1, %eax
	call	TextFormat@PLT
	movl	-64(%rbp), %r8d
	movl	$20, %ecx
	movl	$220, %edx
	movl	$200, %esi
	movq	%rax, %rdi
	call	DrawText@PLT
	call	EndDrawing@PLT
.L2:
	call	WindowShouldClose@PLT
	xorl	$1, %eax
	testb	%al, %al
	jne	.L3
	call	CloseWindow@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC4:
	.long	1148846080
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
