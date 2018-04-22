	.text
	.file	"bzip2.opt.bc"
	.globl	BZ2_blockSort
	.p2align	4, 0x90
	.type	BZ2_blockSort,@function
BZ2_blockSort:                          # @BZ2_blockSort
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi0:
	.cfi_def_cfa_offset 16
.Lcfi1:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi2:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
.Lcfi3:
	.cfi_offset %rbx, -56
.Lcfi4:
	.cfi_offset %r12, -48
.Lcfi5:
	.cfi_offset %r13, -40
.Lcfi6:
	.cfi_offset %r14, -32
.Lcfi7:
	.cfi_offset %r15, -24
	movq	%rdi, %rbx
	movq	40(%rbx), %rcx
	movq	56(%rbx), %r14
	movl	108(%rbx), %r13d
	movl	656(%rbx), %r15d
	cmpl	$9999, %r13d            # imm = 0x270F
	jg	.LBB0_2
# BB#1:                                 # %if.then
	movq	24(%rbx), %rdi
	movq	32(%rbx), %rsi
	movq	%rcx, %rdx
	movl	%r13d, %ecx
	movl	%r15d, %r8d
	jmp	.LBB0_8
.LBB0_2:                                # %if.else
	movq	64(%rbx), %rsi
	movl	88(%rbx), %eax
	leal	34(%r13), %edi
	leal	35(%r13), %edx
	testb	$1, %dil
	cmovel	%edi, %edx
	movslq	%edx, %rdx
	addq	%rsi, %rdx
	testl	%eax, %eax
	movl	$1, %edi
	cmovlel	%edi, %eax
	cmpl	$100, %eax
	movl	$100, %edi
	cmovlel	%eax, %edi
	decl	%edi
	movslq	%edi, %rax
	imulq	$1431655766, %rax, %r12 # imm = 0x55555556
	movq	%r12, %rax
	shrq	$63, %rax
	shrq	$32, %r12
	addl	%eax, %r12d
	imull	%r13d, %r12d
	movl	%r12d, -44(%rbp)
	leaq	-44(%rbp), %rax
	movq	%rax, (%rsp)
	movq	%r14, %rdi
	movq	%rcx, -56(%rbp)         # 8-byte Spill
	movl	%r13d, %r8d
	movl	%r15d, %r9d
	callq	mainSort
	movl	%r15d, %r8d
	cmpl	$3, %r8d
	jl	.LBB0_4
# BB#3:                                 # %if.then13
	movq	stderr(%rip), %rdi
	subl	-44(%rbp), %r12d
	cvtsi2ssl	%r12d, %xmm0
	testl	%r13d, %r13d
	movl	$1, %eax
	cmovnel	%r13d, %eax
	cvtsi2ssl	%eax, %xmm1
	divss	%xmm1, %xmm0
	cvtss2sd	%xmm0, %xmm0
	movl	$.L.str, %esi
	movb	$1, %al
	movl	%r12d, %edx
	movl	%r13d, %ecx
	callq	fprintf
	movl	%r15d, %r8d
.LBB0_4:                                # %if.end21
	cmpl	$0, -44(%rbp)
	jns	.LBB0_9
# BB#5:                                 # %if.then24
	cmpl	$2, %r8d
	jl	.LBB0_7
# BB#6:                                 # %if.then27
	movq	stderr(%rip), %rdi
	movl	$.L.str.1, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	%r15d, %r8d
.LBB0_7:                                # %if.end29
	movq	24(%rbx), %rdi
	movq	32(%rbx), %rsi
	movq	-56(%rbp), %rdx         # 8-byte Reload
	movl	%r13d, %ecx
.LBB0_8:                                # %if.end33
	callq	fallbackSort
.LBB0_9:                                # %if.end33
	movl	$-1, 48(%rbx)
	xorl	%eax, %eax
	cmpl	108(%rbx), %eax
	jl	.LBB0_11
	jmp	.LBB0_13
	.p2align	4, 0x90
.LBB0_16:                               # %for.inc
                                        #   in Loop: Header=BB0_11 Depth=1
	incq	%rax
	cmpl	108(%rbx), %eax
	jge	.LBB0_13
.LBB0_11:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$0, (%r14,%rax,4)
	jne	.LBB0_16
# BB#12:                                # %if.then41
	movl	%eax, 48(%rbx)
.LBB0_13:                               # %for.end
	cmpl	$-1, 48(%rbx)
	jne	.LBB0_15
# BB#14:                                # %if.then48
	movl	$1003, %edi             # imm = 0x3EB
	callq	BZ2_bz__AssertH__fail
.LBB0_15:                               # %if.end49
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end0:
	.size	BZ2_blockSort, .Lfunc_end0-BZ2_blockSort
	.cfi_endproc

	.p2align	4, 0x90
	.type	fallbackSort,@function
fallbackSort:                           # @fallbackSort
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi8:
	.cfi_def_cfa_offset 16
.Lcfi9:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi10:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$2088, %rsp             # imm = 0x828
.Lcfi11:
	.cfi_offset %rbx, -56
.Lcfi12:
	.cfi_offset %r12, -48
.Lcfi13:
	.cfi_offset %r13, -40
.Lcfi14:
	.cfi_offset %r14, -32
.Lcfi15:
	.cfi_offset %r15, -24
	movl	%r8d, %r15d
	movl	%ecx, %r8d
	movq	%rdx, %r13
	movq	%rsi, %rbx
	movq	%rdi, %r14
	cmpl	$4, %r15d
	movl	%r8d, -44(%rbp)         # 4-byte Spill
	jl	.LBB1_2
# BB#1:                                 # %if.then
	movq	stderr(%rip), %rdi
	movl	$.L.str.48, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	-44(%rbp), %r8d         # 4-byte Reload
.LBB1_2:                                # %for.cond.preheader
	xorl	%eax, %eax
	cmpl	$257, %eax              # imm = 0x101
	jge	.LBB1_4
	.p2align	4, 0x90
.LBB1_62:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	$0, -1104(%rbp,%rax,4)
	incq	%rax
	cmpl	$257, %eax              # imm = 0x101
	jl	.LBB1_62
.LBB1_4:                                # %for.cond2.preheader
	xorl	%eax, %eax
	cmpl	%r8d, %eax
	jge	.LBB1_6
	.p2align	4, 0x90
.LBB1_63:                               # %for.body4
                                        # =>This Inner Loop Header: Depth=1
	movzbl	(%rbx,%rax), %ecx
	incl	-1104(%rbp,%rcx,4)
	incq	%rax
	cmpl	%r8d, %eax
	jl	.LBB1_63
.LBB1_6:                                # %for.cond13.preheader
	xorl	%eax, %eax
	cmpl	$256, %eax              # imm = 0x100
	jge	.LBB1_8
	.p2align	4, 0x90
.LBB1_64:                               # %for.body15
                                        # =>This Inner Loop Header: Depth=1
	movl	-1104(%rbp,%rax,4), %ecx
	movl	%ecx, -2128(%rbp,%rax,4)
	incq	%rax
	cmpl	$256, %eax              # imm = 0x100
	jl	.LBB1_64
.LBB1_8:                                # %for.cond23.preheader
	movl	$1, %eax
	cmpl	$257, %eax              # imm = 0x101
	jge	.LBB1_10
	.p2align	4, 0x90
.LBB1_65:                               # %for.body25
                                        # =>This Inner Loop Header: Depth=1
	movl	-1108(%rbp,%rax,4), %ecx
	addl	%ecx, -1104(%rbp,%rax,4)
	incq	%rax
	cmpl	$257, %eax              # imm = 0x101
	jl	.LBB1_65
.LBB1_10:                               # %for.cond33.preheader
	xorl	%eax, %eax
	cmpl	%r8d, %eax
	jge	.LBB1_13
	.p2align	4, 0x90
.LBB1_12:                               # %for.body35
                                        # =>This Inner Loop Header: Depth=1
	movzbl	(%rbx,%rax), %ecx
	movslq	-1104(%rbp,%rcx,4), %rdx
	leaq	-1(%rdx), %rsi
	movl	%esi, -1104(%rbp,%rcx,4)
	movl	%eax, -4(%r14,%rdx,4)
	incq	%rax
	cmpl	%r8d, %eax
	jl	.LBB1_12
.LBB1_13:                               # %for.end47
	movl	%r8d, %eax
	sarl	$31, %eax
	shrl	$27, %eax
	addl	%r8d, %eax
	sarl	$5, %eax
	addl	$2, %eax
	xorl	%ecx, %ecx
	cmpl	%eax, %ecx
	jge	.LBB1_15
	.p2align	4, 0x90
.LBB1_66:                               # %for.body52
                                        # =>This Inner Loop Header: Depth=1
	movl	$0, (%r13,%rcx,4)
	incq	%rcx
	cmpl	%eax, %ecx
	jl	.LBB1_66
.LBB1_15:                               # %for.cond58.preheader
	xorl	%eax, %eax
	cmpl	$256, %eax              # imm = 0x100
	jge	.LBB1_17
	.p2align	4, 0x90
.LBB1_67:                               # %for.body61
                                        # =>This Inner Loop Header: Depth=1
	movl	-1104(%rbp,%rax,4), %ecx
	movl	$1, %edx
	shll	%cl, %edx
	sarl	$5, %ecx
	movslq	%ecx, %rcx
	orl	%edx, (%r13,%rcx,4)
	incq	%rax
	cmpl	$256, %eax              # imm = 0x100
	jl	.LBB1_67
.LBB1_17:                               # %for.cond71.preheader
	xorl	%edx, %edx
	movl	%r8d, %eax
	cmpl	$32, %edx
	jge	.LBB1_19
	.p2align	4, 0x90
.LBB1_68:                               # %for.body74
                                        # =>This Inner Loop Header: Depth=1
	movl	$1, %esi
	movl	%eax, %ecx
	shll	%cl, %esi
	movl	%eax, %ecx
	sarl	$5, %ecx
	movslq	%ecx, %rcx
	orl	%esi, (%r13,%rcx,4)
	leal	1(%rax), %ecx
	movl	$-2, %esi
	roll	%cl, %esi
	sarl	$5, %ecx
	movslq	%ecx, %rcx
	andl	%esi, (%r13,%rcx,4)
	incl	%edx
	addl	$2, %eax
	cmpl	$32, %edx
	jl	.LBB1_68
.LBB1_19:                               # %while.body.preheader
	movl	$1, %r12d
	movq	%rbx, -64(%rbp)         # 8-byte Spill
	movq	%r14, -56(%rbp)         # 8-byte Spill
	movl	%r15d, -68(%rbp)        # 4-byte Spill
	.p2align	4, 0x90
.LBB1_20:                               # %while.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_69 Depth 2
                                        #     Child Loop BB1_25 Depth 2
                                        #       Child Loop BB1_27 Depth 3
                                        #       Child Loop BB1_29 Depth 3
                                        #       Child Loop BB1_32 Depth 3
                                        #       Child Loop BB1_35 Depth 3
                                        #       Child Loop BB1_37 Depth 3
                                        #       Child Loop BB1_44 Depth 3
	cmpl	$4, %r15d
	jl	.LBB1_22
# BB#21:                                # %if.then101
                                        #   in Loop: Header=BB1_20 Depth=1
	movq	stderr(%rip), %rdi
	movl	$.L.str.49, %esi
	xorl	%eax, %eax
	movl	%r12d, %edx
	callq	fprintf
	movl	-44(%rbp), %r8d         # 4-byte Reload
.LBB1_22:                               # %for.cond104.preheader
                                        #   in Loop: Header=BB1_20 Depth=1
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	cmpl	%r8d, %eax
	jge	.LBB1_24
	.p2align	4, 0x90
.LBB1_69:                               # %for.body107
                                        #   Parent Loop BB1_20 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	(%r14,%rax,4), %edx
	movl	%edx, %esi
	subl	%r12d, %esi
	addl	%r8d, %esi
	subl	%r12d, %edx
	cmovsl	%esi, %edx
	movl	%eax, %esi
	sarl	$5, %esi
	movslq	%esi, %rsi
	movl	(%r13,%rsi,4), %esi
	btl	%eax, %esi
	cmovbl	%eax, %ecx
	movslq	%edx, %rdx
	movl	%ecx, (%rbx,%rdx,4)
	incq	%rax
	cmpl	%r8d, %eax
	jl	.LBB1_69
.LBB1_24:                               # %while.body130.preheader
                                        #   in Loop: Header=BB1_20 Depth=1
	xorl	%edx, %edx
	movl	$-1, %r15d
	jmp	.LBB1_25
.LBB1_43:                               #   in Loop: Header=BB1_25 Depth=2
	movl	-44(%rbp), %r8d         # 4-byte Reload
	movq	%rbx, %rdx
	.p2align	4, 0x90
.LBB1_25:                               # %while.cond132
                                        #   Parent Loop BB1_20 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_27 Depth 3
                                        #       Child Loop BB1_29 Depth 3
                                        #       Child Loop BB1_32 Depth 3
                                        #       Child Loop BB1_35 Depth 3
                                        #       Child Loop BB1_37 Depth 3
                                        #       Child Loop BB1_44 Depth 3
	incl	%r15d
	movl	%r15d, %eax
	sarl	$5, %eax
	cltq
	movl	(%r13,%rax,4), %ecx
	movl	%r15d, %esi
	andl	$31, %esi
	setne	%bl
	btl	%esi, %ecx
	sbbb	%cl, %cl
	testb	%bl, %cl
	jne	.LBB1_25
# BB#26:                                # %while.end
                                        #   in Loop: Header=BB1_25 Depth=2
	movl	(%r13,%rax,4), %eax
	btl	%r15d, %eax
	jb	.LBB1_27
	jmp	.LBB1_31
	.p2align	4, 0x90
.LBB1_28:                               # %while.body158
                                        #   in Loop: Header=BB1_27 Depth=3
	addl	$32, %r15d
.LBB1_27:                               # %while.cond152
                                        #   Parent Loop BB1_20 Depth=1
                                        #     Parent Loop BB1_25 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	%r15d, %eax
	sarl	$5, %eax
	cltq
	cmpl	$-1, (%r13,%rax,4)
	je	.LBB1_28
	jmp	.LBB1_29
	.p2align	4, 0x90
.LBB1_30:                               # %while.body169
                                        #   in Loop: Header=BB1_29 Depth=3
	incl	%r15d
.LBB1_29:                               # %while.cond161
                                        #   Parent Loop BB1_20 Depth=1
                                        #     Parent Loop BB1_25 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	%r15d, %eax
	sarl	$5, %eax
	cltq
	movl	(%r13,%rax,4), %eax
	btl	%r15d, %eax
	jb	.LBB1_30
.LBB1_31:                               # %if.end172
                                        #   in Loop: Header=BB1_25 Depth=2
	leal	-1(%r15), %r14d
	cmpl	%r8d, %r14d
	jl	.LBB1_32
	jmp	.LBB1_47
	.p2align	4, 0x90
.LBB1_33:                               # %while.body190
                                        #   in Loop: Header=BB1_32 Depth=3
	incl	%r15d
.LBB1_32:                               # %while.cond178
                                        #   Parent Loop BB1_20 Depth=1
                                        #     Parent Loop BB1_25 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	%r15d, %eax
	sarl	$5, %eax
	cltq
	movl	(%r13,%rax,4), %ecx
	movl	%r15d, %esi
	andl	$31, %esi
	setne	%bl
	btl	%esi, %ecx
	setae	%cl
	andb	%bl, %cl
	cmpb	$1, %cl
	je	.LBB1_33
# BB#34:                                # %while.end192
                                        #   in Loop: Header=BB1_25 Depth=2
	movl	(%r13,%rax,4), %eax
	btl	%r15d, %eax
	jb	.LBB1_39
	jmp	.LBB1_35
	.p2align	4, 0x90
.LBB1_36:                               # %while.body207
                                        #   in Loop: Header=BB1_35 Depth=3
	addl	$32, %r15d
.LBB1_35:                               # %while.cond201
                                        #   Parent Loop BB1_20 Depth=1
                                        #     Parent Loop BB1_25 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	%r15d, %eax
	sarl	$5, %eax
	cltq
	cmpl	$0, (%r13,%rax,4)
	je	.LBB1_36
	jmp	.LBB1_37
	.p2align	4, 0x90
.LBB1_38:                               # %while.body218
                                        #   in Loop: Header=BB1_37 Depth=3
	incl	%r15d
.LBB1_37:                               # %while.cond210
                                        #   Parent Loop BB1_20 Depth=1
                                        #     Parent Loop BB1_25 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	%r15d, %eax
	sarl	$5, %eax
	cltq
	movl	(%r13,%rax,4), %eax
	btl	%r15d, %eax
	jae	.LBB1_38
.LBB1_39:                               # %if.end221
                                        #   in Loop: Header=BB1_25 Depth=2
	decl	%r15d
	cmpl	%r8d, %r15d
	jge	.LBB1_47
# BB#40:                                # %if.end226
                                        #   in Loop: Header=BB1_25 Depth=2
	movl	%r15d, %eax
	subl	%r14d, %eax
	jle	.LBB1_25
# BB#41:                                # %if.then229
                                        #   in Loop: Header=BB1_25 Depth=2
	leal	1(%rdx,%rax), %edx
	movq	%rdx, %rbx
	movq	-56(%rbp), %rdi         # 8-byte Reload
	movq	-64(%rbp), %rsi         # 8-byte Reload
	movl	%r14d, %edx
	movl	%r15d, %ecx
	callq	fallbackQSort3
	movslq	%r14d, %rcx
	movl	$-1, %eax
	cmpl	%r15d, %ecx
	jle	.LBB1_44
	jmp	.LBB1_43
	.p2align	4, 0x90
.LBB1_46:                               # %for.inc251
                                        #   in Loop: Header=BB1_44 Depth=3
	incq	%rcx
	cmpl	%r15d, %ecx
	jg	.LBB1_43
.LBB1_44:                               # %for.body236
                                        #   Parent Loop BB1_20 Depth=1
                                        #     Parent Loop BB1_25 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	-56(%rbp), %rdx         # 8-byte Reload
	movl	(%rdx,%rcx,4), %edx
	movq	-64(%rbp), %rsi         # 8-byte Reload
	movl	(%rsi,%rdx,4), %edx
	cmpl	%edx, %eax
	je	.LBB1_46
# BB#45:                                # %if.then243
                                        #   in Loop: Header=BB1_44 Depth=3
	movl	$1, %eax
	shll	%cl, %eax
	movl	%ecx, %esi
	sarl	$5, %esi
	movslq	%esi, %rsi
	orl	%eax, (%r13,%rsi,4)
	movl	%edx, %eax
	jmp	.LBB1_46
	.p2align	4, 0x90
.LBB1_47:                               # %while.end255
                                        #   in Loop: Header=BB1_20 Depth=1
	movl	-68(%rbp), %r15d        # 4-byte Reload
	cmpl	$4, %r15d
	jl	.LBB1_49
# BB#48:                                # %if.then258
                                        #   in Loop: Header=BB1_20 Depth=1
	movq	stderr(%rip), %rdi
	movl	$.L.str.50, %esi
	xorl	%eax, %eax
	movq	%rdx, %rbx
	callq	fprintf
	movq	%rbx, %rdx
	movl	-44(%rbp), %r8d         # 4-byte Reload
.LBB1_49:                               # %if.end260
                                        #   in Loop: Header=BB1_20 Depth=1
	addl	%r12d, %r12d
	cmpl	%r8d, %r12d
	movq	-64(%rbp), %rbx         # 8-byte Reload
	movq	-56(%rbp), %r14         # 8-byte Reload
	jg	.LBB1_51
# BB#50:                                # %if.end260
                                        #   in Loop: Header=BB1_20 Depth=1
	testl	%edx, %edx
	jne	.LBB1_20
.LBB1_51:                               # %while.end268
	cmpl	$4, %r15d
	jl	.LBB1_53
# BB#52:                                # %if.then271
	movq	stderr(%rip), %rdi
	movl	$.L.str.51, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	-44(%rbp), %r8d         # 4-byte Reload
.LBB1_53:                               # %for.cond274.preheader
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	cmpl	%r8d, %eax
	jl	.LBB1_55
	jmp	.LBB1_59
	.p2align	4, 0x90
.LBB1_58:                               # %while.end284
                                        #   in Loop: Header=BB1_55 Depth=1
	decl	(%rdx)
	movslq	%eax, %rdx
	movl	(%r14,%rdx,4), %edx
	movb	%cl, (%rbx,%rdx)
	incl	%eax
	cmpl	%r8d, %eax
	jge	.LBB1_59
.LBB1_55:                               # %while.cond.preheader
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_57 Depth 2
	movslq	%ecx, %rdx
	leaq	-2128(%rbp,%rdx,4), %rdx
	cmpl	$0, (%rdx)
	jne	.LBB1_58
	.p2align	4, 0x90
.LBB1_57:                               # %while.body282
                                        #   Parent Loop BB1_55 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	incl	%ecx
	addq	$4, %rdx
	cmpl	$0, (%rdx)
	je	.LBB1_57
	jmp	.LBB1_58
.LBB1_59:                               # %for.end294
	cmpl	$256, %ecx              # imm = 0x100
	jl	.LBB1_61
# BB#60:                                # %if.then297
	movl	$1005, %edi             # imm = 0x3ED
	callq	BZ2_bz__AssertH__fail
.LBB1_61:                               # %if.end298
	addq	$2088, %rsp             # imm = 0x828
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end1:
	.size	fallbackSort, .Lfunc_end1-fallbackSort
	.cfi_endproc

	.p2align	4, 0x90
	.type	mainSort,@function
mainSort:                               # @mainSort
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi16:
	.cfi_def_cfa_offset 16
.Lcfi17:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi18:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$3416, %rsp             # imm = 0xD58
.Lcfi19:
	.cfi_offset %rbx, -56
.Lcfi20:
	.cfi_offset %r12, -48
.Lcfi21:
	.cfi_offset %r13, -40
.Lcfi22:
	.cfi_offset %r14, -32
.Lcfi23:
	.cfi_offset %r15, -24
	movl	%r8d, %ebx
	movq	%rcx, %r13
	movq	%rdx, %r11
	movq	%rsi, -48(%rbp)         # 8-byte Spill
	movq	%rdi, -72(%rbp)         # 8-byte Spill
	movl	%ebx, %eax
	movq	%rax, -120(%rbp)        # 8-byte Spill
	movl	%r9d, -76(%rbp)         # 4-byte Spill
	cmpl	$4, %r9d
	movq	%r11, -56(%rbp)         # 8-byte Spill
	jl	.LBB2_2
# BB#1:                                 # %if.then
	movq	stderr(%rip), %rdi
	movl	$.L.str.52, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	-56(%rbp), %r11         # 8-byte Reload
.LBB2_2:                                # %for.cond.preheader
	movl	$65536, %eax            # imm = 0x10000
	movq	-48(%rbp), %r9          # 8-byte Reload
	testl	%eax, %eax
	js	.LBB2_5
	.p2align	4, 0x90
.LBB2_4:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	$0, (%r13,%rax,4)
	decq	%rax
	testl	%eax, %eax
	jns	.LBB2_4
.LBB2_5:                                # %for.end
	movzbl	(%r9), %ecx
	shll	$8, %ecx
	movslq	%ebx, %rax
	leal	-4(%rbx), %r10d
	leal	-3(%rbx), %edx
	movq	%rdx, -64(%rbp)         # 8-byte Spill
	movq	%rbx, -112(%rbp)        # 8-byte Spill
	leal	-2(%rbx), %r12d
	leaq	-1(%r9,%rax), %r15
	leaq	-2(%r11,%rax,2), %rdx
	leaq	-1(%rax), %r14
	movl	%r14d, %esi
	xorl	%eax, %eax
	movq	-120(%rbp), %rbx        # 8-byte Reload
	jmp	.LBB2_6
	.p2align	4, 0x90
.LBB2_83:                               # %for.body6
                                        #   in Loop: Header=BB2_6 Depth=1
	movw	$0, (%rdx,%rax,2)
	sarl	$8, %ecx
	movzbl	(%r15,%rax), %edi
	shll	$8, %edi
	orl	%ecx, %edi
	movslq	%edi, %rcx
	incl	(%r13,%rcx,4)
	leal	(%r12,%rax), %edi
	movslq	%edi, %rdi
	movw	$0, (%r11,%rdi,2)
	sarl	$8, %ecx
	movzbl	(%r9,%rdi), %edi
	shll	$8, %edi
	orl	%ecx, %edi
	movslq	%edi, %rcx
	incl	(%r13,%rcx,4)
	movq	-64(%rbp), %rdi         # 8-byte Reload
	leal	(%rdi,%rax), %edi
	movslq	%edi, %rdi
	movw	$0, (%r11,%rdi,2)
	sarl	$8, %ecx
	movzbl	(%r9,%rdi), %edi
	shll	$8, %edi
	orl	%ecx, %edi
	movslq	%edi, %rdi
	incl	(%r13,%rdi,4)
	leal	(%r10,%rax), %ecx
	movslq	%ecx, %rcx
	movw	$0, (%r11,%rcx,2)
	sarl	$8, %edi
	movzbl	(%r9,%rcx), %ecx
	shll	$8, %ecx
	orl	%edi, %ecx
	movslq	%ecx, %rdi
	incl	(%r13,%rdi,4)
	addq	$-4, %rax
.LBB2_6:                                # %for.cond3
                                        # =>This Inner Loop Header: Depth=1
	leal	(%rsi,%rax), %edi
	cmpl	$2, %edi
	jg	.LBB2_83
# BB#7:                                 # %for.cond61.preheader
	addq	%r14, %rax
	testl	%eax, %eax
	js	.LBB2_9
	.p2align	4, 0x90
.LBB2_84:                               # %for.body64
                                        # =>This Inner Loop Header: Depth=1
	movw	$0, (%r11,%rax,2)
	sarl	$8, %ecx
	movzbl	(%r9,%rax), %edx
	shll	$8, %edx
	orl	%edx, %ecx
	movslq	%ecx, %rdx
	incl	(%r13,%rdx,4)
	decq	%rax
	testl	%eax, %eax
	jns	.LBB2_84
.LBB2_9:                                # %for.cond80.preheader
	xorl	%eax, %eax
	cmpl	$33, %eax
	jg	.LBB2_12
	.p2align	4, 0x90
.LBB2_11:                               # %for.body83
                                        # =>This Inner Loop Header: Depth=1
	movzbl	(%r9,%rax), %ecx
	leal	(%rbx,%rax), %edx
	movslq	%edx, %rdx
	movb	%cl, (%r9,%rdx)
	movw	$0, (%r11,%rdx,2)
	incq	%rax
	cmpl	$33, %eax
	jle	.LBB2_11
.LBB2_12:                               # %for.end93
	cmpl	$4, -76(%rbp)           # 4-byte Folded Reload
	jl	.LBB2_14
# BB#13:                                # %if.then96
	movq	stderr(%rip), %rdi
	movl	$.L.str.48, %esi
	xorl	%eax, %eax
	movq	%r10, %rbx
	callq	fprintf
	movq	%rbx, %r10
	movq	-48(%rbp), %r9          # 8-byte Reload
	movq	-56(%rbp), %r11         # 8-byte Reload
.LBB2_14:                               # %for.cond99.preheader
	movl	$1, %eax
	cmpl	$65536, %eax            # imm = 0x10000
	jg	.LBB2_17
	.p2align	4, 0x90
.LBB2_16:                               # %for.body102
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%r13,%rax,4), %ecx
	addl	%ecx, (%r13,%rax,4)
	incq	%rax
	cmpl	$65536, %eax            # imm = 0x10000
	jle	.LBB2_16
.LBB2_17:                               # %for.end111
	movzbl	(%r9), %esi
	shll	$8, %esi
	movl	%r14d, %r8d
	xorl	%eax, %eax
	jmp	.LBB2_18
	.p2align	4, 0x90
.LBB2_85:                               # %for.body120
                                        #   in Loop: Header=BB2_18 Depth=1
	movzwl	%si, %esi
	shrl	$8, %esi
	movzbl	(%r15,%rax), %edi
	shll	$8, %edi
	orl	%esi, %edi
	movl	(%r13,%rdi,4), %esi
	decl	%esi
	movl	%esi, (%r13,%rdi,4)
	movslq	%esi, %rsi
	movq	-72(%rbp), %rbx         # 8-byte Reload
	movl	%edx, (%rbx,%rsi,4)
	shrl	$8, %edi
	leal	(%r12,%rax), %esi
	movslq	%esi, %rsi
	movzbl	(%r9,%rsi), %esi
	shll	$8, %esi
	orl	%edi, %esi
	movl	(%r13,%rsi,4), %edi
	decl	%edi
	movl	%edi, (%r13,%rsi,4)
	movslq	%edi, %rdi
	leal	-1(%rdx), %ecx
	movl	%ecx, (%rbx,%rdi,4)
	shrl	$8, %esi
	movq	-64(%rbp), %rcx         # 8-byte Reload
	leal	(%rcx,%rax), %ecx
	movslq	%ecx, %rcx
	movzbl	(%r9,%rcx), %ecx
	shll	$8, %ecx
	orl	%esi, %ecx
	movl	(%r13,%rcx,4), %esi
	decl	%esi
	movl	%esi, (%r13,%rcx,4)
	movslq	%esi, %rsi
	leal	-2(%rdx), %edi
	movl	%edi, (%rbx,%rsi,4)
	shrl	$8, %ecx
	leal	(%r10,%rax), %esi
	movslq	%esi, %rsi
	movzbl	(%r9,%rsi), %esi
	shll	$8, %esi
	orl	%ecx, %esi
	movl	(%r13,%rsi,4), %ecx
	decl	%ecx
	movl	%ecx, (%r13,%rsi,4)
	movslq	%ecx, %rcx
	addl	$-3, %edx
	movl	%edx, (%rbx,%rcx,4)
	addq	$-4, %rax
.LBB2_18:                               # %for.cond117
                                        # =>This Inner Loop Header: Depth=1
	leaq	(%r8,%rax), %rdx
	cmpl	$2, %edx
	jg	.LBB2_85
# BB#19:                                # %for.cond190.preheader
	addq	%rax, %r14
	movq	-72(%rbp), %rcx         # 8-byte Reload
	testl	%r14d, %r14d
	js	.LBB2_21
	.p2align	4, 0x90
.LBB2_86:                               # %for.body193
                                        # =>This Inner Loop Header: Depth=1
	movzwl	%si, %eax
	shrl	$8, %eax
	movzbl	(%r9,%r14), %esi
	shll	$8, %esi
	orl	%eax, %esi
	movl	(%r13,%rsi,4), %eax
	decl	%eax
	movl	%eax, (%r13,%rsi,4)
	cltq
	movl	%r14d, (%rcx,%rax,4)
	decq	%r14
	testl	%r14d, %r14d
	jns	.LBB2_86
.LBB2_21:                               # %for.cond212.preheader
	xorl	%eax, %eax
	cmpl	$256, %eax              # imm = 0x100
	jge	.LBB2_23
	.p2align	4, 0x90
.LBB2_87:                               # %for.body215
                                        # =>This Inner Loop Header: Depth=1
	movb	$0, -384(%rbp,%rax)
	movl	%eax, -1408(%rbp,%rax,4)
	incq	%rax
	cmpl	$256, %eax              # imm = 0x100
	jl	.LBB2_87
.LBB2_23:                               # %do.body.preheader
	movl	$1, %eax
	.p2align	4, 0x90
.LBB2_24:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	leal	1(%rax,%rax,2), %eax
	cmpl	$257, %eax              # imm = 0x101
	jl	.LBB2_24
	.p2align	4, 0x90
.LBB2_25:                               # %do.body226
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_27 Depth 2
                                        #       Child Loop BB2_28 Depth 3
	cltq
	imulq	$1431655766, %rax, %rax # imm = 0x55555556
	movq	%rax, %rcx
	shrq	$63, %rcx
	shrq	$32, %rax
	addl	%ecx, %eax
	xorl	%r8d, %r8d
	movl	%eax, %r9d
	cmpl	$255, %r9d
	jle	.LBB2_27
	jmp	.LBB2_32
	.p2align	4, 0x90
.LBB2_30:                               # %zerosplit
                                        #   in Loop: Header=BB2_27 Depth=2
	addl	%eax, %edi
	movl	%edi, %ecx
.LBB2_31:                               # %zero
                                        #   in Loop: Header=BB2_27 Depth=2
	movslq	%ecx, %rcx
	movl	%r10d, -1408(%rbp,%rcx,4)
	incl	%r9d
	incl	%r8d
	cmpl	$255, %r9d
	jg	.LBB2_32
.LBB2_27:                               # %for.body230
                                        #   Parent Loop BB2_25 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_28 Depth 3
	movslq	%r9d, %rcx
	movl	-1408(%rbp,%rcx,4), %r10d
	movl	%r8d, %edi
	.p2align	4, 0x90
.LBB2_28:                               # %while.cond
                                        #   Parent Loop BB2_25 Depth=1
                                        #     Parent Loop BB2_27 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	leal	(%rax,%rdi), %ecx
	movslq	%edi, %rdx
	movl	-1408(%rbp,%rdx,4), %edi
	shll	$8, %edi
	leal	256(%rdi), %ebx
	movslq	%ebx, %rbx
	movl	(%r13,%rbx,4), %ebx
	movslq	%edi, %rdi
	subl	(%r13,%rdi,4), %ebx
	movl	%r10d, %edi
	shll	$8, %edi
	leal	256(%rdi), %esi
	movslq	%esi, %rsi
	movl	(%r13,%rsi,4), %esi
	movslq	%edi, %rdi
	subl	(%r13,%rdi,4), %esi
	cmpl	%esi, %ebx
	jbe	.LBB2_31
# BB#29:                                # %while.body
                                        #   in Loop: Header=BB2_28 Depth=3
	movl	-1408(%rbp,%rdx,4), %esi
	movslq	%ecx, %rcx
	movl	%esi, -1408(%rbp,%rcx,4)
	leal	-1(%rax), %ecx
	movl	%edx, %edi
	subl	%eax, %edi
	cmpl	%ecx, %edx
	jg	.LBB2_28
	jmp	.LBB2_30
	.p2align	4, 0x90
.LBB2_32:                               # %do.cond273
                                        #   in Loop: Header=BB2_25 Depth=1
	cmpl	$1, %eax
	jne	.LBB2_25
# BB#33:                                # %for.cond277.preheader
	movl	$-2097153, %r10d        # imm = 0xFFDFFFFF
	xorl	%r12d, %r12d
	xorl	%eax, %eax
	movq	%rax, -64(%rbp)         # 8-byte Spill
	movq	-48(%rbp), %rsi         # 8-byte Reload
	cmpl	$255, %r12d
	jle	.LBB2_35
	jmp	.LBB2_80
	.p2align	4, 0x90
.LBB2_79:                               # %for.inc506
                                        #   in Loop: Header=BB2_35 Depth=1
	incl	%r12d
	cmpl	$255, %r12d
	jg	.LBB2_80
.LBB2_35:                               # %for.body280
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_37 Depth 2
                                        #     Child Loop BB2_51 Depth 2
                                        #     Child Loop BB2_54 Depth 2
                                        #     Child Loop BB2_59 Depth 2
                                        #     Child Loop BB2_68 Depth 2
                                        #     Child Loop BB2_71 Depth 2
                                        #     Child Loop BB2_74 Depth 2
	movl	%r12d, -100(%rbp)       # 4-byte Spill
	movslq	%r12d, %rax
	movl	-1408(%rbp,%rax,4), %r12d
	movslq	%r12d, %r9
	movl	%r9d, %ecx
	shll	$8, %ecx
	xorl	%r15d, %r15d
	movq	-72(%rbp), %rdi         # 8-byte Reload
	movq	%r9, -96(%rbp)          # 8-byte Spill
	movq	%rcx, -128(%rbp)        # 8-byte Spill
	cmpl	$255, %r15d
	jle	.LBB2_37
	jmp	.LBB2_47
	.p2align	4, 0x90
.LBB2_46:                               # %for.inc326
                                        #   in Loop: Header=BB2_37 Depth=2
	incl	%r15d
	cmpl	$255, %r15d
	jg	.LBB2_47
.LBB2_37:                               # %for.body286
                                        #   Parent Loop BB2_35 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	%r15d, %r12d
	je	.LBB2_46
# BB#38:                                # %if.then289
                                        #   in Loop: Header=BB2_37 Depth=2
	leal	(%rcx,%r15), %eax
	movslq	%eax, %rbx
	testb	$32, 2(%r13,%rbx,4)
	jne	.LBB2_45
# BB#39:                                # %if.then294
                                        #   in Loop: Header=BB2_37 Depth=2
	movl	(%r13,%rbx,4), %r8d
	andl	%r10d, %r8d
	leal	1(%rcx,%r15), %eax
	cltq
	movl	(%r13,%rax,4), %r14d
	andl	%r10d, %r14d
	decl	%r14d
	movl	%r14d, %eax
	subl	%r8d, %eax
	jle	.LBB2_44
# BB#40:                                # %if.then305
                                        #   in Loop: Header=BB2_37 Depth=2
	movq	%rax, -88(%rbp)         # 8-byte Spill
	cmpl	$4, -76(%rbp)           # 4-byte Folded Reload
	jl	.LBB2_42
# BB#41:                                # %if.then308
                                        #   in Loop: Header=BB2_37 Depth=2
	movq	stderr(%rip), %rdi
	movq	-88(%rbp), %rax         # 8-byte Reload
	leal	1(%rax), %r9d
	movl	$.L.str.53, %esi
	xorl	%eax, %eax
	movl	%r12d, %edx
	movl	%r15d, %ecx
	movl	%r8d, -104(%rbp)        # 4-byte Spill
	movq	-64(%rbp), %r8          # 8-byte Reload
                                        # kill: %R8D<def> %R8D<kill> %R8<kill>
	callq	fprintf
	movl	-104(%rbp), %r8d        # 4-byte Reload
	movq	-72(%rbp), %rdi         # 8-byte Reload
	movq	-48(%rbp), %rsi         # 8-byte Reload
	movq	-56(%rbp), %r11         # 8-byte Reload
.LBB2_42:                               # %if.end312
                                        #   in Loop: Header=BB2_37 Depth=2
	movq	%r11, %rdx
	movq	-120(%rbp), %rcx        # 8-byte Reload
                                        # kill: %ECX<def> %ECX<kill> %RCX<kill>
	movl	%r14d, %r9d
	movq	16(%rbp), %rax
	movq	%rax, %r14
	pushq	%r14
	pushq	$2
	callq	mainQSort3
	addq	$16, %rsp
	cmpl	$0, (%r14)
	js	.LBB2_82
# BB#43:                                #   in Loop: Header=BB2_37 Depth=2
	movq	-64(%rbp), %rax         # 8-byte Reload
	movq	-88(%rbp), %rcx         # 8-byte Reload
	leal	1(%rax,%rcx), %eax
	movq	%rax, -64(%rbp)         # 8-byte Spill
	movq	-56(%rbp), %r11         # 8-byte Reload
	movq	-48(%rbp), %rsi         # 8-byte Reload
	movq	-72(%rbp), %rdi         # 8-byte Reload
	movl	$-2097153, %r10d        # imm = 0xFFDFFFFF
	movq	-96(%rbp), %r9          # 8-byte Reload
.LBB2_44:                               # %if.end321
                                        #   in Loop: Header=BB2_37 Depth=2
	movq	-128(%rbp), %rcx        # 8-byte Reload
.LBB2_45:                               # %if.end321
                                        #   in Loop: Header=BB2_37 Depth=2
	orb	$32, 2(%r13,%rbx,4)
	jmp	.LBB2_46
	.p2align	4, 0x90
.LBB2_47:                               # %for.end328
                                        #   in Loop: Header=BB2_35 Depth=1
	movq	%rcx, %r15
	cmpb	$0, -384(%rbp,%r9)
	movq	-112(%rbp), %r14        # 8-byte Reload
	je	.LBB2_49
# BB#48:                                # %if.then332
                                        #   in Loop: Header=BB2_35 Depth=1
	movl	$1006, %edi             # imm = 0x3EE
	callq	BZ2_bz__AssertH__fail
	movq	-96(%rbp), %r9          # 8-byte Reload
	movl	$-2097153, %r10d        # imm = 0xFFDFFFFF
	movq	-72(%rbp), %rdi         # 8-byte Reload
	movq	-48(%rbp), %rsi         # 8-byte Reload
	movq	-56(%rbp), %r11         # 8-byte Reload
.LBB2_49:                               # %for.cond334.preheader
                                        #   in Loop: Header=BB2_35 Depth=1
	movl	%r12d, %eax
	xorl	%ecx, %ecx
	cmpl	$255, %ecx
	jg	.LBB2_52
	.p2align	4, 0x90
.LBB2_51:                               # %for.body337
                                        #   Parent Loop BB2_35 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cltq
	movl	(%r13,%rax,4), %edx
	andl	%r10d, %edx
	movl	%edx, -3456(%rbp,%rcx,4)
	leal	1(%rax), %edx
	movslq	%edx, %rdx
	movl	(%r13,%rdx,4), %edx
	andl	%r10d, %edx
	decl	%edx
	movl	%edx, -2432(%rbp,%rcx,4)
	incq	%rcx
	addl	$256, %eax              # imm = 0x100
	cmpl	$255, %ecx
	jle	.LBB2_51
.LBB2_52:                               # %for.end356
                                        #   in Loop: Header=BB2_35 Depth=1
	movslq	%r15d, %rax
	movq	%rax, -88(%rbp)         # 8-byte Spill
	movslq	(%r13,%rax,4), %rax
	andq	$-2097153, %rax         # imm = 0xFFDFFFFF
	cmpl	-3456(%rbp,%r9,4), %eax
	jl	.LBB2_54
	jmp	.LBB2_57
	.p2align	4, 0x90
.LBB2_56:                               # %for.inc387
                                        #   in Loop: Header=BB2_54 Depth=2
	incq	%rax
	cmpl	-3456(%rbp,%r9,4), %eax
	jge	.LBB2_57
.LBB2_54:                               # %for.body366
                                        #   Parent Loop BB2_35 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	(%rdi,%rax,4), %edx
	leal	-1(%rdx,%r14), %ecx
                                        # kill: %EDX<def> %EDX<kill> %RDX<kill>
	decl	%edx
	cmovnsl	%edx, %ecx
	movslq	%ecx, %rdx
	movzbl	(%rsi,%rdx), %edx
	cmpb	$0, -384(%rbp,%rdx)
	jne	.LBB2_56
# BB#55:                                # %if.then380
                                        #   in Loop: Header=BB2_54 Depth=2
	movslq	-3456(%rbp,%rdx,4), %r8
	leal	1(%r8), %ebx
	movl	%ebx, -3456(%rbp,%rdx,4)
	movl	%ecx, (%rdi,%r8,4)
	jmp	.LBB2_56
	.p2align	4, 0x90
.LBB2_57:                               # %for.end389
                                        #   in Loop: Header=BB2_35 Depth=1
	addl	$256, %r15d             # imm = 0x100
	movslq	%r15d, %r15
	movl	(%r13,%r15,4), %eax
	andl	%r10d, %eax
	decl	%eax
	cltq
	cmpl	-2432(%rbp,%r9,4), %eax
	jg	.LBB2_59
	jmp	.LBB2_62
	.p2align	4, 0x90
.LBB2_61:                               # %for.inc422
                                        #   in Loop: Header=BB2_59 Depth=2
	decq	%rax
	cmpl	-2432(%rbp,%r9,4), %eax
	jle	.LBB2_62
.LBB2_59:                               # %for.body401
                                        #   Parent Loop BB2_35 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	(%rdi,%rax,4), %edx
	leal	-1(%rdx,%r14), %ecx
                                        # kill: %EDX<def> %EDX<kill> %RDX<kill>
	decl	%edx
	cmovnsl	%edx, %ecx
	movslq	%ecx, %rdx
	movzbl	(%rsi,%rdx), %edx
	cmpb	$0, -384(%rbp,%rdx)
	jne	.LBB2_61
# BB#60:                                # %if.then415
                                        #   in Loop: Header=BB2_59 Depth=2
	movslq	-2432(%rbp,%rdx,4), %r8
	leal	-1(%r8), %ebx
	movl	%ebx, -2432(%rbp,%rdx,4)
	movl	%ecx, (%rdi,%r8,4)
	jmp	.LBB2_61
	.p2align	4, 0x90
.LBB2_62:                               # %for.end424
                                        #   in Loop: Header=BB2_35 Depth=1
	movl	-3456(%rbp,%r9,4), %eax
	decl	%eax
	cmpl	-2432(%rbp,%r9,4), %eax
	je	.LBB2_66
# BB#63:                                # %lor.lhs.false
                                        #   in Loop: Header=BB2_35 Depth=1
	cmpl	$0, -3456(%rbp,%r9,4)
	jne	.LBB2_65
# BB#64:                                # %land.lhs.true
                                        #   in Loop: Header=BB2_35 Depth=1
	leal	-1(%r14), %eax
	cmpl	%eax, -2432(%rbp,%r9,4)
	je	.LBB2_66
.LBB2_65:                               # %if.then441
                                        #   in Loop: Header=BB2_35 Depth=1
	movl	$1007, %edi             # imm = 0x3EF
	callq	BZ2_bz__AssertH__fail
	movq	-96(%rbp), %r9          # 8-byte Reload
	movl	$-2097153, %r10d        # imm = 0xFFDFFFFF
	movq	-48(%rbp), %rsi         # 8-byte Reload
	movq	-56(%rbp), %r11         # 8-byte Reload
.LBB2_66:                               # %for.cond443.preheader
                                        #   in Loop: Header=BB2_35 Depth=1
	xorl	%eax, %eax
	cmpl	$255, %eax
	jg	.LBB2_69
	.p2align	4, 0x90
.LBB2_68:                               # %for.body446
                                        #   Parent Loop BB2_35 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%r12d, %r12
	orb	$32, 2(%r13,%r12,4)
	incl	%eax
	addl	$256, %r12d             # imm = 0x100
	cmpl	$255, %eax
	jle	.LBB2_68
.LBB2_69:                               # %for.end454
                                        #   in Loop: Header=BB2_35 Depth=1
	movb	$1, -384(%rbp,%r9)
	movl	-100(%rbp), %r12d       # 4-byte Reload
	cmpl	$254, %r12d
	jg	.LBB2_79
# BB#70:                                # %if.then459
                                        #   in Loop: Header=BB2_35 Depth=1
	movq	-88(%rbp), %rax         # 8-byte Reload
	movl	(%r13,%rax,4), %r8d
	andl	%r10d, %r8d
	movl	(%r13,%r15,4), %eax
	andl	%r10d, %eax
	movl	%eax, %r9d
	subl	%r8d, %r9d
	xorl	%ecx, %ecx
	jmp	.LBB2_71
	.p2align	4, 0x90
.LBB2_72:                               # %while.body474
                                        #   in Loop: Header=BB2_71 Depth=2
	incl	%ecx
.LBB2_71:                               # %while.cond470
                                        #   Parent Loop BB2_35 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	%r9d, %edx
	sarl	%cl, %edx
	cmpl	$65535, %edx            # imm = 0xFFFF
	jge	.LBB2_72
# BB#73:                                # %while.end476
                                        #   in Loop: Header=BB2_35 Depth=1
	negl	%r8d
	jmp	.LBB2_74
	.p2align	4, 0x90
.LBB2_76:                               # %if.then491
                                        #   in Loop: Header=BB2_74 Depth=2
	addl	%r14d, %edx
	movslq	%edx, %rdx
	movw	%di, (%r11,%rdx,2)
.LBB2_74:                               # %for.cond478
                                        #   Parent Loop BB2_35 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	decl	%eax
	movl	%r8d, %edi
	addl	%eax, %edi
	js	.LBB2_77
# BB#75:                                # %for.body481
                                        #   in Loop: Header=BB2_74 Depth=2
	movslq	%eax, %rdx
	movq	-72(%rbp), %rbx         # 8-byte Reload
	movslq	(%rbx,%rdx,4), %rdx
	sarl	%cl, %edi
	cmpq	$33, %rdx
	movw	%di, (%r11,%rdx,2)
	jg	.LBB2_74
	jmp	.LBB2_76
	.p2align	4, 0x90
.LBB2_77:                               # %for.end498
                                        #   in Loop: Header=BB2_35 Depth=1
	decl	%r9d
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	sarl	%cl, %r9d
	cmpl	$65536, %r9d            # imm = 0x10000
	jl	.LBB2_79
# BB#78:                                # %if.then503
                                        #   in Loop: Header=BB2_35 Depth=1
	movl	$1002, %edi             # imm = 0x3EA
	callq	BZ2_bz__AssertH__fail
	movl	$-2097153, %r10d        # imm = 0xFFDFFFFF
	movq	-48(%rbp), %rsi         # 8-byte Reload
	movq	-56(%rbp), %r11         # 8-byte Reload
	jmp	.LBB2_79
.LBB2_80:                               # %for.end508
	cmpl	$4, -76(%rbp)           # 4-byte Folded Reload
	jl	.LBB2_82
# BB#81:                                # %if.then511
	movq	stderr(%rip), %rdi
	movq	-112(%rbp), %rdx        # 8-byte Reload
	movl	%edx, %r8d
	movq	-64(%rbp), %rcx         # 8-byte Reload
	subl	%ecx, %r8d
	movl	$.L.str.54, %esi
	xorl	%eax, %eax
                                        # kill: %EDX<def> %EDX<kill> %RDX<kill>
                                        # kill: %ECX<def> %ECX<kill> %RCX<kill>
	callq	fprintf
.LBB2_82:                               # %if.end514
	addq	$3416, %rsp             # imm = 0xD58
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end2:
	.size	mainSort, .Lfunc_end2-mainSort
	.cfi_endproc

	.globl	BZ2_bz__AssertH__fail
	.p2align	4, 0x90
	.type	BZ2_bz__AssertH__fail,@function
BZ2_bz__AssertH__fail:                  # @BZ2_bz__AssertH__fail
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi24:
	.cfi_def_cfa_offset 16
.Lcfi25:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi26:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi27:
	.cfi_offset %rbx, -32
.Lcfi28:
	.cfi_offset %r14, -24
	movl	%edi, %ebx
	movq	stderr(%rip), %r14
	callq	BZ2_bzlibVersion
	movq	%rax, %rcx
	movl	$.L.str.6, %esi
	xorl	%eax, %eax
	movq	%r14, %rdi
	movl	%ebx, %edx
	callq	fprintf
	cmpl	$1007, %ebx             # imm = 0x3EF
	jne	.LBB3_2
# BB#1:                                 # %if.then
	movq	stderr(%rip), %rdi
	movl	$.L.str.7, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB3_2:                                # %if.end
	movl	$3, %edi
	callq	exit
.Lfunc_end3:
	.size	BZ2_bz__AssertH__fail, .Lfunc_end3-BZ2_bz__AssertH__fail
	.cfi_endproc

	.globl	BZ2_hbMakeCodeLengths
	.p2align	4, 0x90
	.type	BZ2_hbMakeCodeLengths,@function
BZ2_hbMakeCodeLengths:                  # @BZ2_hbMakeCodeLengths
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi29:
	.cfi_def_cfa_offset 16
.Lcfi30:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi31:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$5176, %rsp             # imm = 0x1438
.Lcfi32:
	.cfi_offset %rbx, -56
.Lcfi33:
	.cfi_offset %r12, -48
.Lcfi34:
	.cfi_offset %r13, -40
.Lcfi35:
	.cfi_offset %r14, -32
.Lcfi36:
	.cfi_offset %r15, -24
	movl	%edx, %r13d
	movq	%rdi, %r15
	xorl	%eax, %eax
	cmpl	%r13d, %eax
	jl	.LBB4_8
	jmp	.LBB4_2
	.p2align	4, 0x90
.LBB4_11:                               # %cond.end
                                        #   in Loop: Header=BB4_8 Depth=1
	shll	$8, %edi
	incq	%rax
	movslq	%eax, %rdx
	movl	%edi, -3152(%rbp,%rdx,4)
	cmpl	%r13d, %eax
	jge	.LBB4_2
.LBB4_8:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$0, (%rsi,%rax,4)
	je	.LBB4_9
# BB#10:                                # %cond.false
                                        #   in Loop: Header=BB4_8 Depth=1
	movl	(%rsi,%rax,4), %edi
	jmp	.LBB4_11
	.p2align	4, 0x90
.LBB4_9:                                #   in Loop: Header=BB4_8 Depth=1
	movl	$1, %edi
	jmp	.LBB4_11
.LBB4_2:
	movl	$-256, %r12d
	movl	%ecx, -44(%rbp)         # 4-byte Spill
	jmp	.LBB4_3
	.p2align	4, 0x90
.LBB4_44:                               # %for.cond228.preheader
                                        #   in Loop: Header=BB4_3 Depth=1
	movl	$1, %eax
	cmpl	%r13d, %eax
	jge	.LBB4_3
	.p2align	4, 0x90
.LBB4_46:                               # %for.body231
                                        #   Parent Loop BB4_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-3152(%rbp,%rax,4), %esi
	movl	%esi, %edx
	sarl	$8, %edx
	shrl	$31, %esi
	addl	%edx, %esi
	andl	$-2, %esi
	shll	$7, %esi
	addl	$256, %esi              # imm = 0x100
	movl	%esi, -3152(%rbp,%rax,4)
	incq	%rax
	cmpl	%r13d, %eax
	jl	.LBB4_46
.LBB4_3:                                # %while.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_5 Depth 2
                                        #       Child Loop BB4_6 Depth 3
                                        #     Child Loop BB4_17 Depth 2
                                        #       Child Loop BB4_18 Depth 3
                                        #       Child Loop BB4_24 Depth 3
                                        #       Child Loop BB4_30 Depth 3
                                        #     Child Loop BB4_37 Depth 2
                                        #       Child Loop BB4_38 Depth 3
                                        #     Child Loop BB4_46 Depth 2
	movl	$0, -1088(%rbp)
	movl	$0, -3152(%rbp)
	movl	$-2, -5216(%rbp)
	xorl	%r14d, %r14d
	movl	$1, %r8d
	cmpl	%r13d, %r8d
	jle	.LBB4_5
	jmp	.LBB4_13
	.p2align	4, 0x90
.LBB4_12:                               # %while.end
                                        #   in Loop: Header=BB4_5 Depth=2
	movslq	%edx, %rax
	movl	%r8d, -1088(%rbp,%rax,4)
	incl	%r8d
	cmpl	%r13d, %r8d
	jg	.LBB4_13
.LBB4_5:                                # %for.body11
                                        #   Parent Loop BB4_3 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB4_6 Depth 3
	movslq	%r8d, %r9
	movl	$-1, -5216(%rbp,%r9,4)
	movslq	%r14d, %rdx
	incl	%r14d
	movl	%r8d, -1084(%rbp,%rdx,4)
	movl	%r14d, %edx
	jmp	.LBB4_6
	.p2align	4, 0x90
.LBB4_7:                                # %while.body27
                                        #   in Loop: Header=BB4_6 Depth=3
	movl	-1088(%rbp,%rdi,4), %eax
	movslq	%edx, %rdx
	movl	%eax, -1088(%rbp,%rdx,4)
	movl	%esi, %edx
.LBB4_6:                                # %while.cond19
                                        #   Parent Loop BB4_3 Depth=1
                                        #     Parent Loop BB4_5 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-3152(%rbp,%r9,4), %eax
	movl	%edx, %esi
	sarl	%esi
	movslq	%esi, %rdi
	movslq	-1088(%rbp,%rdi,4), %rbx
	cmpl	-3152(%rbp,%rbx,4), %eax
	jl	.LBB4_7
	jmp	.LBB4_12
	.p2align	4, 0x90
.LBB4_13:                               # %for.end38
                                        #   in Loop: Header=BB4_3 Depth=1
	cmpl	$260, %r14d             # imm = 0x104
	jl	.LBB4_15
# BB#14:                                # %if.then
                                        #   in Loop: Header=BB4_3 Depth=1
	movl	$2001, %edi             # imm = 0x7D1
	callq	BZ2_bz__AssertH__fail
.LBB4_15:                               # %while.cond40.preheader
                                        #   in Loop: Header=BB4_3 Depth=1
	movl	%r13d, %r9d
	cmpl	$2, %r14d
	jge	.LBB4_17
	jmp	.LBB4_33
	.p2align	4, 0x90
.LBB4_32:                               # %while.end198
                                        #   in Loop: Header=BB4_17 Depth=2
	movslq	%ecx, %rax
	movl	%r9d, -1088(%rbp,%rax,4)
	cmpl	$2, %r14d
	jl	.LBB4_33
.LBB4_17:                               # %while.body42
                                        #   Parent Loop BB4_3 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB4_18 Depth 3
                                        #       Child Loop BB4_24 Depth 3
                                        #       Child Loop BB4_30 Depth 3
	movslq	-1084(%rbp), %r8
	movslq	%r14d, %rax
	movl	-1088(%rbp,%rax,4), %r10d
	movl	%r10d, -1084(%rbp)
	decl	%r14d
	movslq	%r10d, %rsi
	movl	$1, %ecx
	jmp	.LBB4_18
	.p2align	4, 0x90
.LBB4_22:                               # %if.end82
                                        #   in Loop: Header=BB4_18 Depth=3
	movl	-1088(%rbp,%rax,4), %eax
	movslq	%ecx, %rcx
	movl	%eax, -1088(%rbp,%rcx,4)
	movl	%edi, %ecx
.LBB4_18:                               # %while.body55
                                        #   Parent Loop BB4_3 Depth=1
                                        #     Parent Loop BB4_17 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	leal	(%rcx,%rcx), %edi
	cmpl	%r14d, %edi
	jg	.LBB4_23
# BB#19:                                # %if.end59
                                        #   in Loop: Header=BB4_18 Depth=3
	jge	.LBB4_21
# BB#20:                                # %land.lhs.true
                                        #   in Loop: Header=BB4_18 Depth=3
	leal	1(%rdi), %eax
	movslq	%edi, %rbx
	movslq	-1084(%rbp,%rbx,4), %rdx
	movl	-3152(%rbp,%rdx,4), %edx
	movslq	-1088(%rbp,%rbx,4), %rbx
	cmpl	-3152(%rbp,%rbx,4), %edx
	cmovgel	%edi, %eax
	movl	%eax, %edi
.LBB4_21:                               # %if.end73
                                        #   in Loop: Header=BB4_18 Depth=3
	movl	-3152(%rbp,%rsi,4), %edx
	movslq	%edi, %rax
	movslq	-1088(%rbp,%rax,4), %rbx
	cmpl	-3152(%rbp,%rbx,4), %edx
	jge	.LBB4_22
.LBB4_23:                               # %while.end87
                                        #   in Loop: Header=BB4_17 Depth=2
	movslq	%ecx, %rax
	movl	%r10d, -1088(%rbp,%rax,4)
	movslq	-1084(%rbp), %r11
	movslq	%r14d, %rax
	movl	-1088(%rbp,%rax,4), %r10d
	movl	%r10d, -1084(%rbp)
	decl	%r14d
	movslq	%r10d, %rcx
	movl	$1, %eax
	jmp	.LBB4_24
	.p2align	4, 0x90
.LBB4_28:                               # %if.end132
                                        #   in Loop: Header=BB4_24 Depth=3
	movl	-1088(%rbp,%rsi,4), %edx
	cltq
	movl	%edx, -1088(%rbp,%rax,4)
	movl	%edi, %eax
.LBB4_24:                               # %while.body104
                                        #   Parent Loop BB4_3 Depth=1
                                        #     Parent Loop BB4_17 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	leal	(%rax,%rax), %edi
	cmpl	%r14d, %edi
	jg	.LBB4_29
# BB#25:                                # %if.end108
                                        #   in Loop: Header=BB4_24 Depth=3
	jge	.LBB4_27
# BB#26:                                # %land.lhs.true110
                                        #   in Loop: Header=BB4_24 Depth=3
	leal	1(%rdi), %esi
	movslq	%edi, %rbx
	movslq	-1084(%rbp,%rbx,4), %rdx
	movl	-3152(%rbp,%rdx,4), %edx
	movslq	-1088(%rbp,%rbx,4), %rbx
	cmpl	-3152(%rbp,%rbx,4), %edx
	cmovgel	%edi, %esi
	movl	%esi, %edi
.LBB4_27:                               # %if.end123
                                        #   in Loop: Header=BB4_24 Depth=3
	movl	-3152(%rbp,%rcx,4), %edx
	movslq	%edi, %rsi
	movslq	-1088(%rbp,%rsi,4), %rbx
	cmpl	-3152(%rbp,%rbx,4), %edx
	jge	.LBB4_28
.LBB4_29:                               # %while.end137
                                        #   in Loop: Header=BB4_17 Depth=2
	cltq
	movl	%r10d, -1088(%rbp,%rax,4)
	movslq	%r9d, %rax
	incl	%r9d
	movl	%r9d, -5216(%rbp,%r11,4)
	movl	%r9d, -5216(%rbp,%r8,4)
	movl	-3152(%rbp,%r8,4), %ecx
	andl	%r12d, %ecx
	movl	-3152(%rbp,%r11,4), %edx
	andl	%r12d, %edx
	addl	%ecx, %edx
	movzbl	-3152(%rbp,%r8,4), %ecx
	movzbl	-3152(%rbp,%r11,4), %esi
	cmpl	%esi, %ecx
	cmovgl	%r8d, %r11d
	movslq	%r11d, %rcx
	movzbl	-3152(%rbp,%rcx,4), %ecx
	incl	%ecx
	orl	%edx, %ecx
	movl	%ecx, -3148(%rbp,%rax,4)
	movl	$-1, -5212(%rbp,%rax,4)
	incq	%rax
	movslq	%r14d, %rcx
	incl	%r14d
	movl	%r9d, -1084(%rbp,%rcx,4)
	movl	%r14d, %ecx
	jmp	.LBB4_30
	.p2align	4, 0x90
.LBB4_31:                               # %while.body191
                                        #   in Loop: Header=BB4_30 Depth=3
	movl	-1088(%rbp,%rsi,4), %esi
	movslq	%ecx, %rcx
	movl	%esi, -1088(%rbp,%rcx,4)
	movl	%edx, %ecx
.LBB4_30:                               # %while.cond182
                                        #   Parent Loop BB4_3 Depth=1
                                        #     Parent Loop BB4_17 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-3152(%rbp,%rax,4), %edi
	movl	%ecx, %edx
	sarl	%edx
	movslq	%edx, %rsi
	movslq	-1088(%rbp,%rsi,4), %rbx
	cmpl	-3152(%rbp,%rbx,4), %edi
	jl	.LBB4_31
	jmp	.LBB4_32
	.p2align	4, 0x90
.LBB4_33:                               # %while.end201
                                        #   in Loop: Header=BB4_3 Depth=1
	cmpl	$516, %r9d              # imm = 0x204
	jl	.LBB4_35
# BB#34:                                # %if.then203
                                        #   in Loop: Header=BB4_3 Depth=1
	movl	$2002, %edi             # imm = 0x7D2
	callq	BZ2_bz__AssertH__fail
.LBB4_35:                               # %for.cond205.preheader
                                        #   in Loop: Header=BB4_3 Depth=1
	movl	$1, %eax
	xorl	%edi, %edi
	movl	-44(%rbp), %ecx         # 4-byte Reload
	cmpl	%r13d, %eax
	jle	.LBB4_37
	jmp	.LBB4_43
	.p2align	4, 0x90
.LBB4_42:                               # %while.end216
                                        #   in Loop: Header=BB4_37 Depth=2
	incl	%eax
	movb	%dl, %dil
	cmpl	%r13d, %eax
	jg	.LBB4_43
.LBB4_37:                               # %while.cond208.preheader
                                        #   Parent Loop BB4_3 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB4_38 Depth 3
	xorl	%edx, %edx
	movl	%eax, %esi
	jmp	.LBB4_38
	.p2align	4, 0x90
.LBB4_39:                               # %while.body212
                                        #   in Loop: Header=BB4_38 Depth=3
	movl	-5216(%rbp,%rsi,4), %esi
	incl	%edx
.LBB4_38:                               # %while.cond208
                                        #   Parent Loop BB4_3 Depth=1
                                        #     Parent Loop BB4_37 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movslq	%esi, %rsi
	cmpl	$0, -5216(%rbp,%rsi,4)
	jns	.LBB4_39
# BB#40:                                # %while.end216
                                        #   in Loop: Header=BB4_37 Depth=2
	movslq	%eax, %rsi
	movb	%dl, -1(%r15,%rsi)
	cmpl	%ecx, %edx
	movb	$1, %dl
	jg	.LBB4_42
# BB#41:                                # %while.end216
                                        #   in Loop: Header=BB4_37 Depth=2
	movl	%edi, %edx
	jmp	.LBB4_42
	.p2align	4, 0x90
.LBB4_43:                               # %for.end225
                                        #   in Loop: Header=BB4_3 Depth=1
	testb	%dil, %dil
	jne	.LBB4_44
# BB#47:                                # %while.end242
	addq	$5176, %rsp             # imm = 0x1438
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end4:
	.size	BZ2_hbMakeCodeLengths, .Lfunc_end4-BZ2_hbMakeCodeLengths
	.cfi_endproc

	.globl	BZ2_hbAssignCodes
	.p2align	4, 0x90
	.type	BZ2_hbAssignCodes,@function
BZ2_hbAssignCodes:                      # @BZ2_hbAssignCodes
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi37:
	.cfi_def_cfa_offset 16
.Lcfi38:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi39:
	.cfi_def_cfa_register %rbp
	xorl	%r9d, %r9d
	cmpl	%ecx, %edx
	jle	.LBB5_2
	jmp	.LBB5_8
	.p2align	4, 0x90
.LBB5_7:                                # %for.end
                                        #   in Loop: Header=BB5_2 Depth=1
	addl	%r9d, %r9d
	incl	%edx
	cmpl	%ecx, %edx
	jg	.LBB5_8
.LBB5_2:                                # %for.cond1.preheader
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_4 Depth 2
	xorl	%r10d, %r10d
	cmpl	%r8d, %r10d
	jl	.LBB5_4
	jmp	.LBB5_7
	.p2align	4, 0x90
.LBB5_6:                                # %for.inc
                                        #   in Loop: Header=BB5_4 Depth=2
	incq	%r10
	cmpl	%r8d, %r10d
	jge	.LBB5_7
.LBB5_4:                                # %for.body3
                                        #   Parent Loop BB5_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%rsi,%r10), %eax
	cmpl	%edx, %eax
	jne	.LBB5_6
# BB#5:                                 # %if.then
                                        #   in Loop: Header=BB5_4 Depth=2
	movl	%r9d, (%rdi,%r10,4)
	incl	%r9d
	jmp	.LBB5_6
.LBB5_8:                                # %for.end11
	popq	%rbp
	retq
.Lfunc_end5:
	.size	BZ2_hbAssignCodes, .Lfunc_end5-BZ2_hbAssignCodes
	.cfi_endproc

	.globl	BZ2_hbCreateDecodeTables
	.p2align	4, 0x90
	.type	BZ2_hbCreateDecodeTables,@function
BZ2_hbCreateDecodeTables:               # @BZ2_hbCreateDecodeTables
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi40:
	.cfi_def_cfa_offset 16
.Lcfi41:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi42:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi43:
	.cfi_offset %rbx, -32
.Lcfi44:
	.cfi_offset %r14, -24
	xorl	%r14d, %r14d
	movl	16(%rbp), %r10d
	movl	%r8d, %r11d
	cmpl	%r9d, %r11d
	jle	.LBB6_2
	jmp	.LBB6_8
	.p2align	4, 0x90
.LBB6_7:                                # %for.inc9
                                        #   in Loop: Header=BB6_2 Depth=1
	incl	%r11d
	cmpl	%r9d, %r11d
	jg	.LBB6_8
.LBB6_2:                                # %for.cond1.preheader
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB6_4 Depth 2
	xorl	%ebx, %ebx
	cmpl	%r10d, %ebx
	jl	.LBB6_4
	jmp	.LBB6_7
	.p2align	4, 0x90
.LBB6_6:                                # %for.inc
                                        #   in Loop: Header=BB6_4 Depth=2
	incq	%rbx
	cmpl	%r10d, %ebx
	jge	.LBB6_7
.LBB6_4:                                # %for.body3
                                        #   Parent Loop BB6_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%rcx,%rbx), %eax
	cmpl	%r11d, %eax
	jne	.LBB6_6
# BB#5:                                 # %if.then
                                        #   in Loop: Header=BB6_4 Depth=2
	movslq	%r14d, %r14
	movl	%ebx, (%rdx,%r14,4)
	incl	%r14d
	jmp	.LBB6_6
.LBB6_8:                                # %for.cond12.preheader
	xorl	%eax, %eax
	cmpl	$23, %eax
	jge	.LBB6_10
	.p2align	4, 0x90
.LBB6_22:                               # %for.body15
                                        # =>This Inner Loop Header: Depth=1
	movl	$0, (%rsi,%rax,4)
	incq	%rax
	cmpl	$23, %eax
	jl	.LBB6_22
.LBB6_10:                               # %for.cond21.preheader
	xorl	%eax, %eax
	cmpl	%r10d, %eax
	jge	.LBB6_12
	.p2align	4, 0x90
.LBB6_23:                               # %for.body24
                                        # =>This Inner Loop Header: Depth=1
	movzbl	(%rcx,%rax), %edx
	incl	4(%rsi,%rdx,4)
	incq	%rax
	cmpl	%r10d, %eax
	jl	.LBB6_23
.LBB6_12:                               # %for.cond34.preheader
	movl	$1, %eax
	cmpl	$23, %eax
	jge	.LBB6_14
	.p2align	4, 0x90
.LBB6_24:                               # %for.body37
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rsi,%rax,4), %ecx
	addl	%ecx, (%rsi,%rax,4)
	incq	%rax
	cmpl	$23, %eax
	jl	.LBB6_24
.LBB6_14:                               # %for.cond46.preheader
	xorl	%eax, %eax
	cmpl	$23, %eax
	jge	.LBB6_16
	.p2align	4, 0x90
.LBB6_25:                               # %for.body49
                                        # =>This Inner Loop Header: Depth=1
	movl	$0, (%rdi,%rax,4)
	incq	%rax
	cmpl	$23, %eax
	jl	.LBB6_25
.LBB6_16:                               # %for.cond55.preheader
	movslq	%r8d, %rax
	xorl	%r10d, %r10d
	cmpl	%r9d, %eax
	jg	.LBB6_18
	.p2align	4, 0x90
.LBB6_26:                               # %for.body58
                                        # =>This Inner Loop Header: Depth=1
	leaq	1(%rax), %rdx
	movslq	%edx, %rbx
	movl	(%rsi,%rbx,4), %ebx
	subl	(%rsi,%rax,4), %ebx
	leal	-1(%r10,%rbx), %ecx
	leal	(%r10,%rbx), %ebx
	movl	%ecx, (%rdi,%rax,4)
	addl	%ebx, %ebx
	movq	%rdx, %rax
	movl	%ebx, %r10d
	cmpl	%r9d, %eax
	jle	.LBB6_26
.LBB6_18:                               # %for.cond73.preheader
	movslq	%r8d, %rcx
	jmp	.LBB6_19
	.p2align	4, 0x90
.LBB6_20:                               # %for.body76
                                        #   in Loop: Header=BB6_19 Depth=1
	movl	(%rdi,%rcx,4), %ecx
	leal	2(%rcx,%rcx), %ecx
	movslq	%eax, %rdx
	subl	(%rsi,%rdx,4), %ecx
	movl	%ecx, (%rsi,%rdx,4)
	movq	%rax, %rcx
.LBB6_19:                               # %for.cond73
                                        # =>This Inner Loop Header: Depth=1
	leaq	1(%rcx), %rax
	cmpl	%r9d, %eax
	jle	.LBB6_20
# BB#21:                                # %for.end89
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end6:
	.size	BZ2_hbCreateDecodeTables, .Lfunc_end6-BZ2_hbCreateDecodeTables
	.cfi_endproc

	.globl	BZ2_bsInitWrite
	.p2align	4, 0x90
	.type	BZ2_bsInitWrite,@function
BZ2_bsInitWrite:                        # @BZ2_bsInitWrite
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi45:
	.cfi_def_cfa_offset 16
.Lcfi46:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi47:
	.cfi_def_cfa_register %rbp
	movq	$0, 640(%rdi)
	popq	%rbp
	retq
.Lfunc_end7:
	.size	BZ2_bsInitWrite, .Lfunc_end7-BZ2_bsInitWrite
	.cfi_endproc

	.globl	BZ2_compressBlock
	.p2align	4, 0x90
	.type	BZ2_compressBlock,@function
BZ2_compressBlock:                      # @BZ2_compressBlock
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi48:
	.cfi_def_cfa_offset 16
.Lcfi49:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi50:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi51:
	.cfi_offset %rbx, -32
.Lcfi52:
	.cfi_offset %r14, -24
	movl	%esi, %r14d
	movq	%rdi, %rbx
	cmpl	$0, 108(%rbx)
	jle	.LBB8_6
# BB#1:                                 # %if.then
	notl	648(%rbx)
	movl	652(%rbx), %eax
	roll	%eax
	movl	%eax, 652(%rbx)
	xorl	648(%rbx), %eax
	movl	%eax, 652(%rbx)
	cmpl	$2, 660(%rbx)
	jl	.LBB8_3
# BB#2:                                 # %if.then7
	movl	$0, 116(%rbx)
.LBB8_3:                                # %if.end
	cmpl	$2, 656(%rbx)
	jl	.LBB8_5
# BB#4:                                 # %if.then9
	movq	stderr(%rip), %rdi
	movl	660(%rbx), %edx
	movl	648(%rbx), %ecx
	movl	652(%rbx), %r8d
	movl	108(%rbx), %r9d
	movl	$.L.str.2, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB8_5:                                # %if.end14
	movq	%rbx, %rdi
	callq	BZ2_blockSort
.LBB8_6:                                # %if.end15
	movslq	108(%rbx), %rax
	addq	32(%rbx), %rax
	movq	%rax, 80(%rbx)
	cmpl	$1, 660(%rbx)
	jne	.LBB8_8
# BB#7:                                 # %if.then19
	movq	%rbx, %rdi
	callq	BZ2_bsInitWrite
	movl	$66, %esi
	movq	%rbx, %rdi
	callq	bsPutUChar
	movl	$90, %esi
	movq	%rbx, %rdi
	callq	bsPutUChar
	movl	$104, %esi
	movq	%rbx, %rdi
	callq	bsPutUChar
	movl	664(%rbx), %eax
	addl	$48, %eax
	movzbl	%al, %esi
	movq	%rbx, %rdi
	callq	bsPutUChar
.LBB8_8:                                # %if.end20
	cmpl	$0, 108(%rbx)
	jle	.LBB8_10
# BB#9:                                 # %if.then24
	movl	$49, %esi
	movq	%rbx, %rdi
	callq	bsPutUChar
	movl	$65, %esi
	movq	%rbx, %rdi
	callq	bsPutUChar
	movl	$89, %esi
	movq	%rbx, %rdi
	callq	bsPutUChar
	movl	$38, %esi
	movq	%rbx, %rdi
	callq	bsPutUChar
	movl	$83, %esi
	movq	%rbx, %rdi
	callq	bsPutUChar
	movl	$89, %esi
	movq	%rbx, %rdi
	callq	bsPutUChar
	movl	648(%rbx), %esi
	movq	%rbx, %rdi
	callq	bsPutUInt32
	movl	$1, %esi
	xorl	%edx, %edx
	movq	%rbx, %rdi
	callq	bsW
	movl	48(%rbx), %edx
	movl	$24, %esi
	movq	%rbx, %rdi
	callq	bsW
	movq	%rbx, %rdi
	callq	generateMTFValues
	movq	%rbx, %rdi
	callq	sendMTFValues
.LBB8_10:                               # %if.end26
	testb	%r14b, %r14b
	je	.LBB8_14
# BB#11:                                # %if.then27
	movl	$23, %esi
	movq	%rbx, %rdi
	callq	bsPutUChar
	movl	$114, %esi
	movq	%rbx, %rdi
	callq	bsPutUChar
	movl	$69, %esi
	movq	%rbx, %rdi
	callq	bsPutUChar
	movl	$56, %esi
	movq	%rbx, %rdi
	callq	bsPutUChar
	movl	$80, %esi
	movq	%rbx, %rdi
	callq	bsPutUChar
	movl	$144, %esi
	movq	%rbx, %rdi
	callq	bsPutUChar
	movl	652(%rbx), %esi
	movq	%rbx, %rdi
	callq	bsPutUInt32
	cmpl	$2, 656(%rbx)
	jl	.LBB8_13
# BB#12:                                # %if.then32
	movq	stderr(%rip), %rdi
	movl	652(%rbx), %edx
	movl	$.L.str.3, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB8_13:                               # %if.end35
	movq	%rbx, %rdi
	callq	bsFinishWrite
.LBB8_14:                               # %if.end36
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end8:
	.size	BZ2_compressBlock, .Lfunc_end8-BZ2_compressBlock
	.cfi_endproc

	.p2align	4, 0x90
	.type	bsPutUChar,@function
bsPutUChar:                             # @bsPutUChar
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi53:
	.cfi_def_cfa_offset 16
.Lcfi54:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi55:
	.cfi_def_cfa_register %rbp
	movl	%esi, %eax
	movl	$8, %esi
	movl	%eax, %edx
	callq	bsW
	popq	%rbp
	retq
.Lfunc_end9:
	.size	bsPutUChar, .Lfunc_end9-bsPutUChar
	.cfi_endproc

	.p2align	4, 0x90
	.type	bsPutUInt32,@function
bsPutUInt32:                            # @bsPutUInt32
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi56:
	.cfi_def_cfa_offset 16
.Lcfi57:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi58:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi59:
	.cfi_offset %rbx, -32
.Lcfi60:
	.cfi_offset %r14, -24
	movl	%esi, %ebx
	movq	%rdi, %r14
	movl	%ebx, %edx
	shrl	$24, %edx
	movl	$8, %esi
	callq	bsW
	movl	%ebx, %eax
	shrl	$16, %eax
	movzbl	%al, %edx
	movl	$8, %esi
	movq	%r14, %rdi
	callq	bsW
	movzbl	%bh, %edx  # NOREX
	movl	$8, %esi
	movq	%r14, %rdi
	callq	bsW
	movzbl	%bl, %edx
	movl	$8, %esi
	movq	%r14, %rdi
	callq	bsW
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end10:
	.size	bsPutUInt32, .Lfunc_end10-bsPutUInt32
	.cfi_endproc

	.p2align	4, 0x90
	.type	bsW,@function
bsW:                                    # @bsW
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi61:
	.cfi_def_cfa_offset 16
.Lcfi62:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi63:
	.cfi_def_cfa_register %rbp
	cmpl	$8, 644(%rdi)
	jl	.LBB11_3
	.p2align	4, 0x90
.LBB11_2:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movzbl	643(%rdi), %r8d
	movq	80(%rdi), %rcx
	movslq	116(%rdi), %rax
	movb	%r8b, (%rcx,%rax)
	incl	116(%rdi)
	shll	$8, 640(%rdi)
	addl	$-8, 644(%rdi)
	cmpl	$8, 644(%rdi)
	jge	.LBB11_2
.LBB11_3:                               # %while.end
	movl	$32, %ecx
	subl	644(%rdi), %ecx
	subl	%esi, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shll	%cl, %edx
	orl	%edx, 640(%rdi)
	addl	%esi, 644(%rdi)
	popq	%rbp
	retq
.Lfunc_end11:
	.size	bsW, .Lfunc_end11-bsW
	.cfi_endproc

	.p2align	4, 0x90
	.type	generateMTFValues,@function
generateMTFValues:                      # @generateMTFValues
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi64:
	.cfi_def_cfa_offset 16
.Lcfi65:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi66:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$264, %rsp              # imm = 0x108
.Lcfi67:
	.cfi_offset %rbx, -56
.Lcfi68:
	.cfi_offset %r12, -48
.Lcfi69:
	.cfi_offset %r13, -40
.Lcfi70:
	.cfi_offset %r14, -32
.Lcfi71:
	.cfi_offset %r15, -24
	movq	%rdi, %rbx
	movq	56(%rbx), %r15
	movq	64(%rbx), %r12
	movq	72(%rbx), %r14
	callq	makeMaps_e
	movslq	124(%rbx), %rcx
	movq	%rcx, %rax
	movq	%rax, -48(%rbp)         # 8-byte Spill
	leal	1(%rcx), %r11d
	xorl	%eax, %eax
	cmpl	%r11d, %eax
	jg	.LBB12_2
	.p2align	4, 0x90
.LBB12_29:                              # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	$0, 672(%rbx,%rax,4)
	incq	%rax
	cmpl	%r11d, %eax
	jle	.LBB12_29
.LBB12_2:                               # %for.cond4.preheader
	xorl	%eax, %eax
	cmpl	124(%rbx), %eax
	jge	.LBB12_4
	.p2align	4, 0x90
.LBB12_30:                              # %for.body7
                                        # =>This Inner Loop Header: Depth=1
	movb	%al, -304(%rbp,%rax)
	incq	%rax
	cmpl	124(%rbx), %eax
	jl	.LBB12_30
.LBB12_4:                               # %for.cond13.preheader
	xorl	%edx, %edx
	leaq	-303(%rbp), %r10
	xorl	%esi, %esi
	xorl	%r13d, %r13d
	cmpl	108(%rbx), %r13d
	jl	.LBB12_6
	jmp	.LBB12_21
	.p2align	4, 0x90
.LBB12_9:                               # %if.then32
                                        #   in Loop: Header=BB12_6 Depth=1
	incl	%esi
	incl	%r13d
	cmpl	108(%rbx), %r13d
	jge	.LBB12_21
.LBB12_6:                               # %for.body16
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB12_12 Depth 2
                                        #     Child Loop BB12_18 Depth 2
	movslq	%r13d, %rax
	movl	(%r15,%rax,4), %eax
	decl	%eax
	jns	.LBB12_8
# BB#7:                                 # %if.then
                                        #   in Loop: Header=BB12_6 Depth=1
	addl	108(%rbx), %eax
.LBB12_8:                               # %if.end
                                        #   in Loop: Header=BB12_6 Depth=1
	cltq
	movzbl	(%r12,%rax), %eax
	movzbl	384(%rbx,%rax), %edi
	movzbl	-304(%rbp), %eax
	cmpl	%edi, %eax
	je	.LBB12_9
# BB#10:                                # %if.else
                                        #   in Loop: Header=BB12_6 Depth=1
	testl	%esi, %esi
	jle	.LBB12_17
# BB#11:                                # %if.then36
                                        #   in Loop: Header=BB12_6 Depth=1
	decl	%esi
	jmp	.LBB12_12
	.p2align	4, 0x90
.LBB12_31:                              # %if.end55
                                        #   in Loop: Header=BB12_12 Depth=2
	leal	-2(%rsi), %eax
	shrl	$31, %eax
	leal	-2(%rsi,%rax), %esi
	sarl	%esi
.LBB12_12:                              # %while.body
                                        #   Parent Loop BB12_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%edx, %rdx
	testb	$1, %sil
	je	.LBB12_14
# BB#13:                                # %if.then37
                                        #   in Loop: Header=BB12_12 Depth=2
	movw	$1, (%r14,%rdx,2)
	incl	%edx
	incl	676(%rbx)
	cmpl	$2, %esi
	jge	.LBB12_31
	jmp	.LBB12_16
	.p2align	4, 0x90
.LBB12_14:                              # %if.else44
                                        #   in Loop: Header=BB12_12 Depth=2
	movw	$0, (%r14,%rdx,2)
	incl	%edx
	incl	672(%rbx)
	cmpl	$2, %esi
	jge	.LBB12_31
.LBB12_16:                              #   in Loop: Header=BB12_6 Depth=1
	xorl	%esi, %esi
.LBB12_17:                              # %if.end57
                                        #   in Loop: Header=BB12_6 Depth=1
	movb	-304(%rbp), %cl
	movb	-303(%rbp), %r9b
	movb	%cl, -303(%rbp)
	movq	%r10, %rcx
	jmp	.LBB12_18
	.p2align	4, 0x90
.LBB12_19:                              # %while.body66
                                        #   in Loop: Header=BB12_18 Depth=2
	movzbl	1(%rcx), %eax
	movb	%r9b, 1(%rcx)
	incq	%rcx
	movl	%eax, %r9d
.LBB12_18:                              # %while.cond
                                        #   Parent Loop BB12_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	%r9b, %r8d
	cmpl	%r8d, %edi
	jne	.LBB12_19
# BB#20:                                # %while.end67
                                        #   in Loop: Header=BB12_6 Depth=1
	movb	%r9b, -304(%rbp)
	leaq	-304(%rbp), %rax
	subq	%rax, %rcx
	leal	1(%rcx), %eax
	movslq	%edx, %rdx
	movw	%ax, (%r14,%rdx,2)
	incl	%edx
	movslq	%ecx, %rax
	incl	676(%rbx,%rax,4)
	incl	%r13d
	cmpl	108(%rbx), %r13d
	jl	.LBB12_6
.LBB12_21:                              # %for.end84
	testl	%esi, %esi
	jle	.LBB12_28
# BB#22:                                # %if.then87
	decl	%esi
	jmp	.LBB12_23
	.p2align	4, 0x90
.LBB12_27:                              # %if.end111
                                        #   in Loop: Header=BB12_23 Depth=1
	leal	-2(%rsi), %eax
	shrl	$31, %eax
	leal	-2(%rsi,%rax), %esi
	sarl	%esi
.LBB12_23:                              # %while.body90
                                        # =>This Inner Loop Header: Depth=1
	movslq	%edx, %rdx
	testb	$1, %sil
	je	.LBB12_25
# BB#24:                                # %if.then93
                                        #   in Loop: Header=BB12_23 Depth=1
	movw	$1, (%r14,%rdx,2)
	incl	%edx
	incl	676(%rbx)
	cmpl	$2, %esi
	jge	.LBB12_27
	jmp	.LBB12_28
	.p2align	4, 0x90
.LBB12_25:                              # %if.else100
                                        #   in Loop: Header=BB12_23 Depth=1
	movw	$0, (%r14,%rdx,2)
	incl	%edx
	incl	672(%rbx)
	cmpl	$2, %esi
	jge	.LBB12_27
.LBB12_28:                              # %if.end115
	movslq	%edx, %rax
	movw	%r11w, (%r14,%rax,2)
	incl	%eax
	movq	-48(%rbp), %rcx         # 8-byte Reload
	incl	676(%rbx,%rcx,4)
	movl	%eax, 668(%rbx)
	addq	$264, %rsp              # imm = 0x108
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end12:
	.size	generateMTFValues, .Lfunc_end12-generateMTFValues
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI13_0:
	.quad	4636737291354636288     # double 100
	.text
	.p2align	4, 0x90
	.type	sendMTFValues,@function
sendMTFValues:                          # @sendMTFValues
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi72:
	.cfi_def_cfa_offset 16
.Lcfi73:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi74:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$136, %rsp
.Lcfi75:
	.cfi_offset %rbx, -56
.Lcfi76:
	.cfi_offset %r12, -48
.Lcfi77:
	.cfi_offset %r13, -40
.Lcfi78:
	.cfi_offset %r14, -32
.Lcfi79:
	.cfi_offset %r15, -24
	movq	%rdi, %r13
	movq	72(%r13), %r12
	cmpl	$3, 656(%r13)
	jl	.LBB13_2
# BB#1:                                 # %if.then
	movq	stderr(%rip), %rdi
	movl	668(%r13), %ecx
	movl	108(%r13), %edx
	movl	124(%r13), %r8d
	movl	$.L.str.55, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB13_2:                               # %if.end
	movl	124(%r13), %r10d
	addl	$2, %r10d
	leaq	37708(%r13), %rax
	xorl	%ecx, %ecx
	cmpl	$5, %ecx
	jle	.LBB13_4
	jmp	.LBB13_8
	.p2align	4, 0x90
.LBB13_7:                               # %for.inc9
                                        #   in Loop: Header=BB13_4 Depth=1
	incl	%ecx
	addq	$258, %rax              # imm = 0x102
	cmpl	$5, %ecx
	jg	.LBB13_8
.LBB13_4:                               # %for.cond4.preheader
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_6 Depth 2
	xorl	%edx, %edx
	movq	%rax, %rsi
	cmpl	%r10d, %edx
	jge	.LBB13_7
	.p2align	4, 0x90
.LBB13_6:                               # %for.body6
                                        #   Parent Loop BB13_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movb	$15, (%rsi)
	incl	%edx
	incq	%rsi
	cmpl	%r10d, %edx
	jl	.LBB13_6
	jmp	.LBB13_7
.LBB13_8:                               # %for.end11
	cmpl	$0, 668(%r13)
	movq	%r10, -80(%rbp)         # 8-byte Spill
	jg	.LBB13_10
# BB#9:                                 # %if.then14
	movl	$3001, %edi             # imm = 0xBB9
	callq	BZ2_bz__AssertH__fail
	movq	-80(%rbp), %r10         # 8-byte Reload
.LBB13_10:                              # %if.end15
	movl	$2, %r14d
	cmpl	$200, 668(%r13)
	jl	.LBB13_14
# BB#11:                                # %if.else
	movl	$3, %r14d
	cmpl	$600, 668(%r13)         # imm = 0x258
	jl	.LBB13_14
# BB#12:                                # %if.else22
	movl	$4, %r14d
	cmpl	$1200, 668(%r13)        # imm = 0x4B0
	jl	.LBB13_14
# BB#13:                                # %if.else26
	xorl	%r14d, %r14d
	cmpl	$2399, 668(%r13)        # imm = 0x95F
	setg	%r14b
	addl	$5, %r14d
.LBB13_14:                              # %if.end34
	movl	668(%r13), %edi
	leaq	672(%r13), %r8
	movslq	%r14d, %rax
	imulq	$258, %rax, %rax        # imm = 0x102
	leaq	37450(%r13,%rax), %r9
	xorl	%esi, %esi
	leal	-1(%r10), %r11d
	movl	%r14d, %ebx
	movl	%r14d, -60(%rbp)        # 4-byte Spill
	movq	%r8, -120(%rbp)         # 8-byte Spill
	testl	%ebx, %ebx
	jg	.LBB13_25
	jmp	.LBB13_16
	.p2align	4, 0x90
.LBB13_43:                              # %for.end95
                                        #   in Loop: Header=BB13_25 Depth=1
	decl	%ebx
	incl	%r15d
	subl	%r14d, %edi
	addq	$-258, %r9              # imm = 0xFEFE
	movl	%r15d, %esi
	movl	-60(%rbp), %r14d        # 4-byte Reload
	testl	%ebx, %ebx
	jle	.LBB13_16
.LBB13_25:                              # %while.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_26 Depth 2
                                        #     Child Loop BB13_37 Depth 2
	movl	%edi, %eax
	cltd
	movl	%ebx, -44(%rbp)         # 4-byte Spill
	idivl	%ebx
	leal	-1(%rsi), %ecx
	movslq	%ecx, %rcx
	movq	%rsi, %rdx
	leaq	(%r8,%rcx,4), %rsi
	xorl	%r14d, %r14d
	movq	%rdx, %rcx
	movq	%rcx, -56(%rbp)         # 8-byte Spill
	jmp	.LBB13_26
	.p2align	4, 0x90
.LBB13_27:                              # %while.body41
                                        #   in Loop: Header=BB13_26 Depth=2
	movslq	%ecx, %rdx
	addl	672(%r13,%rdx,4), %r14d
	incl	%ecx
	addq	$4, %rsi
.LBB13_26:                              # %while.cond37
                                        #   Parent Loop BB13_25 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leal	-1(%rcx), %r15d
	cmpl	%eax, %r14d
	setl	%bl
	cmpl	%r11d, %r15d
	setl	%dl
	andb	%bl, %dl
	cmpb	$1, %dl
	je	.LBB13_27
# BB#28:                                # %while.end
                                        #   in Loop: Header=BB13_25 Depth=1
	cmpl	-56(%rbp), %r15d        # 4-byte Folded Reload
	movl	-44(%rbp), %ebx         # 4-byte Reload
	jle	.LBB13_33
# BB#29:                                # %while.end
                                        #   in Loop: Header=BB13_25 Depth=1
	cmpl	-60(%rbp), %ebx         # 4-byte Folded Reload
	je	.LBB13_33
# BB#30:                                # %while.end
                                        #   in Loop: Header=BB13_25 Depth=1
	cmpl	$1, %ebx
	je	.LBB13_33
# BB#31:                                # %land.lhs.true50
                                        #   in Loop: Header=BB13_25 Depth=1
	movl	-60(%rbp), %eax         # 4-byte Reload
	subl	%ebx, %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%eax, %edx
	andl	$-2, %edx
	subl	%edx, %eax
	cmpl	$1, %eax
	jne	.LBB13_33
# BB#32:                                # %if.then53
                                        #   in Loop: Header=BB13_25 Depth=1
	subl	(%rsi), %r14d
	addl	$-2, %ecx
	movl	%ecx, %r15d
.LBB13_33:                              # %if.end58
                                        #   in Loop: Header=BB13_25 Depth=1
	cmpl	$3, 656(%r13)
	jl	.LBB13_35
# BB#34:                                # %if.then61
                                        #   in Loop: Header=BB13_25 Depth=1
	movl	%edi, -72(%rbp)         # 4-byte Spill
	movq	stderr(%rip), %rdi
	cvtsi2ssl	%r14d, %xmm0
	cvtss2sd	%xmm0, %xmm0
	mulsd	.LCPI13_0(%rip), %xmm0
	cvtsi2ssl	668(%r13), %xmm1
	cvtss2sd	%xmm1, %xmm1
	divsd	%xmm1, %xmm0
	movl	$.L.str.56, %esi
	movb	$1, %al
	movl	%ebx, %edx
	movq	-56(%rbp), %rcx         # 8-byte Reload
                                        # kill: %ECX<def> %ECX<kill> %RCX<kill>
	movl	%r15d, %r8d
	movq	%r9, -104(%rbp)         # 8-byte Spill
	movl	%r14d, %r9d
	movl	%r11d, %ebx
	callq	fprintf
	movl	%ebx, %r11d
	movl	-44(%rbp), %ebx         # 4-byte Reload
	movq	-104(%rbp), %r9         # 8-byte Reload
	movq	-120(%rbp), %r8         # 8-byte Reload
	movl	-72(%rbp), %edi         # 4-byte Reload
	movq	-80(%rbp), %r10         # 8-byte Reload
.LBB13_35:                              # %for.cond69.preheader
                                        #   in Loop: Header=BB13_25 Depth=1
	xorl	%eax, %eax
	movq	%r9, %rcx
	movq	-56(%rbp), %rsi         # 8-byte Reload
	cmpl	%r10d, %eax
	jl	.LBB13_37
	jmp	.LBB13_43
	.p2align	4, 0x90
.LBB13_42:                              # %for.body72
                                        #   in Loop: Header=BB13_37 Depth=2
	movb	%dl, (%rcx)
	incl	%eax
	incq	%rcx
	cmpl	%r10d, %eax
	jge	.LBB13_43
.LBB13_37:                              # %for.body72
                                        #   Parent Loop BB13_25 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	%r15d, %eax
	jle	.LBB13_38
# BB#39:                                # %for.body72
                                        #   in Loop: Header=BB13_37 Depth=2
	movb	$15, %dl
	cmpl	%esi, %eax
	jge	.LBB13_42
	jmp	.LBB13_41
	.p2align	4, 0x90
.LBB13_38:                              #   in Loop: Header=BB13_37 Depth=2
	xorl	%edx, %edx
	cmpl	%esi, %eax
	jge	.LBB13_42
.LBB13_41:                              # %for.body72
                                        #   in Loop: Header=BB13_37 Depth=2
	movb	$15, %dl
	jmp	.LBB13_42
.LBB13_16:                              # %for.cond100.preheader
	leaq	45448(%r13), %rax
	movq	%rax, -104(%rbp)        # 8-byte Spill
	leaq	51648(%r13), %rax
	movq	%rax, -152(%rbp)        # 8-byte Spill
	leaq	37708(%r13), %r11
                                        # implicit-def: %R15D
	xorl	%edi, %edi
	movq	%r12, -120(%rbp)        # 8-byte Spill
	movq	%r11, -56(%rbp)         # 8-byte Spill
	cmpl	$3, %edi
	jle	.LBB13_18
	jmp	.LBB13_86
	.p2align	4, 0x90
.LBB13_85:                              # %for.inc1702
                                        #   in Loop: Header=BB13_18 Depth=1
	movq	-72(%rbp), %rdi         # 8-byte Reload
	incl	%edi
	movq	-120(%rbp), %r12        # 8-byte Reload
	movl	-44(%rbp), %r15d        # 4-byte Reload
	cmpl	$3, %edi
	jg	.LBB13_86
.LBB13_18:                              # %for.cond104.preheader
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_44 Depth 2
                                        #     Child Loop BB13_22 Depth 2
                                        #       Child Loop BB13_24 Depth 3
                                        #     Child Loop BB13_49 Depth 2
                                        #     Child Loop BB13_52 Depth 2
                                        #       Child Loop BB13_56 Depth 3
                                        #       Child Loop BB13_66 Depth 3
                                        #         Child Loop BB13_69 Depth 4
                                        #       Child Loop BB13_62 Depth 3
                                        #       Child Loop BB13_73 Depth 3
                                        #     Child Loop BB13_79 Depth 2
                                        #     Child Loop BB13_84 Depth 2
	xorl	%eax, %eax
	cmpl	%r14d, %eax
	jge	.LBB13_20
	.p2align	4, 0x90
.LBB13_44:                              # %for.body107
                                        #   Parent Loop BB13_18 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$0, -176(%rbp,%rax,4)
	incq	%rax
	cmpl	%r14d, %eax
	jl	.LBB13_44
.LBB13_20:                              # %for.cond113.preheader
                                        #   in Loop: Header=BB13_18 Depth=1
	xorl	%eax, %eax
	movq	-104(%rbp), %rcx        # 8-byte Reload
	cmpl	%r14d, %eax
	jl	.LBB13_22
	jmp	.LBB13_46
	.p2align	4, 0x90
.LBB13_45:                              # %for.inc128
                                        #   in Loop: Header=BB13_22 Depth=2
	incl	%eax
	addq	$1032, %rcx             # imm = 0x408
	cmpl	%r14d, %eax
	jge	.LBB13_46
.LBB13_22:                              # %for.cond117.preheader
                                        #   Parent Loop BB13_18 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB13_24 Depth 3
	xorl	%edx, %edx
	movq	%rcx, %rsi
	cmpl	%r10d, %edx
	jge	.LBB13_45
	.p2align	4, 0x90
.LBB13_24:                              # %for.body120
                                        #   Parent Loop BB13_18 Depth=1
                                        #     Parent Loop BB13_22 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	$0, (%rsi)
	incl	%edx
	addq	$4, %rsi
	cmpl	%r10d, %edx
	jl	.LBB13_24
	jmp	.LBB13_45
	.p2align	4, 0x90
.LBB13_46:                              # %for.end130
                                        #   in Loop: Header=BB13_18 Depth=1
	cmpl	$6, %r14d
	jne	.LBB13_50
# BB#47:                                # %for.cond134.preheader
                                        #   in Loop: Header=BB13_18 Depth=1
	xorl	%eax, %eax
	movq	-152(%rbp), %rcx        # 8-byte Reload
	cmpl	%r10d, %eax
	jge	.LBB13_50
	.p2align	4, 0x90
.LBB13_49:                              # %for.body137
                                        #   Parent Loop BB13_18 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	37966(%r13,%rax), %edx
	shll	$16, %edx
	movzbl	37708(%r13,%rax), %esi
	orl	%edx, %esi
	movl	%esi, -8(%rcx)
	movzbl	38482(%r13,%rax), %edx
	shll	$16, %edx
	movzbl	38224(%r13,%rax), %esi
	orl	%edx, %esi
	movl	%esi, -4(%rcx)
	movzbl	38998(%r13,%rax), %edx
	shll	$16, %edx
	movzbl	38740(%r13,%rax), %esi
	orl	%edx, %esi
	movl	%esi, (%rcx)
	addq	$16, %rcx
	incq	%rax
	cmpl	%r10d, %eax
	jl	.LBB13_49
.LBB13_50:                              # %while.body188.preheader
                                        #   in Loop: Header=BB13_18 Depth=1
	movq	%rdi, -72(%rbp)         # 8-byte Spill
	xorl	%r15d, %r15d
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	cmpl	668(%r13), %r9d
	jl	.LBB13_52
	jmp	.LBB13_77
	.p2align	4, 0x90
.LBB13_76:                              # %if.end1665
                                        #   in Loop: Header=BB13_52 Depth=2
	addl	%eax, %r8d
	incl	%r15d
	incl	%ecx
	movl	%ecx, %r9d
	cmpl	668(%r13), %r9d
	jge	.LBB13_77
.LBB13_52:                              # %if.end193
                                        #   Parent Loop BB13_18 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB13_56 Depth 3
                                        #       Child Loop BB13_66 Depth 3
                                        #         Child Loop BB13_69 Depth 4
                                        #       Child Loop BB13_62 Depth 3
                                        #       Child Loop BB13_73 Depth 3
	leal	49(%r9), %ecx
	cmpl	668(%r13), %ecx
	jl	.LBB13_54
# BB#53:                                # %if.then199
                                        #   in Loop: Header=BB13_52 Depth=2
	movl	668(%r13), %ecx
	decl	%ecx
.LBB13_54:                              # %if.end202
                                        #   in Loop: Header=BB13_52 Depth=2
	xorl	%eax, %eax
	cmpl	%r14d, %eax
	jge	.LBB13_57
	.p2align	4, 0x90
.LBB13_56:                              # %for.body206
                                        #   Parent Loop BB13_18 Depth=1
                                        #     Parent Loop BB13_52 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movw	$0, -92(%rbp,%rax,2)
	incq	%rax
	cmpl	%r14d, %eax
	jl	.LBB13_56
.LBB13_57:                              # %for.end211
                                        #   in Loop: Header=BB13_52 Depth=2
	cmpl	$6, %r14d
	movl	%r9d, %eax
	jne	.LBB13_66
# BB#58:                                # %land.lhs.true214
                                        #   in Loop: Header=BB13_52 Depth=2
	movl	%ecx, %eax
	subl	%r9d, %eax
	cmpl	$49, %eax
	movl	%r9d, %eax
	jne	.LBB13_66
# BB#59:                                # %if.then219
                                        #   in Loop: Header=BB13_52 Depth=2
	movslq	%r9d, %rax
	movzwl	(%r12,%rax,2), %esi
	shlq	$4, %rsi
	movl	51640(%r13,%rsi), %ebx
	movl	51644(%r13,%rsi), %edi
	movl	51648(%r13,%rsi), %esi
	movzwl	2(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	4(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	6(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	8(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	10(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	12(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	14(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	16(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	18(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	20(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	22(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	24(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	26(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	28(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	30(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	32(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	34(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	36(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	38(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	40(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	42(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	44(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	46(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	48(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	50(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	52(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	54(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	56(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	58(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	60(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	62(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	64(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	66(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	68(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	70(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	72(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	74(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	76(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	78(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	80(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	82(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	84(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	86(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	88(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	90(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	92(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	94(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	96(%r12,%rax,2), %edx
	shlq	$4, %rdx
	addl	51640(%r13,%rdx), %ebx
	addl	51644(%r13,%rdx), %edi
	addl	51648(%r13,%rdx), %esi
	movzwl	98(%r12,%rax,2), %eax
	shlq	$4, %rax
	addl	51640(%r13,%rax), %ebx
	addl	51644(%r13,%rax), %edi
	addl	51648(%r13,%rax), %esi
	movw	%bx, -92(%rbp)
	shrl	$16, %ebx
	movw	%bx, -90(%rbp)
	movw	%di, -88(%rbp)
	shrl	$16, %edi
	movw	%di, -86(%rbp)
	movw	%si, -84(%rbp)
	shrl	$16, %esi
	movw	%si, -82(%rbp)
	jmp	.LBB13_60
	.p2align	4, 0x90
.LBB13_65:                              # %for.inc1162
                                        #   in Loop: Header=BB13_66 Depth=3
	incl	%eax
.LBB13_66:                              # %for.cond1137
                                        #   Parent Loop BB13_18 Depth=1
                                        #     Parent Loop BB13_52 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB13_69 Depth 4
	cmpl	%ecx, %eax
	jg	.LBB13_60
# BB#67:                                # %for.body1140
                                        #   in Loop: Header=BB13_66 Depth=3
	movslq	%eax, %rdx
	movzwl	(%r12,%rdx,2), %esi
	addq	%r11, %rsi
	xorl	%edi, %edi
	cmpl	%r14d, %edi
	jge	.LBB13_65
	.p2align	4, 0x90
.LBB13_69:                              # %for.body1147
                                        #   Parent Loop BB13_18 Depth=1
                                        #     Parent Loop BB13_52 Depth=2
                                        #       Parent Loop BB13_66 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movzbl	(%rsi), %edx
	movzwl	-92(%rbp,%rdi,2), %ebx
	addl	%edx, %ebx
	movw	%bx, -92(%rbp,%rdi,2)
	incq	%rdi
	addq	$258, %rsi              # imm = 0x102
	cmpl	%r14d, %edi
	jl	.LBB13_69
	jmp	.LBB13_65
	.p2align	4, 0x90
.LBB13_60:                              # %for.cond1166.preheader
                                        #   in Loop: Header=BB13_52 Depth=2
	movl	$-1, %edi
	movl	$999999999, %eax        # imm = 0x3B9AC9FF
	xorl	%esi, %esi
	cmpl	%r14d, %esi
	jl	.LBB13_62
	jmp	.LBB13_70
	.p2align	4, 0x90
.LBB13_64:                              # %for.inc1180
                                        #   in Loop: Header=BB13_62 Depth=3
	incq	%rsi
	cmpl	%r14d, %esi
	jge	.LBB13_70
.LBB13_62:                              # %for.body1169
                                        #   Parent Loop BB13_18 Depth=1
                                        #     Parent Loop BB13_52 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movzwl	-92(%rbp,%rsi,2), %edx
	cmpl	%eax, %edx
	jge	.LBB13_64
# BB#63:                                # %if.then1175
                                        #   in Loop: Header=BB13_62 Depth=3
	movzwl	-92(%rbp,%rsi,2), %eax
	movl	%esi, %edi
	jmp	.LBB13_64
	.p2align	4, 0x90
.LBB13_70:                              # %for.end1182
                                        #   in Loop: Header=BB13_52 Depth=2
	movslq	%edi, %rsi
	incl	-176(%rbp,%rsi,4)
	movslq	%r15d, %rdx
	movb	%sil, 1704(%r13,%rdx)
	cmpl	$6, %r14d
	jne	.LBB13_71
# BB#74:                                # %land.lhs.true1193
                                        #   in Loop: Header=BB13_52 Depth=2
	movl	%ecx, %edx
	subl	%r9d, %edx
	cmpl	$49, %edx
	jne	.LBB13_71
# BB#75:                                # %if.then1198
                                        #   in Loop: Header=BB13_52 Depth=2
	imulq	$1032, %rsi, %rsi       # imm = 0x408
	addq	%r13, %rsi
	movslq	%r9d, %rdx
	movzwl	(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	2(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	4(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	6(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	8(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	10(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	12(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	14(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	16(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	18(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	20(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	22(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	24(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	26(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	28(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	30(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	32(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	34(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	36(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	38(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	40(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	42(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	44(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	46(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	48(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	50(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	52(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	54(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	56(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	58(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	60(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	62(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	64(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	66(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	68(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	70(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	72(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	74(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	76(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	78(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	80(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	82(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	84(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	86(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	88(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	90(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	92(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	94(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	96(%r12,%rdx,2), %edi
	incl	45448(%rsi,%rdi,4)
	movzwl	98(%r12,%rdx,2), %edx
	incl	45448(%rsi,%rdx,4)
	jmp	.LBB13_76
	.p2align	4, 0x90
.LBB13_71:                              # %for.cond1650.preheader
                                        #   in Loop: Header=BB13_52 Depth=2
	movslq	%r9d, %rdx
	cmpl	%ecx, %edx
	jg	.LBB13_76
	.p2align	4, 0x90
.LBB13_73:                              # %for.body1653
                                        #   Parent Loop BB13_18 Depth=1
                                        #     Parent Loop BB13_52 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	imulq	$1032, %rsi, %rdi       # imm = 0x408
	addq	%r13, %rdi
	movzwl	(%r12,%rdx,2), %ebx
	incl	45448(%rdi,%rbx,4)
	incq	%rdx
	cmpl	%ecx, %edx
	jle	.LBB13_73
	jmp	.LBB13_76
	.p2align	4, 0x90
.LBB13_77:                              # %while.end1667
                                        #   in Loop: Header=BB13_18 Depth=1
	cmpl	$3, 656(%r13)
	jl	.LBB13_82
# BB#78:                                # %if.then1671
                                        #   in Loop: Header=BB13_18 Depth=1
	movq	stderr(%rip), %rdi
	movq	-72(%rbp), %rax         # 8-byte Reload
	leal	1(%rax), %edx
	movl	%r8d, %ecx
	sarl	$31, %ecx
	shrl	$29, %ecx
	addl	%r8d, %ecx
	sarl	$3, %ecx
	movl	$.L.str.57, %esi
	xorl	%eax, %eax
	callq	fprintf
	xorl	%ebx, %ebx
	jmp	.LBB13_79
	.p2align	4, 0x90
.LBB13_80:                              # %for.body1678
                                        #   in Loop: Header=BB13_79 Depth=2
	movl	-176(%rbp,%rbx,4), %edx
	movl	$.L.str.58, %esi
	xorl	%eax, %eax
	callq	fprintf
	incq	%rbx
.LBB13_79:                              # %for.cond1675
                                        #   Parent Loop BB13_18 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	stderr(%rip), %rdi
	cmpl	%r14d, %ebx
	jl	.LBB13_80
# BB#81:                                # %for.end1684
                                        #   in Loop: Header=BB13_18 Depth=1
	movl	$.L.str.59, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	-80(%rbp), %r10         # 8-byte Reload
	movq	-56(%rbp), %r11         # 8-byte Reload
.LBB13_82:                              # %for.cond1687.preheader
                                        #   in Loop: Header=BB13_18 Depth=1
	movl	%r15d, -44(%rbp)        # 4-byte Spill
	xorl	%r12d, %r12d
	movq	%r11, %r15
	movq	-104(%rbp), %rbx        # 8-byte Reload
	cmpl	%r14d, %r12d
	jge	.LBB13_85
	.p2align	4, 0x90
.LBB13_84:                              # %for.body1690
                                        #   Parent Loop BB13_18 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$20, %ecx
	movq	%r15, %rdi
	movq	%rbx, %rsi
	movl	%r10d, %edx
	callq	BZ2_hbMakeCodeLengths
	movq	-56(%rbp), %r11         # 8-byte Reload
	movq	-80(%rbp), %r10         # 8-byte Reload
	incl	%r12d
	addq	$1032, %rbx             # imm = 0x408
	addq	$258, %r15              # imm = 0x102
	cmpl	%r14d, %r12d
	jl	.LBB13_84
	jmp	.LBB13_85
.LBB13_86:                              # %for.end1704
	cmpl	$8, %r14d
	jl	.LBB13_88
# BB#87:                                # %if.then1707
	movl	$3002, %edi             # imm = 0xBBA
	callq	BZ2_bz__AssertH__fail
.LBB13_88:                              # %if.end1708
	cmpl	$32767, %r15d           # imm = 0x7FFF
	jg	.LBB13_90
# BB#89:                                # %if.end1708
	cmpl	$18003, %r15d           # imm = 0x4653
	jl	.LBB13_91
.LBB13_90:                              # %if.then1714
	movl	$3003, %edi             # imm = 0xBBB
	callq	BZ2_bz__AssertH__fail
.LBB13_91:                              # %for.cond1716.preheader
	xorl	%eax, %eax
	movq	-56(%rbp), %r9          # 8-byte Reload
	cmpl	%r14d, %eax
	jge	.LBB13_93
	.p2align	4, 0x90
.LBB13_177:                             # %for.body1719
                                        # =>This Inner Loop Header: Depth=1
	movb	%al, -110(%rbp,%rax)
	incq	%rax
	cmpl	%r14d, %eax
	jl	.LBB13_177
.LBB13_93:                              # %for.cond1726.preheader
	xorl	%eax, %eax
	cmpl	%r15d, %eax
	jl	.LBB13_104
	jmp	.LBB13_95
	.p2align	4, 0x90
.LBB13_107:                             # %while.end1746
                                        #   in Loop: Header=BB13_104 Depth=1
	movb	%cl, -110(%rbp)
	movb	%dl, 19706(%r13,%r8)
	incl	%eax
	cmpl	%r15d, %eax
	jge	.LBB13_95
.LBB13_104:                             # %for.body1729
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_105 Depth 2
	movslq	%eax, %r8
	movzbl	1704(%r13,%r8), %esi
	xorl	%edx, %edx
	movb	-110(%rbp), %cl
	jmp	.LBB13_105
	.p2align	4, 0x90
.LBB13_106:                             # %while.body1740
                                        #   in Loop: Header=BB13_105 Depth=2
	movslq	%edx, %rdi
	leaq	1(%rdi), %rdx
	movzbl	-109(%rbp,%rdi), %ebx
	movb	%cl, -109(%rbp,%rdi)
	movl	%ebx, %ecx
.LBB13_105:                             # %while.cond1735
                                        #   Parent Loop BB13_104 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	%cl, %edi
	cmpl	%edi, %esi
	jne	.LBB13_106
	jmp	.LBB13_107
.LBB13_95:                              # %for.cond1754.preheader
	xorl	%r12d, %r12d
	movl	%r15d, -44(%rbp)        # 4-byte Spill
	cmpl	%r14d, %r12d
	jl	.LBB13_97
	jmp	.LBB13_113
	.p2align	4, 0x90
.LBB13_112:                             # %if.end1804
                                        #   in Loop: Header=BB13_97 Depth=1
	movl	-72(%rbp), %r12d        # 4-byte Reload
	movslq	%r12d, %rax
	imulq	$1032, %rax, %rcx       # imm = 0x408
	leaq	39256(%r13,%rcx), %rdi
	imulq	$258, %rax, %rax        # imm = 0x102
	leaq	37708(%r13,%rax), %rsi
	movl	%r15d, %edx
	movl	%ebx, %ecx
                                        # kill: %R8D<def> %R8D<kill> %R8<kill>
	callq	BZ2_hbAssignCodes
	incl	%r12d
	movq	-56(%rbp), %r9          # 8-byte Reload
	addq	$258, %r9               # imm = 0x102
	cmpl	%r14d, %r12d
	jge	.LBB13_113
.LBB13_97:                              # %for.cond1758.preheader
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_99 Depth 2
	movl	%r12d, -72(%rbp)        # 4-byte Spill
	movl	$32, %r15d
	xorl	%ebx, %ebx
	movq	%r9, %rax
	xorl	%ecx, %ecx
	movq	-80(%rbp), %r8          # 8-byte Reload
	cmpl	%r8d, %ecx
	jl	.LBB13_99
	jmp	.LBB13_108
	.p2align	4, 0x90
.LBB13_103:                             # %for.inc1794
                                        #   in Loop: Header=BB13_99 Depth=2
	incl	%ecx
	incq	%rax
	cmpl	%r8d, %ecx
	jge	.LBB13_108
.LBB13_99:                              # %for.body1761
                                        #   Parent Loop BB13_97 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%rax), %edx
	cmpl	%ebx, %edx
	jle	.LBB13_101
# BB#100:                               # %if.then1770
                                        #   in Loop: Header=BB13_99 Depth=2
	movzbl	(%rax), %ebx
.LBB13_101:                             # %if.end1777
                                        #   in Loop: Header=BB13_99 Depth=2
	movzbl	(%rax), %edx
	cmpl	%r15d, %edx
	jge	.LBB13_103
# BB#102:                               # %if.then1786
                                        #   in Loop: Header=BB13_99 Depth=2
	movzbl	(%rax), %r15d
	jmp	.LBB13_103
	.p2align	4, 0x90
.LBB13_108:                             # %for.end1796
                                        #   in Loop: Header=BB13_97 Depth=1
	movq	%r9, -56(%rbp)          # 8-byte Spill
	cmpl	$21, %ebx
	jl	.LBB13_110
# BB#109:                               # %if.then1799
                                        #   in Loop: Header=BB13_97 Depth=1
	movl	$3004, %edi             # imm = 0xBBC
	callq	BZ2_bz__AssertH__fail
	movq	-80(%rbp), %r8          # 8-byte Reload
.LBB13_110:                             # %if.end1800
                                        #   in Loop: Header=BB13_97 Depth=1
	testl	%r15d, %r15d
	jg	.LBB13_112
# BB#111:                               # %if.then1803
                                        #   in Loop: Header=BB13_97 Depth=1
	movl	$3005, %edi             # imm = 0xBBD
	callq	BZ2_bz__AssertH__fail
	movq	-80(%rbp), %r8          # 8-byte Reload
	jmp	.LBB13_112
.LBB13_113:                             # %for.cond1816.preheader
	movq	%r13, %rax
	subq	$-128, %rax
	xorl	%ecx, %ecx
	cmpl	$15, %ecx
	jle	.LBB13_115
	jmp	.LBB13_121
	.p2align	4, 0x90
.LBB13_120:                             # %for.inc1837
                                        #   in Loop: Header=BB13_115 Depth=1
	incl	%ecx
	addq	$16, %rax
	cmpl	$15, %ecx
	jg	.LBB13_121
.LBB13_115:                             # %for.body1819
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_117 Depth 2
	movslq	%ecx, %rdx
	movb	$0, -144(%rbp,%rdx)
	xorl	%esi, %esi
	movq	%rax, %rdi
	cmpl	$15, %esi
	jle	.LBB13_117
	jmp	.LBB13_120
	.p2align	4, 0x90
.LBB13_119:                             # %for.inc1834
                                        #   in Loop: Header=BB13_117 Depth=2
	incl	%esi
	incq	%rdi
	cmpl	$15, %esi
	jg	.LBB13_120
.LBB13_117:                             # %for.body1825
                                        #   Parent Loop BB13_115 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpb	$0, (%rdi)
	je	.LBB13_119
# BB#118:                               # %if.then1830
                                        #   in Loop: Header=BB13_117 Depth=2
	movb	$1, -144(%rbp,%rdx)
	jmp	.LBB13_119
.LBB13_121:                             # %for.end1839
	movl	116(%r13), %eax
	movl	%eax, -72(%rbp)         # 4-byte Spill
	xorl	%ebx, %ebx
	cmpl	$16, %ebx
	jl	.LBB13_130
	jmp	.LBB13_123
	.p2align	4, 0x90
.LBB13_132:                             # %for.cond1840
                                        #   in Loop: Header=BB13_130 Depth=1
	movq	%r13, %rdi
	callq	bsW
	incq	%rbx
	cmpl	$16, %ebx
	jge	.LBB13_123
.LBB13_130:                             # %for.body1843
                                        # =>This Inner Loop Header: Depth=1
	cmpb	$0, -144(%rbp,%rbx)
	je	.LBB13_133
# BB#131:                               # %if.then1847
                                        #   in Loop: Header=BB13_130 Depth=1
	movl	$1, %esi
	movl	$1, %edx
	jmp	.LBB13_132
	.p2align	4, 0x90
.LBB13_133:                             # %if.else1848
                                        #   in Loop: Header=BB13_130 Depth=1
	movl	$1, %esi
	xorl	%edx, %edx
	jmp	.LBB13_132
.LBB13_123:                             # %for.cond1853.preheader
	movq	%r13, %rax
	subq	$-128, %rax
	movq	%rax, -56(%rbp)         # 8-byte Spill
	xorl	%r15d, %r15d
	cmpl	$15, %r15d
	jle	.LBB13_125
	jmp	.LBB13_137
	.p2align	4, 0x90
.LBB13_136:                             # %for.inc1878
                                        #   in Loop: Header=BB13_125 Depth=1
	incl	%r15d
	addq	$16, -56(%rbp)          # 8-byte Folded Spill
	cmpl	$15, %r15d
	jg	.LBB13_137
.LBB13_125:                             # %for.body1856
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_128 Depth 2
	movslq	%r15d, %rax
	cmpb	$0, -144(%rbp,%rax)
	je	.LBB13_136
# BB#126:                               # %for.cond1861.preheader
                                        #   in Loop: Header=BB13_125 Depth=1
	xorl	%ebx, %ebx
	movq	-56(%rbp), %r12         # 8-byte Reload
	cmpl	$15, %ebx
	jle	.LBB13_128
	jmp	.LBB13_136
	.p2align	4, 0x90
.LBB13_135:                             # %for.inc1874
                                        #   in Loop: Header=BB13_128 Depth=2
	movq	%r13, %rdi
	callq	bsW
	incl	%ebx
	incq	%r12
	cmpl	$15, %ebx
	jg	.LBB13_136
.LBB13_128:                             # %for.body1864
                                        #   Parent Loop BB13_125 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpb	$0, (%r12)
	je	.LBB13_134
# BB#129:                               # %if.then1871
                                        #   in Loop: Header=BB13_128 Depth=2
	movl	$1, %esi
	movl	$1, %edx
	jmp	.LBB13_135
	.p2align	4, 0x90
.LBB13_134:                             # %if.else1872
                                        #   in Loop: Header=BB13_128 Depth=2
	movl	$1, %esi
	xorl	%edx, %edx
	jmp	.LBB13_135
.LBB13_137:                             # %for.end1880
	cmpl	$3, 656(%r13)
	jl	.LBB13_139
# BB#138:                               # %if.then1884
	movq	stderr(%rip), %rdi
	movl	116(%r13), %edx
	subl	-72(%rbp), %edx         # 4-byte Folded Reload
	movl	$.L.str.60, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB13_139:                             # %if.end1888
	movl	116(%r13), %r15d
	movl	$3, %esi
	movq	%r13, %rdi
	movl	%r14d, %edx
	callq	bsW
	movl	$15, %esi
	movq	%r13, %rdi
	movl	-44(%rbp), %edx         # 4-byte Reload
	callq	bsW
	xorl	%r14d, %r14d
	cmpl	-44(%rbp), %r14d        # 4-byte Folded Reload
	jl	.LBB13_141
	jmp	.LBB13_145
	.p2align	4, 0x90
.LBB13_144:                             # %for.end1904
                                        #   in Loop: Header=BB13_141 Depth=1
	xorl	%edx, %edx
	movq	%r13, %rdi
	callq	bsW
	incl	%r14d
	cmpl	-44(%rbp), %r14d        # 4-byte Folded Reload
	jge	.LBB13_145
.LBB13_141:                             # %for.cond1894.preheader
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_142 Depth 2
	xorl	%ebx, %ebx
	jmp	.LBB13_142
	.p2align	4, 0x90
.LBB13_143:                             # %for.body1901
                                        #   in Loop: Header=BB13_142 Depth=2
	movl	$1, %edx
	movq	%r13, %rdi
	callq	bsW
	incl	%ebx
.LBB13_142:                             # %for.cond1894
                                        #   Parent Loop BB13_141 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%r14d, %rax
	movzbl	19706(%r13,%rax), %eax
	movl	$1, %esi
	cmpl	%eax, %ebx
	jl	.LBB13_143
	jmp	.LBB13_144
.LBB13_145:                             # %for.end1907
	cmpl	$3, 656(%r13)
	jl	.LBB13_147
# BB#146:                               # %if.then1911
	movq	stderr(%rip), %rdi
	movl	116(%r13), %edx
	subl	%r15d, %edx
	movl	$.L.str.61, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB13_147:                             # %if.end1915
	movl	116(%r13), %eax
	movl	%eax, -104(%rbp)        # 4-byte Spill
	xorl	%eax, %eax
	movl	-60(%rbp), %r14d        # 4-byte Reload
	movl	-44(%rbp), %ebx         # 4-byte Reload
	cmpl	%r14d, %eax
	jl	.LBB13_149
	jmp	.LBB13_157
	.p2align	4, 0x90
.LBB13_156:                             # %for.inc1958
                                        #   in Loop: Header=BB13_149 Depth=1
	movl	-72(%rbp), %eax         # 4-byte Reload
	incl	%eax
	cmpl	%r14d, %eax
	jge	.LBB13_157
.LBB13_149:                             # %for.body1920
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_151 Depth 2
                                        #       Child Loop BB13_153 Depth 3
	movl	%eax, -72(%rbp)         # 4-byte Spill
	cltq
	imulq	$258, %rax, %rax        # imm = 0x102
	movq	%rax, -56(%rbp)         # 8-byte Spill
	movzbl	37708(%r13,%rax), %r12d
	movl	$5, %esi
	movq	%r13, %rdi
	movl	%r12d, %edx
	callq	bsW
	xorl	%eax, %eax
	cmpl	-80(%rbp), %eax         # 4-byte Folded Reload
	jl	.LBB13_151
	jmp	.LBB13_156
.LBB13_155:                             # %while.end1954
                                        #   in Loop: Header=BB13_151 Depth=2
	movl	$1, %esi
	xorl	%edx, %edx
	movq	%rbx, %r13
	movq	%r13, %rdi
	callq	bsW
	movl	%r15d, %eax
	incl	%eax
	movl	-60(%rbp), %r14d        # 4-byte Reload
	movl	-44(%rbp), %ebx         # 4-byte Reload
	cmpl	-80(%rbp), %eax         # 4-byte Folded Reload
	jl	.LBB13_151
	jmp	.LBB13_156
	.p2align	4, 0x90
.LBB13_152:                             # %while.body1940
                                        #   in Loop: Header=BB13_151 Depth=2
	movl	$2, %esi
	movl	$2, %edx
	movq	%rbx, %rdi
	callq	bsW
	incl	%r12d
	movq	%rbx, %r13
	movl	%r15d, %eax
.LBB13_151:                             # %while.cond1931
                                        #   Parent Loop BB13_149 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB13_153 Depth 3
	movq	-56(%rbp), %rcx         # 8-byte Reload
	leaq	(%r13,%rcx), %r14
	movq	%r13, %rbx
	movl	%eax, %r15d
	movslq	%eax, %r13
	movzbl	37708(%r13,%r14), %eax
	cmpl	%eax, %r12d
	jl	.LBB13_152
	jmp	.LBB13_153
	.p2align	4, 0x90
.LBB13_154:                             # %while.body1952
                                        #   in Loop: Header=BB13_153 Depth=3
	movl	$2, %esi
	movl	$3, %edx
	movq	%rbx, %rdi
	callq	bsW
	decl	%r12d
.LBB13_153:                             # %while.cond1943
                                        #   Parent Loop BB13_149 Depth=1
                                        #     Parent Loop BB13_151 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movzbl	37708(%r13,%r14), %eax
	cmpl	%eax, %r12d
	jg	.LBB13_154
	jmp	.LBB13_155
.LBB13_157:                             # %for.end1960
	cmpl	$3, 656(%r13)
	jl	.LBB13_159
# BB#158:                               # %if.then1964
	movq	stderr(%rip), %rdi
	movl	116(%r13), %edx
	subl	-104(%rbp), %edx        # 4-byte Folded Reload
	movl	$.L.str.62, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB13_159:                             # %if.end1968
	movl	116(%r13), %eax
	movl	%eax, -72(%rbp)         # 4-byte Spill
	xorl	%eax, %eax
	xorl	%r12d, %r12d
	cmpl	668(%r13), %r12d
	jl	.LBB13_161
	jmp	.LBB13_172
	.p2align	4, 0x90
.LBB13_171:                             # %if.end2448
                                        #   in Loop: Header=BB13_161 Depth=1
	incl	%r12d
	movl	-80(%rbp), %eax         # 4-byte Reload
	incl	%eax
                                        # kill: %R12D<def> %R12D<kill> %R12<def>
	movl	-60(%rbp), %r14d        # 4-byte Reload
	movl	-44(%rbp), %ebx         # 4-byte Reload
	cmpl	668(%r13), %r12d
	jge	.LBB13_172
.LBB13_161:                             # %if.end1976
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_168 Depth 2
	leal	49(%r12), %ecx
	movl	%ecx, -56(%rbp)         # 4-byte Spill
	cmpl	668(%r13), %ecx
	jl	.LBB13_163
# BB#162:                               # %if.then1982
                                        #   in Loop: Header=BB13_161 Depth=1
	movl	668(%r13), %ecx
	decl	%ecx
	movl	%ecx, -56(%rbp)         # 4-byte Spill
.LBB13_163:                             # %if.end1985
                                        #   in Loop: Header=BB13_161 Depth=1
	movl	%eax, -80(%rbp)         # 4-byte Spill
	movslq	%eax, %r15
	movzbl	1704(%r13,%r15), %eax
	cmpl	%r14d, %eax
	jl	.LBB13_165
# BB#164:                               # %if.then1992
                                        #   in Loop: Header=BB13_161 Depth=1
	movl	$3006, %edi             # imm = 0xBBE
	callq	BZ2_bz__AssertH__fail
.LBB13_165:                             # %if.end1993
                                        #   in Loop: Header=BB13_161 Depth=1
	cmpl	$6, %r14d
	jne	.LBB13_166
# BB#169:                               # %land.lhs.true1996
                                        #   in Loop: Header=BB13_161 Depth=1
	movl	-56(%rbp), %eax         # 4-byte Reload
	subl	%r12d, %eax
	cmpl	$49, %eax
	jne	.LBB13_166
# BB#170:                               # %if.then2001
                                        #   in Loop: Header=BB13_161 Depth=1
	movzbl	1704(%r13,%r15), %eax
	imulq	$258, %rax, %r15        # imm = 0x102
	addq	%r13, %r15
	imulq	$1032, %rax, %rbx       # imm = 0x408
	addq	%r13, %rbx
	movslq	%r12d, %r12
	movq	-120(%rbp), %r14        # 8-byte Reload
	movzwl	(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	2(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	4(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	6(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	8(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	10(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	12(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	14(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	16(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	18(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	20(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	22(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	24(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	26(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	28(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	30(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	32(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	34(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	36(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	38(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	40(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	42(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	44(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	46(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	48(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	50(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	52(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	54(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	56(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	58(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	60(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	62(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	64(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	66(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	68(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	70(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	72(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	74(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	76(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	78(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	80(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	82(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	84(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	86(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	88(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	90(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	92(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	94(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	96(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movzwl	98(%r14,%r12,2), %eax
	movzbl	37708(%rax,%r15), %esi
	movl	39256(%rbx,%rax,4), %edx
	movq	%r13, %rdi
	callq	bsW
	movl	-56(%rbp), %r12d        # 4-byte Reload
	jmp	.LBB13_171
	.p2align	4, 0x90
.LBB13_166:                             # %for.cond2420.preheader
                                        #   in Loop: Header=BB13_161 Depth=1
	movslq	%r12d, %rbx
	movq	-120(%rbp), %r14        # 8-byte Reload
	movl	-56(%rbp), %r12d        # 4-byte Reload
	cmpl	%r12d, %ebx
	jg	.LBB13_171
	.p2align	4, 0x90
.LBB13_168:                             # %for.body2423
                                        #   Parent Loop BB13_161 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	1704(%r13,%r15), %eax
	imulq	$258, %rax, %rcx        # imm = 0x102
	addq	%r13, %rcx
	movzwl	(%r14,%rbx,2), %edx
	movzbl	37708(%rdx,%rcx), %esi
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	%r13, %rax
	movl	39256(%rax,%rdx,4), %edx
	movq	%r13, %rdi
	callq	bsW
	incq	%rbx
	cmpl	%r12d, %ebx
	jle	.LBB13_168
	jmp	.LBB13_171
.LBB13_172:                             # %while.end2451
	cmpl	%ebx, %eax
	je	.LBB13_174
# BB#173:                               # %if.then2454
	movl	$3007, %edi             # imm = 0xBBF
	callq	BZ2_bz__AssertH__fail
.LBB13_174:                             # %if.end2455
	cmpl	$3, 656(%r13)
	jl	.LBB13_176
# BB#175:                               # %if.then2459
	movq	stderr(%rip), %rdi
	movl	116(%r13), %edx
	subl	-72(%rbp), %edx         # 4-byte Folded Reload
	movl	$.L.str.63, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB13_176:                             # %if.end2463
	addq	$136, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end13:
	.size	sendMTFValues, .Lfunc_end13-sendMTFValues
	.cfi_endproc

	.p2align	4, 0x90
	.type	bsFinishWrite,@function
bsFinishWrite:                          # @bsFinishWrite
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi80:
	.cfi_def_cfa_offset 16
.Lcfi81:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi82:
	.cfi_def_cfa_register %rbp
	cmpl	$0, 644(%rdi)
	jle	.LBB14_3
	.p2align	4, 0x90
.LBB14_2:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movzbl	643(%rdi), %eax
	movq	80(%rdi), %rcx
	movslq	116(%rdi), %rdx
	movb	%al, (%rcx,%rdx)
	incl	116(%rdi)
	shll	$8, 640(%rdi)
	addl	$-8, 644(%rdi)
	cmpl	$0, 644(%rdi)
	jg	.LBB14_2
.LBB14_3:                               # %while.end
	popq	%rbp
	retq
.Lfunc_end14:
	.size	bsFinishWrite, .Lfunc_end14-bsFinishWrite
	.cfi_endproc

	.globl	BZ2_decompress
	.p2align	4, 0x90
	.type	BZ2_decompress,@function
BZ2_decompress:                         # @BZ2_decompress
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi83:
	.cfi_def_cfa_offset 16
.Lcfi84:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi85:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$168, %rsp
.Lcfi86:
	.cfi_offset %rbx, -56
.Lcfi87:
	.cfi_offset %r12, -48
.Lcfi88:
	.cfi_offset %r13, -40
.Lcfi89:
	.cfi_offset %r14, -32
.Lcfi90:
	.cfi_offset %r15, -24
	movq	%rdi, %r15
	movq	(%r15), %r14
	cmpl	$10, 8(%r15)
	jne	.LBB15_2
# BB#1:                                 # %if.then
	movl	$0, 64036(%r15)
	movl	$0, 64040(%r15)
	movl	$0, 64044(%r15)
	movl	$0, 64048(%r15)
	movl	$0, 64052(%r15)
	movl	$0, 64056(%r15)
	movl	$0, 64060(%r15)
	movl	$0, 64064(%r15)
	movl	$0, 64068(%r15)
	movl	$0, 64072(%r15)
	movl	$0, 64076(%r15)
	movl	$0, 64080(%r15)
	movl	$0, 64084(%r15)
	movl	$0, 64088(%r15)
	movl	$0, 64092(%r15)
	movl	$0, 64096(%r15)
	movl	$0, 64100(%r15)
	movl	$0, 64104(%r15)
	movl	$0, 64108(%r15)
	movl	$0, 64112(%r15)
	movl	$0, 64116(%r15)
	xorps	%xmm0, %xmm0
	movups	%xmm0, 64120(%r15)
	movq	$0, 64136(%r15)
.LBB15_2:                               # %if.end
	movl	64036(%r15), %r12d
	movl	64040(%r15), %eax
	movl	%eax, -92(%rbp)         # 4-byte Spill
	movl	64044(%r15), %eax
	movl	%eax, -124(%rbp)        # 4-byte Spill
	movl	64048(%r15), %eax
	movl	%eax, -156(%rbp)        # 4-byte Spill
	movl	64052(%r15), %r10d
	movl	64056(%r15), %r11d
	movl	64060(%r15), %eax
	movl	%eax, -116(%rbp)        # 4-byte Spill
	movl	64064(%r15), %edi
	movl	64068(%r15), %eax
	movl	%eax, -72(%rbp)         # 4-byte Spill
	movl	64072(%r15), %eax
	movq	%rax, -136(%rbp)        # 8-byte Spill
	movl	64076(%r15), %esi
	movl	64080(%r15), %r9d
	movl	8(%r15), %eax
	addl	$-10, %eax
	cmpl	$40, %eax
	movl	64084(%r15), %ecx
	movq	%rcx, -144(%rbp)        # 8-byte Spill
	movl	64088(%r15), %ecx
	movq	%rcx, -184(%rbp)        # 8-byte Spill
	movl	64092(%r15), %ecx
	movl	%ecx, -120(%rbp)        # 4-byte Spill
	movl	64096(%r15), %r8d
	movl	64100(%r15), %ebx
	movl	64104(%r15), %ecx
	movq	%rcx, -152(%rbp)        # 8-byte Spill
	movl	64108(%r15), %r13d
	movl	64112(%r15), %ecx
	movq	%rcx, -200(%rbp)        # 8-byte Spill
	movl	64116(%r15), %ecx
	movl	%ecx, -76(%rbp)         # 4-byte Spill
	movq	64120(%r15), %rcx
	movq	%rcx, -176(%rbp)        # 8-byte Spill
	movq	64128(%r15), %rcx
	movq	%rcx, -48(%rbp)         # 8-byte Spill
	movq	64136(%r15), %rcx
	movq	%rcx, -168(%rbp)        # 8-byte Spill
	ja	.LBB15_9
# BB#3:                                 # %if.end
	jmpq	*.LJTI15_0(,%rax,8)
.LBB15_4:                               # %sw.bb
	movl	$10, 8(%r15)
	cmpl	$8, 36(%r15)
	jl	.LBB15_7
	jmp	.LBB15_10
.LBB15_5:                               # %if.then53
                                        #   in Loop: Header=BB15_7 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_6:                               # %while.body
                                        #   in Loop: Header=BB15_7 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_10
.LBB15_7:                               # %if.end33
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_31
# BB#8:                                 # %if.end38
                                        #   in Loop: Header=BB15_7 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_6
	jmp	.LBB15_5
.LBB15_9:                               # %sw.default
	movq	%rdi, %rax
	movl	$4001, %edi             # imm = 0xFA1
	movl	%r10d, -104(%rbp)       # 4-byte Spill
	movl	%r11d, -80(%rbp)        # 4-byte Spill
	movl	%r8d, -68(%rbp)         # 4-byte Spill
	movq	%r13, -88(%rbp)         # 8-byte Spill
	movq	%r12, -112(%rbp)        # 8-byte Spill
	movl	%ebx, -56(%rbp)         # 4-byte Spill
	movl	%esi, -52(%rbp)         # 4-byte Spill
	movq	%r9, %r14
	movq	%rax, %r13
	callq	BZ2_bz__AssertH__fail
	movl	$4002, %edi             # imm = 0xFA2
	callq	BZ2_bz__AssertH__fail
	movq	%r13, %rdi
	movq	%r14, %r9
	movl	-52(%rbp), %esi         # 4-byte Reload
	movl	-56(%rbp), %ebx         # 4-byte Reload
	movq	-112(%rbp), %r12        # 8-byte Reload
	movq	-88(%rbp), %r13         # 8-byte Reload
	movl	-68(%rbp), %r8d         # 4-byte Reload
	movl	-80(%rbp), %r11d        # 4-byte Reload
	movl	-104(%rbp), %r10d       # 4-byte Reload
	jmp	.LBB15_31
.LBB15_10:                              # %if.then29
	movl	32(%r15), %edx
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %edx
	movl	%ecx, 36(%r15)
	movl	$-5, %eax
	cmpb	$66, %dl
	je	.LBB15_12
# BB#11:
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_12:                              # %sw.bb62
	movl	$11, 8(%r15)
	cmpl	$8, 36(%r15)
	jl	.LBB15_15
	jmp	.LBB15_17
	.p2align	4, 0x90
.LBB15_13:                              # %if.then107
                                        #   in Loop: Header=BB15_15 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_14:                              # %while.body64
                                        #   in Loop: Header=BB15_15 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_17
.LBB15_15:                              # %if.end78
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_31
# BB#16:                                # %if.end84
                                        #   in Loop: Header=BB15_15 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_14
	jmp	.LBB15_13
.LBB15_17:                              # %if.then68
	movl	32(%r15), %edx
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %edx
	movl	%ecx, 36(%r15)
	movl	$-5, %eax
	cmpb	$90, %dl
	je	.LBB15_19
# BB#18:
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_19:                              # %sw.bb118
	movl	$12, 8(%r15)
	cmpl	$8, 36(%r15)
	jl	.LBB15_22
	jmp	.LBB15_24
	.p2align	4, 0x90
.LBB15_20:                              # %if.then163
                                        #   in Loop: Header=BB15_22 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_21:                              # %while.body120
                                        #   in Loop: Header=BB15_22 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_24
.LBB15_22:                              # %if.end134
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_31
# BB#23:                                # %if.end140
                                        #   in Loop: Header=BB15_22 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_21
	jmp	.LBB15_20
.LBB15_24:                              # %if.then124
	movl	32(%r15), %edx
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %edx
	movl	%ecx, 36(%r15)
	movl	$-5, %eax
	cmpb	$104, %dl
	je	.LBB15_26
# BB#25:
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_26:                              # %sw.bb174
	movl	$13, 8(%r15)
	cmpl	$8, 36(%r15)
	jl	.LBB15_29
	jmp	.LBB15_32
	.p2align	4, 0x90
.LBB15_27:                              # %if.then218
                                        #   in Loop: Header=BB15_29 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_28:                              # %while.body176
                                        #   in Loop: Header=BB15_29 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_32
.LBB15_29:                              # %if.end189
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_31
# BB#30:                                # %if.end195
                                        #   in Loop: Header=BB15_29 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_28
	jmp	.LBB15_27
.LBB15_31:
	xorl	%eax, %eax
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_32:                              # %if.then180
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %eax
	movzbl	%al, %edx
	movl	%ecx, 36(%r15)
	movl	%edx, 40(%r15)
	movl	$-5, %eax
	cmpl	$49, %edx
	jge	.LBB15_34
# BB#33:
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_34:                              # %lor.lhs.false
	cmpl	$57, 40(%r15)
	jle	.LBB15_36
# BB#35:
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_36:                              # %if.end231
	movq	%r12, -112(%rbp)        # 8-byte Spill
	movq	%rdi, %r12
	movq	%r9, -104(%rbp)         # 8-byte Spill
	movl	%ebx, -56(%rbp)         # 4-byte Spill
	movl	%esi, -52(%rbp)         # 4-byte Spill
	movq	%r13, -88(%rbp)         # 8-byte Spill
	movl	%r8d, -68(%rbp)         # 4-byte Spill
	movl	%r11d, -80(%rbp)        # 4-byte Spill
	movl	%r10d, %ebx
	addl	$-48, 40(%r15)
	movq	56(%r14), %rax
	movq	72(%r14), %rdi
	movslq	40(%r15), %rcx
	imulq	$100000, %rcx, %rsi     # imm = 0x186A0
	cmpb	$0, 44(%r15)
	je	.LBB15_40
# BB#37:                                # %if.then234
	addl	%esi, %esi
	movl	$1, %edx
                                        # kill: %ESI<def> %ESI<kill> %RSI<kill>
	callq	*%rax
	movq	%rax, 3160(%r15)
	movq	72(%r14), %rdi
	imull	$100000, 40(%r15), %esi # imm = 0x186A0
	sarl	%esi
	movl	$1, %edx
	callq	*56(%r14)
	movq	%rax, 3168(%r15)
	movl	$-3, %eax
	cmpq	$0, 3160(%r15)
	je	.LBB15_217
# BB#38:                                # %lor.lhs.false252
	cmpq	$0, 3168(%r15)
	movl	%ebx, %r10d
	movl	-80(%rbp), %r11d        # 4-byte Reload
	movl	-68(%rbp), %r8d         # 4-byte Reload
	movq	-88(%rbp), %r13         # 8-byte Reload
	movl	-52(%rbp), %esi         # 4-byte Reload
	movl	-56(%rbp), %ebx         # 4-byte Reload
	movq	-104(%rbp), %r9         # 8-byte Reload
	movq	%r12, %rdi
	movq	-112(%rbp), %r12        # 8-byte Reload
	jne	.LBB15_41
# BB#39:
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_40:                              # %if.else
	shll	$2, %esi
	movl	$1, %edx
                                        # kill: %ESI<def> %ESI<kill> %RSI<kill>
	callq	*%rax
	movq	%rax, 3152(%r15)
	testq	%rax, %rax
	movl	%ebx, %r10d
	movl	-80(%rbp), %r11d        # 4-byte Reload
	movl	-68(%rbp), %r8d         # 4-byte Reload
	movq	-88(%rbp), %r13         # 8-byte Reload
	movl	-52(%rbp), %esi         # 4-byte Reload
	movl	-56(%rbp), %ebx         # 4-byte Reload
	movq	-104(%rbp), %r9         # 8-byte Reload
	movq	%r12, %rdi
	movq	-112(%rbp), %r12        # 8-byte Reload
	je	.LBB15_218
.LBB15_41:                              # %sw.bb272
	movl	$14, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_44
	jmp	.LBB15_46
.LBB15_42:                              # %if.then317
                                        #   in Loop: Header=BB15_44 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_43:                              # %while.body274
                                        #   in Loop: Header=BB15_44 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_46
.LBB15_44:                              # %if.end288
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#45:                                # %if.end294
                                        #   in Loop: Header=BB15_44 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_43
	jmp	.LBB15_42
.LBB15_46:                              # %if.then278
	movl	32(%r15), %edx
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %edx
	movl	%ecx, 36(%r15)
	cmpb	$23, %dl
	jne	.LBB15_116
.LBB15_47:                              # %sw.bb2922
	movl	$42, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_50
	jmp	.LBB15_52
	.p2align	4, 0x90
.LBB15_48:                              # %if.then2969
                                        #   in Loop: Header=BB15_50 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_49:                              # %while.body2925
                                        #   in Loop: Header=BB15_50 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_52
.LBB15_50:                              # %if.end2940
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#51:                                # %if.end2946
                                        #   in Loop: Header=BB15_50 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_49
	jmp	.LBB15_48
.LBB15_52:                              # %if.then2929
	movl	32(%r15), %edx
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %edx
	movl	%ecx, 36(%r15)
	movl	$-4, %eax
	cmpb	$114, %dl
	je	.LBB15_54
# BB#53:
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_54:                              # %sw.bb2980
	movl	$43, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_57
	jmp	.LBB15_59
	.p2align	4, 0x90
.LBB15_55:                              # %if.then3027
                                        #   in Loop: Header=BB15_57 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_56:                              # %while.body2983
                                        #   in Loop: Header=BB15_57 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_59
.LBB15_57:                              # %if.end2998
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#58:                                # %if.end3004
                                        #   in Loop: Header=BB15_57 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_56
	jmp	.LBB15_55
.LBB15_59:                              # %if.then2987
	movl	32(%r15), %edx
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %edx
	movl	%ecx, 36(%r15)
	movl	$-4, %eax
	cmpb	$69, %dl
	je	.LBB15_61
# BB#60:
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_61:                              # %sw.bb3038
	movl	$44, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_64
	jmp	.LBB15_66
	.p2align	4, 0x90
.LBB15_62:                              # %if.then3085
                                        #   in Loop: Header=BB15_64 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_63:                              # %while.body3041
                                        #   in Loop: Header=BB15_64 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_66
.LBB15_64:                              # %if.end3056
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#65:                                # %if.end3062
                                        #   in Loop: Header=BB15_64 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_63
	jmp	.LBB15_62
.LBB15_66:                              # %if.then3045
	movl	32(%r15), %edx
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %edx
	movl	%ecx, 36(%r15)
	movl	$-4, %eax
	cmpb	$56, %dl
	je	.LBB15_68
# BB#67:
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_68:                              # %sw.bb3096
	movl	$45, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_71
	jmp	.LBB15_73
	.p2align	4, 0x90
.LBB15_69:                              # %if.then3143
                                        #   in Loop: Header=BB15_71 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_70:                              # %while.body3099
                                        #   in Loop: Header=BB15_71 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_73
.LBB15_71:                              # %if.end3114
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#72:                                # %if.end3120
                                        #   in Loop: Header=BB15_71 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_70
	jmp	.LBB15_69
.LBB15_73:                              # %if.then3103
	movl	32(%r15), %edx
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %edx
	movl	%ecx, 36(%r15)
	movl	$-4, %eax
	cmpb	$80, %dl
	je	.LBB15_75
# BB#74:
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_75:                              # %sw.bb3154
	movl	$46, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_78
	jmp	.LBB15_80
	.p2align	4, 0x90
.LBB15_76:                              # %if.then3201
                                        #   in Loop: Header=BB15_78 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_77:                              # %while.body3157
                                        #   in Loop: Header=BB15_78 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_80
.LBB15_78:                              # %if.end3172
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#79:                                # %if.end3178
                                        #   in Loop: Header=BB15_78 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_77
	jmp	.LBB15_76
.LBB15_80:                              # %if.then3161
	movl	32(%r15), %edx
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %edx
	movl	%ecx, 36(%r15)
	movl	$-4, %eax
	cmpb	$-112, %dl
	jne	.LBB15_488
# BB#81:                                # %if.end3211
	movl	$0, 3180(%r15)
.LBB15_82:                              # %sw.bb3212
	movl	$47, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_85
	jmp	.LBB15_87
	.p2align	4, 0x90
.LBB15_83:                              # %if.then3259
                                        #   in Loop: Header=BB15_85 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_84:                              # %while.body3215
                                        #   in Loop: Header=BB15_85 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_87
.LBB15_85:                              # %if.end3230
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#86:                                # %if.end3236
                                        #   in Loop: Header=BB15_85 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_84
	jmp	.LBB15_83
.LBB15_87:                              # %if.then3219
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %eax
	movl	%ecx, 36(%r15)
	movl	3180(%r15), %ecx
	shll	$8, %ecx
	movzbl	%al, %eax
	orl	%ecx, %eax
	movl	%eax, 3180(%r15)
.LBB15_88:                              # %sw.bb3270
	movl	$48, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_91
	jmp	.LBB15_93
	.p2align	4, 0x90
.LBB15_89:                              # %if.then3317
                                        #   in Loop: Header=BB15_91 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_90:                              # %while.body3273
                                        #   in Loop: Header=BB15_91 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_93
.LBB15_91:                              # %if.end3288
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#92:                                # %if.end3294
                                        #   in Loop: Header=BB15_91 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_90
	jmp	.LBB15_89
.LBB15_93:                              # %if.then3277
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %eax
	movl	%ecx, 36(%r15)
	movl	3180(%r15), %ecx
	shll	$8, %ecx
	movzbl	%al, %eax
	orl	%ecx, %eax
	movl	%eax, 3180(%r15)
.LBB15_94:                              # %sw.bb3328
	movl	$49, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_97
	jmp	.LBB15_99
	.p2align	4, 0x90
.LBB15_95:                              # %if.then3375
                                        #   in Loop: Header=BB15_97 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_96:                              # %while.body3331
                                        #   in Loop: Header=BB15_97 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_99
.LBB15_97:                              # %if.end3346
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#98:                                # %if.end3352
                                        #   in Loop: Header=BB15_97 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_96
	jmp	.LBB15_95
.LBB15_99:                              # %if.then3335
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %eax
	movl	%ecx, 36(%r15)
	movl	3180(%r15), %ecx
	shll	$8, %ecx
	movzbl	%al, %eax
	orl	%ecx, %eax
	movl	%eax, 3180(%r15)
.LBB15_100:                             # %sw.bb3386
	movl	$50, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_103
	jmp	.LBB15_105
	.p2align	4, 0x90
.LBB15_101:                             # %if.then3433
                                        #   in Loop: Header=BB15_103 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_102:                             # %while.body3389
                                        #   in Loop: Header=BB15_103 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_105
.LBB15_103:                             # %if.end3404
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#104:                               # %if.end3410
                                        #   in Loop: Header=BB15_103 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_102
	jmp	.LBB15_101
.LBB15_105:                             # %if.then3393
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %eax
	movl	%ecx, 36(%r15)
	movl	3180(%r15), %ecx
	shll	$8, %ecx
	movzbl	%al, %eax
	orl	%ecx, %eax
	movl	%eax, 3180(%r15)
	movl	$1, 8(%r15)
	movl	$4, %eax
	jmp	.LBB15_488
.LBB15_116:                             # %if.end327
	movl	$-4, %eax
	cmpb	$49, %dl
	je	.LBB15_118
# BB#117:
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_118:                             # %sw.bb333
	movl	$15, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_121
	jmp	.LBB15_123
	.p2align	4, 0x90
.LBB15_119:                             # %if.then378
                                        #   in Loop: Header=BB15_121 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_120:                             # %while.body335
                                        #   in Loop: Header=BB15_121 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_123
.LBB15_121:                             # %if.end349
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#122:                               # %if.end355
                                        #   in Loop: Header=BB15_121 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_120
	jmp	.LBB15_119
.LBB15_123:                             # %if.then339
	movl	32(%r15), %edx
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %edx
	movl	%ecx, 36(%r15)
	movl	$-4, %eax
	cmpb	$65, %dl
	je	.LBB15_125
# BB#124:
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_125:                             # %sw.bb389
	movl	$16, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_128
	jmp	.LBB15_130
	.p2align	4, 0x90
.LBB15_126:                             # %if.then434
                                        #   in Loop: Header=BB15_128 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_127:                             # %while.body391
                                        #   in Loop: Header=BB15_128 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_130
.LBB15_128:                             # %if.end405
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#129:                               # %if.end411
                                        #   in Loop: Header=BB15_128 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_127
	jmp	.LBB15_126
.LBB15_130:                             # %if.then395
	movl	32(%r15), %edx
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %edx
	movl	%ecx, 36(%r15)
	movl	$-4, %eax
	cmpb	$89, %dl
	je	.LBB15_132
# BB#131:
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_132:                             # %sw.bb445
	movl	$17, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_135
	jmp	.LBB15_137
	.p2align	4, 0x90
.LBB15_133:                             # %if.then490
                                        #   in Loop: Header=BB15_135 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_134:                             # %while.body447
                                        #   in Loop: Header=BB15_135 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_137
.LBB15_135:                             # %if.end461
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#136:                               # %if.end467
                                        #   in Loop: Header=BB15_135 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_134
	jmp	.LBB15_133
.LBB15_137:                             # %if.then451
	movl	32(%r15), %edx
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %edx
	movl	%ecx, 36(%r15)
	movl	$-4, %eax
	cmpb	$38, %dl
	je	.LBB15_139
# BB#138:
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_139:                             # %sw.bb501
	movl	$18, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_142
	jmp	.LBB15_144
	.p2align	4, 0x90
.LBB15_140:                             # %if.then546
                                        #   in Loop: Header=BB15_142 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_141:                             # %while.body503
                                        #   in Loop: Header=BB15_142 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_144
.LBB15_142:                             # %if.end517
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#143:                               # %if.end523
                                        #   in Loop: Header=BB15_142 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_141
	jmp	.LBB15_140
.LBB15_144:                             # %if.then507
	movl	32(%r15), %edx
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %edx
	movl	%ecx, 36(%r15)
	movl	$-4, %eax
	cmpb	$83, %dl
	je	.LBB15_146
# BB#145:
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_146:                             # %sw.bb557
	movl	$19, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_149
	jmp	.LBB15_151
	.p2align	4, 0x90
.LBB15_147:                             # %if.then602
                                        #   in Loop: Header=BB15_149 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_148:                             # %while.body559
                                        #   in Loop: Header=BB15_149 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_151
.LBB15_149:                             # %if.end573
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#150:                               # %if.end579
                                        #   in Loop: Header=BB15_149 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_148
	jmp	.LBB15_147
.LBB15_151:                             # %if.then563
	movl	32(%r15), %edx
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %edx
	movl	%ecx, 36(%r15)
	movl	$-4, %eax
	cmpb	$89, %dl
	jne	.LBB15_488
# BB#152:                               # %if.end612
	incl	48(%r15)
	cmpl	$2, 52(%r15)
	jl	.LBB15_154
# BB#153:                               # %if.then616
	movq	%rdi, %rcx
	movq	stderr(%rip), %rdi
	movl	48(%r15), %edx
	movl	%esi, -52(%rbp)         # 4-byte Spill
	movl	$.L.str.4, %esi
	xorl	%eax, %eax
	movl	%r10d, -104(%rbp)       # 4-byte Spill
	movl	%r11d, -80(%rbp)        # 4-byte Spill
	movl	%ebx, -56(%rbp)         # 4-byte Spill
	movl	%r8d, %ebx
	movq	%r9, %r14
	movq	%rcx, -64(%rbp)         # 8-byte Spill
	movq	%r12, -112(%rbp)        # 8-byte Spill
	callq	fprintf
	movq	-112(%rbp), %r12        # 8-byte Reload
	movq	-64(%rbp), %rdi         # 8-byte Reload
	movq	%r14, %r9
	movl	-52(%rbp), %esi         # 4-byte Reload
	movl	%ebx, %r8d
	movl	-56(%rbp), %ebx         # 4-byte Reload
	movl	-80(%rbp), %r11d        # 4-byte Reload
	movl	-104(%rbp), %r10d       # 4-byte Reload
.LBB15_154:                             # %if.end619
	movl	$0, 3176(%r15)
.LBB15_155:                             # %sw.bb620
	movl	$20, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_158
	jmp	.LBB15_160
	.p2align	4, 0x90
.LBB15_156:                             # %if.then665
                                        #   in Loop: Header=BB15_158 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_157:                             # %while.body622
                                        #   in Loop: Header=BB15_158 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_160
.LBB15_158:                             # %if.end636
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#159:                               # %if.end642
                                        #   in Loop: Header=BB15_158 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_157
	jmp	.LBB15_156
.LBB15_160:                             # %if.then626
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %eax
	movl	%ecx, 36(%r15)
	movl	3176(%r15), %ecx
	shll	$8, %ecx
	movzbl	%al, %eax
	orl	%ecx, %eax
	movl	%eax, 3176(%r15)
.LBB15_161:                             # %sw.bb676
	movl	$21, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_164
	jmp	.LBB15_166
	.p2align	4, 0x90
.LBB15_162:                             # %if.then721
                                        #   in Loop: Header=BB15_164 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_163:                             # %while.body678
                                        #   in Loop: Header=BB15_164 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_166
.LBB15_164:                             # %if.end692
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#165:                               # %if.end698
                                        #   in Loop: Header=BB15_164 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_163
	jmp	.LBB15_162
.LBB15_166:                             # %if.then682
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %eax
	movl	%ecx, 36(%r15)
	movl	3176(%r15), %ecx
	shll	$8, %ecx
	movzbl	%al, %eax
	orl	%ecx, %eax
	movl	%eax, 3176(%r15)
.LBB15_167:                             # %sw.bb732
	movl	$22, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_170
	jmp	.LBB15_172
	.p2align	4, 0x90
.LBB15_168:                             # %if.then777
                                        #   in Loop: Header=BB15_170 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_169:                             # %while.body734
                                        #   in Loop: Header=BB15_170 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_172
.LBB15_170:                             # %if.end748
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#171:                               # %if.end754
                                        #   in Loop: Header=BB15_170 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_169
	jmp	.LBB15_168
.LBB15_172:                             # %if.then738
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %eax
	movl	%ecx, 36(%r15)
	movl	3176(%r15), %ecx
	shll	$8, %ecx
	movzbl	%al, %eax
	orl	%ecx, %eax
	movl	%eax, 3176(%r15)
.LBB15_173:                             # %sw.bb788
	movl	$23, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_176
	jmp	.LBB15_178
	.p2align	4, 0x90
.LBB15_174:                             # %if.then833
                                        #   in Loop: Header=BB15_176 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_175:                             # %while.body790
                                        #   in Loop: Header=BB15_176 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_178
.LBB15_176:                             # %if.end804
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#177:                               # %if.end810
                                        #   in Loop: Header=BB15_176 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_175
	jmp	.LBB15_174
.LBB15_178:                             # %if.then794
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %eax
	movl	%ecx, 36(%r15)
	movl	3176(%r15), %ecx
	shll	$8, %ecx
	movzbl	%al, %eax
	orl	%ecx, %eax
	movl	%eax, 3176(%r15)
.LBB15_179:                             # %sw.bb844
	movl	$24, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$0, 36(%r15)
	jle	.LBB15_182
	jmp	.LBB15_184
	.p2align	4, 0x90
.LBB15_180:                             # %if.then889
                                        #   in Loop: Header=BB15_182 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_181:                             # %while.body846
                                        #   in Loop: Header=BB15_182 Depth=1
	cmpl	$0, 36(%r15)
	jg	.LBB15_184
.LBB15_182:                             # %if.end860
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#183:                               # %if.end866
                                        #   in Loop: Header=BB15_182 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_181
	jmp	.LBB15_180
.LBB15_184:                             # %if.then850
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	decl	%ecx
	shrl	%cl, %eax
	andl	$1, %eax
	movl	%ecx, 36(%r15)
	movb	%al, 20(%r15)
	movl	$0, 56(%r15)
.LBB15_185:                             # %sw.bb895
	movl	$25, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_188
	jmp	.LBB15_190
	.p2align	4, 0x90
.LBB15_186:                             # %if.then940
                                        #   in Loop: Header=BB15_188 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_187:                             # %while.body897
                                        #   in Loop: Header=BB15_188 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_190
.LBB15_188:                             # %if.end911
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#189:                               # %if.end917
                                        #   in Loop: Header=BB15_188 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_187
	jmp	.LBB15_186
.LBB15_190:                             # %if.then901
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %eax
	movl	%ecx, 36(%r15)
	movl	56(%r15), %ecx
	shll	$8, %ecx
	movzbl	%al, %eax
	orl	%ecx, %eax
	movl	%eax, 56(%r15)
.LBB15_191:                             # %sw.bb951
	movl	$26, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_194
	jmp	.LBB15_196
	.p2align	4, 0x90
.LBB15_192:                             # %if.then996
                                        #   in Loop: Header=BB15_194 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_193:                             # %while.body953
                                        #   in Loop: Header=BB15_194 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_196
.LBB15_194:                             # %if.end967
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#195:                               # %if.end973
                                        #   in Loop: Header=BB15_194 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_193
	jmp	.LBB15_192
.LBB15_196:                             # %if.then957
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %eax
	movl	%ecx, 36(%r15)
	movl	56(%r15), %ecx
	shll	$8, %ecx
	movzbl	%al, %eax
	orl	%ecx, %eax
	movl	%eax, 56(%r15)
.LBB15_197:                             # %sw.bb1007
	movl	$27, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$8, 36(%r15)
	jl	.LBB15_200
	jmp	.LBB15_202
	.p2align	4, 0x90
.LBB15_198:                             # %if.then1052
                                        #   in Loop: Header=BB15_200 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_199:                             # %while.body1009
                                        #   in Loop: Header=BB15_200 Depth=1
	cmpl	$8, 36(%r15)
	jge	.LBB15_202
.LBB15_200:                             # %if.end1023
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#201:                               # %if.end1029
                                        #   in Loop: Header=BB15_200 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_199
	jmp	.LBB15_198
.LBB15_202:                             # %if.then1013
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	addl	$-8, %ecx
	shrl	%cl, %eax
	movl	%ecx, 36(%r15)
	movl	56(%r15), %ecx
	shll	$8, %ecx
	movzbl	%al, %edx
	orl	%ecx, %edx
	movl	%edx, 56(%r15)
	movl	$-4, %eax
	testl	%edx, %edx
	js	.LBB15_488
# BB#203:                               # %if.end1067
	imull	$100000, 40(%r15), %edx # imm = 0x186A0
	orl	$10, %edx
	xorl	%ecx, %ecx
	cmpl	%edx, 56(%r15)
	jg	.LBB15_488
	jmp	.LBB15_219
.LBB15_217:
	movl	%ebx, %r10d
	movl	-80(%rbp), %r11d        # 4-byte Reload
	movl	-68(%rbp), %r8d         # 4-byte Reload
	movq	-88(%rbp), %r13         # 8-byte Reload
	movq	-48(%rbp), %r14         # 8-byte Reload
	movl	-52(%rbp), %esi         # 4-byte Reload
	movl	-56(%rbp), %ebx         # 4-byte Reload
	movq	-104(%rbp), %r9         # 8-byte Reload
	movq	%r12, %rdi
	movq	-112(%rbp), %r12        # 8-byte Reload
	jmp	.LBB15_488
.LBB15_218:
	movl	$-3, %eax
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_219:                             # %for.cond
	cmpl	$16, %ecx
	movl	%ecx, %r12d
	jge	.LBB15_226
.LBB15_220:                             # %sw.bb1078
	movl	$28, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$0, 36(%r15)
	jle	.LBB15_223
	jmp	.LBB15_225
	.p2align	4, 0x90
.LBB15_221:                             # %if.then1123
                                        #   in Loop: Header=BB15_223 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_222:                             # %while.body1080
                                        #   in Loop: Header=BB15_223 Depth=1
	cmpl	$0, 36(%r15)
	jg	.LBB15_225
.LBB15_223:                             # %if.end1094
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#224:                               # %if.end1100
                                        #   in Loop: Header=BB15_223 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_222
	jmp	.LBB15_221
.LBB15_225:                             # %if.then1084
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	decl	%ecx
	shrl	%cl, %eax
	movl	%ecx, 36(%r15)
	movslq	%r12d, %rcx
	andb	$1, %al
	movb	%al, 3452(%r15,%rcx)
	incl	%ecx
	jmp	.LBB15_219
.LBB15_226:                             # %for.cond1139.preheader
	xorl	%r12d, %r12d
	xorl	%eax, %eax
	cmpl	$255, %eax
	jg	.LBB15_230
	.p2align	4, 0x90
.LBB15_227:                             # %for.body1142
                                        # =>This Inner Loop Header: Depth=1
	movb	$0, 3196(%r15,%rax)
	incq	%rax
	cmpl	$255, %eax
	jle	.LBB15_227
	jmp	.LBB15_230
.LBB15_229:                             # %for.inc1226
	incl	%r12d
.LBB15_230:                             # %for.cond1148
	cmpl	$15, %r12d
	jg	.LBB15_232
# BB#231:                               # %for.body1151
	movslq	%r12d, %rcx
	xorl	%eax, %eax
	cmpb	$0, 3452(%r15,%rcx)
	jne	.LBB15_273
	jmp	.LBB15_229
.LBB15_232:                             # %for.end1228
	movq	%r12, -112(%rbp)        # 8-byte Spill
	movq	%rdi, -64(%rbp)         # 8-byte Spill
	movq	%r9, -104(%rbp)         # 8-byte Spill
	movl	%ebx, -56(%rbp)         # 4-byte Spill
	movl	%esi, -52(%rbp)         # 4-byte Spill
	movl	%r8d, %r12d
	movl	%r11d, %r14d
	movl	%r10d, %ebx
	movq	%r15, %rdi
	callq	makeMaps_d
	cmpl	$0, 3192(%r15)
	je	.LBB15_269
# BB#233:                               # %if.end1232
	movl	3192(%r15), %eax
	addl	$2, %eax
	movl	%eax, -156(%rbp)        # 4-byte Spill
	movl	%ebx, %r10d
	movl	%r14d, %r11d
	movl	%r12d, %r8d
	movl	-52(%rbp), %esi         # 4-byte Reload
	movl	-56(%rbp), %ebx         # 4-byte Reload
	movq	-104(%rbp), %r9         # 8-byte Reload
	movq	-64(%rbp), %rdi         # 8-byte Reload
	movq	-112(%rbp), %r12        # 8-byte Reload
.LBB15_234:                             # %sw.bb1235
	movl	$30, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$3, 36(%r15)
	jl	.LBB15_237
	jmp	.LBB15_239
	.p2align	4, 0x90
.LBB15_235:                             # %if.then1279
                                        #   in Loop: Header=BB15_237 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_236:                             # %while.body1237
                                        #   in Loop: Header=BB15_237 Depth=1
	cmpl	$3, 36(%r15)
	jge	.LBB15_239
.LBB15_237:                             # %if.end1250
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#238:                               # %if.end1256
                                        #   in Loop: Header=BB15_237 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_236
	jmp	.LBB15_235
.LBB15_239:                             # %if.then1241
	movl	32(%r15), %r10d
	movl	36(%r15), %ecx
	addl	$-3, %ecx
	shrl	%cl, %r10d
	andl	$7, %r10d
	movl	%ecx, 36(%r15)
	cmpl	$2, %r10d
	movl	$-4, %eax
	jl	.LBB15_488
# BB#240:                               # %if.then1241
	cmpl	$6, %r10d
	jg	.LBB15_271
.LBB15_241:                             # %sw.bb1292
	movl	$31, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$15, 36(%r15)
	jl	.LBB15_244
	jmp	.LBB15_247
	.p2align	4, 0x90
.LBB15_242:                             # %if.then1336
                                        #   in Loop: Header=BB15_244 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_243:                             # %while.body1294
                                        #   in Loop: Header=BB15_244 Depth=1
	cmpl	$15, 36(%r15)
	jge	.LBB15_247
.LBB15_244:                             # %if.end1307
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#245:                               # %if.end1313
                                        #   in Loop: Header=BB15_244 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_243
	jmp	.LBB15_242
.LBB15_247:                             # %if.then1298
	movl	32(%r15), %r11d
	movl	36(%r15), %ecx
	addl	$-15, %ecx
	shrl	%cl, %r11d
	andl	$32767, %r11d           # imm = 0x7FFF
	movl	%ecx, 36(%r15)
	xorl	%eax, %eax
	testl	%r11d, %r11d
	jle	.LBB15_270
.LBB15_248:                             # %for.cond1346
	cmpl	%r11d, %eax
	movl	%r8d, -68(%rbp)         # 4-byte Spill
	movq	%r13, -88(%rbp)         # 8-byte Spill
	jge	.LBB15_260
# BB#249:
	movl	$0, -92(%rbp)           # 4-byte Folded Spill
	movl	%eax, %r12d
.LBB15_250:                             # %sw.bb1351
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB15_253 Depth 2
	movl	$32, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$0, 36(%r15)
	jle	.LBB15_253
	jmp	.LBB15_255
	.p2align	4, 0x90
.LBB15_251:                             # %if.then1397
                                        #   in Loop: Header=BB15_253 Depth=2
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_252:                             # %while.body1354
                                        #   in Loop: Header=BB15_253 Depth=2
	cmpl	$0, 36(%r15)
	jg	.LBB15_255
.LBB15_253:                             # %if.end1368
                                        #   Parent Loop BB15_250 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#254:                               # %if.end1374
                                        #   in Loop: Header=BB15_253 Depth=2
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_252
	jmp	.LBB15_251
.LBB15_255:                             # %if.then1358
                                        #   in Loop: Header=BB15_250 Depth=1
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	decl	%ecx
	shrl	%cl, %eax
	movl	%ecx, 36(%r15)
	andb	$1, %al
	je	.LBB15_272
# BB#256:                               # %if.end1407
                                        #   in Loop: Header=BB15_250 Depth=1
	movl	-92(%rbp), %ecx         # 4-byte Reload
	incl	%ecx
	movl	$-4, %eax
	movl	%ecx, -92(%rbp)         # 4-byte Spill
	cmpl	%r10d, %ecx
	jl	.LBB15_250
# BB#257:
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_260:                             # %for.cond1422.preheader
	xorl	%eax, %eax
	movl	-76(%rbp), %ecx         # 4-byte Reload
	jmp	.LBB15_262
	.p2align	4, 0x90
.LBB15_261:                             # %for.body1426
                                        #   in Loop: Header=BB15_262 Depth=1
	movb	%al, -190(%rbp,%rax)
	incb	%al
.LBB15_262:                             # %for.cond1422
                                        # =>This Inner Loop Header: Depth=1
	movzbl	%al, %eax
	cmpl	%r10d, %eax
	jl	.LBB15_261
# BB#263:                               # %for.cond1432.preheader
	xorl	%eax, %eax
	xorl	%r12d, %r12d
	cmpl	%r11d, %r12d
	jge	.LBB15_268
	.p2align	4, 0x90
.LBB15_265:                             # %for.body1435
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB15_267 Depth 2
	movq	%rdi, %r13
	movq	%r12, %rax
	movq	%r9, %r12
	movl	%ebx, %r9d
	movl	%esi, %r14d
	movl	%ecx, %edi
	movq	%rax, %rsi
	cltq
	movzbl	25886(%r15,%rax), %ecx
	movb	-190(%rbp,%rcx), %dl
	jmp	.LBB15_267
	.p2align	4, 0x90
.LBB15_266:                             # %while.body1444
                                        #   in Loop: Header=BB15_267 Depth=2
	movzbl	-191(%rbp,%rcx), %ebx
	movb	%bl, -190(%rbp,%rcx)
	decb	%cl
.LBB15_267:                             # %while.cond
                                        #   Parent Loop BB15_265 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	%cl, %ecx
	testl	%ecx, %ecx
	jg	.LBB15_266
# BB#264:                               # %while.end1452
                                        #   in Loop: Header=BB15_265 Depth=1
	movb	%dl, -190(%rbp)
	movb	%dl, 7884(%r15,%rax)
	movq	%rsi, %rax
	incl	%eax
	movl	%edi, %ecx
	xorl	%edx, %edx
	movl	%r14d, %esi
	movl	%r9d, %ebx
	movq	%r12, %r9
	movq	%rax, %r12
	movq	%r13, %rdi
	cmpl	%r11d, %r12d
	jl	.LBB15_265
.LBB15_268:
	movl	-68(%rbp), %r8d         # 4-byte Reload
	movq	-88(%rbp), %r13         # 8-byte Reload
	xorl	%eax, %eax
	cmpl	%r10d, %eax
	jge	.LBB15_311
	jmp	.LBB15_284
.LBB15_269:
	movl	$-4, %eax
	movl	%ebx, %r10d
	movl	%r14d, %r11d
	movl	%r12d, %r8d
	jmp	.LBB15_283
.LBB15_270:
	movl	$-4, %eax
	jmp	.LBB15_488
.LBB15_271:
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_272:                             # %while.end1413
	movslq	%r12d, %rax
	movl	-92(%rbp), %ecx         # 4-byte Reload
	movb	%cl, 25886(%r15,%rax)
	incl	%eax
	jmp	.LBB15_248
.LBB15_273:                             # %for.cond1157
	cmpl	$15, %eax
	movl	%eax, -92(%rbp)         # 4-byte Spill
	jg	.LBB15_229
.LBB15_274:                             # %sw.bb1161
	movl	$29, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$0, 36(%r15)
	jle	.LBB15_277
	jmp	.LBB15_279
	.p2align	4, 0x90
.LBB15_275:                             # %if.then1206
                                        #   in Loop: Header=BB15_277 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_276:                             # %while.body1163
                                        #   in Loop: Header=BB15_277 Depth=1
	cmpl	$0, 36(%r15)
	jg	.LBB15_279
.LBB15_277:                             # %if.end1177
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#278:                               # %if.end1183
                                        #   in Loop: Header=BB15_277 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_276
	jmp	.LBB15_275
.LBB15_279:                             # %if.then1167
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	decl	%ecx
	movl	%ecx, 36(%r15)
	btl	%ecx, %eax
	movl	-92(%rbp), %ecx         # 4-byte Reload
	jae	.LBB15_281
# BB#280:                               # %if.then1215
	movl	%r12d, %eax
	shll	$4, %eax
	addl	%ecx, %eax
	cltq
	movb	$1, 3196(%r15,%rax)
.LBB15_281:                             # %for.inc1222
	incl	%ecx
	movl	%ecx, %eax
	jmp	.LBB15_273
.LBB15_284:
	movl	%eax, -124(%rbp)        # 4-byte Spill
.LBB15_285:                             # %sw.bb1463
	movl	$33, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$5, 36(%r15)
	jl	.LBB15_288
	jmp	.LBB15_290
	.p2align	4, 0x90
.LBB15_286:                             # %if.then1509
                                        #   in Loop: Header=BB15_288 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_287:                             # %while.body1466
                                        #   in Loop: Header=BB15_288 Depth=1
	cmpl	$5, 36(%r15)
	jge	.LBB15_290
.LBB15_288:                             # %if.end1480
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#289:                               # %if.end1486
                                        #   in Loop: Header=BB15_288 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_287
	jmp	.LBB15_286
.LBB15_290:                             # %if.then1470
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	addl	$-5, %ecx
	shrl	%cl, %eax
	andl	$31, %eax
	movl	%eax, -120(%rbp)        # 4-byte Spill
	movl	%ecx, 36(%r15)
	xorl	%r12d, %r12d
	cmpl	-156(%rbp), %r12d       # 4-byte Folded Reload
	jge	.LBB15_310
.LBB15_292:                             # %while.body1520
	cmpl	$0, -120(%rbp)          # 4-byte Folded Reload
	movl	$-4, %eax
	jle	.LBB15_488
# BB#293:                               # %while.body1520
	cmpl	$20, -120(%rbp)         # 4-byte Folded Reload
	jg	.LBB15_308
.LBB15_294:                             # %sw.bb1528
	movl	$34, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$0, 36(%r15)
	jle	.LBB15_297
	jmp	.LBB15_299
	.p2align	4, 0x90
.LBB15_295:                             # %if.then1575
                                        #   in Loop: Header=BB15_297 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_296:                             # %while.body1531
                                        #   in Loop: Header=BB15_297 Depth=1
	cmpl	$0, 36(%r15)
	jg	.LBB15_299
.LBB15_297:                             # %if.end1546
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#298:                               # %if.end1552
                                        #   in Loop: Header=BB15_297 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_296
	jmp	.LBB15_295
.LBB15_299:                             # %if.then1535
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	decl	%ecx
	shrl	%cl, %eax
	movl	%ecx, 36(%r15)
	andb	$1, %al
	je	.LBB15_309
.LBB15_300:                             # %sw.bb1586
	movl	$35, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$0, 36(%r15)
	jle	.LBB15_303
	jmp	.LBB15_305
	.p2align	4, 0x90
.LBB15_301:                             # %if.then1633
                                        #   in Loop: Header=BB15_303 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_302:                             # %while.body1589
                                        #   in Loop: Header=BB15_303 Depth=1
	cmpl	$0, 36(%r15)
	jg	.LBB15_305
.LBB15_303:                             # %if.end1604
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#304:                               # %if.end1610
                                        #   in Loop: Header=BB15_303 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_302
	jmp	.LBB15_301
.LBB15_305:                             # %if.then1593
	movl	32(%r15), %eax
	movl	36(%r15), %ecx
	decl	%ecx
	shrl	%cl, %eax
	movl	%ecx, 36(%r15)
	andb	$1, %al
	cmpb	$1, %al
	sbbl	%eax, %eax
	notl	%eax
	orl	$1, %eax
	addl	%eax, -120(%rbp)        # 4-byte Folded Spill
	jmp	.LBB15_292
.LBB15_308:
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_309:                             # %while.end1647
	movslq	-124(%rbp), %rax        # 4-byte Folded Reload
	imulq	$258, %rax, %rax        # imm = 0x102
	addq	%r15, %rax
	movslq	%r12d, %r12
	movl	-120(%rbp), %ecx        # 4-byte Reload
	movb	%cl, 43888(%r12,%rax)
	incl	%r12d
	cmpl	-156(%rbp), %r12d       # 4-byte Folded Reload
	jl	.LBB15_292
.LBB15_310:                             # %for.inc1656
	movl	-124(%rbp), %eax        # 4-byte Reload
	incl	%eax
	cmpl	%r10d, %eax
	jl	.LBB15_284
.LBB15_311:                             # %for.cond1659.preheader
	movl	%r11d, -80(%rbp)        # 4-byte Spill
	leaq	43888(%r15), %rdx
	xorl	%edi, %edi
	movl	%r8d, -68(%rbp)         # 4-byte Spill
	movq	%r13, -88(%rbp)         # 8-byte Spill
	movl	%ebx, -56(%rbp)         # 4-byte Spill
	jmp	.LBB15_313
	.p2align	4, 0x90
.LBB15_312:                             # %for.end1701
                                        #   in Loop: Header=BB15_313 Depth=1
	movslq	%edi, %r13
	imulq	$1032, %r13, %rax       # imm = 0x408
	leaq	45436(%r15,%rax), %rdi
	leaq	51628(%r15,%rax), %rsi
	leaq	57820(%r15,%rax), %rdx
	imulq	$258, %r13, %rax        # imm = 0x102
	leaq	43888(%r15,%rax), %rcx
	movl	%r8d, (%rsp)
	movl	%ebx, %r8d
	movl	%r10d, %r12d
	callq	BZ2_hbCreateDecodeTables
	movl	-124(%rbp), %edi        # 4-byte Reload
	movl	%r12d, %r10d
	movl	%ebx, 64012(%r15,%r13,4)
	incl	%edi
	movq	%r14, %rdx
	addq	$258, %rdx              # imm = 0x102
	movl	-68(%rbp), %r8d         # 4-byte Reload
.LBB15_313:                             # %for.cond1659
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB15_316 Depth 2
	cmpl	%r10d, %edi
	movl	%edi, -124(%rbp)        # 4-byte Spill
	jge	.LBB15_320
# BB#314:                               # %for.cond1663.preheader
                                        #   in Loop: Header=BB15_313 Depth=1
	movl	$32, %ebx
	xorl	%eax, %eax
	movq	%rdx, %r14
	movq	%rdx, %rcx
	xorl	%r9d, %r9d
	movl	-156(%rbp), %r8d        # 4-byte Reload
	cmpl	%r8d, %eax
	jge	.LBB15_312
	.p2align	4, 0x90
.LBB15_316:                             # %for.body1666
                                        #   Parent Loop BB15_313 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%rcx), %edx
	cmpl	%r9d, %edx
	jle	.LBB15_318
# BB#317:                               # %if.then1675
                                        #   in Loop: Header=BB15_316 Depth=2
	movzbl	(%rcx), %r9d
.LBB15_318:                             # %if.end1682
                                        #   in Loop: Header=BB15_316 Depth=2
	movzbl	(%rcx), %edx
	cmpl	%ebx, %edx
	jge	.LBB15_315
# BB#319:                               # %if.then1691
                                        #   in Loop: Header=BB15_316 Depth=2
	movzbl	(%rcx), %ebx
.LBB15_315:                             # %for.inc1699
                                        #   in Loop: Header=BB15_316 Depth=2
	incl	%eax
	incq	%rcx
	cmpl	%r8d, %eax
	jl	.LBB15_316
	jmp	.LBB15_312
.LBB15_320:                             # %for.end1719
	movl	3192(%r15), %eax
	incl	%eax
	movl	%eax, -116(%rbp)        # 4-byte Spill
	imull	$100000, 40(%r15), %eax # imm = 0x186A0
	xorl	%r12d, %r12d
	movl	-80(%rbp), %r11d        # 4-byte Reload
	cmpl	$256, %r12d             # imm = 0x100
	jge	.LBB15_322
	.p2align	4, 0x90
.LBB15_321:                             # %for.body1727
                                        # =>This Inner Loop Header: Depth=1
	movl	$0, 68(%r15,%r12,4)
	incq	%r12
	cmpl	$256, %r12d             # imm = 0x100
	jl	.LBB15_321
.LBB15_322:                             # %for.cond1736.preheader
	movl	%eax, -52(%rbp)         # 4-byte Spill
	movl	%r8d, %r14d
	leaq	3724(%r15), %r8
	movl	$4095, %esi             # imm = 0xFFF
	movl	$15, %ecx
	movb	$-1, %r9b
	testl	%ecx, %ecx
	js	.LBB15_327
	.p2align	4, 0x90
.LBB15_324:                             # %for.cond1740.preheader
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB15_326 Depth 2
	movslq	%esi, %rbx
	addq	%r8, %rbx
	xorl	%edi, %edi
	movl	%r9d, %edx
	jmp	.LBB15_326
	.p2align	4, 0x90
.LBB15_325:                             # %for.body1743
                                        #   in Loop: Header=BB15_326 Depth=2
	movb	%dl, (%rbx,%rdi)
	decb	%dl
	decq	%rdi
.LBB15_326:                             # %for.cond1740
                                        #   Parent Loop BB15_324 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	%edi, %eax
	addl	$15, %eax
	jns	.LBB15_325
# BB#323:                               # %for.end1752
                                        #   in Loop: Header=BB15_324 Depth=1
	leal	1(%rsi,%rdi), %eax
	leal	(%rsi,%rdi), %edx
	movslq	%ecx, %rsi
	movl	%eax, 7820(%r15,%rsi,4)
	decl	%ecx
	addb	$-16, %r9b
	movl	%edx, %esi
	testl	%ecx, %ecx
	jns	.LBB15_324
.LBB15_327:                             # %if.then1761
	testl	%r11d, %r11d
	jg	.LBB15_329
# BB#328:                               # %if.then1761.save_state_and_return_crit_edge
	movl	$-4, %eax
	xorl	%r9d, %r9d
	movl	$0, -72(%rbp)           # 4-byte Folded Spill
	xorl	%edi, %edi
	movl	%r14d, %r8d
	movq	-88(%rbp), %r13         # 8-byte Reload
	movq	-48(%rbp), %r14         # 8-byte Reload
	movl	-52(%rbp), %esi         # 4-byte Reload
	movl	-56(%rbp), %ebx         # 4-byte Reload
	jmp	.LBB15_488
.LBB15_329:                             # %if.end1766
	movzbl	7884(%r15), %eax
	movl	64012(%r15,%rax,4), %ebx
	movq	%rax, -200(%rbp)        # 8-byte Spill
	imulq	$1032, %rax, %rax       # imm = 0x408
	leaq	45436(%r15,%rax), %rcx
	movq	%rcx, -176(%rbp)        # 8-byte Spill
	leaq	57820(%r15,%rax), %rcx
	movq	%rcx, -168(%rbp)        # 8-byte Spill
	leaq	51628(%r15,%rax), %rax
	movq	%rax, -48(%rbp)         # 8-byte Spill
	movl	$49, -72(%rbp)          # 4-byte Folded Spill
	xorl	%r9d, %r9d
	movl	%ebx, -76(%rbp)         # 4-byte Spill
	xorl	%edi, %edi
	movl	%r14d, %r8d
	movq	-88(%rbp), %r13         # 8-byte Reload
	movl	-52(%rbp), %esi         # 4-byte Reload
.LBB15_330:                             # %sw.bb1788
	movl	$36, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	%ebx, 36(%r15)
	jl	.LBB15_333
	jmp	.LBB15_335
	.p2align	4, 0x90
.LBB15_331:                             # %if.then1836
                                        #   in Loop: Header=BB15_333 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_332:                             # %while.body1791
                                        #   in Loop: Header=BB15_333 Depth=1
	cmpl	%ebx, 36(%r15)
	jge	.LBB15_335
.LBB15_333:                             # %if.end1807
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#334:                               # %if.end1813
                                        #   in Loop: Header=BB15_333 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_332
	jmp	.LBB15_331
.LBB15_335:                             # %if.then1795
	movq	%rdi, -64(%rbp)         # 8-byte Spill
	movl	32(%r15), %edx
	movl	36(%r15), %eax
	subl	%ebx, %eax
	movl	%eax, %ecx
	shrl	%cl, %edx
	movl	$1, %edi
	movl	%ebx, %ecx
	shll	%cl, %edi
	movq	%rdi, %rcx
	decl	%ecx
	andl	%edx, %ecx
	movl	%eax, 36(%r15)
	jmp	.LBB15_337
.LBB15_283:                             # %save_state_and_return
	movq	-48(%rbp), %r14         # 8-byte Reload
	movl	-52(%rbp), %esi         # 4-byte Reload
	movl	-56(%rbp), %ebx         # 4-byte Reload
	movq	-104(%rbp), %r9         # 8-byte Reload
	movq	-64(%rbp), %rdi         # 8-byte Reload
	movq	-112(%rbp), %r12        # 8-byte Reload
	jmp	.LBB15_488
.LBB15_337:                             # %while.body1843
	movl	$-4, %eax
	cmpl	$20, %ebx
	jle	.LBB15_339
# BB#338:
	movq	%rcx, -152(%rbp)        # 8-byte Spill
	movq	-64(%rbp), %rdi         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_339:                             # %if.end1847
	movslq	%ebx, %rdi
	movq	-176(%rbp), %rdx        # 8-byte Reload
	cmpl	(%rdx,%rdi,4), %ecx
	movq	%rcx, -152(%rbp)        # 8-byte Spill
	jg	.LBB15_343
# BB#340:                               # %while.end1909
	cmpl	(%r14,%rdi,4), %ecx
	js	.LBB15_351
# BB#341:                               # %lor.lhs.false1915
	movl	%ecx, %edx
	subl	(%r14,%rdi,4), %edx
	cmpl	$257, %edx              # imm = 0x101
	jle	.LBB15_489
# BB#342:
	movq	-64(%rbp), %rdi         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_343:                             # %if.end1853
	movq	%r14, -48(%rbp)         # 8-byte Spill
	incl	%ebx
	movq	-64(%rbp), %rdi         # 8-byte Reload
.LBB15_344:                             # %sw.bb1855
	movl	$37, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$0, 36(%r15)
	jle	.LBB15_347
	jmp	.LBB15_349
	.p2align	4, 0x90
.LBB15_345:                             # %if.then1901
                                        #   in Loop: Header=BB15_347 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_346:                             # %while.body1858
                                        #   in Loop: Header=BB15_347 Depth=1
	cmpl	$0, 36(%r15)
	jg	.LBB15_349
.LBB15_347:                             # %if.end1872
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#348:                               # %if.end1878
                                        #   in Loop: Header=BB15_347 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_346
	jmp	.LBB15_345
.LBB15_349:                             # %if.then1862
	movq	%rdi, -64(%rbp)         # 8-byte Spill
	movl	32(%r15), %r13d
	movl	36(%r15), %ecx
	decl	%ecx
	shrl	%cl, %r13d
	andl	$1, %r13d
	movl	%ecx, 36(%r15)
	movq	-152(%rbp), %rcx        # 8-byte Reload
	leal	(%r13,%rcx,2), %ecx
	jmp	.LBB15_337
.LBB15_351:
	movq	-64(%rbp), %rdi         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_352:                             # %while.body1929.loopexit16
	movl	-116(%rbp), %eax        # 4-byte Reload
.LBB15_353:                             # %while.body1929
	cmpl	%eax, -136(%rbp)        # 4-byte Folded Reload
	movl	-76(%rbp), %ecx         # 4-byte Reload
	movq	%r14, -48(%rbp)         # 8-byte Spill
	movl	%eax, -116(%rbp)        # 4-byte Spill
	movl	%esi, -52(%rbp)         # 4-byte Spill
	movl	%ebx, -56(%rbp)         # 4-byte Spill
	movq	%r13, -88(%rbp)         # 8-byte Spill
	movq	%rdi, -64(%rbp)         # 8-byte Spill
	jne	.LBB15_372
# BB#354:                               # %while.end2549
	movl	$-4, %eax
	cmpl	$0, 56(%r15)
	js	.LBB15_488
# BB#355:                               # %lor.lhs.false2553
	cmpl	%r9d, 56(%r15)
	jge	.LBB15_488
# BB#356:                               # %if.end2558
	movl	$0, 16(%r15)
	movb	$0, 12(%r15)
	movl	$-1, 3184(%r15)
	movl	$2, 8(%r15)
	cmpl	$2, 52(%r15)
	movq	%r9, -104(%rbp)         # 8-byte Spill
	jl	.LBB15_358
# BB#357:                               # %if.then2563
	movq	stderr(%rip), %rdi
	movl	$.L.str.5, %esi
	xorl	%eax, %eax
	movl	%r10d, %r12d
	movl	%r11d, %r14d
	movl	%r8d, %ebx
	callq	fprintf
	movq	-64(%rbp), %rdi         # 8-byte Reload
	movq	-104(%rbp), %r9         # 8-byte Reload
	movl	%ebx, %r8d
	movl	-56(%rbp), %ebx         # 4-byte Reload
	movl	-76(%rbp), %ecx         # 4-byte Reload
	movl	%r14d, %r11d
	movq	-48(%rbp), %r14         # 8-byte Reload
	movl	%r12d, %r10d
.LBB15_358:                             # %if.end2565
	movl	%ecx, -76(%rbp)         # 4-byte Spill
	movl	$0, 1096(%r15)
	movl	$275, %eax              # imm = 0x113
	jmp	.LBB15_360
.LBB15_359:                             # %for.body2570
                                        #   in Loop: Header=BB15_360 Depth=1
	movl	-1032(%r15,%rax,4), %ecx
	movl	%ecx, (%r15,%rax,4)
	incq	%rax
.LBB15_360:                             # %for.cond2567
                                        # =>This Inner Loop Header: Depth=1
	leal	-274(%rax), %ecx
	cmpl	$257, %ecx              # imm = 0x101
	jl	.LBB15_359
# BB#361:                               # %for.cond2581.preheader
	movl	$275, %eax              # imm = 0x113
	jmp	.LBB15_363
.LBB15_362:                             # %for.body2584
                                        #   in Loop: Header=BB15_363 Depth=1
	movl	-4(%r15,%rax,4), %ecx
	addl	%ecx, (%r15,%rax,4)
	incq	%rax
.LBB15_363:                             # %for.cond2581
                                        # =>This Inner Loop Header: Depth=1
	leal	-274(%rax), %ecx
	cmpl	$256, %ecx              # imm = 0x100
	jle	.LBB15_362
# BB#364:                               # %for.end2595
	cmpb	$0, 44(%r15)
	je	.LBB15_421
# BB#365:                               # %for.cond2599.preheader
	xorl	%eax, %eax
	cmpl	$257, %eax              # imm = 0x101
	jge	.LBB15_367
.LBB15_366:                             # %for.body2602
                                        # =>This Inner Loop Header: Depth=1
	movl	1096(%r15,%rax,4), %ecx
	movl	%ecx, 2124(%r15,%rax,4)
	incq	%rax
	cmpl	$257, %eax              # imm = 0x101
	jl	.LBB15_366
.LBB15_367:                             # %for.cond2611.preheader
	xorl	%eax, %eax
	cmpl	%r9d, %eax
	jge	.LBB15_400
.LBB15_369:                             # %for.body2614
                                        # =>This Inner Loop Header: Depth=1
	movq	3160(%r15), %rdx
	movzbl	(%rdx,%rax,2), %ecx
	movzwl	2124(%r15,%rcx,4), %esi
	movw	%si, (%rdx,%rax,2)
	movq	3168(%r15), %rdx
	movl	%eax, %esi
	sarl	%esi
	movslq	%esi, %rsi
	movzbl	(%rdx,%rsi), %edx
	testb	$1, %al
	jne	.LBB15_371
# BB#370:                               # %if.then2630
                                        #   in Loop: Header=BB15_369 Depth=1
	andl	$240, %edx
	movzbl	%cl, %esi
	movl	2124(%r15,%rsi,4), %esi
	sarl	$16, %esi
	orl	%edx, %esi
	jmp	.LBB15_368
.LBB15_371:                             # %if.else2647
                                        #   in Loop: Header=BB15_369 Depth=1
	andl	$15, %edx
	movzbl	%cl, %esi
	movl	2124(%r15,%rsi,4), %esi
	sarl	$16, %esi
	shll	$4, %esi
	orl	%edx, %esi
.LBB15_368:                             # %if.end2665
                                        #   in Loop: Header=BB15_369 Depth=1
	movq	3168(%r15), %rdx
	movl	%eax, %edi
	sarl	%edi
	movslq	%edi, %rdi
	movb	%sil, (%rdx,%rdi)
	movzbl	%cl, %ecx
	incl	2124(%r15,%rcx,4)
	incq	%rax
	cmpl	%r9d, %eax
	jl	.LBB15_369
.LBB15_400:                             # %for.end2672
	movl	%r11d, %r12d
	movslq	56(%r15), %rax
	movq	3160(%r15), %rcx
	movq	3168(%r15), %rdx
	movzwl	(%rcx,%rax,2), %esi
	movl	%eax, %ecx
	sarl	%ecx
	movslq	%ecx, %rcx
	movzbl	(%rdx,%rcx), %ebx
	movl	%eax, %ecx
	shlb	$2, %cl
	andb	$4, %cl
	shrl	%cl, %ebx
	andl	$15, %ebx
	shll	$16, %ebx
	orl	%esi, %ebx
.LBB15_401:                             # %do.body2689
                                        # =>This Inner Loop Header: Depth=1
	movl	%ebx, %r14d
	movslq	%r14d, %rdi
	movq	3160(%r15), %r11
	movq	3168(%r15), %rcx
	movzwl	(%r11,%rdi,2), %ebx
	movl	%edi, %edx
	sarl	%edx
	movslq	%edx, %rdx
	movzbl	(%rcx,%rdx), %esi
	movl	%edi, %ecx
	shlb	$2, %cl
	andb	$4, %cl
	shrl	%cl, %esi
	andl	$15, %esi
	shll	$16, %esi
	movw	%ax, (%r11,%rdi,2)
	movq	3168(%r15), %rcx
	movzbl	(%rcx,%rdx), %ecx
	testb	$1, %dil
	jne	.LBB15_403
# BB#402:                               # %if.then2715
                                        #   in Loop: Header=BB15_401 Depth=1
	andl	$240, %ecx
	sarl	$16, %eax
	orl	%ecx, %eax
	jmp	.LBB15_404
.LBB15_403:                             # %if.else2729
                                        #   in Loop: Header=BB15_401 Depth=1
	andl	$15, %ecx
	sarl	$16, %eax
	shll	$4, %eax
	orl	%ecx, %eax
.LBB15_404:                             # %if.end2744
                                        #   in Loop: Header=BB15_401 Depth=1
	orl	%esi, %ebx
	movq	3168(%r15), %rcx
	movb	%al, (%rcx,%rdx)
	cmpl	56(%r15), %r14d
	movl	%r14d, %eax
	jne	.LBB15_401
# BB#405:                               # %do.end2749
	movq	%r14, -112(%rbp)        # 8-byte Spill
	movl	%ebx, -92(%rbp)         # 4-byte Spill
	movl	%r8d, -68(%rbp)         # 4-byte Spill
	movl	%r10d, %ebx
	movl	56(%r15), %eax
	movl	%eax, 60(%r15)
	movl	$0, 1092(%r15)
	cmpb	$0, 20(%r15)
	je	.LBB15_429
# BB#406:                               # %if.then2753
	movq	$0, 24(%r15)
	movl	60(%r15), %edi
	leaq	1096(%r15), %rsi
	callq	BZ2_indexIntoF
	movl	%eax, 64(%r15)
	movq	3160(%r15), %rax
	movl	60(%r15), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movq	3168(%r15), %rdx
	movl	%ecx, %esi
	shrl	%esi
	movzbl	(%rdx,%rsi), %edx
	shlb	$2, %cl
	andb	$4, %cl
                                        # kill: %CL<def> %CL<kill> %RCX<kill>
	shrl	%cl, %edx
	andl	$15, %edx
	shll	$16, %edx
	orl	%eax, %edx
	movl	%edx, 60(%r15)
	incl	1092(%r15)
	cmpl	$0, 24(%r15)
	jne	.LBB15_409
# BB#407:                               # %if.then2781
	movslq	28(%r15), %rax
	movl	BZ2_rNums(,%rax,4), %eax
	movl	%eax, 24(%r15)
	movl	28(%r15), %eax
	incl	%eax
	movl	%eax, 28(%r15)
	cmpl	$512, %eax              # imm = 0x200
	jne	.LBB15_409
# BB#408:                               # %if.then2791
	movl	$0, 28(%r15)
.LBB15_409:                             # %if.end2794
	movl	24(%r15), %eax
	decl	%eax
	movl	%eax, 24(%r15)
	xorl	%ecx, %ecx
	cmpl	$1, %eax
	sete	%cl
	xorl	%ecx, 64(%r15)
	jmp	.LBB15_430
.LBB15_372:                             # %if.end1933
	cmpl	$1, -136(%rbp)          # 4-byte Folded Reload
	ja	.LBB15_392
# BB#373:
	movl	$-1, %eax
	movq	%rax, -144(%rbp)        # 8-byte Spill
	movl	$1, %eax
	movq	%rax, -184(%rbp)        # 8-byte Spill
	movl	-72(%rbp), %eax         # 4-byte Reload
.LBB15_374:                             # %do.body
	cmpl	$1, -136(%rbp)          # 4-byte Folded Reload
	movq	%r14, -48(%rbp)         # 8-byte Spill
	movl	%ecx, -76(%rbp)         # 4-byte Spill
	je	.LBB15_377
# BB#375:                               # %do.body
	cmpl	$0, -136(%rbp)          # 4-byte Folded Reload
	jne	.LBB15_379
# BB#376:                               # %if.then1942
	movq	-184(%rbp), %rcx        # 8-byte Reload
	movq	-144(%rbp), %rdx        # 8-byte Reload
	addl	%ecx, %edx
	jmp	.LBB15_378
.LBB15_377:                             # %if.then1948
	movq	-184(%rbp), %rcx        # 8-byte Reload
	movq	-144(%rbp), %rdx        # 8-byte Reload
	leal	(%rdx,%rcx,2), %edx
.LBB15_378:                             # %if.end1952
	movq	%rdx, -144(%rbp)        # 8-byte Spill
	jmp	.LBB15_380
.LBB15_379:
	movq	-184(%rbp), %rcx        # 8-byte Reload
.LBB15_380:                             # %if.end1952
	addl	%ecx, %ecx
	movq	%rcx, -184(%rbp)        # 8-byte Spill
	testl	%eax, %eax
	je	.LBB15_382
# BB#381:
	movl	-76(%rbp), %ebx         # 4-byte Reload
	jmp	.LBB15_384
.LBB15_382:                             # %if.then1956
	movl	%eax, -72(%rbp)         # 4-byte Spill
	movslq	%edi, %rdi
	incq	%rdi
	movl	$-4, %eax
	cmpl	%r11d, %edi
	jge	.LBB15_488
# BB#383:                               # %if.end1961
	movzbl	7884(%r15,%rdi), %eax
	movl	64012(%r15,%rax,4), %ebx
	movq	%rax, -200(%rbp)        # 8-byte Spill
	imulq	$1032, %rax, %rax       # imm = 0x408
	leaq	45436(%r15,%rax), %rcx
	movq	%rcx, -176(%rbp)        # 8-byte Spill
	leaq	57820(%r15,%rax), %rcx
	movq	%rcx, -168(%rbp)        # 8-byte Spill
	leaq	51628(%r15,%rax), %rax
	movq	%rax, -48(%rbp)         # 8-byte Spill
	movl	$50, %eax
.LBB15_384:                             # %if.end1981
	decl	%eax
	movl	%eax, -72(%rbp)         # 4-byte Spill
	movl	%ebx, -76(%rbp)         # 4-byte Spill
.LBB15_385:                             # %sw.bb1983
	movl	$38, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	%ebx, 36(%r15)
	jl	.LBB15_388
	jmp	.LBB15_390
.LBB15_386:                             # %if.then2031
                                        #   in Loop: Header=BB15_388 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_387:                             # %while.body1986
                                        #   in Loop: Header=BB15_388 Depth=1
	cmpl	%ebx, 36(%r15)
	jge	.LBB15_390
.LBB15_388:                             # %if.end2002
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#389:                               # %if.end2008
                                        #   in Loop: Header=BB15_388 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_387
	jmp	.LBB15_386
.LBB15_390:                             # %if.then1990
	movl	32(%r15), %edx
	movl	36(%r15), %eax
	subl	%ebx, %eax
	movl	%eax, %ecx
	shrl	%cl, %edx
	movl	%r8d, -68(%rbp)         # 4-byte Spill
	movq	%rdi, %r8
	movq	%r13, -88(%rbp)         # 8-byte Spill
	movl	%r10d, %r13d
	movl	%r11d, %r10d
	movq	%r9, %r11
	movl	%ebx, %r9d
	movq	%r12, %rbx
	movl	%esi, %r12d
	movl	$1, %edi
	movl	%r9d, %ecx
	shll	%cl, %edi
	movq	%rdi, %rcx
	movq	%rbx, %r12
	movl	%r9d, %ebx
	movq	%r11, %r9
	movl	%r10d, %r11d
	movl	%r13d, %r10d
	movq	-88(%rbp), %r13         # 8-byte Reload
	movq	%r8, %rdi
	movl	-68(%rbp), %r8d         # 4-byte Reload
	decl	%ecx
	andl	%edx, %ecx
	movl	%eax, 36(%r15)
	jmp	.LBB15_448
.LBB15_392:                             # %if.else2174
	movl	$-4, %eax
	cmpl	%esi, %r9d
	jge	.LBB15_488
# BB#393:                               # %if.end2178
	movq	-136(%rbp), %rcx        # 8-byte Reload
	leal	-1(%rcx), %esi
	cmpl	$15, %esi
	ja	.LBB15_410
# BB#394:                               # %if.then2192
	movl	%r11d, -80(%rbp)        # 4-byte Spill
	movq	%r9, %r11
	movl	%r8d, %r14d
	movslq	7820(%r15), %r9
	leal	(%r9,%rsi), %ecx
	movb	3724(%r15,%rcx), %r8b
	movq	-136(%rbp), %rcx        # 8-byte Reload
	leal	-1(%rcx,%r9), %ecx
	xorl	%edi, %edi
	jmp	.LBB15_396
.LBB15_395:                             # %while.body2202
                                        #   in Loop: Header=BB15_396 Depth=1
	leal	(%rcx,%rdi), %ebx
	leal	-1(%rcx,%rdi), %edx
	movslq	%edx, %rdx
	movzbl	3724(%r15,%rdx), %edx
	movslq	%ebx, %rbx
	movb	%dl, 3724(%r15,%rbx)
	leal	-2(%rcx,%rdi), %edx
	movslq	%edx, %rdx
	movzbl	3724(%r15,%rdx), %edx
	leal	-1(%rcx,%rdi), %ebx
	movslq	%ebx, %rbx
	movb	%dl, 3724(%r15,%rbx)
	leal	-3(%rcx,%rdi), %edx
	movslq	%edx, %rdx
	movzbl	3724(%r15,%rdx), %edx
	leal	-2(%rcx,%rdi), %ebx
	movslq	%ebx, %rbx
	movb	%dl, 3724(%r15,%rbx)
	leal	-4(%rcx,%rdi), %edx
	movslq	%edx, %rdx
	movzbl	3724(%r15,%rdx), %edx
	leal	-3(%rcx,%rdi), %ebx
	movslq	%ebx, %rbx
	movb	%dl, 3724(%r15,%rbx)
	addl	$-4, %edi
.LBB15_396:                             # %while.cond2199
                                        # =>This Inner Loop Header: Depth=1
	leal	(%rsi,%rdi), %ebx
	cmpl	$3, %ebx
	ja	.LBB15_395
# BB#397:                               # %while.cond2238.preheader
	movq	-136(%rbp), %rcx        # 8-byte Reload
	movq	%rcx, %rdx
	leal	(%rdx,%r9), %ecx
	leal	-1(%rdi,%rcx), %esi
	leal	-1(%rdx,%rdi), %ecx
	testl	%ecx, %ecx
	je	.LBB15_399
.LBB15_398:                             # %while.body2241
                                        # =>This Inner Loop Header: Depth=1
	movl	%esi, %edx
	leal	-1(%rsi), %esi
	movzbl	3724(%r15,%rsi), %ebx
	movb	%bl, 3724(%r15,%rdx)
	decl	%ecx
                                        # kill: %ESI<def> %ESI<kill> %RSI<kill> %RSI<def>
	testl	%ecx, %ecx
	jne	.LBB15_398
.LBB15_399:                             # %while.end2252
	movb	%r8b, 3724(%r15,%r9)
	movl	-56(%rbp), %ebx         # 4-byte Reload
	movq	%r11, %r9
	movq	-64(%rbp), %rdi         # 8-byte Reload
	movl	-80(%rbp), %r11d        # 4-byte Reload
	jmp	.LBB15_432
.LBB15_410:                             # %if.else2256
	movq	%rdi, %r13
	movl	%r8d, %r14d
	movl	%esi, %edx
	shrl	$4, %edx
	andl	$15, %esi
	movl	7820(%r15,%rdx,4), %edi
	leal	(%rdi,%rsi), %ecx
	movslq	%ecx, %rcx
	movb	3724(%r15,%rcx), %r8b
	leaq	3724(%r15,%rcx), %rcx
	leal	-1(%rdi,%rsi), %esi
	jmp	.LBB15_412
.LBB15_411:                             # %while.body2270
                                        #   in Loop: Header=BB15_412 Depth=1
	movslq	%esi, %rdi
	movzbl	3724(%r15,%rdi), %ebx
	movb	%bl, (%rcx)
	movl	-56(%rbp), %ebx         # 4-byte Reload
	decq	%rcx
	decl	%esi
.LBB15_412:                             # %while.cond2264
                                        # =>This Inner Loop Header: Depth=1
	leal	1(%rsi), %edi
	cmpl	7820(%r15,%rdx,4), %edi
	jg	.LBB15_411
# BB#413:                               # %while.end2279
	incl	7820(%r15,%rdx,4)
	movq	%r13, %rdi
	testl	%edx, %edx
	jle	.LBB15_415
.LBB15_414:                             # %while.body2287
                                        # =>This Inner Loop Header: Depth=1
	decl	7820(%r15,%rdx,4)
	movslq	7816(%r15,%rdx,4), %rcx
	movzbl	3739(%r15,%rcx), %ecx
	movslq	7820(%r15,%rdx,4), %rsi
	movb	%cl, 3724(%r15,%rsi)
	decq	%rdx
	testl	%edx, %edx
	jg	.LBB15_414
.LBB15_415:                             # %while.end2308
	decl	7820(%r15)
	movslq	7820(%r15), %rcx
	movb	%r8b, 3724(%r15,%rcx)
	cmpl	$0, 7820(%r15)
	jne	.LBB15_432
# BB#416:                               # %for.cond2322.preheader
	movq	%r12, -112(%rbp)        # 8-byte Spill
	movq	%rdi, %r12
	movq	%r9, -104(%rbp)         # 8-byte Spill
	leaq	3724(%r15), %r9
	movl	$4095, %esi             # imm = 0xFFF
	movl	$15, %ecx
	testl	%ecx, %ecx
	js	.LBB15_431
.LBB15_418:                             # %for.cond2326.preheader
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB15_420 Depth 2
	movslq	%esi, %rdx
	addq	%r9, %rdx
	xorl	%edi, %edi
	jmp	.LBB15_420
	.p2align	4, 0x90
.LBB15_419:                             # %for.body2329
                                        #   in Loop: Header=BB15_420 Depth=2
	movslq	%ecx, %rbx
	movl	7820(%r15,%rbx,4), %ebx
	leal	15(%rdi,%rbx), %ebx
	movslq	%ebx, %rbx
	movzbl	3724(%r15,%rbx), %ebx
	movb	%bl, (%rdx,%rdi)
	decq	%rdi
.LBB15_420:                             # %for.cond2326
                                        #   Parent Loop BB15_418 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	%edi, %ebx
	addl	$15, %ebx
	jns	.LBB15_419
# BB#417:                               # %for.end2343
                                        #   in Loop: Header=BB15_418 Depth=1
	leal	1(%rsi,%rdi), %edx
	leal	(%rsi,%rdi), %esi
	movslq	%ecx, %rdi
	movl	%edx, 7820(%r15,%rdi,4)
	decl	%ecx
                                        # kill: %ESI<def> %ESI<kill> %RSI<def>
	movl	-56(%rbp), %ebx         # 4-byte Reload
	testl	%ecx, %ecx
	jns	.LBB15_418
.LBB15_431:
	movq	-104(%rbp), %r9         # 8-byte Reload
	movq	%r12, %rdi
	movq	-112(%rbp), %r12        # 8-byte Reload
.LBB15_432:                             # %if.end2352
	movzbl	%r8b, %ecx
	movzbl	3468(%r15,%rcx), %edx
	incl	68(%r15,%rdx,4)
	movzbl	3468(%r15,%rcx), %ecx
	cmpb	$0, 44(%r15)
	je	.LBB15_434
# BB#433:                               # %if.then2362
	movq	3160(%r15), %rdx
	movslq	%r9d, %rsi
	movw	%cx, (%rdx,%rsi,2)
	jmp	.LBB15_435
.LBB15_421:                             # %for.cond2830.preheader
	xorl	%eax, %eax
	xorl	%r12d, %r12d
	jmp	.LBB15_423
.LBB15_422:                             # %for.body2833
                                        #   in Loop: Header=BB15_423 Depth=1
	movq	3152(%r15), %rdx
	movzbl	(%rcx,%r12,4), %ecx
	movslq	1096(%r15,%rcx,4), %rsi
	orl	%eax, (%rdx,%rsi,4)
	incl	1096(%r15,%rcx,4)
	incq	%r12
	addl	$256, %eax              # imm = 0x100
.LBB15_423:                             # %for.cond2830
                                        # =>This Inner Loop Header: Depth=1
	movq	3152(%r15), %rcx
	cmpl	%r9d, %r12d
	jl	.LBB15_422
# BB#424:                               # %for.end2853
	movslq	56(%r15), %rax
	movl	(%rcx,%rax,4), %eax
	shrl	$8, %eax
	movl	%eax, 60(%r15)
	movl	$0, 1092(%r15)
	cmpb	$0, 20(%r15)
	je	.LBB15_447
# BB#425:                               # %if.then2863
	movq	$0, 24(%r15)
	movq	3152(%r15), %rax
	movl	60(%r15), %ecx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, 60(%r15)
	movzbl	60(%r15), %eax
	movl	%eax, 64(%r15)
	shrl	$8, 60(%r15)
	incl	1092(%r15)
	cmpl	$0, 24(%r15)
	movl	-52(%rbp), %esi         # 4-byte Reload
	jne	.LBB15_428
# BB#426:                               # %if.then2883
	movslq	28(%r15), %rax
	movl	BZ2_rNums(,%rax,4), %eax
	movl	%eax, 24(%r15)
	movl	28(%r15), %eax
	incl	%eax
	movl	%eax, 28(%r15)
	cmpl	$512, %eax              # imm = 0x200
	jne	.LBB15_428
# BB#427:                               # %if.then2893
	movl	$0, 28(%r15)
.LBB15_428:                             # %if.end2896
	movl	24(%r15), %eax
	decl	%eax
	movl	%eax, 24(%r15)
	xorl	%ecx, %ecx
	cmpl	$1, %eax
	sete	%cl
	xorl	%ecx, 64(%r15)
	jmp	.LBB15_487
.LBB15_434:                             # %if.else2370
	movzwl	%cx, %ecx
	movq	3152(%r15), %rdx
	movslq	%r9d, %rsi
	movl	%ecx, (%rdx,%rsi,4)
.LBB15_435:                             # %if.end2378
	movq	-88(%rbp), %r13         # 8-byte Reload
	movl	-72(%rbp), %ecx         # 4-byte Reload
	movl	%r14d, %r8d
	incl	%r9d
	movl	%ecx, -72(%rbp)         # 4-byte Spill
	testl	%ecx, %ecx
	movl	-52(%rbp), %esi         # 4-byte Reload
	movq	-48(%rbp), %r14         # 8-byte Reload
	je	.LBB15_437
# BB#436:
	movl	-72(%rbp), %eax         # 4-byte Reload
	movl	-76(%rbp), %ebx         # 4-byte Reload
	jmp	.LBB15_439
.LBB15_437:                             # %if.then2382
	movslq	%edi, %rdi
	incq	%rdi
	cmpl	%r11d, %edi
	jge	.LBB15_488
# BB#438:                               # %if.end2387
	movzbl	7884(%r15,%rdi), %eax
	movl	64012(%r15,%rax,4), %ebx
	movq	%rax, -200(%rbp)        # 8-byte Spill
	imulq	$1032, %rax, %rax       # imm = 0x408
	leaq	45436(%r15,%rax), %rcx
	movq	%rcx, -176(%rbp)        # 8-byte Spill
	leaq	57820(%r15,%rax), %rcx
	movq	%rcx, -168(%rbp)        # 8-byte Spill
	leaq	51628(%r15,%rax), %rax
	movq	%rax, -48(%rbp)         # 8-byte Spill
	movl	$50, %eax
.LBB15_439:                             # %if.end2407
	decl	%eax
	movl	%eax, -72(%rbp)         # 4-byte Spill
	movl	%ebx, -76(%rbp)         # 4-byte Spill
.LBB15_440:                             # %sw.bb2409
	movl	$40, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	movq	%rdi, -64(%rbp)         # 8-byte Spill
	cmpl	%ebx, 36(%r15)
	jl	.LBB15_443
	jmp	.LBB15_445
.LBB15_441:                             # %if.then2457
                                        #   in Loop: Header=BB15_443 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_442:                             # %while.body2412
                                        #   in Loop: Header=BB15_443 Depth=1
	cmpl	%ebx, 36(%r15)
	jge	.LBB15_445
.LBB15_443:                             # %if.end2428
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#444:                               # %if.end2434
                                        #   in Loop: Header=BB15_443 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_442
	jmp	.LBB15_441
.LBB15_445:                             # %if.then2416
	movl	32(%r15), %edx
	movl	36(%r15), %eax
	subl	%ebx, %eax
	movl	%eax, %ecx
	shrl	%cl, %edx
	movl	%ebx, %ecx
	movl	%esi, %ebx
	movl	$1, %edi
	shll	%cl, %edi
	movl	%ecx, %ebx
	decl	%edi
	andl	%edx, %edi
	movl	%eax, 36(%r15)
	jmp	.LBB15_474
.LBB15_429:                             # %if.else2801
	movl	60(%r15), %edi
	leaq	1096(%r15), %rsi
	callq	BZ2_indexIntoF
	movl	%eax, 64(%r15)
	movq	3160(%r15), %rax
	movl	60(%r15), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movq	3168(%r15), %rdx
	movl	%ecx, %esi
	shrl	%esi
	movzbl	(%rdx,%rsi), %edx
	shlb	$2, %cl
	andb	$4, %cl
                                        # kill: %CL<def> %CL<kill> %RCX<kill>
	shrl	%cl, %edx
	andl	$15, %edx
	shll	$16, %edx
	orl	%eax, %edx
	movl	%edx, 60(%r15)
	incl	1092(%r15)
.LBB15_430:                             # %save_state_and_return
	xorl	%eax, %eax
	movl	%ebx, %r10d
	movl	%r12d, %r11d
	movl	-68(%rbp), %r8d         # 4-byte Reload
	movq	-88(%rbp), %r13         # 8-byte Reload
	jmp	.LBB15_283
.LBB15_447:                             # %if.else2905
	movq	3152(%r15), %rax
	movl	60(%r15), %ecx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, 60(%r15)
	movzbl	60(%r15), %eax
	movl	%eax, 64(%r15)
	shrl	$8, 60(%r15)
	incl	1092(%r15)
	xorl	%eax, %eax
	movl	-52(%rbp), %esi         # 4-byte Reload
	jmp	.LBB15_488
.LBB15_448:                             # %while.body2038
	movl	$-4, %eax
	cmpl	$20, %ebx
	jle	.LBB15_450
# BB#449:
	movq	%rcx, -152(%rbp)        # 8-byte Spill
	jmp	.LBB15_488
.LBB15_450:                             # %if.end2042
	movq	%r14, -48(%rbp)         # 8-byte Spill
	movq	%rdi, -64(%rbp)         # 8-byte Spill
	movslq	%ebx, %rdi
	movq	-176(%rbp), %rdx        # 8-byte Reload
	cmpl	(%rdx,%rdi,4), %ecx
	movq	%rcx, -152(%rbp)        # 8-byte Spill
	jg	.LBB15_454
# BB#451:                               # %while.end2104
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	(%r14,%rdi,4), %ecx
	js	.LBB15_462
# BB#452:                               # %lor.lhs.false2110
	movl	%ecx, %edx
	subl	(%r14,%rdi,4), %edx
	cmpl	$257, %edx              # imm = 0x101
	jle	.LBB15_463
# BB#453:
	movq	-64(%rbp), %rdi         # 8-byte Reload
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_454:                             # %if.end2048
	incl	%ebx
	movq	-64(%rbp), %rdi         # 8-byte Reload
.LBB15_455:                             # %sw.bb2050
	movl	$39, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$0, 36(%r15)
	jle	.LBB15_458
	jmp	.LBB15_460
.LBB15_456:                             # %if.then2096
                                        #   in Loop: Header=BB15_458 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_457:                             # %while.body2053
                                        #   in Loop: Header=BB15_458 Depth=1
	cmpl	$0, 36(%r15)
	jg	.LBB15_460
.LBB15_458:                             # %if.end2067
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#459:                               # %if.end2073
                                        #   in Loop: Header=BB15_458 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_457
	jmp	.LBB15_456
.LBB15_460:                             # %if.then2057
	movl	32(%r15), %r13d
	movl	36(%r15), %ecx
	decl	%ecx
	shrl	%cl, %r13d
	andl	$1, %r13d
	movl	%ecx, 36(%r15)
	movq	-152(%rbp), %rcx        # 8-byte Reload
	leal	(%r13,%rcx,2), %ecx
	jmp	.LBB15_448
.LBB15_462:
	movq	-64(%rbp), %rdi         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_463:                             # %if.end2117
	movq	-48(%rbp), %rdx         # 8-byte Reload
	movslq	(%rdx,%rdi,4), %rdi
	movslq	%ecx, %rdx
	subq	%rdi, %rdx
	movq	-168(%rbp), %rcx        # 8-byte Reload
	movl	(%rcx,%rdx,4), %edx
	testl	%edx, %edx
	sete	%cl
	movq	%rdx, -136(%rbp)        # 8-byte Spill
	cmpl	$1, %edx
	sete	%dl
	orb	%cl, %dl
	je	.LBB15_465
# BB#464:
	movq	-64(%rbp), %rdi         # 8-byte Reload
	movl	-72(%rbp), %eax         # 4-byte Reload
	movl	-76(%rbp), %ecx         # 4-byte Reload
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_374
.LBB15_465:                             # %do.end
	movq	-144(%rbp), %rdi        # 8-byte Reload
	incl	%edi
	movslq	7820(%r15), %rcx
	movzbl	3724(%r15,%rcx), %ecx
	movzbl	3468(%r15,%rcx), %ecx
	movq	%rdi, %rdx
	addl	%edi, 68(%r15,%rcx,4)
	cmpb	$0, 44(%r15)
	je	.LBB15_470
# BB#466:                               # %while.cond2142.preheader
	movslq	%r9d, %r9
	movq	-64(%rbp), %rdi         # 8-byte Reload
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_468
.LBB15_467:                             # %if.end2149
                                        #   in Loop: Header=BB15_468 Depth=1
	movq	3160(%r15), %rdx
	movw	%cx, (%rdx,%r9,2)
	movq	-144(%rbp), %rdx        # 8-byte Reload
	decl	%edx
	incq	%r9
.LBB15_468:                             # %while.cond2142
                                        # =>This Inner Loop Header: Depth=1
	movq	%rdx, -144(%rbp)        # 8-byte Spill
	testl	%edx, %edx
	jle	.LBB15_352
# BB#469:                               # %while.body2145
                                        #   in Loop: Header=BB15_468 Depth=1
	cmpl	%esi, %r9d
	jl	.LBB15_467
	jmp	.LBB15_488
.LBB15_470:                             # %while.cond2158.preheader
	movslq	%r9d, %r9
	movzwl	%cx, %ecx
	movq	-64(%rbp), %rdi         # 8-byte Reload
	movq	-48(%rbp), %r14         # 8-byte Reload
	jmp	.LBB15_472
.LBB15_471:                             # %if.end2165
                                        #   in Loop: Header=BB15_472 Depth=1
	movq	3152(%r15), %rdx
	movl	%ecx, (%rdx,%r9,4)
	movq	-144(%rbp), %rdx        # 8-byte Reload
	decl	%edx
	incq	%r9
.LBB15_472:                             # %while.cond2158
                                        # =>This Inner Loop Header: Depth=1
	movq	%rdx, -144(%rbp)        # 8-byte Spill
	testl	%edx, %edx
	jle	.LBB15_352
# BB#473:                               # %while.body2161
                                        #   in Loop: Header=BB15_472 Depth=1
	cmpl	%esi, %r9d
	jl	.LBB15_471
	jmp	.LBB15_488
.LBB15_487:
	xorl	%eax, %eax
.LBB15_488:                             # %save_state_and_return
	movl	%r12d, 64036(%r15)
	movl	-92(%rbp), %ecx         # 4-byte Reload
	movl	%ecx, 64040(%r15)
	movl	-124(%rbp), %ecx        # 4-byte Reload
	movl	%ecx, 64044(%r15)
	movl	-156(%rbp), %ecx        # 4-byte Reload
	movl	%ecx, 64048(%r15)
	movl	%r10d, 64052(%r15)
	movl	%r11d, 64056(%r15)
	movl	-116(%rbp), %ecx        # 4-byte Reload
	movl	%ecx, 64060(%r15)
	movl	%edi, 64064(%r15)
	movl	-72(%rbp), %ecx         # 4-byte Reload
	movl	%ecx, 64068(%r15)
	movq	-136(%rbp), %rcx        # 8-byte Reload
	movl	%ecx, 64072(%r15)
	movl	%esi, 64076(%r15)
	movl	%r9d, 64080(%r15)
	movq	-144(%rbp), %rcx        # 8-byte Reload
	movl	%ecx, 64084(%r15)
	movq	-184(%rbp), %rcx        # 8-byte Reload
	movl	%ecx, 64088(%r15)
	movl	-120(%rbp), %ecx        # 4-byte Reload
	movl	%ecx, 64092(%r15)
	movl	%r8d, 64096(%r15)
	movl	%ebx, 64100(%r15)
	movq	-152(%rbp), %rcx        # 8-byte Reload
	movl	%ecx, 64104(%r15)
	movl	%r13d, 64108(%r15)
	movq	-200(%rbp), %rcx        # 8-byte Reload
	movl	%ecx, 64112(%r15)
	movl	-76(%rbp), %ecx         # 4-byte Reload
	movl	%ecx, 64116(%r15)
	movq	-176(%rbp), %rcx        # 8-byte Reload
	movq	%rcx, 64120(%r15)
	movq	%r14, 64128(%r15)
	movq	-168(%rbp), %rcx        # 8-byte Reload
	movq	%rcx, 64136(%r15)
	addq	$168, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB15_474:                             # %while.body2464
	movl	$-4, %eax
	cmpl	$20, %ebx
	jle	.LBB15_476
# BB#475:
	movq	%rdi, -152(%rbp)        # 8-byte Spill
	movq	-64(%rbp), %rdi         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_476:                             # %if.end2468
	movq	%rdi, %rcx
	movslq	%ebx, %rdi
	movq	-176(%rbp), %rdx        # 8-byte Reload
	cmpl	(%rdx,%rdi,4), %ecx
	movq	%rcx, -152(%rbp)        # 8-byte Spill
	jg	.LBB15_480
# BB#477:                               # %while.end2530
	cmpl	(%r14,%rdi,4), %ecx
	js	.LBB15_490
# BB#478:                               # %lor.lhs.false2536
	movl	%ecx, %edx
	subl	(%r14,%rdi,4), %edx
	cmpl	$257, %edx              # imm = 0x101
	jle	.LBB15_489
# BB#479:
	movq	-64(%rbp), %rdi         # 8-byte Reload
	jmp	.LBB15_488
.LBB15_480:                             # %if.end2474
	movq	%r14, -48(%rbp)         # 8-byte Spill
	incl	%ebx
	movq	-64(%rbp), %rdi         # 8-byte Reload
.LBB15_481:                             # %sw.bb2476
	movl	$41, 8(%r15)
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	$0, 36(%r15)
	jle	.LBB15_484
	jmp	.LBB15_486
.LBB15_482:                             # %if.then2522
                                        #   in Loop: Header=BB15_484 Depth=1
	movq	(%r15), %rax
	incl	16(%rax)
.LBB15_483:                             # %while.body2479
                                        #   in Loop: Header=BB15_484 Depth=1
	cmpl	$0, 36(%r15)
	jg	.LBB15_486
.LBB15_484:                             # %if.end2493
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_487
# BB#485:                               # %if.end2499
                                        #   in Loop: Header=BB15_484 Depth=1
	movl	32(%r15), %eax
	shll	$8, %eax
	movq	(%r15), %rcx
	movq	(%rcx), %rcx
	movzbl	(%rcx), %ecx
	orl	%eax, %ecx
	movl	%ecx, 32(%r15)
	addl	$8, 36(%r15)
	movq	(%r15), %rax
	incq	(%rax)
	movq	(%r15), %rax
	decl	8(%rax)
	movq	(%r15), %rax
	incl	12(%rax)
	movq	(%r15), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_483
	jmp	.LBB15_482
.LBB15_486:                             # %if.then2483
	movq	%rdi, -64(%rbp)         # 8-byte Spill
	movl	32(%r15), %r13d
	movl	36(%r15), %ecx
	decl	%ecx
	shrl	%cl, %r13d
	andl	$1, %r13d
	movl	%ecx, 36(%r15)
	movq	-152(%rbp), %rdi        # 8-byte Reload
	leal	(%r13,%rdi,2), %edi
	jmp	.LBB15_474
.LBB15_489:                             # %if.end1922
	movslq	(%r14,%rdi,4), %rax
	movslq	%ecx, %rcx
	subq	%rax, %rcx
	movq	-168(%rbp), %rax        # 8-byte Reload
	movl	(%rax,%rcx,4), %eax
	movq	%rax, -136(%rbp)        # 8-byte Spill
	movl	-116(%rbp), %eax        # 4-byte Reload
	movq	-64(%rbp), %rdi         # 8-byte Reload
	jmp	.LBB15_353
.LBB15_490:
	movq	-64(%rbp), %rdi         # 8-byte Reload
	jmp	.LBB15_488
.Lfunc_end15:
	.size	BZ2_decompress, .Lfunc_end15-BZ2_decompress
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	3
.LJTI15_0:
	.quad	.LBB15_4
	.quad	.LBB15_12
	.quad	.LBB15_19
	.quad	.LBB15_26
	.quad	.LBB15_41
	.quad	.LBB15_118
	.quad	.LBB15_125
	.quad	.LBB15_132
	.quad	.LBB15_139
	.quad	.LBB15_146
	.quad	.LBB15_155
	.quad	.LBB15_161
	.quad	.LBB15_167
	.quad	.LBB15_173
	.quad	.LBB15_179
	.quad	.LBB15_185
	.quad	.LBB15_191
	.quad	.LBB15_197
	.quad	.LBB15_220
	.quad	.LBB15_274
	.quad	.LBB15_234
	.quad	.LBB15_241
	.quad	.LBB15_250
	.quad	.LBB15_285
	.quad	.LBB15_294
	.quad	.LBB15_300
	.quad	.LBB15_330
	.quad	.LBB15_344
	.quad	.LBB15_385
	.quad	.LBB15_455
	.quad	.LBB15_440
	.quad	.LBB15_481
	.quad	.LBB15_47
	.quad	.LBB15_54
	.quad	.LBB15_61
	.quad	.LBB15_68
	.quad	.LBB15_75
	.quad	.LBB15_82
	.quad	.LBB15_88
	.quad	.LBB15_94
	.quad	.LBB15_100

	.text
	.p2align	4, 0x90
	.type	makeMaps_d,@function
makeMaps_d:                             # @makeMaps_d
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi91:
	.cfi_def_cfa_offset 16
.Lcfi92:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi93:
	.cfi_def_cfa_register %rbp
	movl	$0, 3192(%rdi)
	xorl	%eax, %eax
	cmpl	$255, %eax
	jle	.LBB16_2
	jmp	.LBB16_5
	.p2align	4, 0x90
.LBB16_4:                               # %for.inc
                                        #   in Loop: Header=BB16_2 Depth=1
	incq	%rax
	cmpl	$255, %eax
	jg	.LBB16_5
.LBB16_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	cmpb	$0, 3196(%rdi,%rax)
	je	.LBB16_4
# BB#3:                                 # %if.then
                                        #   in Loop: Header=BB16_2 Depth=1
	movslq	3192(%rdi), %rcx
	movb	%al, 3468(%rdi,%rcx)
	incl	3192(%rdi)
	jmp	.LBB16_4
.LBB16_5:                               # %for.end
	popq	%rbp
	retq
.Lfunc_end16:
	.size	makeMaps_d, .Lfunc_end16-makeMaps_d
	.cfi_endproc

	.globl	BZ2_indexIntoF
	.p2align	4, 0x90
	.type	BZ2_indexIntoF,@function
BZ2_indexIntoF:                         # @BZ2_indexIntoF
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi94:
	.cfi_def_cfa_offset 16
.Lcfi95:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi96:
	.cfi_def_cfa_register %rbp
	movl	$256, %ecx              # imm = 0x100
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB17_1:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	leal	(%rax,%rcx), %edx
	sarl	%edx
	movslq	%edx, %rdx
	cmpl	(%rsi,%rdx,4), %edi
	cmovgel	%edx, %eax
	cmovll	%edx, %ecx
	movl	%ecx, %edx
	subl	%eax, %edx
	cmpl	$1, %edx
	jne	.LBB17_1
# BB#2:                                 # %do.end
                                        # kill: %EAX<def> %EAX<kill> %RAX<kill>
	popq	%rbp
	retq
.Lfunc_end17:
	.size	BZ2_indexIntoF, .Lfunc_end17-BZ2_indexIntoF
	.cfi_endproc

	.globl	BZ2_bzlibVersion
	.p2align	4, 0x90
	.type	BZ2_bzlibVersion,@function
BZ2_bzlibVersion:                       # @BZ2_bzlibVersion
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi97:
	.cfi_def_cfa_offset 16
.Lcfi98:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi99:
	.cfi_def_cfa_register %rbp
	movl	$.L.str.11, %eax
	popq	%rbp
	retq
.Lfunc_end18:
	.size	BZ2_bzlibVersion, .Lfunc_end18-BZ2_bzlibVersion
	.cfi_endproc

	.globl	BZ2_bzCompressInit
	.p2align	4, 0x90
	.type	BZ2_bzCompressInit,@function
BZ2_bzCompressInit:                     # @BZ2_bzCompressInit
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi100:
	.cfi_def_cfa_offset 16
.Lcfi101:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi102:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
.Lcfi103:
	.cfi_offset %rbx, -56
.Lcfi104:
	.cfi_offset %r12, -48
.Lcfi105:
	.cfi_offset %r13, -40
.Lcfi106:
	.cfi_offset %r14, -32
.Lcfi107:
	.cfi_offset %r15, -24
	movl	%ecx, %ebx
	movl	%edx, %r12d
	movl	%esi, %r13d
	movq	%rdi, %r15
	callq	bz_config_ok
	testl	%eax, %eax
	je	.LBB19_1
# BB#2:                                 # %if.end
	testq	%r15, %r15
	movl	$-2, %r14d
	je	.LBB19_24
# BB#3:                                 # %if.end
	testl	%r13d, %r13d
	jle	.LBB19_24
# BB#4:                                 # %if.end
	cmpl	$9, %r13d
	jg	.LBB19_24
# BB#5:                                 # %if.end
	testl	%ebx, %ebx
	js	.LBB19_24
# BB#6:                                 # %if.end
	cmpl	$250, %ebx
	jg	.LBB19_24
# BB#7:                                 # %if.end9
	testl	%ebx, %ebx
	movl	$30, %eax
	cmovnel	%ebx, %eax
	movl	%eax, -48(%rbp)         # 4-byte Spill
	cmpq	$0, 56(%r15)
	jne	.LBB19_9
# BB#8:                                 # %if.then14
	movq	$default_bzalloc, 56(%r15)
.LBB19_9:                               # %if.end16
	cmpq	$0, 64(%r15)
	jne	.LBB19_11
# BB#10:                                # %if.then18
	movq	$default_bzfree, 64(%r15)
.LBB19_11:                              # %if.end20
	movq	72(%r15), %rdi
	movl	$55768, %esi            # imm = 0xD9D8
	movl	$1, %edx
	callq	*56(%r15)
	movq	%rax, %rbx
	movl	$-3, %r14d
	testq	%rbx, %rbx
	je	.LBB19_24
# BB#12:                                # %if.end25
	movl	%r12d, -44(%rbp)        # 4-byte Spill
	movq	%r15, (%rbx)
	movq	$0, 24(%rbx)
	movq	$0, 32(%rbx)
	movq	$0, 40(%rbx)
	movq	72(%r15), %rdi
	imull	$400000, %r13d, %r12d   # imm = 0x61A80
	movl	$1, %edx
	movl	%r12d, %esi
	callq	*56(%r15)
	movq	%rax, 24(%rbx)
	movq	72(%r15), %rdi
	addl	$136, %r12d
	movl	$1, %edx
	movl	%r12d, %esi
	callq	*56(%r15)
	movq	%rax, 32(%rbx)
	movq	72(%r15), %rdi
	movl	$262148, %esi           # imm = 0x40004
	movl	$1, %edx
	callq	*56(%r15)
	movq	%rax, 40(%rbx)
	cmpq	$0, 24(%rbx)
	je	.LBB19_15
# BB#13:                                # %lor.lhs.false47
	cmpq	$0, 32(%rbx)
	je	.LBB19_15
# BB#14:                                # %lor.lhs.false51
	cmpq	$0, 40(%rbx)
	je	.LBB19_15
# BB#23:                                # %if.end86
	movl	$0, 660(%rbx)
	movl	$2, 12(%rbx)
	movl	$2, 8(%rbx)
	movl	$0, 652(%rbx)
	movl	%r13d, 664(%rbx)
	imull	$100000, %r13d, %eax    # imm = 0x186A0
	addl	$-19, %eax
	movl	%eax, 112(%rbx)
	movl	-44(%rbp), %eax         # 4-byte Reload
	movl	%eax, 656(%rbx)
	movl	-48(%rbp), %eax         # 4-byte Reload
	movl	%eax, 88(%rbx)
	movq	32(%rbx), %rax
	movq	%rax, 64(%rbx)
	movq	24(%rbx), %rax
	movq	%rax, 72(%rbx)
	movq	$0, 80(%rbx)
	movq	24(%rbx), %rax
	movq	%rax, 56(%rbx)
	movq	%rbx, 48(%r15)
	movq	$0, 12(%r15)
	movq	$0, 36(%r15)
	movq	%rbx, %rdi
	callq	init_RL
	movq	%rbx, %rdi
	callq	prepare_new_block
	xorl	%r14d, %r14d
	jmp	.LBB19_24
.LBB19_1:
	movl	$-9, %r14d
.LBB19_24:                              # %return
	movl	%r14d, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB19_15:                              # %if.then55
	cmpq	$0, 24(%rbx)
	je	.LBB19_17
# BB#16:                                # %if.then59
	movq	72(%r15), %rdi
	movq	24(%rbx), %rsi
	callq	*64(%r15)
.LBB19_17:                              # %if.end63
	cmpq	$0, 32(%rbx)
	je	.LBB19_19
# BB#18:                                # %if.then67
	movq	72(%r15), %rdi
	movq	32(%rbx), %rsi
	callq	*64(%r15)
.LBB19_19:                              # %if.end71
	cmpq	$0, 40(%rbx)
	je	.LBB19_21
# BB#20:                                # %if.then75
	movq	72(%r15), %rdi
	movq	40(%rbx), %rsi
	callq	*64(%r15)
.LBB19_21:                              # %if.end79
	testq	%rbx, %rbx
	je	.LBB19_24
# BB#22:                                # %if.then82
	movq	72(%r15), %rdi
	movq	%rbx, %rsi
	callq	*64(%r15)
	jmp	.LBB19_24
.Lfunc_end19:
	.size	BZ2_bzCompressInit, .Lfunc_end19-BZ2_bzCompressInit
	.cfi_endproc

	.p2align	4, 0x90
	.type	bz_config_ok,@function
bz_config_ok:                           # @bz_config_ok
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi108:
	.cfi_def_cfa_offset 16
.Lcfi109:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi110:
	.cfi_def_cfa_register %rbp
	movl	$1, %eax
	popq	%rbp
	retq
.Lfunc_end20:
	.size	bz_config_ok, .Lfunc_end20-bz_config_ok
	.cfi_endproc

	.p2align	4, 0x90
	.type	default_bzalloc,@function
default_bzalloc:                        # @default_bzalloc
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi111:
	.cfi_def_cfa_offset 16
.Lcfi112:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi113:
	.cfi_def_cfa_register %rbp
	imull	%edx, %esi
	movslq	%esi, %rdi
	callq	malloc
	popq	%rbp
	retq
.Lfunc_end21:
	.size	default_bzalloc, .Lfunc_end21-default_bzalloc
	.cfi_endproc

	.p2align	4, 0x90
	.type	default_bzfree,@function
default_bzfree:                         # @default_bzfree
	.cfi_startproc
# BB#0:                                 # %entry
	testq	%rsi, %rsi
	je	.LBB22_2
# BB#1:                                 # %if.then
	pushq	%rbp
.Lcfi114:
	.cfi_def_cfa_offset 16
.Lcfi115:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi116:
	.cfi_def_cfa_register %rbp
	movq	%rsi, %rdi
	callq	free
	popq	%rbp
.LBB22_2:                               # %if.end
	retq
.Lfunc_end22:
	.size	default_bzfree, .Lfunc_end22-default_bzfree
	.cfi_endproc

	.p2align	4, 0x90
	.type	init_RL,@function
init_RL:                                # @init_RL
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi117:
	.cfi_def_cfa_offset 16
.Lcfi118:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi119:
	.cfi_def_cfa_register %rbp
	movq	$256, 92(%rdi)          # imm = 0x100
	popq	%rbp
	retq
.Lfunc_end23:
	.size	init_RL, .Lfunc_end23-init_RL
	.cfi_endproc

	.p2align	4, 0x90
	.type	prepare_new_block,@function
prepare_new_block:                      # @prepare_new_block
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi120:
	.cfi_def_cfa_offset 16
.Lcfi121:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi122:
	.cfi_def_cfa_register %rbp
	movl	$0, 108(%rdi)
	movl	$0, 116(%rdi)
	movl	$0, 120(%rdi)
	movl	$-1, 648(%rdi)
	xorl	%eax, %eax
	cmpl	$255, %eax
	jg	.LBB24_3
	.p2align	4, 0x90
.LBB24_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movb	$0, 128(%rdi,%rax)
	incq	%rax
	cmpl	$255, %eax
	jle	.LBB24_2
.LBB24_3:                               # %for.end
	incl	660(%rdi)
	popq	%rbp
	retq
.Lfunc_end24:
	.size	prepare_new_block, .Lfunc_end24-prepare_new_block
	.cfi_endproc

	.globl	BZ2_bzCompress
	.p2align	4, 0x90
	.type	BZ2_bzCompress,@function
BZ2_bzCompress:                         # @BZ2_bzCompress
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi123:
	.cfi_def_cfa_offset 16
.Lcfi124:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi125:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi126:
	.cfi_offset %rbx, -32
.Lcfi127:
	.cfi_offset %r14, -24
	movl	$-2, %r14d
	testq	%rdi, %rdi
	je	.LBB25_26
# BB#1:                                 # %if.end
	movq	48(%rdi), %rbx
	testq	%rbx, %rbx
	je	.LBB25_26
# BB#2:                                 # %if.end3
	cmpq	%rdi, (%rbx)
	je	.LBB25_3
.LBB25_26:                              # %return
	movl	%r14d, %eax
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.LBB25_3:
	movl	$-1, %r14d
	jmp	.LBB25_6
	.p2align	4, 0x90
.LBB25_5:                               # %preswitch.sink.split
                                        #   in Loop: Header=BB25_6 Depth=1
	movl	8(%rdi), %ecx
	movl	%ecx, 16(%rbx)
	movl	%eax, 8(%rbx)
.LBB25_6:                               # %preswitch
                                        # =>This Inner Loop Header: Depth=1
	movl	8(%rbx), %eax
	decl	%eax
	cmpl	$3, %eax
	ja	.LBB25_25
# BB#7:                                 # %preswitch
                                        #   in Loop: Header=BB25_6 Depth=1
	jmpq	*.LJTI25_0(,%rax,8)
.LBB25_8:                               # %sw.bb8
                                        #   in Loop: Header=BB25_6 Depth=1
	cmpl	$1, %esi
	je	.LBB25_4
# BB#9:                                 # %sw.bb8
                                        #   in Loop: Header=BB25_6 Depth=1
	movl	$4, %eax
	cmpl	$2, %esi
	je	.LBB25_5
	jmp	.LBB25_10
	.p2align	4, 0x90
.LBB25_4:                               # %if.then13
                                        #   in Loop: Header=BB25_6 Depth=1
	movl	$3, %eax
	jmp	.LBB25_5
.LBB25_10:                              # %sw.bb8
	testl	%esi, %esi
	movl	$-2, %r14d
	jne	.LBB25_26
# BB#11:                                # %if.then10
	callq	handle_compress
	testb	%al, %al
	movl	$1, %eax
	movl	$-2, %r14d
	cmovnel	%eax, %r14d
	jmp	.LBB25_26
.LBB25_25:                              # %sw.epilog
	xorl	%r14d, %r14d
	jmp	.LBB25_26
.LBB25_12:                              # %sw.bb23
	cmpl	$1, %esi
	jne	.LBB25_26
# BB#13:                                # %if.end27
	movl	16(%rbx), %eax
	movq	(%rbx), %rcx
	cmpl	8(%rcx), %eax
	jne	.LBB25_26
# BB#14:                                # %if.end34
	callq	handle_compress
	movl	$2, %r14d
	cmpl	$0, 16(%rbx)
	jne	.LBB25_26
# BB#15:                                # %lor.lhs.false
	movq	%rbx, %rdi
	callq	isempty_RL
	testb	%al, %al
	je	.LBB25_26
# BB#16:                                # %lor.lhs.false41
	movl	120(%rbx), %eax
	cmpl	116(%rbx), %eax
	jl	.LBB25_26
# BB#17:                                # %if.end45
	movl	$2, 8(%rbx)
	movl	$1, %r14d
	jmp	.LBB25_26
.LBB25_18:                              # %sw.bb47
	cmpl	$2, %esi
	jne	.LBB25_26
# BB#19:                                # %if.end51
	movl	16(%rbx), %eax
	movq	(%rbx), %rcx
	cmpl	8(%rcx), %eax
	jne	.LBB25_26
# BB#20:                                # %if.end58
	callq	handle_compress
	testb	%al, %al
	je	.LBB25_26
# BB#21:                                # %if.end62
	movl	$3, %r14d
	cmpl	$0, 16(%rbx)
	jne	.LBB25_26
# BB#22:                                # %lor.lhs.false66
	movq	%rbx, %rdi
	callq	isempty_RL
	testb	%al, %al
	je	.LBB25_26
# BB#23:                                # %lor.lhs.false69
	movl	120(%rbx), %eax
	cmpl	116(%rbx), %eax
	jl	.LBB25_26
# BB#24:                                # %if.end75
	movl	$1, 8(%rbx)
	movl	$4, %r14d
	jmp	.LBB25_26
.Lfunc_end25:
	.size	BZ2_bzCompress, .Lfunc_end25-BZ2_bzCompress
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	3
.LJTI25_0:
	.quad	.LBB25_26
	.quad	.LBB25_8
	.quad	.LBB25_12
	.quad	.LBB25_18

	.text
	.p2align	4, 0x90
	.type	handle_compress,@function
handle_compress:                        # @handle_compress
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi128:
	.cfi_def_cfa_offset 16
.Lcfi129:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi130:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
.Lcfi131:
	.cfi_offset %rbx, -40
.Lcfi132:
	.cfi_offset %r14, -32
.Lcfi133:
	.cfi_offset %r15, -24
	movq	48(%rdi), %rbx
	xorl	%r14d, %r14d
	xorl	%r15d, %r15d
	cmpl	$1, 12(%rbx)
	jne	.LBB26_9
	jmp	.LBB26_2
.LBB26_15:                              # %while.body.outer
                                        #   in Loop: Header=BB26_9 Depth=1
	movq	%rbx, %rdi
	callq	BZ2_compressBlock
	movl	$1, 12(%rbx)
	.p2align	4, 0x90
.LBB26_1:                               # %while.body
                                        #   in Loop: Header=BB26_9 Depth=1
	cmpl	$1, 12(%rbx)
	jne	.LBB26_9
.LBB26_2:                               # %if.then
	movq	%rbx, %rdi
	callq	copy_output_until_stop
	orb	%al, %r15b
	movl	120(%rbx), %eax
	cmpl	116(%rbx), %eax
	jl	.LBB26_17
# BB#3:                                 # %if.end
	cmpl	$4, 8(%rbx)
	jne	.LBB26_6
# BB#4:                                 # %land.lhs.true
	cmpl	$0, 16(%rbx)
	jne	.LBB26_6
# BB#5:                                 # %land.lhs.true11
	movq	%rbx, %rdi
	callq	isempty_RL
	testb	%al, %al
	jne	.LBB26_17
	.p2align	4, 0x90
.LBB26_6:                               # %if.end15
	movq	%rbx, %rdi
	callq	prepare_new_block
	movl	$2, 12(%rbx)
	cmpl	$3, 8(%rbx)
	jne	.LBB26_9
# BB#7:                                 # %land.lhs.true20
	cmpl	$0, 16(%rbx)
	jne	.LBB26_9
# BB#8:                                 # %land.lhs.true24
	movq	%rbx, %rdi
	callq	isempty_RL
	testb	%al, %al
	jne	.LBB26_17
	.p2align	4, 0x90
.LBB26_9:                               # %if.end30
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$2, 12(%rbx)
	jne	.LBB26_1
# BB#10:                                # %if.then34
                                        #   in Loop: Header=BB26_9 Depth=1
	movq	%rbx, %rdi
	callq	copy_input_until_stop
	orb	%al, %r14b
	cmpl	$2, 8(%rbx)
	je	.LBB26_13
# BB#11:                                # %land.lhs.true43
                                        #   in Loop: Header=BB26_9 Depth=1
	cmpl	$0, 16(%rbx)
	je	.LBB26_12
.LBB26_13:                              # %if.else
                                        #   in Loop: Header=BB26_9 Depth=1
	movl	108(%rbx), %eax
	cmpl	112(%rbx), %eax
	jl	.LBB26_16
# BB#14:                                # %if.then55
                                        #   in Loop: Header=BB26_9 Depth=1
	xorl	%esi, %esi
	jmp	.LBB26_15
.LBB26_16:                              # %if.else57
                                        #   in Loop: Header=BB26_9 Depth=1
	movq	(%rbx), %rax
	cmpl	$0, 8(%rax)
	jne	.LBB26_1
	jmp	.LBB26_17
.LBB26_12:                              # %if.then47
                                        #   in Loop: Header=BB26_9 Depth=1
	movq	%rbx, %rdi
	callq	flush_RL
	xorl	%esi, %esi
	cmpl	$4, 8(%rbx)
	sete	%sil
	jmp	.LBB26_15
.LBB26_17:                              # %while.end
	orb	%r15b, %r14b
	setne	%al
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end26:
	.size	handle_compress, .Lfunc_end26-handle_compress
	.cfi_endproc

	.p2align	4, 0x90
	.type	isempty_RL,@function
isempty_RL:                             # @isempty_RL
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi134:
	.cfi_def_cfa_offset 16
.Lcfi135:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi136:
	.cfi_def_cfa_register %rbp
	cmpl	$255, 92(%rdi)
	ja	.LBB27_3
# BB#1:                                 # %land.lhs.true
	cmpl	$0, 96(%rdi)
	jle	.LBB27_3
# BB#2:
	xorl	%eax, %eax
	jmp	.LBB27_4
.LBB27_3:                               # %if.else
	movb	$1, %al
.LBB27_4:                               # %return
                                        # kill: %AL<def> %AL<kill> %EAX<kill>
	popq	%rbp
	retq
.Lfunc_end27:
	.size	isempty_RL, .Lfunc_end27-isempty_RL
	.cfi_endproc

	.globl	BZ2_bzCompressEnd
	.p2align	4, 0x90
	.type	BZ2_bzCompressEnd,@function
BZ2_bzCompressEnd:                      # @BZ2_bzCompressEnd
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi137:
	.cfi_def_cfa_offset 16
.Lcfi138:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi139:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi140:
	.cfi_offset %rbx, -32
.Lcfi141:
	.cfi_offset %r14, -24
	movq	%rdi, %rbx
	movl	$-2, %eax
	testq	%rbx, %rbx
	je	.LBB28_10
# BB#1:                                 # %if.end
	movq	48(%rbx), %r14
	testq	%r14, %r14
	je	.LBB28_10
# BB#2:                                 # %if.end3
	cmpq	%rbx, (%r14)
	jne	.LBB28_10
# BB#3:                                 # %if.end7
	cmpq	$0, 24(%r14)
	je	.LBB28_5
# BB#4:                                 # %if.then9
	movq	72(%rbx), %rdi
	movq	24(%r14), %rsi
	callq	*64(%rbx)
.LBB28_5:                               # %if.end11
	cmpq	$0, 32(%r14)
	je	.LBB28_7
# BB#6:                                 # %if.then13
	movq	72(%rbx), %rdi
	movq	32(%r14), %rsi
	callq	*64(%rbx)
.LBB28_7:                               # %if.end17
	cmpq	$0, 40(%r14)
	je	.LBB28_9
# BB#8:                                 # %if.then19
	movq	72(%rbx), %rdi
	movq	40(%r14), %rsi
	callq	*64(%rbx)
.LBB28_9:                               # %if.end23
	movq	48(%rbx), %rsi
	movq	72(%rbx), %rdi
	callq	*64(%rbx)
	movq	$0, 48(%rbx)
	xorl	%eax, %eax
.LBB28_10:                              # %return
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end28:
	.size	BZ2_bzCompressEnd, .Lfunc_end28-BZ2_bzCompressEnd
	.cfi_endproc

	.globl	BZ2_bzDecompressInit
	.p2align	4, 0x90
	.type	BZ2_bzDecompressInit,@function
BZ2_bzDecompressInit:                   # @BZ2_bzDecompressInit
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi142:
	.cfi_def_cfa_offset 16
.Lcfi143:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi144:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
.Lcfi145:
	.cfi_offset %rbx, -40
.Lcfi146:
	.cfi_offset %r14, -32
.Lcfi147:
	.cfi_offset %r15, -24
	movl	%edx, %r14d
	movl	%esi, %r15d
	movq	%rdi, %rbx
	callq	bz_config_ok
	testl	%eax, %eax
	je	.LBB29_1
# BB#2:                                 # %if.end
	movl	$-2, %eax
	testq	%rbx, %rbx
	je	.LBB29_13
# BB#3:                                 # %if.end
	cmpl	$1, %r14d
	ja	.LBB29_13
# BB#4:                                 # %if.end6
	testl	%r15d, %r15d
	js	.LBB29_13
# BB#5:                                 # %if.end6
	cmpl	$4, %r15d
	jg	.LBB29_13
# BB#6:                                 # %if.end10
	cmpq	$0, 56(%rbx)
	jne	.LBB29_8
# BB#7:                                 # %if.then12
	movq	$default_bzalloc, 56(%rbx)
.LBB29_8:                               # %if.end14
	cmpq	$0, 64(%rbx)
	jne	.LBB29_10
# BB#9:                                 # %if.then16
	movq	$default_bzfree, 64(%rbx)
.LBB29_10:                              # %if.end18
	movq	72(%rbx), %rdi
	movl	$64144, %esi            # imm = 0xFA90
	movl	$1, %edx
	callq	*56(%rbx)
	testq	%rax, %rax
	je	.LBB29_11
# BB#12:                                # %if.end23
	movq	%rbx, (%rax)
	movq	%rax, 48(%rbx)
	movl	$10, 8(%rax)
	movl	$0, 36(%rax)
	movl	$0, 32(%rax)
	movl	$0, 3188(%rax)
	movl	$0, 12(%rbx)
	movl	$0, 16(%rbx)
	movl	$0, 36(%rbx)
	movl	$0, 40(%rbx)
	movb	%r14b, 44(%rax)
	movq	$0, 3168(%rax)
	movq	$0, 3160(%rax)
	movq	$0, 3152(%rax)
	movl	$0, 48(%rax)
	movl	%r15d, 52(%rax)
	xorl	%eax, %eax
	jmp	.LBB29_13
.LBB29_1:
	movl	$-9, %eax
.LBB29_13:                              # %return
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB29_11:
	movl	$-3, %eax
	jmp	.LBB29_13
.Lfunc_end29:
	.size	BZ2_bzDecompressInit, .Lfunc_end29-BZ2_bzDecompressInit
	.cfi_endproc

	.globl	BZ2_bzDecompress
	.p2align	4, 0x90
	.type	BZ2_bzDecompress,@function
BZ2_bzDecompress:                       # @BZ2_bzDecompress
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi148:
	.cfi_def_cfa_offset 16
.Lcfi149:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi150:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi151:
	.cfi_offset %rbx, -32
.Lcfi152:
	.cfi_offset %r14, -24
	movl	$-2, %r14d
	testq	%rdi, %rdi
	je	.LBB30_24
# BB#1:                                 # %if.end
	movq	48(%rdi), %rbx
	testq	%rbx, %rbx
	je	.LBB30_24
# BB#2:                                 # %if.end3
	cmpq	%rdi, (%rbx)
	je	.LBB30_3
.LBB30_24:                              # %return
	movl	%r14d, %eax
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
	.p2align	4, 0x90
.LBB30_3:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$1, 8(%rbx)
	je	.LBB30_4
# BB#5:                                 # %if.end11
                                        #   in Loop: Header=BB30_3 Depth=1
	cmpl	$2, 8(%rbx)
	jne	.LBB30_18
# BB#6:                                 # %if.then14
                                        #   in Loop: Header=BB30_3 Depth=1
	cmpb	$0, 44(%rbx)
	je	.LBB30_8
# BB#7:                                 # %if.then15
                                        #   in Loop: Header=BB30_3 Depth=1
	movq	%rbx, %rdi
	callq	unRLE_obuf_to_output_SMALL
	jmp	.LBB30_9
.LBB30_8:                               # %if.else
                                        #   in Loop: Header=BB30_3 Depth=1
	movq	%rbx, %rdi
	callq	unRLE_obuf_to_output_FAST
.LBB30_9:                               # %if.end16
                                        #   in Loop: Header=BB30_3 Depth=1
	movl	64080(%rbx), %eax
	incl	%eax
	xorl	%r14d, %r14d
	cmpl	%eax, 1092(%rbx)
	jne	.LBB30_24
# BB#10:                                # %land.lhs.true
                                        #   in Loop: Header=BB30_3 Depth=1
	cmpl	$0, 16(%rbx)
	jne	.LBB30_24
# BB#11:                                # %if.then19
                                        #   in Loop: Header=BB30_3 Depth=1
	notl	3184(%rbx)
	cmpl	$3, 52(%rbx)
	jl	.LBB30_13
# BB#12:                                # %if.then22
                                        #   in Loop: Header=BB30_3 Depth=1
	movq	stderr(%rip), %rdi
	movl	3176(%rbx), %edx
	movl	3184(%rbx), %ecx
	movl	$.L.str.8, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB30_13:                              # %if.end24
                                        #   in Loop: Header=BB30_3 Depth=1
	cmpl	$2, 52(%rbx)
	jl	.LBB30_15
# BB#14:                                # %if.then27
                                        #   in Loop: Header=BB30_3 Depth=1
	movq	stderr(%rip), %rdi
	movl	$.L.str.9, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB30_15:                              # %if.end29
                                        #   in Loop: Header=BB30_3 Depth=1
	movl	3184(%rbx), %eax
	cmpl	3176(%rbx), %eax
	jne	.LBB30_16
# BB#17:                                # %if.end34
                                        #   in Loop: Header=BB30_3 Depth=1
	movl	3188(%rbx), %eax
	roll	%eax
	movl	%eax, 3188(%rbx)
	xorl	3184(%rbx), %eax
	movl	%eax, 3188(%rbx)
	movl	$14, 8(%rbx)
.LBB30_18:                              # %if.end42
                                        #   in Loop: Header=BB30_3 Depth=1
	cmpl	$10, 8(%rbx)
	jl	.LBB30_3
# BB#19:                                # %if.then45
                                        #   in Loop: Header=BB30_3 Depth=1
	movq	%rbx, %rdi
	callq	BZ2_decompress
	movl	%eax, %r14d
	cmpl	$4, %r14d
	je	.LBB30_20
# BB#23:                                # %if.end60
                                        #   in Loop: Header=BB30_3 Depth=1
	cmpl	$2, 8(%rbx)
	je	.LBB30_3
	jmp	.LBB30_24
.LBB30_4:
	movl	$-1, %r14d
	jmp	.LBB30_24
.LBB30_20:                              # %if.then48
	cmpl	$3, 52(%rbx)
	jl	.LBB30_22
# BB#21:                                # %if.then51
	movq	stderr(%rip), %rdi
	movl	3180(%rbx), %edx
	movl	3188(%rbx), %ecx
	movl	$.L.str.10, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB30_22:                              # %if.end54
	movl	3188(%rbx), %eax
	cmpl	3180(%rbx), %eax
	movl	$-4, %eax
	cmovnel	%eax, %r14d
	jmp	.LBB30_24
.LBB30_16:
	movl	$-4, %r14d
	jmp	.LBB30_24
.Lfunc_end30:
	.size	BZ2_bzDecompress, .Lfunc_end30-BZ2_bzDecompress
	.cfi_endproc

	.p2align	4, 0x90
	.type	unRLE_obuf_to_output_SMALL,@function
unRLE_obuf_to_output_SMALL:             # @unRLE_obuf_to_output_SMALL
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi153:
	.cfi_def_cfa_offset 16
.Lcfi154:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi155:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi156:
	.cfi_offset %rbx, -32
.Lcfi157:
	.cfi_offset %r14, -24
	movq	%rdi, %rbx
	cmpb	$0, 20(%rbx)
	je	.LBB31_1
# BB#6:                                 # %while.body.preheader
	leaq	1096(%rbx), %r14
	jmp	.LBB31_7
	.p2align	4, 0x90
.LBB31_10:                              # %if.then23
                                        #   in Loop: Header=BB31_7 Depth=1
	movq	(%rbx), %rax
	incl	40(%rax)
.LBB31_7:                               # %while.body2
                                        # =>This Inner Loop Header: Depth=1
	movq	(%rbx), %rax
	cmpl	$0, 32(%rax)
	je	.LBB31_48
# BB#8:                                 # %if.end
                                        #   in Loop: Header=BB31_7 Depth=1
	cmpl	$0, 16(%rbx)
	je	.LBB31_11
# BB#9:                                 # %if.end6
                                        #   in Loop: Header=BB31_7 Depth=1
	movzbl	12(%rbx), %eax
	movq	(%rbx), %rcx
	movq	24(%rcx), %rcx
	movb	%al, (%rcx)
	movl	3184(%rbx), %eax
	movl	%eax, %ecx
	shll	$8, %ecx
	shrl	$24, %eax
	movzbl	12(%rbx), %edx
	xorl	%eax, %edx
	xorl	BZ2_crc32Table(,%rdx,4), %ecx
	movl	%ecx, 3184(%rbx)
	decl	16(%rbx)
	movq	(%rbx), %rax
	incq	24(%rax)
	movq	(%rbx), %rax
	decl	32(%rax)
	movq	(%rbx), %rax
	incl	36(%rax)
	movq	(%rbx), %rax
	cmpl	$0, 36(%rax)
	jne	.LBB31_7
	jmp	.LBB31_10
.LBB31_11:                              # %while.end
                                        #   in Loop: Header=BB31_7 Depth=1
	movl	64080(%rbx), %eax
	incl	%eax
	cmpl	%eax, 1092(%rbx)
	je	.LBB31_48
# BB#12:                                # %if.end30
                                        #   in Loop: Header=BB31_7 Depth=1
	movl	$1, 16(%rbx)
	movzbl	64(%rbx), %eax
	movb	%al, 12(%rbx)
	movl	60(%rbx), %edi
	movq	%r14, %rsi
	callq	BZ2_indexIntoF
	movq	3160(%rbx), %rdx
	movl	60(%rbx), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rbx), %rsi
	movl	%ecx, %edi
	shrl	%edi
	movzbl	(%rsi,%rdi), %esi
	shlb	$2, %cl
	andb	$4, %cl
                                        # kill: %CL<def> %CL<kill> %RCX<kill>
	shrl	%cl, %esi
	andl	$15, %esi
	shll	$16, %esi
	orl	%edx, %esi
	movl	%esi, 60(%rbx)
	cmpl	$0, 24(%rbx)
	jne	.LBB31_15
# BB#13:                                # %if.then52
                                        #   in Loop: Header=BB31_7 Depth=1
	movslq	28(%rbx), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rbx)
	movl	28(%rbx), %ecx
	incl	%ecx
	movl	%ecx, 28(%rbx)
	cmpl	$512, %ecx              # imm = 0x200
	jne	.LBB31_15
# BB#14:                                # %if.then61
                                        #   in Loop: Header=BB31_7 Depth=1
	movl	$0, 28(%rbx)
.LBB31_15:                              # %if.end64
                                        #   in Loop: Header=BB31_7 Depth=1
	movl	24(%rbx), %ecx
	decl	%ecx
	movl	%ecx, 24(%rbx)
	cmpl	$1, %ecx
	sete	%cl
	movl	1092(%rbx), %edx
	leal	1(%rdx), %esi
	movl	%esi, 1092(%rbx)
	cmpl	64080(%rbx), %edx
	je	.LBB31_7
# BB#16:                                # %if.end81
                                        #   in Loop: Header=BB31_7 Depth=1
	xorb	%cl, %al
	movzbl	%al, %eax
	cmpl	64(%rbx), %eax
	je	.LBB31_18
# BB#17:                                # %if.then86
                                        #   in Loop: Header=BB31_7 Depth=1
	movl	%eax, 64(%rbx)
	jmp	.LBB31_7
.LBB31_18:                              # %if.end89
                                        #   in Loop: Header=BB31_7 Depth=1
	movl	$2, 16(%rbx)
	movl	60(%rbx), %edi
	movq	%r14, %rsi
	callq	BZ2_indexIntoF
	movq	3160(%rbx), %rdx
	movl	60(%rbx), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rbx), %rsi
	movl	%ecx, %edi
	shrl	%edi
	movzbl	(%rsi,%rdi), %esi
	shlb	$2, %cl
	andb	$4, %cl
                                        # kill: %CL<def> %CL<kill> %RCX<kill>
	shrl	%cl, %esi
	andl	$15, %esi
	shll	$16, %esi
	orl	%edx, %esi
	movl	%esi, 60(%rbx)
	cmpl	$0, 24(%rbx)
	jne	.LBB31_21
# BB#19:                                # %if.then118
                                        #   in Loop: Header=BB31_7 Depth=1
	movslq	28(%rbx), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rbx)
	movl	28(%rbx), %ecx
	incl	%ecx
	movl	%ecx, 28(%rbx)
	cmpl	$512, %ecx              # imm = 0x200
	jne	.LBB31_21
# BB#20:                                # %if.then128
                                        #   in Loop: Header=BB31_7 Depth=1
	movl	$0, 28(%rbx)
.LBB31_21:                              # %if.end131
                                        #   in Loop: Header=BB31_7 Depth=1
	movl	24(%rbx), %ecx
	decl	%ecx
	movl	%ecx, 24(%rbx)
	cmpl	$1, %ecx
	sete	%cl
	movl	1092(%rbx), %edx
	leal	1(%rdx), %esi
	movl	%esi, 1092(%rbx)
	cmpl	64080(%rbx), %edx
	je	.LBB31_7
# BB#22:                                # %if.end149
                                        #   in Loop: Header=BB31_7 Depth=1
	xorb	%cl, %al
	movzbl	%al, %eax
	cmpl	64(%rbx), %eax
	je	.LBB31_24
# BB#23:                                # %if.then154
                                        #   in Loop: Header=BB31_7 Depth=1
	movl	%eax, 64(%rbx)
	jmp	.LBB31_7
.LBB31_24:                              # %if.end157
                                        #   in Loop: Header=BB31_7 Depth=1
	movl	$3, 16(%rbx)
	movl	60(%rbx), %edi
	movq	%r14, %rsi
	callq	BZ2_indexIntoF
	movq	3160(%rbx), %rdx
	movl	60(%rbx), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rbx), %rsi
	movl	%ecx, %edi
	shrl	%edi
	movzbl	(%rsi,%rdi), %esi
	shlb	$2, %cl
	andb	$4, %cl
                                        # kill: %CL<def> %CL<kill> %RCX<kill>
	shrl	%cl, %esi
	andl	$15, %esi
	shll	$16, %esi
	orl	%edx, %esi
	movl	%esi, 60(%rbx)
	cmpl	$0, 24(%rbx)
	jne	.LBB31_27
# BB#25:                                # %if.then186
                                        #   in Loop: Header=BB31_7 Depth=1
	movslq	28(%rbx), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rbx)
	movl	28(%rbx), %ecx
	incl	%ecx
	movl	%ecx, 28(%rbx)
	cmpl	$512, %ecx              # imm = 0x200
	jne	.LBB31_27
# BB#26:                                # %if.then196
                                        #   in Loop: Header=BB31_7 Depth=1
	movl	$0, 28(%rbx)
.LBB31_27:                              # %if.end199
                                        #   in Loop: Header=BB31_7 Depth=1
	movl	24(%rbx), %ecx
	decl	%ecx
	movl	%ecx, 24(%rbx)
	cmpl	$1, %ecx
	sete	%cl
	movl	1092(%rbx), %edx
	leal	1(%rdx), %esi
	movl	%esi, 1092(%rbx)
	cmpl	64080(%rbx), %edx
	je	.LBB31_7
# BB#28:                                # %if.end217
                                        #   in Loop: Header=BB31_7 Depth=1
	xorb	%cl, %al
	movzbl	%al, %eax
	cmpl	64(%rbx), %eax
	je	.LBB31_30
# BB#29:                                # %if.then222
                                        #   in Loop: Header=BB31_7 Depth=1
	movl	%eax, 64(%rbx)
	jmp	.LBB31_7
.LBB31_30:                              # %if.end225
                                        #   in Loop: Header=BB31_7 Depth=1
	movl	60(%rbx), %edi
	movq	%r14, %rsi
	callq	BZ2_indexIntoF
	movq	3160(%rbx), %rdx
	movl	60(%rbx), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rbx), %rsi
	movl	%ecx, %edi
	shrl	%edi
	movzbl	(%rsi,%rdi), %esi
	shlb	$2, %cl
	andb	$4, %cl
                                        # kill: %CL<def> %CL<kill> %RCX<kill>
	shrl	%cl, %esi
	andl	$15, %esi
	shll	$16, %esi
	orl	%edx, %esi
	movl	%esi, 60(%rbx)
	cmpl	$0, 24(%rbx)
	jne	.LBB31_33
# BB#31:                                # %if.then253
                                        #   in Loop: Header=BB31_7 Depth=1
	movslq	28(%rbx), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rbx)
	movl	28(%rbx), %ecx
	incl	%ecx
	movl	%ecx, 28(%rbx)
	cmpl	$512, %ecx              # imm = 0x200
	jne	.LBB31_33
# BB#32:                                # %if.then263
                                        #   in Loop: Header=BB31_7 Depth=1
	movl	$0, 28(%rbx)
.LBB31_33:                              # %if.end266
                                        #   in Loop: Header=BB31_7 Depth=1
	movl	24(%rbx), %ecx
	decl	%ecx
	movl	%ecx, 24(%rbx)
	cmpl	$1, %ecx
	sete	%cl
	xorb	%cl, %al
	incl	1092(%rbx)
	movzbl	%al, %eax
	addl	$4, %eax
	movl	%eax, 16(%rbx)
	movl	60(%rbx), %edi
	movq	%r14, %rsi
	callq	BZ2_indexIntoF
	movl	%eax, 64(%rbx)
	movq	3160(%rbx), %rax
	movl	60(%rbx), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movq	3168(%rbx), %rdx
	movl	%ecx, %esi
	shrl	%esi
	movzbl	(%rdx,%rsi), %edx
	shlb	$2, %cl
	andb	$4, %cl
                                        # kill: %CL<def> %CL<kill> %RCX<kill>
	shrl	%cl, %edx
	andl	$15, %edx
	shll	$16, %edx
	orl	%eax, %edx
	movl	%edx, 60(%rbx)
	cmpl	$0, 24(%rbx)
	jne	.LBB31_36
# BB#34:                                # %if.then308
                                        #   in Loop: Header=BB31_7 Depth=1
	movslq	28(%rbx), %rax
	movl	BZ2_rNums(,%rax,4), %eax
	movl	%eax, 24(%rbx)
	movl	28(%rbx), %eax
	incl	%eax
	movl	%eax, 28(%rbx)
	cmpl	$512, %eax              # imm = 0x200
	jne	.LBB31_36
# BB#35:                                # %if.then318
                                        #   in Loop: Header=BB31_7 Depth=1
	movl	$0, 28(%rbx)
.LBB31_36:                              # %if.end321
                                        #   in Loop: Header=BB31_7 Depth=1
	movl	24(%rbx), %eax
	decl	%eax
	movl	%eax, 24(%rbx)
	xorl	%ecx, %ecx
	cmpl	$1, %eax
	sete	%cl
	xorl	%ecx, 64(%rbx)
	incl	1092(%rbx)
	jmp	.LBB31_7
.LBB31_1:
	leaq	1096(%rbx), %r14
	jmp	.LBB31_2
	.p2align	4, 0x90
.LBB31_5:                               # %if.then375
                                        #   in Loop: Header=BB31_2 Depth=1
	movq	(%rbx), %rax
	incl	40(%rax)
.LBB31_2:                               # %while.body334
                                        # =>This Inner Loop Header: Depth=1
	movq	(%rbx), %rax
	cmpl	$0, 32(%rax)
	je	.LBB31_48
# BB#3:                                 # %if.end340
                                        #   in Loop: Header=BB31_2 Depth=1
	cmpl	$0, 16(%rbx)
	je	.LBB31_37
# BB#4:                                 # %if.end345
                                        #   in Loop: Header=BB31_2 Depth=1
	movzbl	12(%rbx), %eax
	movq	(%rbx), %rcx
	movq	24(%rcx), %rcx
	movb	%al, (%rcx)
	movl	3184(%rbx), %eax
	movl	%eax, %ecx
	shll	$8, %ecx
	shrl	$24, %eax
	movzbl	12(%rbx), %edx
	xorl	%eax, %edx
	xorl	BZ2_crc32Table(,%rdx,4), %ecx
	movl	%ecx, 3184(%rbx)
	decl	16(%rbx)
	movq	(%rbx), %rax
	incq	24(%rax)
	movq	(%rbx), %rax
	decl	32(%rax)
	movq	(%rbx), %rax
	incl	36(%rax)
	movq	(%rbx), %rax
	cmpl	$0, 36(%rax)
	jne	.LBB31_2
	jmp	.LBB31_5
.LBB31_37:                              # %while.end380
                                        #   in Loop: Header=BB31_2 Depth=1
	movl	64080(%rbx), %eax
	incl	%eax
	cmpl	%eax, 1092(%rbx)
	je	.LBB31_48
# BB#38:                                # %if.end387
                                        #   in Loop: Header=BB31_2 Depth=1
	movl	$1, 16(%rbx)
	movzbl	64(%rbx), %eax
	movb	%al, 12(%rbx)
	movl	60(%rbx), %edi
	movq	%r14, %rsi
	callq	BZ2_indexIntoF
	movq	3160(%rbx), %rdx
	movl	60(%rbx), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rbx), %rsi
	movl	%ecx, %edi
	shrl	%edi
	movzbl	(%rsi,%rdi), %esi
	shlb	$2, %cl
	andb	$4, %cl
                                        # kill: %CL<def> %CL<kill> %RCX<kill>
	shrl	%cl, %esi
	andl	$15, %esi
	shll	$16, %esi
	orl	%edx, %esi
	movl	%esi, 60(%rbx)
	movl	1092(%rbx), %ecx
	leal	1(%rcx), %edx
	movl	%edx, 1092(%rbx)
	cmpl	64080(%rbx), %ecx
	je	.LBB31_2
# BB#39:                                # %if.end424
                                        #   in Loop: Header=BB31_2 Depth=1
	movzbl	%al, %eax
	cmpl	64(%rbx), %eax
	je	.LBB31_41
# BB#40:                                # %if.then429
                                        #   in Loop: Header=BB31_2 Depth=1
	movl	%eax, 64(%rbx)
	jmp	.LBB31_2
.LBB31_41:                              # %if.end432
                                        #   in Loop: Header=BB31_2 Depth=1
	movl	$2, 16(%rbx)
	movl	60(%rbx), %edi
	movq	%r14, %rsi
	callq	BZ2_indexIntoF
	movq	3160(%rbx), %rdx
	movl	60(%rbx), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rbx), %rsi
	movl	%ecx, %edi
	shrl	%edi
	movzbl	(%rsi,%rdi), %esi
	shlb	$2, %cl
	andb	$4, %cl
                                        # kill: %CL<def> %CL<kill> %RCX<kill>
	shrl	%cl, %esi
	andl	$15, %esi
	shll	$16, %esi
	orl	%edx, %esi
	movl	%esi, 60(%rbx)
	movl	1092(%rbx), %ecx
	leal	1(%rcx), %edx
	movl	%edx, 1092(%rbx)
	cmpl	64080(%rbx), %ecx
	je	.LBB31_2
# BB#42:                                # %if.end466
                                        #   in Loop: Header=BB31_2 Depth=1
	movzbl	%al, %eax
	cmpl	64(%rbx), %eax
	je	.LBB31_44
# BB#43:                                # %if.then471
                                        #   in Loop: Header=BB31_2 Depth=1
	movl	%eax, 64(%rbx)
	jmp	.LBB31_2
.LBB31_44:                              # %if.end474
                                        #   in Loop: Header=BB31_2 Depth=1
	movl	$3, 16(%rbx)
	movl	60(%rbx), %edi
	movq	%r14, %rsi
	callq	BZ2_indexIntoF
	movq	3160(%rbx), %rdx
	movl	60(%rbx), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rbx), %rsi
	movl	%ecx, %edi
	shrl	%edi
	movzbl	(%rsi,%rdi), %esi
	shlb	$2, %cl
	andb	$4, %cl
                                        # kill: %CL<def> %CL<kill> %RCX<kill>
	shrl	%cl, %esi
	andl	$15, %esi
	shll	$16, %esi
	orl	%edx, %esi
	movl	%esi, 60(%rbx)
	movl	1092(%rbx), %ecx
	leal	1(%rcx), %edx
	movl	%edx, 1092(%rbx)
	cmpl	64080(%rbx), %ecx
	je	.LBB31_2
# BB#45:                                # %if.end508
                                        #   in Loop: Header=BB31_2 Depth=1
	movzbl	%al, %eax
	cmpl	64(%rbx), %eax
	je	.LBB31_47
# BB#46:                                # %if.then513
                                        #   in Loop: Header=BB31_2 Depth=1
	movl	%eax, 64(%rbx)
	jmp	.LBB31_2
.LBB31_47:                              # %if.end516
                                        #   in Loop: Header=BB31_2 Depth=1
	movl	60(%rbx), %edi
	movq	%r14, %rsi
	callq	BZ2_indexIntoF
	movq	3160(%rbx), %rdx
	movl	60(%rbx), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rbx), %rsi
	movl	%ecx, %edi
	shrl	%edi
	movzbl	(%rsi,%rdi), %esi
	shlb	$2, %cl
	andb	$4, %cl
                                        # kill: %CL<def> %CL<kill> %RCX<kill>
	shrl	%cl, %esi
	andl	$15, %esi
	shll	$16, %esi
	orl	%edx, %esi
	movl	%esi, 60(%rbx)
	incl	1092(%rbx)
	movzbl	%al, %eax
	addl	$4, %eax
	movl	%eax, 16(%rbx)
	movl	60(%rbx), %edi
	movq	%r14, %rsi
	callq	BZ2_indexIntoF
	movl	%eax, 64(%rbx)
	movq	3160(%rbx), %rax
	movl	60(%rbx), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movq	3168(%rbx), %rdx
	movl	%ecx, %esi
	shrl	%esi
	movzbl	(%rdx,%rsi), %edx
	shlb	$2, %cl
	andb	$4, %cl
                                        # kill: %CL<def> %CL<kill> %RCX<kill>
	shrl	%cl, %edx
	andl	$15, %edx
	shll	$16, %edx
	orl	%eax, %edx
	movl	%edx, 60(%rbx)
	incl	1092(%rbx)
	jmp	.LBB31_2
.LBB31_48:                              # %return
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end31:
	.size	unRLE_obuf_to_output_SMALL, .Lfunc_end31-unRLE_obuf_to_output_SMALL
	.cfi_endproc

	.p2align	4, 0x90
	.type	unRLE_obuf_to_output_FAST,@function
unRLE_obuf_to_output_FAST:              # @unRLE_obuf_to_output_FAST
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi158:
	.cfi_def_cfa_offset 16
.Lcfi159:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi160:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
.Lcfi161:
	.cfi_offset %rbx, -56
.Lcfi162:
	.cfi_offset %r12, -48
.Lcfi163:
	.cfi_offset %r13, -40
.Lcfi164:
	.cfi_offset %r14, -32
.Lcfi165:
	.cfi_offset %r15, -24
	cmpb	$0, 20(%rdi)
	jne	.LBB32_3
# BB#1:                                 # %if.else
	movl	3184(%rdi), %r9d
	movb	12(%rdi), %bl
	movl	16(%rdi), %eax
	movl	1092(%rdi), %r12d
	movl	64(%rdi), %r14d
	movq	3152(%rdi), %r8
	movl	60(%rdi), %r13d
	movq	(%rdi), %rdx
	movq	24(%rdx), %rcx
	movl	32(%rdx), %r10d
	movl	64080(%rdi), %r11d
	incl	%r11d
	movl	%r10d, -48(%rbp)        # 4-byte Spill
	movq	%r8, -56(%rbp)          # 8-byte Spill
	testl	%eax, %eax
	jg	.LBB32_34
	jmp	.LBB32_38
	.p2align	4, 0x90
.LBB32_2:                               # %if.then23
                                        #   in Loop: Header=BB32_3 Depth=1
	movq	(%rdi), %rax
	incl	40(%rax)
.LBB32_3:                               # %while.body2
                                        # =>This Inner Loop Header: Depth=1
	movq	(%rdi), %rax
	cmpl	$0, 32(%rax)
	je	.LBB32_55
# BB#4:                                 # %if.end
                                        #   in Loop: Header=BB32_3 Depth=1
	cmpl	$0, 16(%rdi)
	je	.LBB32_6
# BB#5:                                 # %if.end6
                                        #   in Loop: Header=BB32_3 Depth=1
	movzbl	12(%rdi), %eax
	movq	(%rdi), %rcx
	movq	24(%rcx), %rcx
	movb	%al, (%rcx)
	movl	3184(%rdi), %eax
	movl	%eax, %ecx
	shll	$8, %ecx
	shrl	$24, %eax
	movzbl	12(%rdi), %edx
	xorl	%eax, %edx
	xorl	BZ2_crc32Table(,%rdx,4), %ecx
	movl	%ecx, 3184(%rdi)
	decl	16(%rdi)
	movq	(%rdi), %rax
	incq	24(%rax)
	movq	(%rdi), %rax
	decl	32(%rax)
	movq	(%rdi), %rax
	incl	36(%rax)
	movq	(%rdi), %rax
	cmpl	$0, 36(%rax)
	jne	.LBB32_3
	jmp	.LBB32_2
.LBB32_6:                               # %while.end
                                        #   in Loop: Header=BB32_3 Depth=1
	movl	64080(%rdi), %eax
	incl	%eax
	cmpl	%eax, 1092(%rdi)
	je	.LBB32_55
# BB#7:                                 # %if.end30
                                        #   in Loop: Header=BB32_3 Depth=1
	movl	$1, 16(%rdi)
	movzbl	64(%rdi), %eax
	movb	%al, 12(%rdi)
	movq	3152(%rdi), %rax
	movl	60(%rdi), %ecx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, 60(%rdi)
	movl	%eax, %ecx
	shrl	$8, %ecx
	movl	%ecx, 60(%rdi)
	cmpl	$0, 24(%rdi)
	jne	.LBB32_10
# BB#8:                                 # %if.then43
                                        #   in Loop: Header=BB32_3 Depth=1
	movslq	28(%rdi), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rdi)
	movl	28(%rdi), %ecx
	incl	%ecx
	movl	%ecx, 28(%rdi)
	cmpl	$512, %ecx              # imm = 0x200
	jne	.LBB32_10
# BB#9:                                 # %if.then52
                                        #   in Loop: Header=BB32_3 Depth=1
	movl	$0, 28(%rdi)
.LBB32_10:                              # %if.end55
                                        #   in Loop: Header=BB32_3 Depth=1
	movl	24(%rdi), %ecx
	decl	%ecx
	movl	%ecx, 24(%rdi)
	cmpl	$1, %ecx
	sete	%cl
	movl	1092(%rdi), %edx
	leal	1(%rdx), %esi
	movl	%esi, 1092(%rdi)
	cmpl	64080(%rdi), %edx
	je	.LBB32_3
# BB#11:                                # %if.end72
                                        #   in Loop: Header=BB32_3 Depth=1
	xorb	%cl, %al
	movzbl	%al, %eax
	cmpl	64(%rdi), %eax
	je	.LBB32_13
# BB#12:                                # %if.then77
                                        #   in Loop: Header=BB32_3 Depth=1
	movl	%eax, 64(%rdi)
	jmp	.LBB32_3
.LBB32_13:                              # %if.end80
                                        #   in Loop: Header=BB32_3 Depth=1
	movl	$2, 16(%rdi)
	movq	3152(%rdi), %rax
	movl	60(%rdi), %ecx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, 60(%rdi)
	movl	%eax, %ecx
	shrl	$8, %ecx
	movl	%ecx, 60(%rdi)
	cmpl	$0, 24(%rdi)
	jne	.LBB32_16
# BB#14:                                # %if.then95
                                        #   in Loop: Header=BB32_3 Depth=1
	movslq	28(%rdi), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rdi)
	movl	28(%rdi), %ecx
	incl	%ecx
	movl	%ecx, 28(%rdi)
	cmpl	$512, %ecx              # imm = 0x200
	jne	.LBB32_16
# BB#15:                                # %if.then105
                                        #   in Loop: Header=BB32_3 Depth=1
	movl	$0, 28(%rdi)
.LBB32_16:                              # %if.end108
                                        #   in Loop: Header=BB32_3 Depth=1
	movl	24(%rdi), %ecx
	decl	%ecx
	movl	%ecx, 24(%rdi)
	cmpl	$1, %ecx
	sete	%cl
	movl	1092(%rdi), %edx
	leal	1(%rdx), %esi
	movl	%esi, 1092(%rdi)
	cmpl	64080(%rdi), %edx
	je	.LBB32_3
# BB#17:                                # %if.end126
                                        #   in Loop: Header=BB32_3 Depth=1
	xorb	%cl, %al
	movzbl	%al, %eax
	cmpl	64(%rdi), %eax
	je	.LBB32_19
# BB#18:                                # %if.then131
                                        #   in Loop: Header=BB32_3 Depth=1
	movl	%eax, 64(%rdi)
	jmp	.LBB32_3
.LBB32_19:                              # %if.end134
                                        #   in Loop: Header=BB32_3 Depth=1
	movl	$3, 16(%rdi)
	movq	3152(%rdi), %rax
	movl	60(%rdi), %ecx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, 60(%rdi)
	movl	%eax, %ecx
	shrl	$8, %ecx
	movl	%ecx, 60(%rdi)
	cmpl	$0, 24(%rdi)
	jne	.LBB32_22
# BB#20:                                # %if.then149
                                        #   in Loop: Header=BB32_3 Depth=1
	movslq	28(%rdi), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rdi)
	movl	28(%rdi), %ecx
	incl	%ecx
	movl	%ecx, 28(%rdi)
	cmpl	$512, %ecx              # imm = 0x200
	jne	.LBB32_22
# BB#21:                                # %if.then159
                                        #   in Loop: Header=BB32_3 Depth=1
	movl	$0, 28(%rdi)
.LBB32_22:                              # %if.end162
                                        #   in Loop: Header=BB32_3 Depth=1
	movl	24(%rdi), %ecx
	decl	%ecx
	movl	%ecx, 24(%rdi)
	cmpl	$1, %ecx
	sete	%cl
	movl	1092(%rdi), %edx
	leal	1(%rdx), %esi
	movl	%esi, 1092(%rdi)
	cmpl	64080(%rdi), %edx
	je	.LBB32_3
# BB#23:                                # %if.end180
                                        #   in Loop: Header=BB32_3 Depth=1
	xorb	%cl, %al
	movzbl	%al, %eax
	cmpl	64(%rdi), %eax
	je	.LBB32_25
# BB#24:                                # %if.then185
                                        #   in Loop: Header=BB32_3 Depth=1
	movl	%eax, 64(%rdi)
	jmp	.LBB32_3
.LBB32_25:                              # %if.end188
                                        #   in Loop: Header=BB32_3 Depth=1
	movq	3152(%rdi), %rax
	movl	60(%rdi), %ecx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, 60(%rdi)
	movl	%eax, %ecx
	shrl	$8, %ecx
	movl	%ecx, 60(%rdi)
	cmpl	$0, 24(%rdi)
	jne	.LBB32_28
# BB#26:                                # %if.then202
                                        #   in Loop: Header=BB32_3 Depth=1
	movslq	28(%rdi), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rdi)
	movl	28(%rdi), %ecx
	incl	%ecx
	movl	%ecx, 28(%rdi)
	cmpl	$512, %ecx              # imm = 0x200
	jne	.LBB32_28
# BB#27:                                # %if.then212
                                        #   in Loop: Header=BB32_3 Depth=1
	movl	$0, 28(%rdi)
.LBB32_28:                              # %if.end215
                                        #   in Loop: Header=BB32_3 Depth=1
	movl	24(%rdi), %ecx
	decl	%ecx
	movl	%ecx, 24(%rdi)
	cmpl	$1, %ecx
	sete	%cl
	xorb	%al, %cl
	incl	1092(%rdi)
	movzbl	%cl, %eax
	addl	$4, %eax
	movl	%eax, 16(%rdi)
	movq	3152(%rdi), %rax
	movl	60(%rdi), %ecx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, 60(%rdi)
	movzbl	60(%rdi), %eax
	movl	%eax, 64(%rdi)
	shrl	$8, 60(%rdi)
	cmpl	$0, 24(%rdi)
	jne	.LBB32_31
# BB#29:                                # %if.then245
                                        #   in Loop: Header=BB32_3 Depth=1
	movslq	28(%rdi), %rax
	movl	BZ2_rNums(,%rax,4), %eax
	movl	%eax, 24(%rdi)
	movl	28(%rdi), %eax
	incl	%eax
	movl	%eax, 28(%rdi)
	cmpl	$512, %eax              # imm = 0x200
	jne	.LBB32_31
# BB#30:                                # %if.then255
                                        #   in Loop: Header=BB32_3 Depth=1
	movl	$0, 28(%rdi)
.LBB32_31:                              # %if.end258
                                        #   in Loop: Header=BB32_3 Depth=1
	movl	24(%rdi), %eax
	decl	%eax
	movl	%eax, 24(%rdi)
	xorl	%ecx, %ecx
	cmpl	$1, %eax
	sete	%cl
	xorl	%ecx, 64(%rdi)
	incl	1092(%rdi)
	jmp	.LBB32_3
	.p2align	4, 0x90
.LBB32_35:                              # %if.end295
                                        #   in Loop: Header=BB32_36 Depth=1
	movb	%bl, (%rcx,%rdx)
	movl	%r9d, %eax
	shll	$8, %eax
	shrl	$24, %r9d
	movzbl	%bl, %r15d
	xorl	%r9d, %r15d
	xorl	BZ2_crc32Table(,%r15,4), %eax
	incq	%rdx
	movl	%eax, %r9d
	cmpl	%edx, %r8d
	jne	.LBB32_36
	jmp	.LBB32_51
	.p2align	4, 0x90
.LBB32_37:                              # %s_state_out_len_eq_one.loopexit
	addq	%rdx, %rcx
	subl	%edx, %r10d
	movq	-56(%rbp), %r8          # 8-byte Reload
	testl	%r10d, %r10d
	je	.LBB32_57
	.p2align	4, 0x90
.LBB32_39:                              # %if.end310
	movb	%bl, (%rcx)
	movl	%r9d, %eax
	shll	$8, %eax
	shrl	$24, %r9d
	movzbl	%bl, %edx
	xorl	%r9d, %edx
	xorl	BZ2_crc32Table(,%rdx,4), %eax
	incq	%rcx
	decl	%r10d
	movl	%r14d, %edx
	movl	%eax, %r9d
	cmpl	%r11d, %r12d
	je	.LBB32_56
.LBB32_40:                              # %if.end324
	movl	%r13d, %eax
	movl	(%r8,%rax,4), %esi
	movzbl	%sil, %eax
	movl	%esi, %r13d
	shrl	$8, %r13d
	incl	%r12d
	cmpl	%edx, %eax
	je	.LBB32_43
# BB#41:                                # %if.then335
	movzbl	%sil, %r14d
	jmp	.LBB32_42
	.p2align	4, 0x90
.LBB32_43:                              # %if.end337
	cmpl	%r11d, %r12d
	jne	.LBB32_45
# BB#44:
	movl	%edx, %r14d
.LBB32_42:                              # %if.then335
	movl	%edx, %ebx
	testl	%r10d, %r10d
	jne	.LBB32_39
	jmp	.LBB32_57
	.p2align	4, 0x90
.LBB32_45:                              # %if.end341
	movl	%r13d, %eax
	movl	(%r8,%rax,4), %esi
	movl	%esi, %r13d
	shrl	$8, %r13d
	incl	%r12d
	movl	$2, %eax
	cmpl	%r11d, %r12d
	movl	%edx, %r14d
	movl	%edx, %ebx
	je	.LBB32_33
# BB#46:                                # %if.end351
	movzbl	%sil, %r14d
	cmpl	%edx, %r14d
	jne	.LBB32_32
# BB#47:                                # %if.end357
	movl	%r13d, %eax
	movl	(%r8,%rax,4), %esi
	movl	%esi, %r13d
	shrl	$8, %r13d
	incl	%r12d
	movl	$3, %eax
	cmpl	%r11d, %r12d
	movl	%edx, %r14d
	movl	%edx, %ebx
	je	.LBB32_33
# BB#48:                                # %if.end367
	movzbl	%sil, %r14d
	cmpl	%edx, %r14d
	je	.LBB32_50
# BB#49:                                # %if.then371
	movl	%edx, %ebx
	movl	$3, %eax
	testl	%eax, %eax
	jg	.LBB32_34
	jmp	.LBB32_38
.LBB32_50:                              # %if.end373
	movl	%r13d, %eax
	movl	(%r8,%rax,4), %esi
	movzbl	%sil, %eax
                                        # kill: %ESI<def> %ESI<kill> %RSI<def>
	shrl	$8, %esi
	addl	$4, %eax
	movl	(%r8,%rsi,4), %r13d
	movzbl	%r13b, %r14d
	shrl	$8, %r13d
	addl	$2, %r12d
	movl	%edx, %ebx
	testl	%eax, %eax
	jg	.LBB32_34
	jmp	.LBB32_38
.LBB32_32:                              # %if.then355
	movl	%edx, %ebx
	movl	$2, %eax
	testl	%eax, %eax
	jg	.LBB32_34
	.p2align	4, 0x90
.LBB32_38:
	movl	%r14d, %edx
	cmpl	%r11d, %r12d
	jne	.LBB32_40
	jmp	.LBB32_56
	.p2align	4, 0x90
.LBB32_33:                              # %while.body282
	testl	%eax, %eax
	jle	.LBB32_38
.LBB32_34:                              # %while.body287.preheader
	movl	%eax, -44(%rbp)         # 4-byte Spill
	movl	%eax, %esi
	decq	%rsi
	movl	%r10d, %r8d
	xorl	%edx, %edx
	cmpl	%edx, %r8d
	je	.LBB32_51
	.p2align	4, 0x90
.LBB32_36:                              # %if.end291
                                        # =>This Inner Loop Header: Depth=1
	cmpl	%edx, %esi
	jne	.LBB32_35
	jmp	.LBB32_37
.LBB32_51:                              # %return_notr.loopexit
	addq	%rdx, %rcx
	subl	%edx, -44(%rbp)         # 4-byte Folded Spill
	subl	%edx, %r10d
	movq	-56(%rbp), %r8          # 8-byte Reload
.LBB32_52:                              # %return_notr
	movq	(%rdi), %rax
	movl	36(%rax), %edx
	movl	-48(%rbp), %esi         # 4-byte Reload
	subl	%r10d, %esi
	addl	%edx, %esi
	movl	%esi, 36(%rax)
	movq	(%rdi), %rax
	cmpl	%edx, 36(%rax)
	jae	.LBB32_54
# BB#53:                                # %if.then398
	movq	(%rdi), %rax
	incl	40(%rax)
.LBB32_54:                              # %if.end402
	movl	%r9d, 3184(%rdi)
	movb	%bl, 12(%rdi)
	movl	-44(%rbp), %eax         # 4-byte Reload
	movl	%eax, 16(%rdi)
	movl	%r12d, 1092(%rdi)
	movl	%r14d, 64(%rdi)
	movq	%r8, 3152(%rdi)
	movl	%r13d, 60(%rdi)
	movq	(%rdi), %rax
	movq	%rcx, 24(%rax)
	movq	(%rdi), %rax
	movl	%r10d, 32(%rax)
.LBB32_55:                              # %if.end414
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB32_57:
	movl	$1, -44(%rbp)           # 4-byte Folded Spill
	jmp	.LBB32_52
.LBB32_56:
	movl	$0, -44(%rbp)           # 4-byte Folded Spill
	movl	%edx, %r14d
	jmp	.LBB32_52
.Lfunc_end32:
	.size	unRLE_obuf_to_output_FAST, .Lfunc_end32-unRLE_obuf_to_output_FAST
	.cfi_endproc

	.globl	BZ2_bzDecompressEnd
	.p2align	4, 0x90
	.type	BZ2_bzDecompressEnd,@function
BZ2_bzDecompressEnd:                    # @BZ2_bzDecompressEnd
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi166:
	.cfi_def_cfa_offset 16
.Lcfi167:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi168:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi169:
	.cfi_offset %rbx, -32
.Lcfi170:
	.cfi_offset %r14, -24
	movq	%rdi, %rbx
	movl	$-2, %eax
	testq	%rbx, %rbx
	je	.LBB33_10
# BB#1:                                 # %if.end
	movq	48(%rbx), %r14
	testq	%r14, %r14
	je	.LBB33_10
# BB#2:                                 # %if.end3
	cmpq	%rbx, (%r14)
	jne	.LBB33_10
# BB#3:                                 # %if.end7
	cmpq	$0, 3152(%r14)
	je	.LBB33_5
# BB#4:                                 # %if.then9
	movq	72(%rbx), %rdi
	movq	3152(%r14), %rsi
	callq	*64(%rbx)
.LBB33_5:                               # %if.end11
	cmpq	$0, 3160(%r14)
	je	.LBB33_7
# BB#6:                                 # %if.then13
	movq	72(%rbx), %rdi
	movq	3160(%r14), %rsi
	callq	*64(%rbx)
.LBB33_7:                               # %if.end17
	cmpq	$0, 3168(%r14)
	je	.LBB33_9
# BB#8:                                 # %if.then19
	movq	72(%rbx), %rdi
	movq	3168(%r14), %rsi
	callq	*64(%rbx)
.LBB33_9:                               # %if.end23
	movq	48(%rbx), %rsi
	movq	72(%rbx), %rdi
	callq	*64(%rbx)
	movq	$0, 48(%rbx)
	xorl	%eax, %eax
.LBB33_10:                              # %return
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end33:
	.size	BZ2_bzDecompressEnd, .Lfunc_end33-BZ2_bzDecompressEnd
	.cfi_endproc

	.globl	BZ2_bzWriteOpen
	.p2align	4, 0x90
	.type	BZ2_bzWriteOpen,@function
BZ2_bzWriteOpen:                        # @BZ2_bzWriteOpen
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi171:
	.cfi_def_cfa_offset 16
.Lcfi172:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi173:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
.Lcfi174:
	.cfi_offset %rbx, -56
.Lcfi175:
	.cfi_offset %r12, -48
.Lcfi176:
	.cfi_offset %r13, -40
.Lcfi177:
	.cfi_offset %r14, -32
.Lcfi178:
	.cfi_offset %r15, -24
	movl	%r8d, %r13d
	movl	%ecx, %ebx
	movl	%edx, %r12d
	movq	%rsi, %r14
	movq	%rdi, %r15
	testq	%r15, %r15
	je	.LBB34_2
# BB#1:                                 # %if.then
	movl	$0, (%r15)
.LBB34_2:                               # %if.end3
	testq	%r14, %r14
	je	.LBB34_12
# BB#3:                                 # %if.end3
	testl	%r12d, %r12d
	jle	.LBB34_12
# BB#4:                                 # %if.end3
	cmpl	$9, %r12d
	jg	.LBB34_12
# BB#5:                                 # %if.end3
	testl	%r13d, %r13d
	js	.LBB34_12
# BB#6:                                 # %if.end3
	cmpl	$250, %r13d
	jg	.LBB34_12
# BB#7:                                 # %if.end3
	testl	%ebx, %ebx
	js	.LBB34_12
# BB#8:                                 # %if.end3
	cmpl	$5, %ebx
	jge	.LBB34_12
# BB#9:                                 # %if.end24
	movq	%r14, %rdi
	callq	ferror
	testl	%eax, %eax
	je	.LBB34_14
# BB#10:                                # %if.then25
	testq	%r15, %r15
	je	.LBB34_32
# BB#11:                                # %if.then27
	movl	$-6, (%r15)
	jmp	.LBB34_32
.LBB34_12:                              # %if.then16
	testq	%r15, %r15
	je	.LBB34_32
# BB#13:                                # %if.then18
	movl	$-2, (%r15)
.LBB34_32:
	xorl	%r14d, %r14d
.LBB34_33:                              # %return
	movq	%r14, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB34_14:                              # %if.end33
	movq	%r14, -48(%rbp)         # 8-byte Spill
	movl	$5104, %edi             # imm = 0x13F0
	callq	malloc
	movq	%rax, %r14
	testq	%r14, %r14
	je	.LBB34_27
# BB#15:                                # %if.end44
	testq	%r15, %r15
	je	.LBB34_17
# BB#16:                                # %if.then46
	movl	$0, (%r15)
.LBB34_17:                              # %if.end47
	testq	%r14, %r14
	je	.LBB34_19
# BB#18:                                # %if.then49
	movl	$0, 5096(%r14)
.LBB34_19:                              # %if.end51
	movb	$0, 5100(%r14)
	movl	$0, 5008(%r14)
	movq	-48(%rbp), %rax         # 8-byte Reload
	movq	%rax, (%r14)
	movb	$1, 5012(%r14)
	leaq	5016(%r14), %rdi
	xorps	%xmm0, %xmm0
	movups	%xmm0, 5072(%r14)
	movq	$0, 5088(%r14)
	testl	%r13d, %r13d
	movl	$30, %ecx
	cmovnel	%r13d, %ecx
	movl	%r12d, %esi
	movl	%ebx, %edx
	callq	BZ2_bzCompressInit
	testl	%eax, %eax
	je	.LBB34_31
# BB#20:                                # %if.then60
	testq	%r15, %r15
	je	.LBB34_22
# BB#21:                                # %if.then62
	movl	%eax, (%r15)
.LBB34_22:                              # %if.end63
	testq	%r14, %r14
	je	.LBB34_24
# BB#23:                                # %if.then65
	movl	%eax, 5096(%r14)
.LBB34_24:                              # %if.end67
	movq	%r14, %rdi
	callq	free
	jmp	.LBB34_32
.LBB34_27:                              # %if.then36
	testq	%r15, %r15
	je	.LBB34_29
# BB#28:                                # %if.then38
	movl	$-3, (%r15)
.LBB34_29:                              # %if.end39
	testq	%r14, %r14
	je	.LBB34_32
# BB#30:                                # %if.then41
	movl	$-3, 5096(%r14)
	jmp	.LBB34_32
.LBB34_31:                              # %if.end68
	movl	$0, 5024(%r14)
	movb	$1, 5100(%r14)
	jmp	.LBB34_33
.Lfunc_end34:
	.size	BZ2_bzWriteOpen, .Lfunc_end34-BZ2_bzWriteOpen
	.cfi_endproc

	.globl	BZ2_bzWrite
	.p2align	4, 0x90
	.type	BZ2_bzWrite,@function
BZ2_bzWrite:                            # @BZ2_bzWrite
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi179:
	.cfi_def_cfa_offset 16
.Lcfi180:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi181:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
.Lcfi182:
	.cfi_offset %rbx, -56
.Lcfi183:
	.cfi_offset %r12, -48
.Lcfi184:
	.cfi_offset %r13, -40
.Lcfi185:
	.cfi_offset %r14, -32
.Lcfi186:
	.cfi_offset %r15, -24
	movl	%ecx, %r12d
	movq	%rdx, %r15
	movq	%rsi, %rbx
	movq	%rdi, %r14
	testq	%r14, %r14
	je	.LBB35_2
# BB#1:                                 # %if.then
	movl	$0, (%r14)
.LBB35_2:                               # %if.end
	testq	%rbx, %rbx
	je	.LBB35_6
# BB#3:                                 # %if.then2
	movl	$0, 5096(%rbx)
	je	.LBB35_6
# BB#4:                                 # %if.then2
	testq	%r15, %r15
	je	.LBB35_6
# BB#5:                                 # %if.then2
	testl	%r12d, %r12d
	js	.LBB35_6
# BB#10:                                # %if.end16
	cmpb	$0, 5012(%rbx)
	je	.LBB35_11
# BB#15:                                # %if.end25
	movq	(%rbx), %rdi
	callq	ferror
	testl	%eax, %eax
	je	.LBB35_20
# BB#16:                                # %if.then27
	testq	%r14, %r14
	je	.LBB35_18
# BB#17:                                # %if.then29
	movl	$-6, (%r14)
.LBB35_18:                              # %if.end30
	testq	%rbx, %rbx
	je	.LBB35_39
# BB#19:                                # %if.then32
	movl	$-6, 5096(%rbx)
	jmp	.LBB35_39
.LBB35_6:                               # %if.then8
	testq	%r14, %r14
	je	.LBB35_8
# BB#7:                                 # %if.then10
	movl	$-2, (%r14)
.LBB35_8:                               # %if.end11
	testq	%rbx, %rbx
	je	.LBB35_39
# BB#9:                                 # %if.then13
	movl	$-2, 5096(%rbx)
.LBB35_39:                              # %return
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB35_11:                              # %if.then17
	testq	%r14, %r14
	je	.LBB35_13
# BB#12:                                # %if.then19
	movl	$-1, (%r14)
.LBB35_13:                              # %if.end20
	testq	%rbx, %rbx
	je	.LBB35_39
# BB#14:                                # %if.then22
	movl	$-1, 5096(%rbx)
	jmp	.LBB35_39
.LBB35_20:                              # %if.end35
	testl	%r12d, %r12d
	je	.LBB35_35
# BB#21:                                # %if.end45
	movl	%r12d, 5024(%rbx)
	movq	%r15, 5016(%rbx)
	leaq	5016(%rbx), %r15
	leaq	8(%rbx), %r12
	.p2align	4, 0x90
.LBB35_22:                              # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movl	$5000, 5048(%rbx)       # imm = 0x1388
	movq	%r12, 5040(%rbx)
	xorl	%esi, %esi
	movq	%r15, %rdi
	callq	BZ2_bzCompress
	cmpl	$1, %eax
	jne	.LBB35_23
# BB#27:                                # %if.end61
                                        #   in Loop: Header=BB35_22 Depth=1
	cmpl	$4999, 5048(%rbx)       # imm = 0x1387
	ja	.LBB35_34
# BB#28:                                # %if.then65
                                        #   in Loop: Header=BB35_22 Depth=1
	movl	$5000, %eax             # imm = 0x1388
	subl	5048(%rbx), %eax
	movslq	%eax, %r13
	movq	(%rbx), %rcx
	movl	$1, %esi
	movq	%r12, %rdi
	movq	%r13, %rdx
	callq	fwrite
	cmpl	%eax, %r13d
	jne	.LBB35_30
# BB#29:                                # %lor.lhs.false75
                                        #   in Loop: Header=BB35_22 Depth=1
	movq	(%rbx), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB35_30
.LBB35_34:                              # %if.end90
                                        #   in Loop: Header=BB35_22 Depth=1
	cmpl	$0, 5024(%rbx)
	jne	.LBB35_22
.LBB35_35:                              # %if.then95
	testq	%r14, %r14
	je	.LBB35_37
# BB#36:                                # %if.then98
	movl	$0, (%r14)
.LBB35_37:                              # %if.end99
	testq	%rbx, %rbx
	je	.LBB35_39
# BB#38:                                # %if.then102
	movl	$0, 5096(%rbx)
	jmp	.LBB35_39
.LBB35_23:                              # %if.then53
	testq	%r14, %r14
	je	.LBB35_25
# BB#24:                                # %if.then55
	movl	%eax, (%r14)
.LBB35_25:                              # %if.end56
	testq	%rbx, %rbx
	je	.LBB35_39
# BB#26:                                # %if.then58
	movl	%eax, 5096(%rbx)
	jmp	.LBB35_39
.LBB35_30:                              # %if.then79
	testq	%r14, %r14
	je	.LBB35_32
# BB#31:                                # %if.then82
	movl	$-6, (%r14)
.LBB35_32:                              # %if.end83
	testq	%rbx, %rbx
	je	.LBB35_39
# BB#33:                                # %if.then86
	movl	$-6, 5096(%rbx)
	jmp	.LBB35_39
.Lfunc_end35:
	.size	BZ2_bzWrite, .Lfunc_end35-BZ2_bzWrite
	.cfi_endproc

	.globl	BZ2_bzWriteClose
	.p2align	4, 0x90
	.type	BZ2_bzWriteClose,@function
BZ2_bzWriteClose:                       # @BZ2_bzWriteClose
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi187:
	.cfi_def_cfa_offset 16
.Lcfi188:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi189:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%r8, %rax
	movq	$0, (%rsp)
	xorl	%r8d, %r8d
	movq	%rax, %r9
	callq	BZ2_bzWriteClose64
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end36:
	.size	BZ2_bzWriteClose, .Lfunc_end36-BZ2_bzWriteClose
	.cfi_endproc

	.globl	BZ2_bzWriteClose64
	.p2align	4, 0x90
	.type	BZ2_bzWriteClose64,@function
BZ2_bzWriteClose64:                     # @BZ2_bzWriteClose64
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi190:
	.cfi_def_cfa_offset 16
.Lcfi191:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi192:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
.Lcfi193:
	.cfi_offset %rbx, -56
.Lcfi194:
	.cfi_offset %r12, -48
.Lcfi195:
	.cfi_offset %r13, -40
.Lcfi196:
	.cfi_offset %r14, -32
.Lcfi197:
	.cfi_offset %r15, -24
	movq	%r9, %r12
	movq	%r8, %r13
	movl	%edx, %r15d
	movq	%rsi, %rbx
	movq	%rdi, %r14
	testq	%rbx, %rbx
	je	.LBB37_1
# BB#5:                                 # %if.end6
	cmpb	$0, 5012(%rbx)
	je	.LBB37_6
# BB#10:                                # %if.end15
	movq	%rcx, -48(%rbp)         # 8-byte Spill
	movq	(%rbx), %rdi
	callq	ferror
	testl	%eax, %eax
	je	.LBB37_15
# BB#11:                                # %if.then17
	testq	%r14, %r14
	je	.LBB37_13
# BB#12:                                # %if.then19
	movl	$-6, (%r14)
.LBB37_13:                              # %if.end20
	testq	%rbx, %rbx
	je	.LBB37_59
# BB#14:                                # %if.then22
	movl	$-6, 5096(%rbx)
	jmp	.LBB37_59
.LBB37_1:                               # %if.then
	testq	%r14, %r14
	je	.LBB37_3
# BB#2:                                 # %if.then2
	movl	$0, (%r14)
.LBB37_3:                               # %if.end
	testq	%rbx, %rbx
	je	.LBB37_59
# BB#4:                                 # %if.then4
	movl	$0, 5096(%rbx)
	jmp	.LBB37_59
.LBB37_6:                               # %if.then7
	testq	%r14, %r14
	je	.LBB37_8
# BB#7:                                 # %if.then9
	movl	$-1, (%r14)
.LBB37_8:                               # %if.end10
	testq	%rbx, %rbx
	je	.LBB37_59
# BB#9:                                 # %if.then12
	movl	$-1, 5096(%rbx)
	jmp	.LBB37_59
.LBB37_15:                              # %if.end25
	movq	-48(%rbp), %rcx         # 8-byte Reload
	testq	%rcx, %rcx
	je	.LBB37_17
# BB#16:                                # %if.then27
	movl	$0, (%rcx)
.LBB37_17:                              # %if.end28
	testq	%r13, %r13
	je	.LBB37_19
# BB#18:                                # %if.then30
	movl	$0, (%r13)
.LBB37_19:                              # %if.end31
	movq	16(%rbp), %rdx
	testq	%r12, %r12
	je	.LBB37_21
# BB#20:                                # %if.then33
	movl	$0, (%r12)
.LBB37_21:                              # %if.end34
	testq	%rdx, %rdx
	je	.LBB37_23
# BB#22:                                # %if.then36
	movl	$0, (%rdx)
.LBB37_23:                              # %if.end37
	testl	%r15d, %r15d
	jne	.LBB37_46
# BB#24:                                # %land.lhs.true
	movq	%r12, -64(%rbp)         # 8-byte Spill
	cmpl	$0, 5096(%rbx)
	je	.LBB37_25
.LBB37_39:                              # %if.end89
	testl	%r15d, %r15d
	movq	-64(%rbp), %r12         # 8-byte Reload
	movq	-48(%rbp), %rcx         # 8-byte Reload
	movq	16(%rbp), %rdx
	jne	.LBB37_46
# BB#40:                                # %land.lhs.true91
	movq	(%rbx), %rdi
	callq	ferror
	movq	16(%rbp), %rdx
	movq	-48(%rbp), %rcx         # 8-byte Reload
	testl	%eax, %eax
	je	.LBB37_41
.LBB37_46:                              # %if.end112
	testq	%rcx, %rcx
	je	.LBB37_48
# BB#47:                                # %if.then115
	movl	5028(%rbx), %eax
	movl	%eax, (%rcx)
.LBB37_48:                              # %if.end117
	testq	%r13, %r13
	je	.LBB37_50
# BB#49:                                # %if.then120
	movl	5032(%rbx), %eax
	movl	%eax, (%r13)
.LBB37_50:                              # %if.end122
	testq	%r12, %r12
	je	.LBB37_52
# BB#51:                                # %if.then125
	movl	5052(%rbx), %eax
	movl	%eax, (%r12)
.LBB37_52:                              # %if.end127
	testq	%rdx, %rdx
	je	.LBB37_54
# BB#53:                                # %if.then130
	movl	5056(%rbx), %eax
	movl	%eax, (%rdx)
.LBB37_54:                              # %if.end132
	testq	%r14, %r14
	je	.LBB37_56
# BB#55:                                # %if.then135
	movl	$0, (%r14)
.LBB37_56:                              # %if.end136
	testq	%rbx, %rbx
	je	.LBB37_58
# BB#57:                                # %if.then139
	movl	$0, 5096(%rbx)
.LBB37_58:                              # %if.end141
	leaq	5016(%rbx), %rdi
	callq	BZ2_bzCompressEnd
	movq	%rbx, %rdi
	callq	free
.LBB37_59:                              # %return
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB37_25:                              # %while.body.preheader
	leaq	5016(%rbx), %rax
	movq	%rax, -80(%rbp)         # 8-byte Spill
	leaq	8(%rbx), %rax
	movq	%rax, -56(%rbp)         # 8-byte Spill
	movq	%r13, -72(%rbp)         # 8-byte Spill
	.p2align	4, 0x90
.LBB37_26:                              # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movl	$5000, 5048(%rbx)       # imm = 0x1388
	movq	-56(%rbp), %rax         # 8-byte Reload
	movq	%rax, 5040(%rbx)
	movl	$2, %esi
	movq	-80(%rbp), %rdi         # 8-byte Reload
	callq	BZ2_bzCompress
	movl	%eax, %r12d
	leal	-3(%r12), %eax
	cmpl	$2, %eax
	jae	.LBB37_27
# BB#31:                                # %if.end56
                                        #   in Loop: Header=BB37_26 Depth=1
	cmpl	$4999, 5048(%rbx)       # imm = 0x1387
	ja	.LBB37_38
# BB#32:                                # %if.then60
                                        #   in Loop: Header=BB37_26 Depth=1
	movl	$5000, %eax             # imm = 0x1388
	subl	5048(%rbx), %eax
	movslq	%eax, %r13
	movq	(%rbx), %rcx
	movl	$1, %esi
	movq	-56(%rbp), %rdi         # 8-byte Reload
	movq	%r13, %rdx
	callq	fwrite
	cmpl	%eax, %r13d
	movq	-72(%rbp), %r13         # 8-byte Reload
	jne	.LBB37_34
# BB#33:                                # %lor.lhs.false
                                        #   in Loop: Header=BB37_26 Depth=1
	movq	(%rbx), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB37_34
.LBB37_38:                              # %if.end84
                                        #   in Loop: Header=BB37_26 Depth=1
	cmpl	$4, %r12d
	jne	.LBB37_26
	jmp	.LBB37_39
.LBB37_27:                              # %if.then48
	testq	%r14, %r14
	je	.LBB37_29
# BB#28:                                # %if.then50
	movl	%r12d, (%r14)
.LBB37_29:                              # %if.end51
	testq	%rbx, %rbx
	je	.LBB37_59
# BB#30:                                # %if.then53
	movl	%r12d, 5096(%rbx)
	jmp	.LBB37_59
.LBB37_34:                              # %if.then73
	testq	%r14, %r14
	je	.LBB37_36
# BB#35:                                # %if.then76
	movl	$-6, (%r14)
.LBB37_36:                              # %if.end77
	testq	%rbx, %rbx
	je	.LBB37_59
# BB#37:                                # %if.then80
	movl	$-6, 5096(%rbx)
	jmp	.LBB37_59
.LBB37_41:                              # %if.then95
	movq	(%rbx), %rdi
	callq	fflush
	movq	(%rbx), %rdi
	callq	ferror
	movq	16(%rbp), %rdx
	movq	-48(%rbp), %rcx         # 8-byte Reload
	testl	%eax, %eax
	je	.LBB37_46
# BB#42:                                # %if.then101
	testq	%r14, %r14
	je	.LBB37_44
# BB#43:                                # %if.then104
	movl	$-6, (%r14)
.LBB37_44:                              # %if.end105
	testq	%rbx, %rbx
	je	.LBB37_59
# BB#45:                                # %if.then108
	movl	$-6, 5096(%rbx)
	jmp	.LBB37_59
.Lfunc_end37:
	.size	BZ2_bzWriteClose64, .Lfunc_end37-BZ2_bzWriteClose64
	.cfi_endproc

	.globl	BZ2_bzReadOpen
	.p2align	4, 0x90
	.type	BZ2_bzReadOpen,@function
BZ2_bzReadOpen:                         # @BZ2_bzReadOpen
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi198:
	.cfi_def_cfa_offset 16
.Lcfi199:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi200:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
.Lcfi201:
	.cfi_offset %rbx, -56
.Lcfi202:
	.cfi_offset %r12, -48
.Lcfi203:
	.cfi_offset %r13, -40
.Lcfi204:
	.cfi_offset %r14, -32
.Lcfi205:
	.cfi_offset %r15, -24
	movl	%r9d, %r13d
	movq	%r8, %r15
	movl	%ecx, %ebx
	movq	%rsi, %r12
	movq	%rdi, %r14
	testq	%r14, %r14
	je	.LBB38_2
# BB#1:                                 # %if.then
	movl	$0, (%r14)
.LBB38_2:                               # %if.end3
	testq	%r12, %r12
	je	.LBB38_8
# BB#3:                                 # %if.end3
	cmpl	$1, %ebx
	ja	.LBB38_8
# BB#4:                                 # %lor.lhs.false7
	testl	%edx, %edx
	js	.LBB38_8
# BB#5:                                 # %lor.lhs.false7
	cmpl	$4, %edx
	jg	.LBB38_8
# BB#6:                                 # %lor.lhs.false11
	testq	%r15, %r15
	jne	.LBB38_12
# BB#7:                                 # %lor.lhs.false11
	testl	%r13d, %r13d
	je	.LBB38_12
.LBB38_8:                               # %if.then21
	testq	%r14, %r14
	je	.LBB38_10
# BB#9:                                 # %if.then23
	movl	$-2, (%r14)
.LBB38_10:
	xorl	%ebx, %ebx
.LBB38_11:                              # %return
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB38_12:                              # %lor.lhs.false15
	testq	%r15, %r15
	je	.LBB38_15
# BB#13:                                # %land.lhs.true17
	testl	%r13d, %r13d
	js	.LBB38_8
# BB#14:                                # %land.lhs.true17
	cmpl	$5001, %r13d            # imm = 0x1389
	jge	.LBB38_8
.LBB38_15:                              # %if.end29
	movl	%edx, -48(%rbp)         # 4-byte Spill
	movq	%r12, %rdi
	callq	ferror
	testl	%eax, %eax
	je	.LBB38_18
# BB#16:                                # %if.then30
	testq	%r14, %r14
	je	.LBB38_10
# BB#17:                                # %if.then32
	movl	$-6, (%r14)
	jmp	.LBB38_10
.LBB38_18:                              # %if.end38
	movl	%ebx, -44(%rbp)         # 4-byte Spill
	movl	$5104, %edi             # imm = 0x13F0
	callq	malloc
	movq	%rax, %rbx
	testq	%rbx, %rbx
	je	.LBB38_32
# BB#19:                                # %if.end49
	testq	%r14, %r14
	je	.LBB38_21
# BB#20:                                # %if.then51
	movl	$0, (%r14)
.LBB38_21:                              # %if.end52
	testq	%rbx, %rbx
	movl	-48(%rbp), %esi         # 4-byte Reload
	je	.LBB38_23
# BB#22:                                # %if.then54
	movl	$0, 5096(%rbx)
.LBB38_23:                              # %if.end56
	movb	$0, 5100(%rbx)
	movq	%r12, (%rbx)
	movl	$0, 5008(%rbx)
	movb	$0, 5012(%rbx)
	xorps	%xmm0, %xmm0
	movups	%xmm0, 5072(%rbx)
	movq	$0, 5088(%rbx)
	testl	%r13d, %r13d
	jle	.LBB38_25
	.p2align	4, 0x90
.LBB38_24:                              # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movzbl	(%r15), %eax
	movslq	5008(%rbx), %rcx
	movb	%al, 8(%rbx,%rcx)
	incl	5008(%rbx)
	incq	%r15
	decl	%r13d
	testl	%r13d, %r13d
	jg	.LBB38_24
.LBB38_25:                              # %while.end
	leaq	5016(%rbx), %rdi
	movl	-44(%rbp), %edx         # 4-byte Reload
	callq	BZ2_bzDecompressInit
	testl	%eax, %eax
	je	.LBB38_36
# BB#26:                                # %if.then65
	testq	%r14, %r14
	je	.LBB38_28
# BB#27:                                # %if.then67
	movl	%eax, (%r14)
.LBB38_28:                              # %if.end68
	testq	%rbx, %rbx
	je	.LBB38_30
# BB#29:                                # %if.then70
	movl	%eax, 5096(%rbx)
.LBB38_30:                              # %if.end72
	movq	%rbx, %rdi
	callq	free
	jmp	.LBB38_10
.LBB38_32:                              # %if.then41
	testq	%r14, %r14
	je	.LBB38_34
# BB#33:                                # %if.then43
	movl	$-3, (%r14)
.LBB38_34:                              # %if.end44
	testq	%rbx, %rbx
	je	.LBB38_10
# BB#35:                                # %if.then46
	movl	$-3, 5096(%rbx)
	jmp	.LBB38_10
.LBB38_36:                              # %if.end73
	movl	5008(%rbx), %eax
	movl	%eax, 5024(%rbx)
	movq	%rbx, %rax
	addq	$8, %rax
	movq	%rax, 5016(%rbx)
	movb	$1, 5100(%rbx)
	jmp	.LBB38_11
.Lfunc_end38:
	.size	BZ2_bzReadOpen, .Lfunc_end38-BZ2_bzReadOpen
	.cfi_endproc

	.globl	BZ2_bzReadClose
	.p2align	4, 0x90
	.type	BZ2_bzReadClose,@function
BZ2_bzReadClose:                        # @BZ2_bzReadClose
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi206:
	.cfi_def_cfa_offset 16
.Lcfi207:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi208:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi209:
	.cfi_offset %rbx, -24
	movq	%rsi, %rbx
	testq	%rdi, %rdi
	je	.LBB39_2
# BB#1:                                 # %if.then
	movl	$0, (%rdi)
.LBB39_2:                               # %if.end
	testq	%rbx, %rbx
	je	.LBB39_8
# BB#3:                                 # %if.then2
	movl	$0, 5096(%rbx)
	cmpb	$0, 5012(%rbx)
	je	.LBB39_12
# BB#4:                                 # %if.then14
	testq	%rdi, %rdi
	je	.LBB39_6
# BB#5:                                 # %if.then16
	movl	$-1, (%rdi)
.LBB39_6:                               # %if.end17
	testq	%rbx, %rbx
	je	.LBB39_15
# BB#7:                                 # %if.then19
	movl	$-1, 5096(%rbx)
	jmp	.LBB39_15
.LBB39_8:                               # %if.then5
	testq	%rdi, %rdi
	je	.LBB39_10
# BB#9:                                 # %if.then7
	movl	$0, (%rdi)
.LBB39_10:                              # %if.end8
	testq	%rbx, %rbx
	je	.LBB39_15
# BB#11:                                # %if.then10
	movl	$0, 5096(%rbx)
	jmp	.LBB39_15
.LBB39_12:                              # %if.end22
	cmpb	$0, 5100(%rbx)
	je	.LBB39_14
# BB#13:                                # %if.then24
	leaq	5016(%rbx), %rdi
	callq	BZ2_bzDecompressEnd
.LBB39_14:                              # %if.end25
	movq	%rbx, %rdi
	callq	free
.LBB39_15:                              # %return
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end39:
	.size	BZ2_bzReadClose, .Lfunc_end39-BZ2_bzReadClose
	.cfi_endproc

	.globl	BZ2_bzRead
	.p2align	4, 0x90
	.type	BZ2_bzRead,@function
BZ2_bzRead:                             # @BZ2_bzRead
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi210:
	.cfi_def_cfa_offset 16
.Lcfi211:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi212:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
.Lcfi213:
	.cfi_offset %rbx, -56
.Lcfi214:
	.cfi_offset %r12, -48
.Lcfi215:
	.cfi_offset %r13, -40
.Lcfi216:
	.cfi_offset %r14, -32
.Lcfi217:
	.cfi_offset %r15, -24
	movl	%ecx, %r14d
	movq	%rsi, %r13
	movq	%rdi, %r15
	testq	%r15, %r15
	je	.LBB40_2
# BB#1:                                 # %if.then
	movl	$0, (%r15)
.LBB40_2:                               # %if.end
	testq	%r13, %r13
	je	.LBB40_6
# BB#3:                                 # %if.then2
	movl	$0, 5096(%r13)
	je	.LBB40_6
# BB#4:                                 # %if.then2
	testq	%rdx, %rdx
	je	.LBB40_6
# BB#5:                                 # %if.then2
	testl	%r14d, %r14d
	js	.LBB40_6
# BB#10:                                # %if.end16
	cmpb	$0, 5012(%r13)
	je	.LBB40_15
# BB#11:                                # %if.then17
	testq	%r15, %r15
	je	.LBB40_13
# BB#12:                                # %if.then19
	movl	$-1, (%r15)
.LBB40_13:                              # %if.end20
	xorl	%r14d, %r14d
	testq	%r13, %r13
	je	.LBB40_57
# BB#14:                                # %if.then22
	movl	$-1, 5096(%r13)
	jmp	.LBB40_57
.LBB40_6:                               # %if.then8
	testq	%r15, %r15
	je	.LBB40_8
# BB#7:                                 # %if.then10
	movl	$-2, (%r15)
.LBB40_8:                               # %if.end11
	xorl	%r14d, %r14d
	testq	%r13, %r13
	je	.LBB40_57
# BB#9:                                 # %if.then13
	movl	$-2, 5096(%r13)
.LBB40_57:                              # %return
	movl	%r14d, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB40_15:                              # %if.end25
	testl	%r14d, %r14d
	je	.LBB40_16
# BB#19:                                # %if.end35
	movl	%r14d, 5048(%r13)
	movq	%rdx, 5040(%r13)
	leaq	8(%r13), %rbx
	leaq	5016(%r13), %rax
	movq	%rax, -48(%rbp)         # 8-byte Spill
	.p2align	4, 0x90
.LBB40_20:                              # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r13), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB40_21
# BB#25:                                # %if.end46
                                        #   in Loop: Header=BB40_20 Depth=1
	cmpl	$0, 5024(%r13)
	jne	.LBB40_33
# BB#26:                                # %land.lhs.true
                                        #   in Loop: Header=BB40_20 Depth=1
	movq	(%r13), %rdi
	callq	myfeof
	testb	%al, %al
	jne	.LBB40_33
# BB#27:                                # %if.then52
                                        #   in Loop: Header=BB40_20 Depth=1
	movq	(%r13), %rcx
	movl	$1, %esi
	movl	$5000, %edx             # imm = 0x1388
	movq	%rbx, %rdi
	callq	fread
	movq	%rax, %r12
	movq	(%r13), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB40_28
# BB#32:                                # %if.end69
                                        #   in Loop: Header=BB40_20 Depth=1
	movl	%r12d, 5008(%r13)
	movl	%r12d, 5024(%r13)
	movq	%rbx, 5016(%r13)
	.p2align	4, 0x90
.LBB40_33:                              # %if.end76
                                        #   in Loop: Header=BB40_20 Depth=1
	movq	-48(%rbp), %rdi         # 8-byte Reload
	callq	BZ2_bzDecompress
	movl	%eax, %r12d
	testl	%r12d, %r12d
	jne	.LBB40_34
# BB#39:                                # %land.lhs.true97
                                        #   in Loop: Header=BB40_20 Depth=1
	movq	(%r13), %rdi
	callq	myfeof
	testb	%al, %al
	je	.LBB40_46
# BB#40:                                # %land.lhs.true102
                                        #   in Loop: Header=BB40_20 Depth=1
	cmpl	$0, 5024(%r13)
	jne	.LBB40_46
# BB#41:                                # %land.lhs.true107
                                        #   in Loop: Header=BB40_20 Depth=1
	cmpl	$0, 5048(%r13)
	jne	.LBB40_42
.LBB40_46:                              # %if.end122
                                        #   in Loop: Header=BB40_20 Depth=1
	cmpl	$4, %r12d
	je	.LBB40_47
# BB#52:                                # %if.end137
                                        #   in Loop: Header=BB40_20 Depth=1
	cmpl	$0, 5048(%r13)
	jne	.LBB40_20
# BB#53:                                # %if.then142
	testq	%r15, %r15
	je	.LBB40_55
# BB#54:                                # %if.then145
	movl	$0, (%r15)
	testq	%r13, %r13
	jne	.LBB40_56
	jmp	.LBB40_57
.LBB40_16:                              # %if.then27
	testq	%r15, %r15
	je	.LBB40_18
# BB#17:                                # %if.then29
	movl	$0, (%r15)
.LBB40_18:                              # %if.end30
	xorl	%r14d, %r14d
.LBB40_55:                              # %if.end146
	testq	%r13, %r13
	je	.LBB40_57
.LBB40_56:                              # %if.then149
	movl	$0, 5096(%r13)
	jmp	.LBB40_57
.LBB40_21:                              # %if.then38
	testq	%r15, %r15
	je	.LBB40_23
# BB#22:                                # %if.then40
	movl	$-6, (%r15)
.LBB40_23:                              # %if.end41
	xorl	%r14d, %r14d
	testq	%r13, %r13
	je	.LBB40_57
# BB#24:                                # %if.then43
	movl	$-6, 5096(%r13)
	jmp	.LBB40_57
.LBB40_34:                              # %if.end76
	cmpl	$4, %r12d
	jne	.LBB40_35
.LBB40_47:                              # %if.then125
	testq	%r15, %r15
	je	.LBB40_49
# BB#48:                                # %if.then128
	movl	$4, (%r15)
.LBB40_49:                              # %if.end129
	testq	%r13, %r13
	je	.LBB40_51
# BB#50:                                # %if.then132
	movl	$4, 5096(%r13)
.LBB40_51:                              # %if.end134
	subl	5048(%r13), %r14d
	jmp	.LBB40_57
.LBB40_35:                              # %if.then84
	testq	%r15, %r15
	je	.LBB40_37
# BB#36:                                # %if.then87
	movl	%r12d, (%r15)
.LBB40_37:                              # %if.end88
	xorl	%r14d, %r14d
	testq	%r13, %r13
	je	.LBB40_57
# BB#38:                                # %if.then91
	movl	%r12d, 5096(%r13)
	jmp	.LBB40_57
.LBB40_42:                              # %if.then112
	testq	%r15, %r15
	je	.LBB40_44
# BB#43:                                # %if.then115
	movl	$-7, (%r15)
.LBB40_44:                              # %if.end116
	xorl	%r14d, %r14d
	testq	%r13, %r13
	je	.LBB40_57
# BB#45:                                # %if.then119
	movl	$-7, 5096(%r13)
	jmp	.LBB40_57
.LBB40_28:                              # %if.then59
	testq	%r15, %r15
	je	.LBB40_30
# BB#29:                                # %if.then62
	movl	$-6, (%r15)
.LBB40_30:                              # %if.end63
	xorl	%r14d, %r14d
	testq	%r13, %r13
	je	.LBB40_57
# BB#31:                                # %if.then66
	movl	$-6, 5096(%r13)
	jmp	.LBB40_57
.Lfunc_end40:
	.size	BZ2_bzRead, .Lfunc_end40-BZ2_bzRead
	.cfi_endproc

	.p2align	4, 0x90
	.type	myfeof,@function
myfeof:                                 # @myfeof
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi218:
	.cfi_def_cfa_offset 16
.Lcfi219:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi220:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi221:
	.cfi_offset %rbx, -24
	movq	%rdi, %rbx
	callq	fgetc
	cmpl	$-1, %eax
	je	.LBB41_1
# BB#2:                                 # %if.end
	movl	%eax, %edi
	movq	%rbx, %rsi
	callq	ungetc
	xorl	%eax, %eax
	jmp	.LBB41_3
.LBB41_1:
	movb	$1, %al
.LBB41_3:                               # %return
                                        # kill: %AL<def> %AL<kill> %EAX<kill>
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end41:
	.size	myfeof, .Lfunc_end41-myfeof
	.cfi_endproc

	.globl	BZ2_bzReadGetUnused
	.p2align	4, 0x90
	.type	BZ2_bzReadGetUnused,@function
BZ2_bzReadGetUnused:                    # @BZ2_bzReadGetUnused
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi222:
	.cfi_def_cfa_offset 16
.Lcfi223:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi224:
	.cfi_def_cfa_register %rbp
	testq	%rsi, %rsi
	je	.LBB42_1
# BB#5:                                 # %if.end6
	cmpl	$4, 5096(%rsi)
	je	.LBB42_10
# BB#6:                                 # %if.then9
	testq	%rdi, %rdi
	je	.LBB42_8
# BB#7:                                 # %if.then11
	movl	$-1, (%rdi)
.LBB42_8:                               # %if.end12
	testq	%rsi, %rsi
	je	.LBB42_21
# BB#9:                                 # %if.then14
	movl	$-1, 5096(%rsi)
	popq	%rbp
	retq
.LBB42_1:                               # %if.then
	testq	%rdi, %rdi
	je	.LBB42_3
# BB#2:                                 # %if.then2
	movl	$-2, (%rdi)
.LBB42_3:                               # %if.end
	testq	%rsi, %rsi
	je	.LBB42_21
# BB#4:                                 # %if.then4
	movl	$-2, 5096(%rsi)
	popq	%rbp
	retq
.LBB42_10:                              # %if.end17
	testq	%rdx, %rdx
	je	.LBB42_12
# BB#11:                                # %if.end17
	testq	%rcx, %rcx
	je	.LBB42_12
# BB#16:                                # %if.end28
	testq	%rdi, %rdi
	je	.LBB42_18
# BB#17:                                # %if.then30
	movl	$0, (%rdi)
.LBB42_18:                              # %if.end31
	testq	%rsi, %rsi
	je	.LBB42_20
# BB#19:                                # %if.then33
	movl	$0, 5096(%rsi)
.LBB42_20:                              # %if.end35
	movl	5024(%rsi), %eax
	movl	%eax, (%rcx)
	movq	5016(%rsi), %rax
	movq	%rax, (%rdx)
	popq	%rbp
	retq
.LBB42_12:                              # %if.then20
	testq	%rdi, %rdi
	je	.LBB42_14
# BB#13:                                # %if.then22
	movl	$-2, (%rdi)
.LBB42_14:                              # %if.end23
	testq	%rsi, %rsi
	je	.LBB42_21
# BB#15:                                # %if.then25
	movl	$-2, 5096(%rsi)
	popq	%rbp
	retq
.LBB42_21:                              # %return
	popq	%rbp
	retq
.Lfunc_end42:
	.size	BZ2_bzReadGetUnused, .Lfunc_end42-BZ2_bzReadGetUnused
	.cfi_endproc

	.globl	BZ2_bzBuffToBuffCompress
	.p2align	4, 0x90
	.type	BZ2_bzBuffToBuffCompress,@function
BZ2_bzBuffToBuffCompress:               # @BZ2_bzBuffToBuffCompress
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi225:
	.cfi_def_cfa_offset 16
.Lcfi226:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi227:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$88, %rsp
.Lcfi228:
	.cfi_offset %rbx, -56
.Lcfi229:
	.cfi_offset %r12, -48
.Lcfi230:
	.cfi_offset %r13, -40
.Lcfi231:
	.cfi_offset %r14, -32
.Lcfi232:
	.cfi_offset %r15, -24
	movl	%ecx, %r15d
	movq	%rdx, %r12
	movq	%rsi, %r14
	movq	%rdi, %r13
	testq	%r13, %r13
	movl	$-2, %ebx
	je	.LBB43_15
# BB#1:                                 # %entry
	testq	%r14, %r14
	je	.LBB43_15
# BB#2:                                 # %entry
	testq	%r12, %r12
	je	.LBB43_15
# BB#3:                                 # %entry
	testl	%r8d, %r8d
	jle	.LBB43_15
# BB#4:                                 # %entry
	cmpl	$9, %r8d
	jg	.LBB43_15
# BB#5:                                 # %entry
	testl	%r9d, %r9d
	js	.LBB43_15
# BB#6:                                 # %entry
	cmpl	$4, %r9d
	jg	.LBB43_15
# BB#7:                                 # %entry
	movl	16(%rbp), %eax
	testl	%eax, %eax
	js	.LBB43_15
# BB#8:                                 # %entry
	cmpl	$250, %eax
	jg	.LBB43_15
# BB#9:                                 # %if.end
	testl	%eax, %eax
	movl	$30, %ecx
	cmovnel	%eax, %ecx
	xorps	%xmm0, %xmm0
	movups	%xmm0, -64(%rbp)
	movq	$0, -48(%rbp)
	leaq	-120(%rbp), %rdi
	movl	%r8d, %esi
	movl	%r9d, %edx
	callq	BZ2_bzCompressInit
	movl	%eax, %ebx
	testl	%ebx, %ebx
	je	.LBB43_10
.LBB43_15:                              # %return
	movl	%ebx, %eax
	addq	$88, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB43_10:                              # %if.end21
	movq	%r12, -120(%rbp)
	movq	%r13, -96(%rbp)
	movl	%r15d, -112(%rbp)
	movl	(%r14), %eax
	movl	%eax, -88(%rbp)
	leaq	-120(%rbp), %rdi
	movl	$2, %esi
	callq	BZ2_bzCompress
	movl	%eax, %ebx
	cmpl	$3, %ebx
	je	.LBB43_13
# BB#11:                                # %if.end21
	cmpl	$4, %ebx
	jne	.LBB43_14
# BB#12:                                # %if.end28
	movl	-88(%rbp), %eax
	subl	%eax, (%r14)
	leaq	-120(%rbp), %rdi
	callq	BZ2_bzCompressEnd
	xorl	%ebx, %ebx
	jmp	.LBB43_15
.LBB43_13:                              # %output_overflow
	leaq	-120(%rbp), %rdi
	callq	BZ2_bzCompressEnd
	movl	$-8, %ebx
	jmp	.LBB43_15
.LBB43_14:                              # %errhandler
	leaq	-120(%rbp), %rdi
	callq	BZ2_bzCompressEnd
	jmp	.LBB43_15
.Lfunc_end43:
	.size	BZ2_bzBuffToBuffCompress, .Lfunc_end43-BZ2_bzBuffToBuffCompress
	.cfi_endproc

	.globl	BZ2_bzBuffToBuffDecompress
	.p2align	4, 0x90
	.type	BZ2_bzBuffToBuffDecompress,@function
BZ2_bzBuffToBuffDecompress:             # @BZ2_bzBuffToBuffDecompress
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi233:
	.cfi_def_cfa_offset 16
.Lcfi234:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi235:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$88, %rsp
.Lcfi236:
	.cfi_offset %rbx, -56
.Lcfi237:
	.cfi_offset %r12, -48
.Lcfi238:
	.cfi_offset %r13, -40
.Lcfi239:
	.cfi_offset %r14, -32
.Lcfi240:
	.cfi_offset %r15, -24
	movl	%ecx, %r15d
	movq	%rdx, %r12
	movq	%rsi, %r14
	movq	%rdi, %r13
	testq	%r13, %r13
	setne	%al
	testq	%r14, %r14
	setne	%cl
	andb	%al, %cl
	testq	%r12, %r12
	setne	%al
	andb	%cl, %al
	movl	$-2, %ebx
	cmpb	$1, %al
	jne	.LBB44_10
# BB#1:                                 # %entry
	cmpl	$1, %r8d
	ja	.LBB44_10
# BB#2:                                 # %lor.lhs.false7
	testl	%r9d, %r9d
	js	.LBB44_10
# BB#3:                                 # %lor.lhs.false7
	cmpl	$4, %r9d
	jg	.LBB44_10
# BB#4:                                 # %if.end
	xorps	%xmm0, %xmm0
	movups	%xmm0, -64(%rbp)
	movq	$0, -48(%rbp)
	leaq	-120(%rbp), %rdi
	movl	%r9d, %esi
	movl	%r8d, %edx
	callq	BZ2_bzDecompressInit
	movl	%eax, %ebx
	testl	%ebx, %ebx
	je	.LBB44_5
.LBB44_10:                              # %return
	movl	%ebx, %eax
	addq	$88, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB44_5:                               # %if.end13
	movq	%r12, -120(%rbp)
	movq	%r13, -96(%rbp)
	movl	%r15d, -112(%rbp)
	movl	(%r14), %eax
	movl	%eax, -88(%rbp)
	leaq	-120(%rbp), %rdi
	callq	BZ2_bzDecompress
	movl	%eax, %ebx
	testl	%ebx, %ebx
	je	.LBB44_8
# BB#6:                                 # %if.end13
	cmpl	$4, %ebx
	jne	.LBB44_9
# BB#7:                                 # %if.end20
	movl	-88(%rbp), %eax
	subl	%eax, (%r14)
	leaq	-120(%rbp), %rdi
	callq	BZ2_bzDecompressEnd
	xorl	%ebx, %ebx
	jmp	.LBB44_10
.LBB44_8:                               # %output_overflow_or_eof
	xorl	%ebx, %ebx
	cmpl	$0, -88(%rbp)
	setne	%bl
	leaq	-120(%rbp), %rdi
	callq	BZ2_bzDecompressEnd
	orl	$-8, %ebx
	jmp	.LBB44_10
.LBB44_9:                               # %errhandler
	leaq	-120(%rbp), %rdi
	callq	BZ2_bzDecompressEnd
	jmp	.LBB44_10
.Lfunc_end44:
	.size	BZ2_bzBuffToBuffDecompress, .Lfunc_end44-BZ2_bzBuffToBuffDecompress
	.cfi_endproc

	.globl	BZ2_bzopen
	.p2align	4, 0x90
	.type	BZ2_bzopen,@function
BZ2_bzopen:                             # @BZ2_bzopen
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi241:
	.cfi_def_cfa_offset 16
.Lcfi242:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi243:
	.cfi_def_cfa_register %rbp
	movq	%rsi, %rax
	movl	$-1, %esi
	xorl	%ecx, %ecx
	movq	%rax, %rdx
	callq	bzopen_or_bzdopen
	popq	%rbp
	retq
.Lfunc_end45:
	.size	BZ2_bzopen, .Lfunc_end45-BZ2_bzopen
	.cfi_endproc

	.p2align	4, 0x90
	.type	bzopen_or_bzdopen,@function
bzopen_or_bzdopen:                      # @bzopen_or_bzdopen
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi244:
	.cfi_def_cfa_offset 16
.Lcfi245:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi246:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$5032, %rsp             # imm = 0x13A8
.Lcfi247:
	.cfi_offset %rbx, -56
.Lcfi248:
	.cfi_offset %r12, -48
.Lcfi249:
	.cfi_offset %r13, -40
.Lcfi250:
	.cfi_offset %r14, -32
.Lcfi251:
	.cfi_offset %r15, -24
	movl	%ecx, %r13d
	movq	%rdx, %r15
	movq	%rdi, -72(%rbp)         # 8-byte Spill
	movw	$0, -48(%rbp)
	movq	$0, -56(%rbp)
	xorl	%ebx, %ebx
	testq	%r15, %r15
	je	.LBB46_28
# BB#1:                                 # %while.cond.preheader
	movl	%esi, -60(%rbp)         # 4-byte Spill
	movl	$9, %r12d
	xorl	%r14d, %r14d
	cmpb	$0, (%r15)
	jne	.LBB46_3
	jmp	.LBB46_12
	.p2align	4, 0x90
.LBB46_11:                              # %sw.epilog
                                        #   in Loop: Header=BB46_3 Depth=1
	incq	%r15
	cmpb	$0, (%r15)
	je	.LBB46_12
.LBB46_3:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movsbl	(%r15), %eax
	cmpl	$114, %eax
	je	.LBB46_4
# BB#5:                                 # %while.body
                                        #   in Loop: Header=BB46_3 Depth=1
	cmpl	$115, %eax
	je	.LBB46_8
# BB#6:                                 # %while.body
                                        #   in Loop: Header=BB46_3 Depth=1
	cmpl	$119, %eax
	jne	.LBB46_9
# BB#7:                                 # %sw.bb1
                                        #   in Loop: Header=BB46_3 Depth=1
	movl	$1, %ebx
	incq	%r15
	cmpb	$0, (%r15)
	jne	.LBB46_3
	jmp	.LBB46_12
	.p2align	4, 0x90
.LBB46_4:                               #   in Loop: Header=BB46_3 Depth=1
	xorl	%ebx, %ebx
	incq	%r15
	cmpb	$0, (%r15)
	jne	.LBB46_3
	jmp	.LBB46_12
	.p2align	4, 0x90
.LBB46_8:                               # %sw.bb2
                                        #   in Loop: Header=BB46_3 Depth=1
	movl	$1, %r14d
	incq	%r15
	cmpb	$0, (%r15)
	jne	.LBB46_3
	jmp	.LBB46_12
	.p2align	4, 0x90
.LBB46_9:                               # %sw.default
                                        #   in Loop: Header=BB46_3 Depth=1
	callq	__ctype_b_loc
	movq	(%rax), %rax
	movsbq	(%r15), %rcx
	movzwl	(%rax,%rcx,2), %eax
	testb	$8, %ah
	je	.LBB46_11
# BB#10:                                # %if.then6
                                        #   in Loop: Header=BB46_3 Depth=1
	movsbl	(%r15), %r12d
	addl	$-48, %r12d
	jmp	.LBB46_11
.LBB46_12:                              # %while.end
	testl	%ebx, %ebx
	movl	$.L.str.64, %eax
	movl	$.L.str.65, %esi
	cmovneq	%rax, %rsi
	leaq	-56(%rbp), %r15
	movq	%r15, %rdi
	callq	strcat
	movl	$.L.str.66, %esi
	movq	%r15, %rdi
	callq	strcat
	testl	%r13d, %r13d
	je	.LBB46_13
# BB#17:                                # %if.else27
	leaq	-56(%rbp), %rsi
	movl	-60(%rbp), %edi         # 4-byte Reload
	callq	fdopen
.LBB46_18:                              # %if.end30
	movq	%rax, %r15
	testq	%r15, %r15
	jne	.LBB46_20
	jmp	.LBB46_27
.LBB46_13:                              # %if.then15
	movq	-72(%rbp), %r15         # 8-byte Reload
	testq	%r15, %r15
	je	.LBB46_15
# BB#14:                                # %lor.lhs.false
	movl	$.L.str.16, %esi
	movq	%r15, %rdi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB46_15
# BB#16:                                # %if.else
	leaq	-56(%rbp), %rsi
	movq	%r15, %rdi
	callq	fopen
	jmp	.LBB46_18
.LBB46_15:                              # %if.then21
	testl	%ebx, %ebx
	movl	$stdout, %eax
	movl	$stdin, %ecx
	cmovneq	%rax, %rcx
	movq	(%rcx), %r15
	testq	%r15, %r15
	je	.LBB46_27
.LBB46_20:                              # %if.end34
	testl	%ebx, %ebx
	je	.LBB46_22
# BB#21:                                # %if.then36
	testl	%r12d, %r12d
	movl	$1, %eax
	cmovgl	%r12d, %eax
	cmpl	$9, %eax
	movl	$9, %edx
	cmovlel	%eax, %edx
	leaq	-64(%rbp), %rdi
	xorl	%ecx, %ecx
	movl	$30, %r8d
	movq	%r15, %rsi
	callq	BZ2_bzWriteOpen
	jmp	.LBB46_23
.LBB46_22:                              # %if.else46
	leaq	-64(%rbp), %rdi
	leaq	-5072(%rbp), %r8
	xorl	%edx, %edx
	xorl	%r9d, %r9d
	movq	%r15, %rsi
	movl	%r14d, %ecx
	callq	BZ2_bzReadOpen
.LBB46_23:                              # %if.end49
	movq	%rax, %rbx
	testq	%rbx, %rbx
	jne	.LBB46_28
# BB#24:                                # %if.then52
	xorl	%ebx, %ebx
	cmpq	stdin(%rip), %r15
	je	.LBB46_28
# BB#25:                                # %if.then52
	cmpq	stdout(%rip), %r15
	je	.LBB46_28
# BB#26:                                # %if.then57
	movq	%r15, %rdi
	callq	fclose
.LBB46_27:                              # %return
	xorl	%ebx, %ebx
.LBB46_28:                              # %return
	movq	%rbx, %rax
	addq	$5032, %rsp             # imm = 0x13A8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end46:
	.size	bzopen_or_bzdopen, .Lfunc_end46-bzopen_or_bzdopen
	.cfi_endproc

	.globl	BZ2_bzdopen
	.p2align	4, 0x90
	.type	BZ2_bzdopen,@function
BZ2_bzdopen:                            # @BZ2_bzdopen
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi252:
	.cfi_def_cfa_offset 16
.Lcfi253:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi254:
	.cfi_def_cfa_register %rbp
	movq	%rsi, %rax
	movl	%edi, %edx
	xorl	%edi, %edi
	movl	$1, %ecx
	movl	%edx, %esi
	movq	%rax, %rdx
	callq	bzopen_or_bzdopen
	popq	%rbp
	retq
.Lfunc_end47:
	.size	BZ2_bzdopen, .Lfunc_end47-BZ2_bzdopen
	.cfi_endproc

	.globl	BZ2_bzread
	.p2align	4, 0x90
	.type	BZ2_bzread,@function
BZ2_bzread:                             # @BZ2_bzread
	.cfi_startproc
# BB#0:                                 # %entry
	movl	%edx, %eax
	movq	%rsi, %rcx
	movq	%rdi, %rdx
	cmpl	$4, 5096(%rdx)
	jne	.LBB48_1
# BB#2:                                 # %return
	xorl	%eax, %eax
	retq
.LBB48_1:                               # %if.end
	pushq	%rbp
.Lcfi255:
	.cfi_def_cfa_offset 16
.Lcfi256:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi257:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	leaq	-4(%rbp), %rdi
	movq	%rdx, %rsi
	movq	%rcx, %rdx
	movl	%eax, %ecx
	callq	BZ2_bzRead
	movl	-4(%rbp), %ecx
	cmpl	$4, %ecx
	movl	$-1, %edx
	cmovel	%eax, %edx
	testl	%ecx, %ecx
	cmovnel	%edx, %eax
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end48:
	.size	BZ2_bzread, .Lfunc_end48-BZ2_bzread
	.cfi_endproc

	.globl	BZ2_bzwrite
	.p2align	4, 0x90
	.type	BZ2_bzwrite,@function
BZ2_bzwrite:                            # @BZ2_bzwrite
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi258:
	.cfi_def_cfa_offset 16
.Lcfi259:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi260:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi261:
	.cfi_offset %rbx, -24
	movl	%edx, %ebx
	movq	%rsi, %rax
	movq	%rdi, %rcx
	leaq	-12(%rbp), %rdi
	movq	%rcx, %rsi
	movq	%rax, %rdx
	movl	%ebx, %ecx
	callq	BZ2_bzWrite
	cmpl	$1, -12(%rbp)
	sbbl	%eax, %eax
	notl	%eax
	orl	%ebx, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end49:
	.size	BZ2_bzwrite, .Lfunc_end49-BZ2_bzwrite
	.cfi_endproc

	.globl	BZ2_bzflush
	.p2align	4, 0x90
	.type	BZ2_bzflush,@function
BZ2_bzflush:                            # @BZ2_bzflush
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi262:
	.cfi_def_cfa_offset 16
.Lcfi263:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi264:
	.cfi_def_cfa_register %rbp
	xorl	%eax, %eax
	popq	%rbp
	retq
.Lfunc_end50:
	.size	BZ2_bzflush, .Lfunc_end50-BZ2_bzflush
	.cfi_endproc

	.globl	BZ2_bzclose
	.p2align	4, 0x90
	.type	BZ2_bzclose,@function
BZ2_bzclose:                            # @BZ2_bzclose
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi265:
	.cfi_def_cfa_offset 16
.Lcfi266:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi267:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$16, %rsp
.Lcfi268:
	.cfi_offset %rbx, -32
.Lcfi269:
	.cfi_offset %r14, -24
	movq	%rdi, %rbx
	testq	%rbx, %rbx
	je	.LBB51_8
# BB#1:                                 # %if.end
	movq	(%rbx), %r14
	cmpb	$0, 5012(%rbx)
	je	.LBB51_4
# BB#2:                                 # %if.then1
	leaq	-20(%rbp), %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	movq	%rbx, %rsi
	callq	BZ2_bzWriteClose
	cmpl	$0, -20(%rbp)
	je	.LBB51_5
# BB#3:                                 # %if.then3
	xorl	%edi, %edi
	movl	$1, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	movq	%rbx, %rsi
	callq	BZ2_bzWriteClose
	cmpq	stdin(%rip), %r14
	jne	.LBB51_6
	jmp	.LBB51_8
.LBB51_4:                               # %if.else
	leaq	-20(%rbp), %rdi
	movq	%rbx, %rsi
	callq	BZ2_bzReadClose
.LBB51_5:                               # %if.end5
	cmpq	stdin(%rip), %r14
	je	.LBB51_8
.LBB51_6:                               # %if.end5
	cmpq	stdout(%rip), %r14
	je	.LBB51_8
# BB#7:                                 # %if.then8
	movq	%r14, %rdi
	callq	fclose
.LBB51_8:                               # %if.end9
	addq	$16, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end51:
	.size	BZ2_bzclose, .Lfunc_end51-BZ2_bzclose
	.cfi_endproc

	.globl	BZ2_bzerror
	.p2align	4, 0x90
	.type	BZ2_bzerror,@function
BZ2_bzerror:                            # @BZ2_bzerror
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi270:
	.cfi_def_cfa_offset 16
.Lcfi271:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi272:
	.cfi_def_cfa_register %rbp
	movl	5096(%rdi), %eax
	xorl	%ecx, %ecx
	testl	%eax, %eax
	cmovlel	%eax, %ecx
	movl	%ecx, (%rsi)
	negl	%ecx
	movslq	%ecx, %rax
	movq	bzerrorstrings(,%rax,8), %rax
	popq	%rbp
	retq
.Lfunc_end52:
	.size	BZ2_bzerror, .Lfunc_end52-BZ2_bzerror
	.cfi_endproc

	.globl	fopen_output_safely
	.p2align	4, 0x90
	.type	fopen_output_safely,@function
fopen_output_safely:                    # @fopen_output_safely
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi273:
	.cfi_def_cfa_offset 16
.Lcfi274:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi275:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
.Lcfi276:
	.cfi_offset %rbx, -40
.Lcfi277:
	.cfi_offset %r14, -32
.Lcfi278:
	.cfi_offset %r15, -24
	movq	%rsi, %r14
	xorl	%r15d, %r15d
	movl	$193, %esi
	movl	$384, %edx              # imm = 0x180
	xorl	%eax, %eax
	callq	open
	movl	%eax, %ebx
	cmpl	$-1, %ebx
	je	.LBB53_3
# BB#1:                                 # %if.end
	movl	%ebx, %edi
	movq	%r14, %rsi
	callq	fdopen
	movq	%rax, %r15
	testq	%r15, %r15
	jne	.LBB53_3
# BB#2:                                 # %if.then3
	movl	%ebx, %edi
	callq	close
.LBB53_3:                               # %return
	movq	%r15, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end53:
	.size	fopen_output_safely, .Lfunc_end53-fopen_output_safely
	.cfi_endproc

	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi279:
	.cfi_def_cfa_offset 16
.Lcfi280:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi281:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$16, %rsp
.Lcfi282:
	.cfi_offset %rbx, -48
.Lcfi283:
	.cfi_offset %r12, -40
.Lcfi284:
	.cfi_offset %r14, -32
.Lcfi285:
	.cfi_offset %r15, -24
	movq	%rsi, %r14
	movl	%edi, %r12d
	movq	$0, outputHandleJustInCase(%rip)
	movb	$0, smallMode(%rip)
	movb	$0, keepInputFiles(%rip)
	movb	$0, forceOverwrite(%rip)
	movb	$1, noisy(%rip)
	movl	$0, verbosity(%rip)
	movl	$9, blockSize100k(%rip)
	movb	$0, testFailsExist(%rip)
	movb	$0, unzFailsExist(%rip)
	movl	$0, numFileNames(%rip)
	movl	$0, numFilesProcessed(%rip)
	movl	$30, workFactor(%rip)
	movb	$0, deleteOutputOnInterrupt(%rip)
	movl	$0, exitValue(%rip)
	movl	$11, %edi
	movl	$mySIGSEGVorSIGBUScatcher, %esi
	callq	signal
	movl	$7, %edi
	movl	$mySIGSEGVorSIGBUScatcher, %esi
	callq	signal
	movl	$inName, %edi
	movl	$.L.str.18, %esi
	callq	copyFileName
	movl	$outName, %edi
	movl	$.L.str.18, %esi
	callq	copyFileName
	movq	(%r14), %rsi
	movl	$progNameReally, %edi
	callq	copyFileName
	movq	$progNameReally, progName(%rip)
	movl	$progNameReally+1, %eax
	cmpb	$0, -1(%rax)
	jne	.LBB54_2
	jmp	.LBB54_5
	.p2align	4, 0x90
.LBB54_4:                               # %for.inc
                                        #   in Loop: Header=BB54_2 Depth=1
	incq	%rax
	cmpb	$0, -1(%rax)
	je	.LBB54_5
.LBB54_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	cmpb	$47, -1(%rax)
	jne	.LBB54_4
# BB#3:                                 # %if.then
                                        #   in Loop: Header=BB54_2 Depth=1
	movq	%rax, progName(%rip)
	jmp	.LBB54_4
.LBB54_5:                               # %for.end
	movq	$0, -40(%rbp)
	leaq	-40(%rbp), %r15
	movl	$.L.str.19, %esi
	movq	%r15, %rdi
	callq	addFlagsFromEnvVar
	movl	$.L.str.20, %esi
	movq	%r15, %rdi
	callq	addFlagsFromEnvVar
	movl	$1, %ebx
	decl	%r12d
	cmpl	%r12d, %ebx
	jg	.LBB54_8
	.p2align	4, 0x90
.LBB54_7:                               # %for.body12
                                        # =>This Inner Loop Header: Depth=1
	movq	-40(%rbp), %rdi
	movq	(%r14,%rbx,8), %rsi
	callq	snocString
	movq	%rax, -40(%rbp)
	incq	%rbx
	cmpl	%r12d, %ebx
	jle	.LBB54_7
.LBB54_8:                               # %for.end16
	movl	$7, longestFileName(%rip)
	movl	$0, numFileNames(%rip)
	movb	$1, %r14b
	movq	-40(%rbp), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_10
	jmp	.LBB54_17
	.p2align	4, 0x90
.LBB54_16:                              # %for.inc45
                                        #   in Loop: Header=BB54_10 Depth=1
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	je	.LBB54_17
.LBB54_10:                              # %for.body20
                                        # =>This Inner Loop Header: Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.21, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_11
# BB#12:                                # %if.end25
                                        #   in Loop: Header=BB54_10 Depth=1
	movq	(%rbx), %rax
	cmpb	$45, (%rax)
	jne	.LBB54_14
# BB#13:                                # %if.end25
                                        #   in Loop: Header=BB54_10 Depth=1
	movzbl	%r14b, %eax
	testl	%eax, %eax
	jne	.LBB54_16
.LBB54_14:                              # %if.end33
                                        #   in Loop: Header=BB54_10 Depth=1
	incl	numFileNames(%rip)
	movl	longestFileName(%rip), %r15d
	movq	(%rbx), %rdi
	callq	strlen
	cmpl	%eax, %r15d
	jge	.LBB54_16
# BB#15:                                # %if.then40
                                        #   in Loop: Header=BB54_10 Depth=1
	movq	(%rbx), %rdi
	callq	strlen
	movl	%eax, longestFileName(%rip)
	jmp	.LBB54_16
	.p2align	4, 0x90
.LBB54_11:                              #   in Loop: Header=BB54_10 Depth=1
	xorl	%r14d, %r14d
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_10
.LBB54_17:                              # %for.end46
	xorl	%eax, %eax
	cmpl	$0, numFileNames(%rip)
	setne	%al
	leal	1(%rax,%rax), %eax
	movl	%eax, srcMode(%rip)
	movl	$1, opMode(%rip)
	movq	progName(%rip), %rdi
	movl	$.L.str.22, %esi
	callq	strstr
	testq	%rax, %rax
	jne	.LBB54_19
# BB#18:                                # %lor.lhs.false
	movq	progName(%rip), %rdi
	movl	$.L.str.23, %esi
	callq	strstr
	testq	%rax, %rax
	je	.LBB54_20
.LBB54_19:                              # %if.then57
	movl	$2, opMode(%rip)
.LBB54_20:                              # %if.end58
	movq	progName(%rip), %rdi
	movl	$.L.str.24, %esi
	callq	strstr
	testq	%rax, %rax
	jne	.LBB54_24
# BB#21:                                # %lor.lhs.false62
	movq	progName(%rip), %rdi
	movl	$.L.str.25, %esi
	callq	strstr
	testq	%rax, %rax
	jne	.LBB54_24
# BB#22:                                # %lor.lhs.false66
	movq	progName(%rip), %rdi
	movl	$.L.str.26, %esi
	callq	strstr
	testq	%rax, %rax
	jne	.LBB54_24
# BB#23:                                # %lor.lhs.false70
	movq	progName(%rip), %rdi
	movl	$.L.str.27, %esi
	callq	strstr
	testq	%rax, %rax
	je	.LBB54_25
.LBB54_24:                              # %if.then74
	cmpl	$1, numFileNames(%rip)
	movl	$2, opMode(%rip)
	movl	$1, %eax
	sbbl	$-1, %eax
	movl	%eax, srcMode(%rip)
.LBB54_25:                              # %if.end77
	movq	-40(%rbp), %r14
	testq	%r14, %r14
	jne	.LBB54_27
	jmp	.LBB54_56
	.p2align	4, 0x90
.LBB54_55:                              # %for.inc138
                                        #   in Loop: Header=BB54_27 Depth=1
	movq	8(%r14), %r14
	testq	%r14, %r14
	je	.LBB54_56
.LBB54_27:                              # %for.body81
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB54_31 Depth 2
	movq	(%r14), %rdi
	movl	$.L.str.21, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_56
# BB#28:                                # %if.end87
                                        #   in Loop: Header=BB54_27 Depth=1
	movq	(%r14), %rax
	cmpb	$45, (%rax)
	jne	.LBB54_55
# BB#29:                                # %land.lhs.true93
                                        #   in Loop: Header=BB54_27 Depth=1
	movq	(%r14), %rax
	cmpb	$45, 1(%rax)
	je	.LBB54_55
# BB#30:                                # %for.cond100.preheader
                                        #   in Loop: Header=BB54_27 Depth=1
	movl	$1, %ebx
	jmp	.LBB54_31
.LBB54_51:                              # %sw.bb128
                                        #   in Loop: Header=BB54_31 Depth=2
	callq	license
	incq	%rbx
	.p2align	4, 0x90
.LBB54_31:                              # %for.cond100
                                        #   Parent Loop BB54_27 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	(%r14), %rax
	cmpb	$0, (%rax,%rbx)
	je	.LBB54_55
# BB#32:                                # %for.body107
                                        #   in Loop: Header=BB54_31 Depth=2
	movq	(%r14), %rax
	movsbl	(%rax,%rbx), %eax
	addl	$-49, %eax
	cmpl	$73, %eax
	ja	.LBB54_53
# BB#33:                                # %for.body107
                                        #   in Loop: Header=BB54_31 Depth=2
	jmpq	*.LJTI54_0(,%rax,8)
.LBB54_42:                              # %sw.bb119
                                        #   in Loop: Header=BB54_31 Depth=2
	movl	$1, blockSize100k(%rip)
	incq	%rbx
	jmp	.LBB54_31
.LBB54_37:                              # %sw.bb114
                                        #   in Loop: Header=BB54_31 Depth=2
	movb	$1, forceOverwrite(%rip)
	incq	%rbx
	jmp	.LBB54_31
.LBB54_36:                              # %sw.bb113
                                        #   in Loop: Header=BB54_31 Depth=2
	movl	$1, opMode(%rip)
	incq	%rbx
	jmp	.LBB54_31
.LBB54_46:                              # %sw.bb123
                                        #   in Loop: Header=BB54_31 Depth=2
	movl	$5, blockSize100k(%rip)
	incq	%rbx
	jmp	.LBB54_31
.LBB54_43:                              # %sw.bb120
                                        #   in Loop: Header=BB54_31 Depth=2
	movl	$2, blockSize100k(%rip)
	incq	%rbx
	jmp	.LBB54_31
.LBB54_47:                              # %sw.bb124
                                        #   in Loop: Header=BB54_31 Depth=2
	movl	$6, blockSize100k(%rip)
	incq	%rbx
	jmp	.LBB54_31
.LBB54_50:                              # %sw.bb127
                                        #   in Loop: Header=BB54_31 Depth=2
	movl	$9, blockSize100k(%rip)
	incq	%rbx
	jmp	.LBB54_31
.LBB54_45:                              # %sw.bb122
                                        #   in Loop: Header=BB54_31 Depth=2
	movl	$4, blockSize100k(%rip)
	incq	%rbx
	jmp	.LBB54_31
.LBB54_49:                              # %sw.bb126
                                        #   in Loop: Header=BB54_31 Depth=2
	movl	$8, blockSize100k(%rip)
	incq	%rbx
	jmp	.LBB54_31
.LBB54_44:                              # %sw.bb121
                                        #   in Loop: Header=BB54_31 Depth=2
	movl	$3, blockSize100k(%rip)
	incq	%rbx
	jmp	.LBB54_31
.LBB54_39:                              # %sw.bb116
                                        #   in Loop: Header=BB54_31 Depth=2
	movb	$1, keepInputFiles(%rip)
	incq	%rbx
	jmp	.LBB54_31
.LBB54_41:                              # %sw.bb118
                                        #   in Loop: Header=BB54_31 Depth=2
	movb	$0, noisy(%rip)
	incq	%rbx
	jmp	.LBB54_31
.LBB54_48:                              # %sw.bb125
                                        #   in Loop: Header=BB54_31 Depth=2
	movl	$7, blockSize100k(%rip)
	incq	%rbx
	jmp	.LBB54_31
.LBB54_35:                              # %sw.bb112
                                        #   in Loop: Header=BB54_31 Depth=2
	movl	$2, opMode(%rip)
	incq	%rbx
	jmp	.LBB54_31
.LBB54_52:                              # %sw.bb129
                                        #   in Loop: Header=BB54_31 Depth=2
	incl	verbosity(%rip)
	incq	%rbx
	jmp	.LBB54_31
.LBB54_40:                              # %sw.bb117
                                        #   in Loop: Header=BB54_31 Depth=2
	movb	$1, smallMode(%rip)
	incq	%rbx
	jmp	.LBB54_31
.LBB54_34:                              # %sw.bb
                                        #   in Loop: Header=BB54_31 Depth=2
	movl	$2, srcMode(%rip)
	incq	%rbx
	jmp	.LBB54_31
.LBB54_38:                              # %sw.bb115
                                        #   in Loop: Header=BB54_31 Depth=2
	movl	$3, opMode(%rip)
	incq	%rbx
	jmp	.LBB54_31
.LBB54_56:                              # %for.end140
	movq	-40(%rbp), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_58
	jmp	.LBB54_95
	.p2align	4, 0x90
.LBB54_60:                              # %if.then155
                                        #   in Loop: Header=BB54_58 Depth=1
	movl	$2, srcMode(%rip)
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	je	.LBB54_95
.LBB54_58:                              # %for.body144
                                        # =>This Inner Loop Header: Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.21, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_95
# BB#59:                                # %if.end150
                                        #   in Loop: Header=BB54_58 Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.29, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_60
# BB#61:                                # %if.else156
                                        #   in Loop: Header=BB54_58 Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.30, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_62
# BB#63:                                # %if.else162
                                        #   in Loop: Header=BB54_58 Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.31, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_64
# BB#65:                                # %if.else168
                                        #   in Loop: Header=BB54_58 Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.32, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_66
# BB#67:                                # %if.else174
                                        #   in Loop: Header=BB54_58 Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.33, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_68
# BB#69:                                # %if.else180
                                        #   in Loop: Header=BB54_58 Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.34, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_70
# BB#71:                                # %if.else186
                                        #   in Loop: Header=BB54_58 Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.35, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_72
# BB#73:                                # %if.else192
                                        #   in Loop: Header=BB54_58 Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.36, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_74
# BB#75:                                # %if.else198
                                        #   in Loop: Header=BB54_58 Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.37, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_76
# BB#77:                                # %if.else204
                                        #   in Loop: Header=BB54_58 Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.38, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_78
# BB#79:                                # %if.else210
                                        #   in Loop: Header=BB54_58 Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.39, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_80
# BB#81:                                # %if.else216
                                        #   in Loop: Header=BB54_58 Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.40, %esi
	callq	strcmp
	movq	(%rbx), %rdi
	testl	%eax, %eax
	je	.LBB54_82
# BB#83:                                # %if.else223
                                        #   in Loop: Header=BB54_58 Depth=1
	movl	$.L.str.41, %esi
	callq	strcmp
	movq	(%rbx), %rdi
	testl	%eax, %eax
	je	.LBB54_84
# BB#85:                                # %if.else230
                                        #   in Loop: Header=BB54_58 Depth=1
	movl	$.L.str.42, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_86
# BB#87:                                # %if.else236
                                        #   in Loop: Header=BB54_58 Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.43, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_88
# BB#89:                                # %if.else242
                                        #   in Loop: Header=BB54_58 Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.44, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_90
# BB#92:                                # %if.else249
                                        #   in Loop: Header=BB54_58 Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.45, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_153
# BB#93:                                # %if.else255
                                        #   in Loop: Header=BB54_58 Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.21, %esi
	movl	$2, %edx
	callq	strncmp
	testl	%eax, %eax
	jne	.LBB54_91
	jmp	.LBB54_94
	.p2align	4, 0x90
.LBB54_62:                              # %if.then161
                                        #   in Loop: Header=BB54_58 Depth=1
	movl	$2, opMode(%rip)
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_58
	jmp	.LBB54_95
.LBB54_64:                              # %if.then167
                                        #   in Loop: Header=BB54_58 Depth=1
	movl	$1, opMode(%rip)
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_58
	jmp	.LBB54_95
.LBB54_66:                              # %if.then173
                                        #   in Loop: Header=BB54_58 Depth=1
	movb	$1, forceOverwrite(%rip)
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_58
	jmp	.LBB54_95
.LBB54_68:                              # %if.then179
                                        #   in Loop: Header=BB54_58 Depth=1
	movl	$3, opMode(%rip)
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_58
	jmp	.LBB54_95
.LBB54_70:                              # %if.then185
                                        #   in Loop: Header=BB54_58 Depth=1
	movb	$1, keepInputFiles(%rip)
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_58
	jmp	.LBB54_95
.LBB54_72:                              # %if.then191
                                        #   in Loop: Header=BB54_58 Depth=1
	movb	$1, smallMode(%rip)
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_58
	jmp	.LBB54_95
.LBB54_74:                              # %if.then197
                                        #   in Loop: Header=BB54_58 Depth=1
	movb	$0, noisy(%rip)
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_58
	jmp	.LBB54_95
.LBB54_76:                              # %if.then203
                                        #   in Loop: Header=BB54_58 Depth=1
	callq	license
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_58
	jmp	.LBB54_95
.LBB54_78:                              # %if.then209
                                        #   in Loop: Header=BB54_58 Depth=1
	callq	license
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_58
	jmp	.LBB54_95
.LBB54_80:                              # %if.then215
                                        #   in Loop: Header=BB54_58 Depth=1
	movl	$1, workFactor(%rip)
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_58
	jmp	.LBB54_95
.LBB54_82:                              # %if.then221
                                        #   in Loop: Header=BB54_58 Depth=1
	callq	redundant
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_58
	jmp	.LBB54_95
.LBB54_84:                              # %if.then228
                                        #   in Loop: Header=BB54_58 Depth=1
	callq	redundant
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_58
	jmp	.LBB54_95
.LBB54_86:                              # %if.then235
                                        #   in Loop: Header=BB54_58 Depth=1
	movl	$1, blockSize100k(%rip)
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_58
	jmp	.LBB54_95
.LBB54_88:                              # %if.then241
                                        #   in Loop: Header=BB54_58 Depth=1
	movl	$9, blockSize100k(%rip)
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_58
	jmp	.LBB54_95
.LBB54_90:                              # %if.then247
                                        #   in Loop: Header=BB54_58 Depth=1
	incl	verbosity(%rip)
.LBB54_91:                              # %for.inc281
                                        #   in Loop: Header=BB54_58 Depth=1
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_58
.LBB54_95:                              # %for.end283
	cmpl	$5, verbosity(%rip)
	jl	.LBB54_97
# BB#96:                                # %if.then286
	movl	$4, verbosity(%rip)
.LBB54_97:                              # %if.end287
	cmpl	$1, opMode(%rip)
	jne	.LBB54_101
# BB#98:                                # %land.lhs.true290
	cmpb	$0, smallMode(%rip)
	je	.LBB54_101
# BB#99:                                # %land.lhs.true290
	cmpl	$3, blockSize100k(%rip)
	jl	.LBB54_101
# BB#100:                               # %if.then296
	movl	$2, blockSize100k(%rip)
.LBB54_101:                             # %if.end297
	cmpl	$3, opMode(%rip)
	jne	.LBB54_103
# BB#102:                               # %if.end297
	cmpl	$2, srcMode(%rip)
	je	.LBB54_154
.LBB54_103:                             # %if.end305
	cmpl	$2, srcMode(%rip)
	jne	.LBB54_106
# BB#104:                               # %if.end305
	movl	numFileNames(%rip), %eax
	testl	%eax, %eax
	jne	.LBB54_106
# BB#105:                               # %if.then311
	movl	$1, srcMode(%rip)
.LBB54_106:                             # %if.end312
	cmpl	$1, opMode(%rip)
	je	.LBB54_108
# BB#107:                               # %if.then315
	movl	$0, blockSize100k(%rip)
.LBB54_108:                             # %if.end316
	cmpl	$3, srcMode(%rip)
	jne	.LBB54_110
# BB#109:                               # %if.then319
	movl	$2, %edi
	movl	$mySignalCatcher, %esi
	callq	signal
	movl	$15, %edi
	movl	$mySignalCatcher, %esi
	callq	signal
	movl	$1, %edi
	movl	$mySignalCatcher, %esi
	callq	signal
.LBB54_110:                             # %if.end323
	cmpl	$1, opMode(%rip)
	jne	.LBB54_126
# BB#111:                               # %if.then326
	cmpl	$1, srcMode(%rip)
	jne	.LBB54_118
# BB#112:                               # %if.then329
	xorl	%edi, %edi
	callq	compress
	jmp	.LBB54_113
.LBB54_126:                             # %if.else357
	cmpl	$2, opMode(%rip)
	jne	.LBB54_139
# BB#127:                               # %if.then360
	movb	$0, unzFailsExist(%rip)
	cmpl	$1, srcMode(%rip)
	jne	.LBB54_131
# BB#128:                               # %if.then363
	xorl	%edi, %edi
	callq	uncompress
	cmpb	$0, unzFailsExist(%rip)
	je	.LBB54_113
	jmp	.LBB54_130
.LBB54_118:                             # %if.else330
	movb	$1, %r14b
	movq	-40(%rbp), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_120
	jmp	.LBB54_113
	.p2align	4, 0x90
.LBB54_125:                             # %for.inc353
                                        #   in Loop: Header=BB54_120 Depth=1
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	je	.LBB54_113
.LBB54_120:                             # %for.body334
                                        # =>This Inner Loop Header: Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.21, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_121
# BB#122:                               # %if.end340
                                        #   in Loop: Header=BB54_120 Depth=1
	movq	(%rbx), %rax
	cmpb	$45, (%rax)
	jne	.LBB54_124
# BB#123:                               # %if.end340
                                        #   in Loop: Header=BB54_120 Depth=1
	movzbl	%r14b, %eax
	testl	%eax, %eax
	jne	.LBB54_125
.LBB54_124:                             # %if.end350
                                        #   in Loop: Header=BB54_120 Depth=1
	incl	numFilesProcessed(%rip)
	movq	(%rbx), %rdi
	callq	compress
	jmp	.LBB54_125
	.p2align	4, 0x90
.LBB54_121:                             #   in Loop: Header=BB54_120 Depth=1
	xorl	%r14d, %r14d
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_120
	jmp	.LBB54_113
.LBB54_139:                             # %if.else394
	movb	$0, testFailsExist(%rip)
	cmpl	$1, srcMode(%rip)
	jne	.LBB54_144
# BB#140:                               # %if.then397
	xorl	%edi, %edi
	callq	testf
	cmpb	$0, testFailsExist(%rip)
	jne	.LBB54_142
	jmp	.LBB54_113
.LBB54_131:                             # %if.else364
	movb	$1, %r14b
	movq	-40(%rbp), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_133
	jmp	.LBB54_129
	.p2align	4, 0x90
.LBB54_138:                             # %for.inc387
                                        #   in Loop: Header=BB54_133 Depth=1
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	je	.LBB54_129
.LBB54_133:                             # %for.body368
                                        # =>This Inner Loop Header: Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.21, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_134
# BB#135:                               # %if.end374
                                        #   in Loop: Header=BB54_133 Depth=1
	movq	(%rbx), %rax
	cmpb	$45, (%rax)
	jne	.LBB54_137
# BB#136:                               # %if.end374
                                        #   in Loop: Header=BB54_133 Depth=1
	movzbl	%r14b, %eax
	testl	%eax, %eax
	jne	.LBB54_138
.LBB54_137:                             # %if.end384
                                        #   in Loop: Header=BB54_133 Depth=1
	incl	numFilesProcessed(%rip)
	movq	(%rbx), %rdi
	callq	uncompress
	jmp	.LBB54_138
	.p2align	4, 0x90
.LBB54_134:                             #   in Loop: Header=BB54_133 Depth=1
	xorl	%r14d, %r14d
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_133
.LBB54_129:                             # %if.end390
	cmpb	$0, unzFailsExist(%rip)
	je	.LBB54_113
	jmp	.LBB54_130
.LBB54_144:                             # %if.else398
	movb	$1, %r14b
	movq	-40(%rbp), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_146
	jmp	.LBB54_141
	.p2align	4, 0x90
.LBB54_151:                             # %for.inc421
                                        #   in Loop: Header=BB54_146 Depth=1
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	je	.LBB54_141
.LBB54_146:                             # %for.body402
                                        # =>This Inner Loop Header: Depth=1
	movq	(%rbx), %rdi
	movl	$.L.str.21, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_147
# BB#148:                               # %if.end408
                                        #   in Loop: Header=BB54_146 Depth=1
	movq	(%rbx), %rax
	cmpb	$45, (%rax)
	jne	.LBB54_150
# BB#149:                               # %if.end408
                                        #   in Loop: Header=BB54_146 Depth=1
	movzbl	%r14b, %eax
	testl	%eax, %eax
	jne	.LBB54_151
.LBB54_150:                             # %if.end418
                                        #   in Loop: Header=BB54_146 Depth=1
	incl	numFilesProcessed(%rip)
	movq	(%rbx), %rdi
	callq	testf
	jmp	.LBB54_151
	.p2align	4, 0x90
.LBB54_147:                             #   in Loop: Header=BB54_146 Depth=1
	xorl	%r14d, %r14d
	movq	8(%rbx), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_146
.LBB54_141:                             # %if.end424
	cmpb	$0, testFailsExist(%rip)
	je	.LBB54_113
.LBB54_142:                             # %land.lhs.true427
	cmpb	$0, noisy(%rip)
	jne	.LBB54_143
.LBB54_113:                             # %if.end434
	movq	-40(%rbp), %rbx
	testq	%rbx, %rbx
	jne	.LBB54_115
	jmp	.LBB54_152
	.p2align	4, 0x90
.LBB54_117:                             # %if.end444
                                        #   in Loop: Header=BB54_115 Depth=1
	movq	%rbx, %rdi
	callq	free
	movq	%r14, %rbx
	testq	%rbx, %rbx
	je	.LBB54_152
.LBB54_115:                             # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movq	8(%rbx), %r14
	cmpq	$0, (%rbx)
	je	.LBB54_117
# BB#116:                               # %if.then442
                                        #   in Loop: Header=BB54_115 Depth=1
	movq	(%rbx), %rdi
	callq	free
	jmp	.LBB54_117
.LBB54_152:                             # %while.end
	movl	exitValue(%rip), %eax
	addq	$16, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB54_153:                             # %sw.bb131
	movq	progName(%rip), %rdi
	callq	usage
	xorl	%edi, %edi
	callq	exit
.LBB54_53:                              # %sw.default
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movq	(%r14), %rcx
.LBB54_54:                              # %sw.default
	movl	$.L.str.28, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	progName(%rip), %rdi
	callq	usage
	movl	$1, %edi
	callq	exit
.LBB54_154:                             # %if.then303
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.46, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, %edi
	callq	exit
.LBB54_143:                             # %if.then430
	movq	stderr(%rip), %rdi
	movl	$.L.str.47, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB54_130:                             # %if.then392
	movl	$2, %edi
	callq	setExit
	movl	exitValue(%rip), %edi
	callq	exit
.LBB54_94:                              # %if.then260
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movq	(%rbx), %rcx
	jmp	.LBB54_54
.Lfunc_end54:
	.size	main, .Lfunc_end54-main
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	3
.LJTI54_0:
	.quad	.LBB54_42
	.quad	.LBB54_43
	.quad	.LBB54_44
	.quad	.LBB54_45
	.quad	.LBB54_46
	.quad	.LBB54_47
	.quad	.LBB54_48
	.quad	.LBB54_49
	.quad	.LBB54_50
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_51
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_51
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_34
	.quad	.LBB54_35
	.quad	.LBB54_53
	.quad	.LBB54_37
	.quad	.LBB54_53
	.quad	.LBB54_153
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_39
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_41
	.quad	.LBB54_53
	.quad	.LBB54_40
	.quad	.LBB54_38
	.quad	.LBB54_53
	.quad	.LBB54_52
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_53
	.quad	.LBB54_36

	.text
	.p2align	4, 0x90
	.type	mySIGSEGVorSIGBUScatcher,@function
mySIGSEGVorSIGBUScatcher:               # @mySIGSEGVorSIGBUScatcher
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi286:
	.cfi_def_cfa_offset 16
.Lcfi287:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi288:
	.cfi_def_cfa_register %rbp
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	cmpl	$1, opMode(%rip)
	jne	.LBB55_2
# BB#1:                                 # %if.then
	movl	$.L.str.78, %esi
	jmp	.LBB55_3
.LBB55_2:                               # %if.else
	movl	$.L.str.79, %esi
.LBB55_3:                               # %if.end
	xorl	%eax, %eax
	callq	fprintf
	callq	showFileNames
	cmpl	$1, opMode(%rip)
	jne	.LBB55_5
# BB#4:                                 # %if.then3
	movl	$3, %edi
	callq	cleanUpAndFail
.LBB55_5:                               # %if.else4
	callq	cadvise
	movl	$2, %edi
	callq	cleanUpAndFail
.Lfunc_end55:
	.size	mySIGSEGVorSIGBUScatcher, .Lfunc_end55-mySIGSEGVorSIGBUScatcher
	.cfi_endproc

	.p2align	4, 0x90
	.type	copyFileName,@function
copyFileName:                           # @copyFileName
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi289:
	.cfi_def_cfa_offset 16
.Lcfi290:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi291:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi292:
	.cfi_offset %rbx, -32
.Lcfi293:
	.cfi_offset %r14, -24
	movq	%rsi, %r14
	movq	%rdi, %rbx
	movq	%r14, %rdi
	callq	strlen
	cmpq	$1025, %rax             # imm = 0x401
	jae	.LBB56_2
# BB#1:                                 # %if.end
	movl	$1024, %edx             # imm = 0x400
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	strncpy
	movb	$0, 1024(%rbx)
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.LBB56_2:                               # %if.then
	movq	stderr(%rip), %rdi
	movl	$.L.str.89, %esi
	movl	$1024, %ecx             # imm = 0x400
	xorl	%eax, %eax
	movq	%r14, %rdx
	callq	fprintf
	movl	$1, %edi
	callq	setExit
	movl	exitValue(%rip), %edi
	callq	exit
.Lfunc_end56:
	.size	copyFileName, .Lfunc_end56-copyFileName
	.cfi_endproc

	.p2align	4, 0x90
	.type	addFlagsFromEnvVar,@function
addFlagsFromEnvVar:                     # @addFlagsFromEnvVar
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi294:
	.cfi_def_cfa_offset 16
.Lcfi295:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi296:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
.Lcfi297:
	.cfi_offset %rbx, -48
.Lcfi298:
	.cfi_offset %r12, -40
.Lcfi299:
	.cfi_offset %r14, -32
.Lcfi300:
	.cfi_offset %r15, -24
	movq	%rdi, %r14
	movq	%rsi, %rdi
	callq	getenv
	movq	%rax, %rbx
	testq	%rbx, %rbx
	je	.LBB57_14
# BB#1:                                 # %while.body.preheader
	xorl	%r12d, %r12d
	movl	$1024, %r15d            # imm = 0x400
	jmp	.LBB57_2
	.p2align	4, 0x90
.LBB57_13:                              # %for.end
                                        #   in Loop: Header=BB57_2 Depth=1
	cltq
	movb	$0, tmpName(%rax)
	movq	(%r14), %rdi
	movl	$tmpName, %esi
	callq	snocString
	movq	%rax, (%r14)
.LBB57_2:                               # %while.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB57_4 Depth 2
                                        #     Child Loop BB57_7 Depth 2
                                        #     Child Loop BB57_12 Depth 2
	movslq	%r12d, %rax
	cmpb	$0, (%rbx,%rax)
	je	.LBB57_14
# BB#3:                                 # %if.end
                                        #   in Loop: Header=BB57_2 Depth=1
	addq	%rax, %rbx
	jmp	.LBB57_4
	.p2align	4, 0x90
.LBB57_15:                              # %while.body11
                                        #   in Loop: Header=BB57_4 Depth=2
	incq	%rbx
.LBB57_4:                               # %while.cond4
                                        #   Parent Loop BB57_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	callq	__ctype_b_loc
	movq	(%rax), %rax
	movsbq	(%rbx), %rcx
	movzwl	(%rax,%rcx,2), %eax
	testb	$32, %ah
	jne	.LBB57_15
# BB#5:                                 # %while.cond12.preheader
                                        #   in Loop: Header=BB57_2 Depth=1
	xorl	%r12d, %r12d
	cmpb	$0, (%rbx,%r12)
	jne	.LBB57_7
	jmp	.LBB57_9
	.p2align	4, 0x90
.LBB57_8:                               # %while.body27
                                        #   in Loop: Header=BB57_7 Depth=2
	incq	%r12
	cmpb	$0, (%rbx,%r12)
	je	.LBB57_9
.LBB57_7:                               # %land.rhs
                                        #   Parent Loop BB57_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	callq	__ctype_b_loc
	movq	(%rax), %rax
	movsbq	(%rbx,%r12), %rcx
	movzwl	(%rax,%rcx,2), %eax
	testb	$32, %ah
	je	.LBB57_8
.LBB57_9:                               # %while.end28
                                        #   in Loop: Header=BB57_2 Depth=1
	testl	%r12d, %r12d
	jle	.LBB57_2
# BB#10:                                # %if.then31
                                        #   in Loop: Header=BB57_2 Depth=1
	cmpl	$1024, %r12d            # imm = 0x400
	movl	%r12d, %eax
	cmovgl	%r15d, %eax
	xorl	%ecx, %ecx
	cmpl	%eax, %ecx
	jge	.LBB57_13
	.p2align	4, 0x90
.LBB57_12:                              # %for.body
                                        #   Parent Loop BB57_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	(%rbx,%rcx), %edx
	movb	%dl, tmpName(%rcx)
	incq	%rcx
	cmpl	%eax, %ecx
	jl	.LBB57_12
	jmp	.LBB57_13
.LBB57_14:                              # %if.end48
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end57:
	.size	addFlagsFromEnvVar, .Lfunc_end57-addFlagsFromEnvVar
	.cfi_endproc

	.p2align	4, 0x90
	.type	snocString,@function
snocString:                             # @snocString
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi301:
	.cfi_def_cfa_offset 16
.Lcfi302:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi303:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
.Lcfi304:
	.cfi_offset %rbx, -40
.Lcfi305:
	.cfi_offset %r14, -32
.Lcfi306:
	.cfi_offset %r15, -24
	movq	%rsi, %r14
	movq	%rdi, %r15
	testq	%r15, %r15
	je	.LBB58_5
# BB#1:
	movq	%r15, %rdi
	.p2align	4, 0x90
.LBB58_2:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	%rdi, %rbx
	movq	8(%rbx), %rdi
	testq	%rdi, %rdi
	jne	.LBB58_2
# BB#3:                                 # %while.end
	movq	%r14, %rsi
	callq	snocString
	movq	%rax, 8(%rbx)
	jmp	.LBB58_4
.LBB58_5:                               # %if.then
	callq	mkCell
	movq	%rax, %r15
	movq	%r14, %rdi
	callq	strlen
	leal	5(%rax), %edi
	callq	myMalloc
	movq	%rax, (%r15)
	movq	%rax, %rdi
	movq	%r14, %rsi
	callq	strcpy
.LBB58_4:                               # %return
	movq	%r15, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end58:
	.size	snocString, .Lfunc_end58-snocString
	.cfi_endproc

	.p2align	4, 0x90
	.type	license,@function
license:                                # @license
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi307:
	.cfi_def_cfa_offset 16
.Lcfi308:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi309:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi310:
	.cfi_offset %rbx, -24
	movq	stderr(%rip), %rbx
	callq	BZ2_bzlibVersion
	movq	%rax, %rcx
	movl	$.L.str.91, %esi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	movq	%rcx, %rdx
	callq	fprintf
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end59:
	.size	license, .Lfunc_end59-license
	.cfi_endproc

	.p2align	4, 0x90
	.type	usage,@function
usage:                                  # @usage
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi311:
	.cfi_def_cfa_offset 16
.Lcfi312:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi313:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi314:
	.cfi_offset %rbx, -32
.Lcfi315:
	.cfi_offset %r14, -24
	movq	%rdi, %r14
	movq	stderr(%rip), %rbx
	callq	BZ2_bzlibVersion
	movq	%rax, %rcx
	movl	$.L.str.92, %esi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	movq	%rcx, %rdx
	movq	%r14, %rcx
	callq	fprintf
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end60:
	.size	usage, .Lfunc_end60-usage
	.cfi_endproc

	.p2align	4, 0x90
	.type	redundant,@function
redundant:                              # @redundant
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi316:
	.cfi_def_cfa_offset 16
.Lcfi317:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi318:
	.cfi_def_cfa_register %rbp
	movq	%rdi, %rcx
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.93, %esi
	xorl	%eax, %eax
	callq	fprintf
	popq	%rbp
	retq
.Lfunc_end61:
	.size	redundant, .Lfunc_end61-redundant
	.cfi_endproc

	.p2align	4, 0x90
	.type	mySignalCatcher,@function
mySignalCatcher:                        # @mySignalCatcher
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi319:
	.cfi_def_cfa_offset 16
.Lcfi320:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi321:
	.cfi_def_cfa_register %rbp
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.94, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, %edi
	callq	cleanUpAndFail
.Lfunc_end62:
	.size	mySignalCatcher, .Lfunc_end62-mySignalCatcher
	.cfi_endproc

	.p2align	4, 0x90
	.type	compress,@function
compress:                               # @compress
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi322:
	.cfi_def_cfa_offset 16
.Lcfi323:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi324:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$144, %rsp
.Lcfi325:
	.cfi_offset %rbx, -48
.Lcfi326:
	.cfi_offset %r12, -40
.Lcfi327:
	.cfi_offset %r14, -32
.Lcfi328:
	.cfi_offset %r15, -24
	movq	%rdi, %rbx
	movb	$0, deleteOutputOnInterrupt(%rip)
	testq	%rbx, %rbx
	jne	.LBB63_2
# BB#1:                                 # %entry
	cmpl	$1, srcMode(%rip)
	jne	.LBB63_67
.LBB63_2:                               # %if.end
	movl	srcMode(%rip), %eax
	cmpl	$3, %eax
	je	.LBB63_6
# BB#3:                                 # %if.end
	cmpl	$2, %eax
	je	.LBB63_7
# BB#4:                                 # %if.end
	cmpl	$1, %eax
	jne	.LBB63_9
# BB#5:                                 # %sw.bb
	movl	$inName, %edi
	movl	$.L.str.96, %esi
	jmp	.LBB63_8
.LBB63_6:                               # %sw.bb2
	movl	$inName, %edi
	movq	%rbx, %rsi
	callq	copyFileName
	movl	$outName, %edi
	movq	%rbx, %rsi
	callq	copyFileName
	movl	$outName, %edi
	movl	$.L.str.12, %esi
	callq	strcat
	cmpl	$1, srcMode(%rip)
	jne	.LBB63_10
	jmp	.LBB63_13
.LBB63_7:                               # %sw.bb3
	movl	$inName, %edi
	movq	%rbx, %rsi
.LBB63_8:                               # %sw.epilog
	callq	copyFileName
	movl	$outName, %edi
	movl	$.L.str.97, %esi
	callq	copyFileName
.LBB63_9:                               # %sw.epilog
	cmpl	$1, srcMode(%rip)
	je	.LBB63_13
.LBB63_10:                              # %land.lhs.true5
	movl	$inName, %edi
	callq	containsDubiousChars
	testb	%al, %al
	je	.LBB63_13
# BB#11:                                # %if.then7
	cmpb	$0, noisy(%rip)
	je	.LBB63_65
# BB#12:                                # %if.then9
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.98, %esi
	jmp	.LBB63_29
.LBB63_13:                              # %if.end12
	cmpl	$1, srcMode(%rip)
	je	.LBB63_15
# BB#14:                                # %land.lhs.true15
	movl	$inName, %edi
	callq	fileExists
	testb	%al, %al
	je	.LBB63_63
.LBB63_15:                              # %for.cond.preheader
	xorl	%ebx, %ebx
	cmpl	$3, %ebx
	jg	.LBB63_20
	.p2align	4, 0x90
.LBB63_17:                              # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movq	zSuffix(,%rbx,8), %rsi
	movl	$inName, %edi
	callq	hasSuffix
	testb	%al, %al
	jne	.LBB63_18
# BB#16:                                # %for.inc
                                        #   in Loop: Header=BB63_17 Depth=1
	incq	%rbx
	cmpl	$3, %ebx
	jle	.LBB63_17
.LBB63_20:                              # %for.end
	movl	srcMode(%rip), %eax
	cmpl	$3, %eax
	je	.LBB63_22
# BB#21:                                # %for.end
	cmpl	$2, %eax
	jne	.LBB63_24
.LBB63_22:                              # %if.then39
	leaq	-176(%rbp), %rsi
	movl	$inName, %edi
	callq	stat
	movl	$61440, %eax            # imm = 0xF000
	andl	-152(%rbp), %eax
	cmpl	$16384, %eax            # imm = 0x4000
	jne	.LBB63_24
# BB#23:                                # %if.then43
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.101, %esi
	jmp	.LBB63_29
.LBB63_18:                              # %if.then27
	cmpb	$0, noisy(%rip)
	je	.LBB63_65
# BB#19:                                # %if.then29
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movq	zSuffix(,%rbx,8), %r8
	movl	$.L.str.100, %esi
	movl	$inName, %ecx
	xorl	%eax, %eax
	jmp	.LBB63_64
.LBB63_24:                              # %if.end46
	cmpl	$3, srcMode(%rip)
	jne	.LBB63_32
# BB#25:                                # %if.end46
	movb	forceOverwrite(%rip), %al
	testb	%al, %al
	jne	.LBB63_32
# BB#26:                                # %land.lhs.true51
	movl	$inName, %edi
	callq	notAStandardFile
	testb	%al, %al
	je	.LBB63_32
# BB#27:                                # %if.then55
	cmpb	$0, noisy(%rip)
	je	.LBB63_65
# BB#28:                                # %if.then57
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.102, %esi
.LBB63_29:                              # %if.end11
	movl	$inName, %ecx
.LBB63_30:                              # %if.end11
	xorl	%eax, %eax
.LBB63_31:                              # %if.end11
	callq	fprintf
	jmp	.LBB63_65
.LBB63_32:                              # %if.end60
	cmpl	$3, srcMode(%rip)
	jne	.LBB63_36
# BB#33:                                # %land.lhs.true63
	movl	$outName, %edi
	callq	fileExists
	testb	%al, %al
	je	.LBB63_36
# BB#34:                                # %if.then67
	cmpb	$0, forceOverwrite(%rip)
	je	.LBB63_53
# BB#35:                                # %if.then69
	movl	$outName, %edi
	callq	remove
.LBB63_36:                              # %if.end73
	cmpl	$3, srcMode(%rip)
	jne	.LBB63_40
# BB#37:                                # %if.end73
	movb	forceOverwrite(%rip), %al
	testb	%al, %al
	jne	.LBB63_40
# BB#38:                                # %land.lhs.true78
	movl	$inName, %edi
	callq	countHardLinks
	movl	%eax, %ebx
	testl	%ebx, %ebx
	jle	.LBB63_40
# BB#39:                                # %if.then82
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	cmpl	$1, %ebx
	movl	$.L.str.105, %eax
	movl	$.L.str.16, %r9d
	cmovgq	%rax, %r9
	movl	$.L.str.104, %esi
	movl	$inName, %ecx
	xorl	%eax, %eax
	movl	%ebx, %r8d
	callq	fprintf
	jmp	.LBB63_65
.LBB63_40:                              # %if.end86
	cmpl	$3, srcMode(%rip)
	jne	.LBB63_42
# BB#41:                                # %if.then89
	movl	$inName, %edi
	callq	saveInputFileMetaInfo
.LBB63_42:                              # %if.end90
	movl	srcMode(%rip), %eax
	cmpl	$3, %eax
	je	.LBB63_47
# BB#43:                                # %if.end90
	cmpl	$2, %eax
	je	.LBB63_51
# BB#44:                                # %if.end90
	cmpl	$1, %eax
	jne	.LBB63_68
# BB#45:                                # %sw.bb91
	movq	stdin(%rip), %r14
	movq	stdout(%rip), %rbx
	movq	%rbx, %rdi
	callq	fileno
	movl	%eax, %edi
	callq	isatty
	testl	%eax, %eax
	je	.LBB63_57
# BB#46:                                # %if.then95
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.106, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.107, %esi
	xorl	%eax, %eax
	movq	%rdx, %rcx
	jmp	.LBB63_31
.LBB63_47:                              # %sw.bb120
	movl	$inName, %edi
	movl	$.L.str.108, %esi
	callq	fopen
	movq	%rax, %r14
	movl	$outName, %edi
	movl	$.L.str.109, %esi
	callq	fopen_output_safely
	movq	%rax, %rbx
	testq	%rbx, %rbx
	je	.LBB63_54
# BB#48:                                # %if.end134
	testq	%r14, %r14
	jne	.LBB63_57
# BB#49:                                # %if.then137
	movq	stderr(%rip), %r14
	movq	progName(%rip), %r15
	callq	__errno_location
	movl	(%rax), %edi
	callq	strerror
	movq	%rax, %r8
	movl	$.L.str.99, %esi
	movl	$inName, %ecx
	xorl	%eax, %eax
	movq	%r14, %rdi
	movq	%r15, %rdx
	callq	fprintf
	testq	%rbx, %rbx
	je	.LBB63_65
# BB#50:                                # %if.then143
	movq	%rbx, %rdi
	callq	fclose
	jmp	.LBB63_65
.LBB63_51:                              # %sw.bb99
	movl	$inName, %edi
	movl	$.L.str.108, %esi
	callq	fopen
	movq	%rax, %r14
	movq	stdout(%rip), %rbx
	movq	%rbx, %rdi
	callq	fileno
	movl	%eax, %edi
	callq	isatty
	testl	%eax, %eax
	je	.LBB63_56
# BB#52:                                # %if.then104
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.106, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.107, %esi
	xorl	%eax, %eax
	movq	%rdx, %rcx
	callq	fprintf
	testq	%r14, %r14
	jne	.LBB63_55
	jmp	.LBB63_65
.LBB63_53:                              # %if.else
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.103, %esi
	movl	$outName, %ecx
	jmp	.LBB63_30
.LBB63_54:                              # %if.then125
	movq	stderr(%rip), %r15
	movq	progName(%rip), %r12
	callq	__errno_location
	movl	(%rax), %edi
	callq	strerror
	movq	%rax, %rbx
	movl	$.L.str.110, %esi
	movl	$outName, %ecx
	xorl	%eax, %eax
	movq	%r15, %rdi
	movq	%r12, %rdx
	movq	%rbx, %r8
	callq	fprintf
	testq	%r14, %r14
	je	.LBB63_65
.LBB63_55:                              # %if.then109
	movq	%r14, %rdi
	callq	fclose
	jmp	.LBB63_65
.LBB63_56:                              # %if.end112
	testq	%r14, %r14
	je	.LBB63_63
.LBB63_57:                              # %sw.epilog147
	cmpl	$0, verbosity(%rip)
	jle	.LBB63_59
# BB#58:                                # %if.then150
	movq	stderr(%rip), %rdi
	movl	$.L.str.112, %esi
	movl	$inName, %edx
	xorl	%eax, %eax
	callq	fprintf
	movl	$inName, %edi
	callq	pad
	movq	stderr(%rip), %rdi
	callq	fflush
.LBB63_59:                              # %if.end153
	movq	%rbx, outputHandleJustInCase(%rip)
	movb	$1, deleteOutputOnInterrupt(%rip)
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	compressStream
	movq	$0, outputHandleJustInCase(%rip)
	cmpl	$3, srcMode(%rip)
	jne	.LBB63_62
# BB#60:                                # %if.then156
	movl	$outName, %edi
	callq	applySavedMetaInfoToOutputFile
	movb	$0, deleteOutputOnInterrupt(%rip)
	cmpb	$0, keepInputFiles(%rip)
	jne	.LBB63_62
# BB#61:                                # %if.then158
	movl	$inName, %edi
	callq	remove
	testl	%eax, %eax
	jne	.LBB63_69
.LBB63_62:                              # %if.end165
	movb	$0, deleteOutputOnInterrupt(%rip)
	jmp	.LBB63_66
.LBB63_63:                              # %if.then18
	movq	stderr(%rip), %r14
	movq	progName(%rip), %r15
	callq	__errno_location
	movl	(%rax), %edi
	callq	strerror
	movq	%rax, %rbx
	movl	$.L.str.99, %esi
	movl	$inName, %ecx
	xorl	%eax, %eax
	movq	%r14, %rdi
	movq	%r15, %rdx
	movq	%rbx, %r8
.LBB63_64:                              # %if.end11
	callq	fprintf
.LBB63_65:                              # %if.end11
	movl	$1, %edi
	callq	setExit
.LBB63_66:                              # %return
	addq	$144, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB63_67:                              # %if.then
	movl	$.L.str.95, %edi
	callq	panic
.LBB63_68:                              # %sw.default
	movl	$.L.str.111, %edi
	callq	panic
.LBB63_69:                              # %if.then162
	callq	ioError
.Lfunc_end63:
	.size	compress, .Lfunc_end63-compress
	.cfi_endproc

	.p2align	4, 0x90
	.type	uncompress,@function
uncompress:                             # @uncompress
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi329:
	.cfi_def_cfa_offset 16
.Lcfi330:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi331:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$144, %rsp
.Lcfi332:
	.cfi_offset %rbx, -48
.Lcfi333:
	.cfi_offset %r12, -40
.Lcfi334:
	.cfi_offset %r14, -32
.Lcfi335:
	.cfi_offset %r15, -24
	movq	%rdi, %rbx
	movb	$0, deleteOutputOnInterrupt(%rip)
	testq	%rbx, %rbx
	jne	.LBB64_2
# BB#1:                                 # %entry
	cmpl	$1, srcMode(%rip)
	jne	.LBB64_80
.LBB64_2:                               # %if.end
	movl	srcMode(%rip), %eax
	cmpl	$3, %eax
	je	.LBB64_6
# BB#3:                                 # %if.end
	cmpl	$2, %eax
	je	.LBB64_11
# BB#4:                                 # %if.end
	cmpl	$1, %eax
	jne	.LBB64_13
# BB#5:                                 # %sw.bb
	movl	$inName, %edi
	movl	$.L.str.96, %esi
	jmp	.LBB64_12
.LBB64_6:                               # %sw.bb2
	movl	$inName, %edi
	movq	%rbx, %rsi
	callq	copyFileName
	movl	$outName, %edi
	movq	%rbx, %rsi
	callq	copyFileName
	xorl	%ebx, %ebx
	cmpl	$3, %ebx
	jle	.LBB64_8
	jmp	.LBB64_10
	.p2align	4, 0x90
.LBB64_9:                               # %for.inc
                                        #   in Loop: Header=BB64_8 Depth=1
	incq	%rbx
	cmpl	$3, %ebx
	jg	.LBB64_10
.LBB64_8:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movq	zSuffix(,%rbx,8), %rsi
	movq	unzSuffix(,%rbx,8), %rdx
	movl	$outName, %edi
	callq	mapSuffix
	testb	%al, %al
	je	.LBB64_9
	jmp	.LBB64_13
.LBB64_11:                              # %sw.bb9
	movl	$inName, %edi
	movq	%rbx, %rsi
.LBB64_12:                              # %zzz
	callq	copyFileName
	movl	$outName, %edi
	movl	$.L.str.97, %esi
	callq	copyFileName
.LBB64_13:                              # %zzz
	xorl	%ebx, %ebx
	cmpl	$1, srcMode(%rip)
	je	.LBB64_22
.LBB64_15:                              # %land.lhs.true11
	movl	$inName, %edi
	callq	containsDubiousChars
	testb	%al, %al
	je	.LBB64_22
# BB#16:                                # %if.then14
	cmpb	$0, noisy(%rip)
	je	.LBB64_21
# BB#17:                                # %if.then16
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.98, %esi
	jmp	.LBB64_18
.LBB64_10:                              # %for.end
	movl	$outName, %edi
	movl	$.L.str.121, %esi
	callq	strcat
	movb	$1, %bl
	cmpl	$1, srcMode(%rip)
	jne	.LBB64_15
.LBB64_22:                              # %if.end19
	cmpl	$1, srcMode(%rip)
	je	.LBB64_26
# BB#23:                                # %land.lhs.true22
	movl	$inName, %edi
	callq	fileExists
	testb	%al, %al
	je	.LBB64_24
.LBB64_26:                              # %if.end29
	movl	srcMode(%rip), %eax
	cmpl	$3, %eax
	je	.LBB64_28
# BB#27:                                # %if.end29
	cmpl	$2, %eax
	jne	.LBB64_30
.LBB64_28:                              # %if.then34
	leaq	-176(%rbp), %rsi
	movl	$inName, %edi
	callq	stat
	movl	$61440, %eax            # imm = 0xF000
	andl	-152(%rbp), %eax
	cmpl	$16384, %eax            # imm = 0x4000
	jne	.LBB64_30
# BB#29:                                # %if.then38
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.101, %esi
	jmp	.LBB64_18
.LBB64_30:                              # %if.end41
	cmpl	$3, srcMode(%rip)
	jne	.LBB64_35
# BB#31:                                # %if.end41
	movb	forceOverwrite(%rip), %al
	testb	%al, %al
	jne	.LBB64_35
# BB#32:                                # %land.lhs.true46
	movl	$inName, %edi
	callq	notAStandardFile
	testb	%al, %al
	je	.LBB64_35
# BB#33:                                # %if.then50
	cmpb	$0, noisy(%rip)
	je	.LBB64_21
# BB#34:                                # %if.then52
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.102, %esi
.LBB64_18:                              # %if.end18
	movl	$inName, %ecx
.LBB64_19:                              # %if.end18
	xorl	%eax, %eax
.LBB64_20:                              # %if.end18
	callq	fprintf
	jmp	.LBB64_21
.LBB64_35:                              # %if.end55
	testb	%bl, %bl
	je	.LBB64_38
# BB#36:                                # %if.end55
	movb	noisy(%rip), %al
	testb	%al, %al
	je	.LBB64_38
# BB#37:                                # %if.then59
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.122, %esi
	movl	$inName, %ecx
	movl	$outName, %r8d
	xorl	%eax, %eax
	callq	fprintf
.LBB64_38:                              # %if.end62
	cmpl	$3, srcMode(%rip)
	jne	.LBB64_42
# BB#39:                                # %land.lhs.true65
	movl	$outName, %edi
	callq	fileExists
	testb	%al, %al
	je	.LBB64_42
# BB#40:                                # %if.then69
	cmpb	$0, forceOverwrite(%rip)
	je	.LBB64_81
# BB#41:                                # %if.then71
	movl	$outName, %edi
	callq	remove
.LBB64_42:                              # %if.end75
	cmpl	$3, srcMode(%rip)
	jne	.LBB64_46
# BB#43:                                # %if.end75
	movb	forceOverwrite(%rip), %al
	testb	%al, %al
	jne	.LBB64_46
# BB#44:                                # %land.lhs.true80
	movl	$inName, %edi
	callq	countHardLinks
	movl	%eax, %ebx
	testl	%ebx, %ebx
	jle	.LBB64_46
# BB#45:                                # %if.then84
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	cmpl	$1, %ebx
	movl	$.L.str.105, %eax
	movl	$.L.str.16, %r9d
	cmovgq	%rax, %r9
	movl	$.L.str.104, %esi
	movl	$inName, %ecx
	xorl	%eax, %eax
	movl	%ebx, %r8d
	callq	fprintf
	jmp	.LBB64_21
.LBB64_46:                              # %if.end88
	cmpl	$3, srcMode(%rip)
	jne	.LBB64_48
# BB#47:                                # %if.then91
	movl	$inName, %edi
	callq	saveInputFileMetaInfo
.LBB64_48:                              # %if.end92
	movl	srcMode(%rip), %eax
	cmpl	$3, %eax
	je	.LBB64_63
# BB#49:                                # %if.end92
	cmpl	$2, %eax
	je	.LBB64_53
# BB#50:                                # %if.end92
	cmpl	$1, %eax
	jne	.LBB64_69
# BB#51:                                # %sw.bb93
	movq	stdin(%rip), %r14
	movq	stdout(%rip), %rbx
	movq	%r14, %rdi
	callq	fileno
	movl	%eax, %edi
	callq	isatty
	testl	%eax, %eax
	je	.LBB64_55
# BB#52:                                # %if.then97
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.123, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.107, %esi
	xorl	%eax, %eax
	movq	%rdx, %rcx
	jmp	.LBB64_20
.LBB64_24:                              # %if.then25
	movq	stderr(%rip), %r14
	movq	progName(%rip), %r15
	callq	__errno_location
	movl	(%rax), %edi
	callq	strerror
	movq	%rax, %rbx
	movl	$.L.str.99, %esi
.LBB64_25:                              # %if.end191
	movl	$inName, %ecx
	xorl	%eax, %eax
	movq	%r14, %rdi
	movq	%r15, %rdx
	movq	%rbx, %r8
	callq	fprintf
.LBB64_21:                              # %if.end18
	movl	$1, %edi
	callq	setExit
.LBB64_79:                              # %if.end191
	addq	$144, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB64_63:                              # %sw.bb115
	movl	$inName, %edi
	movl	$.L.str.108, %esi
	callq	fopen
	movq	%rax, %r14
	movl	$outName, %edi
	movl	$.L.str.109, %esi
	callq	fopen_output_safely
	movq	%rax, %rbx
	testq	%rbx, %rbx
	je	.LBB64_64
# BB#66:                                # %if.end129
	testq	%r14, %r14
	jne	.LBB64_55
# BB#67:                                # %if.then132
	movq	stderr(%rip), %r14
	movq	progName(%rip), %r15
	callq	__errno_location
	movl	(%rax), %edi
	callq	strerror
	movq	%rax, %r8
	movl	$.L.str.99, %esi
	movl	$inName, %ecx
	xorl	%eax, %eax
	movq	%r14, %rdi
	movq	%r15, %rdx
	callq	fprintf
	testq	%rbx, %rbx
	je	.LBB64_21
# BB#68:                                # %if.then138
	movq	%rbx, %rdi
	callq	fclose
	jmp	.LBB64_21
.LBB64_53:                              # %sw.bb101
	movl	$inName, %edi
	movl	$.L.str.108, %esi
	callq	fopen
	movq	%rax, %r14
	testq	%r14, %r14
	je	.LBB64_62
# BB#54:
	movq	stdout(%rip), %rbx
.LBB64_55:                              # %sw.epilog142
	cmpl	$0, verbosity(%rip)
	jle	.LBB64_57
# BB#56:                                # %if.then145
	movq	stderr(%rip), %rdi
	movl	$.L.str.112, %esi
	movl	$inName, %edx
	xorl	%eax, %eax
	callq	fprintf
	movl	$inName, %edi
	callq	pad
	movq	stderr(%rip), %rdi
	callq	fflush
.LBB64_57:                              # %if.end148
	movq	%rbx, outputHandleJustInCase(%rip)
	movb	$1, deleteOutputOnInterrupt(%rip)
	movq	%r14, %rdi
	movq	%rbx, %rsi
	callq	uncompressStream
	movl	%eax, %ebx
	movq	$0, outputHandleJustInCase(%rip)
	testb	%bl, %bl
	je	.LBB64_70
# BB#58:                                # %if.then151
	cmpl	$3, srcMode(%rip)
	jne	.LBB64_72
# BB#59:                                # %if.then154
	movl	$outName, %edi
	callq	applySavedMetaInfoToOutputFile
	movb	$0, deleteOutputOnInterrupt(%rip)
	cmpb	$0, keepInputFiles(%rip)
	jne	.LBB64_72
# BB#60:                                # %if.then156
	movl	$inName, %edi
	callq	remove
	testl	%eax, %eax
	je	.LBB64_72
# BB#61:                                # %if.then160
	callq	ioError
.LBB64_81:                              # %if.else
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.103, %esi
	movl	$outName, %ecx
	jmp	.LBB64_19
.LBB64_70:                              # %if.else164
	movb	$1, unzFailsExist(%rip)
	movb	$0, deleteOutputOnInterrupt(%rip)
	cmpl	$3, srcMode(%rip)
	jne	.LBB64_72
# BB#71:                                # %if.then167
	movl	$outName, %edi
	callq	remove
	testl	%eax, %eax
	jne	.LBB64_82
.LBB64_72:                              # %if.end175
	movb	$0, deleteOutputOnInterrupt(%rip)
	testb	%bl, %bl
	je	.LBB64_75
# BB#73:                                # %if.then177
	cmpl	$0, verbosity(%rip)
	jle	.LBB64_79
# BB#74:                                # %if.then180
	movq	stderr(%rip), %rdi
	movl	$.L.str.126, %esi
	jmp	.LBB64_77
.LBB64_75:                              # %if.else183
	movl	$2, %edi
	callq	setExit
	movq	stderr(%rip), %rdi
	cmpl	$0, verbosity(%rip)
	jle	.LBB64_78
# BB#76:                                # %if.then186
	movl	$.L.str.127, %esi
.LBB64_77:                              # %if.end191
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB64_79
.LBB64_64:                              # %if.then120
	movq	stderr(%rip), %r15
	movq	progName(%rip), %r12
	callq	__errno_location
	movl	(%rax), %edi
	callq	strerror
	movq	%rax, %rbx
	movl	$.L.str.110, %esi
	movl	$outName, %ecx
	xorl	%eax, %eax
	movq	%r15, %rdi
	movq	%r12, %rdx
	movq	%rbx, %r8
	callq	fprintf
	testq	%r14, %r14
	je	.LBB64_21
# BB#65:                                # %if.then126
	movq	%r14, %rdi
	callq	fclose
	jmp	.LBB64_21
.LBB64_62:                              # %if.then105
	movq	stderr(%rip), %r14
	movq	progName(%rip), %r15
	callq	__errno_location
	movl	(%rax), %edi
	callq	strerror
	movq	%rax, %rbx
	movl	$.L.str.124, %esi
	jmp	.LBB64_25
.LBB64_78:                              # %if.else188
	movq	progName(%rip), %rdx
	movl	$.L.str.128, %esi
	movl	$inName, %ecx
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB64_79
.LBB64_80:                              # %if.then
	movl	$.L.str.120, %edi
	callq	panic
.LBB64_69:                              # %sw.default
	movl	$.L.str.125, %edi
	callq	panic
.LBB64_82:                              # %if.then172
	callq	ioError
.Lfunc_end64:
	.size	uncompress, .Lfunc_end64-uncompress
	.cfi_endproc

	.p2align	4, 0x90
	.type	setExit,@function
setExit:                                # @setExit
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi336:
	.cfi_def_cfa_offset 16
.Lcfi337:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi338:
	.cfi_def_cfa_register %rbp
	cmpl	exitValue(%rip), %edi
	jle	.LBB65_2
# BB#1:                                 # %if.then
	movl	%edi, exitValue(%rip)
.LBB65_2:                               # %if.end
	popq	%rbp
	retq
.Lfunc_end65:
	.size	setExit, .Lfunc_end65-setExit
	.cfi_endproc

	.p2align	4, 0x90
	.type	testf,@function
testf:                                  # @testf
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi339:
	.cfi_def_cfa_offset 16
.Lcfi340:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi341:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$152, %rsp
.Lcfi342:
	.cfi_offset %rbx, -40
.Lcfi343:
	.cfi_offset %r14, -32
.Lcfi344:
	.cfi_offset %r15, -24
	movq	%rdi, %rbx
	movb	$0, deleteOutputOnInterrupt(%rip)
	testq	%rbx, %rbx
	jne	.LBB66_2
# BB#1:                                 # %entry
	cmpl	$1, srcMode(%rip)
	jne	.LBB66_38
.LBB66_2:                               # %if.end
	movl	$outName, %edi
	movl	$.L.str.18, %esi
	callq	copyFileName
	movl	srcMode(%rip), %eax
	cmpl	$3, %eax
	je	.LBB66_6
# BB#3:                                 # %if.end
	cmpl	$2, %eax
	je	.LBB66_6
# BB#4:                                 # %if.end
	cmpl	$1, %eax
	jne	.LBB66_8
# BB#5:                                 # %sw.bb
	movl	$inName, %edi
	movl	$.L.str.96, %esi
	jmp	.LBB66_7
.LBB66_6:                               # %sw.bb3
	movl	$inName, %edi
	movq	%rbx, %rsi
.LBB66_7:                               # %sw.epilog
	callq	copyFileName
.LBB66_8:                               # %sw.epilog
	cmpl	$1, srcMode(%rip)
	je	.LBB66_15
# BB#9:                                 # %land.lhs.true5
	movl	$inName, %edi
	callq	containsDubiousChars
	testb	%al, %al
	je	.LBB66_15
# BB#10:                                # %if.then6
	cmpb	$0, noisy(%rip)
	je	.LBB66_14
# BB#11:                                # %if.then8
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.98, %esi
	jmp	.LBB66_12
.LBB66_15:                              # %if.end11
	cmpl	$1, srcMode(%rip)
	je	.LBB66_19
# BB#16:                                # %land.lhs.true14
	movl	$inName, %edi
	callq	fileExists
	testb	%al, %al
	je	.LBB66_17
.LBB66_19:                              # %if.end21
	cmpl	$1, srcMode(%rip)
	je	.LBB66_22
# BB#20:                                # %if.then24
	leaq	-168(%rbp), %rsi
	movl	$inName, %edi
	callq	stat
	movl	$61440, %eax            # imm = 0xF000
	andl	-144(%rbp), %eax
	cmpl	$16384, %eax            # imm = 0x4000
	jne	.LBB66_22
# BB#21:                                # %if.then28
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.101, %esi
.LBB66_12:                              # %if.end10
	movl	$inName, %ecx
	xorl	%eax, %eax
	jmp	.LBB66_13
.LBB66_22:                              # %if.end31
	movl	srcMode(%rip), %eax
	leal	-2(%rax), %ecx
	cmpl	$2, %ecx
	jae	.LBB66_23
# BB#26:                                # %sw.bb40
	movl	$inName, %edi
	movl	$.L.str.108, %esi
	callq	fopen
	movq	%rax, %rbx
	testq	%rbx, %rbx
	jne	.LBB66_30
# BB#27:                                # %if.then44
	movq	stderr(%rip), %r14
	movq	progName(%rip), %r15
	callq	__errno_location
	movl	(%rax), %edi
	callq	strerror
	movq	%rax, %rbx
	movl	$.L.str.124, %esi
	jmp	.LBB66_18
.LBB66_23:                              # %if.end31
	cmpl	$1, %eax
	jne	.LBB66_28
# BB#24:                                # %sw.bb32
	movq	stdin(%rip), %rdi
	callq	fileno
	movl	%eax, %edi
	callq	isatty
	testl	%eax, %eax
	je	.LBB66_29
# BB#25:                                # %if.then36
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.123, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.107, %esi
	xorl	%eax, %eax
	movq	%rdx, %rcx
.LBB66_13:                              # %if.end10
	callq	fprintf
	jmp	.LBB66_14
.LBB66_17:                              # %if.then17
	movq	stderr(%rip), %r14
	movq	progName(%rip), %r15
	callq	__errno_location
	movl	(%rax), %edi
	callq	strerror
	movq	%rax, %rbx
	movl	$.L.str.136, %esi
.LBB66_18:                              # %if.end67
	movl	$inName, %ecx
	xorl	%eax, %eax
	movq	%r14, %rdi
	movq	%r15, %rdx
	movq	%rbx, %r8
	callq	fprintf
.LBB66_14:                              # %if.end10
	movl	$1, %edi
	callq	setExit
.LBB66_37:                              # %if.end67
	addq	$152, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB66_29:                              # %if.end39
	movq	stdin(%rip), %rbx
.LBB66_30:                              # %sw.epilog49
	cmpl	$0, verbosity(%rip)
	jle	.LBB66_32
# BB#31:                                # %if.then52
	movq	stderr(%rip), %rdi
	movl	$.L.str.112, %esi
	movl	$inName, %edx
	xorl	%eax, %eax
	callq	fprintf
	movl	$inName, %edi
	callq	pad
	movq	stderr(%rip), %rdi
	callq	fflush
.LBB66_32:                              # %if.end55
	movq	$0, outputHandleJustInCase(%rip)
	movq	%rbx, %rdi
	callq	testStream
	movl	%eax, %ebx
	testb	%bl, %bl
	je	.LBB66_35
# BB#33:                                # %if.end55
	movl	verbosity(%rip), %eax
	testl	%eax, %eax
	jle	.LBB66_35
# BB#34:                                # %if.then62
	movq	stderr(%rip), %rdi
	movl	$.L.str.138, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB66_35:                              # %if.end64
	testb	%bl, %bl
	jne	.LBB66_37
# BB#36:                                # %if.then66
	movb	$1, testFailsExist(%rip)
	jmp	.LBB66_37
.LBB66_38:                              # %if.then
	movl	$.L.str.135, %edi
	callq	panic
.LBB66_28:                              # %sw.default
	movl	$.L.str.137, %edi
	callq	panic
.Lfunc_end66:
	.size	testf, .Lfunc_end66-testf
	.cfi_endproc

	.p2align	4, 0x90
	.type	fallbackQSort3,@function
fallbackQSort3:                         # @fallbackQSort3
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi345:
	.cfi_def_cfa_offset 16
.Lcfi346:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi347:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$936, %rsp              # imm = 0x3A8
.Lcfi348:
	.cfi_offset %rbx, -56
.Lcfi349:
	.cfi_offset %r12, -48
.Lcfi350:
	.cfi_offset %r13, -40
.Lcfi351:
	.cfi_offset %r14, -32
.Lcfi352:
	.cfi_offset %r15, -24
	movq	%rsi, %r14
	movq	%rdi, %r12
	movl	%edx, -976(%rbp)
	movl	%ecx, -576(%rbp)
	movl	$1, %ecx
	xorl	%eax, %eax
	movq	%rax, -136(%rbp)        # 8-byte Spill
	jmp	.LBB67_1
	.p2align	4, 0x90
.LBB67_35:                              # %while.end159
                                        #   in Loop: Header=BB67_1 Depth=1
	addl	-144(%rbp), %r11d       # 4-byte Folded Reload
	movq	-120(%rbp), %r15        # 8-byte Reload
	leal	(%r15,%r11), %eax
	leal	-1(%rsi,%rax), %eax
	movl	-44(%rbp), %r10d        # 4-byte Reload
	addl	%r12d, %r10d
	addl	%r9d, %r10d
	leal	-1(%rsi,%r11), %ecx
	subl	%r12d, %r13d
	decl	%r13d
	subl	%r9d, %r13d
	movq	-88(%rbp), %r9          # 8-byte Reload
	leal	-1(%r9), %edx
	cmpl	%r13d, %ecx
	movslq	%edx, %rcx
	leaq	-976(%rbp,%rcx,4), %r8
	movl	%r15d, %esi
	cmovlel	%r10d, %esi
	movq	-128(%rbp), %rdx        # 8-byte Reload
	movl	%edx, %edi
	cmovgl	%eax, %edi
	cmovlel	%r15d, %r10d
	cmovgl	%edx, %eax
	movq	-168(%rbp), %rbx        # 8-byte Reload
	movl	%esi, (%r8,%rbx,4)
	leaq	-576(%rbp,%rcx,4), %rcx
	movl	%edi, (%rcx,%rbx,4)
	movslq	%r9d, %rcx
	leaq	-976(%rbp,%rcx,4), %rdx
	movl	%r10d, (%rdx,%rbx,4)
	leaq	-576(%rbp,%rcx,4), %rcx
	movl	%eax, (%rcx,%rbx,4)
	leal	1(%r9,%rbx), %ecx
	movq	-56(%rbp), %r12         # 8-byte Reload
.LBB67_1:                               # %while.cond.outer
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB67_2 Depth 2
                                        #     Child Loop BB67_11 Depth 2
                                        #       Child Loop BB67_12 Depth 3
                                        #         Child Loop BB67_13 Depth 4
                                        #       Child Loop BB67_22 Depth 3
                                        #         Child Loop BB67_19 Depth 4
                                        #     Child Loop BB67_31 Depth 2
                                        #     Child Loop BB67_34 Depth 2
	leal	-1(%rcx), %eax
	cltq
	leaq	-576(%rbp,%rax,4), %rdx
	movq	%rdx, -64(%rbp)         # 8-byte Spill
	leaq	-976(%rbp,%rax,4), %r15
	movl	%ecx, %eax
	movq	%rax, -88(%rbp)         # 8-byte Spill
	xorl	%r13d, %r13d
	jmp	.LBB67_2
	.p2align	4, 0x90
.LBB67_6:                               # %if.then9
                                        #   in Loop: Header=BB67_2 Depth=2
	movq	%r12, %rdi
	movq	%r14, %rsi
	movl	%ebx, %edx
                                        # kill: %ECX<def> %ECX<kill> %RCX<kill>
	callq	fallbackSimpleSort
	decq	%r13
.LBB67_2:                               # %while.cond
                                        #   Parent Loop BB67_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-88(%rbp), %rax         # 8-byte Reload
	leaq	(%rax,%r13), %rax
	testl	%eax, %eax
	jle	.LBB67_36
# BB#3:                                 # %while.body
                                        #   in Loop: Header=BB67_2 Depth=2
	cmpl	$100, %eax
	jl	.LBB67_5
# BB#4:                                 # %if.then
                                        #   in Loop: Header=BB67_2 Depth=2
	movl	$1004, %edi             # imm = 0x3EC
	callq	BZ2_bz__AssertH__fail
.LBB67_5:                               # %if.end
                                        #   in Loop: Header=BB67_2 Depth=2
	movl	(%r15,%r13,4), %ebx
	movq	-64(%rbp), %rax         # 8-byte Reload
	movl	(%rax,%r13,4), %ecx
	movl	%ecx, %eax
	subl	%ebx, %eax
	cmpl	$9, %eax
	jle	.LBB67_6
# BB#7:                                 # %if.end10
                                        #   in Loop: Header=BB67_1 Depth=1
	movq	-136(%rbp), %rsi        # 8-byte Reload
	imull	$7621, %esi, %esi       # imm = 0x1DC5
	incl	%esi
	andl	$32767, %esi            # imm = 0x7FFF
	movq	%rsi, %rax
	movl	$2863311531, %edx       # imm = 0xAAAAAAAB
	imulq	%rdx, %rax
	shrq	$33, %rax
	leal	(%rax,%rax,2), %eax
	movq	-88(%rbp), %rdx         # 8-byte Reload
	leal	-1(%rdx), %edi
	movq	%rsi, -136(%rbp)        # 8-byte Spill
	movl	%esi, %edx
	subl	%eax, %edx
	movl	%ebx, %eax
	je	.LBB67_10
# BB#8:                                 # %if.end10
                                        #   in Loop: Header=BB67_1 Depth=1
	cmpl	$1, %edx
	movl	%ecx, %eax
	jne	.LBB67_10
# BB#9:                                 # %if.then19
                                        #   in Loop: Header=BB67_1 Depth=1
	leal	(%rbx,%rcx), %eax
	sarl	%eax
.LBB67_10:                              # %if.end31
                                        #   in Loop: Header=BB67_1 Depth=1
	movslq	%ebx, %rdx
	movq	%rdx, -152(%rbp)        # 8-byte Spill
	addq	%r13, %rdi
	movq	%rdi, -160(%rbp)        # 8-byte Spill
	cltq
	movl	(%r12,%rax,4), %eax
	movl	(%r14,%rax,4), %r15d
	leal	-1(%rbx), %eax
	movl	%eax, -108(%rbp)        # 4-byte Spill
	leal	1(%rcx), %eax
	movl	%eax, -104(%rbp)        # 4-byte Spill
	movl	%ecx, %eax
	notl	%eax
	movq	%rax, -176(%rbp)        # 8-byte Spill
	movl	%ecx, %eax
	movq	%rax, -64(%rbp)         # 8-byte Spill
	movl	%ebx, %eax
	movq	%rax, -80(%rbp)         # 8-byte Spill
	movq	%rcx, -128(%rbp)        # 8-byte Spill
	movl	%ecx, %eax
	movq	%rbx, -120(%rbp)        # 8-byte Spill
	movl	%ebx, %ecx
	movq	%r12, -56(%rbp)         # 8-byte Spill
	movq	%r13, -168(%rbp)        # 8-byte Spill
	jmp	.LBB67_11
	.p2align	4, 0x90
.LBB67_26:                              # %if.end92
                                        #   in Loop: Header=BB67_11 Depth=2
	movslq	%r11d, %rax
	movq	-56(%rbp), %rbx         # 8-byte Reload
	leaq	(%rbx,%rax,4), %rax
	movl	(%rax,%rsi,4), %ecx
	movslq	%r12d, %rdx
	leaq	(%rbx,%rdx,4), %rdx
	movl	(%rdx,%r9,4), %edi
	movl	%edi, (%rax,%rsi,4)
	movl	%ecx, (%rdx,%r9,4)
	leal	1(%r11,%rsi), %ecx
	leal	-1(%r12,%r9), %eax
	movq	%rbx, %r12
.LBB67_11:                              # %while.body33
                                        #   Parent Loop BB67_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB67_12 Depth 3
                                        #         Child Loop BB67_13 Depth 4
                                        #       Child Loop BB67_22 Depth 3
                                        #         Child Loop BB67_19 Depth 4
	movq	-80(%rbp), %rdx         # 8-byte Reload
	movl	%edx, %r10d
	negl	%r10d
	leal	-1(%rdx), %r9d
	movl	-108(%rbp), %esi        # 4-byte Reload
	subl	%edx, %esi
	movl	%esi, -68(%rbp)         # 4-byte Spill
	jmp	.LBB67_12
	.p2align	4, 0x90
.LBB67_16:                              # %if.then45
                                        #   in Loop: Header=BB67_12 Depth=3
	movslq	%r11d, %rcx
	leaq	(%r12,%rcx,4), %rcx
	movl	(%rcx,%rsi,4), %edx
	movq	-80(%rbp), %rbx         # 8-byte Reload
	movslq	%ebx, %rbx
	movl	(%r12,%rbx,4), %edi
	movl	%edi, (%rcx,%rsi,4)
	movl	%edx, (%r12,%rbx,4)
	incl	%ebx
	movq	%rbx, -80(%rbp)         # 8-byte Spill
	leal	1(%r11,%rsi), %ecx
	decl	%r10d
	incl	%r9d
	decl	-68(%rbp)               # 4-byte Folded Spill
.LBB67_12:                              # %while.body35.outer
                                        #   Parent Loop BB67_1 Depth=1
                                        #     Parent Loop BB67_11 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB67_13 Depth 4
	movslq	%ecx, %rcx
	leaq	(%r12,%rcx,4), %rbx
	movl	%ecx, %r11d
	movl	%r9d, %edx
	subl	%ecx, %edx
	incl	%ecx
	movq	%rbx, %r8
	xorl	%esi, %esi
	jmp	.LBB67_13
	.p2align	4, 0x90
.LBB67_18:                              # %if.end59
                                        #   in Loop: Header=BB67_13 Depth=4
	incq	%rsi
	decl	%edx
	incl	%ecx
	addq	$4, %r8
.LBB67_13:                              # %while.body35
                                        #   Parent Loop BB67_1 Depth=1
                                        #     Parent Loop BB67_11 Depth=2
                                        #       Parent Loop BB67_12 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	leal	(%r11,%rsi), %edi
	cmpl	%eax, %edi
	jg	.LBB67_14
# BB#15:                                # %if.end38
                                        #   in Loop: Header=BB67_13 Depth=4
	movl	(%rbx,%rsi,4), %edi
	movl	(%r14,%rdi,4), %edi
	subl	%r15d, %edi
	je	.LBB67_16
# BB#17:                                # %if.end56
                                        #   in Loop: Header=BB67_13 Depth=4
	testl	%edi, %edi
	jle	.LBB67_18
.LBB67_14:                              # %while.body62.preheader
                                        #   in Loop: Header=BB67_11 Depth=2
	movq	%r10, -144(%rbp)        # 8-byte Spill
	leaq	(%r11,%rsi), %r10
	movl	-104(%rbp), %r13d       # 4-byte Reload
	movq	-64(%rbp), %rdi         # 8-byte Reload
	subl	%edi, %r13d
	movl	%edi, %r9d
	notl	%r9d
	movq	-176(%rbp), %rbx        # 8-byte Reload
	leal	(%rbx,%rdi), %edi
	jmp	.LBB67_22
	.p2align	4, 0x90
.LBB67_21:                              # %if.then72
                                        #   in Loop: Header=BB67_22 Depth=3
	movslq	%r12d, %rax
	movq	-56(%rbp), %rdi         # 8-byte Reload
	leaq	(%rdi,%rax,4), %rax
	movl	(%rax,%r9,4), %ebx
	movl	%ebx, -100(%rbp)        # 4-byte Spill
	movl	%r13d, -44(%rbp)        # 4-byte Spill
	movq	-64(%rbp), %r13         # 8-byte Reload
	movslq	%r13d, %r13
	movl	(%rdi,%r13,4), %ebx
	movl	%ebx, (%rax,%r9,4)
	movl	-100(%rbp), %eax        # 4-byte Reload
	movl	%eax, (%rdi,%r13,4)
	decl	%r13d
	movq	%r13, -64(%rbp)         # 8-byte Spill
	movl	-44(%rbp), %r13d        # 4-byte Reload
	leal	-1(%r12,%r9), %eax
	movq	%rdi, %r12
	incl	%r13d
	movl	-112(%rbp), %r9d        # 4-byte Reload
	incl	%r9d
	movq	-96(%rbp), %rdi         # 8-byte Reload
	decl	%edi
.LBB67_22:                              # %while.body62.outer
                                        #   Parent Loop BB67_1 Depth=1
                                        #     Parent Loop BB67_11 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB67_19 Depth 4
	movq	%rdi, -96(%rbp)         # 8-byte Spill
	cltq
	leaq	(%r12,%rax,4), %rbx
	movl	%eax, %r12d
	movl	%r9d, -112(%rbp)        # 4-byte Spill
	addl	%r9d, %eax
	xorl	%r9d, %r9d
	jmp	.LBB67_19
	.p2align	4, 0x90
.LBB67_24:                              # %if.end87
                                        #   in Loop: Header=BB67_19 Depth=4
	decq	%r9
	decl	%eax
.LBB67_19:                              # %while.body62
                                        #   Parent Loop BB67_1 Depth=1
                                        #     Parent Loop BB67_11 Depth=2
                                        #       Parent Loop BB67_22 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	leal	(%r12,%r9), %edi
	cmpl	%edi, %r10d
	jg	.LBB67_25
# BB#20:                                # %if.end65
                                        #   in Loop: Header=BB67_19 Depth=4
	movl	(%rbx,%r9,4), %edi
	movl	(%r14,%rdi,4), %edi
	subl	%r15d, %edi
	je	.LBB67_21
# BB#23:                                # %if.end84
                                        #   in Loop: Header=BB67_19 Depth=4
	testl	%edi, %edi
	jns	.LBB67_24
.LBB67_25:                              # %while.end89
                                        #   in Loop: Header=BB67_11 Depth=2
	leal	(%r9,%r12), %edi
	cmpl	%edi, %r10d
	jle	.LBB67_26
# BB#27:                                # %while.end104
                                        #   in Loop: Header=BB67_1 Depth=1
	movl	%r13d, -44(%rbp)        # 4-byte Spill
	movq	-64(%rbp), %r13         # 8-byte Reload
	movq	-80(%rbp), %r15         # 8-byte Reload
	cmpl	%r15d, %r13d
	jge	.LBB67_29
# BB#28:                                # %while.end104.while.cond.outer.backedge_crit_edge
                                        #   in Loop: Header=BB67_1 Depth=1
	movq	-56(%rbp), %r12         # 8-byte Reload
	movq	-160(%rbp), %rcx        # 8-byte Reload
	jmp	.LBB67_1
	.p2align	4, 0x90
.LBB67_29:                              # %if.end107
                                        #   in Loop: Header=BB67_1 Depth=1
	subl	-120(%rbp), %r15d       # 4-byte Folded Reload
	movq	-144(%rbp), %rdi        # 8-byte Reload
	leal	(%r11,%rdi), %edi
	leal	(%rsi,%rdi), %edi
	cmpl	%edi, %r15d
	cmovgl	%edi, %r15d
	movq	-56(%rbp), %r10         # 8-byte Reload
	movq	-152(%rbp), %rbx        # 8-byte Reload
	leaq	(%r10,%rbx,4), %rbx
	movl	-68(%rbp), %edi         # 4-byte Reload
	cmpl	%edi, %edx
	cmovgel	%edx, %edi
	addl	%ecx, %edi
	movslq	%edi, %rcx
	leaq	(%r10,%rcx,4), %rcx
	testl	%r15d, %r15d
	jle	.LBB67_32
	.p2align	4, 0x90
.LBB67_31:                              # %while.body116
                                        #   Parent Loop BB67_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	(%rbx), %edx
	movl	(%rcx), %edi
	movl	%edi, (%rbx)
	movl	%edx, (%rcx)
	decl	%r15d
	addq	$4, %rbx
	addq	$4, %rcx
	testl	%r15d, %r15d
	jg	.LBB67_31
.LBB67_32:                              # %while.end129
                                        #   in Loop: Header=BB67_1 Depth=1
	movq	-128(%rbp), %rdi        # 8-byte Reload
	movl	%edi, %edx
	subl	%r13d, %edx
	movl	%r13d, %ecx
	subl	%r12d, %ecx
	subl	%r9d, %ecx
	cmpl	%ecx, %edx
	cmovlel	%edx, %ecx
	movq	-96(%rbp), %rdx         # 8-byte Reload
	cmpl	%edx, %eax
	cmovgel	%eax, %edx
	leal	2(%rdi,%rdx), %eax
	cltq
	movq	-56(%rbp), %rdx         # 8-byte Reload
	leaq	(%rdx,%rax,4), %rax
	testl	%ecx, %ecx
	jle	.LBB67_35
	.p2align	4, 0x90
.LBB67_34:                              # %while.body146
                                        #   Parent Loop BB67_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	(%r8), %edx
	movl	(%rax), %edi
	movl	%edi, (%r8)
	movl	%edx, (%rax)
	decl	%ecx
	addq	$4, %r8
	addq	$4, %rax
	testl	%ecx, %ecx
	jg	.LBB67_34
	jmp	.LBB67_35
.LBB67_36:                              # %while.end192
	addq	$936, %rsp              # imm = 0x3A8
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end67:
	.size	fallbackQSort3, .Lfunc_end67-fallbackQSort3
	.cfi_endproc

	.p2align	4, 0x90
	.type	fallbackSimpleSort,@function
fallbackSimpleSort:                     # @fallbackSimpleSort
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi353:
	.cfi_def_cfa_offset 16
.Lcfi354:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi355:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
.Lcfi356:
	.cfi_offset %rbx, -48
.Lcfi357:
	.cfi_offset %r12, -40
.Lcfi358:
	.cfi_offset %r14, -32
.Lcfi359:
	.cfi_offset %r15, -24
                                        # kill: %ECX<def> %ECX<kill> %RCX<def>
	cmpl	%ecx, %edx
	je	.LBB68_16
# BB#1:                                 # %if.end
	movl	%ecx, %eax
	subl	%edx, %eax
	cmpl	$4, %eax
	jl	.LBB68_9
# BB#2:                                 # %if.then3
	leal	-4(%rcx), %r10d
	movslq	%r10d, %rax
	leaq	(%rdi,%rax,4), %r8
	movl	%ecx, %r9d
	cmpl	%edx, %r10d
	jge	.LBB68_4
	jmp	.LBB68_9
	.p2align	4, 0x90
.LBB68_8:                               # %for.end
                                        #   in Loop: Header=BB68_4 Depth=1
	movl	%r11d, (%r15)
	decl	%r10d
	decl	%r9d
	addq	$-4, %r8
	cmpl	%edx, %r10d
	jl	.LBB68_9
.LBB68_4:                               # %for.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB68_6 Depth 2
	movslq	%r10d, %rax
	movslq	(%rdi,%rax,4), %r11
	movl	(%rsi,%r11,4), %r14d
	movq	%r8, %r15
	movl	%r9d, %r12d
	cmpl	%ecx, %r12d
	jle	.LBB68_6
	jmp	.LBB68_8
	.p2align	4, 0x90
.LBB68_7:                               # %for.body15
                                        #   in Loop: Header=BB68_6 Depth=2
	movl	(%rdi,%rax,4), %eax
	movl	%eax, (%r15)
	addl	$4, %r12d
	addq	$16, %r15
	cmpl	%ecx, %r12d
	jg	.LBB68_8
.LBB68_6:                               # %land.rhs
                                        #   Parent Loop BB68_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%r12d, %rax
	movl	(%rdi,%rax,4), %ebx
	cmpl	(%rsi,%rbx,4), %r14d
	ja	.LBB68_7
	jmp	.LBB68_8
.LBB68_9:                               # %if.end27
	leal	-1(%rcx), %r10d
	movslq	%r10d, %rax
	leaq	(%rdi,%rax,4), %r8
	movl	%ecx, %r9d
	cmpl	%edx, %r10d
	jge	.LBB68_11
	jmp	.LBB68_16
	.p2align	4, 0x90
.LBB68_15:                              # %for.end53
                                        #   in Loop: Header=BB68_11 Depth=1
	movl	%r11d, (%r15)
	decl	%r10d
	decl	%r9d
	addq	$-4, %r8
	cmpl	%edx, %r10d
	jl	.LBB68_16
.LBB68_11:                              # %for.body31
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB68_13 Depth 2
	movslq	%r10d, %rax
	movslq	(%rdi,%rax,4), %r11
	movl	(%rsi,%r11,4), %r14d
	movq	%r8, %r15
	movl	%r9d, %r12d
	cmpl	%ecx, %r12d
	jle	.LBB68_13
	jmp	.LBB68_15
	.p2align	4, 0x90
.LBB68_14:                              # %for.body46
                                        #   in Loop: Header=BB68_13 Depth=2
	movl	(%rdi,%rax,4), %eax
	movl	%eax, (%r15)
	incl	%r12d
	addq	$4, %r15
	cmpl	%ecx, %r12d
	jg	.LBB68_15
.LBB68_13:                              # %land.rhs39
                                        #   Parent Loop BB68_11 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%r12d, %rax
	movl	(%rdi,%rax,4), %ebx
	cmpl	(%rsi,%rbx,4), %r14d
	ja	.LBB68_14
	jmp	.LBB68_15
.LBB68_16:                              # %for.end59
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end68:
	.size	fallbackSimpleSort, .Lfunc_end68-fallbackSimpleSort
	.cfi_endproc

	.p2align	4, 0x90
	.type	mainQSort3,@function
mainQSort3:                             # @mainQSort3
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi360:
	.cfi_def_cfa_offset 16
.Lcfi361:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi362:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$1368, %rsp             # imm = 0x558
.Lcfi363:
	.cfi_offset %rbx, -56
.Lcfi364:
	.cfi_offset %r12, -48
.Lcfi365:
	.cfi_offset %r13, -40
.Lcfi366:
	.cfi_offset %r14, -32
.Lcfi367:
	.cfi_offset %r15, -24
	movl	%ecx, -148(%rbp)        # 4-byte Spill
	movq	%rdx, -184(%rbp)        # 8-byte Spill
	movq	%rsi, -128(%rbp)        # 8-byte Spill
	movq	%rdi, -88(%rbp)         # 8-byte Spill
	movl	16(%rbp), %eax
	movl	%r8d, -1408(%rbp)
	movl	%r9d, -1008(%rbp)
	movl	%eax, -608(%rbp)
	movl	$1, %ebx
	testl	%ebx, %ebx
	jg	.LBB69_2
	jmp	.LBB69_7
	.p2align	4, 0x90
.LBB69_39:                              # %if.end271
                                        #   in Loop: Header=BB69_2 Depth=1
	movl	-64(%rbp), %eax
	movslq	%ebx, %rbx
	movl	%eax, -1408(%rbp,%rbx,4)
	movl	-52(%rbp), %eax
	movl	%eax, -1008(%rbp,%rbx,4)
	movl	-76(%rbp), %eax
	movl	%eax, -608(%rbp,%rbx,4)
	movl	-60(%rbp), %eax
	movl	%eax, -1404(%rbp,%rbx,4)
	movl	-48(%rbp), %eax
	movl	%eax, -1004(%rbp,%rbx,4)
	movl	-72(%rbp), %eax
	movl	%eax, -604(%rbp,%rbx,4)
	movl	-56(%rbp), %eax
	movl	%eax, -1400(%rbp,%rbx,4)
	movl	-44(%rbp), %eax
	movl	%eax, -1000(%rbp,%rbx,4)
	movl	-68(%rbp), %eax
	movl	%eax, -600(%rbp,%rbx,4)
	addl	$3, %ebx
.LBB69_1:                               # %while.cond
                                        #   in Loop: Header=BB69_2 Depth=1
	testl	%ebx, %ebx
	jle	.LBB69_7
.LBB69_2:                               # %while.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB69_9 Depth 2
                                        #       Child Loop BB69_10 Depth 3
                                        #         Child Loop BB69_11 Depth 4
                                        #       Child Loop BB69_20 Depth 3
                                        #         Child Loop BB69_17 Depth 4
                                        #     Child Loop BB69_29 Depth 2
                                        #     Child Loop BB69_32 Depth 2
	cmpl	$100, %ebx
	jl	.LBB69_4
# BB#3:                                 # %if.then
                                        #   in Loop: Header=BB69_2 Depth=1
	movl	$1001, %edi             # imm = 0x3E9
	callq	BZ2_bz__AssertH__fail
.LBB69_4:                               # %if.end
                                        #   in Loop: Header=BB69_2 Depth=1
	movslq	%ebx, %rax
	decl	%ebx
	movl	-1412(%rbp,%rax,4), %r14d
	movl	-1012(%rbp,%rax,4), %ecx
	movl	-612(%rbp,%rax,4), %r13d
	movq	%rcx, -96(%rbp)         # 8-byte Spill
	movl	%ecx, %eax
	subl	%r14d, %eax
	cmpl	$20, %eax
	jl	.LBB69_6
# BB#5:                                 # %if.end
                                        #   in Loop: Header=BB69_2 Depth=1
	cmpl	$15, %r13d
	jge	.LBB69_6
# BB#8:                                 # %if.end18
                                        #   in Loop: Header=BB69_2 Depth=1
	movq	%rbx, -168(%rbp)        # 8-byte Spill
	movslq	%r14d, %rcx
	movq	-96(%rbp), %r15         # 8-byte Reload
	movslq	%r15d, %rax
	movq	-88(%rbp), %rsi         # 8-byte Reload
	movq	%rcx, -192(%rbp)        # 8-byte Spill
	movl	(%rsi,%rcx,4), %ecx
	addl	%r13d, %ecx
	movl	(%rsi,%rax,4), %eax
	addl	%r13d, %eax
	leal	(%r14,%r15), %edx
	sarl	%edx
	movslq	%edx, %rdx
	movl	(%rsi,%rdx,4), %edx
	addl	%r13d, %edx
	movq	-128(%rbp), %rbx        # 8-byte Reload
	movzbl	(%rbx,%rax), %esi
	movzbl	(%rbx,%rcx), %edi
	movzbl	(%rbx,%rdx), %edx
	callq	mmed3
	movzbl	%al, %eax
	leal	-1(%r14), %ecx
	movl	%ecx, -156(%rbp)        # 4-byte Spill
	movl	%r15d, %ecx
	notl	%ecx
	movq	%rcx, -208(%rbp)        # 8-byte Spill
	movl	%r15d, %ecx
	movq	%rcx, -112(%rbp)        # 8-byte Spill
	movl	%r14d, %edx
	movl	%r15d, %edi
	movq	%r14, -136(%rbp)        # 8-byte Spill
	movl	%r14d, %ecx
	jmp	.LBB69_9
	.p2align	4, 0x90
.LBB69_24:                              # %if.end105
                                        #   in Loop: Header=BB69_9 Depth=2
	movslq	%r9d, %rdx
	movq	-88(%rbp), %rcx         # 8-byte Reload
	leaq	(%rcx,%rdx,4), %rdx
	movl	(%rdx,%rsi,4), %r8d
	movslq	%r15d, %rbx
	leaq	(%rcx,%rbx,4), %rbx
	movl	(%rbx,%r11,4), %edi
	movl	%edi, (%rdx,%rsi,4)
	movl	%r8d, (%rbx,%r11,4)
	leal	1(%r9,%rsi), %ecx
	leal	-1(%r15,%r11), %edi
	movq	-120(%rbp), %rdx        # 8-byte Reload
.LBB69_9:                               # %while.body35
                                        #   Parent Loop BB69_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB69_10 Depth 3
                                        #         Child Loop BB69_11 Depth 4
                                        #       Child Loop BB69_20 Depth 3
                                        #         Child Loop BB69_17 Depth 4
	movl	%edx, %r14d
	negl	%r14d
	leal	-1(%rdx), %r11d
	movl	-156(%rbp), %r15d       # 4-byte Reload
	movq	%rdx, -120(%rbp)        # 8-byte Spill
	subl	%edx, %r15d
	jmp	.LBB69_10
	.p2align	4, 0x90
.LBB69_14:                              # %if.then51
                                        #   in Loop: Header=BB69_10 Depth=3
	movslq	%r9d, %rdx
	movq	-88(%rbp), %rcx         # 8-byte Reload
	leaq	(%rcx,%rdx,4), %r10
	movl	(%r10,%rsi,4), %r8d
	movq	-120(%rbp), %rdx        # 8-byte Reload
	movslq	%edx, %rdx
	movl	(%rcx,%rdx,4), %ebx
	movl	%ebx, (%r10,%rsi,4)
	movl	%r8d, (%rcx,%rdx,4)
	incl	%edx
	movq	%rdx, -120(%rbp)        # 8-byte Spill
	leal	1(%r9,%rsi), %ecx
	decl	%r14d
	incl	%r11d
	decl	%r15d
.LBB69_10:                              # %while.body37.outer
                                        #   Parent Loop BB69_2 Depth=1
                                        #     Parent Loop BB69_9 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB69_11 Depth 4
	movslq	%ecx, %r8
	movq	-88(%rbp), %rcx         # 8-byte Reload
	leaq	(%rcx,%r8,4), %rdx
	movl	%r8d, %r9d
	movl	%r11d, %r12d
	subl	%r8d, %r12d
	incl	%r8d
	movq	%rdx, %r10
	xorl	%esi, %esi
	jmp	.LBB69_11
	.p2align	4, 0x90
.LBB69_16:                              # %if.end66
                                        #   in Loop: Header=BB69_11 Depth=4
	incq	%rsi
	decl	%r12d
	incl	%r8d
	addq	$4, %r10
.LBB69_11:                              # %while.body37
                                        #   Parent Loop BB69_2 Depth=1
                                        #     Parent Loop BB69_9 Depth=2
                                        #       Parent Loop BB69_10 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	leal	(%r9,%rsi), %ebx
	cmpl	%edi, %ebx
	jg	.LBB69_12
# BB#13:                                # %if.end41
                                        #   in Loop: Header=BB69_11 Depth=4
	movl	(%rdx,%rsi,4), %ebx
	addl	%r13d, %ebx
	movq	-128(%rbp), %rcx        # 8-byte Reload
	movzbl	(%rcx,%rbx), %ebx
	subl	%eax, %ebx
	je	.LBB69_14
# BB#15:                                # %if.end62
                                        #   in Loop: Header=BB69_11 Depth=4
	testl	%ebx, %ebx
	jle	.LBB69_16
.LBB69_12:                              # %while.body69.preheader
                                        #   in Loop: Header=BB69_9 Depth=2
	movl	%r15d, -152(%rbp)       # 4-byte Spill
	movq	%r14, -176(%rbp)        # 8-byte Spill
	leaq	(%r9,%rsi), %r14
	movq	-96(%rbp), %rcx         # 8-byte Reload
	movl	%ecx, %edx
	movq	-112(%rbp), %rcx        # 8-byte Reload
	subl	%ecx, %edx
	movl	%edx, -100(%rbp)        # 4-byte Spill
	movl	%ecx, %ebx
	notl	%ebx
	movq	-208(%rbp), %rdx        # 8-byte Reload
	leal	(%rdx,%rcx), %ecx
	jmp	.LBB69_20
	.p2align	4, 0x90
.LBB69_19:                              # %if.then83
                                        #   in Loop: Header=BB69_20 Depth=3
	movslq	%r15d, %rdx
	movq	-88(%rbp), %rcx         # 8-byte Reload
	leaq	(%rcx,%rdx,4), %rdx
	movl	(%rdx,%r11,4), %edi
	movq	%r9, -200(%rbp)         # 8-byte Spill
	movq	-112(%rbp), %r9         # 8-byte Reload
	movslq	%r9d, %r9
	movl	(%rcx,%r9,4), %ebx
	movl	%ebx, (%rdx,%r11,4)
	movl	%edi, (%rcx,%r9,4)
	decl	%r9d
	movq	%r9, -112(%rbp)         # 8-byte Spill
	movq	-200(%rbp), %r9         # 8-byte Reload
	leal	-1(%r15,%r11), %edi
	incl	-100(%rbp)              # 4-byte Folded Spill
	movl	-160(%rbp), %ebx        # 4-byte Reload
	incl	%ebx
	movq	-144(%rbp), %rcx        # 8-byte Reload
	decl	%ecx
.LBB69_20:                              # %while.body69.outer
                                        #   Parent Loop BB69_2 Depth=1
                                        #     Parent Loop BB69_9 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB69_17 Depth 4
	movq	%rcx, -144(%rbp)        # 8-byte Spill
	movslq	%edi, %rdi
	movq	-88(%rbp), %rcx         # 8-byte Reload
	leaq	(%rcx,%rdi,4), %rdx
	movl	%edi, %r15d
	movl	%ebx, -160(%rbp)        # 4-byte Spill
	addl	%ebx, %edi
	xorl	%r11d, %r11d
	jmp	.LBB69_17
	.p2align	4, 0x90
.LBB69_22:                              # %if.end99
                                        #   in Loop: Header=BB69_17 Depth=4
	decq	%r11
	decl	%edi
.LBB69_17:                              # %while.body69
                                        #   Parent Loop BB69_2 Depth=1
                                        #     Parent Loop BB69_9 Depth=2
                                        #       Parent Loop BB69_20 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	leal	(%r15,%r11), %ebx
	cmpl	%ebx, %r14d
	jg	.LBB69_23
# BB#18:                                # %if.end73
                                        #   in Loop: Header=BB69_17 Depth=4
	movl	(%rdx,%r11,4), %ebx
	addl	%r13d, %ebx
	movq	-128(%rbp), %rcx        # 8-byte Reload
	movzbl	(%rcx,%rbx), %ebx
	subl	%eax, %ebx
	je	.LBB69_19
# BB#21:                                # %if.end95
                                        #   in Loop: Header=BB69_17 Depth=4
	testl	%ebx, %ebx
	jns	.LBB69_22
.LBB69_23:                              # %while.end101
                                        #   in Loop: Header=BB69_9 Depth=2
	leal	(%r11,%r15), %edx
	cmpl	%edx, %r14d
	jle	.LBB69_24
# BB#25:                                # %while.end117
                                        #   in Loop: Header=BB69_2 Depth=1
	movq	-112(%rbp), %r14        # 8-byte Reload
	movq	-120(%rbp), %rbx        # 8-byte Reload
	cmpl	%ebx, %r14d
	jge	.LBB69_27
# BB#26:                                # %if.then120
                                        #   in Loop: Header=BB69_2 Depth=1
	movq	-168(%rbp), %rbx        # 8-byte Reload
	movslq	%ebx, %rax
	movq	-136(%rbp), %rcx        # 8-byte Reload
	movl	%ecx, -1408(%rbp,%rax,4)
	movq	-96(%rbp), %rcx         # 8-byte Reload
	movl	%ecx, -1008(%rbp,%rax,4)
	incl	%r13d
	movl	%r13d, -608(%rbp,%rax,4)
	incl	%ebx
	testl	%ebx, %ebx
	jg	.LBB69_2
	jmp	.LBB69_7
	.p2align	4, 0x90
.LBB69_6:                               # %if.then14
                                        #   in Loop: Header=BB69_2 Depth=1
	movq	-88(%rbp), %rdi         # 8-byte Reload
	movq	-128(%rbp), %rsi        # 8-byte Reload
	movq	-184(%rbp), %rdx        # 8-byte Reload
	movl	-148(%rbp), %ecx        # 4-byte Reload
	movl	%r14d, %r8d
	movq	-96(%rbp), %r9          # 8-byte Reload
                                        # kill: %R9D<def> %R9D<kill> %R9<kill>
	movq	24(%rbp), %rax
	movq	%rax, %r14
	pushq	%r14
	pushq	%r13
	callq	mainSimpleSort
	addq	$16, %rsp
	cmpl	$0, (%r14)
	jns	.LBB69_1
	jmp	.LBB69_7
	.p2align	4, 0x90
.LBB69_27:                              # %if.end129
                                        #   in Loop: Header=BB69_2 Depth=1
	subl	-136(%rbp), %ebx        # 4-byte Folded Reload
	movq	-176(%rbp), %rax        # 8-byte Reload
	leal	(%r9,%rax), %eax
	leal	(%rsi,%rax), %eax
	cmpl	%eax, %ebx
	cmovgl	%eax, %ebx
	movq	-88(%rbp), %rax         # 8-byte Reload
	movq	-192(%rbp), %rcx        # 8-byte Reload
	leaq	(%rax,%rcx,4), %rcx
	movl	-152(%rbp), %edx        # 4-byte Reload
	cmpl	%edx, %r12d
	cmovgel	%r12d, %edx
	addl	%r8d, %edx
	movslq	%edx, %rdx
	leaq	(%rax,%rdx,4), %rdx
	movq	%rbx, %r8
	testl	%r8d, %r8d
	jle	.LBB69_30
	.p2align	4, 0x90
.LBB69_29:                              # %while.body140
                                        #   Parent Loop BB69_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	(%rcx), %ebx
	movl	(%rdx), %eax
	movl	%eax, (%rcx)
	movl	%ebx, (%rdx)
	decl	%r8d
	addq	$4, %rcx
	addq	$4, %rdx
	testl	%r8d, %r8d
	jg	.LBB69_29
.LBB69_30:                              # %while.end153
                                        #   in Loop: Header=BB69_2 Depth=1
	movq	-96(%rbp), %rax         # 8-byte Reload
	movq	%rax, %rcx
	subl	%r14d, %eax
	subl	%r15d, %r14d
	subl	%r11d, %r14d
	cmpl	%r14d, %eax
	cmovlel	%eax, %r14d
	movq	-144(%rbp), %rax        # 8-byte Reload
	cmpl	%eax, %edi
	cmovgel	%edi, %eax
	leal	2(%rcx,%rax), %eax
	cltq
	movq	-88(%rbp), %rcx         # 8-byte Reload
	leaq	(%rcx,%rax,4), %rax
	movq	-168(%rbp), %rbx        # 8-byte Reload
	movq	-136(%rbp), %rcx        # 8-byte Reload
	testl	%r14d, %r14d
	jle	.LBB69_33
	.p2align	4, 0x90
.LBB69_32:                              # %while.body172
                                        #   Parent Loop BB69_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	(%r10), %edx
	movl	(%rax), %edi
	movl	%edi, (%r10)
	movl	%edx, (%rax)
	decl	%r14d
	addq	$4, %r10
	addq	$4, %rax
	testl	%r14d, %r14d
	jg	.LBB69_32
.LBB69_33:                              # %while.end185
                                        #   in Loop: Header=BB69_2 Depth=1
	addl	-176(%rbp), %r9d        # 4-byte Folded Reload
	leal	(%rcx,%r9), %eax
	leal	-1(%rsi,%rax), %eax
	addl	-100(%rbp), %r15d       # 4-byte Folded Reload
	leal	(%r15,%r11), %edx
	leal	1(%r11,%r15), %edi
	movl	%ecx, -64(%rbp)
	movl	%eax, -52(%rbp)
	movl	%r13d, -76(%rbp)
	movl	%edi, -60(%rbp)
	movq	-96(%rbp), %rax         # 8-byte Reload
	movl	%eax, -48(%rbp)
	movl	%r13d, -72(%rbp)
	addl	%ecx, %r9d
	addl	%esi, %r9d
	movl	%r9d, -56(%rbp)
	movl	%edx, -44(%rbp)
	incl	%r13d
	movl	%r13d, -68(%rbp)
	movl	-52(%rbp), %eax
	movl	-48(%rbp), %ecx
	subl	-64(%rbp), %eax
	subl	-60(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB69_35
# BB#34:                                # %if.then212
                                        #   in Loop: Header=BB69_2 Depth=1
	movl	-64(%rbp), %eax
	movl	-60(%rbp), %ecx
	movl	%ecx, -64(%rbp)
	movl	%eax, -60(%rbp)
	movl	-52(%rbp), %eax
	movl	-48(%rbp), %ecx
	movl	%ecx, -52(%rbp)
	movl	%eax, -48(%rbp)
	movl	-76(%rbp), %eax
	movl	-72(%rbp), %ecx
	movl	%ecx, -76(%rbp)
	movl	%eax, -72(%rbp)
.LBB69_35:                              # %if.end225
                                        #   in Loop: Header=BB69_2 Depth=1
	movl	-48(%rbp), %eax
	movl	-44(%rbp), %ecx
	subl	-60(%rbp), %eax
	subl	-56(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB69_37
# BB#36:                                # %if.then234
                                        #   in Loop: Header=BB69_2 Depth=1
	movl	-60(%rbp), %eax
	movl	-56(%rbp), %ecx
	movl	%ecx, -60(%rbp)
	movl	%eax, -56(%rbp)
	movl	-48(%rbp), %eax
	movl	-44(%rbp), %ecx
	movl	%ecx, -48(%rbp)
	movl	%eax, -44(%rbp)
	movl	-72(%rbp), %eax
	movl	-68(%rbp), %ecx
	movl	%ecx, -72(%rbp)
	movl	%eax, -68(%rbp)
.LBB69_37:                              # %if.end248
                                        #   in Loop: Header=BB69_2 Depth=1
	movl	-52(%rbp), %eax
	movl	-48(%rbp), %ecx
	subl	-64(%rbp), %eax
	subl	-60(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB69_39
# BB#38:                                # %if.then257
                                        #   in Loop: Header=BB69_2 Depth=1
	movl	-64(%rbp), %eax
	movl	-60(%rbp), %ecx
	movl	%ecx, -64(%rbp)
	movl	%eax, -60(%rbp)
	movl	-52(%rbp), %eax
	movl	-48(%rbp), %ecx
	movl	%ecx, -52(%rbp)
	movl	%eax, -48(%rbp)
	movl	-76(%rbp), %eax
	movl	-72(%rbp), %ecx
	movl	%ecx, -76(%rbp)
	movl	%eax, -72(%rbp)
	jmp	.LBB69_39
.LBB69_7:                               # %while.end302
	addq	$1368, %rsp             # imm = 0x558
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end69:
	.size	mainQSort3, .Lfunc_end69-mainQSort3
	.cfi_endproc

	.p2align	4, 0x90
	.type	mainSimpleSort,@function
mainSimpleSort:                         # @mainSimpleSort
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi368:
	.cfi_def_cfa_offset 16
.Lcfi369:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi370:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$72, %rsp
.Lcfi371:
	.cfi_offset %rbx, -56
.Lcfi372:
	.cfi_offset %r12, -48
.Lcfi373:
	.cfi_offset %r13, -40
.Lcfi374:
	.cfi_offset %r14, -32
.Lcfi375:
	.cfi_offset %r15, -24
                                        # kill: %R8D<def> %R8D<kill> %R8<def>
	movl	%ecx, -60(%rbp)         # 4-byte Spill
	movq	%rdx, -112(%rbp)        # 8-byte Spill
	movq	%rsi, -104(%rbp)        # 8-byte Spill
	movq	%rdi, %r14
	movl	%r9d, -52(%rbp)         # 4-byte Spill
	movl	%r9d, %eax
	movq	%r8, -88(%rbp)          # 8-byte Spill
	subl	%r8d, %eax
	incl	%eax
	cmpl	$2, %eax
	jl	.LBB70_24
# BB#1:                                 # %while.cond.preheader
	xorl	%ecx, %ecx
	cmpl	%eax, incs(,%rcx,4)
	jge	.LBB70_4
	.p2align	4, 0x90
.LBB70_3:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	incq	%rcx
	cmpl	%eax, incs(,%rcx,4)
	jl	.LBB70_3
	jmp	.LBB70_4
	.p2align	4, 0x90
.LBB70_7:                               #   in Loop: Header=BB70_4 Depth=1
	movq	-80(%rbp), %rcx         # 8-byte Reload
.LBB70_4:                               # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB70_6 Depth 2
                                        #       Child Loop BB70_9 Depth 3
                                        #       Child Loop BB70_15 Depth 3
                                        #       Child Loop BB70_21 Depth 3
	decl	%ecx
	movq	%rcx, -80(%rbp)         # 8-byte Spill
	js	.LBB70_24
# BB#5:                                 # %for.body
                                        #   in Loop: Header=BB70_4 Depth=1
	movslq	-80(%rbp), %rax         # 4-byte Folded Reload
	movl	incs(,%rax,4), %r12d
	movq	-88(%rbp), %rax         # 8-byte Reload
	leal	(%rax,%r12), %r13d
                                        # kill: %EAX<def> %EAX<kill> %RAX<kill> %RAX<def>
	movq	%rax, -72(%rbp)         # 8-byte Spill
	movq	%r12, -96(%rbp)         # 8-byte Spill
	.p2align	4, 0x90
.LBB70_6:                               # %while.body7
                                        #   Parent Loop BB70_4 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB70_9 Depth 3
                                        #       Child Loop BB70_15 Depth 3
                                        #       Child Loop BB70_21 Depth 3
	cmpl	-52(%rbp), %r13d        # 4-byte Folded Reload
	jg	.LBB70_7
# BB#8:                                 # %if.end10
                                        #   in Loop: Header=BB70_6 Depth=2
	movslq	%r13d, %rax
	movl	(%r14,%rax,4), %eax
	movq	%rax, -48(%rbp)         # 8-byte Spill
	movq	-72(%rbp), %rax         # 8-byte Reload
                                        # kill: %EAX<def> %EAX<kill> %RAX<kill> %RAX<def>
	.p2align	4, 0x90
.LBB70_9:                               # %while.cond13
                                        #   Parent Loop BB70_4 Depth=1
                                        #     Parent Loop BB70_6 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	leal	(%r12,%rax), %r15d
	movslq	%eax, %rbx
	movl	(%r14,%rbx,4), %edi
	movl	16(%rbp), %eax
	addl	%eax, %edi
	movq	-48(%rbp), %rcx         # 8-byte Reload
	leal	(%rcx,%rax), %esi
	movq	-104(%rbp), %rdx        # 8-byte Reload
	movq	-112(%rbp), %rcx        # 8-byte Reload
	movl	-60(%rbp), %r8d         # 4-byte Reload
	movq	24(%rbp), %r9
	callq	mainGtU
	testb	%al, %al
	je	.LBB70_12
# BB#10:                                # %while.body19
                                        #   in Loop: Header=BB70_9 Depth=3
	movl	(%r14,%rbx,4), %eax
	movslq	%r15d, %rcx
	movl	%eax, (%r14,%rcx,4)
	movq	-88(%rbp), %rax         # 8-byte Reload
	leal	-1(%rax,%r12), %ecx
	movl	%ebx, %eax
	subl	%r12d, %eax
	cmpl	%ecx, %ebx
	jg	.LBB70_9
# BB#11:                                # %while.end31split
                                        #   in Loop: Header=BB70_6 Depth=2
	addl	%r12d, %eax
	movl	%eax, %r15d
.LBB70_12:                              # %while.end31
                                        #   in Loop: Header=BB70_6 Depth=2
	movslq	%r15d, %rax
	movq	-48(%rbp), %rcx         # 8-byte Reload
	movl	%ecx, (%r14,%rax,4)
	leal	1(%r13), %eax
	cmpl	-52(%rbp), %eax         # 4-byte Folded Reload
	jg	.LBB70_13
# BB#14:                                # %if.end37
                                        #   in Loop: Header=BB70_6 Depth=2
	movl	%eax, -56(%rbp)         # 4-byte Spill
	cltq
	movl	(%r14,%rax,4), %eax
	movq	%rax, -48(%rbp)         # 8-byte Spill
	movl	$1, %r15d
	.p2align	4, 0x90
.LBB70_15:                              # %while.cond40
                                        #   Parent Loop BB70_4 Depth=1
                                        #     Parent Loop BB70_6 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	leal	(%r13,%r15), %ebx
	movq	-72(%rbp), %rax         # 8-byte Reload
	leal	(%rax,%r15), %eax
	movq	%r13, %r12
	movslq	%eax, %r13
	movl	(%r14,%r13,4), %edi
	movl	16(%rbp), %eax
	addl	%eax, %edi
	movq	-48(%rbp), %rcx         # 8-byte Reload
	leal	(%rcx,%rax), %esi
	movq	-104(%rbp), %rdx        # 8-byte Reload
	movq	-112(%rbp), %rcx        # 8-byte Reload
	movl	-60(%rbp), %r8d         # 4-byte Reload
	movq	24(%rbp), %r9
	callq	mainGtU
	testb	%al, %al
	je	.LBB70_17
# BB#16:                                # %while.body48
                                        #   in Loop: Header=BB70_15 Depth=3
	movl	(%r14,%r13,4), %eax
	movslq	%ebx, %rcx
	movl	%eax, (%r14,%rcx,4)
	movq	-88(%rbp), %rax         # 8-byte Reload
	movq	-96(%rbp), %rcx         # 8-byte Reload
	leal	-1(%rax,%rcx), %eax
	subl	%ecx, %r15d
	leal	(%r12,%r15), %ebx
	cmpl	%eax, %ebx
	movq	%r12, %r13
	jg	.LBB70_15
	jmp	.LBB70_18
	.p2align	4, 0x90
.LBB70_17:                              # %while.cond40.while.end60_crit_edge
                                        #   in Loop: Header=BB70_6 Depth=2
	movq	%r12, %r13
.LBB70_18:                              # %while.end60
                                        #   in Loop: Header=BB70_6 Depth=2
	movslq	%ebx, %rax
	movq	-48(%rbp), %rcx         # 8-byte Reload
	movl	%ecx, (%r14,%rax,4)
	movl	-56(%rbp), %eax         # 4-byte Reload
	incl	%eax
	cmpl	-52(%rbp), %eax         # 4-byte Folded Reload
	jg	.LBB70_19
# BB#20:                                # %if.end66
                                        #   in Loop: Header=BB70_6 Depth=2
	movl	%eax, -56(%rbp)         # 4-byte Spill
	cltq
	movl	(%r14,%rax,4), %eax
	movq	%rax, -48(%rbp)         # 8-byte Spill
	movl	$2, %ebx
	.p2align	4, 0x90
.LBB70_21:                              # %while.cond69
                                        #   Parent Loop BB70_4 Depth=1
                                        #     Parent Loop BB70_6 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	leal	(%r13,%rbx), %r15d
	movq	-72(%rbp), %rax         # 8-byte Reload
	leal	(%rax,%rbx), %eax
	movq	%r13, %r12
	movslq	%eax, %r13
	movl	(%r14,%r13,4), %edi
	movl	16(%rbp), %eax
	addl	%eax, %edi
	movq	-48(%rbp), %rcx         # 8-byte Reload
	leal	(%rcx,%rax), %esi
	movq	-104(%rbp), %rdx        # 8-byte Reload
	movq	-112(%rbp), %rcx        # 8-byte Reload
	movl	-60(%rbp), %r8d         # 4-byte Reload
	movq	24(%rbp), %r9
	callq	mainGtU
	testb	%al, %al
	je	.LBB70_23
# BB#22:                                # %while.body77
                                        #   in Loop: Header=BB70_21 Depth=3
	movl	(%r14,%r13,4), %eax
	movslq	%r15d, %rcx
	movl	%eax, (%r14,%rcx,4)
	movq	-88(%rbp), %rax         # 8-byte Reload
	movq	-96(%rbp), %rcx         # 8-byte Reload
	leal	-1(%rax,%rcx), %eax
	subl	%ecx, %ebx
	leal	(%r12,%rbx), %r15d
	cmpl	%eax, %r15d
	movq	%r12, %r13
	jg	.LBB70_21
.LBB70_23:                              # %while.end89
                                        #   in Loop: Header=BB70_6 Depth=2
	movslq	%r15d, %rax
	movq	-48(%rbp), %rcx         # 8-byte Reload
	movl	%ecx, (%r14,%rax,4)
	movl	-56(%rbp), %ecx         # 4-byte Reload
	incl	%ecx
	movq	-72(%rbp), %rax         # 8-byte Reload
	addl	$3, %eax
	movq	%rax, -72(%rbp)         # 8-byte Spill
	movq	24(%rbp), %rax
	cmpl	$0, (%rax)
	movl	%ecx, %r13d
	movq	-96(%rbp), %r12         # 8-byte Reload
	jns	.LBB70_6
	jmp	.LBB70_24
	.p2align	4, 0x90
.LBB70_13:                              #   in Loop: Header=BB70_4 Depth=1
	movq	-80(%rbp), %rcx         # 8-byte Reload
	jmp	.LBB70_4
	.p2align	4, 0x90
.LBB70_19:                              #   in Loop: Header=BB70_4 Depth=1
	movq	-80(%rbp), %rcx         # 8-byte Reload
	jmp	.LBB70_4
.LBB70_24:                              # %for.end
	addq	$72, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end70:
	.size	mainSimpleSort, .Lfunc_end70-mainSimpleSort
	.cfi_endproc

	.p2align	4, 0x90
	.type	mmed3,@function
mmed3:                                  # @mmed3
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi376:
	.cfi_def_cfa_offset 16
.Lcfi377:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi378:
	.cfi_def_cfa_register %rbp
	cmpl	%esi, %edi
	movl	%esi, %eax
	cmovgl	%edi, %eax
	cmovgl	%esi, %edi
	movzbl	%al, %ecx
	cmpl	%edx, %ecx
	jle	.LBB71_4
# BB#1:                                 # %if.then7
	movzbl	%dil, %eax
	movzbl	%dl, %ecx
	cmpl	%ecx, %eax
	jg	.LBB71_3
# BB#2:                                 # %if.then7
	movb	%dl, %dil
.LBB71_3:                               # %if.then7
	movb	%dil, %al
.LBB71_4:                               # %if.end14
                                        # kill: %AL<def> %AL<kill> %EAX<kill>
	popq	%rbp
	retq
.Lfunc_end71:
	.size	mmed3, .Lfunc_end71-mmed3
	.cfi_endproc

	.p2align	4, 0x90
	.type	mainGtU,@function
mainGtU:                                # @mainGtU
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi379:
	.cfi_def_cfa_offset 16
.Lcfi380:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi381:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi382:
	.cfi_offset %rbx, -32
.Lcfi383:
	.cfi_offset %r14, -24
                                        # kill: %R8D<def> %R8D<kill> %R8<def>
                                        # kill: %ESI<def> %ESI<kill> %RSI<def>
                                        # kill: %EDI<def> %EDI<kill> %RDI<def>
	movl	%edi, %eax
	movzbl	(%rdx,%rax), %r10d
	movl	%esi, %eax
	movzbl	(%rdx,%rax), %eax
	cmpl	%eax, %r10d
	jne	.LBB72_23
# BB#2:                                 # %if.end
	incl	%edi
	incl	%esi
	movzbl	(%rdx,%rdi), %r10d
	movzbl	(%rdx,%rsi), %eax
	cmpl	%eax, %r10d
	jne	.LBB72_23
# BB#4:                                 # %if.end25
	incl	%edi
	incl	%esi
	movzbl	(%rdx,%rdi), %r10d
	movzbl	(%rdx,%rsi), %eax
	cmpl	%eax, %r10d
	jne	.LBB72_23
# BB#6:                                 # %if.end42
	incl	%edi
	incl	%esi
	movzbl	(%rdx,%rdi), %r10d
	movzbl	(%rdx,%rsi), %eax
	cmpl	%eax, %r10d
	jne	.LBB72_23
# BB#8:                                 # %if.end59
	incl	%edi
	incl	%esi
	movzbl	(%rdx,%rdi), %r10d
	movzbl	(%rdx,%rsi), %eax
	cmpl	%eax, %r10d
	jne	.LBB72_23
# BB#10:                                # %if.end76
	incl	%edi
	incl	%esi
	movzbl	(%rdx,%rdi), %r10d
	movzbl	(%rdx,%rsi), %eax
	cmpl	%eax, %r10d
	jne	.LBB72_23
# BB#12:                                # %if.end93
	incl	%edi
	incl	%esi
	movzbl	(%rdx,%rdi), %r10d
	movzbl	(%rdx,%rsi), %eax
	cmpl	%eax, %r10d
	jne	.LBB72_23
# BB#14:                                # %if.end110
	incl	%edi
	incl	%esi
	movzbl	(%rdx,%rdi), %r10d
	movzbl	(%rdx,%rsi), %eax
	cmpl	%eax, %r10d
	jne	.LBB72_23
# BB#16:                                # %if.end127
	incl	%edi
	incl	%esi
	movzbl	(%rdx,%rdi), %r10d
	movzbl	(%rdx,%rsi), %eax
	cmpl	%eax, %r10d
	jne	.LBB72_23
# BB#18:                                # %if.end144
	incl	%edi
	incl	%esi
	movzbl	(%rdx,%rdi), %r10d
	movzbl	(%rdx,%rsi), %eax
	cmpl	%eax, %r10d
	jne	.LBB72_23
# BB#20:                                # %if.end161
	incl	%edi
	incl	%esi
	movzbl	(%rdx,%rdi), %r10d
	movzbl	(%rdx,%rsi), %eax
	cmpl	%eax, %r10d
	jne	.LBB72_23
# BB#22:                                # %if.end178
	incl	%edi
	incl	%esi
	movzbl	(%rdx,%rdi), %r10d
	movzbl	(%rdx,%rsi), %eax
	cmpl	%eax, %r10d
	je	.LBB72_25
.LBB72_23:                              # %if.then189
	setg	%al
.LBB72_24:                              # %return
                                        # kill: %AL<def> %AL<kill> %EAX<kill>
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.LBB72_25:                              # %if.end195
	incl	%edi
	incl	%esi
	leal	8(%r8), %r10d
.LBB72_26:                              # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movl	%edi, %r11d
	movzbl	(%rdx,%r11), %r14d
	movl	%esi, %eax
	movzbl	(%rdx,%rax), %ebx
	cmpl	%ebx, %r14d
	jne	.LBB72_23
# BB#27:                                # %if.end212
                                        #   in Loop: Header=BB72_26 Depth=1
	movzwl	(%rcx,%r11,2), %ebx
	movzwl	(%rcx,%rax,2), %eax
	cmpl	%eax, %ebx
	jne	.LBB72_23
# BB#28:                                # %if.end227
                                        #   in Loop: Header=BB72_26 Depth=1
	incl	%edi
	incl	%esi
	movzbl	(%rdx,%rdi), %eax
	movzbl	(%rdx,%rsi), %ebx
	cmpl	%ebx, %eax
	jne	.LBB72_23
# BB#29:                                # %if.end244
                                        #   in Loop: Header=BB72_26 Depth=1
	movl	%edi, %eax
	movzwl	(%rcx,%rax,2), %eax
	movl	%esi, %ebx
	movzwl	(%rcx,%rbx,2), %ebx
	cmpl	%ebx, %eax
	jne	.LBB72_23
# BB#30:                                # %if.end259
                                        #   in Loop: Header=BB72_26 Depth=1
	incl	%edi
	incl	%esi
	movzbl	(%rdx,%rdi), %eax
	movzbl	(%rdx,%rsi), %ebx
	cmpl	%ebx, %eax
	jne	.LBB72_23
# BB#31:                                # %if.end276
                                        #   in Loop: Header=BB72_26 Depth=1
	movl	%edi, %eax
	movzwl	(%rcx,%rax,2), %eax
	movl	%esi, %ebx
	movzwl	(%rcx,%rbx,2), %ebx
	cmpl	%ebx, %eax
	jne	.LBB72_23
# BB#32:                                # %if.end291
                                        #   in Loop: Header=BB72_26 Depth=1
	incl	%edi
	incl	%esi
	movzbl	(%rdx,%rdi), %eax
	movzbl	(%rdx,%rsi), %ebx
	cmpl	%ebx, %eax
	jne	.LBB72_23
# BB#33:                                # %if.end308
                                        #   in Loop: Header=BB72_26 Depth=1
	movl	%edi, %eax
	movzwl	(%rcx,%rax,2), %eax
	movl	%esi, %ebx
	movzwl	(%rcx,%rbx,2), %ebx
	cmpl	%ebx, %eax
	jne	.LBB72_23
# BB#34:                                # %if.end323
                                        #   in Loop: Header=BB72_26 Depth=1
	incl	%edi
	incl	%esi
	movzbl	(%rdx,%rdi), %eax
	movzbl	(%rdx,%rsi), %ebx
	cmpl	%ebx, %eax
	jne	.LBB72_23
# BB#35:                                # %if.end340
                                        #   in Loop: Header=BB72_26 Depth=1
	movl	%edi, %eax
	movzwl	(%rcx,%rax,2), %eax
	movl	%esi, %ebx
	movzwl	(%rcx,%rbx,2), %ebx
	cmpl	%ebx, %eax
	jne	.LBB72_23
# BB#36:                                # %if.end355
                                        #   in Loop: Header=BB72_26 Depth=1
	incl	%edi
	incl	%esi
	movzbl	(%rdx,%rdi), %eax
	movzbl	(%rdx,%rsi), %ebx
	cmpl	%ebx, %eax
	jne	.LBB72_23
# BB#37:                                # %if.end372
                                        #   in Loop: Header=BB72_26 Depth=1
	movl	%edi, %eax
	movzwl	(%rcx,%rax,2), %eax
	movl	%esi, %ebx
	movzwl	(%rcx,%rbx,2), %ebx
	cmpl	%ebx, %eax
	jne	.LBB72_23
# BB#38:                                # %if.end387
                                        #   in Loop: Header=BB72_26 Depth=1
	incl	%edi
	incl	%esi
	movzbl	(%rdx,%rdi), %eax
	movzbl	(%rdx,%rsi), %ebx
	cmpl	%ebx, %eax
	jne	.LBB72_23
# BB#39:                                # %if.end404
                                        #   in Loop: Header=BB72_26 Depth=1
	movl	%edi, %eax
	movzwl	(%rcx,%rax,2), %eax
	movl	%esi, %ebx
	movzwl	(%rcx,%rbx,2), %ebx
	cmpl	%ebx, %eax
	jne	.LBB72_23
# BB#40:                                # %if.end419
                                        #   in Loop: Header=BB72_26 Depth=1
	incl	%edi
	incl	%esi
	movzbl	(%rdx,%rdi), %eax
	movzbl	(%rdx,%rsi), %ebx
	cmpl	%ebx, %eax
	jne	.LBB72_23
# BB#41:                                # %if.end436
                                        #   in Loop: Header=BB72_26 Depth=1
	movl	%edi, %eax
	movzwl	(%rcx,%rax,2), %eax
	movl	%esi, %ebx
	movzwl	(%rcx,%rbx,2), %ebx
	cmpl	%ebx, %eax
	jne	.LBB72_23
# BB#42:                                # %if.end451
                                        #   in Loop: Header=BB72_26 Depth=1
	incl	%edi
	incl	%esi
	movl	%edi, %ebx
	subl	%r8d, %ebx
	cmovbl	%edi, %ebx
	movl	%esi, %edi
	subl	%r8d, %edi
	cmovbl	%esi, %edi
	decl	(%r9)
	xorl	%eax, %eax
	addl	$-8, %r10d
	movl	%edi, %esi
	movl	%ebx, %edi
	jns	.LBB72_26
	jmp	.LBB72_24
.Lfunc_end72:
	.size	mainGtU, .Lfunc_end72-mainGtU
	.cfi_endproc

	.p2align	4, 0x90
	.type	makeMaps_e,@function
makeMaps_e:                             # @makeMaps_e
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi384:
	.cfi_def_cfa_offset 16
.Lcfi385:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi386:
	.cfi_def_cfa_register %rbp
	movl	$0, 124(%rdi)
	xorl	%eax, %eax
	cmpl	$255, %eax
	jle	.LBB73_2
	jmp	.LBB73_5
	.p2align	4, 0x90
.LBB73_4:                               # %for.inc
                                        #   in Loop: Header=BB73_2 Depth=1
	incq	%rax
	cmpl	$255, %eax
	jg	.LBB73_5
.LBB73_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	cmpb	$0, 128(%rdi,%rax)
	je	.LBB73_4
# BB#3:                                 # %if.then
                                        #   in Loop: Header=BB73_2 Depth=1
	movzbl	124(%rdi), %ecx
	movb	%cl, 384(%rdi,%rax)
	incl	124(%rdi)
	jmp	.LBB73_4
.LBB73_5:                               # %for.end
	popq	%rbp
	retq
.Lfunc_end73:
	.size	makeMaps_e, .Lfunc_end73-makeMaps_e
	.cfi_endproc

	.p2align	4, 0x90
	.type	copy_output_until_stop,@function
copy_output_until_stop:                 # @copy_output_until_stop
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi387:
	.cfi_def_cfa_offset 16
.Lcfi388:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi389:
	.cfi_def_cfa_register %rbp
	xorl	%eax, %eax
	jmp	.LBB74_1
	.p2align	4, 0x90
.LBB74_4:                               # %if.then16
                                        #   in Loop: Header=BB74_1 Depth=1
	movq	(%rdi), %rcx
	incl	40(%rcx)
.LBB74_1:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movq	(%rdi), %rcx
	cmpl	$0, 32(%rcx)
	je	.LBB74_5
# BB#2:                                 # %if.end
                                        #   in Loop: Header=BB74_1 Depth=1
	movl	120(%rdi), %ecx
	cmpl	116(%rdi), %ecx
	jge	.LBB74_5
# BB#3:                                 # %if.end3
                                        #   in Loop: Header=BB74_1 Depth=1
	movq	(%rdi), %rax
	movq	80(%rdi), %rcx
	movslq	120(%rdi), %rdx
	movzbl	(%rcx,%rdx), %ecx
	movq	24(%rax), %rax
	movb	%cl, (%rax)
	incl	120(%rdi)
	movq	(%rdi), %rax
	decl	32(%rax)
	movq	(%rdi), %rax
	incq	24(%rax)
	movq	(%rdi), %rax
	incl	36(%rax)
	movq	(%rdi), %rcx
	movb	$1, %al
	cmpl	$0, 36(%rcx)
	jne	.LBB74_1
	jmp	.LBB74_4
.LBB74_5:                               # %while.end
                                        # kill: %AL<def> %AL<kill> %EAX<kill>
	popq	%rbp
	retq
.Lfunc_end74:
	.size	copy_output_until_stop, .Lfunc_end74-copy_output_until_stop
	.cfi_endproc

	.p2align	4, 0x90
	.type	copy_input_until_stop,@function
copy_input_until_stop:                  # @copy_input_until_stop
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi390:
	.cfi_def_cfa_offset 16
.Lcfi391:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi392:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi393:
	.cfi_offset %rbx, -32
.Lcfi394:
	.cfi_offset %r14, -24
	movq	%rdi, %rbx
	cmpl	$2, 8(%rbx)
	jne	.LBB75_1
# BB#8:                                 # %while.body.preheader
	xorl	%eax, %eax
	jmp	.LBB75_9
	.p2align	4, 0x90
.LBB75_21:                              # %if.then55
                                        #   in Loop: Header=BB75_9 Depth=1
	movq	(%rbx), %rcx
	incl	16(%rcx)
.LBB75_9:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movl	108(%rbx), %ecx
	cmpl	112(%rbx), %ecx
	jge	.LBB75_31
# BB#10:                                # %if.end
                                        #   in Loop: Header=BB75_9 Depth=1
	movq	(%rbx), %rcx
	cmpl	$0, 8(%rcx)
	je	.LBB75_31
# BB#11:                                # %if.end5
                                        #   in Loop: Header=BB75_9 Depth=1
	movq	(%rbx), %rax
	movq	(%rax), %rax
	movzbl	(%rax), %r14d
	cmpl	92(%rbx), %r14d
	je	.LBB75_14
# BB#12:                                # %land.lhs.true
                                        #   in Loop: Header=BB75_9 Depth=1
	cmpl	$1, 96(%rbx)
	jne	.LBB75_14
# BB#13:                                # %if.then11
                                        #   in Loop: Header=BB75_9 Depth=1
	movzbl	92(%rbx), %eax
	movl	648(%rbx), %ecx
	movl	%ecx, %edx
	shll	$8, %edx
	shrl	$24, %ecx
	xorl	%eax, %ecx
	xorl	BZ2_crc32Table(,%rcx,4), %edx
	movl	%edx, 648(%rbx)
	movl	92(%rbx), %ecx
	movb	$1, 128(%rbx,%rcx)
	movq	64(%rbx), %rcx
	movslq	108(%rbx), %rdx
	movb	%al, (%rcx,%rdx)
	incl	108(%rbx)
	movl	%r14d, 92(%rbx)
	jmp	.LBB75_20
	.p2align	4, 0x90
.LBB75_14:                              # %if.else
                                        #   in Loop: Header=BB75_9 Depth=1
	cmpl	92(%rbx), %r14d
	jne	.LBB75_16
# BB#15:                                # %lor.lhs.false
                                        #   in Loop: Header=BB75_9 Depth=1
	cmpl	$255, 96(%rbx)
	jne	.LBB75_19
.LBB75_16:                              # %if.then32
                                        #   in Loop: Header=BB75_9 Depth=1
	cmpl	$255, 92(%rbx)
	ja	.LBB75_18
# BB#17:                                # %if.then36
                                        #   in Loop: Header=BB75_9 Depth=1
	movq	%rbx, %rdi
	callq	add_pair_to_block
.LBB75_18:                              # %if.end37
                                        #   in Loop: Header=BB75_9 Depth=1
	movl	%r14d, 92(%rbx)
	movl	$1, 96(%rbx)
	jmp	.LBB75_20
.LBB75_19:                              # %if.else40
                                        #   in Loop: Header=BB75_9 Depth=1
	incl	96(%rbx)
	.p2align	4, 0x90
.LBB75_20:                              # %if.end44
                                        #   in Loop: Header=BB75_9 Depth=1
	movq	(%rbx), %rax
	incq	(%rax)
	movq	(%rbx), %rax
	decl	8(%rax)
	movq	(%rbx), %rax
	incl	12(%rax)
	movq	(%rbx), %rcx
	movb	$1, %al
	cmpl	$0, 12(%rcx)
	jne	.LBB75_9
	jmp	.LBB75_21
.LBB75_1:                               # %while.body60.preheader
	xorl	%eax, %eax
	jmp	.LBB75_2
	.p2align	4, 0x90
.LBB75_30:                              # %if.end151
                                        #   in Loop: Header=BB75_2 Depth=1
	decl	16(%rbx)
	movb	$1, %al
.LBB75_2:                               # %while.body60
                                        # =>This Inner Loop Header: Depth=1
	movl	108(%rbx), %ecx
	cmpl	112(%rbx), %ecx
	jge	.LBB75_31
# BB#3:                                 # %if.end66
                                        #   in Loop: Header=BB75_2 Depth=1
	movq	(%rbx), %rcx
	cmpl	$0, 8(%rcx)
	je	.LBB75_31
# BB#4:                                 # %if.end72
                                        #   in Loop: Header=BB75_2 Depth=1
	cmpl	$0, 16(%rbx)
	je	.LBB75_31
# BB#5:                                 # %if.end76
                                        #   in Loop: Header=BB75_2 Depth=1
	movq	(%rbx), %rax
	movq	(%rax), %rax
	movzbl	(%rax), %r14d
	cmpl	92(%rbx), %r14d
	je	.LBB75_22
# BB#6:                                 # %land.lhs.true84
                                        #   in Loop: Header=BB75_2 Depth=1
	cmpl	$1, 96(%rbx)
	jne	.LBB75_22
# BB#7:                                 # %if.then88
                                        #   in Loop: Header=BB75_2 Depth=1
	movzbl	92(%rbx), %eax
	movl	648(%rbx), %ecx
	movl	%ecx, %edx
	shll	$8, %edx
	shrl	$24, %ecx
	xorl	%eax, %ecx
	xorl	BZ2_crc32Table(,%rcx,4), %edx
	movl	%edx, 648(%rbx)
	movl	92(%rbx), %ecx
	movb	$1, 128(%rbx,%rcx)
	movq	64(%rbx), %rcx
	movslq	108(%rbx), %rdx
	movb	%al, (%rcx,%rdx)
	incl	108(%rbx)
	movl	%r14d, 92(%rbx)
	jmp	.LBB75_28
	.p2align	4, 0x90
.LBB75_22:                              # %if.else113
                                        #   in Loop: Header=BB75_2 Depth=1
	cmpl	92(%rbx), %r14d
	jne	.LBB75_24
# BB#23:                                # %lor.lhs.false117
                                        #   in Loop: Header=BB75_2 Depth=1
	cmpl	$255, 96(%rbx)
	jne	.LBB75_27
.LBB75_24:                              # %if.then121
                                        #   in Loop: Header=BB75_2 Depth=1
	cmpl	$255, 92(%rbx)
	ja	.LBB75_26
# BB#25:                                # %if.then125
                                        #   in Loop: Header=BB75_2 Depth=1
	movq	%rbx, %rdi
	callq	add_pair_to_block
.LBB75_26:                              # %if.end126
                                        #   in Loop: Header=BB75_2 Depth=1
	movl	%r14d, 92(%rbx)
	movl	$1, 96(%rbx)
	jmp	.LBB75_28
.LBB75_27:                              # %if.else129
                                        #   in Loop: Header=BB75_2 Depth=1
	incl	96(%rbx)
	.p2align	4, 0x90
.LBB75_28:                              # %if.end133
                                        #   in Loop: Header=BB75_2 Depth=1
	movq	(%rbx), %rax
	incq	(%rax)
	movq	(%rbx), %rax
	decl	8(%rax)
	movq	(%rbx), %rax
	incl	12(%rax)
	movq	(%rbx), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB75_30
# BB#29:                                # %if.then147
                                        #   in Loop: Header=BB75_2 Depth=1
	movq	(%rbx), %rax
	incl	16(%rax)
	jmp	.LBB75_30
.LBB75_31:                              # %if.end155
                                        # kill: %AL<def> %AL<kill> %EAX<kill>
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end75:
	.size	copy_input_until_stop, .Lfunc_end75-copy_input_until_stop
	.cfi_endproc

	.p2align	4, 0x90
	.type	flush_RL,@function
flush_RL:                               # @flush_RL
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi395:
	.cfi_def_cfa_offset 16
.Lcfi396:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi397:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi398:
	.cfi_offset %rbx, -24
	movq	%rdi, %rbx
	cmpl	$255, 92(%rbx)
	ja	.LBB76_2
# BB#1:                                 # %if.then
	movq	%rbx, %rdi
	callq	add_pair_to_block
.LBB76_2:                               # %if.end
	movq	%rbx, %rdi
	callq	init_RL
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end76:
	.size	flush_RL, .Lfunc_end76-flush_RL
	.cfi_endproc

	.p2align	4, 0x90
	.type	add_pair_to_block,@function
add_pair_to_block:                      # @add_pair_to_block
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi399:
	.cfi_def_cfa_offset 16
.Lcfi400:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi401:
	.cfi_def_cfa_register %rbp
	movb	92(%rdi), %r8b
	xorl	%ecx, %ecx
	movzbl	%r8b, %edx
	cmpl	96(%rdi), %ecx
	jge	.LBB77_3
	.p2align	4, 0x90
.LBB77_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	648(%rdi), %esi
	movl	%esi, %eax
	shll	$8, %eax
	shrl	$24, %esi
	xorl	%edx, %esi
	xorl	BZ2_crc32Table(,%rsi,4), %eax
	movl	%eax, 648(%rdi)
	incl	%ecx
	cmpl	96(%rdi), %ecx
	jl	.LBB77_2
.LBB77_3:                               # %for.end
	movl	92(%rdi), %eax
	movb	$1, 128(%rdi,%rax)
	movl	96(%rdi), %ecx
	cmpl	$1, %ecx
	je	.LBB77_9
# BB#4:                                 # %for.end
	cmpl	$3, %ecx
	je	.LBB77_7
# BB#5:                                 # %for.end
	cmpl	$2, %ecx
	je	.LBB77_6
# BB#8:                                 # %sw.default
	movslq	96(%rdi), %rax
	movb	$1, 124(%rdi,%rax)
	movq	64(%rdi), %rax
	movslq	108(%rdi), %rcx
	movb	%r8b, (%rax,%rcx)
	incl	108(%rdi)
	movq	64(%rdi), %rax
	movslq	108(%rdi), %rcx
	movb	%r8b, (%rax,%rcx)
	incl	108(%rdi)
	movq	64(%rdi), %rax
	movslq	108(%rdi), %rcx
	movb	%r8b, (%rax,%rcx)
	incl	108(%rdi)
	movq	64(%rdi), %rax
	movslq	108(%rdi), %rcx
	movb	%r8b, (%rax,%rcx)
	incl	108(%rdi)
	movl	96(%rdi), %r8d
	addl	$-4, %r8d
	jmp	.LBB77_9
.LBB77_7:                               # %sw.bb27
	movq	64(%rdi), %rax
	movslq	108(%rdi), %rcx
	movb	%r8b, (%rax,%rcx)
	incl	108(%rdi)
.LBB77_6:                               # %sw.bb14
	movq	64(%rdi), %rax
	movslq	108(%rdi), %rcx
	movb	%r8b, (%rax,%rcx)
	incl	108(%rdi)
.LBB77_9:                               # %sw.epilog
	movq	64(%rdi), %rax
	movslq	108(%rdi), %rcx
	movb	%r8b, (%rax,%rcx)
	incl	108(%rdi)
	popq	%rbp
	retq
.Lfunc_end77:
	.size	add_pair_to_block, .Lfunc_end77-add_pair_to_block
	.cfi_endproc

	.p2align	4, 0x90
	.type	showFileNames,@function
showFileNames:                          # @showFileNames
	.cfi_startproc
# BB#0:                                 # %entry
	cmpb	$0, noisy(%rip)
	je	.LBB78_2
# BB#1:                                 # %if.then
	pushq	%rbp
.Lcfi402:
	.cfi_def_cfa_offset 16
.Lcfi403:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi404:
	.cfi_def_cfa_register %rbp
	movq	stderr(%rip), %rdi
	movl	$.L.str.80, %esi
	movl	$inName, %edx
	movl	$outName, %ecx
	xorl	%eax, %eax
	callq	fprintf
	popq	%rbp
.LBB78_2:                               # %if.end
	retq
.Lfunc_end78:
	.size	showFileNames, .Lfunc_end78-showFileNames
	.cfi_endproc

	.p2align	4, 0x90
	.type	cleanUpAndFail,@function
cleanUpAndFail:                         # @cleanUpAndFail
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi405:
	.cfi_def_cfa_offset 16
.Lcfi406:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi407:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$152, %rsp
.Lcfi408:
	.cfi_offset %rbx, -24
	movl	%edi, %ebx
	cmpl	$3, srcMode(%rip)
	jne	.LBB79_12
# BB#1:                                 # %entry
	cmpl	$3, opMode(%rip)
	je	.LBB79_12
# BB#2:                                 # %land.lhs.true2
	cmpb	$0, deleteOutputOnInterrupt(%rip)
	je	.LBB79_12
# BB#3:                                 # %if.then
	leaq	-152(%rbp), %rsi
	movl	$inName, %edi
	callq	stat
	testl	%eax, %eax
	jne	.LBB79_10
# BB#4:                                 # %if.then5
	cmpb	$0, noisy(%rip)
	je	.LBB79_6
# BB#5:                                 # %if.then7
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.81, %esi
	movl	$outName, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB79_6:                               # %if.end
	cmpq	$0, outputHandleJustInCase(%rip)
	je	.LBB79_8
# BB#7:                                 # %if.then11
	movq	outputHandleJustInCase(%rip), %rdi
	callq	fclose
.LBB79_8:                               # %if.end13
	movl	$outName, %edi
	callq	remove
	testl	%eax, %eax
	je	.LBB79_12
# BB#9:                                 # %if.then17
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.82, %esi
	jmp	.LBB79_11
.LBB79_10:                              # %if.else
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.83, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.84, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.85, %esi
	movl	$outName, %ecx
	xorl	%eax, %eax
	callq	fprintf
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.86, %esi
.LBB79_11:                              # %if.end25
	xorl	%eax, %eax
	callq	fprintf
.LBB79_12:                              # %if.end25
	cmpb	$0, noisy(%rip)
	je	.LBB79_16
# BB#13:                                # %if.end25
	movl	numFileNames(%rip), %eax
	testl	%eax, %eax
	jle	.LBB79_16
# BB#14:                                # %land.lhs.true31
	movl	numFilesProcessed(%rip), %eax
	cmpl	numFileNames(%rip), %eax
	jge	.LBB79_16
# BB#15:                                # %if.then34
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	numFileNames(%rip), %r8d
	movl	%r8d, %r9d
	subl	numFilesProcessed(%rip), %r9d
	movl	$.L.str.87, %esi
	xorl	%eax, %eax
	movq	%rdx, %rcx
	callq	fprintf
.LBB79_16:                              # %if.end36
	movl	%ebx, %edi
	callq	setExit
	movl	exitValue(%rip), %edi
	callq	exit
.Lfunc_end79:
	.size	cleanUpAndFail, .Lfunc_end79-cleanUpAndFail
	.cfi_endproc

	.p2align	4, 0x90
	.type	cadvise,@function
cadvise:                                # @cadvise
	.cfi_startproc
# BB#0:                                 # %entry
	cmpb	$0, noisy(%rip)
	je	.LBB80_2
# BB#1:                                 # %if.then
	pushq	%rbp
.Lcfi409:
	.cfi_def_cfa_offset 16
.Lcfi410:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi411:
	.cfi_def_cfa_register %rbp
	movq	stderr(%rip), %rdi
	movl	$.L.str.88, %esi
	xorl	%eax, %eax
	callq	fprintf
	popq	%rbp
.LBB80_2:                               # %if.end
	retq
.Lfunc_end80:
	.size	cadvise, .Lfunc_end80-cadvise
	.cfi_endproc

	.p2align	4, 0x90
	.type	mkCell,@function
mkCell:                                 # @mkCell
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi412:
	.cfi_def_cfa_offset 16
.Lcfi413:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi414:
	.cfi_def_cfa_register %rbp
	movl	$16, %edi
	callq	myMalloc
	xorps	%xmm0, %xmm0
	movups	%xmm0, (%rax)
	popq	%rbp
	retq
.Lfunc_end81:
	.size	mkCell, .Lfunc_end81-mkCell
	.cfi_endproc

	.p2align	4, 0x90
	.type	myMalloc,@function
myMalloc:                               # @myMalloc
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi415:
	.cfi_def_cfa_offset 16
.Lcfi416:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi417:
	.cfi_def_cfa_register %rbp
	movslq	%edi, %rdi
	callq	malloc
	testq	%rax, %rax
	je	.LBB82_2
# BB#1:                                 # %if.end
	popq	%rbp
	retq
.LBB82_2:                               # %if.then
	callq	outOfMemory
.Lfunc_end82:
	.size	myMalloc, .Lfunc_end82-myMalloc
	.cfi_endproc

	.p2align	4, 0x90
	.type	outOfMemory,@function
outOfMemory:                            # @outOfMemory
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi418:
	.cfi_def_cfa_offset 16
.Lcfi419:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi420:
	.cfi_def_cfa_register %rbp
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.90, %esi
	xorl	%eax, %eax
	callq	fprintf
	callq	showFileNames
	movl	$1, %edi
	callq	cleanUpAndFail
.Lfunc_end83:
	.size	outOfMemory, .Lfunc_end83-outOfMemory
	.cfi_endproc

	.p2align	4, 0x90
	.type	panic,@function
panic:                                  # @panic
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi421:
	.cfi_def_cfa_offset 16
.Lcfi422:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi423:
	.cfi_def_cfa_register %rbp
	movq	%rdi, %rcx
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.113, %esi
	xorl	%eax, %eax
	callq	fprintf
	callq	showFileNames
	movl	$3, %edi
	callq	cleanUpAndFail
.Lfunc_end84:
	.size	panic, .Lfunc_end84-panic
	.cfi_endproc

	.p2align	4, 0x90
	.type	containsDubiousChars,@function
containsDubiousChars:                   # @containsDubiousChars
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi424:
	.cfi_def_cfa_offset 16
.Lcfi425:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi426:
	.cfi_def_cfa_register %rbp
	xorl	%eax, %eax
	popq	%rbp
	retq
.Lfunc_end85:
	.size	containsDubiousChars, .Lfunc_end85-containsDubiousChars
	.cfi_endproc

	.p2align	4, 0x90
	.type	fileExists,@function
fileExists:                             # @fileExists
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi427:
	.cfi_def_cfa_offset 16
.Lcfi428:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi429:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi430:
	.cfi_offset %rbx, -24
	movl	$.L.str.108, %esi
	callq	fopen
	testq	%rax, %rax
	setne	%bl
	je	.LBB86_2
# BB#1:                                 # %if.then
	movq	%rax, %rdi
	callq	fclose
.LBB86_2:                               # %if.end
	movl	%ebx, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end86:
	.size	fileExists, .Lfunc_end86-fileExists
	.cfi_endproc

	.p2align	4, 0x90
	.type	hasSuffix,@function
hasSuffix:                              # @hasSuffix
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi431:
	.cfi_def_cfa_offset 16
.Lcfi432:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi433:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
.Lcfi434:
	.cfi_offset %rbx, -40
.Lcfi435:
	.cfi_offset %r14, -32
.Lcfi436:
	.cfi_offset %r15, -24
	movq	%rsi, %r14
	movq	%rdi, %rbx
	callq	strlen
	movq	%rax, %r15
	movq	%r14, %rdi
	callq	strlen
	cmpl	%eax, %r15d
	jge	.LBB87_2
# BB#1:
	xorl	%eax, %eax
	jmp	.LBB87_3
.LBB87_2:                               # %if.end
	movslq	%r15d, %rcx
	addq	%rcx, %rbx
	cltq
	subq	%rax, %rbx
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	strcmp
	testl	%eax, %eax
	sete	%al
.LBB87_3:                               # %return
                                        # kill: %AL<def> %AL<kill> %EAX<kill>
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end87:
	.size	hasSuffix, .Lfunc_end87-hasSuffix
	.cfi_endproc

	.p2align	4, 0x90
	.type	notAStandardFile,@function
notAStandardFile:                       # @notAStandardFile
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi437:
	.cfi_def_cfa_offset 16
.Lcfi438:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi439:
	.cfi_def_cfa_register %rbp
	subq	$144, %rsp
	leaq	-144(%rbp), %rsi
	callq	lstat
	movl	%eax, %ecx
	movb	$1, %al
	testl	%ecx, %ecx
	jne	.LBB88_2
# BB#1:                                 # %if.end
	movl	$61440, %eax            # imm = 0xF000
	andl	-120(%rbp), %eax
	cmpl	$32768, %eax            # imm = 0x8000
	setne	%al
.LBB88_2:                               # %return
	addq	$144, %rsp
	popq	%rbp
	retq
.Lfunc_end88:
	.size	notAStandardFile, .Lfunc_end88-notAStandardFile
	.cfi_endproc

	.p2align	4, 0x90
	.type	countHardLinks,@function
countHardLinks:                         # @countHardLinks
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi440:
	.cfi_def_cfa_offset 16
.Lcfi441:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi442:
	.cfi_def_cfa_register %rbp
	subq	$144, %rsp
	leaq	-144(%rbp), %rsi
	callq	lstat
	movl	-128(%rbp), %edx
	decl	%edx
	xorl	%ecx, %ecx
	testl	%eax, %eax
	cmovel	%edx, %ecx
	movl	%ecx, %eax
	addq	$144, %rsp
	popq	%rbp
	retq
.Lfunc_end89:
	.size	countHardLinks, .Lfunc_end89-countHardLinks
	.cfi_endproc

	.p2align	4, 0x90
	.type	saveInputFileMetaInfo,@function
saveInputFileMetaInfo:                  # @saveInputFileMetaInfo
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi443:
	.cfi_def_cfa_offset 16
.Lcfi444:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi445:
	.cfi_def_cfa_register %rbp
	movl	$fileMetaInfo, %esi
	callq	stat
	testl	%eax, %eax
	jne	.LBB90_2
# BB#1:                                 # %if.end
	popq	%rbp
	retq
.LBB90_2:                               # %if.then
	callq	ioError
.Lfunc_end90:
	.size	saveInputFileMetaInfo, .Lfunc_end90-saveInputFileMetaInfo
	.cfi_endproc

	.p2align	4, 0x90
	.type	pad,@function
pad:                                    # @pad
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi446:
	.cfi_def_cfa_offset 16
.Lcfi447:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi448:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
.Lcfi449:
	.cfi_offset %rbx, -40
.Lcfi450:
	.cfi_offset %r14, -32
.Lcfi451:
	.cfi_offset %r15, -24
	movq	%rdi, %r14
	callq	strlen
	cmpl	longestFileName(%rip), %eax
	jge	.LBB91_4
# BB#1:                                 # %for.cond.preheader
	movl	$1, %r15d
	jmp	.LBB91_2
	.p2align	4, 0x90
.LBB91_3:                               # %for.body
                                        #   in Loop: Header=BB91_2 Depth=1
	movq	stderr(%rip), %rdi
	movl	$.L.str.114, %esi
	xorl	%eax, %eax
	callq	fprintf
	incl	%r15d
.LBB91_2:                               # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	longestFileName(%rip), %ebx
	movq	%r14, %rdi
	callq	strlen
	subl	%eax, %ebx
	cmpl	%ebx, %r15d
	jle	.LBB91_3
.LBB91_4:                               # %for.end
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end91:
	.size	pad, .Lfunc_end91-pad
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI92_0:
	.quad	4620693217682128896     # double 8
.LCPI92_1:
	.quad	4607182418800017408     # double 1
.LCPI92_2:
	.quad	4636737291354636288     # double 100
	.text
	.p2align	4, 0x90
	.type	compressStream,@function
compressStream:                         # @compressStream
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi452:
	.cfi_def_cfa_offset 16
.Lcfi453:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi454:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$5160, %rsp             # imm = 0x1428
.Lcfi455:
	.cfi_offset %rbx, -56
.Lcfi456:
	.cfi_offset %r12, -48
.Lcfi457:
	.cfi_offset %r13, -40
.Lcfi458:
	.cfi_offset %r14, -32
.Lcfi459:
	.cfi_offset %r15, -24
	movq	%rsi, -56(%rbp)         # 8-byte Spill
	movq	%rdi, %rbx
	callq	ferror
	testl	%eax, %eax
	jne	.LBB92_28
# BB#1:                                 # %if.end
	movq	-56(%rbp), %rdi         # 8-byte Reload
	callq	ferror
	testl	%eax, %eax
	jne	.LBB92_28
# BB#2:                                 # %if.end4
	movl	blockSize100k(%rip), %edx
	movl	verbosity(%rip), %ecx
	movl	workFactor(%rip), %r8d
	leaq	-44(%rbp), %rdi
	movq	-56(%rbp), %rsi         # 8-byte Reload
	callq	BZ2_bzWriteOpen
	movq	%rax, %r15
	cmpl	$0, -44(%rbp)
	jne	.LBB92_11
# BB#3:                                 # %if.end7
	cmpl	$2, verbosity(%rip)
	jl	.LBB92_5
# BB#4:                                 # %if.then9
	movq	stderr(%rip), %rdi
	movl	$.L.str.59, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB92_5:                               # %while.body.preheader
	leaq	-5184(%rbp), %r12
	leaq	-44(%rbp), %r13
	.p2align	4, 0x90
.LBB92_6:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movq	%rbx, %rdi
	callq	myfeof
	testb	%al, %al
	jne	.LBB92_15
# BB#7:                                 # %if.end15
                                        #   in Loop: Header=BB92_6 Depth=1
	movl	$1, %esi
	movl	$5000, %edx             # imm = 0x1388
	movq	%r12, %rdi
	movq	%rbx, %rcx
	callq	fread
	movq	%rax, %r14
	movq	%rbx, %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB92_28
# BB#8:                                 # %if.end20
                                        #   in Loop: Header=BB92_6 Depth=1
	testl	%r14d, %r14d
	jle	.LBB92_10
# BB#9:                                 # %if.then23
                                        #   in Loop: Header=BB92_6 Depth=1
	movq	%r13, %rdi
	movq	%r15, %rsi
	movq	%r12, %rdx
	movl	%r14d, %ecx
	callq	BZ2_bzWrite
.LBB92_10:                              # %if.end25
                                        #   in Loop: Header=BB92_6 Depth=1
	cmpl	$0, -44(%rbp)
	je	.LBB92_6
.LBB92_11:                              # %errhandler
	leaq	-68(%rbp), %rax
	movq	%rax, (%rsp)
	leaq	-84(%rbp), %rdi
	leaq	-64(%rbp), %rcx
	leaq	-60(%rbp), %r8
	leaq	-72(%rbp), %r9
	movl	$1, %edx
	movq	%r15, %rsi
	callq	BZ2_bzWriteClose64
	movl	-44(%rbp), %eax
	cmpl	$-3, %eax
	je	.LBB92_27
# BB#12:                                # %errhandler
	cmpl	$-6, %eax
	je	.LBB92_28
# BB#13:                                # %errhandler
	cmpl	$-9, %eax
	jne	.LBB92_29
# BB#14:                                # %sw.bb
	callq	configError
.LBB92_15:                              # %while.end
	leaq	-68(%rbp), %rax
	movq	%rax, (%rsp)
	leaq	-44(%rbp), %rdi
	leaq	-64(%rbp), %rcx
	leaq	-60(%rbp), %r8
	leaq	-72(%rbp), %r9
	xorl	%edx, %edx
	movq	%r15, %rsi
	callq	BZ2_bzWriteClose64
	cmpl	$0, -44(%rbp)
	jne	.LBB92_11
# BB#16:                                # %if.end33
	movq	-56(%rbp), %rdi         # 8-byte Reload
	callq	ferror
	testl	%eax, %eax
	jne	.LBB92_28
# BB#17:                                # %if.end37
	movq	-56(%rbp), %rdi         # 8-byte Reload
	callq	fflush
	cmpl	$-1, %eax
	je	.LBB92_28
# BB#18:                                # %if.end42
	movq	-56(%rbp), %rax         # 8-byte Reload
	cmpq	stdout(%rip), %rax
	je	.LBB92_20
# BB#19:                                # %if.then45
	movq	-56(%rbp), %rdi         # 8-byte Reload
	callq	fclose
	movq	$0, outputHandleJustInCase(%rip)
	cmpl	$-1, %eax
	je	.LBB92_28
.LBB92_20:                              # %if.end51
	movq	$0, outputHandleJustInCase(%rip)
	movq	%rbx, %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB92_28
# BB#21:                                # %if.end55
	movq	%rbx, %rdi
	callq	fclose
	cmpl	$-1, %eax
	je	.LBB92_28
# BB#22:                                # %if.end60
	cmpl	$0, verbosity(%rip)
	jle	.LBB92_26
# BB#23:                                # %if.then63
	movl	-64(%rbp), %eax
	orl	-60(%rbp), %eax
	jne	.LBB92_25
# BB#24:                                # %if.then68
	movq	stderr(%rip), %rdi
	movl	$.L.str.115, %esi
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB92_26
.LBB92_25:                              # %if.else
	movl	-64(%rbp), %esi
	movl	-60(%rbp), %edx
	leaq	-104(%rbp), %r15
	movq	%r15, %rdi
	callq	uInt64_from_UInt32s
	movl	-72(%rbp), %esi
	movl	-68(%rbp), %edx
	leaq	-96(%rbp), %rbx
	movq	%rbx, %rdi
	callq	uInt64_from_UInt32s
	movq	%r15, %rdi
	callq	uInt64_to_double
	movsd	%xmm0, -56(%rbp)        # 8-byte Spill
	movq	%rbx, %rdi
	callq	uInt64_to_double
	movsd	%xmm0, -80(%rbp)        # 8-byte Spill
	leaq	-176(%rbp), %r14
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	uInt64_toAscii
	leaq	-144(%rbp), %r15
	movq	%r15, %rdi
	movq	%rbx, %rsi
	callq	uInt64_toAscii
	movq	stderr(%rip), %rdi
	movsd	-56(%rbp), %xmm2        # 8-byte Reload
                                        # xmm2 = mem[0],zero
	movapd	%xmm2, %xmm0
	movsd	-80(%rbp), %xmm3        # 8-byte Reload
                                        # xmm3 = mem[0],zero
	divsd	%xmm3, %xmm0
	movsd	.LCPI92_0(%rip), %xmm1  # xmm1 = mem[0],zero
	mulsd	%xmm3, %xmm1
	divsd	%xmm2, %xmm1
	divsd	%xmm2, %xmm3
	movsd	.LCPI92_1(%rip), %xmm2  # xmm2 = mem[0],zero
	subsd	%xmm3, %xmm2
	mulsd	.LCPI92_2(%rip), %xmm2
	movl	$.L.str.116, %esi
	movb	$3, %al
	movq	%r14, %rdx
	movq	%r15, %rcx
	callq	fprintf
.LBB92_26:                              # %if.end81
	addq	$5160, %rsp             # imm = 0x1428
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB92_28:                              # %errhandler_io
	callq	ioError
.LBB92_27:                              # %sw.bb82
	callq	outOfMemory
.LBB92_29:                              # %sw.default
	movl	$.L.str.117, %edi
	callq	panic
.Lfunc_end92:
	.size	compressStream, .Lfunc_end92-compressStream
	.cfi_endproc

	.p2align	4, 0x90
	.type	applySavedMetaInfoToOutputFile,@function
applySavedMetaInfoToOutputFile:         # @applySavedMetaInfoToOutputFile
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi460:
	.cfi_def_cfa_offset 16
.Lcfi461:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi462:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$24, %rsp
.Lcfi463:
	.cfi_offset %rbx, -24
	movq	%rdi, %rbx
	movq	fileMetaInfo+72(%rip), %rax
	movq	%rax, -24(%rbp)
	movq	fileMetaInfo+88(%rip), %rax
	movq	%rax, -16(%rbp)
	movl	fileMetaInfo+24(%rip), %esi
	callq	chmod
	testl	%eax, %eax
	jne	.LBB93_3
# BB#1:                                 # %if.end
	leaq	-24(%rbp), %rsi
	movq	%rbx, %rdi
	callq	utime
	testl	%eax, %eax
	jne	.LBB93_3
# BB#2:                                 # %if.end4
	movl	fileMetaInfo+28(%rip), %esi
	movl	fileMetaInfo+32(%rip), %edx
	movq	%rbx, %rdi
	callq	chown
	addq	$24, %rsp
	popq	%rbx
	popq	%rbp
	retq
.LBB93_3:                               # %if.then3
	callq	ioError
.Lfunc_end93:
	.size	applySavedMetaInfoToOutputFile, .Lfunc_end93-applySavedMetaInfoToOutputFile
	.cfi_endproc

	.p2align	4, 0x90
	.type	ioError,@function
ioError:                                # @ioError
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi464:
	.cfi_def_cfa_offset 16
.Lcfi465:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi466:
	.cfi_def_cfa_register %rbp
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.119, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	progName(%rip), %rdi
	callq	perror
	callq	showFileNames
	movl	$1, %edi
	callq	cleanUpAndFail
.Lfunc_end94:
	.size	ioError, .Lfunc_end94-ioError
	.cfi_endproc

	.p2align	4, 0x90
	.type	uInt64_from_UInt32s,@function
uInt64_from_UInt32s:                    # @uInt64_from_UInt32s
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi467:
	.cfi_def_cfa_offset 16
.Lcfi468:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi469:
	.cfi_def_cfa_register %rbp
	movl	%esi, %eax
	movl	%edx, %ecx
	shrl	$24, %ecx
	movb	%cl, 7(%rdi)
	movl	%edx, %ecx
	shrl	$16, %ecx
	movb	%cl, 6(%rdi)
	movb	%dh, 5(%rdi)  # NOREX
	movb	%dl, 4(%rdi)
	movl	%eax, %ecx
	shrl	$24, %ecx
	movb	%cl, 3(%rdi)
	movl	%eax, %ecx
	shrl	$16, %ecx
	movb	%cl, 2(%rdi)
	movb	%ah, 1(%rdi)  # NOREX
	movb	%al, (%rdi)
	popq	%rbp
	retq
.Lfunc_end95:
	.size	uInt64_from_UInt32s, .Lfunc_end95-uInt64_from_UInt32s
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI96_0:
	.quad	4607182418800017408     # double 1
.LCPI96_1:
	.quad	4643211215818981376     # double 256
	.text
	.p2align	4, 0x90
	.type	uInt64_to_double,@function
uInt64_to_double:                       # @uInt64_to_double
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi470:
	.cfi_def_cfa_offset 16
.Lcfi471:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi472:
	.cfi_def_cfa_register %rbp
	xorpd	%xmm0, %xmm0
	movsd	.LCPI96_0(%rip), %xmm1  # xmm1 = mem[0],zero
	xorl	%eax, %eax
	movsd	.LCPI96_1(%rip), %xmm2  # xmm2 = mem[0],zero
	cmpl	$7, %eax
	jg	.LBB96_3
	.p2align	4, 0x90
.LBB96_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movzbl	(%rdi,%rax), %ecx
	xorps	%xmm3, %xmm3
	cvtsi2sdl	%ecx, %xmm3
	mulsd	%xmm1, %xmm3
	addsd	%xmm3, %xmm0
	mulsd	%xmm2, %xmm1
	incq	%rax
	cmpl	$7, %eax
	jle	.LBB96_2
.LBB96_3:                               # %for.end
	popq	%rbp
	retq
.Lfunc_end96:
	.size	uInt64_to_double, .Lfunc_end96-uInt64_to_double
	.cfi_endproc

	.p2align	4, 0x90
	.type	uInt64_toAscii,@function
uInt64_toAscii:                         # @uInt64_toAscii
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi473:
	.cfi_def_cfa_offset 16
.Lcfi474:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi475:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$40, %rsp
.Lcfi476:
	.cfi_offset %rbx, -40
.Lcfi477:
	.cfi_offset %r14, -32
.Lcfi478:
	.cfi_offset %r15, -24
	movq	%rdi, %r14
	movq	(%rsi), %rax
	movq	%rax, -32(%rbp)
	xorl	%ebx, %ebx
	leaq	-32(%rbp), %r15
	.p2align	4, 0x90
.LBB97_1:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movq	%r15, %rdi
	callq	uInt64_qrm10
	addl	$48, %eax
	movb	%al, -64(%rbp,%rbx)
	movq	%r15, %rdi
	callq	uInt64_isZero
	incq	%rbx
	testb	%al, %al
	je	.LBB97_1
# BB#2:                                 # %do.end
	movslq	%ebx, %rax
	movb	$0, (%r14,%rax)
	leaq	-65(%rbp,%rbx), %rax
	xorl	%ecx, %ecx
	cmpl	%ebx, %ecx
	jge	.LBB97_5
	.p2align	4, 0x90
.LBB97_4:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movzbl	(%rax), %edx
	movb	%dl, (%r14,%rcx)
	incq	%rcx
	decq	%rax
	cmpl	%ebx, %ecx
	jl	.LBB97_4
.LBB97_5:                               # %for.end
	addq	$40, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end97:
	.size	uInt64_toAscii, .Lfunc_end97-uInt64_toAscii
	.cfi_endproc

	.p2align	4, 0x90
	.type	configError,@function
configError:                            # @configError
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi479:
	.cfi_def_cfa_offset 16
.Lcfi480:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi481:
	.cfi_def_cfa_register %rbp
	movq	stderr(%rip), %rdi
	movl	$.L.str.118, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	$3, %edi
	callq	setExit
	movl	exitValue(%rip), %edi
	callq	exit
.Lfunc_end98:
	.size	configError, .Lfunc_end98-configError
	.cfi_endproc

	.p2align	4, 0x90
	.type	uInt64_qrm10,@function
uInt64_qrm10:                           # @uInt64_qrm10
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi482:
	.cfi_def_cfa_offset 16
.Lcfi483:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi484:
	.cfi_def_cfa_register %rbp
	xorl	%eax, %eax
	movl	$7, %ecx
	movl	$3435973837, %edx       # imm = 0xCCCCCCCD
	testl	%ecx, %ecx
	js	.LBB99_3
	.p2align	4, 0x90
.LBB99_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	shll	$8, %eax
	movzbl	(%rdi,%rcx), %esi
	orl	%eax, %esi
	movq	%rsi, %rax
	imulq	%rdx, %rax
	shrq	$35, %rax
	movb	%al, (%rdi,%rcx)
	leal	(%rax,%rax), %eax
	leal	(%rax,%rax,4), %eax
	subl	%eax, %esi
	decq	%rcx
	movl	%esi, %eax
	testl	%ecx, %ecx
	jns	.LBB99_2
.LBB99_3:                               # %for.end
	popq	%rbp
	retq
.Lfunc_end99:
	.size	uInt64_qrm10, .Lfunc_end99-uInt64_qrm10
	.cfi_endproc

	.p2align	4, 0x90
	.type	uInt64_isZero,@function
uInt64_isZero:                          # @uInt64_isZero
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi485:
	.cfi_def_cfa_offset 16
.Lcfi486:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi487:
	.cfi_def_cfa_register %rbp
	xorl	%eax, %eax
	cmpl	$7, %eax
	jle	.LBB100_3
	jmp	.LBB100_2
	.p2align	4, 0x90
.LBB100_6:                              # %for.inc
                                        #   in Loop: Header=BB100_3 Depth=1
	incq	%rax
	cmpl	$7, %eax
	jg	.LBB100_2
.LBB100_3:                              # %for.body
                                        # =>This Inner Loop Header: Depth=1
	cmpb	$0, (%rdi,%rax)
	je	.LBB100_6
# BB#4:
	xorl	%eax, %eax
	jmp	.LBB100_5
.LBB100_2:
	movb	$1, %al
.LBB100_5:                              # %return
                                        # kill: %AL<def> %AL<kill> %EAX<kill>
	popq	%rbp
	retq
.Lfunc_end100:
	.size	uInt64_isZero, .Lfunc_end100-uInt64_isZero
	.cfi_endproc

	.p2align	4, 0x90
	.type	mapSuffix,@function
mapSuffix:                              # @mapSuffix
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi488:
	.cfi_def_cfa_offset 16
.Lcfi489:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi490:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
.Lcfi491:
	.cfi_offset %rbx, -48
.Lcfi492:
	.cfi_offset %r12, -40
.Lcfi493:
	.cfi_offset %r14, -32
.Lcfi494:
	.cfi_offset %r15, -24
	movq	%rdx, %r14
	movq	%rsi, %r15
	movq	%rdi, %rbx
	callq	hasSuffix
	testb	%al, %al
	je	.LBB101_1
# BB#2:                                 # %if.end
	movq	%rbx, %rdi
	callq	strlen
	movq	%rax, %r12
	movq	%r15, %rdi
	callq	strlen
	subq	%rax, %r12
	movb	$0, (%rbx,%r12)
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	strcat
	movb	$1, %al
	jmp	.LBB101_3
.LBB101_1:
	xorl	%eax, %eax
.LBB101_3:                              # %return
                                        # kill: %AL<def> %AL<kill> %EAX<kill>
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.Lfunc_end101:
	.size	mapSuffix, .Lfunc_end101-mapSuffix
	.cfi_endproc

	.p2align	4, 0x90
	.type	uncompressStream,@function
uncompressStream:                       # @uncompressStream
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi495:
	.cfi_def_cfa_offset 16
.Lcfi496:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi497:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$10040, %rsp            # imm = 0x2738
.Lcfi498:
	.cfi_offset %rbx, -56
.Lcfi499:
	.cfi_offset %r12, -48
.Lcfi500:
	.cfi_offset %r13, -40
.Lcfi501:
	.cfi_offset %r14, -32
.Lcfi502:
	.cfi_offset %r15, -24
	movq	%rsi, %r13
	movq	%rdi, %r14
	movl	$0, -48(%rbp)
	movq	%r13, %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB102_12
# BB#1:                                 # %if.end
	movq	%r14, %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB102_12
# BB#2:                                 # %while.body.preheader
	xorl	%eax, %eax
	movq	%rax, -56(%rbp)         # 8-byte Spill
	leaq	-44(%rbp), %r15
	leaq	-5072(%rbp), %r12
	leaq	-10080(%rbp), %rbx
.LBB102_3:                              # %while.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB102_6 Depth 2
                                        #     Child Loop BB102_17 Depth 2
	movl	verbosity(%rip), %edx
	movzbl	smallMode(%rip), %ecx
	movl	-48(%rbp), %r9d
	movq	%r15, %rdi
	movq	%r14, %rsi
	movq	%r12, %r8
	callq	BZ2_bzReadOpen
	movq	%rax, %r12
	testq	%r12, %r12
	je	.LBB102_36
# BB#4:                                 # %while.body
                                        #   in Loop: Header=BB102_3 Depth=1
	movl	-44(%rbp), %eax
	testl	%eax, %eax
	jne	.LBB102_36
# BB#5:                                 # %if.end10
                                        #   in Loop: Header=BB102_3 Depth=1
	movq	-56(%rbp), %rax         # 8-byte Reload
	incl	%eax
	movq	%rax, -56(%rbp)         # 8-byte Spill
	.p2align	4, 0x90
.LBB102_6:                              # %while.cond11
                                        #   Parent Loop BB102_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$0, -44(%rbp)
	jne	.LBB102_13
# BB#7:                                 # %while.body14
                                        #   in Loop: Header=BB102_6 Depth=2
	movl	$5000, %ecx             # imm = 0x1388
	movq	%r15, %rdi
	movq	%r12, %rsi
	movq	%rbx, %rdx
	callq	BZ2_bzRead
	cmpl	$-5, -44(%rbp)
	je	.LBB102_29
# BB#8:                                 # %if.end20
                                        #   in Loop: Header=BB102_6 Depth=2
	movl	-44(%rbp), %ecx
	testl	%ecx, %ecx
	sete	%dl
	cmpl	$4, %ecx
	sete	%cl
	orb	%dl, %cl
	cmpb	$1, %cl
	jne	.LBB102_11
# BB#9:                                 # %if.end20
                                        #   in Loop: Header=BB102_6 Depth=2
	testl	%eax, %eax
	jle	.LBB102_11
# BB#10:                                # %if.then28
                                        #   in Loop: Header=BB102_6 Depth=2
	movslq	%eax, %rdx
	movl	$1, %esi
	movq	%rbx, %rdi
	movq	%r13, %rcx
	callq	fwrite
.LBB102_11:                             # %if.end32
                                        #   in Loop: Header=BB102_6 Depth=2
	movq	%r13, %rdi
	callq	ferror
	testl	%eax, %eax
	je	.LBB102_6
	jmp	.LBB102_12
	.p2align	4, 0x90
.LBB102_13:                             # %while.end
                                        #   in Loop: Header=BB102_3 Depth=1
	cmpl	$4, -44(%rbp)
	jne	.LBB102_36
# BB#14:                                # %if.end40
                                        #   in Loop: Header=BB102_3 Depth=1
	movq	%r15, %rdi
	movq	%r12, %rsi
	leaq	-64(%rbp), %rdx
	leaq	-48(%rbp), %rcx
	callq	BZ2_bzReadGetUnused
	cmpl	$0, -44(%rbp)
	jne	.LBB102_51
# BB#15:                                # %for.cond.preheader
                                        #   in Loop: Header=BB102_3 Depth=1
	xorl	%eax, %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB102_18
	.p2align	4, 0x90
.LBB102_17:                             # %for.body
                                        #   Parent Loop BB102_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-64(%rbp), %rcx
	movzbl	(%rcx,%rax), %ecx
	movb	%cl, -5072(%rbp,%rax)
	incq	%rax
	cmpl	-48(%rbp), %eax
	jl	.LBB102_17
.LBB102_18:                             # %for.end
                                        #   in Loop: Header=BB102_3 Depth=1
	movq	%r15, %rdi
	movq	%r12, %rsi
	callq	BZ2_bzReadClose
	cmpl	$0, -44(%rbp)
	jne	.LBB102_51
# BB#19:                                # %if.end53
                                        #   in Loop: Header=BB102_3 Depth=1
	cmpl	$0, -48(%rbp)
	leaq	-5072(%rbp), %r12
	jne	.LBB102_3
# BB#20:                                # %land.lhs.true56
                                        #   in Loop: Header=BB102_3 Depth=1
	movq	%r14, %rdi
	callq	myfeof
	testb	%al, %al
	je	.LBB102_3
	jmp	.LBB102_21
.LBB102_29:                             # %trycat
	cmpb	$0, forceOverwrite(%rip)
	je	.LBB102_36
# BB#30:                                # %if.then96
	movq	%r14, %rdi
	callq	rewind
	leaq	-10080(%rbp), %r15
	.p2align	4, 0x90
.LBB102_31:                             # %while.body97
                                        # =>This Inner Loop Header: Depth=1
	movq	%r14, %rdi
	callq	myfeof
	testb	%al, %al
	jne	.LBB102_21
# BB#32:                                # %if.end101
                                        #   in Loop: Header=BB102_31 Depth=1
	movl	$1, %esi
	movl	$5000, %edx             # imm = 0x1388
	movq	%r15, %rdi
	movq	%r14, %rcx
	callq	fread
	movq	%rax, %rbx
	movq	%r14, %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB102_12
# BB#33:                                # %if.end108
                                        #   in Loop: Header=BB102_31 Depth=1
	testl	%ebx, %ebx
	jle	.LBB102_35
# BB#34:                                # %if.then111
                                        #   in Loop: Header=BB102_31 Depth=1
	movslq	%ebx, %rdx
	movl	$1, %esi
	movq	%r15, %rdi
	movq	%r13, %rcx
	callq	fwrite
.LBB102_35:                             # %if.end115
                                        #   in Loop: Header=BB102_31 Depth=1
	movq	%r13, %rdi
	callq	ferror
	testl	%eax, %eax
	je	.LBB102_31
.LBB102_12:                             # %errhandler_io
	callq	ioError
.LBB102_21:                             # %closeok
	movq	%r14, %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB102_12
# BB#22:                                # %if.end66
	movq	%r14, %rdi
	callq	fclose
	cmpl	$-1, %eax
	je	.LBB102_12
# BB#23:                                # %if.end71
	movq	%r13, %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB102_12
# BB#24:                                # %if.end75
	movq	%r13, %rdi
	callq	fflush
	testl	%eax, %eax
	jne	.LBB102_12
# BB#25:                                # %if.end80
	cmpq	stdout(%rip), %r13
	je	.LBB102_27
# BB#26:                                # %if.then83
	movq	%r13, %rdi
	callq	fclose
	movq	$0, outputHandleJustInCase(%rip)
	cmpl	$-1, %eax
	je	.LBB102_12
.LBB102_27:                             # %if.end89
	movq	$0, outputHandleJustInCase(%rip)
	movb	$1, %bl
	cmpl	$2, verbosity(%rip)
	jl	.LBB102_50
# BB#28:                                # %if.then92
	movq	stderr(%rip), %rdi
	movl	$.L.str.130, %esi
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB102_50
.LBB102_36:                             # %errhandler
	leaq	-68(%rbp), %rdi
	movq	%r12, %rsi
	callq	BZ2_bzReadClose
	movl	-44(%rbp), %eax
	addl	$9, %eax
	cmpl	$6, %eax
	ja	.LBB102_52
# BB#37:                                # %errhandler
	jmpq	*.LJTI102_0(,%rax,8)
.LBB102_42:                             # %sw.bb126
	cmpq	stdin(%rip), %r14
	je	.LBB102_44
# BB#43:                                # %if.then129
	movq	%r14, %rdi
	callq	fclose
.LBB102_44:                             # %if.end131
	cmpq	stdout(%rip), %r13
	je	.LBB102_46
# BB#45:                                # %if.then134
	movq	%r13, %rdi
	callq	fclose
.LBB102_46:                             # %if.end136
	cmpl	$1, -56(%rbp)           # 4-byte Folded Reload
	jne	.LBB102_48
# BB#47:
	xorl	%ebx, %ebx
	jmp	.LBB102_50
.LBB102_48:                             # %if.else
	movb	$1, %bl
	cmpb	$0, noisy(%rip)
	je	.LBB102_50
# BB#49:                                # %if.then141
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.131, %esi
	movl	$inName, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB102_50:                             # %return
	movl	%ebx, %eax
	addq	$10040, %rsp            # imm = 0x2738
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB102_51:                             # %if.then52
	movl	$.L.str.129, %edi
	callq	panic
.LBB102_38:                             # %sw.bb
	callq	configError
.LBB102_52:                             # %sw.default
	movl	$.L.str.132, %edi
	callq	panic
.LBB102_41:                             # %sw.bb125
	callq	compressedStreamEOF
.LBB102_39:                             # %sw.bb123
	callq	crcError
.LBB102_40:                             # %sw.bb124
	callq	outOfMemory
.Lfunc_end102:
	.size	uncompressStream, .Lfunc_end102-uncompressStream
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	3
.LJTI102_0:
	.quad	.LBB102_38
	.quad	.LBB102_52
	.quad	.LBB102_41
	.quad	.LBB102_12
	.quad	.LBB102_42
	.quad	.LBB102_39
	.quad	.LBB102_40

	.text
	.p2align	4, 0x90
	.type	crcError,@function
crcError:                               # @crcError
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi503:
	.cfi_def_cfa_offset 16
.Lcfi504:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi505:
	.cfi_def_cfa_register %rbp
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.133, %esi
	xorl	%eax, %eax
	callq	fprintf
	callq	showFileNames
	callq	cadvise
	movl	$2, %edi
	callq	cleanUpAndFail
.Lfunc_end103:
	.size	crcError, .Lfunc_end103-crcError
	.cfi_endproc

	.p2align	4, 0x90
	.type	compressedStreamEOF,@function
compressedStreamEOF:                    # @compressedStreamEOF
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi506:
	.cfi_def_cfa_offset 16
.Lcfi507:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi508:
	.cfi_def_cfa_register %rbp
	cmpb	$0, noisy(%rip)
	je	.LBB104_2
# BB#1:                                 # %if.then
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.134, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	progName(%rip), %rdi
	callq	perror
	callq	showFileNames
	callq	cadvise
.LBB104_2:                              # %if.end
	movl	$2, %edi
	callq	cleanUpAndFail
.Lfunc_end104:
	.size	compressedStreamEOF, .Lfunc_end104-compressedStreamEOF
	.cfi_endproc

	.p2align	4, 0x90
	.type	testStream,@function
testStream:                             # @testStream
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi509:
	.cfi_def_cfa_offset 16
.Lcfi510:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi511:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$10040, %rsp            # imm = 0x2738
.Lcfi512:
	.cfi_offset %rbx, -56
.Lcfi513:
	.cfi_offset %r12, -48
.Lcfi514:
	.cfi_offset %r13, -40
.Lcfi515:
	.cfi_offset %r14, -32
.Lcfi516:
	.cfi_offset %r15, -24
	movq	%rdi, %r14
	movl	$0, -48(%rbp)
	callq	ferror
	testl	%eax, %eax
	jne	.LBB105_26
# BB#1:                                 # %while.body.preheader
	xorl	%eax, %eax
	movq	%rax, -56(%rbp)         # 8-byte Spill
	leaq	-44(%rbp), %rbx
	leaq	-5072(%rbp), %r13
	leaq	-10080(%rbp), %r12
.LBB105_2:                              # %while.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB105_5 Depth 2
                                        #     Child Loop BB105_15 Depth 2
	movl	verbosity(%rip), %edx
	movzbl	smallMode(%rip), %ecx
	movl	-48(%rbp), %r9d
	movq	%rbx, %rdi
	movq	%r14, %r15
	movq	%r14, %rsi
	movq	%r13, %r14
	movq	%r13, %r8
	callq	BZ2_bzReadOpen
	movq	%rax, %r13
	testq	%r13, %r13
	je	.LBB105_7
# BB#3:                                 # %while.body
                                        #   in Loop: Header=BB105_2 Depth=1
	movl	-44(%rbp), %eax
	testl	%eax, %eax
	jne	.LBB105_7
# BB#4:                                 # %if.end6
                                        #   in Loop: Header=BB105_2 Depth=1
	movq	-56(%rbp), %rax         # 8-byte Reload
	incl	%eax
	movq	%rax, -56(%rbp)         # 8-byte Spill
	.p2align	4, 0x90
.LBB105_5:                              # %while.cond7
                                        #   Parent Loop BB105_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$0, -44(%rbp)
	jne	.LBB105_11
# BB#6:                                 # %while.body10
                                        #   in Loop: Header=BB105_5 Depth=2
	movl	$5000, %ecx             # imm = 0x1388
	movq	%rbx, %rdi
	movq	%r13, %rsi
	movq	%r12, %rdx
	callq	BZ2_bzRead
	cmpl	$-5, -44(%rbp)
	jne	.LBB105_5
	jmp	.LBB105_7
	.p2align	4, 0x90
.LBB105_11:                             # %while.end
                                        #   in Loop: Header=BB105_2 Depth=1
	cmpl	$4, -44(%rbp)
	jne	.LBB105_7
# BB#12:                                # %if.end20
                                        #   in Loop: Header=BB105_2 Depth=1
	movq	%rbx, %rdi
	movq	%r13, %rsi
	leaq	-64(%rbp), %rdx
	leaq	-48(%rbp), %rcx
	callq	BZ2_bzReadGetUnused
	cmpl	$0, -44(%rbp)
	jne	.LBB105_37
# BB#13:                                # %for.cond.preheader
                                        #   in Loop: Header=BB105_2 Depth=1
	xorl	%eax, %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB105_16
	.p2align	4, 0x90
.LBB105_15:                             # %for.body
                                        #   Parent Loop BB105_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-64(%rbp), %rcx
	movzbl	(%rcx,%rax), %ecx
	movb	%cl, -5072(%rbp,%rax)
	incq	%rax
	cmpl	-48(%rbp), %eax
	jl	.LBB105_15
.LBB105_16:                             # %for.end
                                        #   in Loop: Header=BB105_2 Depth=1
	movq	%rbx, %rdi
	movq	%r13, %rsi
	callq	BZ2_bzReadClose
	cmpl	$0, -44(%rbp)
	jne	.LBB105_37
# BB#17:                                # %if.end33
                                        #   in Loop: Header=BB105_2 Depth=1
	cmpl	$0, -48(%rbp)
	movq	%r14, %r13
	movq	%r15, %r14
	jne	.LBB105_2
# BB#18:                                # %land.lhs.true
                                        #   in Loop: Header=BB105_2 Depth=1
	movq	%r14, %rdi
	callq	myfeof
	testb	%al, %al
	je	.LBB105_2
# BB#19:                                # %while.end41
	movq	%r14, %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB105_26
# BB#20:                                # %if.end45
	movq	%r14, %rdi
	callq	fclose
	cmpl	$-1, %eax
	je	.LBB105_26
# BB#21:                                # %if.end50
	movb	$1, %bl
	cmpl	$2, verbosity(%rip)
	jl	.LBB105_24
# BB#22:                                # %if.then53
	movq	stderr(%rip), %rdi
	movl	$.L.str.130, %esi
	jmp	.LBB105_23
.LBB105_7:                              # %errhandler
	leaq	-68(%rbp), %rdi
	movq	%r13, %rsi
	callq	BZ2_bzReadClose
	cmpl	$0, verbosity(%rip)
	jne	.LBB105_9
# BB#8:                                 # %if.then58
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.140, %esi
	movl	$inName, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB105_9:                              # %if.end60
	movl	-44(%rbp), %eax
	addl	$9, %eax
	cmpl	$6, %eax
	ja	.LBB105_36
# BB#10:                                # %if.end60
	jmpq	*.LJTI105_0(,%rax,8)
.LBB105_29:                             # %sw.bb65
	movq	stderr(%rip), %rdi
	xorl	%ebx, %ebx
	movl	$.L.str.142, %esi
	jmp	.LBB105_23
.LBB105_30:                             # %sw.bb67
	cmpq	stdin(%rip), %r15
	je	.LBB105_32
# BB#31:                                # %if.then70
	movq	%r15, %rdi
	callq	fclose
.LBB105_32:                             # %if.end72
	cmpl	$1, -56(%rbp)           # 4-byte Folded Reload
	jne	.LBB105_34
# BB#33:                                # %if.then75
	movq	stderr(%rip), %rdi
	xorl	%ebx, %ebx
	movl	$.L.str.143, %esi
	jmp	.LBB105_23
.LBB105_27:                             # %sw.bb62
	movq	stderr(%rip), %rdi
	xorl	%ebx, %ebx
	movl	$.L.str.141, %esi
	jmp	.LBB105_23
.LBB105_34:                             # %if.else
	movb	$1, %bl
	cmpb	$0, noisy(%rip)
	je	.LBB105_24
# BB#35:                                # %if.then78
	movq	stderr(%rip), %rdi
	movl	$.L.str.144, %esi
.LBB105_23:                             # %return
	xorl	%eax, %eax
	callq	fprintf
.LBB105_24:                             # %return
	movl	%ebx, %eax
	addq	$10040, %rsp            # imm = 0x2738
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB105_37:                             # %if.then32
	movl	$.L.str.139, %edi
	callq	panic
.LBB105_26:                             # %errhandler_io
	callq	ioError
.LBB105_25:                             # %sw.bb
	callq	configError
.LBB105_36:                             # %sw.default
	movl	$.L.str.145, %edi
	callq	panic
.LBB105_28:                             # %sw.bb64
	callq	outOfMemory
.Lfunc_end105:
	.size	testStream, .Lfunc_end105-testStream
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	3
.LJTI105_0:
	.quad	.LBB105_25
	.quad	.LBB105_36
	.quad	.LBB105_29
	.quad	.LBB105_26
	.quad	.LBB105_30
	.quad	.LBB105_27
	.quad	.LBB105_28

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"      %d work, %d block, ratio %5.2f\n"
	.size	.L.str, 38

	.type	.L.str.1,@object        # @.str.1
.L.str.1:
	.asciz	"    too repetitive; using fallback sorting algorithm\n"
	.size	.L.str.1, 54

	.type	BZ2_crc32Table,@object  # @BZ2_crc32Table
	.data
	.globl	BZ2_crc32Table
	.p2align	4
BZ2_crc32Table:
	.long	0                       # 0x0
	.long	79764919                # 0x4c11db7
	.long	159529838               # 0x9823b6e
	.long	222504665               # 0xd4326d9
	.long	319059676               # 0x130476dc
	.long	398814059               # 0x17c56b6b
	.long	445009330               # 0x1a864db2
	.long	507990021               # 0x1e475005
	.long	638119352               # 0x2608edb8
	.long	583659535               # 0x22c9f00f
	.long	797628118               # 0x2f8ad6d6
	.long	726387553               # 0x2b4bcb61
	.long	890018660               # 0x350c9b64
	.long	835552979               # 0x31cd86d3
	.long	1015980042              # 0x3c8ea00a
	.long	944750013               # 0x384fbdbd
	.long	1276238704              # 0x4c11db70
	.long	1221641927              # 0x48d0c6c7
	.long	1167319070              # 0x4593e01e
	.long	1095957929              # 0x4152fda9
	.long	1595256236              # 0x5f15adac
	.long	1540665371              # 0x5bd4b01b
	.long	1452775106              # 0x569796c2
	.long	1381403509              # 0x52568b75
	.long	1780037320              # 0x6a1936c8
	.long	1859660671              # 0x6ed82b7f
	.long	1671105958              # 0x639b0da6
	.long	1733955601              # 0x675a1011
	.long	2031960084              # 0x791d4014
	.long	2111593891              # 0x7ddc5da3
	.long	1889500026              # 0x709f7b7a
	.long	1952343757              # 0x745e66cd
	.long	2552477408              # 0x9823b6e0
	.long	2632100695              # 0x9ce2ab57
	.long	2443283854              # 0x91a18d8e
	.long	2506133561              # 0x95609039
	.long	2334638140              # 0x8b27c03c
	.long	2414271883              # 0x8fe6dd8b
	.long	2191915858              # 0x82a5fb52
	.long	2254759653              # 0x8664e6e5
	.long	3190512472              # 0xbe2b5b58
	.long	3135915759              # 0xbaea46ef
	.long	3081330742              # 0xb7a96036
	.long	3009969537              # 0xb3687d81
	.long	2905550212              # 0xad2f2d84
	.long	2850959411              # 0xa9ee3033
	.long	2762807018              # 0xa4ad16ea
	.long	2691435357              # 0xa06c0b5d
	.long	3560074640              # 0xd4326d90
	.long	3505614887              # 0xd0f37027
	.long	3719321342              # 0xddb056fe
	.long	3648080713              # 0xd9714b49
	.long	3342211916              # 0xc7361b4c
	.long	3287746299              # 0xc3f706fb
	.long	3467911202              # 0xceb42022
	.long	3396681109              # 0xca753d95
	.long	4063920168              # 0xf23a8028
	.long	4143685023              # 0xf6fb9d9f
	.long	4223187782              # 0xfbb8bb46
	.long	4286162673              # 0xff79a6f1
	.long	3779000052              # 0xe13ef6f4
	.long	3858754371              # 0xe5ffeb43
	.long	3904687514              # 0xe8bccd9a
	.long	3967668269              # 0xec7dd02d
	.long	881225847               # 0x34867077
	.long	809987520               # 0x30476dc0
	.long	1023691545              # 0x3d044b19
	.long	969234094               # 0x39c556ae
	.long	662832811               # 0x278206ab
	.long	591600412               # 0x23431b1c
	.long	771767749               # 0x2e003dc5
	.long	717299826               # 0x2ac12072
	.long	311336399               # 0x128e9dcf
	.long	374308984               # 0x164f8078
	.long	453813921               # 0x1b0ca6a1
	.long	533576470               # 0x1fcdbb16
	.long	25881363                # 0x18aeb13
	.long	88864420                # 0x54bf6a4
	.long	134795389               # 0x808d07d
	.long	214552010               # 0xcc9cdca
	.long	2023205639              # 0x7897ab07
	.long	2086057648              # 0x7c56b6b0
	.long	1897238633              # 0x71159069
	.long	1976864222              # 0x75d48dde
	.long	1804852699              # 0x6b93dddb
	.long	1867694188              # 0x6f52c06c
	.long	1645340341              # 0x6211e6b5
	.long	1724971778              # 0x66d0fb02
	.long	1587496639              # 0x5e9f46bf
	.long	1516133128              # 0x5a5e5b08
	.long	1461550545              # 0x571d7dd1
	.long	1406951526              # 0x53dc6066
	.long	1302016099              # 0x4d9b3063
	.long	1230646740              # 0x495a2dd4
	.long	1142491917              # 0x44190b0d
	.long	1087903418              # 0x40d816ba
	.long	2896545431              # 0xaca5c697
	.long	2825181984              # 0xa864db20
	.long	2770861561              # 0xa527fdf9
	.long	2716262478              # 0xa1e6e04e
	.long	3215044683              # 0xbfa1b04b
	.long	3143675388              # 0xbb60adfc
	.long	3055782693              # 0xb6238b25
	.long	3001194130              # 0xb2e29692
	.long	2326604591              # 0x8aad2b2f
	.long	2389456536              # 0x8e6c3698
	.long	2200899649              # 0x832f1041
	.long	2280525302              # 0x87ee0df6
	.long	2578013683              # 0x99a95df3
	.long	2640855108              # 0x9d684044
	.long	2418763421              # 0x902b669d
	.long	2498394922              # 0x94ea7b2a
	.long	3769900519              # 0xe0b41de7
	.long	3832873040              # 0xe4750050
	.long	3912640137              # 0xe9362689
	.long	3992402750              # 0xedf73b3e
	.long	4088425275              # 0xf3b06b3b
	.long	4151408268              # 0xf771768c
	.long	4197601365              # 0xfa325055
	.long	4277358050              # 0xfef34de2
	.long	3334271071              # 0xc6bcf05f
	.long	3263032808              # 0xc27dede8
	.long	3476998961              # 0xcf3ecb31
	.long	3422541446              # 0xcbffd686
	.long	3585640067              # 0xd5b88683
	.long	3514407732              # 0xd1799b34
	.long	3694837229              # 0xdc3abded
	.long	3640369242              # 0xd8fba05a
	.long	1762451694              # 0x690ce0ee
	.long	1842216281              # 0x6dcdfd59
	.long	1619975040              # 0x608edb80
	.long	1682949687              # 0x644fc637
	.long	2047383090              # 0x7a089632
	.long	2127137669              # 0x7ec98b85
	.long	1938468188              # 0x738aad5c
	.long	2001449195              # 0x774bb0eb
	.long	1325665622              # 0x4f040d56
	.long	1271206113              # 0x4bc510e1
	.long	1183200824              # 0x46863638
	.long	1111960463              # 0x42472b8f
	.long	1543535498              # 0x5c007b8a
	.long	1489069629              # 0x58c1663d
	.long	1434599652              # 0x558240e4
	.long	1363369299              # 0x51435d53
	.long	622672798               # 0x251d3b9e
	.long	568075817               # 0x21dc2629
	.long	748617968               # 0x2c9f00f0
	.long	677256519               # 0x285e1d47
	.long	907627842               # 0x36194d42
	.long	853037301               # 0x32d850f5
	.long	1067152940              # 0x3f9b762c
	.long	995781531               # 0x3b5a6b9b
	.long	51762726                # 0x315d626
	.long	131386257               # 0x7d4cb91
	.long	177728840               # 0xa97ed48
	.long	240578815               # 0xe56f0ff
	.long	269590778               # 0x1011a0fa
	.long	349224269               # 0x14d0bd4d
	.long	429104020               # 0x19939b94
	.long	491947555               # 0x1d528623
	.long	4046411278              # 0xf12f560e
	.long	4126034873              # 0xf5ee4bb9
	.long	4172115296              # 0xf8ad6d60
	.long	4234965207              # 0xfc6c70d7
	.long	3794477266              # 0xe22b20d2
	.long	3874110821              # 0xe6ea3d65
	.long	3953728444              # 0xeba91bbc
	.long	4016571915              # 0xef68060b
	.long	3609705398              # 0xd727bbb6
	.long	3555108353              # 0xd3e6a601
	.long	3735388376              # 0xdea580d8
	.long	3664026991              # 0xda649d6f
	.long	3290680682              # 0xc423cd6a
	.long	3236090077              # 0xc0e2d0dd
	.long	3449943556              # 0xcda1f604
	.long	3378572211              # 0xc960ebb3
	.long	3174993278              # 0xbd3e8d7e
	.long	3120533705              # 0xb9ff90c9
	.long	3032266256              # 0xb4bcb610
	.long	2961025959              # 0xb07daba7
	.long	2923101090              # 0xae3afba2
	.long	2868635157              # 0xaafbe615
	.long	2813903052              # 0xa7b8c0cc
	.long	2742672763              # 0xa379dd7b
	.long	2604032198              # 0x9b3660c6
	.long	2683796849              # 0x9ff77d71
	.long	2461293480              # 0x92b45ba8
	.long	2524268063              # 0x9675461f
	.long	2284983834              # 0x8832161a
	.long	2364738477              # 0x8cf30bad
	.long	2175806836              # 0x81b02d74
	.long	2238787779              # 0x857130c3
	.long	1569362073              # 0x5d8a9099
	.long	1498123566              # 0x594b8d2e
	.long	1409854455              # 0x5408abf7
	.long	1355396672              # 0x50c9b640
	.long	1317987909              # 0x4e8ee645
	.long	1246755826              # 0x4a4ffbf2
	.long	1192025387              # 0x470cdd2b
	.long	1137557660              # 0x43cdc09c
	.long	2072149281              # 0x7b827d21
	.long	2135122070              # 0x7f436096
	.long	1912620623              # 0x7200464f
	.long	1992383480              # 0x76c15bf8
	.long	1753615357              # 0x68860bfd
	.long	1816598090              # 0x6c47164a
	.long	1627664531              # 0x61043093
	.long	1707420964              # 0x65c52d24
	.long	295390185               # 0x119b4be9
	.long	358241886               # 0x155a565e
	.long	404320391               # 0x18197087
	.long	483945776               # 0x1cd86d30
	.long	43990325                # 0x29f3d35
	.long	106832002               # 0x65e2082
	.long	186451547               # 0xb1d065b
	.long	266083308               # 0xfdc1bec
	.long	932423249               # 0x3793a651
	.long	861060070               # 0x3352bbe6
	.long	1041341759              # 0x3e119d3f
	.long	986742920               # 0x3ad08088
	.long	613929101               # 0x2497d08d
	.long	542559546               # 0x2056cd3a
	.long	756411363               # 0x2d15ebe3
	.long	701822548               # 0x29d4f654
	.long	3316196985              # 0xc5a92679
	.long	3244833742              # 0xc1683bce
	.long	3425377559              # 0xcc2b1d17
	.long	3370778784              # 0xc8ea00a0
	.long	3601682597              # 0xd6ad50a5
	.long	3530312978              # 0xd26c4d12
	.long	3744426955              # 0xdf2f6bcb
	.long	3689838204              # 0xdbee767c
	.long	3819031489              # 0xe3a1cbc1
	.long	3881883254              # 0xe760d676
	.long	3928223919              # 0xea23f0af
	.long	4007849240              # 0xeee2ed18
	.long	4037393693              # 0xf0a5bd1d
	.long	4100235434              # 0xf464a0aa
	.long	4180117107              # 0xf9278673
	.long	4259748804              # 0xfde69bc4
	.long	2310601993              # 0x89b8fd09
	.long	2373574846              # 0x8d79e0be
	.long	2151335527              # 0x803ac667
	.long	2231098320              # 0x84fbdbd0
	.long	2596047829              # 0x9abc8bd5
	.long	2659030626              # 0x9e7d9662
	.long	2470359227              # 0x933eb0bb
	.long	2550115596              # 0x97ffad0c
	.long	2947551409              # 0xafb010b1
	.long	2876312838              # 0xab710d06
	.long	2788305887              # 0xa6322bdf
	.long	2733848168              # 0xa2f33668
	.long	3165939309              # 0xbcb4666d
	.long	3094707162              # 0xb8757bda
	.long	3040238851              # 0xb5365d03
	.long	2985771188              # 0xb1f740b4
	.size	BZ2_crc32Table, 1024

	.type	BZ2_rNums,@object       # @BZ2_rNums
	.globl	BZ2_rNums
	.p2align	4
BZ2_rNums:
	.long	619                     # 0x26b
	.long	720                     # 0x2d0
	.long	127                     # 0x7f
	.long	481                     # 0x1e1
	.long	931                     # 0x3a3
	.long	816                     # 0x330
	.long	813                     # 0x32d
	.long	233                     # 0xe9
	.long	566                     # 0x236
	.long	247                     # 0xf7
	.long	985                     # 0x3d9
	.long	724                     # 0x2d4
	.long	205                     # 0xcd
	.long	454                     # 0x1c6
	.long	863                     # 0x35f
	.long	491                     # 0x1eb
	.long	741                     # 0x2e5
	.long	242                     # 0xf2
	.long	949                     # 0x3b5
	.long	214                     # 0xd6
	.long	733                     # 0x2dd
	.long	859                     # 0x35b
	.long	335                     # 0x14f
	.long	708                     # 0x2c4
	.long	621                     # 0x26d
	.long	574                     # 0x23e
	.long	73                      # 0x49
	.long	654                     # 0x28e
	.long	730                     # 0x2da
	.long	472                     # 0x1d8
	.long	419                     # 0x1a3
	.long	436                     # 0x1b4
	.long	278                     # 0x116
	.long	496                     # 0x1f0
	.long	867                     # 0x363
	.long	210                     # 0xd2
	.long	399                     # 0x18f
	.long	680                     # 0x2a8
	.long	480                     # 0x1e0
	.long	51                      # 0x33
	.long	878                     # 0x36e
	.long	465                     # 0x1d1
	.long	811                     # 0x32b
	.long	169                     # 0xa9
	.long	869                     # 0x365
	.long	675                     # 0x2a3
	.long	611                     # 0x263
	.long	697                     # 0x2b9
	.long	867                     # 0x363
	.long	561                     # 0x231
	.long	862                     # 0x35e
	.long	687                     # 0x2af
	.long	507                     # 0x1fb
	.long	283                     # 0x11b
	.long	482                     # 0x1e2
	.long	129                     # 0x81
	.long	807                     # 0x327
	.long	591                     # 0x24f
	.long	733                     # 0x2dd
	.long	623                     # 0x26f
	.long	150                     # 0x96
	.long	238                     # 0xee
	.long	59                      # 0x3b
	.long	379                     # 0x17b
	.long	684                     # 0x2ac
	.long	877                     # 0x36d
	.long	625                     # 0x271
	.long	169                     # 0xa9
	.long	643                     # 0x283
	.long	105                     # 0x69
	.long	170                     # 0xaa
	.long	607                     # 0x25f
	.long	520                     # 0x208
	.long	932                     # 0x3a4
	.long	727                     # 0x2d7
	.long	476                     # 0x1dc
	.long	693                     # 0x2b5
	.long	425                     # 0x1a9
	.long	174                     # 0xae
	.long	647                     # 0x287
	.long	73                      # 0x49
	.long	122                     # 0x7a
	.long	335                     # 0x14f
	.long	530                     # 0x212
	.long	442                     # 0x1ba
	.long	853                     # 0x355
	.long	695                     # 0x2b7
	.long	249                     # 0xf9
	.long	445                     # 0x1bd
	.long	515                     # 0x203
	.long	909                     # 0x38d
	.long	545                     # 0x221
	.long	703                     # 0x2bf
	.long	919                     # 0x397
	.long	874                     # 0x36a
	.long	474                     # 0x1da
	.long	882                     # 0x372
	.long	500                     # 0x1f4
	.long	594                     # 0x252
	.long	612                     # 0x264
	.long	641                     # 0x281
	.long	801                     # 0x321
	.long	220                     # 0xdc
	.long	162                     # 0xa2
	.long	819                     # 0x333
	.long	984                     # 0x3d8
	.long	589                     # 0x24d
	.long	513                     # 0x201
	.long	495                     # 0x1ef
	.long	799                     # 0x31f
	.long	161                     # 0xa1
	.long	604                     # 0x25c
	.long	958                     # 0x3be
	.long	533                     # 0x215
	.long	221                     # 0xdd
	.long	400                     # 0x190
	.long	386                     # 0x182
	.long	867                     # 0x363
	.long	600                     # 0x258
	.long	782                     # 0x30e
	.long	382                     # 0x17e
	.long	596                     # 0x254
	.long	414                     # 0x19e
	.long	171                     # 0xab
	.long	516                     # 0x204
	.long	375                     # 0x177
	.long	682                     # 0x2aa
	.long	485                     # 0x1e5
	.long	911                     # 0x38f
	.long	276                     # 0x114
	.long	98                      # 0x62
	.long	553                     # 0x229
	.long	163                     # 0xa3
	.long	354                     # 0x162
	.long	666                     # 0x29a
	.long	933                     # 0x3a5
	.long	424                     # 0x1a8
	.long	341                     # 0x155
	.long	533                     # 0x215
	.long	870                     # 0x366
	.long	227                     # 0xe3
	.long	730                     # 0x2da
	.long	475                     # 0x1db
	.long	186                     # 0xba
	.long	263                     # 0x107
	.long	647                     # 0x287
	.long	537                     # 0x219
	.long	686                     # 0x2ae
	.long	600                     # 0x258
	.long	224                     # 0xe0
	.long	469                     # 0x1d5
	.long	68                      # 0x44
	.long	770                     # 0x302
	.long	919                     # 0x397
	.long	190                     # 0xbe
	.long	373                     # 0x175
	.long	294                     # 0x126
	.long	822                     # 0x336
	.long	808                     # 0x328
	.long	206                     # 0xce
	.long	184                     # 0xb8
	.long	943                     # 0x3af
	.long	795                     # 0x31b
	.long	384                     # 0x180
	.long	383                     # 0x17f
	.long	461                     # 0x1cd
	.long	404                     # 0x194
	.long	758                     # 0x2f6
	.long	839                     # 0x347
	.long	887                     # 0x377
	.long	715                     # 0x2cb
	.long	67                      # 0x43
	.long	618                     # 0x26a
	.long	276                     # 0x114
	.long	204                     # 0xcc
	.long	918                     # 0x396
	.long	873                     # 0x369
	.long	777                     # 0x309
	.long	604                     # 0x25c
	.long	560                     # 0x230
	.long	951                     # 0x3b7
	.long	160                     # 0xa0
	.long	578                     # 0x242
	.long	722                     # 0x2d2
	.long	79                      # 0x4f
	.long	804                     # 0x324
	.long	96                      # 0x60
	.long	409                     # 0x199
	.long	713                     # 0x2c9
	.long	940                     # 0x3ac
	.long	652                     # 0x28c
	.long	934                     # 0x3a6
	.long	970                     # 0x3ca
	.long	447                     # 0x1bf
	.long	318                     # 0x13e
	.long	353                     # 0x161
	.long	859                     # 0x35b
	.long	672                     # 0x2a0
	.long	112                     # 0x70
	.long	785                     # 0x311
	.long	645                     # 0x285
	.long	863                     # 0x35f
	.long	803                     # 0x323
	.long	350                     # 0x15e
	.long	139                     # 0x8b
	.long	93                      # 0x5d
	.long	354                     # 0x162
	.long	99                      # 0x63
	.long	820                     # 0x334
	.long	908                     # 0x38c
	.long	609                     # 0x261
	.long	772                     # 0x304
	.long	154                     # 0x9a
	.long	274                     # 0x112
	.long	580                     # 0x244
	.long	184                     # 0xb8
	.long	79                      # 0x4f
	.long	626                     # 0x272
	.long	630                     # 0x276
	.long	742                     # 0x2e6
	.long	653                     # 0x28d
	.long	282                     # 0x11a
	.long	762                     # 0x2fa
	.long	623                     # 0x26f
	.long	680                     # 0x2a8
	.long	81                      # 0x51
	.long	927                     # 0x39f
	.long	626                     # 0x272
	.long	789                     # 0x315
	.long	125                     # 0x7d
	.long	411                     # 0x19b
	.long	521                     # 0x209
	.long	938                     # 0x3aa
	.long	300                     # 0x12c
	.long	821                     # 0x335
	.long	78                      # 0x4e
	.long	343                     # 0x157
	.long	175                     # 0xaf
	.long	128                     # 0x80
	.long	250                     # 0xfa
	.long	170                     # 0xaa
	.long	774                     # 0x306
	.long	972                     # 0x3cc
	.long	275                     # 0x113
	.long	999                     # 0x3e7
	.long	639                     # 0x27f
	.long	495                     # 0x1ef
	.long	78                      # 0x4e
	.long	352                     # 0x160
	.long	126                     # 0x7e
	.long	857                     # 0x359
	.long	956                     # 0x3bc
	.long	358                     # 0x166
	.long	619                     # 0x26b
	.long	580                     # 0x244
	.long	124                     # 0x7c
	.long	737                     # 0x2e1
	.long	594                     # 0x252
	.long	701                     # 0x2bd
	.long	612                     # 0x264
	.long	669                     # 0x29d
	.long	112                     # 0x70
	.long	134                     # 0x86
	.long	694                     # 0x2b6
	.long	363                     # 0x16b
	.long	992                     # 0x3e0
	.long	809                     # 0x329
	.long	743                     # 0x2e7
	.long	168                     # 0xa8
	.long	974                     # 0x3ce
	.long	944                     # 0x3b0
	.long	375                     # 0x177
	.long	748                     # 0x2ec
	.long	52                      # 0x34
	.long	600                     # 0x258
	.long	747                     # 0x2eb
	.long	642                     # 0x282
	.long	182                     # 0xb6
	.long	862                     # 0x35e
	.long	81                      # 0x51
	.long	344                     # 0x158
	.long	805                     # 0x325
	.long	988                     # 0x3dc
	.long	739                     # 0x2e3
	.long	511                     # 0x1ff
	.long	655                     # 0x28f
	.long	814                     # 0x32e
	.long	334                     # 0x14e
	.long	249                     # 0xf9
	.long	515                     # 0x203
	.long	897                     # 0x381
	.long	955                     # 0x3bb
	.long	664                     # 0x298
	.long	981                     # 0x3d5
	.long	649                     # 0x289
	.long	113                     # 0x71
	.long	974                     # 0x3ce
	.long	459                     # 0x1cb
	.long	893                     # 0x37d
	.long	228                     # 0xe4
	.long	433                     # 0x1b1
	.long	837                     # 0x345
	.long	553                     # 0x229
	.long	268                     # 0x10c
	.long	926                     # 0x39e
	.long	240                     # 0xf0
	.long	102                     # 0x66
	.long	654                     # 0x28e
	.long	459                     # 0x1cb
	.long	51                      # 0x33
	.long	686                     # 0x2ae
	.long	754                     # 0x2f2
	.long	806                     # 0x326
	.long	760                     # 0x2f8
	.long	493                     # 0x1ed
	.long	403                     # 0x193
	.long	415                     # 0x19f
	.long	394                     # 0x18a
	.long	687                     # 0x2af
	.long	700                     # 0x2bc
	.long	946                     # 0x3b2
	.long	670                     # 0x29e
	.long	656                     # 0x290
	.long	610                     # 0x262
	.long	738                     # 0x2e2
	.long	392                     # 0x188
	.long	760                     # 0x2f8
	.long	799                     # 0x31f
	.long	887                     # 0x377
	.long	653                     # 0x28d
	.long	978                     # 0x3d2
	.long	321                     # 0x141
	.long	576                     # 0x240
	.long	617                     # 0x269
	.long	626                     # 0x272
	.long	502                     # 0x1f6
	.long	894                     # 0x37e
	.long	679                     # 0x2a7
	.long	243                     # 0xf3
	.long	440                     # 0x1b8
	.long	680                     # 0x2a8
	.long	879                     # 0x36f
	.long	194                     # 0xc2
	.long	572                     # 0x23c
	.long	640                     # 0x280
	.long	724                     # 0x2d4
	.long	926                     # 0x39e
	.long	56                      # 0x38
	.long	204                     # 0xcc
	.long	700                     # 0x2bc
	.long	707                     # 0x2c3
	.long	151                     # 0x97
	.long	457                     # 0x1c9
	.long	449                     # 0x1c1
	.long	797                     # 0x31d
	.long	195                     # 0xc3
	.long	791                     # 0x317
	.long	558                     # 0x22e
	.long	945                     # 0x3b1
	.long	679                     # 0x2a7
	.long	297                     # 0x129
	.long	59                      # 0x3b
	.long	87                      # 0x57
	.long	824                     # 0x338
	.long	713                     # 0x2c9
	.long	663                     # 0x297
	.long	412                     # 0x19c
	.long	693                     # 0x2b5
	.long	342                     # 0x156
	.long	606                     # 0x25e
	.long	134                     # 0x86
	.long	108                     # 0x6c
	.long	571                     # 0x23b
	.long	364                     # 0x16c
	.long	631                     # 0x277
	.long	212                     # 0xd4
	.long	174                     # 0xae
	.long	643                     # 0x283
	.long	304                     # 0x130
	.long	329                     # 0x149
	.long	343                     # 0x157
	.long	97                      # 0x61
	.long	430                     # 0x1ae
	.long	751                     # 0x2ef
	.long	497                     # 0x1f1
	.long	314                     # 0x13a
	.long	983                     # 0x3d7
	.long	374                     # 0x176
	.long	822                     # 0x336
	.long	928                     # 0x3a0
	.long	140                     # 0x8c
	.long	206                     # 0xce
	.long	73                      # 0x49
	.long	263                     # 0x107
	.long	980                     # 0x3d4
	.long	736                     # 0x2e0
	.long	876                     # 0x36c
	.long	478                     # 0x1de
	.long	430                     # 0x1ae
	.long	305                     # 0x131
	.long	170                     # 0xaa
	.long	514                     # 0x202
	.long	364                     # 0x16c
	.long	692                     # 0x2b4
	.long	829                     # 0x33d
	.long	82                      # 0x52
	.long	855                     # 0x357
	.long	953                     # 0x3b9
	.long	676                     # 0x2a4
	.long	246                     # 0xf6
	.long	369                     # 0x171
	.long	970                     # 0x3ca
	.long	294                     # 0x126
	.long	750                     # 0x2ee
	.long	807                     # 0x327
	.long	827                     # 0x33b
	.long	150                     # 0x96
	.long	790                     # 0x316
	.long	288                     # 0x120
	.long	923                     # 0x39b
	.long	804                     # 0x324
	.long	378                     # 0x17a
	.long	215                     # 0xd7
	.long	828                     # 0x33c
	.long	592                     # 0x250
	.long	281                     # 0x119
	.long	565                     # 0x235
	.long	555                     # 0x22b
	.long	710                     # 0x2c6
	.long	82                      # 0x52
	.long	896                     # 0x380
	.long	831                     # 0x33f
	.long	547                     # 0x223
	.long	261                     # 0x105
	.long	524                     # 0x20c
	.long	462                     # 0x1ce
	.long	293                     # 0x125
	.long	465                     # 0x1d1
	.long	502                     # 0x1f6
	.long	56                      # 0x38
	.long	661                     # 0x295
	.long	821                     # 0x335
	.long	976                     # 0x3d0
	.long	991                     # 0x3df
	.long	658                     # 0x292
	.long	869                     # 0x365
	.long	905                     # 0x389
	.long	758                     # 0x2f6
	.long	745                     # 0x2e9
	.long	193                     # 0xc1
	.long	768                     # 0x300
	.long	550                     # 0x226
	.long	608                     # 0x260
	.long	933                     # 0x3a5
	.long	378                     # 0x17a
	.long	286                     # 0x11e
	.long	215                     # 0xd7
	.long	979                     # 0x3d3
	.long	792                     # 0x318
	.long	961                     # 0x3c1
	.long	61                      # 0x3d
	.long	688                     # 0x2b0
	.long	793                     # 0x319
	.long	644                     # 0x284
	.long	986                     # 0x3da
	.long	403                     # 0x193
	.long	106                     # 0x6a
	.long	366                     # 0x16e
	.long	905                     # 0x389
	.long	644                     # 0x284
	.long	372                     # 0x174
	.long	567                     # 0x237
	.long	466                     # 0x1d2
	.long	434                     # 0x1b2
	.long	645                     # 0x285
	.long	210                     # 0xd2
	.long	389                     # 0x185
	.long	550                     # 0x226
	.long	919                     # 0x397
	.long	135                     # 0x87
	.long	780                     # 0x30c
	.long	773                     # 0x305
	.long	635                     # 0x27b
	.long	389                     # 0x185
	.long	707                     # 0x2c3
	.long	100                     # 0x64
	.long	626                     # 0x272
	.long	958                     # 0x3be
	.long	165                     # 0xa5
	.long	504                     # 0x1f8
	.long	920                     # 0x398
	.long	176                     # 0xb0
	.long	193                     # 0xc1
	.long	713                     # 0x2c9
	.long	857                     # 0x359
	.long	265                     # 0x109
	.long	203                     # 0xcb
	.long	50                      # 0x32
	.long	668                     # 0x29c
	.long	108                     # 0x6c
	.long	645                     # 0x285
	.long	990                     # 0x3de
	.long	626                     # 0x272
	.long	197                     # 0xc5
	.long	510                     # 0x1fe
	.long	357                     # 0x165
	.long	358                     # 0x166
	.long	850                     # 0x352
	.long	858                     # 0x35a
	.long	364                     # 0x16c
	.long	936                     # 0x3a8
	.long	638                     # 0x27e
	.size	BZ2_rNums, 2048

	.type	.L.str.2,@object        # @.str.2
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.2:
	.asciz	"    block %d: crc = 0x%8x, combined CRC = 0x%8x, size = %d\n"
	.size	.L.str.2, 60

	.type	.L.str.3,@object        # @.str.3
.L.str.3:
	.asciz	"    final combined CRC = 0x%x\n   "
	.size	.L.str.3, 34

	.type	.L.str.4,@object        # @.str.4
.L.str.4:
	.asciz	"\n    [%d: huff+mtf "
	.size	.L.str.4, 20

	.type	.L.str.5,@object        # @.str.5
.L.str.5:
	.asciz	"rt+rld"
	.size	.L.str.5, 7

	.type	.L.str.6,@object        # @.str.6
.L.str.6:
	.asciz	"\n\nbzip2/libbzip2: internal error number %d.\nThis is a bug in bzip2/libbzip2, %s.\nPlease report it to me at: jseward@acm.org.  If this happened\nwhen you were using some program which uses libbzip2 as a\ncomponent, you should also report this bug to the author(s)\nof that program.  Please make an effort to report this bug;\ntimely and accurate bug reports eventually lead to higher\nquality software.  Thanks.  Julian Seward, 30 December 2001.\n\n"
	.size	.L.str.6, 442

	.type	.L.str.7,@object        # @.str.7
.L.str.7:
	.asciz	"\n*** A special note about internal error number 1007 ***\n\nExperience suggests that a common cause of i.e. 1007\nis unreliable memory or other hardware.  The 1007 assertion\njust happens to cross-check the results of huge numbers of\nmemory reads/writes, and so acts (unintendedly) as a stress\ntest of your memory system.\n\nI suggest the following: try compressing the file again,\npossibly monitoring progress in detail with the -vv flag.\n\n* If the error cannot be reproduced, and/or happens at different\n  points in compression, you may have a flaky memory system.\n  Try a memory-test program.  I have used Memtest86\n  (www.memtest86.com).  At the time of writing it is free (GPLd).\n  Memtest86 tests memory much more thorougly than your BIOSs\n  power-on test, and may find failures that the BIOS doesn't.\n\n* If the error can be repeatably reproduced, this is a bug in\n  bzip2, and I would very much like to hear about it.  Please\n  let me know, and, ideally, save a copy of the file causing the\n  problem -- without which I will be unable to investigate it.\n\n"
	.size	.L.str.7, 1057

	.type	.L.str.8,@object        # @.str.8
.L.str.8:
	.asciz	" {0x%x, 0x%x}"
	.size	.L.str.8, 14

	.type	.L.str.9,@object        # @.str.9
.L.str.9:
	.asciz	"]"
	.size	.L.str.9, 2

	.type	.L.str.10,@object       # @.str.10
.L.str.10:
	.asciz	"\n    combined CRCs: stored = 0x%x, computed = 0x%x"
	.size	.L.str.10, 51

	.type	.L.str.11,@object       # @.str.11
.L.str.11:
	.asciz	"1.0.2, 30-Dec-2001"
	.size	.L.str.11, 19

	.type	bzerrorstrings,@object  # @bzerrorstrings
	.data
	.p2align	4
bzerrorstrings:
	.quad	.L.str.67
	.quad	.L.str.68
	.quad	.L.str.69
	.quad	.L.str.70
	.quad	.L.str.71
	.quad	.L.str.72
	.quad	.L.str.73
	.quad	.L.str.74
	.quad	.L.str.75
	.quad	.L.str.76
	.quad	.L.str.77
	.quad	.L.str.77
	.quad	.L.str.77
	.quad	.L.str.77
	.quad	.L.str.77
	.quad	.L.str.77
	.size	bzerrorstrings, 128

	.type	.L.str.12,@object       # @.str.12
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.12:
	.asciz	".bz2"
	.size	.L.str.12, 5

	.type	.L.str.13,@object       # @.str.13
.L.str.13:
	.asciz	".bz"
	.size	.L.str.13, 4

	.type	.L.str.14,@object       # @.str.14
.L.str.14:
	.asciz	".tbz2"
	.size	.L.str.14, 6

	.type	.L.str.15,@object       # @.str.15
.L.str.15:
	.asciz	".tbz"
	.size	.L.str.15, 5

	.type	zSuffix,@object         # @zSuffix
	.data
	.globl	zSuffix
	.p2align	4
zSuffix:
	.quad	.L.str.12
	.quad	.L.str.13
	.quad	.L.str.14
	.quad	.L.str.15
	.size	zSuffix, 32

	.type	.L.str.16,@object       # @.str.16
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.16:
	.zero	1
	.size	.L.str.16, 1

	.type	.L.str.17,@object       # @.str.17
.L.str.17:
	.asciz	".tar"
	.size	.L.str.17, 5

	.type	unzSuffix,@object       # @unzSuffix
	.data
	.globl	unzSuffix
	.p2align	4
unzSuffix:
	.quad	.L.str.16
	.quad	.L.str.16
	.quad	.L.str.17
	.quad	.L.str.17
	.size	unzSuffix, 32

	.type	outputHandleJustInCase,@object # @outputHandleJustInCase
	.comm	outputHandleJustInCase,8,8
	.type	smallMode,@object       # @smallMode
	.comm	smallMode,1,1
	.type	keepInputFiles,@object  # @keepInputFiles
	.comm	keepInputFiles,1,1
	.type	forceOverwrite,@object  # @forceOverwrite
	.comm	forceOverwrite,1,1
	.type	noisy,@object           # @noisy
	.comm	noisy,1,1
	.type	verbosity,@object       # @verbosity
	.comm	verbosity,4,4
	.type	blockSize100k,@object   # @blockSize100k
	.comm	blockSize100k,4,4
	.type	testFailsExist,@object  # @testFailsExist
	.comm	testFailsExist,1,1
	.type	unzFailsExist,@object   # @unzFailsExist
	.comm	unzFailsExist,1,1
	.type	numFileNames,@object    # @numFileNames
	.comm	numFileNames,4,4
	.type	numFilesProcessed,@object # @numFilesProcessed
	.comm	numFilesProcessed,4,4
	.type	workFactor,@object      # @workFactor
	.comm	workFactor,4,4
	.type	deleteOutputOnInterrupt,@object # @deleteOutputOnInterrupt
	.comm	deleteOutputOnInterrupt,1,1
	.type	exitValue,@object       # @exitValue
	.comm	exitValue,4,4
	.type	inName,@object          # @inName
	.comm	inName,1034,16
	.type	.L.str.18,@object       # @.str.18
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.18:
	.asciz	"(none)"
	.size	.L.str.18, 7

	.type	outName,@object         # @outName
	.comm	outName,1034,16
	.type	progNameReally,@object  # @progNameReally
	.comm	progNameReally,1034,16
	.type	progName,@object        # @progName
	.comm	progName,8,8
	.type	.L.str.19,@object       # @.str.19
.L.str.19:
	.asciz	"BZIP2"
	.size	.L.str.19, 6

	.type	.L.str.20,@object       # @.str.20
.L.str.20:
	.asciz	"BZIP"
	.size	.L.str.20, 5

	.type	longestFileName,@object # @longestFileName
	.comm	longestFileName,4,4
	.type	.L.str.21,@object       # @.str.21
.L.str.21:
	.asciz	"--"
	.size	.L.str.21, 3

	.type	srcMode,@object         # @srcMode
	.comm	srcMode,4,4
	.type	opMode,@object          # @opMode
	.comm	opMode,4,4
	.type	.L.str.22,@object       # @.str.22
.L.str.22:
	.asciz	"unzip"
	.size	.L.str.22, 6

	.type	.L.str.23,@object       # @.str.23
.L.str.23:
	.asciz	"UNZIP"
	.size	.L.str.23, 6

	.type	.L.str.24,@object       # @.str.24
.L.str.24:
	.asciz	"z2cat"
	.size	.L.str.24, 6

	.type	.L.str.25,@object       # @.str.25
.L.str.25:
	.asciz	"Z2CAT"
	.size	.L.str.25, 6

	.type	.L.str.26,@object       # @.str.26
.L.str.26:
	.asciz	"zcat"
	.size	.L.str.26, 5

	.type	.L.str.27,@object       # @.str.27
.L.str.27:
	.asciz	"ZCAT"
	.size	.L.str.27, 5

	.type	.L.str.28,@object       # @.str.28
.L.str.28:
	.asciz	"%s: Bad flag `%s'\n"
	.size	.L.str.28, 19

	.type	.L.str.29,@object       # @.str.29
.L.str.29:
	.asciz	"--stdout"
	.size	.L.str.29, 9

	.type	.L.str.30,@object       # @.str.30
.L.str.30:
	.asciz	"--decompress"
	.size	.L.str.30, 13

	.type	.L.str.31,@object       # @.str.31
.L.str.31:
	.asciz	"--compress"
	.size	.L.str.31, 11

	.type	.L.str.32,@object       # @.str.32
.L.str.32:
	.asciz	"--force"
	.size	.L.str.32, 8

	.type	.L.str.33,@object       # @.str.33
.L.str.33:
	.asciz	"--test"
	.size	.L.str.33, 7

	.type	.L.str.34,@object       # @.str.34
.L.str.34:
	.asciz	"--keep"
	.size	.L.str.34, 7

	.type	.L.str.35,@object       # @.str.35
.L.str.35:
	.asciz	"--small"
	.size	.L.str.35, 8

	.type	.L.str.36,@object       # @.str.36
.L.str.36:
	.asciz	"--quiet"
	.size	.L.str.36, 8

	.type	.L.str.37,@object       # @.str.37
.L.str.37:
	.asciz	"--version"
	.size	.L.str.37, 10

	.type	.L.str.38,@object       # @.str.38
.L.str.38:
	.asciz	"--license"
	.size	.L.str.38, 10

	.type	.L.str.39,@object       # @.str.39
.L.str.39:
	.asciz	"--exponential"
	.size	.L.str.39, 14

	.type	.L.str.40,@object       # @.str.40
.L.str.40:
	.asciz	"--repetitive-best"
	.size	.L.str.40, 18

	.type	.L.str.41,@object       # @.str.41
.L.str.41:
	.asciz	"--repetitive-fast"
	.size	.L.str.41, 18

	.type	.L.str.42,@object       # @.str.42
.L.str.42:
	.asciz	"--fast"
	.size	.L.str.42, 7

	.type	.L.str.43,@object       # @.str.43
.L.str.43:
	.asciz	"--best"
	.size	.L.str.43, 7

	.type	.L.str.44,@object       # @.str.44
.L.str.44:
	.asciz	"--verbose"
	.size	.L.str.44, 10

	.type	.L.str.45,@object       # @.str.45
.L.str.45:
	.asciz	"--help"
	.size	.L.str.45, 7

	.type	.L.str.46,@object       # @.str.46
.L.str.46:
	.asciz	"%s: -c and -t cannot be used together.\n"
	.size	.L.str.46, 40

	.type	.L.str.47,@object       # @.str.47
.L.str.47:
	.asciz	"\nYou can use the `bzip2recover' program to attempt to recover\ndata from undamaged sections of corrupted files.\n\n"
	.size	.L.str.47, 113

	.type	tmpName,@object         # @tmpName
	.comm	tmpName,1034,16
	.type	.L.str.48,@object       # @.str.48
.L.str.48:
	.asciz	"        bucket sorting ...\n"
	.size	.L.str.48, 28

	.type	.L.str.49,@object       # @.str.49
.L.str.49:
	.asciz	"        depth %6d has "
	.size	.L.str.49, 23

	.type	.L.str.50,@object       # @.str.50
.L.str.50:
	.asciz	"%6d unresolved strings\n"
	.size	.L.str.50, 24

	.type	.L.str.51,@object       # @.str.51
.L.str.51:
	.asciz	"        reconstructing block ...\n"
	.size	.L.str.51, 34

	.type	.L.str.52,@object       # @.str.52
.L.str.52:
	.asciz	"        main sort initialise ...\n"
	.size	.L.str.52, 34

	.type	.L.str.53,@object       # @.str.53
.L.str.53:
	.asciz	"        qsort [0x%x, 0x%x]   done %d   this %d\n"
	.size	.L.str.53, 48

	.type	.L.str.54,@object       # @.str.54
.L.str.54:
	.asciz	"        %d pointers, %d sorted, %d scanned\n"
	.size	.L.str.54, 44

	.type	incs,@object            # @incs
	.data
	.p2align	4
incs:
	.long	1                       # 0x1
	.long	4                       # 0x4
	.long	13                      # 0xd
	.long	40                      # 0x28
	.long	121                     # 0x79
	.long	364                     # 0x16c
	.long	1093                    # 0x445
	.long	3280                    # 0xcd0
	.long	9841                    # 0x2671
	.long	29524                   # 0x7354
	.long	88573                   # 0x159fd
	.long	265720                  # 0x40df8
	.long	797161                  # 0xc29e9
	.long	2391484                 # 0x247dbc
	.size	incs, 56

	.type	.L.str.55,@object       # @.str.55
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.55:
	.asciz	"      %d in block, %d after MTF & 1-2 coding, %d+2 syms in use\n"
	.size	.L.str.55, 64

	.type	.L.str.56,@object       # @.str.56
.L.str.56:
	.asciz	"      initial group %d, [%d .. %d], has %d syms (%4.1f%%)\n"
	.size	.L.str.56, 59

	.type	.L.str.57,@object       # @.str.57
.L.str.57:
	.asciz	"      pass %d: size is %d, grp uses are "
	.size	.L.str.57, 41

	.type	.L.str.58,@object       # @.str.58
.L.str.58:
	.asciz	"%d "
	.size	.L.str.58, 4

	.type	.L.str.59,@object       # @.str.59
.L.str.59:
	.asciz	"\n"
	.size	.L.str.59, 2

	.type	.L.str.60,@object       # @.str.60
.L.str.60:
	.asciz	"      bytes: mapping %d, "
	.size	.L.str.60, 26

	.type	.L.str.61,@object       # @.str.61
.L.str.61:
	.asciz	"selectors %d, "
	.size	.L.str.61, 15

	.type	.L.str.62,@object       # @.str.62
.L.str.62:
	.asciz	"code lengths %d, "
	.size	.L.str.62, 18

	.type	.L.str.63,@object       # @.str.63
.L.str.63:
	.asciz	"codes %d\n"
	.size	.L.str.63, 10

	.type	.L.str.64,@object       # @.str.64
.L.str.64:
	.asciz	"w"
	.size	.L.str.64, 2

	.type	.L.str.65,@object       # @.str.65
.L.str.65:
	.asciz	"r"
	.size	.L.str.65, 2

	.type	.L.str.66,@object       # @.str.66
.L.str.66:
	.asciz	"b"
	.size	.L.str.66, 2

	.type	.L.str.67,@object       # @.str.67
.L.str.67:
	.asciz	"OK"
	.size	.L.str.67, 3

	.type	.L.str.68,@object       # @.str.68
.L.str.68:
	.asciz	"SEQUENCE_ERROR"
	.size	.L.str.68, 15

	.type	.L.str.69,@object       # @.str.69
.L.str.69:
	.asciz	"PARAM_ERROR"
	.size	.L.str.69, 12

	.type	.L.str.70,@object       # @.str.70
.L.str.70:
	.asciz	"MEM_ERROR"
	.size	.L.str.70, 10

	.type	.L.str.71,@object       # @.str.71
.L.str.71:
	.asciz	"DATA_ERROR"
	.size	.L.str.71, 11

	.type	.L.str.72,@object       # @.str.72
.L.str.72:
	.asciz	"DATA_ERROR_MAGIC"
	.size	.L.str.72, 17

	.type	.L.str.73,@object       # @.str.73
.L.str.73:
	.asciz	"IO_ERROR"
	.size	.L.str.73, 9

	.type	.L.str.74,@object       # @.str.74
.L.str.74:
	.asciz	"UNEXPECTED_EOF"
	.size	.L.str.74, 15

	.type	.L.str.75,@object       # @.str.75
.L.str.75:
	.asciz	"OUTBUFF_FULL"
	.size	.L.str.75, 13

	.type	.L.str.76,@object       # @.str.76
.L.str.76:
	.asciz	"CONFIG_ERROR"
	.size	.L.str.76, 13

	.type	.L.str.77,@object       # @.str.77
.L.str.77:
	.asciz	"???"
	.size	.L.str.77, 4

	.type	.L.str.78,@object       # @.str.78
.L.str.78:
	.asciz	"\n%s: Caught a SIGSEGV or SIGBUS whilst compressing.\n\n   Possible causes are (most likely first):\n   (1) This computer has unreliable memory or cache hardware\n       (a surprisingly common problem; try a different machine.)\n   (2) A bug in the compiler used to create this executable\n       (unlikely, if you didn't compile bzip2 yourself.)\n   (3) A real bug in bzip2 -- I hope this should never be the case.\n   The user's manual, Section 4.3, has more info on (1) and (2).\n   \n   If you suspect this is a bug in bzip2, or are unsure about (1)\n   or (2), feel free to report it to me at: jseward@acm.org.\n   Section 4.3 of the user's manual describes the info a useful\n   bug report should have.  If the manual is available on your\n   system, please try and read it before mailing me.  If you don't\n   have the manual or can't be bothered to read it, mail me anyway.\n\n"
	.size	.L.str.78, 868

	.type	.L.str.79,@object       # @.str.79
.L.str.79:
	.asciz	"\n%s: Caught a SIGSEGV or SIGBUS whilst decompressing.\n\n   Possible causes are (most likely first):\n   (1) The compressed data is corrupted, and bzip2's usual checks\n       failed to detect this.  Try bzip2 -tvv my_file.bz2.\n   (2) This computer has unreliable memory or cache hardware\n       (a surprisingly common problem; try a different machine.)\n   (3) A bug in the compiler used to create this executable\n       (unlikely, if you didn't compile bzip2 yourself.)\n   (4) A real bug in bzip2 -- I hope this should never be the case.\n   The user's manual, Section 4.3, has more info on (2) and (3).\n   \n   If you suspect this is a bug in bzip2, or are unsure about (2)\n   or (3), feel free to report it to me at: jseward@acm.org.\n   Section 4.3 of the user's manual describes the info a useful\n   bug report should have.  If the manual is available on your\n   system, please try and read it before mailing me.  If you don't\n   have the manual or can't be bothered to read it, mail me anyway.\n\n"
	.size	.L.str.79, 995

	.type	.L.str.80,@object       # @.str.80
.L.str.80:
	.asciz	"\tInput file = %s, output file = %s\n"
	.size	.L.str.80, 36

	.type	.L.str.81,@object       # @.str.81
.L.str.81:
	.asciz	"%s: Deleting output file %s, if it exists.\n"
	.size	.L.str.81, 44

	.type	.L.str.82,@object       # @.str.82
.L.str.82:
	.asciz	"%s: WARNING: deletion of output file (apparently) failed.\n"
	.size	.L.str.82, 59

	.type	.L.str.83,@object       # @.str.83
.L.str.83:
	.asciz	"%s: WARNING: deletion of output file suppressed\n"
	.size	.L.str.83, 49

	.type	.L.str.84,@object       # @.str.84
.L.str.84:
	.asciz	"%s:    since input file no longer exists.  Output file\n"
	.size	.L.str.84, 56

	.type	.L.str.85,@object       # @.str.85
.L.str.85:
	.asciz	"%s:    `%s' may be incomplete.\n"
	.size	.L.str.85, 32

	.type	.L.str.86,@object       # @.str.86
.L.str.86:
	.asciz	"%s:    I suggest doing an integrity test (bzip2 -tv) of it.\n"
	.size	.L.str.86, 61

	.type	.L.str.87,@object       # @.str.87
.L.str.87:
	.asciz	"%s: WARNING: some files have not been processed:\n%s:    %d specified on command line, %d not processed yet.\n\n"
	.size	.L.str.87, 110

	.type	.L.str.88,@object       # @.str.88
.L.str.88:
	.asciz	"\nIt is possible that the compressed file(s) have become corrupted.\nYou can use the -tvv option to test integrity of such files.\n\nYou can use the `bzip2recover' program to attempt to recover\ndata from undamaged sections of corrupted files.\n\n"
	.size	.L.str.88, 241

	.type	.L.str.89,@object       # @.str.89
.L.str.89:
	.asciz	"bzip2: file name\n`%s'\nis suspiciously (more than %d chars) long.\nTry using a reasonable file name instead.  Sorry! :-)\n"
	.size	.L.str.89, 120

	.type	.L.str.90,@object       # @.str.90
.L.str.90:
	.asciz	"\n%s: couldn't allocate enough memory\n"
	.size	.L.str.90, 38

	.type	.L.str.91,@object       # @.str.91
.L.str.91:
	.asciz	"bzip2, a block-sorting file compressor.  Version %s.\n   \n   Copyright (C) 1996-2002 by Julian Seward.\n   \n   This program is free software; you can redistribute it and/or modify\n   it under the terms set out in the LICENSE file, which is included\n   in the bzip2-1.0 source distribution.\n   \n   This program is distributed in the hope that it will be useful,\n   but WITHOUT ANY WARRANTY; without even the implied warranty of\n   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\n   LICENSE file for more details.\n   \n"
	.size	.L.str.91, 529

	.type	.L.str.92,@object       # @.str.92
.L.str.92:
	.asciz	"bzip2, a block-sorting file compressor.  Version %s.\n\n   usage: %s [flags and input files in any order]\n\n   -h --help           print this message\n   -d --decompress     force decompression\n   -z --compress       force compression\n   -k --keep           keep (don't delete) input files\n   -f --force          overwrite existing output files\n   -t --test           test compressed file integrity\n   -c --stdout         output to standard out\n   -q --quiet          suppress noncritical error messages\n   -v --verbose        be verbose (a 2nd -v gives more)\n   -L --license        display software version & license\n   -V --version        display software version & license\n   -s --small          use less memory (at most 2500k)\n   -1 .. -9            set block size to 100k .. 900k\n   --fast              alias for -1\n   --best              alias for -9\n\n   If invoked as `bzip2', default action is to compress.\n              as `bunzip2',  default action is to decompress.\n              as `bzcat', default action is to decompress to stdout.\n\n   If no file names are given, bzip2 compresses or decompresses\n   from standard input to standard output.  You can combine\n   short flags, so `-v -4' means the same as -v4 or -4v, &c.\n\n"
	.size	.L.str.92, 1230

	.type	.L.str.93,@object       # @.str.93
.L.str.93:
	.asciz	"%s: %s is redundant in versions 0.9.5 and above\n"
	.size	.L.str.93, 49

	.type	.L.str.94,@object       # @.str.94
.L.str.94:
	.asciz	"\n%s: Control-C or similar caught, quitting.\n"
	.size	.L.str.94, 45

	.type	.L.str.95,@object       # @.str.95
.L.str.95:
	.asciz	"compress: bad modes\n"
	.size	.L.str.95, 21

	.type	.L.str.96,@object       # @.str.96
.L.str.96:
	.asciz	"(stdin)"
	.size	.L.str.96, 8

	.type	.L.str.97,@object       # @.str.97
.L.str.97:
	.asciz	"(stdout)"
	.size	.L.str.97, 9

	.type	.L.str.98,@object       # @.str.98
.L.str.98:
	.asciz	"%s: There are no files matching `%s'.\n"
	.size	.L.str.98, 39

	.type	.L.str.99,@object       # @.str.99
.L.str.99:
	.asciz	"%s: Can't open input file %s: %s.\n"
	.size	.L.str.99, 35

	.type	.L.str.100,@object      # @.str.100
.L.str.100:
	.asciz	"%s: Input file %s already has %s suffix.\n"
	.size	.L.str.100, 42

	.type	.L.str.101,@object      # @.str.101
.L.str.101:
	.asciz	"%s: Input file %s is a directory.\n"
	.size	.L.str.101, 35

	.type	.L.str.102,@object      # @.str.102
.L.str.102:
	.asciz	"%s: Input file %s is not a normal file.\n"
	.size	.L.str.102, 41

	.type	.L.str.103,@object      # @.str.103
.L.str.103:
	.asciz	"%s: Output file %s already exists.\n"
	.size	.L.str.103, 36

	.type	.L.str.104,@object      # @.str.104
.L.str.104:
	.asciz	"%s: Input file %s has %d other link%s.\n"
	.size	.L.str.104, 40

	.type	.L.str.105,@object      # @.str.105
.L.str.105:
	.asciz	"s"
	.size	.L.str.105, 2

	.type	.L.str.106,@object      # @.str.106
.L.str.106:
	.asciz	"%s: I won't write compressed data to a terminal.\n"
	.size	.L.str.106, 50

	.type	.L.str.107,@object      # @.str.107
.L.str.107:
	.asciz	"%s: For help, type: `%s --help'.\n"
	.size	.L.str.107, 34

	.type	.L.str.108,@object      # @.str.108
.L.str.108:
	.asciz	"rb"
	.size	.L.str.108, 3

	.type	.L.str.109,@object      # @.str.109
.L.str.109:
	.asciz	"wb"
	.size	.L.str.109, 3

	.type	.L.str.110,@object      # @.str.110
.L.str.110:
	.asciz	"%s: Can't create output file %s: %s.\n"
	.size	.L.str.110, 38

	.type	.L.str.111,@object      # @.str.111
.L.str.111:
	.asciz	"compress: bad srcMode"
	.size	.L.str.111, 22

	.type	.L.str.112,@object      # @.str.112
.L.str.112:
	.asciz	"  %s: "
	.size	.L.str.112, 7

	.type	.L.str.113,@object      # @.str.113
.L.str.113:
	.asciz	"\n%s: PANIC -- internal consistency error:\n\t%s\n\tThis is a BUG.  Please report it to me at:\n\tjseward@acm.org\n"
	.size	.L.str.113, 108

	.type	fileMetaInfo,@object    # @fileMetaInfo
	.local	fileMetaInfo
	.comm	fileMetaInfo,144,8
	.type	.L.str.114,@object      # @.str.114
.L.str.114:
	.asciz	" "
	.size	.L.str.114, 2

	.type	.L.str.115,@object      # @.str.115
.L.str.115:
	.asciz	" no data compressed.\n"
	.size	.L.str.115, 22

	.type	.L.str.116,@object      # @.str.116
.L.str.116:
	.asciz	"%6.3f:1, %6.3f bits/byte, %5.2f%% saved, %s in, %s out.\n"
	.size	.L.str.116, 57

	.type	.L.str.117,@object      # @.str.117
.L.str.117:
	.asciz	"compress:unexpected error"
	.size	.L.str.117, 26

	.type	.L.str.118,@object      # @.str.118
.L.str.118:
	.asciz	"bzip2: I'm not configured correctly for this platform!\n\tI require Int32, Int16 and Char to have sizes\n\tof 4, 2 and 1 bytes to run properly, and they don't.\n\tProbably you can fix this by defining them correctly,\n\tand recompiling.  Bye!\n"
	.size	.L.str.118, 236

	.type	.L.str.119,@object      # @.str.119
.L.str.119:
	.asciz	"\n%s: I/O or other error, bailing out.  Possible reason follows.\n"
	.size	.L.str.119, 65

	.type	.L.str.120,@object      # @.str.120
.L.str.120:
	.asciz	"uncompress: bad modes\n"
	.size	.L.str.120, 23

	.type	.L.str.121,@object      # @.str.121
.L.str.121:
	.asciz	".out"
	.size	.L.str.121, 5

	.type	.L.str.122,@object      # @.str.122
.L.str.122:
	.asciz	"%s: Can't guess original name for %s -- using %s\n"
	.size	.L.str.122, 50

	.type	.L.str.123,@object      # @.str.123
.L.str.123:
	.asciz	"%s: I won't read compressed data from a terminal.\n"
	.size	.L.str.123, 51

	.type	.L.str.124,@object      # @.str.124
.L.str.124:
	.asciz	"%s: Can't open input file %s:%s.\n"
	.size	.L.str.124, 34

	.type	.L.str.125,@object      # @.str.125
.L.str.125:
	.asciz	"uncompress: bad srcMode"
	.size	.L.str.125, 24

	.type	.L.str.126,@object      # @.str.126
.L.str.126:
	.asciz	"done\n"
	.size	.L.str.126, 6

	.type	.L.str.127,@object      # @.str.127
.L.str.127:
	.asciz	"not a bzip2 file.\n"
	.size	.L.str.127, 19

	.type	.L.str.128,@object      # @.str.128
.L.str.128:
	.asciz	"%s: %s is not a bzip2 file.\n"
	.size	.L.str.128, 29

	.type	.L.str.129,@object      # @.str.129
.L.str.129:
	.asciz	"decompress:bzReadGetUnused"
	.size	.L.str.129, 27

	.type	.L.str.130,@object      # @.str.130
.L.str.130:
	.asciz	"\n    "
	.size	.L.str.130, 6

	.type	.L.str.131,@object      # @.str.131
.L.str.131:
	.asciz	"\n%s: %s: trailing garbage after EOF ignored\n"
	.size	.L.str.131, 45

	.type	.L.str.132,@object      # @.str.132
.L.str.132:
	.asciz	"decompress:unexpected error"
	.size	.L.str.132, 28

	.type	.L.str.133,@object      # @.str.133
.L.str.133:
	.asciz	"\n%s: Data integrity error when decompressing.\n"
	.size	.L.str.133, 47

	.type	.L.str.134,@object      # @.str.134
.L.str.134:
	.asciz	"\n%s: Compressed file ends unexpectedly;\n\tperhaps it is corrupted?  *Possible* reason follows.\n"
	.size	.L.str.134, 95

	.type	.L.str.135,@object      # @.str.135
.L.str.135:
	.asciz	"testf: bad modes\n"
	.size	.L.str.135, 18

	.type	.L.str.136,@object      # @.str.136
.L.str.136:
	.asciz	"%s: Can't open input %s: %s.\n"
	.size	.L.str.136, 30

	.type	.L.str.137,@object      # @.str.137
.L.str.137:
	.asciz	"testf: bad srcMode"
	.size	.L.str.137, 19

	.type	.L.str.138,@object      # @.str.138
.L.str.138:
	.asciz	"ok\n"
	.size	.L.str.138, 4

	.type	.L.str.139,@object      # @.str.139
.L.str.139:
	.asciz	"test:bzReadGetUnused"
	.size	.L.str.139, 21

	.type	.L.str.140,@object      # @.str.140
.L.str.140:
	.asciz	"%s: %s: "
	.size	.L.str.140, 9

	.type	.L.str.141,@object      # @.str.141
.L.str.141:
	.asciz	"data integrity (CRC) error in data\n"
	.size	.L.str.141, 36

	.type	.L.str.142,@object      # @.str.142
.L.str.142:
	.asciz	"file ends unexpectedly\n"
	.size	.L.str.142, 24

	.type	.L.str.143,@object      # @.str.143
.L.str.143:
	.asciz	"bad magic number (file not created by bzip2)\n"
	.size	.L.str.143, 46

	.type	.L.str.144,@object      # @.str.144
.L.str.144:
	.asciz	"trailing garbage after EOF ignored\n"
	.size	.L.str.144, 36

	.type	.L.str.145,@object      # @.str.145
.L.str.145:
	.asciz	"test:unexpected error"
	.size	.L.str.145, 22


	.ident	"clang version 4.0.1 (tags/RELEASE_401/final 324005)"
	.section	".note.GNU-stack","",@progbits
