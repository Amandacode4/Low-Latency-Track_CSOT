	.build_version macos, 26, 0	sdk_version 26, 5
	.section	__TEXT,__text,regular,pure_instructions
	.globl	__Z14process_manualPK7AggTickS1_P16AlignedSymbolAggPy ; -- Begin function _Z14process_manualPK7AggTickS1_P16AlignedSymbolAggPy
	.p2align	2
__Z14process_manualPK7AggTickS1_P16AlignedSymbolAggPy: ; @_Z14process_manualPK7AggTickS1_P16AlignedSymbolAggPy
	.cfi_startproc
; %bb.0:
	add	x8, x0, #64
	cmp	x8, x1
	b.hi	LBB0_79
; %bb.1:
	add	x9, x0, #128
	add	x10, x1, #1
	cmp	x9, x10
	csinc	x9, x9, x1, hi
	sub	x9, x9, x0
	sub	x9, x9, #65
	mvn	w10, w9
	tst	x10, #0x1c0
	b.eq	LBB0_46
; %bb.2:
	lsr	w8, w9, #6
	add	w8, w8, #1
	and	x8, x8, #0x7
LBB0_3:                                 ; =>This Inner Loop Header: Depth=1
	ldr	w11, [x0, #16]
	ldr	w10, [x0, #48]
	add	x12, x2, x11, lsl #5
	ldr	x14, [x0, #8]
	ldr	x13, [x0, #40]
	ldr	x15, [x12, #16]
	cmp	x14, x15
	b.lt	LBB0_8
; %bb.4:                                ;   in Loop: Header=BB0_3 Depth=1
	add	x15, x2, x10, lsl #5
	ldr	x16, [x15, #16]
	cmp	x13, x16
	b.lt	LBB0_9
LBB0_5:                                 ;   in Loop: Header=BB0_3 Depth=1
	ldr	x16, [x12, #24]
	cmp	x14, x16
	b.gt	LBB0_10
LBB0_6:                                 ;   in Loop: Header=BB0_3 Depth=1
	ldr	x16, [x15, #24]
	cmp	x13, x16
	b.gt	LBB0_11
LBB0_7:                                 ;   in Loop: Header=BB0_3 Depth=1
	ldr	w16, [x12]
	add	w16, w16, #1
	str	w16, [x12]
	ldr	w16, [x15]
	add	w16, w16, #1
	str	w16, [x15]
	ldr	x16, [x12, #8]
	add	x14, x16, x14
	str	x14, [x12, #8]
	ldr	x12, [x15, #8]
	add	x12, x12, x13
	str	x12, [x15, #8]
	ldr	x12, [x3, x11, lsl #3]
	ldr	w13, [x0, #20]
	add	x12, x12, x13
	str	x12, [x3, x11, lsl #3]
	ldr	x11, [x3, x10, lsl #3]
	ldr	w12, [x0, #52]
	add	x11, x11, x12
	str	x11, [x3, x10, lsl #3]
	add	x0, x0, #64
	subs	x8, x8, #1
	b.ne	LBB0_3
	b	LBB0_12
LBB0_8:                                 ;   in Loop: Header=BB0_3 Depth=1
	str	x14, [x12, #16]
	add	x15, x2, x10, lsl #5
	ldr	x16, [x15, #16]
	cmp	x13, x16
	b.ge	LBB0_5
LBB0_9:                                 ;   in Loop: Header=BB0_3 Depth=1
	str	x13, [x15, #16]
	ldr	x16, [x12, #24]
	cmp	x14, x16
	b.le	LBB0_6
LBB0_10:                                ;   in Loop: Header=BB0_3 Depth=1
	str	x14, [x12, #24]
	ldr	x16, [x15, #24]
	cmp	x13, x16
	b.le	LBB0_7
LBB0_11:                                ;   in Loop: Header=BB0_3 Depth=1
	str	x13, [x15, #24]
	b	LBB0_7
LBB0_12:
	cmp	x9, #448
	b.lo	LBB0_79
; %bb.13:
	add	x8, x0, #64
	b	LBB0_46
LBB0_14:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x13, [x11, #16]
	add	x14, x2, x9, lsl #5
	ldr	x15, [x14, #16]
	cmp	x12, x15
	b.ge	LBB0_48
LBB0_15:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x12, [x14, #16]
	ldr	x15, [x11, #24]
	cmp	x13, x15
	b.le	LBB0_49
LBB0_16:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x13, [x11, #24]
	ldr	x15, [x14, #24]
	cmp	x12, x15
	b.le	LBB0_50
LBB0_17:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x12, [x14, #24]
	b	LBB0_50
LBB0_18:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x13, [x11, #16]
	add	x14, x2, x9, lsl #5
	ldr	x15, [x14, #16]
	cmp	x12, x15
	b.ge	LBB0_52
LBB0_19:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x12, [x14, #16]
	ldr	x15, [x11, #24]
	cmp	x13, x15
	b.le	LBB0_53
LBB0_20:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x13, [x11, #24]
	ldr	x15, [x14, #24]
	cmp	x12, x15
	b.le	LBB0_54
LBB0_21:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x12, [x14, #24]
	b	LBB0_54
LBB0_22:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x13, [x11, #16]
	add	x14, x2, x9, lsl #5
	ldr	x15, [x14, #16]
	cmp	x12, x15
	b.ge	LBB0_56
LBB0_23:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x12, [x14, #16]
	ldr	x15, [x11, #24]
	cmp	x13, x15
	b.le	LBB0_57
LBB0_24:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x13, [x11, #24]
	ldr	x15, [x14, #24]
	cmp	x12, x15
	b.le	LBB0_58
LBB0_25:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x12, [x14, #24]
	b	LBB0_58
LBB0_26:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x13, [x11, #16]
	add	x14, x2, x9, lsl #5
	ldr	x15, [x14, #16]
	cmp	x12, x15
	b.ge	LBB0_60
LBB0_27:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x12, [x14, #16]
	ldr	x15, [x11, #24]
	cmp	x13, x15
	b.le	LBB0_61
LBB0_28:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x13, [x11, #24]
	ldr	x15, [x14, #24]
	cmp	x12, x15
	b.le	LBB0_62
LBB0_29:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x12, [x14, #24]
	b	LBB0_62
LBB0_30:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x13, [x11, #16]
	add	x14, x2, x9, lsl #5
	ldr	x15, [x14, #16]
	cmp	x12, x15
	b.ge	LBB0_64
LBB0_31:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x12, [x14, #16]
	ldr	x15, [x11, #24]
	cmp	x13, x15
	b.le	LBB0_65
LBB0_32:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x13, [x11, #24]
	ldr	x15, [x14, #24]
	cmp	x12, x15
	b.le	LBB0_66
LBB0_33:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x12, [x14, #24]
	b	LBB0_66
LBB0_34:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x13, [x11, #16]
	add	x14, x2, x9, lsl #5
	ldr	x15, [x14, #16]
	cmp	x12, x15
	b.ge	LBB0_68
LBB0_35:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x12, [x14, #16]
	ldr	x15, [x11, #24]
	cmp	x13, x15
	b.le	LBB0_69
LBB0_36:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x13, [x11, #24]
	ldr	x15, [x14, #24]
	cmp	x12, x15
	b.le	LBB0_70
LBB0_37:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x12, [x14, #24]
	b	LBB0_70
LBB0_38:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x13, [x11, #16]
	add	x14, x2, x9, lsl #5
	ldr	x15, [x14, #16]
	cmp	x12, x15
	b.ge	LBB0_72
LBB0_39:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x12, [x14, #16]
	ldr	x15, [x11, #24]
	cmp	x13, x15
	b.le	LBB0_73
LBB0_40:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x13, [x11, #24]
	ldr	x15, [x14, #24]
	cmp	x12, x15
	b.le	LBB0_74
LBB0_41:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x12, [x14, #24]
	b	LBB0_74
LBB0_42:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x13, [x11, #16]
	add	x14, x2, x9, lsl #5
	ldr	x15, [x14, #16]
	cmp	x12, x15
	b.ge	LBB0_76
LBB0_43:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x12, [x14, #16]
	ldr	x15, [x11, #24]
	cmp	x13, x15
	b.le	LBB0_77
LBB0_44:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x13, [x11, #24]
	ldr	x15, [x14, #24]
	cmp	x12, x15
	b.le	LBB0_78
LBB0_45:                                ;   in Loop: Header=BB0_46 Depth=1
	str	x12, [x14, #24]
	b	LBB0_78
LBB0_46:                                ; =>This Inner Loop Header: Depth=1
	ldr	w10, [x0, #16]
	ldr	w9, [x0, #48]
	add	x11, x2, x10, lsl #5
	ldr	x13, [x0, #8]
	ldr	x12, [x0, #40]
	ldr	x14, [x11, #16]
	cmp	x13, x14
	b.lt	LBB0_14
; %bb.47:                               ;   in Loop: Header=BB0_46 Depth=1
	add	x14, x2, x9, lsl #5
	ldr	x15, [x14, #16]
	cmp	x12, x15
	b.lt	LBB0_15
LBB0_48:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	x15, [x11, #24]
	cmp	x13, x15
	b.gt	LBB0_16
LBB0_49:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	x15, [x14, #24]
	cmp	x12, x15
	b.gt	LBB0_17
LBB0_50:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	w15, [x11]
	add	w15, w15, #1
	str	w15, [x11]
	ldr	w15, [x14]
	add	w15, w15, #1
	str	w15, [x14]
	ldr	x15, [x11, #8]
	add	x13, x15, x13
	str	x13, [x11, #8]
	ldr	x11, [x14, #8]
	add	x11, x11, x12
	str	x11, [x14, #8]
	ldr	w11, [x0, #20]
	ldr	x12, [x3, x10, lsl #3]
	add	x11, x12, x11
	str	x11, [x3, x10, lsl #3]
	ldr	w10, [x0, #52]
	ldr	x11, [x3, x9, lsl #3]
	add	x10, x11, x10
	str	x10, [x3, x9, lsl #3]
	ldr	w10, [x8, #16]
	ldr	w9, [x8, #48]
	add	x11, x2, x10, lsl #5
	ldr	x13, [x8, #8]
	ldr	x12, [x8, #40]
	ldr	x14, [x11, #16]
	cmp	x13, x14
	b.lt	LBB0_18
; %bb.51:                               ;   in Loop: Header=BB0_46 Depth=1
	add	x14, x2, x9, lsl #5
	ldr	x15, [x14, #16]
	cmp	x12, x15
	b.lt	LBB0_19
LBB0_52:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	x15, [x11, #24]
	cmp	x13, x15
	b.gt	LBB0_20
LBB0_53:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	x15, [x14, #24]
	cmp	x12, x15
	b.gt	LBB0_21
LBB0_54:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	w15, [x11]
	add	w15, w15, #1
	str	w15, [x11]
	ldr	w15, [x14]
	add	w15, w15, #1
	str	w15, [x14]
	ldr	x15, [x11, #8]
	add	x13, x15, x13
	str	x13, [x11, #8]
	ldr	x11, [x14, #8]
	add	x11, x11, x12
	str	x11, [x14, #8]
	ldr	w11, [x8, #20]
	ldr	x12, [x3, x10, lsl #3]
	add	x11, x12, x11
	str	x11, [x3, x10, lsl #3]
	ldr	w10, [x8, #52]
	ldr	x11, [x3, x9, lsl #3]
	add	x10, x11, x10
	str	x10, [x3, x9, lsl #3]
	ldr	w10, [x8, #80]
	ldr	w9, [x8, #112]
	add	x11, x2, x10, lsl #5
	ldr	x13, [x8, #72]
	ldr	x12, [x8, #104]
	ldr	x14, [x11, #16]
	cmp	x13, x14
	b.lt	LBB0_22
; %bb.55:                               ;   in Loop: Header=BB0_46 Depth=1
	add	x14, x2, x9, lsl #5
	ldr	x15, [x14, #16]
	cmp	x12, x15
	b.lt	LBB0_23
LBB0_56:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	x15, [x11, #24]
	cmp	x13, x15
	b.gt	LBB0_24
LBB0_57:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	x15, [x14, #24]
	cmp	x12, x15
	b.gt	LBB0_25
LBB0_58:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	w15, [x11]
	add	w15, w15, #1
	str	w15, [x11]
	ldr	w15, [x14]
	add	w15, w15, #1
	str	w15, [x14]
	ldr	x15, [x11, #8]
	add	x13, x15, x13
	str	x13, [x11, #8]
	ldr	x11, [x14, #8]
	add	x11, x11, x12
	str	x11, [x14, #8]
	ldr	w11, [x8, #84]
	ldr	x12, [x3, x10, lsl #3]
	add	x11, x12, x11
	str	x11, [x3, x10, lsl #3]
	ldr	w10, [x8, #116]
	ldr	x11, [x3, x9, lsl #3]
	add	x10, x11, x10
	str	x10, [x3, x9, lsl #3]
	ldr	w10, [x8, #144]
	ldr	w9, [x8, #176]
	add	x11, x2, x10, lsl #5
	ldr	x13, [x8, #136]
	ldr	x12, [x8, #168]
	ldr	x14, [x11, #16]
	cmp	x13, x14
	b.lt	LBB0_26
; %bb.59:                               ;   in Loop: Header=BB0_46 Depth=1
	add	x14, x2, x9, lsl #5
	ldr	x15, [x14, #16]
	cmp	x12, x15
	b.lt	LBB0_27
LBB0_60:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	x15, [x11, #24]
	cmp	x13, x15
	b.gt	LBB0_28
LBB0_61:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	x15, [x14, #24]
	cmp	x12, x15
	b.gt	LBB0_29
LBB0_62:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	w15, [x11]
	add	w15, w15, #1
	str	w15, [x11]
	ldr	w15, [x14]
	add	w15, w15, #1
	str	w15, [x14]
	ldr	x15, [x11, #8]
	add	x13, x15, x13
	str	x13, [x11, #8]
	ldr	x11, [x14, #8]
	add	x11, x11, x12
	str	x11, [x14, #8]
	ldr	w11, [x8, #148]
	ldr	x12, [x3, x10, lsl #3]
	add	x11, x12, x11
	str	x11, [x3, x10, lsl #3]
	ldr	w10, [x8, #180]
	ldr	x11, [x3, x9, lsl #3]
	add	x10, x11, x10
	str	x10, [x3, x9, lsl #3]
	ldr	w10, [x8, #208]
	ldr	w9, [x8, #240]
	add	x11, x2, x10, lsl #5
	ldr	x13, [x8, #200]
	ldr	x12, [x8, #232]
	ldr	x14, [x11, #16]
	cmp	x13, x14
	b.lt	LBB0_30
; %bb.63:                               ;   in Loop: Header=BB0_46 Depth=1
	add	x14, x2, x9, lsl #5
	ldr	x15, [x14, #16]
	cmp	x12, x15
	b.lt	LBB0_31
LBB0_64:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	x15, [x11, #24]
	cmp	x13, x15
	b.gt	LBB0_32
LBB0_65:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	x15, [x14, #24]
	cmp	x12, x15
	b.gt	LBB0_33
LBB0_66:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	w15, [x11]
	add	w15, w15, #1
	str	w15, [x11]
	ldr	w15, [x14]
	add	w15, w15, #1
	str	w15, [x14]
	ldr	x15, [x11, #8]
	add	x13, x15, x13
	str	x13, [x11, #8]
	ldr	x11, [x14, #8]
	add	x11, x11, x12
	str	x11, [x14, #8]
	ldr	w11, [x8, #212]
	ldr	x12, [x3, x10, lsl #3]
	add	x11, x12, x11
	str	x11, [x3, x10, lsl #3]
	ldr	w10, [x8, #244]
	ldr	x11, [x3, x9, lsl #3]
	add	x10, x11, x10
	str	x10, [x3, x9, lsl #3]
	ldr	w10, [x8, #272]
	ldr	w9, [x8, #304]
	add	x11, x2, x10, lsl #5
	ldr	x13, [x8, #264]
	ldr	x12, [x8, #296]
	ldr	x14, [x11, #16]
	cmp	x13, x14
	b.lt	LBB0_34
; %bb.67:                               ;   in Loop: Header=BB0_46 Depth=1
	add	x14, x2, x9, lsl #5
	ldr	x15, [x14, #16]
	cmp	x12, x15
	b.lt	LBB0_35
LBB0_68:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	x15, [x11, #24]
	cmp	x13, x15
	b.gt	LBB0_36
LBB0_69:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	x15, [x14, #24]
	cmp	x12, x15
	b.gt	LBB0_37
LBB0_70:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	w15, [x11]
	add	w15, w15, #1
	str	w15, [x11]
	ldr	w15, [x14]
	add	w15, w15, #1
	str	w15, [x14]
	ldr	x15, [x11, #8]
	add	x13, x15, x13
	str	x13, [x11, #8]
	ldr	x11, [x14, #8]
	add	x11, x11, x12
	str	x11, [x14, #8]
	ldr	w11, [x8, #276]
	ldr	x12, [x3, x10, lsl #3]
	add	x11, x12, x11
	str	x11, [x3, x10, lsl #3]
	ldr	w10, [x8, #308]
	ldr	x11, [x3, x9, lsl #3]
	add	x10, x11, x10
	str	x10, [x3, x9, lsl #3]
	ldr	w10, [x8, #336]
	ldr	w9, [x8, #368]
	add	x11, x2, x10, lsl #5
	ldr	x13, [x8, #328]
	ldr	x12, [x8, #360]
	ldr	x14, [x11, #16]
	cmp	x13, x14
	b.lt	LBB0_38
; %bb.71:                               ;   in Loop: Header=BB0_46 Depth=1
	add	x14, x2, x9, lsl #5
	ldr	x15, [x14, #16]
	cmp	x12, x15
	b.lt	LBB0_39
LBB0_72:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	x15, [x11, #24]
	cmp	x13, x15
	b.gt	LBB0_40
LBB0_73:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	x15, [x14, #24]
	cmp	x12, x15
	b.gt	LBB0_41
LBB0_74:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	w15, [x11]
	add	w15, w15, #1
	str	w15, [x11]
	ldr	w15, [x14]
	add	w15, w15, #1
	str	w15, [x14]
	ldr	x15, [x11, #8]
	add	x13, x15, x13
	str	x13, [x11, #8]
	ldr	x11, [x14, #8]
	add	x11, x11, x12
	str	x11, [x14, #8]
	ldr	w11, [x8, #340]
	ldr	x12, [x3, x10, lsl #3]
	add	x11, x12, x11
	str	x11, [x3, x10, lsl #3]
	ldr	w10, [x8, #372]
	ldr	x11, [x3, x9, lsl #3]
	add	x10, x11, x10
	str	x10, [x3, x9, lsl #3]
	ldr	w10, [x8, #400]
	ldr	w9, [x8, #432]
	add	x11, x2, x10, lsl #5
	ldr	x13, [x8, #392]
	ldr	x12, [x8, #424]
	ldr	x14, [x11, #16]
	cmp	x13, x14
	b.lt	LBB0_42
; %bb.75:                               ;   in Loop: Header=BB0_46 Depth=1
	add	x14, x2, x9, lsl #5
	ldr	x15, [x14, #16]
	cmp	x12, x15
	b.lt	LBB0_43
LBB0_76:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	x15, [x11, #24]
	cmp	x13, x15
	b.gt	LBB0_44
LBB0_77:                                ;   in Loop: Header=BB0_46 Depth=1
	ldr	x15, [x14, #24]
	cmp	x12, x15
	b.gt	LBB0_45
LBB0_78:                                ;   in Loop: Header=BB0_46 Depth=1
	add	x0, x8, #448
	ldr	w15, [x11]
	add	w15, w15, #1
	str	w15, [x11]
	ldr	w15, [x14]
	add	w15, w15, #1
	str	w15, [x14]
	ldr	x15, [x11, #8]
	add	x13, x15, x13
	str	x13, [x11, #8]
	ldr	x11, [x14, #8]
	add	x11, x11, x12
	str	x11, [x14, #8]
	ldr	x11, [x3, x10, lsl #3]
	ldr	w12, [x8, #404]
	add	x11, x11, x12
	str	x11, [x3, x10, lsl #3]
	ldr	x10, [x3, x9, lsl #3]
	ldr	w11, [x8, #436]
	add	x10, x10, x11
	str	x10, [x3, x9, lsl #3]
	add	x8, x8, #512
	cmp	x8, x1
	b.ls	LBB0_46
LBB0_79:
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__Z12process_autoPK7AggTickS1_P16AlignedSymbolAggPy ; -- Begin function _Z12process_autoPK7AggTickS1_P16AlignedSymbolAggPy
	.p2align	2
__Z12process_autoPK7AggTickS1_P16AlignedSymbolAggPy: ; @_Z12process_autoPK7AggTickS1_P16AlignedSymbolAggPy
	.cfi_startproc
; %bb.0:
	cmp	x0, x1
	b.hs	LBB1_42
; %bb.1:
	add	x8, x0, #32
	cmp	x1, x8
	csel	x8, x1, x8, hi
	mvn	x9, x0
	add	x8, x8, x9
	mvn	w9, w8
	tst	x9, #0xe0
	b.eq	LBB1_25
; %bb.2:
	lsr	w9, w8, #5
	add	w9, w9, #1
	and	x9, x9, #0x7
LBB1_3:                                 ; =>This Inner Loop Header: Depth=1
	ldr	w10, [x0, #16]
	add	x11, x2, x10, lsl #5
	ldr	x12, [x0, #8]
	ldr	x13, [x11, #16]
	cmp	x12, x13
	b.lt	LBB1_6
; %bb.4:                                ;   in Loop: Header=BB1_3 Depth=1
	ldr	x13, [x11, #24]
	cmp	x12, x13
	b.gt	LBB1_7
LBB1_5:                                 ;   in Loop: Header=BB1_3 Depth=1
	ldr	w13, [x11]
	add	w13, w13, #1
	str	w13, [x11]
	ldr	x13, [x11, #8]
	add	x12, x13, x12
	str	x12, [x11, #8]
	ldr	x11, [x3, x10, lsl #3]
	ldr	w12, [x0, #20]
	add	x11, x11, x12
	str	x11, [x3, x10, lsl #3]
	add	x0, x0, #32
	subs	x9, x9, #1
	b.ne	LBB1_3
	b	LBB1_8
LBB1_6:                                 ;   in Loop: Header=BB1_3 Depth=1
	str	x12, [x11, #16]
	ldr	x13, [x11, #24]
	cmp	x12, x13
	b.le	LBB1_5
LBB1_7:                                 ;   in Loop: Header=BB1_3 Depth=1
	str	x12, [x11, #24]
	b	LBB1_5
LBB1_8:
	cmp	x8, #224
	b.hs	LBB1_25
	b	LBB1_42
LBB1_9:                                 ;   in Loop: Header=BB1_25 Depth=1
	str	x10, [x9, #16]
	ldr	x11, [x9, #24]
	cmp	x10, x11
	b.le	LBB1_27
LBB1_10:                                ;   in Loop: Header=BB1_25 Depth=1
	str	x10, [x9, #24]
	b	LBB1_27
LBB1_11:                                ;   in Loop: Header=BB1_25 Depth=1
	str	x10, [x9, #16]
	ldr	x11, [x9, #24]
	cmp	x10, x11
	b.le	LBB1_29
LBB1_12:                                ;   in Loop: Header=BB1_25 Depth=1
	str	x10, [x9, #24]
	b	LBB1_29
LBB1_13:                                ;   in Loop: Header=BB1_25 Depth=1
	str	x10, [x9, #16]
	ldr	x11, [x9, #24]
	cmp	x10, x11
	b.le	LBB1_31
LBB1_14:                                ;   in Loop: Header=BB1_25 Depth=1
	str	x10, [x9, #24]
	b	LBB1_31
LBB1_15:                                ;   in Loop: Header=BB1_25 Depth=1
	str	x10, [x9, #16]
	ldr	x11, [x9, #24]
	cmp	x10, x11
	b.le	LBB1_33
LBB1_16:                                ;   in Loop: Header=BB1_25 Depth=1
	str	x10, [x9, #24]
	b	LBB1_33
LBB1_17:                                ;   in Loop: Header=BB1_25 Depth=1
	str	x10, [x9, #16]
	ldr	x11, [x9, #24]
	cmp	x10, x11
	b.le	LBB1_35
LBB1_18:                                ;   in Loop: Header=BB1_25 Depth=1
	str	x10, [x9, #24]
	b	LBB1_35
LBB1_19:                                ;   in Loop: Header=BB1_25 Depth=1
	str	x10, [x9, #16]
	ldr	x11, [x9, #24]
	cmp	x10, x11
	b.le	LBB1_37
LBB1_20:                                ;   in Loop: Header=BB1_25 Depth=1
	str	x10, [x9, #24]
	b	LBB1_37
LBB1_21:                                ;   in Loop: Header=BB1_25 Depth=1
	str	x10, [x9, #16]
	ldr	x11, [x9, #24]
	cmp	x10, x11
	b.le	LBB1_39
LBB1_22:                                ;   in Loop: Header=BB1_25 Depth=1
	str	x10, [x9, #24]
	b	LBB1_39
LBB1_23:                                ;   in Loop: Header=BB1_25 Depth=1
	str	x10, [x9, #16]
	ldr	x11, [x9, #24]
	cmp	x10, x11
	b.le	LBB1_41
LBB1_24:                                ;   in Loop: Header=BB1_25 Depth=1
	str	x10, [x9, #24]
	b	LBB1_41
LBB1_25:                                ; =>This Inner Loop Header: Depth=1
	ldr	w8, [x0, #16]
	add	x9, x2, x8, lsl #5
	ldr	x10, [x0, #8]
	ldr	x11, [x9, #16]
	cmp	x10, x11
	b.lt	LBB1_9
; %bb.26:                               ;   in Loop: Header=BB1_25 Depth=1
	ldr	x11, [x9, #24]
	cmp	x10, x11
	b.gt	LBB1_10
LBB1_27:                                ;   in Loop: Header=BB1_25 Depth=1
	ldr	x11, [x9, #8]
	add	x10, x11, x10
	str	x10, [x9, #8]
	ldr	x10, [x3, x8, lsl #3]
	ldr	w11, [x0, #20]
	add	x10, x10, x11
	ldr	w11, [x9]
	add	w11, w11, #1
	str	x10, [x3, x8, lsl #3]
	str	w11, [x9]
	ldr	w8, [x0, #48]
	add	x9, x2, x8, lsl #5
	ldr	x10, [x0, #40]
	ldr	x11, [x9, #16]
	cmp	x10, x11
	b.lt	LBB1_11
; %bb.28:                               ;   in Loop: Header=BB1_25 Depth=1
	ldr	x11, [x9, #24]
	cmp	x10, x11
	b.gt	LBB1_12
LBB1_29:                                ;   in Loop: Header=BB1_25 Depth=1
	ldr	x11, [x9, #8]
	add	x10, x11, x10
	str	x10, [x9, #8]
	ldr	x10, [x3, x8, lsl #3]
	ldr	w11, [x0, #52]
	add	x10, x10, x11
	ldr	w11, [x9]
	add	w11, w11, #1
	str	x10, [x3, x8, lsl #3]
	str	w11, [x9]
	ldr	w8, [x0, #80]
	add	x9, x2, x8, lsl #5
	ldr	x10, [x0, #72]
	ldr	x11, [x9, #16]
	cmp	x10, x11
	b.lt	LBB1_13
; %bb.30:                               ;   in Loop: Header=BB1_25 Depth=1
	ldr	x11, [x9, #24]
	cmp	x10, x11
	b.gt	LBB1_14
LBB1_31:                                ;   in Loop: Header=BB1_25 Depth=1
	ldr	x11, [x9, #8]
	add	x10, x11, x10
	str	x10, [x9, #8]
	ldr	x10, [x3, x8, lsl #3]
	ldr	w11, [x0, #84]
	add	x10, x10, x11
	ldr	w11, [x9]
	add	w11, w11, #1
	str	x10, [x3, x8, lsl #3]
	str	w11, [x9]
	ldr	w8, [x0, #112]
	add	x9, x2, x8, lsl #5
	ldr	x10, [x0, #104]
	ldr	x11, [x9, #16]
	cmp	x10, x11
	b.lt	LBB1_15
; %bb.32:                               ;   in Loop: Header=BB1_25 Depth=1
	ldr	x11, [x9, #24]
	cmp	x10, x11
	b.gt	LBB1_16
LBB1_33:                                ;   in Loop: Header=BB1_25 Depth=1
	ldr	x11, [x9, #8]
	add	x10, x11, x10
	str	x10, [x9, #8]
	ldr	x10, [x3, x8, lsl #3]
	ldr	w11, [x0, #116]
	add	x10, x10, x11
	ldr	w11, [x9]
	add	w11, w11, #1
	str	x10, [x3, x8, lsl #3]
	str	w11, [x9]
	ldr	w8, [x0, #144]
	add	x9, x2, x8, lsl #5
	ldr	x10, [x0, #136]
	ldr	x11, [x9, #16]
	cmp	x10, x11
	b.lt	LBB1_17
; %bb.34:                               ;   in Loop: Header=BB1_25 Depth=1
	ldr	x11, [x9, #24]
	cmp	x10, x11
	b.gt	LBB1_18
LBB1_35:                                ;   in Loop: Header=BB1_25 Depth=1
	ldr	x11, [x9, #8]
	add	x10, x11, x10
	str	x10, [x9, #8]
	ldr	x10, [x3, x8, lsl #3]
	ldr	w11, [x0, #148]
	add	x10, x10, x11
	ldr	w11, [x9]
	add	w11, w11, #1
	str	x10, [x3, x8, lsl #3]
	str	w11, [x9]
	ldr	w8, [x0, #176]
	add	x9, x2, x8, lsl #5
	ldr	x10, [x0, #168]
	ldr	x11, [x9, #16]
	cmp	x10, x11
	b.lt	LBB1_19
; %bb.36:                               ;   in Loop: Header=BB1_25 Depth=1
	ldr	x11, [x9, #24]
	cmp	x10, x11
	b.gt	LBB1_20
LBB1_37:                                ;   in Loop: Header=BB1_25 Depth=1
	ldr	x11, [x9, #8]
	add	x10, x11, x10
	str	x10, [x9, #8]
	ldr	x10, [x3, x8, lsl #3]
	ldr	w11, [x0, #180]
	add	x10, x10, x11
	ldr	w11, [x9]
	add	w11, w11, #1
	str	x10, [x3, x8, lsl #3]
	str	w11, [x9]
	ldr	w8, [x0, #208]
	add	x9, x2, x8, lsl #5
	ldr	x10, [x0, #200]
	ldr	x11, [x9, #16]
	cmp	x10, x11
	b.lt	LBB1_21
; %bb.38:                               ;   in Loop: Header=BB1_25 Depth=1
	ldr	x11, [x9, #24]
	cmp	x10, x11
	b.gt	LBB1_22
LBB1_39:                                ;   in Loop: Header=BB1_25 Depth=1
	ldr	x11, [x9, #8]
	add	x10, x11, x10
	str	x10, [x9, #8]
	ldr	x10, [x3, x8, lsl #3]
	ldr	w11, [x0, #212]
	add	x10, x10, x11
	ldr	w11, [x9]
	add	w11, w11, #1
	str	x10, [x3, x8, lsl #3]
	str	w11, [x9]
	ldr	w8, [x0, #240]
	add	x9, x2, x8, lsl #5
	ldr	x10, [x0, #232]
	ldr	x11, [x9, #16]
	cmp	x10, x11
	b.lt	LBB1_23
; %bb.40:                               ;   in Loop: Header=BB1_25 Depth=1
	ldr	x11, [x9, #24]
	cmp	x10, x11
	b.gt	LBB1_24
LBB1_41:                                ;   in Loop: Header=BB1_25 Depth=1
	ldr	w11, [x9]
	add	w11, w11, #1
	str	w11, [x9]
	ldr	x11, [x9, #8]
	add	x10, x11, x10
	str	x10, [x9, #8]
	ldr	x9, [x3, x8, lsl #3]
	ldr	w10, [x0, #244]
	add	x9, x9, x10
	str	x9, [x3, x8, lsl #3]
	add	x0, x0, #256
	cmp	x0, x1
	b.lo	LBB1_25
LBB1_42:
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
