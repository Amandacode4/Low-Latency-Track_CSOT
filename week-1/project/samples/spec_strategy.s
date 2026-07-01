	.file	"spec_strategy.cpp"
# GNU C++20 (GCC) version 15.2.0 (x86_64-unknown-linux-gnu)
#	compiled by GNU C version Apple LLVM 15.0.0 (clang-1500.3.9.4), GMP version 6.2.1, MPFR version 4.2.2, MPC version 1.3.1, isl version isl-0.26-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -march=x86-64-v3 -O3 -std=c++20 -fno-lto -ffast-math -fno-plt
	.text
	.section	.text._ZN4csot8Strategy7on_initEv,"axG",@progbits,_ZN4csot8Strategy7on_initEv,comdat
	.align 2
	.p2align 6
	.weak	_ZN4csot8Strategy7on_initEv
	.type	_ZN4csot8Strategy7on_initEv, @function
_ZN4csot8Strategy7on_initEv:
.LFB1747:
	.cfi_startproc
# ../include/strategy.hpp:93:     virtual void on_init() {}
	ret	
	.cfi_endproc
.LFE1747:
	.size	_ZN4csot8Strategy7on_initEv, .-_ZN4csot8Strategy7on_initEv
	.section	.text.hot,"ax",@progbits
	.align 64
	.type	_ZN12_GLOBAL__N_112SpecStrategy7on_fillERKN4csot5OrderEdj, @function
_ZN12_GLOBAL__N_112SpecStrategy7on_fillERKN4csot5OrderEdj:
.LFB2474:
	.cfi_startproc
# spec_strategy.cpp:130:     [[gnu::hot, gnu::aligned(64), gnu::flatten]] void on_fill(const csot::Order& o, double, std::uint32_t fill_qty) noexcept override {
	movl	%edx, %ecx	# fill_qty, fill_qty
# spec_strategy.cpp:131:         const std::uintptr_t slot_offset = reinterpret_cast<std::uintptr_t>(o.symbol.data()) & 2016;
	movq	16(%rsi), %rdx	# MEM[(const struct basic_string_view *)o_8(D) + 8B]._M_str, slot_offset_11
	andl	$2016, %edx	#, slot_offset_11
# spec_strategy.cpp:135:         st.position += (o.side == csot::Order::Side::BUY) ? static_cast<std::int32_t>(fill_qty) : -static_cast<std::int32_t>(fill_qty);
	movl	_ZN12_GLOBAL__N_1L7g_slotsE+28(%rdx), %eax	# MEM[(struct SymbolSlot & {ref-all})_2].position, _3
# spec_strategy.cpp:135:         st.position += (o.side == csot::Order::Side::BUY) ? static_cast<std::int32_t>(fill_qty) : -static_cast<std::int32_t>(fill_qty);
	leal	(%rax,%rcx), %edi	#, tmp114
	subl	%ecx, %eax	# fill_qty, tmp113
	cmpb	$0, (%rsi)	#, o_8(D)->side
	cmove	%edi, %eax	# tmp113,, tmp114, tmp115
	movl	%eax, _ZN12_GLOBAL__N_1L7g_slotsE+28(%rdx)	# tmp115, MEM[(struct SymbolSlot & {ref-all})_2].position
# spec_strategy.cpp:136:     }
	ret	
	.cfi_endproc
.LFE2474:
	.size	_ZN12_GLOBAL__N_112SpecStrategy7on_fillERKN4csot5OrderEdj, .-_ZN12_GLOBAL__N_112SpecStrategy7on_fillERKN4csot5OrderEdj
	.text
	.align 2
	.p2align 6
	.type	_ZN12_GLOBAL__N_112SpecStrategyD2Ev, @function
_ZN12_GLOBAL__N_112SpecStrategyD2Ev:
.LFB2728:
	.cfi_startproc
# spec_strategy.cpp:52: class alignas(64) SpecStrategy final : public csot::Strategy {
	ret	
	.cfi_endproc
.LFE2728:
	.size	_ZN12_GLOBAL__N_112SpecStrategyD2Ev, .-_ZN12_GLOBAL__N_112SpecStrategyD2Ev
	.set	_ZN12_GLOBAL__N_112SpecStrategyD1Ev,_ZN12_GLOBAL__N_112SpecStrategyD2Ev
	.section	.text.hot
	.align 64
	.type	_ZN12_GLOBAL__N_112SpecStrategy7on_tickERKN4csot4TickE, @function
_ZN12_GLOBAL__N_112SpecStrategy7on_tickERKN4csot4TickE:
.LFB2450:
	.cfi_startproc
# spec_strategy.cpp:64:         const std::uintptr_t slot_offset = reinterpret_cast<std::uintptr_t>(t.symbol.data()) & 2016;
	movq	16(%rdx), %rax	# MEM[(const struct basic_string_view *)t_49(D) + 8B]._M_str, slot_offset
