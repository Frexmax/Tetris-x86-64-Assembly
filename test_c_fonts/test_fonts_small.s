	.file	"test_fonts_small.c"
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"raylib [text] example - raylib fonts"
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
	subq	$24, %rsp
	.cfi_offset 3, -24
	movl	$800, -32(%rbp)
	movl	$450, -28(%rbp)
	movl	-28(%rbp), %ecx
	movl	-32(%rbp), %eax
	leaq	.LC0(%rip), %rdx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	InitWindow@PLT
	movss	.LC1(%rip), %xmm0
	movss	%xmm0, -24(%rbp)
	movss	.LC1(%rip), %xmm0
	movss	%xmm0, -20(%rbp)
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
.LC1:
	.long	1114636288
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
