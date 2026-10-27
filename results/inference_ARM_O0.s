	.arch armv8-a
	.file	"inference.c"
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"results/model_parameters.txt"
	.align	3
.LC1:
	.string	"r"
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
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB0:
	.cfi_startproc
	stp	x29, x30, [sp, -112]!
	.cfi_def_cfa_offset 112
	.cfi_offset 29, -112
	.cfi_offset 30, -104
	mov	x29, sp
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	str	x0, [sp, 104]
	adrp	x0, .LC1
	add	x1, x0, :lo12:.LC1
	ldr	x0, [sp, 104]
	bl	fopen
	str	x0, [sp, 96]
	ldr	x0, [sp, 96]
	cmp	x0, 0
	bne	.L2
	adrp	x0, stderr
	add	x0, x0, :lo12:stderr
	ldr	x3, [x0]
	ldr	x2, [sp, 104]
	adrp	x0, .LC2
	add	x1, x0, :lo12:.LC2
	mov	x0, x3
	bl	fprintf
	mov	w0, 1
	b	.L5
.L2:
	add	x4, sp, 24
	add	x3, sp, 32
	add	x2, sp, 40
	add	x1, sp, 48
	add	x0, sp, 56
	mov	x6, x4
	mov	x5, x3
	mov	x4, x2
	mov	x3, x1
	mov	x2, x0
	adrp	x0, .LC3
	add	x1, x0, :lo12:.LC3
	ldr	x0, [sp, 96]
	bl	__isoc23_fscanf
	str	w0, [sp, 92]
	ldr	x0, [sp, 96]
	bl	fclose
	ldr	w0, [sp, 92]
	cmp	w0, 5
	beq	.L4
	adrp	x0, stderr
	add	x0, x0, :lo12:stderr
	ldr	x0, [x0]
	mov	x3, x0
	mov	x2, 37
	mov	x1, 1
	adrp	x0, .LC4
	add	x0, x0, :lo12:.LC4
	bl	fwrite
	mov	w0, 1
	b	.L5
.L4:
	ldr	d30, [sp, 56]
	ldr	d31, [sp, 32]
	fmul	d30, d30, d31
	ldr	d29, [sp, 48]
	ldr	d31, [sp, 24]
	fmul	d31, d29, d31
	fadd	d30, d30, d31
	ldr	d31, [sp, 40]
	fadd	d31, d30, d31
	str	d31, [sp, 80]
	ldr	d31, [sp, 80]
	fneg	d31, d31
	fmov	d0, d31
	bl	exp
	fmov	d30, d0
	fmov	d31, 1.0e+0
	fadd	d31, d30, d31
	fmov	d30, 1.0e+0
	fdiv	d31, d30, d31
	str	d31, [sp, 72]
	ldr	d30, [sp, 72]
	fmov	d31, 5.0e-1
	fcmpe	d30, d31
	cset	w0, ge
	and	w0, w0, 255
	str	w0, [sp, 68]
	adrp	x0, .LC5
	add	x0, x0, :lo12:.LC5
	bl	puts
	adrp	x0, .LC6
	add	x0, x0, :lo12:.LC6
	bl	puts
	ldr	d0, [sp, 80]
	adrp	x0, .LC7
	add	x0, x0, :lo12:.LC7
	bl	printf
	ldr	d0, [sp, 72]
	adrp	x0, .LC8
	add	x0, x0, :lo12:.LC8
	bl	printf
	ldr	w1, [sp, 68]
	adrp	x0, .LC9
	add	x0, x0, :lo12:.LC9
	bl	printf
	mov	w0, 0
.L5:
	ldp	x29, x30, [sp], 112
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Arm GNU Toolchain 15.3.Rel1 (Build arm-15.149)) 15.3.1 20260627"
	.section	.note.GNU-stack,"",@progbits
