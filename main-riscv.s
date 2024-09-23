	.file	"main.c"
	.option pic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_zicsr2p0_zifencei2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
	.globl	GLOBAL_VAR
	.section	.rodata
	.align	3
.LC0:
	.string	"This is the 'GLOBAL_VAR'."
	.section	.data.rel.local,"aw"
	.align	3
	.type	GLOBAL_VAR, @object
	.size	GLOBAL_VAR, 8
GLOBAL_VAR:
	.dword	.LC0
	.section	.rodata
	.align	3
.LC1:
	.string	"69"
	.text
	.align	1
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sd	ra,8(sp)
	sd	s0,0(sp)
	.cfi_offset 1, -8
	.cfi_offset 8, -16
	addi	s0,sp,16
	.cfi_def_cfa 8, 0
	lla	a5,GLOBAL_VAR
	ld	a5,0(a5)
	mv	a0,a5
	call	puts@plt
	lla	a0,.LC1
	call	puts@plt
	li	a5,0
	mv	a0,a5
	ld	ra,8(sp)
	.cfi_restore 1
	ld	s0,0(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 16
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 13.2.0-4ubuntu3-bb2) 13.2.0"
	.section	.note.GNU-stack,"",@progbits