# spec_strategy.cpp:63:     [[gnu::hot, gnu::aligned(64), gnu::flatten]] std::vector<csot::Order> on_tick(const csot::Tick& t) noexcept override {
	movq	%rdx, %rsi	# t, t
# spec_strategy.cpp:72:         const double p = t.bid_px + t.ask_px;
	vmovsd	24(%rsi), %xmm0	# t_49(D)->bid_px, t_49(D)->bid_px
	vaddsd	32(%rsi), %xmm0, %xmm6	# t_49(D)->ask_px, t_49(D)->bid_px, p
# spec_strategy.cpp:64:         const std::uintptr_t slot_offset = reinterpret_cast<std::uintptr_t>(t.symbol.data()) & 2016;
	andl	$2016, %eax	#, slot_offset
# spec_strategy.cpp:73:         const double old_p = st.next_old_p; 
	vmovsd	_ZN12_GLOBAL__N_1L7g_slotsE+16(%rax), %xmm2	# MEM[(struct SymbolSlot & {ref-all})_4].next_old_p, old_p
# spec_strategy.cpp:81:         const double sum = st.sum + p_diff;
	vmovsd	_ZN12_GLOBAL__N_1L7g_slotsE(%rax), %xmm4	# MEM[(struct SymbolSlot & {ref-all})_4].sum, _9
# spec_strategy.cpp:65:         const std::uintptr_t mids_offset = slot_offset << 4; 
	movq	%rax, %rdx	# slot_offset, mids_offset_52
# spec_strategy.cpp:75:         const std::uint32_t count = st.count;
	movl	_ZN12_GLOBAL__N_1L7g_slotsE+24(%rax), %r8d	# MEM[(struct SymbolSlot & {ref-all})_4].count, count
# spec_strategy.cpp:65:         const std::uintptr_t mids_offset = slot_offset << 4; 
	salq	$4, %rdx	#, mids_offset_52
# spec_strategy.cpp:78:         const double p_diff = p - old_p;
	vsubsd	%xmm2, %xmm6, %xmm3	# old_p, p, p_diff
# spec_strategy.cpp:79:         const double p_sum = p + old_p;
	vaddsd	%xmm2, %xmm6, %xmm5	# old_p, p, p_sum_59
# spec_strategy.cpp:69:         double* mids = reinterpret_cast<double*>(__builtin_assume_aligned(
	addq	$_ZN12_GLOBAL__N_1L11g_mids_dataE, %rdx	#, _5
# spec_strategy.cpp:76:         st.count = count + 1;
	leal	1(%r8), %ecx	#, _8
# spec_strategy.cpp:87:         mids[count & 63] = p;
	movl	%r8d, %r9d	# count, _12
# spec_strategy.cpp:76:         st.count = count + 1;
	movl	%ecx, _ZN12_GLOBAL__N_1L7g_slotsE+24(%rax)	# _8, MEM[(struct SymbolSlot & {ref-all})_4].count
# spec_strategy.cpp:87:         mids[count & 63] = p;
	andl	$63, %r9d	#, _12
# spec_strategy.cpp:88:         st.next_old_p = mids[(count + 1) & 63];
	andl	$63, %ecx	#, _16
# spec_strategy.cpp:81:         const double sum = st.sum + p_diff;
	vaddsd	%xmm3, %xmm4, %xmm1	# p_diff, _9, sum
# spec_strategy.cpp:87:         mids[count & 63] = p;
	vmovsd	%xmm6, (%rdx,%r9,8)	# p, *_14
# spec_strategy.cpp:88:         st.next_old_p = mids[(count + 1) & 63];
	vmovsd	(%rdx,%rcx,8), %xmm8	# *_18, *_18
# spec_strategy.cpp:82:         const double sq_sum = __builtin_fma(p_diff, p_sum, st.sq_sum);
	vfmadd213sd	_ZN12_GLOBAL__N_1L7g_slotsE+8(%rax), %xmm5, %xmm3	# MEM[(struct SymbolSlot & {ref-all})_4].sq_sum, p_sum_59, sq_sum
# spec_strategy.cpp:88:         st.next_old_p = mids[(count + 1) & 63];
	vmovsd	%xmm8, _ZN12_GLOBAL__N_1L7g_slotsE+16(%rax)	# *_18, MEM[(struct SymbolSlot & {ref-all})_4].next_old_p
# spec_strategy.cpp:84:         st.sum = sum;
	vunpcklpd	%xmm3, %xmm1, %xmm7	# sq_sum, sum, _32
	vmovapd	%xmm7, _ZN12_GLOBAL__N_1L7g_slotsE(%rax)	# _32, MEM <vector(2) double> [(struct SymbolSlot & {ref-all})_4]
