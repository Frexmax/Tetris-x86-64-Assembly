	.file	"test_fonts.c"
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"raylib [text] example - raylib fonts"
.LC1:
	.string	"resources/fonts/alagard.png"
.LC2:
	.string	"resources/fonts/pixelplay.png"
.LC3:
	.string	"resources/fonts/mecha.png"
.LC4:
	.string	"resources/fonts/setback.png"
.LC5:
	.string	"resources/fonts/romulus.png"
	.align 8
.LC6:
	.string	"resources/fonts/pixantiqua.png"
	.align 8
.LC7:
	.string	"resources/fonts/alpha_beta.png"
	.align 8
.LC8:
	.string	"resources/fonts/jupiter_crash.png"
	.align 8
.LC9:
	.string	"ALAGARD FONT designed by Hewett Tsoi"
	.align 8
.LC10:
	.string	"PIXELPLAY FONT designed by Aleksander Shevchuk"
	.align 8
.LC11:
	.string	"MECHA FONT designed by Captain Falcon"
	.align 8
.LC12:
	.string	"SETBACK FONT designed by Brian Kent (AEnigma)"
	.align 8
.LC13:
	.string	"ROMULUS FONT designed by Hewett Tsoi"
	.align 8
.LC14:
	.string	"PIXANTIQUA FONT designed by Gerhard Grossmann"
	.align 8
.LC15:
	.string	"ALPHA_BETA FONT designed by Brian Kent (AEnigma)"
	.align 8
.LC16:
	.string	"JUPITER_CRASH FONT designed by Brian Kent (AEnigma)"
	.align 8
