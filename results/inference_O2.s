	.file	"inference.c"
	.text
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "r\0"
.LC1:
	.ascii "results/model_parameters.txt\0"
.LC2:
	.ascii "Error: Could not open %s\12\0"
.LC3:
	.ascii "%lf %lf %lf %lf %lf\0"
	.align 8
.LC4:
	.ascii "Error: Expected five numeric values.\12\0"
.LC7:
	.ascii "MODEL DETECTIVE - C INFERENCE\0"
.LC8:
	.ascii "-----------------------------\0"
.LC9:
	.ascii "Linear score: %.12f\12\0"
.LC10:
	.ascii "Probability:  %.12f\12\0"
.LC12:
	.ascii "Predicted:    %d\12\0"
	.section	.text.startup,"x"
	.p2align 4
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rsi
	.seh_pushreg	%rsi
	pushq	%rbx
	.seh_pushreg	%rbx
	subq	$152, %rsp
	.seh_stackalloc	152
	movaps	%xmm6, 128(%rsp)
	.seh_savexmm	%xmm6, 128
	.seh_endprologue
	leaq	.LC1(%rip), %rsi
	call	__main
	leaq	.LC0(%rip), %rdx
	movq	%rsi, %rcx
	call	fopen
	movq	%rax, %rbx
	testq	%rax, %rax
	je	.L7
	leaq	120(%rsp), %rax
	movq	%rbx, %rcx
	leaq	96(%rsp), %r9
	movq	%rax, 48(%rsp)
	leaq	112(%rsp), %rax
	leaq	88(%rsp), %r8
	movq	%rax, 40(%rsp)
	leaq	104(%rsp), %rax
	leaq	.LC3(%rip), %rdx
	movq	%rax, 32(%rsp)
	call	fscanf
	movq	%rbx, %rcx
	movl	%eax, %esi
	call	fclose
	cmpl	$5, %esi
	je	.L4
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movl	$37, %r8d
	movl	$1, %edx
	leaq	.LC4(%rip), %rcx
	movq	%rax, %r9
	call	fwrite
.L3:
	movl	$1, %eax
	jmp	.L1
.L4:
	movsd	88(%rsp), %xmm1
	movsd	96(%rsp), %xmm0
	mulsd	112(%rsp), %xmm1
	mulsd	120(%rsp), %xmm0
	addsd	%xmm0, %xmm1
	addsd	104(%rsp), %xmm1
	movapd	%xmm1, %xmm0
	xorpd	.LC5(%rip), %xmm0
	movsd	%xmm1, 72(%rsp)
	call	exp
	movsd	.LC6(%rip), %xmm6
	leaq	.LC7(%rip), %rcx
	addsd	%xmm6, %xmm0
	divsd	%xmm0, %xmm6
	call	puts
	leaq	.LC8(%rip), %rcx
	call	puts
	movsd	72(%rsp), %xmm1
	leaq	.LC9(%rip), %rcx
	movq	%xmm1, %rdx
	call	printf
	leaq	.LC10(%rip), %rcx
	movapd	%xmm6, %xmm1
	movq	%xmm6, %rdx
	call	printf
	xorl	%edx, %edx
	comisd	.LC11(%rip), %xmm6
	leaq	.LC12(%rip), %rcx
	setnb	%dl
	call	printf
	xorl	%eax, %eax
.L1:
	movaps	128(%rsp), %xmm6
	addq	$152, %rsp
	popq	%rbx
	popq	%rsi
	ret
.L7:
	movl	$2, %ecx
	call	*__imp___acrt_iob_func(%rip)
	movq	%rsi, %r8
	leaq	.LC2(%rip), %rdx
	movq	%rax, %rcx
	call	fprintf
	jmp	.L3
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
.LC11:
	.long	0
	.long	1071644672
	.ident	"GCC: (MinGW-W64 x86_64-ucrt-posix-seh, built by Brecht Sanders, r8) 13.2.0"
	.def	fopen;	.scl	2;	.type	32;	.endef
	.def	fscanf;	.scl	2;	.type	32;	.endef
	.def	fclose;	.scl	2;	.type	32;	.endef
	.def	fwrite;	.scl	2;	.type	32;	.endef
	.def	exp;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	fprintf;	.scl	2;	.type	32;	.endef