# spec_strategy.cpp:90:         if (__builtin_expect(count < 63, 0)) return {};
	cmpl	$62, %r8d	#, count
	jbe	.L16	#,
# spec_strategy.cpp:92:         const double sum_sq = sum * sum;
	vmulsd	%xmm1, %xmm1, %xmm9	# sum, sum, powmult_69
# spec_strategy.cpp:93:         const double var_scaled = __builtin_fma(sum_sq, -INV_WINDOW, sq_sum); 
	vfmadd132sd	.LC0(%rip), %xmm3, %xmm9	#, sq_sum, var_scaled
# spec_strategy.cpp:95:         if (__builtin_expect(var_scaled >= EPS_VAR_SCALED, 1)) {
	vcomisd	.LC1(%rip), %xmm9	#, var_scaled
	jb	.L16	#,
# spec_strategy.cpp:96:             const double base = __builtin_fma(p, 64.0, -sum); 
	vsubsd	%xmm6, %xmm2, %xmm10	# p, old_p, _114
# spec_strategy.cpp:98:             const std::int32_t pos = st.position;
	vmovd	_ZN12_GLOBAL__N_1L7g_slotsE+28(%rax), %xmm13	# MEM[(struct SymbolSlot & {ref-all})_4].position, tmp204
	vmovd	%xmm13, %r10d	# tmp203, pos
# spec_strategy.cpp:96:             const double base = __builtin_fma(p, 64.0, -sum); 
	vsubsd	%xmm4, %xmm10, %xmm11	# _9, _114, _26
	vfmadd132sd	.LC2(%rip), %xmm11, %xmm6	#, _26, base
# spec_strategy.cpp:97:             const double diff_sq_scaled = base * base;
	vmulsd	%xmm6, %xmm6, %xmm12	# base, base, powmult_66
# spec_strategy.cpp:100:             if (__builtin_expect(pos == 0, 1)) {
	testl	%r10d, %r10d	# pos
	jne	.L11	#,
# spec_strategy.cpp:101:                 const double thresh_entry = var_scaled * 256.0;
	vmulsd	.LC3(%rip), %xmm9, %xmm2	#, var_scaled, thresh_entry_79
# spec_strategy.cpp:102:                 if (__builtin_expect(diff_sq_scaled >= thresh_entry, 0)) {
	vcomisd	%xmm2, %xmm12	# thresh_entry_79, powmult_66
	jnb	.L12	#,
.L16:
# spec_strategy.cpp:90:         if (__builtin_expect(count < 63, 0)) return {};
	movq	$0, 16(%rdi)	#, *_75(D)
	vpxor	%xmm5, %xmm5, %xmm5	# tmp183
	vmovdqu	%xmm5, (%rdi)	# tmp183, *_75(D)
.L6:
# spec_strategy.cpp:128:     }
	movq	%rdi, %rax	# <retval>,
	ret	
	.p2align 4,,10
	.p2align 3
.L11:
# spec_strategy.cpp:113:                 const double thresh_exit = var_scaled * 16.0;
	vmulsd	.LC5(%rip), %xmm9, %xmm14	#, var_scaled, thresh_exit_71
# spec_strategy.cpp:114:                 if (__builtin_expect(diff_sq_scaled <= thresh_exit, 0)) {
	vcomisd	%xmm12, %xmm14	# powmult_66, thresh_exit_71
	jb	.L16	#,
# spec_strategy.cpp:115:                     bool is_sell = pos > 0;
	testl	%r10d, %r10d	# pos
# spec_strategy.cpp:116:                     double prices[2] = { t.ask_px, t.bid_px };
	vpermilpd	$1, 24(%rsi), %xmm15	#, MEM <const vector(2) double> [(double *)t_49(D) + 24B], vect__42.92_25
# spec_strategy.cpp:23:     std::size_t offset = g_pool_offset;
	movq	_ZN12_GLOBAL__N_1L13g_pool_offsetE(%rip), %r9	# g_pool_offset, offset
# spec_strategy.cpp:121:                         static_cast<std::uint32_t>(pos > 0 ? pos : -pos)
	vpabsd	%xmm13, %xmm6	# tmp203, _46
# spec_strategy.cpp:120:                         prices[is_sell],
	setg	%al	#, _44
# spec_strategy.cpp:117:                     return std::vector<csot::Order>(1, csot::Order{
	movq	8(%rsi), %r8	# MEM <size_t> [(const struct Tick &)t_49(D) + 8], SR.71
	movq	16(%rsi), %rsi	# MEM <const char *> [(const struct Tick &)t_49(D) + 16], SR.72
# spec_strategy.cpp:115:                     bool is_sell = pos > 0;
	setg	%r11b	#, is_sell_72
