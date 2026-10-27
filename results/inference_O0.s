	.file	"inference.c"
	.text
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "results/model_parameters.txt\0"
.LC1:
	.ascii "r\0"
.LC2:
	.ascii "Error: Could not open %s\12\0"
.LC3:
	.ascii "%lf %lf %lf %lf %lf\0"
	.align 8
.LC4:
	.ascii "Error: Expected five numeric values.\12\0"
.LC8:
	.ascii "MODEL DETECTIVE - C INFERENCE\0"
.LC9:
	.ascii "-----------------------------\0"
.LC10:
	.ascii "Linear score: %.12f\12\0"
.LC11:
	.ascii "Probability:  %.12f\12\0"
.LC12:
	.ascii "Predicted:    %d\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$160, %rsp
	.seh_stackalloc	160
	.seh_endprologue
	call	__main
	leaq	.LC0(%rip), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	leaq	.LC1(%rip), %rdx
	movq	%rax, %rcx
	call	fopen
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.L2
	movl	$2, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
	movq	%rax, %rcx
	movq	-8(%rbp), %rax
	movq	%rax, %r8
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdx
	call	fprintf
	movl	$1, %eax
	jmp	.L5
.L2:
	leaq	-64(%rbp), %r8
	leaq	-56(%rbp), %rcx
	movq	-16(%rbp), %rax
	leaq	-88(%rbp), %rdx
	movq	%rdx, 48(%rsp)
	leaq	-80(%rbp), %rdx
	movq	%rdx, 40(%rsp)
	leaq	-72(%rbp), %rdx
	movq	%rdx, 32(%rsp)
	movq	%r8, %r9
	movq	%rcx, %r8
	leaq	.LC3(%rip), %rdx
	movq	%rax, %rcx
	call	fscanf
	movl	%eax, -20(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, %rcx
	call	fclose
	cmpl	$5, -20(%rbp)
	je	.L4
	movl	$2, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
	movq	%rax, %r9
	movl	$37, %r8d
	movl	$1, %edx
	leaq	.LC4(%rip), %rax
	movq	%rax, %rcx
	call	fwrite
	movl	$1, %eax
	jmp	.L5
.L4:
	movsd	-56(%rbp), %xmm1
	movsd	-80(%rbp), %xmm0
	mulsd	%xmm0, %xmm1
	movsd	-64(%rbp), %xmm2
	movsd	-88(%rbp), %xmm0
	mulsd	%xmm2, %xmm0
	addsd	%xmm0, %xmm1
	movsd	-72(%rbp), %xmm0
	addsd	%xmm1, %xmm0
	movsd	%xmm0, -32(%rbp)
	movsd	-32(%rbp), %xmm0
	movq	.LC5(%rip), %xmm1
	xorpd	%xmm1, %xmm0
	movq	%xmm0, %rax
	movq	%rax, %xmm0
	call	exp
	movsd	.LC6(%rip), %xmm1
	addsd	%xmm0, %xmm1
	movsd	.LC6(%rip), %xmm0
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -40(%rbp)
	movsd	-40(%rbp), %xmm0
	comisd	.LC7(%rip), %xmm0
	setnb	%al
	movzbl	%al, %eax
	movl	%eax, -44(%rbp)
	leaq	.LC8(%rip), %rax
	movq	%rax, %rcx
	call	puts
	leaq	.LC9(%rip), %rax
	movq	%rax, %rcx
	call	puts
	movsd	-32(%rbp), %xmm0
	movq	-32(%rbp), %rax
	movapd	%xmm0, %xmm1
	movq	%rax, %rdx
	leaq	.LC10(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movsd	-40(%rbp), %xmm0
	movq	-40(%rbp), %rax
	movapd	%xmm0, %xmm1
	movq	%rax, %rdx
	leaq	.LC11(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	-44(%rbp), %eax
	movl	%eax, %edx
	leaq	.LC12(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	$0, %eax
.L5:
	addq	$160, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 16
.LC5:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.align 8
.LC6:
	.long	0
	.long	1072693248
	.align 8
.LC7:
	.long	0
	.long	1071644672
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r8) 13.2.0"
	.def	fopen;	.scl	2;	.type	32;	.endef
	.def	fprintf;	.scl	2;	.type	32;	.endef
	.def	fscanf;	.scl	2;	.type	32;	.endef
	.def	fclose;	.scl	2;	.type	32;	.endef
	.def	fwrite;	.scl	2;	.type	32;	.endef
	.def	exp;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
