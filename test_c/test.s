	.file	"test.c"
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"raylib [core] example - keyboard input"
.LC2:
	.string	"%d\n"
.LC3:
	.string	"move the ball with arrow keys"
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
	pxor	%xmm0, %xmm0
	cvtsi2ssl	-36(%rbp), %xmm0
	movss	.LC1(%rip), %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, -24(%rbp)
	pxor	%xmm0, %xmm0
	cvtsi2ssl	-32(%rbp), %xmm0
	movss	.LC1(%rip), %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, -20(%rbp)
	movl	$60, %edi
	call	SetTargetFPS@PLT
	jmp	.L2
.L7:
	call	GetKeyPressed@PLT
	movq	%rax, %rsi
	movq	$.LC2, %rdi
	movq	$0, %rax
	call	printf@PLT
	movl	$262, %edi
	call	IsKeyDown@PLT
	testb	%al, %al
	je	.L3
	movss	-24(%rbp), %xmm1
	movss	.LC1(%rip), %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -24(%rbp)
.L3:
	movl	$263, %edi
	call	IsKeyDown@PLT
	testb	%al, %al
	je	.L4
	movss	-24(%rbp), %xmm0
	movss	.LC1(%rip), %xmm1
	subss	%xmm1, %xmm0
	movss	%xmm0, -24(%rbp)
.L4:
	movl	$265, %edi
	call	IsKeyDown@PLT
	testb	%al, %al
	je	.L5
	movss	-20(%rbp), %xmm0
	movss	.LC1(%rip), %xmm1
	subss	%xmm1, %xmm0
	movss	%xmm0, -20(%rbp)
.L5:
	movl	$264, %edi
	call	IsKeyDown@PLT
	testb	%al, %al
	je	.L6
	movss	-20(%rbp), %xmm1
	movss	.LC1(%rip), %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -20(%rbp)
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
	movl	-52(%rbp), %ecx
	movb	$80, %cl
	movl	$80, %eax
	movb	%al, %ch
	andl	$-16711681, %ecx
	movl	%ecx, %eax
	orl	$5242880, %eax
	orl	$-16777216, %eax
	movl	%eax, -52(%rbp)
	movl	%eax, %r8d
	movl	$20, %ecx
	movl	$10, %edx
	movl	$10, %esi
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	DrawText@PLT
	movl	-56(%rbp), %edx
	movb	$-66, %dl
	movl	$33, %eax
	movb	%al, %dh
	andl	$-16711681, %edx
	movl	%edx, %eax
	orl	$3604480, %eax
	orl	$-16777216, %eax
	movl	%eax, %ecx
	movl	%ecx, -56(%rbp)
	movq	-24(%rbp), %rax
	movl	%ecx, %edi
	movss	.LC4(%rip), %xmm1
	movq	%rax, %xmm0
	call	DrawCircleV@PLT
	call	EndDrawing@PLT
.L2:
	call	WindowShouldClose@PLT
	xorl	$1, %eax
	testb	%al, %al
	jne	.L7
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
.LC1:
	.long	1073741824
	.align 4
.LC4:
	.long	1112014848
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