# spec_strategy.cpp:120:                         prices[is_sell],
	movzbl	%al, %edx	# _44, _44
# spec_strategy.cpp:116:                     double prices[2] = { t.ask_px, t.bid_px };
	vmovapd	%xmm15, -24(%rsp)	# vect__42.92_25, MEM <vector(2) double> [(double *)_22]
# /opt/homebrew/Cellar/x86_64-unknown-linux-gnu/15.2.0/toolchain/x86_64-unknown-linux-gnu/include/c++/15.2.0/bits/stl_vector.h:407: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	leaq	_ZN12_GLOBAL__N_1L6g_poolE+40(%r9), %rax	#, _104
# spec_strategy.cpp:24:     g_pool_offset += aligned_size;
	leaq	48(%r9), %rcx	#, tmp198
# spec_strategy.cpp:120:                         prices[is_sell],
	vmovsd	-24(%rsp,%rdx,8), %xmm0	# MEM[(double[2] *)_22][_44], _45
# spec_strategy.cpp:25:     return __builtin_assume_aligned(g_pool + offset, 16);
	leaq	_ZN12_GLOBAL__N_1L6g_poolE(%r9), %r10	#, _110
# /opt/homebrew/Cellar/x86_64-unknown-linux-gnu/15.2.0/toolchain/x86_64-unknown-linux-gnu/include/c++/15.2.0/bits/stl_vector.h:407: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	movq	%rax, 16(%rdi)	# _104, MEM[(struct _Vector_base *)_75(D)]._M_impl.D.50016._M_end_of_storage
# /opt/homebrew/Cellar/x86_64-unknown-linux-gnu/15.2.0/toolchain/x86_64-unknown-linux-gnu/include/c++/15.2.0/bits/stl_vector.h:405: 	this->_M_impl._M_start = this->_M_allocate(__n);
	movq	%r10, (%rdi)	# _110, MEM[(struct _Vector_base *)_75(D)]._M_impl.D.50016._M_start
# spec_strategy.cpp:24:     g_pool_offset += aligned_size;
	movq	%rcx, _ZN12_GLOBAL__N_1L13g_pool_offsetE(%rip)	# tmp198, g_pool_offset
# /opt/homebrew/Cellar/x86_64-unknown-linux-gnu/15.2.0/toolchain/x86_64-unknown-linux-gnu/include/c++/15.2.0/bits/stl_construct.h:133:       ::new(static_cast<void*>(__p)) _Tp(std::forward<_Args>(__args)...);
	movb	%r11b, _ZN12_GLOBAL__N_1L6g_poolE(%r9)	# is_sell_72, MEM <unsigned char> [(struct Order *)_111]
	movq	%r8, _ZN12_GLOBAL__N_1L6g_poolE+8(%r9)	# SR.71, MEM <size_t> [(struct Order *)_111 + 8B]
	movq	%rsi, _ZN12_GLOBAL__N_1L6g_poolE+16(%r9)	# SR.72, MEM <const char *> [(struct Order *)_111 + 16B]
	vmovsd	%xmm0, _ZN12_GLOBAL__N_1L6g_poolE+24(%r9)	# _45, MEM[(struct Order *)_111].price
	vmovd	%xmm6, _ZN12_GLOBAL__N_1L6g_poolE+32(%r9)	# _46, MEM[(struct Order *)_111].qty
# /opt/homebrew/Cellar/x86_64-unknown-linux-gnu/15.2.0/toolchain/x86_64-unknown-linux-gnu/include/c++/15.2.0/bits/stl_vector.h:1999: 	this->_M_impl._M_finish =
	movq	%rax, 8(%rdi)	# _104,
	jmp	.L6	#
	.p2align 4,,10
	.p2align 3
.L12:
# spec_strategy.cpp:103:                     bool is_sell = base >= 0.0;
	vxorpd	%xmm3, %xmm3, %xmm3	# tmp185
# spec_strategy.cpp:104:                     double prices[2] = { t.ask_px, t.bid_px };
	vpermilpd	$1, 24(%rsi), %xmm4	#, MEM <const vector(2) double> [(double *)t_49(D) + 24B], vect__34.98_100
# spec_strategy.cpp:23:     std::size_t offset = g_pool_offset;
	movq	_ZN12_GLOBAL__N_1L13g_pool_offsetE(%rip), %r10	# g_pool_offset, offset
# spec_strategy.cpp:103:                     bool is_sell = base >= 0.0;
	vcomisd	%xmm3, %xmm6	# tmp185, base
# spec_strategy.cpp:105:                     return std::vector<csot::Order>(1, csot::Order{
	movq	8(%rsi), %r8	# MEM <size_t> [(const struct Tick &)t_49(D) + 8], SR.66
	movq	16(%rsi), %rsi	# MEM <const char *> [(const struct Tick &)t_49(D) + 16], SR.67