.LC21:
	.string	"free fonts included with raylib"
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
	subq	$696, %rsp
	.cfi_offset 3, -24
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movl	$800, -616(%rbp)
	movl	$450, -612(%rbp)
	movl	-612(%rbp), %ecx
	movl	-616(%rbp), %eax
	leaq	.LC0(%rip), %rdx
	movl	%ecx, %esi
	movl	%eax, %edi
	call	InitWindow@PLT
	leaq	-416(%rbp), %rdx
	movl	$0, %eax
	movl	$48, %ecx
	movq	%rdx, %rdi
	rep stosq
	leaq	-688(%rbp), %rax
	leaq	.LC1(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	LoadFont@PLT
	movq	-688(%rbp), %rax
	movq	-680(%rbp), %rdx
	movq	%rax, -416(%rbp)
	movq	%rdx, -408(%rbp)
	movq	-672(%rbp), %rax
	movq	-664(%rbp), %rdx
	movq	%rax, -400(%rbp)
	movq	%rdx, -392(%rbp)
	movq	-656(%rbp), %rax
	movq	-648(%rbp), %rdx
	movq	%rax, -384(%rbp)
	movq	%rdx, -376(%rbp)
	leaq	-688(%rbp), %rax
	leaq	.LC2(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	LoadFont@PLT
	movq	-688(%rbp), %rax
	movq	-680(%rbp), %rdx
	movq	%rax, -368(%rbp)
	movq	%rdx, -360(%rbp)
	movq	-672(%rbp), %rax
	movq	-664(%rbp), %rdx
	movq	%rax, -352(%rbp)
	movq	%rdx, -344(%rbp)
	movq	-656(%rbp), %rax
	movq	-648(%rbp), %rdx
	movq	%rax, -336(%rbp)
	movq	%rdx, -328(%rbp)
	leaq	-688(%rbp), %rax
	leaq	.LC3(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	LoadFont@PLT
	movq	-688(%rbp), %rax
	movq	-680(%rbp), %rdx
	movq	%rax, -320(%rbp)
	movq	%rdx, -312(%rbp)
	movq	-672(%rbp), %rax
	movq	-664(%rbp), %rdx
	movq	%rax, -304(%rbp)
	movq	%rdx, -296(%rbp)
	movq	-656(%rbp), %rax
	movq	-648(%rbp), %rdx
	movq	%rax, -288(%rbp)
	movq	%rdx, -280(%rbp)
	leaq	-688(%rbp), %rax
	leaq	.LC4(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	LoadFont@PLT
	movq	-688(%rbp), %rax
	movq	-680(%rbp), %rdx
	movq	%rax, -272(%rbp)
	movq	%rdx, -264(%rbp)
	movq	-672(%rbp), %rax
	movq	-664(%rbp), %rdx
	movq	%rax, -256(%rbp)
	movq	%rdx, -248(%rbp)
	movq	-656(%rbp), %rax
	movq	-648(%rbp), %rdx
	movq	%rax, -240(%rbp)
	movq	%rdx, -232(%rbp)
	leaq	-688(%rbp), %rax
	leaq	.LC5(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	LoadFont@PLT
	movq	-688(%rbp), %rax
	movq	-680(%rbp), %rdx
	movq	%rax, -224(%rbp)
	movq	%rdx, -216(%rbp)
	movq	-672(%rbp), %rax
	movq	-664(%rbp), %rdx
	movq	%rax, -208(%rbp)
	movq	%rdx, -200(%rbp)
	movq	-656(%rbp), %rax
	movq	-648(%rbp), %rdx
	movq	%rax, -192(%rbp)
	movq	%rdx, -184(%rbp)
	leaq	-688(%rbp), %rax
	leaq	.LC6(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	LoadFont@PLT
	movq	-688(%rbp), %rax
	movq	-680(%rbp), %rdx
	movq	%rax, -176(%rbp)
	movq	%rdx, -168(%rbp)
	movq	-672(%rbp), %rax
	movq	-664(%rbp), %rdx
	movq	%rax, -160(%rbp)
	movq	%rdx, -152(%rbp)
	movq	-656(%rbp), %rax
	movq	-648(%rbp), %rdx
	movq	%rax, -144(%rbp)
	movq	%rdx, -136(%rbp)
	leaq	-688(%rbp), %rax
	leaq	.LC7(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	LoadFont@PLT
	movq	-688(%rbp), %rax
	movq	-680(%rbp), %rdx
	movq	%rax, -128(%rbp)
	movq	%rdx, -120(%rbp)
	movq	-672(%rbp), %rax
	movq	-664(%rbp), %rdx
	movq	%rax, -112(%rbp)
	movq	%rdx, -104(%rbp)
	movq	-656(%rbp), %rax
	movq	-648(%rbp), %rdx
	movq	%rax, -96(%rbp)
	movq	%rdx, -88(%rbp)
	leaq	-688(%rbp), %rax
	leaq	.LC8(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	LoadFont@PLT
	movq	-688(%rbp), %rax
	movq	-680(%rbp), %rdx
	movq	%rax, -80(%rbp)
	movq	%rdx, -72(%rbp)
	movq	-672(%rbp), %rax
	movq	-664(%rbp), %rdx
	movq	%rax, -64(%rbp)
	movq	%rdx, -56(%rbp)
	movq	-656(%rbp), %rax
	movq	-648(%rbp), %rdx
	movq	%rax, -48(%rbp)
	movq	%rdx, -40(%rbp)
	leaq	.LC9(%rip), %rax
	movq	%rax, -544(%rbp)
	leaq	.LC10(%rip), %rax
	movq	%rax, -536(%rbp)
	leaq	.LC11(%rip), %rax
	movq	%rax, -528(%rbp)
	leaq	.LC12(%rip), %rax
	movq	%rax, -520(%rbp)
	leaq	.LC13(%rip), %rax
	movq	%rax, -512(%rbp)
	leaq	.LC14(%rip), %rax
	movq	%rax, -504(%rbp)
	leaq	.LC15(%rip), %rax
	movq	%rax, -496(%rbp)
	leaq	.LC16(%rip), %rax
	movq	%rax, -488(%rbp)
	movl	$2, -608(%rbp)
	movl	$4, -604(%rbp)
	movl	$8, -600(%rbp)
	movl	$4, -596(%rbp)
	movl	$3, -592(%rbp)
	movl	$4, -588(%rbp)
	movl	$4, -584(%rbp)
	movl	$1, -580(%rbp)
	movq	$0, -480(%rbp)
	movq	$0, -472(%rbp)
	movq	$0, -464(%rbp)
	movq	$0, -456(%rbp)
	movq	$0, -448(%rbp)
	movq	$0, -440(%rbp)
	movq	$0, -432(%rbp)
	movq	$0, -424(%rbp)
	movl	$0, -628(%rbp)
	jmp	.L2
.L3:
	pxor	%xmm0, %xmm0
	cvtsi2ssl	-616(%rbp), %xmm0
	movss	.LC17(%rip), %xmm1
	divss	%xmm1, %xmm0
	movss	%xmm0, -692(%rbp)
	movl	-628(%rbp), %eax
	cltq
	movl	-608(%rbp,%rax,4), %eax
	pxor	%xmm1, %xmm1
	cvtsi2ssl	%eax, %xmm1
	movl	-628(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$4, %rax
	leaq	-16(%rax), %rax
	addq	%rbp, %rax
	subq	$400, %rax
	movl	(%rax), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	movaps	%xmm0, %xmm3
	addss	%xmm0, %xmm3
	movd	%xmm3, %ecx
	movl	-628(%rbp), %eax
	cltq
	movq	-544(%rbp,%rax,8), %rdx
	movl	-628(%rbp), %eax
	movslq	%eax, %rsi
	movq	%rsi, %rax
	addq	%rax, %rax
	addq	%rsi, %rax
	salq	$4, %rax
	leaq	-16(%rax), %rax
	addq	%rbp, %rax
	subq	$400, %rax
	pushq	40(%rax)
	pushq	32(%rax)
	pushq	24(%rax)
	pushq	16(%rax)
	pushq	8(%rax)
	pushq	(%rax)
	movd	%ecx, %xmm0
	movq	%rdx, %rdi
	call	MeasureTextEx@PLT
	addq	$48, %rsp
	movq	%xmm0, %rax
	movd	%eax, %xmm1
	movss	.LC17(%rip), %xmm0
	divss	%xmm0, %xmm1
	movss	-692(%rbp), %xmm0
	subss	%xmm1, %xmm0
	movl	-628(%rbp), %eax
	cltq
	movss	%xmm0, -480(%rbp,%rax,8)
	movl	-628(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$4, %rax
	leaq	-16(%rax), %rax
	addq	%rbp, %rax
	subq	$400, %rax
	movl	(%rax), %eax
	pxor	%xmm1, %xmm1
	cvtsi2ssl	%eax, %xmm1
	movss	.LC18(%rip), %xmm0
	addss	%xmm0, %xmm1
	pxor	%xmm2, %xmm2
	cvtsi2ssl	-628(%rbp), %xmm2
	movss	.LC19(%rip), %xmm0
	mulss	%xmm2, %xmm0
	addss	%xmm1, %xmm0
	movl	-628(%rbp), %eax
	cltq
	movss	%xmm0, -476(%rbp,%rax,8)
	addl	$1, -628(%rbp)
.L2:
	cmpl	$7, -628(%rbp)
	jle	.L3
	movss	-452(%rbp), %xmm1
	movss	.LC20(%rip), %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -452(%rbp)
	movss	-444(%rbp), %xmm1
	movss	.LC17(%rip), %xmm0
	addss	%xmm1, %xmm0
	movss	%xmm0, -444(%rbp)
	movss	-420(%rbp), %xmm0
	movss	.LC20(%rip), %xmm1
	subss	%xmm1, %xmm0
	movss	%xmm0, -420(%rbp)
	movb	$-66, -576(%rbp)
	movb	$33, -575(%rbp)
	movb	$55, -574(%rbp)
	movb	$-1, -573(%rbp)
	movb	$-1, -572(%rbp)
	movb	$-95, -571(%rbp)
	movb	$0, -570(%rbp)
	movb	$-1, -569(%rbp)
	movb	$0, -568(%rbp)
	movb	$117, -567(%rbp)
	movb	$44, -566(%rbp)
	movb	$-1, -565(%rbp)
	movb	$0, -564(%rbp)
	movb	$82, -563(%rbp)
	movb	$-84, -562(%rbp)
	movb	$-1, -561(%rbp)
	movb	$112, -560(%rbp)
	movb	$31, -559(%rbp)
	movb	$126, -558(%rbp)
	movb	$-1, -557(%rbp)
	movb	$0, -556(%rbp)
	movb	$-98, -555(%rbp)
	movb	$47, -554(%rbp)
	movb	$-1, -553(%rbp)
	movb	$-1, -552(%rbp)
	movb	$-53, -551(%rbp)
	movb	$0, -550(%rbp)
	movb	$-1, -549(%rbp)
	movb	$-26, -548(%rbp)
	movb	$41, -547(%rbp)
	movb	$55, -546(%rbp)
	movb	$-1, -545(%rbp)
	movl	$60, %edi
	call	SetTargetFPS@PLT
	jmp	.L4
.L7:
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
	movl	-696(%rbp), %ecx
	movb	$80, %cl
	movl	$80, %eax
	movb	%al, %ch
	andl	$-16711681, %ecx
	movl	%ecx, %eax
	orl	$5242880, %eax
	orl	$-16777216, %eax
	movl	%eax, -696(%rbp)
	movl	%eax, %r8d
	movl	$20, %ecx
	movl	$20, %edx
	movl	$250, %esi
	leaq	.LC21(%rip), %rax
	movq	%rax, %rdi
	call	DrawText@PLT
	movl	-700(%rbp), %ecx
	movb	$80, %cl
	movl	$80, %eax
	movb	%al, %ch
	andl	$-16711681, %ecx
	movl	%ecx, %eax
	orl	$5242880, %eax
	orl	$-16777216, %eax
	movl	%eax, -700(%rbp)
	movl	%eax, %r8d
	movl	$50, %ecx
	movl	$590, %edx
	movl	$50, %esi
	movl	$220, %edi
	call	DrawLine@PLT
	movl	$0, -624(%rbp)
	jmp	.L5
.L6:
	movl	-624(%rbp), %eax
	cltq
	movl	-608(%rbp,%rax,4), %eax
	pxor	%xmm1, %xmm1
	cvtsi2ssl	%eax, %xmm1
	movl	-624(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$4, %rax
	leaq	-16(%rax), %rax
	addq	%rbp, %rax
	subq	$400, %rax
	movl	(%rax), %eax
	pxor	%xmm0, %xmm0
	cvtsi2ssl	%eax, %xmm0
	addss	%xmm0, %xmm0
	movl	-624(%rbp), %eax
	cltq
	movq	-544(%rbp,%rax,8), %rdx
	movl	-624(%rbp), %eax
	cltq
	movl	-576(%rbp,%rax,4), %ecx
	movl	-624(%rbp), %eax
	cltq
	movq	-480(%rbp,%rax,8), %rdi
	movl	-624(%rbp), %eax
	movslq	%eax, %rsi
	movq	%rsi, %rax
	addq	%rax, %rax
	addq	%rsi, %rax
	salq	$4, %rax
	leaq	-16(%rax), %rax
	addq	%rbp, %rax
	subq	$400, %rax
	pushq	40(%rax)
	pushq	32(%rax)
	pushq	24(%rax)
	pushq	16(%rax)
	pushq	8(%rax)
	pushq	(%rax)
	movl	%ecx, %esi
	movaps	%xmm1, %xmm2
	movaps	%xmm0, %xmm1
	movq	%rdi, %xmm0
	movq	%rdx, %rdi
	call	DrawTextEx@PLT
	addq	$48, %rsp
	addl	$1, -624(%rbp)
.L5:
	cmpl	$7, -624(%rbp)
	jle	.L6
	call	EndDrawing@PLT
.L4:
	call	WindowShouldClose@PLT
	xorl	$1, %eax
	testb	%al, %al
	jne	.L7
	movl	$0, -620(%rbp)
	jmp	.L8
.L9:
	movl	-620(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$4, %rax
	leaq	-16(%rax), %rax
	addq	%rbp, %rax
	subq	$400, %rax
	pushq	40(%rax)
	pushq	32(%rax)
	pushq	24(%rax)
	pushq	16(%rax)
	pushq	8(%rax)
	pushq	(%rax)
	call	UnloadFont@PLT
	addq	$48, %rsp
	addl	$1, -620(%rbp)
.L8:
	cmpl	$7, -620(%rbp)
	jle	.L9
	call	CloseWindow@PLT
	movl	$0, %eax
	movq	-24(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L11
	call	__stack_chk_fail@PLT
.L11:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.section	.rodata
	.align 4
.LC17:
	.long	1073741824
	.align 4
.LC18:
	.long	1114636288
	.align 4
.LC19:
	.long	1110704128
	.align 4
.LC20:
	.long	1090519040
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
