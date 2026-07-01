	.file	"test.cpp"
	.text
	.p2align 4
	.globl	_Z9get_priceRK4Tickb
	.type	_Z9get_priceRK4Tickb, @function
_Z9get_priceRK4Tickb:
.LFB3:
	.cfi_startproc
	vmovsd	16(%rdi), %xmm1
	vmovsd	24(%rdi), %xmm0
	testb	%sil, %sil
	je	.L1
	vmovapd	%xmm1, %xmm0
.L1:
	ret
	.cfi_endproc
.LFE3:
	.size	_Z9get_priceRK4Tickb, .-_Z9get_priceRK4Tickb
	.ident	"GCC: (GNU) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