# spec_strategy.cpp:104:                     double prices[2] = { t.ask_px, t.bid_px };
	vmovapd	%xmm4, -24(%rsp)	# vect__34.98_100, MEM <vector(2) double> [(double *)_22]
# spec_strategy.cpp:24:     g_pool_offset += aligned_size;
	leaq	48(%r10), %rcx	#, tmp190
# spec_strategy.cpp:25:     return __builtin_assume_aligned(g_pool + offset, 16);
	leaq	_ZN12_GLOBAL__N_1L6g_poolE(%r10), %rax	#, _98
# /opt/homebrew/Cellar/x86_64-unknown-linux-gnu/15.2.0/toolchain/x86_64-unknown-linux-gnu/include/c++/15.2.0/bits/stl_vector.h:405: 	this->_M_impl._M_start = this->_M_allocate(__n);
	movq	%rax, (%rdi)	# _98, MEM[(struct _Vector_base *)_75(D)]._M_impl.D.50016._M_start
# spec_strategy.cpp:108:                         prices[is_sell],
	setnb	%dl	#, _36
# spec_strategy.cpp:103:                     bool is_sell = base >= 0.0;
	setnb	%r11b	#, is_sell_80
# spec_strategy.cpp:24:     g_pool_offset += aligned_size;
	movq	%rcx, _ZN12_GLOBAL__N_1L13g_pool_offsetE(%rip)	# tmp190, g_pool_offset
# spec_strategy.cpp:108:                         prices[is_sell],
	movzbl	%dl, %r9d	# _36, _36
# /opt/homebrew/Cellar/x86_64-unknown-linux-gnu/15.2.0/toolchain/x86_64-unknown-linux-gnu/include/c++/15.2.0/bits/stl_vector.h:407: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	leaq	_ZN12_GLOBAL__N_1L6g_poolE+40(%r10), %rdx	#, _91
# spec_strategy.cpp:108:                         prices[is_sell],
	vmovsd	-24(%rsp,%r9,8), %xmm1	# MEM[(double[2] *)_22][_36], _37
# /opt/homebrew/Cellar/x86_64-unknown-linux-gnu/15.2.0/toolchain/x86_64-unknown-linux-gnu/include/c++/15.2.0/bits/stl_vector.h:407: 	this->_M_impl._M_end_of_storage = this->_M_impl._M_start + __n;
	movq	%rdx, 16(%rdi)	# _91, MEM[(struct _Vector_base *)_75(D)]._M_impl.D.50016._M_end_of_storage
# /opt/homebrew/Cellar/x86_64-unknown-linux-gnu/15.2.0/toolchain/x86_64-unknown-linux-gnu/include/c++/15.2.0/bits/stl_construct.h:133:       ::new(static_cast<void*>(__p)) _Tp(std::forward<_Args>(__args)...);
	movb	%r11b, _ZN12_GLOBAL__N_1L6g_poolE(%r10)	# is_sell_80, MEM <unsigned char> [(struct Order *)_99]
	movq	%r8, _ZN12_GLOBAL__N_1L6g_poolE+8(%r10)	# SR.66, MEM <size_t> [(struct Order *)_99 + 8B]
	movq	%rsi, _ZN12_GLOBAL__N_1L6g_poolE+16(%r10)	# SR.67, MEM <const char *> [(struct Order *)_99 + 16B]
	movl	$1, _ZN12_GLOBAL__N_1L6g_poolE+32(%r10)	#, MEM[(struct Order *)_99].qty
	vmovsd	%xmm1, _ZN12_GLOBAL__N_1L6g_poolE+24(%r10)	# _37, MEM[(struct Order *)_99].price
# /opt/homebrew/Cellar/x86_64-unknown-linux-gnu/15.2.0/toolchain/x86_64-unknown-linux-gnu/include/c++/15.2.0/bits/stl_vector.h:1999: 	this->_M_impl._M_finish =
	movq	%rdx, 8(%rdi)	# _91,
	jmp	.L6	#
	.cfi_endproc
.LFE2450:
	.size	_ZN12_GLOBAL__N_112SpecStrategy7on_tickERKN4csot4TickE, .-_ZN12_GLOBAL__N_112SpecStrategy7on_tickERKN4csot4TickE
	.text
	.align 2
	.p2align 6
	.type	_ZN12_GLOBAL__N_112SpecStrategyD0Ev, @function
_ZN12_GLOBAL__N_112SpecStrategyD0Ev:
.LFB2730:
	.cfi_startproc
# spec_strategy.cpp:52: class alignas(64) SpecStrategy final : public csot::Strategy {
	movl	$64, %edx	#,
	movl	$64, %esi	#,
	jmp	*_ZdlPvmSt11align_val_t@GOTPCREL(%rip)	#
	.cfi_endproc
