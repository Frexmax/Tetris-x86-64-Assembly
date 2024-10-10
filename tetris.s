.data

.text
	.globl	main
	.type	main, @function

.include "utils/utils.s"
# .include "config/config.s"
.include "colors/colors.s"
.include "config/config.s"

main:
    # prologue

    pushq %rbp 											
	movq %rsp, %rbp

    # epilogue
    movq %rbp, %rsp
	popq %rbp		

    movq $0, %rdi
    call exit
