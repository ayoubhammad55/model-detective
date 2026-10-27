	.arch armv8-a
	.file	"inference.c"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"r"
	.align	3
.LC1:
	.string	"results/model_parameters.txt"
	.align	3
.LC2:
	.string	"Error: Could not open %s\n"
	.align	3
.LC3:
	.string	"%lf %lf %lf %lf %lf"
	.align	3
.LC4:
	.string	"Error: Expected five numeric values.\n"
	.align	3
.LC5:
	.string	"MODEL DETECTIVE - C INFERENCE"
	.align	3
.LC6:
	.string	"-----------------------------"
	.align	3
.LC7:
	.string	"Linear score: %.12f\n"
	.align	3
.LC8:
	.string	"Probability:  %.12f\n"
	.align	3
.LC9:
	.string	"Predicted:    %d\n"
	.section	.text.startup,"ax",@progbits
	.align	2
	.p2align 5,,15
	.global	main
	.type	main, %function
main:
.LFB11:
	.cfi_startproc
	stp	x29, x30, [sp, -112]!
	.cfi_def_cfa_offset 112
	.cfi_offset 29, -112
	.cfi_offset 30, -104
	adrp	x1, .LC0
	add	x1, x1, :lo12:.LC0
	mov	x29, sp
	stp	x19, x20, [sp, 16]
	.cfi_offset 19, -96
	.cfi_offset 20, -88
	adrp	x19, .LC1
	add	x19, x19, :lo12:.LC1
	mov	x0, x19
	bl	fopen
	cbz	x0, .L8
	add	x6, sp, 104
	add	x5, sp, 96
	add	x4, sp, 88
	add	x3, sp, 80
	add	x2, sp, 72
	adrp	x1, .LC3
	add	x1, x1, :lo12:.LC3
	mov	x20, x0
	bl	__isoc23_fscanf
	mov	w19, w0
	mov	x0, x20
	bl	fclose
	cmp	w19, 5
	bne	.L9
	ldp	d0, d1, [sp, 72]
	str	d15, [sp, 32]
	.cfi_offset 79, -80
	ldr	d30, [sp, 104]
	ldp	d29, d31, [sp, 88]
	fmul	d30, d1, d30
	fmadd	d31, d0, d31, d30
	fadd	d31, d31, d29
	fneg	d0, d31
	str	d31, [sp, 56]
	bl	exp
	fmov	d30, 1.0e+0
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	fadd	d0, d0, d30
	fdiv	d15, d30, d0
	bl	puts
	adrp	x0, .LC6
	add	x0, x0, :lo12:.LC6
	bl	puts
	ldr	d0, [sp, 56]
	adrp	x0, .LC7
	add	x0, x0, :lo12:.LC7
	bl	printf
	fmov	d0, d15
	adrp	x0, .LC8
	add	x0, x0, :lo12:.LC8
	bl	printf
	fmov	d31, 5.0e-1
	adrp	x0, .LC9
	add	x0, x0, :lo12:.LC9
	fcmpe	d15, d31
	cset	w1, ge
	bl	printf
	ldr	d15, [sp, 32]
	.cfi_restore 79
	mov	w0, 0
.L1:
	ldp	x19, x20, [sp, 16]
	ldp	x29, x30, [sp], 112
	.cfi_remember_state
	.cfi_restore 30
	.cfi_restore 29
	.cfi_restore 19
	.cfi_restore 20
	.cfi_def_cfa_offset 0
	ret
.L9:
	.cfi_restore_state
	adrp	x0, stderr
	mov	x2, 37
	mov	x1, 1
	ldr	x3, [x0, #:lo12:stderr]
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	bl	fwrite
	mov	w0, 1
	b	.L1
.L8:
	adrp	x0, stderr
	mov	x2, x19
	adrp	x1, .LC2
	add	x1, x1, :lo12:.LC2
	ldr	x0, [x0, #:lo12:stderr]
	bl	fprintf
	mov	w0, 1
	b	.L1
	.cfi_endproc
.LFE11:
	.size	main, .-main
	.ident	"GCC: (Arm GNU Toolchain 15.3.Rel1 (Build arm-15.149)) 15.3.1 20260627"
	.section	.note.GNU-stack,"",@progbits