.LFE2730:
	.size	_ZN12_GLOBAL__N_112SpecStrategyD0Ev, .-_ZN12_GLOBAL__N_112SpecStrategyD0Ev
	.section	.text.hot
	.p2align 6
	.globl	_Znwm
	.type	_Znwm, @function
_Znwm:
.LFB2434:
	.cfi_startproc
# spec_strategy.cpp:23:     std::size_t offset = g_pool_offset;
	movq	_ZN12_GLOBAL__N_1L13g_pool_offsetE(%rip), %rax	# g_pool_offset, offset
# spec_strategy.cpp:22:     std::size_t aligned_size = (size + 15) & ~15;
	addq	$15, %rdi	#, _1
# spec_strategy.cpp:22:     std::size_t aligned_size = (size + 15) & ~15;
	andq	$-16, %rdi	#, aligned_size_5
# spec_strategy.cpp:24:     g_pool_offset += aligned_size;
	addq	%rax, %rdi	# offset, tmp106
# spec_strategy.cpp:25:     return __builtin_assume_aligned(g_pool + offset, 16);
	addq	$_ZN12_GLOBAL__N_1L6g_poolE, %rax	#, _3
# spec_strategy.cpp:24:     g_pool_offset += aligned_size;
	movq	%rdi, _ZN12_GLOBAL__N_1L13g_pool_offsetE(%rip)	# tmp106, g_pool_offset
# spec_strategy.cpp:26: }
	ret	
	.cfi_endproc
.LFE2434:
	.size	_Znwm, .-_Znwm
	.text
	.p2align 6
	.globl	_ZdlPv
	.type	_ZdlPv, @function
_ZdlPv:
.LFB2435:
	.cfi_startproc
# spec_strategy.cpp:28: void operator delete(void*) noexcept {}
	ret	
	.cfi_endproc
.LFE2435:
	.size	_ZdlPv, .-_ZdlPv
	.p2align 6
	.globl	_ZdlPvm
	.type	_ZdlPvm, @function
_ZdlPvm:
.LFB2436:
	.cfi_startproc
# spec_strategy.cpp:29: void operator delete(void*, std::size_t) noexcept {}
	ret	
	.cfi_endproc
.LFE2436:
	.size	_ZdlPvm, .-_ZdlPvm
	.p2align 6
	.globl	_Znam
	.type	_Znam, @function
_Znam:
.LFB2437:
	.cfi_startproc
# spec_strategy.cpp:23:     std::size_t offset = g_pool_offset;
	movq	_ZN12_GLOBAL__N_1L13g_pool_offsetE(%rip), %rax	# g_pool_offset, offset
# spec_strategy.cpp:22:     std::size_t aligned_size = (size + 15) & ~15;
	addq	$15, %rdi	#, _3
# spec_strategy.cpp:22:     std::size_t aligned_size = (size + 15) & ~15;
	andq	$-16, %rdi	#, aligned_size_4
# spec_strategy.cpp:24:     g_pool_offset += aligned_size;
	addq	%rax, %rdi	# offset, tmp106
# spec_strategy.cpp:25:     return __builtin_assume_aligned(g_pool + offset, 16);
	addq	$_ZN12_GLOBAL__N_1L6g_poolE, %rax	#, _7
# spec_strategy.cpp:24:     g_pool_offset += aligned_size;
	movq	%rdi, _ZN12_GLOBAL__N_1L13g_pool_offsetE(%rip)	# tmp106, g_pool_offset
# spec_strategy.cpp:30: void* operator new[](std::size_t size) { return operator new(size); }
	ret	
	.cfi_endproc
.LFE2437:
	.size	_Znam, .-_Znam
	.p2align 6
	.globl	_ZdaPv
	.type	_ZdaPv, @function
_ZdaPv:
.LFB2732:
	.cfi_startproc
	ret	
	.cfi_endproc
.LFE2732:
	.size	_ZdaPv, .-_ZdaPv
	.p2align 6
	.globl	_ZdaPvm
	.type	_ZdaPvm, @function
_ZdaPvm:
.LFB2734:
	.cfi_startproc
	ret	
	.cfi_endproc
.LFE2734:
	.size	_ZdaPvm, .-_ZdaPvm
	.p2align 6
	.globl	create_strategy
	.type	create_strategy, @function
create_strategy:
.LFB2475:
	.cfi_startproc
	pushq	%rbx	#
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
# spec_strategy.cpp:142:     return new SpecStrategy();
	movl	$64, %esi	#,
	movl	$64, %edi	#,
# spec_strategy.cpp:141: extern "C" csot::Strategy* create_strategy() {
	subq	$16, %rsp	#,
	.cfi_def_cfa_offset 32
# spec_strategy.cpp:142:     return new SpecStrategy();
	call	*_ZnwmSt11align_val_t@GOTPCREL(%rip)	#
# spec_strategy.cpp:54:     SpecStrategy() noexcept {
	movq	$_ZTVN12_GLOBAL__N_112SpecStrategyE+16, (%rax)	#, MEM[(struct SpecStrategy *)_3].D.49585._vptr.Strategy
# spec_strategy.cpp:142:     return new SpecStrategy();
	movq	%rax, %rbx	#, <retval>
# spec_strategy.cpp:55:         for (std::size_t i = 0; i < sizeof(g_pool); i += 4096) {
	xorl	%eax, %eax	# i
	.p2align 6
	.p2align 3
.L25:
# spec_strategy.cpp:56:             volatile char c = g_pool[i];
	movzbl	_ZN12_GLOBAL__N_1L6g_poolE(%rax), %edx	# MEM[(char *)&g_pool + i_16 * 1], _6
	movzbl	_ZN12_GLOBAL__N_1L6g_poolE+4096(%rax), %ecx	# MEM[(char *)&g_pool + i_16 * 1], _6
# spec_strategy.cpp:55:         for (std::size_t i = 0; i < sizeof(g_pool); i += 4096) {
	addq	$32768, %rax	#, i
# spec_strategy.cpp:56:             volatile char c = g_pool[i];
	movzbl	_ZN12_GLOBAL__N_1L6g_poolE-24576(%rax), %esi	# MEM[(char *)&g_pool + i_16 * 1], _6
	movzbl	_ZN12_GLOBAL__N_1L6g_poolE-20480(%rax), %edi	# MEM[(char *)&g_pool + i_16 * 1], _6
	movzbl	_ZN12_GLOBAL__N_1L6g_poolE-16384(%rax), %r8d	# MEM[(char *)&g_pool + i_16 * 1], _6
	movzbl	_ZN12_GLOBAL__N_1L6g_poolE-12288(%rax), %r9d	# MEM[(char *)&g_pool + i_16 * 1], _6
# spec_strategy.cpp:56:             volatile char c = g_pool[i];
	movb	%dl, 15(%rsp)	# _6, c
# spec_strategy.cpp:56:             volatile char c = g_pool[i];
	movzbl	_ZN12_GLOBAL__N_1L6g_poolE-8192(%rax), %r10d	# MEM[(char *)&g_pool + i_16 * 1], _6
	movzbl	_ZN12_GLOBAL__N_1L6g_poolE-4096(%rax), %r11d	# MEM[(char *)&g_pool + i_16 * 1], _6
# spec_strategy.cpp:57:             (void)c;
	movzbl	15(%rsp), %edx	# c, vol.1_7
# spec_strategy.cpp:56:             volatile char c = g_pool[i];
	movb	%cl, 15(%rsp)	# _6, c
# spec_strategy.cpp:57:             (void)c;
	movzbl	15(%rsp), %edx	# c, vol.1_7
# spec_strategy.cpp:56:             volatile char c = g_pool[i];
	movb	%sil, 15(%rsp)	# _6, c
# spec_strategy.cpp:57:             (void)c;
	movzbl	15(%rsp), %edx	# c, vol.1_7
# spec_strategy.cpp:56:             volatile char c = g_pool[i];
	movb	%dil, 15(%rsp)	# _6, c
# spec_strategy.cpp:57:             (void)c;
	movzbl	15(%rsp), %edx	# c, vol.1_7
# spec_strategy.cpp:56:             volatile char c = g_pool[i];
	movb	%r8b, 15(%rsp)	# _6, c
# spec_strategy.cpp:57:             (void)c;
	movzbl	15(%rsp), %edx	# c, vol.1_7
# spec_strategy.cpp:56:             volatile char c = g_pool[i];
	movb	%r9b, 15(%rsp)	# _6, c
# spec_strategy.cpp:57:             (void)c;
	movzbl	15(%rsp), %edx	# c, vol.1_7
# spec_strategy.cpp:56:             volatile char c = g_pool[i];
	movb	%r10b, 15(%rsp)	# _6, c
# spec_strategy.cpp:57:             (void)c;
	movzbl	15(%rsp), %edx	# c, vol.1_7
# spec_strategy.cpp:56:             volatile char c = g_pool[i];
	movb	%r11b, 15(%rsp)	# _6, c
# spec_strategy.cpp:57:             (void)c;
	movzbl	15(%rsp), %edx	# c, vol.1_7
# spec_strategy.cpp:55:         for (std::size_t i = 0; i < sizeof(g_pool); i += 4096) {
	cmpq	$8388608, %rax	#, i
	jne	.L25	#,
# spec_strategy.cpp:59:         std::memset(g_slots, 0, sizeof(g_slots));
	xorl	%eax, %eax	# tmp106
	movl	$256, %ecx	#, tmp107
	movl	$_ZN12_GLOBAL__N_1L7g_slotsE, %edi	#, tmp104
# spec_strategy.cpp:60:         std::memset(g_mids_data, 0, sizeof(g_mids_data));
	xorl	%esi, %esi	#
# spec_strategy.cpp:59:         std::memset(g_slots, 0, sizeof(g_slots));
	rep stosq
# spec_strategy.cpp:60:         std::memset(g_mids_data, 0, sizeof(g_mids_data));
	movl	$32768, %edx	#,
	movl	$_ZN12_GLOBAL__N_1L11g_mids_dataE, %edi	#,
	call	*memset@GOTPCREL(%rip)	#
# spec_strategy.cpp:143: }
	addq	$16, %rsp	#,
	.cfi_def_cfa_offset 16
	movq	%rbx, %rax	# <retval>,
	popq	%rbx	#
	.cfi_def_cfa_offset 8
	ret	
	.cfi_endproc
.LFE2475:
	.size	create_strategy, .-create_strategy
	.weak	_ZTSN4csot8StrategyE
	.section	.rodata._ZTSN4csot8StrategyE,"aG",@progbits,_ZTSN4csot8StrategyE,comdat
	.align 16
	.type	_ZTSN4csot8StrategyE, @object
	.size	_ZTSN4csot8StrategyE, 17
_ZTSN4csot8StrategyE:
	.string	"N4csot8StrategyE"
	.weak	_ZTIN4csot8StrategyE
	.section	.rodata._ZTIN4csot8StrategyE,"aG",@progbits,_ZTIN4csot8StrategyE,comdat
	.align 8
	.type	_ZTIN4csot8StrategyE, @object
	.size	_ZTIN4csot8StrategyE, 16
_ZTIN4csot8StrategyE:
# <anonymous>:
# <anonymous>:
	.quad	_ZTVN10__cxxabiv117__class_type_infoE+16
# <anonymous>:
	.quad	_ZTSN4csot8StrategyE
	.section	.rodata
	.align 8
	.type	_ZTIN12_GLOBAL__N_112SpecStrategyE, @object
	.size	_ZTIN12_GLOBAL__N_112SpecStrategyE, 24
_ZTIN12_GLOBAL__N_112SpecStrategyE:
# <anonymous>:
# <anonymous>:
	.quad	_ZTVN10__cxxabiv120__si_class_type_infoE+16
# <anonymous>:
	.quad	_ZTSN12_GLOBAL__N_112SpecStrategyE
# <anonymous>:
	.quad	_ZTIN4csot8StrategyE
	.align 32
	.type	_ZTSN12_GLOBAL__N_112SpecStrategyE, @object
	.size	_ZTSN12_GLOBAL__N_112SpecStrategyE, 32
_ZTSN12_GLOBAL__N_112SpecStrategyE:
	.string	"*N12_GLOBAL__N_112SpecStrategyE"
	.align 8
	.type	_ZTVN12_GLOBAL__N_112SpecStrategyE, @object
	.size	_ZTVN12_GLOBAL__N_112SpecStrategyE, 56
_ZTVN12_GLOBAL__N_112SpecStrategyE:
	.quad	0
	.quad	_ZTIN12_GLOBAL__N_112SpecStrategyE
	.quad	_ZN12_GLOBAL__N_112SpecStrategyD1Ev
	.quad	_ZN12_GLOBAL__N_112SpecStrategyD0Ev
	.quad	_ZN4csot8Strategy7on_initEv
	.quad	_ZN12_GLOBAL__N_112SpecStrategy7on_tickERKN4csot4TickE
	.quad	_ZN12_GLOBAL__N_112SpecStrategy7on_fillERKN4csot5OrderEdj
	.local	_ZN12_GLOBAL__N_1L11g_mids_dataE
	.comm	_ZN12_GLOBAL__N_1L11g_mids_dataE,32768,64
	.local	_ZN12_GLOBAL__N_1L7g_slotsE
	.comm	_ZN12_GLOBAL__N_1L7g_slotsE,2048,64
	.local	_ZN12_GLOBAL__N_1L13g_pool_offsetE
	.comm	_ZN12_GLOBAL__N_1L13g_pool_offsetE,8,8
	.local	_ZN12_GLOBAL__N_1L6g_poolE
	.comm	_ZN12_GLOBAL__N_1L6g_poolE,8388608,64
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	0
	.long	-1081081856
	.align 8
.LC1:
	.long	-774749268
	.long	1018327645
	.align 8
.LC2:
	.long	0
	.long	1078984704
	.align 8
.LC3:
	.long	0
	.long	1081081856
	.align 8
.LC5:
	.long	0
	.long	1076887552
	.ident	"GCC: (GNU) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
