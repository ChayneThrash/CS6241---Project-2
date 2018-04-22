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
	subq	$112, %rsp
	movq	%rdi, -24(%rbp)
	movq	56(%rdi), %rax
	movq	%rax, -64(%rbp)
	movq	-24(%rbp), %rax
	movq	64(%rax), %rax
	movq	%rax, -56(%rbp)
	movq	-24(%rbp), %rax
	movq	40(%rax), %rax
	movq	%rax, -48(%rbp)
	movq	-24(%rbp), %rax
	movl	108(%rax), %eax
	movl	%eax, -4(%rbp)
	movq	-24(%rbp), %rax
	movl	656(%rax), %eax
	movl	%eax, -12(%rbp)
	movq	-24(%rbp), %rax
	movl	88(%rax), %eax
	movl	%eax, -28(%rbp)
	cmpl	$9999, -4(%rbp)         # imm = 0x270F
	jg	.LBB0_1
.LBB0_13:                               # %if.end29
	movq	-24(%rbp), %rax
	movq	24(%rax), %rdi
	movq	32(%rax), %rsi
	movq	-48(%rbp), %rdx
	movl	-4(%rbp), %ecx
	movl	-12(%rbp), %r8d
	callq	fallbackSort
	jmp	.LBB0_14
.LBB0_1:                                # %if.else
	movl	-4(%rbp), %eax
	addl	$34, %eax
	movl	%eax, -8(%rbp)
	testb	$1, -8(%rbp)
	je	.LBB0_3
# BB#2:                                 # %if.then5
	incl	-8(%rbp)
.LBB0_3:                                # %if.end
	movslq	-8(%rbp), %rax
	addq	-56(%rbp), %rax
	movq	%rax, -88(%rbp)
	cmpl	$0, -28(%rbp)
	jle	.LBB0_4
# BB#21:                                # %if.end85
	cmpl	$100, -28(%rbp)
	jg	.LBB0_5
	jmp	.LBB0_22
.LBB0_4:                                # %if.then7
	movl	$1, -28(%rbp)
	movb	$1, %al
	testb	%al, %al
	jne	.LBB0_22
.LBB0_5:                                # %if.then10
	movl	$100, -28(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, %ecx
	shll	$5, %ecx
	addl	%eax, %ecx
	movl	%ecx, -32(%rbp)
	movl	%ecx, -16(%rbp)
	movq	-64(%rbp), %rdi
	movq	-56(%rbp), %rsi
	movq	-88(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movl	-4(%rbp), %r8d
	movl	-12(%rbp), %r9d
	leaq	-16(%rbp), %rax
	movq	%rax, (%rsp)
	callq	mainSort
	cmpl	$3, -12(%rbp)
	jge	.LBB0_6
	jmp	.LBB0_10
.LBB0_22:                               # %if.end119
	movl	-28(%rbp), %eax
	decl	%eax
	cltq
	imulq	$1431655766, %rax, %rax # imm = 0x55555556
	movq	%rax, %rcx
	shrq	$63, %rcx
	shrq	$32, %rax
	addl	%ecx, %eax
	imull	-4(%rbp), %eax
	movl	%eax, -32(%rbp)
	movl	%eax, -16(%rbp)
	movq	-64(%rbp), %rdi
	movq	-56(%rbp), %rsi
	movq	-88(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movl	-4(%rbp), %r8d
	movl	-12(%rbp), %r9d
	leaq	-16(%rbp), %rax
	movq	%rax, (%rsp)
	callq	mainSort
	cmpl	$2, -12(%rbp)
	jle	.LBB0_10
.LBB0_6:                                # %if.then13
	movq	stderr(%rip), %rax
	movq	%rax, -96(%rbp)
	movl	-32(%rbp), %eax
	subl	-16(%rbp), %eax
	movl	%eax, -68(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, -72(%rbp)
	movl	-32(%rbp), %eax
	subl	-16(%rbp), %eax
	cvtsi2ssl	%eax, %xmm0
	movss	%xmm0, -76(%rbp)
	cmpl	$0, -4(%rbp)
	je	.LBB0_7
# BB#8:                                 # %cond.false
	movl	-4(%rbp), %eax
	movl	%eax, -100(%rbp)
	movl	%eax, -36(%rbp)
	jmp	.LBB0_9
.LBB0_7:                                # %cond.true
	movl	$1, -36(%rbp)
.LBB0_9:                                # %cond.end
	xorps	%xmm0, %xmm0
	cvtsi2ssl	-36(%rbp), %xmm0
	movss	-76(%rbp), %xmm1        # xmm1 = mem[0],zero,zero,zero
	divss	%xmm0, %xmm1
	xorps	%xmm0, %xmm0
	cvtss2sd	%xmm1, %xmm0
	movl	-72(%rbp), %ecx
	movl	-68(%rbp), %edx
	movq	-96(%rbp), %rdi
	movl	$.L.str, %esi
	movb	$1, %al
	callq	fprintf
.LBB0_10:                               # %if.end21
	cmpl	$0, -16(%rbp)
	js	.LBB0_11
.LBB0_14:                               # %if.end33
	movq	-24(%rbp), %rax
	movl	$-1, 48(%rax)
	movl	$0, -8(%rbp)
	jmp	.LBB0_15
	.p2align	4, 0x90
.LBB0_23:                               # %for.inc
                                        #   in Loop: Header=BB0_15 Depth=1
	leal	1(%rax), %eax
	movl	%eax, -8(%rbp)
.LBB0_15:                               # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	-8(%rbp), %eax
	movq	-24(%rbp), %rcx
	cmpl	108(%rcx), %eax
	jge	.LBB0_18
# BB#16:                                # %for.body
                                        #   in Loop: Header=BB0_15 Depth=1
	movq	-64(%rbp), %rcx
	movslq	-8(%rbp), %rax
	cmpl	$0, (%rcx,%rax,4)
	jne	.LBB0_23
# BB#17:                                # %if.then41
	movq	-24(%rbp), %rcx
	movl	%eax, 48(%rcx)
.LBB0_18:                               # %for.end
	movq	-24(%rbp), %rax
	cmpl	$-1, 48(%rax)
	jne	.LBB0_20
# BB#19:                                # %if.then48
	movl	$1003, %edi             # imm = 0x3EB
	callq	BZ2_bz__AssertH__fail
.LBB0_20:                               # %if.end49
	addq	$112, %rsp
	popq	%rbp
	retq
.LBB0_11:                               # %if.then24
	cmpl	$2, -12(%rbp)
	jl	.LBB0_13
# BB#12:                                # %if.then27
	movq	stderr(%rip), %rdi
	movl	$.L.str.1, %esi
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB0_13
.Lfunc_end0:
	.size	BZ2_blockSort, .Lfunc_end0-BZ2_blockSort
	.cfi_endproc

	.p2align	4, 0x90
	.type	fallbackSort,@function
fallbackSort:                           # @fallbackSort
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi3:
	.cfi_def_cfa_offset 16
.Lcfi4:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi5:
	.cfi_def_cfa_register %rbp
	subq	$2160, %rsp             # imm = 0x870
	movq	%rdi, -64(%rbp)
	movq	%rsi, -80(%rbp)
	movq	%rdx, -32(%rbp)
	movl	%ecx, -12(%rbp)
	movl	%r8d, -52(%rbp)
	movq	-80(%rbp), %rax
	movq	%rax, -88(%rbp)
	cmpl	$4, -52(%rbp)
	jl	.LBB1_2
# BB#1:                                 # %if.then
	movq	stderr(%rip), %rdi
	movl	$.L.str.48, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB1_2:                                # %if.end
	movl	$0, -4(%rbp)
	cmpl	$256, -4(%rbp)          # imm = 0x100
	jg	.LBB1_77
	.p2align	4, 0x90
.LBB1_4:                                # %for.body6
                                        # =>This Inner Loop Header: Depth=1
	movslq	-4(%rbp), %rax
	movl	$0, -1136(%rbp,%rax,4)
	incl	-4(%rbp)
	cmpl	$256, -4(%rbp)          # imm = 0x100
	jle	.LBB1_4
.LBB1_77:                               # %for.end
	movl	$0, -4(%rbp)
	jmp	.LBB1_78
	.p2align	4, 0x90
.LBB1_79:                               # %for.body415
                                        #   in Loop: Header=BB1_78 Depth=1
	movq	-88(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	incl	-1136(%rbp,%rax,4)
	incl	-4(%rbp)
.LBB1_78:                               # %for.cond213
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jl	.LBB1_79
# BB#5:                                 # %for.end12
	movl	$0, -4(%rbp)
	cmpl	$255, -4(%rbp)
	jg	.LBB1_8
	.p2align	4, 0x90
.LBB1_7:                                # %for.body15
                                        # =>This Inner Loop Header: Depth=1
	movslq	-4(%rbp), %rax
	movl	-1136(%rbp,%rax,4), %ecx
	movl	%ecx, -2160(%rbp,%rax,4)
	incl	-4(%rbp)
	cmpl	$255, -4(%rbp)
	jle	.LBB1_7
.LBB1_8:                                # %for.end22
	movl	$1, -4(%rbp)
	cmpl	$256, -4(%rbp)          # imm = 0x100
	jg	.LBB1_11
	.p2align	4, 0x90
.LBB1_10:                               # %for.body25
                                        # =>This Inner Loop Header: Depth=1
	movslq	-4(%rbp), %rax
	movl	-1140(%rbp,%rax,4), %ecx
	addl	%ecx, -1136(%rbp,%rax,4)
	incl	-4(%rbp)
	cmpl	$256, -4(%rbp)          # imm = 0x100
	jle	.LBB1_10
.LBB1_11:                               # %for.end32
	movl	$0, -4(%rbp)
	jmp	.LBB1_12
	.p2align	4, 0x90
.LBB1_13:                               # %for.body35
                                        #   in Loop: Header=BB1_12 Depth=1
	movq	-88(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movl	%eax, -20(%rbp)
	movslq	-20(%rbp), %rax
	movl	-1136(%rbp,%rax,4), %eax
	decl	%eax
	movl	%eax, -8(%rbp)
	movslq	-20(%rbp), %rcx
	movl	%eax, -1136(%rbp,%rcx,4)
	movl	-4(%rbp), %eax
	movq	-64(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	-4(%rbp)
.LBB1_12:                               # %for.cond33
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jl	.LBB1_13
# BB#14:                                # %for.end47
	movl	-12(%rbp), %eax
	movl	%eax, %ecx
	sarl	$31, %ecx
	shrl	$27, %ecx
	addl	%eax, %ecx
	sarl	$5, %ecx
	addl	$2, %ecx
	movl	%ecx, -92(%rbp)
	movl	$0, -4(%rbp)
	jmp	.LBB1_15
	.p2align	4, 0x90
.LBB1_16:                               # %for.body52
                                        #   in Loop: Header=BB1_15 Depth=1
	movq	-32(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movl	$0, (%rax,%rcx,4)
	incl	-4(%rbp)
.LBB1_15:                               # %for.cond49
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-92(%rbp), %eax
	jl	.LBB1_16
# BB#17:                                # %for.end57
	movl	$0, -4(%rbp)
	cmpl	$255, -4(%rbp)
	jg	.LBB1_20
	.p2align	4, 0x90
.LBB1_19:                               # %for.body61
                                        # =>This Inner Loop Header: Depth=1
	movslq	-4(%rbp), %rax
	movl	-1136(%rbp,%rax,4), %ecx
	movl	$1, %eax
	shll	%cl, %eax
	movq	-32(%rbp), %rdx
	sarl	$5, %ecx
	movslq	%ecx, %rcx
	orl	%eax, (%rdx,%rcx,4)
	incl	-4(%rbp)
	cmpl	$255, -4(%rbp)
	jle	.LBB1_19
.LBB1_20:                               # %for.end70
	movl	$0, -4(%rbp)
	cmpl	$31, -4(%rbp)
	jg	.LBB1_23
	.p2align	4, 0x90
.LBB1_22:                               # %for.body74
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %ecx
	addl	%ecx, %ecx
	addl	-12(%rbp), %ecx
	movl	$1, %eax
	shll	%cl, %eax
	movq	-32(%rbp), %rdx
	sarl	$5, %ecx
	movslq	%ecx, %rcx
	orl	%eax, (%rdx,%rcx,4)
	movl	-12(%rbp), %eax
	movl	-4(%rbp), %ecx
	leal	1(%rax,%rcx,2), %ecx
	movl	$-2, %eax
	roll	%cl, %eax
	movq	-32(%rbp), %rdx
	sarl	$5, %ecx
	movslq	%ecx, %rcx
	andl	%eax, (%rdx,%rcx,4)
	incl	-4(%rbp)
	cmpl	$31, -4(%rbp)
	jle	.LBB1_22
.LBB1_23:                               # %for.end98
	movl	$1, -48(%rbp)
	.p2align	4, 0x90
.LBB1_24:                               # %while.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_27 Depth 2
                                        #     Child Loop BB1_34 Depth 2
                                        #       Child Loop BB1_35 Depth 3
                                        #       Child Loop BB1_41 Depth 3
                                        #       Child Loop BB1_43 Depth 3
                                        #       Child Loop BB1_46 Depth 3
                                        #       Child Loop BB1_52 Depth 3
                                        #       Child Loop BB1_54 Depth 3
                                        #       Child Loop BB1_59 Depth 3
	cmpl	$4, -52(%rbp)
	jl	.LBB1_26
# BB#25:                                # %if.then101
                                        #   in Loop: Header=BB1_24 Depth=1
	movq	stderr(%rip), %rdi
	movl	-48(%rbp), %edx
	movl	$.L.str.49, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB1_26:                               # %if.end103
                                        #   in Loop: Header=BB1_24 Depth=1
	movl	$0, -20(%rbp)
	movl	$0, -4(%rbp)
	jmp	.LBB1_27
	.p2align	4, 0x90
.LBB1_32:                               # %if.end123
                                        #   in Loop: Header=BB1_27 Depth=2
	movl	-20(%rbp), %eax
	movq	-80(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	-4(%rbp)
.LBB1_27:                               # %for.cond104
                                        #   Parent Loop BB1_24 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jge	.LBB1_33
# BB#28:                                # %for.body107
                                        #   in Loop: Header=BB1_27 Depth=2
	movq	-32(%rbp), %rax
	movl	-4(%rbp), %ecx
	movl	%ecx, %edx
	sarl	$5, %edx
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %eax
	btl	%ecx, %eax
	jae	.LBB1_30
# BB#29:                                # %if.then114
                                        #   in Loop: Header=BB1_27 Depth=2
	movl	-4(%rbp), %eax
	movl	%eax, -20(%rbp)
.LBB1_30:                               # %if.end115
                                        #   in Loop: Header=BB1_27 Depth=2
	movq	-64(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	subl	-48(%rbp), %eax
	movl	%eax, -8(%rbp)
	jns	.LBB1_32
# BB#31:                                # %if.then121
                                        #   in Loop: Header=BB1_27 Depth=2
	movl	-12(%rbp), %eax
	addl	%eax, -8(%rbp)
	jmp	.LBB1_32
	.p2align	4, 0x90
.LBB1_33:                               # %for.end128
                                        #   in Loop: Header=BB1_24 Depth=1
	movl	$0, -40(%rbp)
	movl	$-1, -36(%rbp)
	jmp	.LBB1_34
	.p2align	4, 0x90
.LBB1_57:                               # %if.end226
                                        #   in Loop: Header=BB1_34 Depth=2
	movl	-36(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jle	.LBB1_34
# BB#58:                                # %if.then229
                                        #   in Loop: Header=BB1_34 Depth=2
	movl	-36(%rbp), %eax
	subl	-44(%rbp), %eax
	movl	-40(%rbp), %ecx
	leal	1(%rcx,%rax), %eax
	movl	%eax, -40(%rbp)
	movq	-64(%rbp), %rdi
	movq	-80(%rbp), %rsi
	movl	-44(%rbp), %edx
	movl	-36(%rbp), %ecx
	callq	fallbackQSort3
	movl	$-1, -68(%rbp)
	movl	-44(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB1_59
	.p2align	4, 0x90
.LBB1_62:                               # %for.inc251
                                        #   in Loop: Header=BB1_59 Depth=3
	incl	-4(%rbp)
.LBB1_59:                               # %for.cond233
                                        #   Parent Loop BB1_24 Depth=1
                                        #     Parent Loop BB1_34 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-4(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jg	.LBB1_34
# BB#60:                                # %for.body236
                                        #   in Loop: Header=BB1_59 Depth=3
	movq	-80(%rbp), %rax
	movq	-64(%rbp), %rcx
	movslq	-4(%rbp), %rdx
	movl	(%rcx,%rdx,4), %ecx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -96(%rbp)
	cmpl	%eax, -68(%rbp)
	je	.LBB1_62
# BB#61:                                # %if.then243
                                        #   in Loop: Header=BB1_59 Depth=3
	movl	-4(%rbp), %ecx
	movl	$1, %eax
	shll	%cl, %eax
	movq	-32(%rbp), %rdx
	sarl	$5, %ecx
	movslq	%ecx, %rcx
	orl	%eax, (%rdx,%rcx,4)
	movl	-96(%rbp), %eax
	movl	%eax, -68(%rbp)
	jmp	.LBB1_62
	.p2align	4, 0x90
.LBB1_34:                               # %while.body130
                                        #   Parent Loop BB1_24 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB1_35 Depth 3
                                        #       Child Loop BB1_41 Depth 3
                                        #       Child Loop BB1_43 Depth 3
                                        #       Child Loop BB1_46 Depth 3
                                        #       Child Loop BB1_52 Depth 3
                                        #       Child Loop BB1_54 Depth 3
                                        #       Child Loop BB1_59 Depth 3
	movl	-36(%rbp), %eax
	incl	%eax
	movl	%eax, -8(%rbp)
	jmp	.LBB1_35
	.p2align	4, 0x90
.LBB1_39:                               # %while.body142
                                        #   in Loop: Header=BB1_35 Depth=3
	incl	-8(%rbp)
.LBB1_35:                               # %while.cond132
                                        #   Parent Loop BB1_24 Depth=1
                                        #     Parent Loop BB1_34 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	-32(%rbp), %rax
	movl	-8(%rbp), %ecx
	movl	%ecx, %edx
	sarl	$5, %edx
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %eax
	btl	%ecx, %eax
	jae	.LBB1_36
# BB#37:                                # %land.rhs
                                        #   in Loop: Header=BB1_35 Depth=3
	movl	-8(%rbp), %eax
	testb	$31, %al
	setne	-53(%rbp)
	setne	-13(%rbp)
	cmpb	$1, -13(%rbp)
	je	.LBB1_39
	jmp	.LBB1_40
	.p2align	4, 0x90
.LBB1_36:                               # %while.cond132.land.end_crit_edge
                                        #   in Loop: Header=BB1_35 Depth=3
	movb	$0, -13(%rbp)
	cmpb	$1, -13(%rbp)
	je	.LBB1_39
.LBB1_40:                               # %while.end
                                        #   in Loop: Header=BB1_34 Depth=2
	movq	-32(%rbp), %rax
	movl	-8(%rbp), %ecx
	movl	%ecx, %edx
	sarl	$5, %edx
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %eax
	btl	%ecx, %eax
	jb	.LBB1_41
	jmp	.LBB1_45
	.p2align	4, 0x90
.LBB1_42:                               # %while.body158
                                        #   in Loop: Header=BB1_41 Depth=3
	addl	$32, -8(%rbp)
.LBB1_41:                               # %while.cond152
                                        #   Parent Loop BB1_24 Depth=1
                                        #     Parent Loop BB1_34 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	-32(%rbp), %rax
	movl	-8(%rbp), %ecx
	sarl	$5, %ecx
	movslq	%ecx, %rcx
	cmpl	$-1, (%rax,%rcx,4)
	je	.LBB1_42
	jmp	.LBB1_43
	.p2align	4, 0x90
.LBB1_44:                               # %while.body169
                                        #   in Loop: Header=BB1_43 Depth=3
	incl	-8(%rbp)
.LBB1_43:                               # %while.cond161
                                        #   Parent Loop BB1_24 Depth=1
                                        #     Parent Loop BB1_34 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	-32(%rbp), %rax
	movl	-8(%rbp), %ecx
	movl	%ecx, %edx
	sarl	$5, %edx
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %eax
	btl	%ecx, %eax
	jb	.LBB1_44
.LBB1_45:                               # %if.end172
                                        #   in Loop: Header=BB1_34 Depth=2
	movl	-8(%rbp), %eax
	decl	%eax
	movl	%eax, -44(%rbp)
	cmpl	-12(%rbp), %eax
	jl	.LBB1_46
	jmp	.LBB1_63
	.p2align	4, 0x90
.LBB1_50:                               # %while.body190
                                        #   in Loop: Header=BB1_46 Depth=3
	incl	-8(%rbp)
.LBB1_46:                               # %while.cond178
                                        #   Parent Loop BB1_24 Depth=1
                                        #     Parent Loop BB1_34 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	-32(%rbp), %rax
	movl	-8(%rbp), %ecx
	movl	%ecx, %edx
	sarl	$5, %edx
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %eax
	btl	%ecx, %eax
	jae	.LBB1_48
# BB#47:                                # %while.cond178.land.end189_crit_edge
                                        #   in Loop: Header=BB1_46 Depth=3
	movb	$0, -14(%rbp)
	cmpb	$1, -14(%rbp)
	je	.LBB1_50
	jmp	.LBB1_51
	.p2align	4, 0x90
.LBB1_48:                               # %land.rhs186
                                        #   in Loop: Header=BB1_46 Depth=3
	movl	-8(%rbp), %eax
	testb	$31, %al
	setne	-54(%rbp)
	setne	-14(%rbp)
	cmpb	$1, -14(%rbp)
	je	.LBB1_50
.LBB1_51:                               # %while.end192
                                        #   in Loop: Header=BB1_34 Depth=2
	movq	-32(%rbp), %rax
	movl	-8(%rbp), %ecx
	movl	%ecx, %edx
	sarl	$5, %edx
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %eax
	btl	%ecx, %eax
	jb	.LBB1_56
	jmp	.LBB1_52
	.p2align	4, 0x90
.LBB1_53:                               # %while.body207
                                        #   in Loop: Header=BB1_52 Depth=3
	addl	$32, -8(%rbp)
.LBB1_52:                               # %while.cond201
                                        #   Parent Loop BB1_24 Depth=1
                                        #     Parent Loop BB1_34 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	-32(%rbp), %rax
	movl	-8(%rbp), %ecx
	sarl	$5, %ecx
	movslq	%ecx, %rcx
	cmpl	$0, (%rax,%rcx,4)
	je	.LBB1_53
	jmp	.LBB1_54
	.p2align	4, 0x90
.LBB1_55:                               # %while.body218
                                        #   in Loop: Header=BB1_54 Depth=3
	incl	-8(%rbp)
.LBB1_54:                               # %while.cond210
                                        #   Parent Loop BB1_24 Depth=1
                                        #     Parent Loop BB1_34 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	-32(%rbp), %rax
	movl	-8(%rbp), %ecx
	movl	%ecx, %edx
	sarl	$5, %edx
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %eax
	btl	%ecx, %eax
	jae	.LBB1_55
.LBB1_56:                               # %if.end221
                                        #   in Loop: Header=BB1_34 Depth=2
	movl	-8(%rbp), %eax
	decl	%eax
	movl	%eax, -36(%rbp)
	cmpl	-12(%rbp), %eax
	jl	.LBB1_57
.LBB1_63:                               # %while.end255
                                        #   in Loop: Header=BB1_24 Depth=1
	cmpl	$4, -52(%rbp)
	jl	.LBB1_65
# BB#64:                                # %if.then258
                                        #   in Loop: Header=BB1_24 Depth=1
	movq	stderr(%rip), %rdi
	movl	-40(%rbp), %edx
	movl	$.L.str.50, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB1_65:                               # %if.end260
                                        #   in Loop: Header=BB1_24 Depth=1
	movl	-48(%rbp), %eax
	addl	%eax, %eax
	movl	%eax, -48(%rbp)
	cmpl	-12(%rbp), %eax
	jg	.LBB1_67
# BB#66:                                # %if.end260
                                        #   in Loop: Header=BB1_24 Depth=1
	movl	-40(%rbp), %eax
	testl	%eax, %eax
	jne	.LBB1_24
.LBB1_67:                               # %while.end268
	cmpl	$4, -52(%rbp)
	jl	.LBB1_69
# BB#68:                                # %if.then271
	movq	stderr(%rip), %rdi
	movl	$.L.str.51, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB1_69:                               # %if.end273
	movl	$0, -20(%rbp)
	movl	$0, -4(%rbp)
	jmp	.LBB1_70
	.p2align	4, 0x90
.LBB1_73:                               # %while.end284
                                        #   in Loop: Header=BB1_70 Depth=1
	decl	-2160(%rbp,%rax,4)
	movb	-20(%rbp), %al
	movq	-88(%rbp), %rcx
	movq	-64(%rbp), %rdx
	movslq	-4(%rbp), %rsi
	movl	(%rdx,%rsi,4), %edx
	movb	%al, (%rcx,%rdx)
	incl	-4(%rbp)
.LBB1_70:                               # %for.cond274
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB1_71 Depth 2
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jl	.LBB1_71
	jmp	.LBB1_74
	.p2align	4, 0x90
.LBB1_72:                               # %while.body282
                                        #   in Loop: Header=BB1_71 Depth=2
	incl	%eax
	movl	%eax, -20(%rbp)
.LBB1_71:                               # %while.cond
                                        #   Parent Loop BB1_70 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	-20(%rbp), %rax
	cmpl	$0, -2160(%rbp,%rax,4)
	je	.LBB1_72
	jmp	.LBB1_73
.LBB1_74:                               # %for.end294
	cmpl	$256, -20(%rbp)         # imm = 0x100
	jl	.LBB1_76
# BB#75:                                # %if.then297
	movl	$1005, %edi             # imm = 0x3ED
	callq	BZ2_bz__AssertH__fail
.LBB1_76:                               # %if.end298
	addq	$2160, %rsp             # imm = 0x870
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
.Lcfi6:
	.cfi_def_cfa_offset 16
.Lcfi7:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi8:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$3448, %rsp             # imm = 0xD78
.Lcfi9:
	.cfi_offset %rbx, -24
	movq	16(%rbp), %rax
	movq	%rdi, -64(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -72(%rbp)
	movq	%rcx, -32(%rbp)
	movl	%r8d, -36(%rbp)
	movl	%r9d, -92(%rbp)
	movq	%rax, -128(%rbp)
	cmpl	$4, -92(%rbp)
	jl	.LBB2_2
# BB#1:                                 # %if.then
	movq	stderr(%rip), %rdi
	movl	$.L.str.52, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB2_2:                                # %if.end
	movl	$65536, -16(%rbp)       # imm = 0x10000
	cmpl	$0, -16(%rbp)
	js	.LBB2_4
	.p2align	4, 0x90
.LBB2_84:                               # %for.body3
                                        # =>This Inner Loop Header: Depth=1
	movq	-32(%rbp), %rax
	movslq	-16(%rbp), %rcx
	movl	$0, (%rax,%rcx,4)
	decl	-16(%rbp)
	cmpl	$0, -16(%rbp)
	jns	.LBB2_84
.LBB2_4:                                # %for.end
	movq	-48(%rbp), %rax
	movzbl	(%rax), %eax
	shll	$8, %eax
	movl	%eax, -12(%rbp)
	movl	-36(%rbp), %eax
	decl	%eax
	movl	%eax, -16(%rbp)
	cmpl	$2, -16(%rbp)
	jle	.LBB2_7
	.p2align	4, 0x90
.LBB2_6:                                # %for.body6
                                        # =>This Inner Loop Header: Depth=1
	movq	-72(%rbp), %rax
	movslq	-16(%rbp), %rcx
	movw	$0, (%rax,%rcx,2)
	movl	-12(%rbp), %eax
	sarl	$8, %eax
	movq	-48(%rbp), %rcx
	movslq	-16(%rbp), %rdx
	movzbl	(%rcx,%rdx), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movl	%ecx, -12(%rbp)
	movq	-32(%rbp), %rax
	movslq	-12(%rbp), %rcx
	incl	(%rax,%rcx,4)
	movq	-72(%rbp), %rax
	movslq	-16(%rbp), %rcx
	movw	$0, -2(%rax,%rcx,2)
	movl	-12(%rbp), %eax
	sarl	$8, %eax
	movq	-48(%rbp), %rcx
	movslq	-16(%rbp), %rdx
	movzbl	-1(%rcx,%rdx), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movl	%ecx, -12(%rbp)
	movq	-32(%rbp), %rax
	movslq	-12(%rbp), %rcx
	incl	(%rax,%rcx,4)
	movq	-72(%rbp), %rax
	movslq	-16(%rbp), %rcx
	movw	$0, -4(%rax,%rcx,2)
	movl	-12(%rbp), %eax
	sarl	$8, %eax
	movq	-48(%rbp), %rcx
	movslq	-16(%rbp), %rdx
	movzbl	-2(%rcx,%rdx), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movl	%ecx, -12(%rbp)
	movq	-32(%rbp), %rax
	movslq	-12(%rbp), %rcx
	incl	(%rax,%rcx,4)
	movq	-72(%rbp), %rax
	movslq	-16(%rbp), %rcx
	movw	$0, -6(%rax,%rcx,2)
	movl	-12(%rbp), %eax
	sarl	$8, %eax
	movq	-48(%rbp), %rcx
	movslq	-16(%rbp), %rdx
	movzbl	-3(%rcx,%rdx), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movl	%ecx, -12(%rbp)
	movq	-32(%rbp), %rax
	movslq	-12(%rbp), %rcx
	incl	(%rax,%rcx,4)
	addl	$-4, -16(%rbp)
	cmpl	$2, -16(%rbp)
	jg	.LBB2_6
	jmp	.LBB2_7
	.p2align	4, 0x90
.LBB2_8:                                # %for.body64
                                        #   in Loop: Header=BB2_7 Depth=1
	movq	-72(%rbp), %rax
	movslq	-16(%rbp), %rcx
	movw	$0, (%rax,%rcx,2)
	movl	-12(%rbp), %eax
	sarl	$8, %eax
	movq	-48(%rbp), %rcx
	movslq	-16(%rbp), %rdx
	movzbl	(%rcx,%rdx), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movl	%ecx, -12(%rbp)
	movq	-32(%rbp), %rax
	movslq	-12(%rbp), %rcx
	incl	(%rax,%rcx,4)
	decl	-16(%rbp)
.LBB2_7:                                # %for.cond61
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$0, -16(%rbp)
	jns	.LBB2_8
# BB#85:                                # %for.end79
	movl	$0, -16(%rbp)
	cmpl	$33, -16(%rbp)
	jg	.LBB2_9
	.p2align	4, 0x90
.LBB2_87:                               # %for.body8310
                                        # =>This Inner Loop Header: Depth=1
	movq	-48(%rbp), %rax
	movslq	-16(%rbp), %rcx
	movzbl	(%rax,%rcx), %edx
	movslq	-36(%rbp), %rsi
	addq	%rcx, %rsi
	movb	%dl, (%rax,%rsi)
	movq	-72(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movslq	-16(%rbp), %rdx
	addq	%rcx, %rdx
	movw	$0, (%rax,%rdx,2)
	incl	-16(%rbp)
	cmpl	$33, -16(%rbp)
	jle	.LBB2_87
.LBB2_9:                                # %for.end93
	cmpl	$4, -92(%rbp)
	jl	.LBB2_11
# BB#10:                                # %if.then96
	movq	stderr(%rip), %rdi
	movl	$.L.str.48, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB2_11:                               # %if.end98
	movl	$1, -16(%rbp)
	cmpl	$65536, -16(%rbp)       # imm = 0x10000
	jg	.LBB2_14
	.p2align	4, 0x90
.LBB2_13:                               # %for.body102
                                        # =>This Inner Loop Header: Depth=1
	movq	-32(%rbp), %rax
	movslq	-16(%rbp), %rcx
	movl	-4(%rax,%rcx,4), %edx
	addl	%edx, (%rax,%rcx,4)
	incl	-16(%rbp)
	cmpl	$65536, -16(%rbp)       # imm = 0x10000
	jle	.LBB2_13
.LBB2_14:                               # %for.end111
	movq	-48(%rbp), %rax
	movzbl	(%rax), %eax
	shll	$8, %eax
	movw	%ax, -18(%rbp)
	movl	-36(%rbp), %eax
	decl	%eax
	movl	%eax, -16(%rbp)
	cmpl	$2, -16(%rbp)
	jle	.LBB2_17
	.p2align	4, 0x90
.LBB2_16:                               # %for.body120
                                        # =>This Inner Loop Header: Depth=1
	movzwl	-18(%rbp), %eax
	shrl	$8, %eax
	movq	-48(%rbp), %rcx
	movslq	-16(%rbp), %rdx
	movzbl	(%rcx,%rdx), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movw	%cx, -18(%rbp)
	movq	-32(%rbp), %rax
	movzwl	-18(%rbp), %ecx
	movl	(%rax,%rcx,4), %eax
	decl	%eax
	movl	%eax, -12(%rbp)
	movq	-32(%rbp), %rcx
	movzwl	-18(%rbp), %edx
	movl	%eax, (%rcx,%rdx,4)
	movl	-16(%rbp), %eax
	movq	-64(%rbp), %rcx
	movslq	-12(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movzwl	-18(%rbp), %eax
	shrl	$8, %eax
	movq	-48(%rbp), %rcx
	movslq	-16(%rbp), %rdx
	movzbl	-1(%rcx,%rdx), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movw	%cx, -18(%rbp)
	movq	-32(%rbp), %rax
	movzwl	-18(%rbp), %ecx
	movl	(%rax,%rcx,4), %eax
	decl	%eax
	movl	%eax, -12(%rbp)
	movq	-32(%rbp), %rcx
	movzwl	-18(%rbp), %edx
	movl	%eax, (%rcx,%rdx,4)
	movl	-16(%rbp), %eax
	decl	%eax
	movq	-64(%rbp), %rcx
	movslq	-12(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movzwl	-18(%rbp), %eax
	shrl	$8, %eax
	movq	-48(%rbp), %rcx
	movslq	-16(%rbp), %rdx
	movzbl	-2(%rcx,%rdx), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movw	%cx, -18(%rbp)
	movq	-32(%rbp), %rax
	movzwl	-18(%rbp), %ecx
	movl	(%rax,%rcx,4), %eax
	decl	%eax
	movl	%eax, -12(%rbp)
	movq	-32(%rbp), %rcx
	movzwl	-18(%rbp), %edx
	movl	%eax, (%rcx,%rdx,4)
	movl	-16(%rbp), %eax
	addl	$-2, %eax
	movq	-64(%rbp), %rcx
	movslq	-12(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movzwl	-18(%rbp), %eax
	shrl	$8, %eax
	movq	-48(%rbp), %rcx
	movslq	-16(%rbp), %rdx
	movzbl	-3(%rcx,%rdx), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movw	%cx, -18(%rbp)
	movq	-32(%rbp), %rax
	movzwl	-18(%rbp), %ecx
	movl	(%rax,%rcx,4), %eax
	decl	%eax
	movl	%eax, -12(%rbp)
	movq	-32(%rbp), %rcx
	movzwl	-18(%rbp), %edx
	movl	%eax, (%rcx,%rdx,4)
	movl	-16(%rbp), %eax
	addl	$-3, %eax
	movq	-64(%rbp), %rcx
	movslq	-12(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	addl	$-4, -16(%rbp)
	cmpl	$2, -16(%rbp)
	jg	.LBB2_16
	jmp	.LBB2_17
	.p2align	4, 0x90
.LBB2_18:                               # %for.body193
                                        #   in Loop: Header=BB2_17 Depth=1
	movzwl	-18(%rbp), %eax
	shrl	$8, %eax
	movq	-48(%rbp), %rcx
	movslq	-16(%rbp), %rdx
	movzbl	(%rcx,%rdx), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movw	%cx, -18(%rbp)
	movq	-32(%rbp), %rax
	movzwl	-18(%rbp), %ecx
	movl	(%rax,%rcx,4), %eax
	decl	%eax
	movl	%eax, -12(%rbp)
	movq	-32(%rbp), %rcx
	movzwl	-18(%rbp), %edx
	movl	%eax, (%rcx,%rdx,4)
	movl	-16(%rbp), %eax
	movq	-64(%rbp), %rcx
	movslq	-12(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	decl	-16(%rbp)
.LBB2_17:                               # %for.cond190
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$0, -16(%rbp)
	jns	.LBB2_18
# BB#19:                                # %for.end211
	movl	$0, -16(%rbp)
	cmpl	$255, -16(%rbp)
	jg	.LBB2_22
	.p2align	4, 0x90
.LBB2_21:                               # %for.body215
                                        # =>This Inner Loop Header: Depth=1
	movslq	-16(%rbp), %rax
	movb	$0, -384(%rbp,%rax)
	movslq	-16(%rbp), %rax
	movl	%eax, -1408(%rbp,%rax,4)
	incl	-16(%rbp)
	cmpl	$255, -16(%rbp)
	jle	.LBB2_21
.LBB2_22:                               # %for.end222
	movl	$1, -40(%rbp)
	.p2align	4, 0x90
.LBB2_23:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movl	-40(%rbp), %eax
	leal	1(%rax,%rax,2), %eax
	movl	%eax, -40(%rbp)
	cmpl	$257, %eax              # imm = 0x101
	jl	.LBB2_23
	.p2align	4, 0x90
.LBB2_24:                               # %do.body226
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_26 Depth 2
                                        #       Child Loop BB2_27 Depth 3
	movslq	-40(%rbp), %rax
	imulq	$1431655766, %rax, %rax # imm = 0x55555556
	movq	%rax, %rcx
	shrq	$63, %rcx
	shrq	$32, %rax
	addl	%ecx, %eax
	movl	%eax, -40(%rbp)
	movl	%eax, -16(%rbp)
	cmpl	$255, -16(%rbp)
	jle	.LBB2_26
	jmp	.LBB2_30
	.p2align	4, 0x90
.LBB2_29:                               # %zero
                                        #   in Loop: Header=BB2_26 Depth=2
	movl	-112(%rbp), %eax
	movslq	-12(%rbp), %rcx
	movl	%eax, -1408(%rbp,%rcx,4)
	incl	-16(%rbp)
	cmpl	$255, -16(%rbp)
	jg	.LBB2_30
.LBB2_26:                               # %for.body230
                                        #   Parent Loop BB2_24 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB2_27 Depth 3
	movslq	-16(%rbp), %rax
	movl	-1408(%rbp,%rax,4), %eax
	movl	%eax, -112(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -12(%rbp)
	.p2align	4, 0x90
.LBB2_27:                               # %while.cond
                                        #   Parent Loop BB2_24 Depth=1
                                        #     Parent Loop BB2_26 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	-32(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movslq	-40(%rbp), %rdx
	subq	%rdx, %rcx
	movl	-1408(%rbp,%rcx,4), %ecx
	shll	$8, %ecx
	leal	256(%rcx), %edx
	movslq	%edx, %rdx
	movl	(%rax,%rdx,4), %edx
	movslq	%ecx, %rcx
	subl	(%rax,%rcx,4), %edx
	movl	-112(%rbp), %ecx
	shll	$8, %ecx
	leal	256(%rcx), %esi
	movslq	%esi, %rsi
	movl	(%rax,%rsi,4), %esi
	movslq	%ecx, %rcx
	subl	(%rax,%rcx,4), %esi
	cmpl	%esi, %edx
	jbe	.LBB2_29
# BB#28:                                # %while.body
                                        #   in Loop: Header=BB2_27 Depth=3
	movslq	-12(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movq	%rax, %rdx
	subq	%rcx, %rdx
	movl	-1408(%rbp,%rdx,4), %ecx
	movl	%ecx, -1408(%rbp,%rax,4)
	movl	-12(%rbp), %eax
	subl	-40(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	-40(%rbp), %ecx
	decl	%ecx
	cmpl	%ecx, %eax
	jg	.LBB2_27
	jmp	.LBB2_29
	.p2align	4, 0x90
.LBB2_30:                               # %do.cond273
                                        #   in Loop: Header=BB2_24 Depth=1
	cmpl	$1, -40(%rbp)
	jne	.LBB2_24
# BB#31:                                # %do.end276
	movl	$0, -84(%rbp)
	movl	$0, -16(%rbp)
	movl	$-2097153, %ebx         # imm = 0xFFDFFFFF
	cmpl	$255, -16(%rbp)
	jle	.LBB2_33
	jmp	.LBB2_81
	.p2align	4, 0x90
.LBB2_80:                               # %for.inc506
                                        #   in Loop: Header=BB2_33 Depth=1
	incl	-16(%rbp)
	cmpl	$255, -16(%rbp)
	jg	.LBB2_81
.LBB2_33:                               # %for.body280
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB2_35 Depth 2
                                        #     Child Loop BB2_46 Depth 2
                                        #     Child Loop BB2_49 Depth 2
                                        #     Child Loop BB2_56 Depth 2
                                        #     Child Loop BB2_68 Depth 2
                                        #     Child Loop BB2_71 Depth 2
                                        #     Child Loop BB2_75 Depth 2
	movslq	-16(%rbp), %rax
	movl	-1408(%rbp,%rax,4), %eax
	movl	%eax, -24(%rbp)
	movl	$0, -12(%rbp)
	cmpl	$255, -12(%rbp)
	jle	.LBB2_35
	jmp	.LBB2_43
	.p2align	4, 0x90
.LBB2_42:                               # %for.inc326
                                        #   in Loop: Header=BB2_35 Depth=2
	incl	-12(%rbp)
	cmpl	$255, -12(%rbp)
	jg	.LBB2_43
.LBB2_35:                               # %for.body286
                                        #   Parent Loop BB2_33 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-12(%rbp), %eax
	cmpl	-24(%rbp), %eax
	je	.LBB2_42
# BB#36:                                # %if.then289
                                        #   in Loop: Header=BB2_35 Depth=2
	movl	-24(%rbp), %eax
	shll	$8, %eax
	addl	-12(%rbp), %eax
	movl	%eax, -88(%rbp)
	movq	-32(%rbp), %rax
	movslq	-88(%rbp), %rcx
	testb	$32, 2(%rax,%rcx,4)
	jne	.LBB2_41
# BB#37:                                # %if.then294
                                        #   in Loop: Header=BB2_35 Depth=2
	movq	-32(%rbp), %rax
	movslq	-88(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	andl	%ebx, %eax
	movl	%eax, -80(%rbp)
	movq	-32(%rbp), %rax
	movslq	-88(%rbp), %rcx
	movl	4(%rax,%rcx,4), %eax
	andl	%ebx, %eax
	decl	%eax
	movl	%eax, -104(%rbp)
	cmpl	-80(%rbp), %eax
	jle	.LBB2_41
# BB#38:                                # %if.then305
                                        #   in Loop: Header=BB2_35 Depth=2
	cmpl	$4, -92(%rbp)
	jl	.LBB2_40
# BB#39:                                # %if.then308
                                        #   in Loop: Header=BB2_35 Depth=2
	movq	stderr(%rip), %rdi
	movl	-24(%rbp), %edx
	movl	-12(%rbp), %ecx
	movl	-84(%rbp), %r8d
	movl	-104(%rbp), %r9d
	subl	-80(%rbp), %r9d
	incl	%r9d
	movl	$.L.str.53, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB2_40:                               # %if.end312
                                        #   in Loop: Header=BB2_35 Depth=2
	movq	-64(%rbp), %rdi
	movq	-48(%rbp), %rsi
	movq	-72(%rbp), %rdx
	movl	-36(%rbp), %ecx
	movl	-80(%rbp), %r8d
	movl	-104(%rbp), %r9d
	pushq	-128(%rbp)
	pushq	$2
	callq	mainQSort3
	addq	$16, %rsp
	movl	-104(%rbp), %eax
	subl	-80(%rbp), %eax
	movl	-84(%rbp), %ecx
	leal	1(%rcx,%rax), %eax
	movl	%eax, -84(%rbp)
	movq	-128(%rbp), %rax
	cmpl	$0, (%rax)
	js	.LBB2_83
.LBB2_41:                               # %if.end321
                                        #   in Loop: Header=BB2_35 Depth=2
	movq	-32(%rbp), %rax
	movslq	-88(%rbp), %rcx
	orl	$2097152, (%rax,%rcx,4) # imm = 0x200000
	jmp	.LBB2_42
	.p2align	4, 0x90
.LBB2_43:                               # %for.end328
                                        #   in Loop: Header=BB2_33 Depth=1
	movslq	-24(%rbp), %rax
	cmpb	$0, -384(%rbp,%rax)
	je	.LBB2_45
# BB#44:                                # %if.then332
                                        #   in Loop: Header=BB2_33 Depth=1
	movl	$1006, %edi             # imm = 0x3EE
	callq	BZ2_bz__AssertH__fail
.LBB2_45:                               # %if.end333
                                        #   in Loop: Header=BB2_33 Depth=1
	movl	$0, -12(%rbp)
	jmp	.LBB2_46
	.p2align	4, 0x90
.LBB2_47:                               # %for.body337
                                        #   in Loop: Header=BB2_46 Depth=2
	movslq	-12(%rbp), %rcx
	movl	%ecx, %edx
	shll	$8, %edx
	movslq	-24(%rbp), %rsi
	movslq	%edx, %rdx
	addq	%rsi, %rdx
	movl	(%rax,%rdx,4), %eax
	andl	%ebx, %eax
	movl	%eax, -3456(%rbp,%rcx,4)
	movq	-32(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movl	%ecx, %edx
	shll	$8, %edx
	movslq	-24(%rbp), %rsi
	movslq	%edx, %rdx
	addq	%rsi, %rdx
	movl	4(%rax,%rdx,4), %eax
	andl	%ebx, %eax
	decl	%eax
	movl	%eax, -2432(%rbp,%rcx,4)
	incl	-12(%rbp)
.LBB2_46:                               # %for.cond334
                                        #   Parent Loop BB2_33 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-32(%rbp), %rax
	cmpl	$255, -12(%rbp)
	jle	.LBB2_47
# BB#48:                                # %for.end356
                                        #   in Loop: Header=BB2_33 Depth=1
	movl	-24(%rbp), %ecx
	shll	$8, %ecx
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %eax
	andl	%ebx, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB2_49
	.p2align	4, 0x90
.LBB2_54:                               # %for.inc387
                                        #   in Loop: Header=BB2_49 Depth=2
	incl	-12(%rbp)
.LBB2_49:                               # %for.cond361
                                        #   Parent Loop BB2_33 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-12(%rbp), %eax
	movslq	-24(%rbp), %rcx
	cmpl	-3456(%rbp,%rcx,4), %eax
	jge	.LBB2_55
# BB#50:                                # %for.body366
                                        #   in Loop: Header=BB2_49 Depth=2
	movq	-64(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	decl	%eax
	movl	%eax, -52(%rbp)
	jns	.LBB2_52
# BB#51:                                # %if.then372
                                        #   in Loop: Header=BB2_49 Depth=2
	movl	-36(%rbp), %eax
	addl	%eax, -52(%rbp)
.LBB2_52:                               # %if.end374
                                        #   in Loop: Header=BB2_49 Depth=2
	movq	-48(%rbp), %rax
	movslq	-52(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -19(%rbp)
	movzbl	-19(%rbp), %eax
	cmpb	$0, -384(%rbp,%rax)
	jne	.LBB2_54
# BB#53:                                # %if.then380
                                        #   in Loop: Header=BB2_49 Depth=2
	movl	-52(%rbp), %eax
	movq	-64(%rbp), %rcx
	movzbl	-19(%rbp), %edx
	movslq	-3456(%rbp,%rdx,4), %rsi
	leal	1(%rsi), %edi
	movl	%edi, -3456(%rbp,%rdx,4)
	movl	%eax, (%rcx,%rsi,4)
	jmp	.LBB2_54
	.p2align	4, 0x90
.LBB2_55:                               # %for.end389
                                        #   in Loop: Header=BB2_33 Depth=1
	movq	-32(%rbp), %rax
	movl	-24(%rbp), %ecx
	shll	$8, %ecx
	addl	$256, %ecx              # imm = 0x100
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %eax
	andl	%ebx, %eax
	decl	%eax
	movl	%eax, -12(%rbp)
	jmp	.LBB2_56
	.p2align	4, 0x90
.LBB2_61:                               # %for.inc422
                                        #   in Loop: Header=BB2_56 Depth=2
	decl	-12(%rbp)
.LBB2_56:                               # %for.cond396
                                        #   Parent Loop BB2_33 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-12(%rbp), %eax
	movslq	-24(%rbp), %rcx
	cmpl	-2432(%rbp,%rcx,4), %eax
	jle	.LBB2_62
# BB#57:                                # %for.body401
                                        #   in Loop: Header=BB2_56 Depth=2
	movq	-64(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	decl	%eax
	movl	%eax, -52(%rbp)
	jns	.LBB2_59
# BB#58:                                # %if.then407
                                        #   in Loop: Header=BB2_56 Depth=2
	movl	-36(%rbp), %eax
	addl	%eax, -52(%rbp)
.LBB2_59:                               # %if.end409
                                        #   in Loop: Header=BB2_56 Depth=2
	movq	-48(%rbp), %rax
	movslq	-52(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -19(%rbp)
	movzbl	-19(%rbp), %eax
	cmpb	$0, -384(%rbp,%rax)
	jne	.LBB2_61
# BB#60:                                # %if.then415
                                        #   in Loop: Header=BB2_56 Depth=2
	movl	-52(%rbp), %eax
	movq	-64(%rbp), %rcx
	movzbl	-19(%rbp), %edx
	movslq	-2432(%rbp,%rdx,4), %rsi
	leal	-1(%rsi), %edi
	movl	%edi, -2432(%rbp,%rdx,4)
	movl	%eax, (%rcx,%rsi,4)
	jmp	.LBB2_61
	.p2align	4, 0x90
.LBB2_62:                               # %for.end424
                                        #   in Loop: Header=BB2_33 Depth=1
	movslq	-24(%rbp), %rax
	movl	-3456(%rbp,%rax,4), %ecx
	decl	%ecx
	cmpl	-2432(%rbp,%rax,4), %ecx
	je	.LBB2_66
# BB#63:                                # %lor.lhs.false
                                        #   in Loop: Header=BB2_33 Depth=1
	movslq	-24(%rbp), %rax
	cmpl	$0, -3456(%rbp,%rax,4)
	jne	.LBB2_65
# BB#64:                                # %land.lhs.true
                                        #   in Loop: Header=BB2_33 Depth=1
	movslq	-24(%rbp), %rax
	movl	-36(%rbp), %ecx
	decl	%ecx
	cmpl	%ecx, -2432(%rbp,%rax,4)
	je	.LBB2_66
.LBB2_65:                               # %if.then441
                                        #   in Loop: Header=BB2_33 Depth=1
	movl	$1007, %edi             # imm = 0x3EF
	callq	BZ2_bz__AssertH__fail
.LBB2_66:                               # %if.end442
                                        #   in Loop: Header=BB2_33 Depth=1
	movl	$0, -12(%rbp)
	cmpl	$255, -12(%rbp)
	jg	.LBB2_69
	.p2align	4, 0x90
.LBB2_68:                               # %for.body446
                                        #   Parent Loop BB2_33 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-32(%rbp), %rax
	movl	-12(%rbp), %ecx
	shll	$8, %ecx
	movslq	-24(%rbp), %rdx
	movslq	%ecx, %rcx
	addq	%rdx, %rcx
	orl	$2097152, (%rax,%rcx,4) # imm = 0x200000
	incl	-12(%rbp)
	cmpl	$255, -12(%rbp)
	jle	.LBB2_68
.LBB2_69:                               # %for.end454
                                        #   in Loop: Header=BB2_33 Depth=1
	movslq	-24(%rbp), %rax
	movb	$1, -384(%rbp,%rax)
	cmpl	$254, -16(%rbp)
	jg	.LBB2_80
# BB#70:                                # %if.then459
                                        #   in Loop: Header=BB2_33 Depth=1
	movq	-32(%rbp), %rax
	movl	-24(%rbp), %ecx
	shll	$8, %ecx
	movslq	%ecx, %rcx
	movl	(%rax,%rcx,4), %eax
	andl	%ebx, %eax
	movl	%eax, -116(%rbp)
	movq	-32(%rbp), %rcx
	movl	-24(%rbp), %edx
	shll	$8, %edx
	addl	$256, %edx              # imm = 0x100
	movslq	%edx, %rdx
	movl	(%rcx,%rdx,4), %ecx
	andl	%ebx, %ecx
	subl	%eax, %ecx
	movl	%ecx, -100(%rbp)
	movl	$0, -76(%rbp)
	jmp	.LBB2_71
	.p2align	4, 0x90
.LBB2_72:                               # %while.body474
                                        #   in Loop: Header=BB2_71 Depth=2
	incl	-76(%rbp)
.LBB2_71:                               # %while.cond470
                                        #   Parent Loop BB2_33 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-100(%rbp), %eax
	movzbl	-76(%rbp), %ecx
	sarl	%cl, %eax
	cmpl	$65535, %eax            # imm = 0xFFFF
	jge	.LBB2_72
# BB#73:                                # %while.end476
                                        #   in Loop: Header=BB2_33 Depth=1
	movl	-100(%rbp), %eax
	decl	%eax
	movl	%eax, -12(%rbp)
	cmpl	$0, -12(%rbp)
	jns	.LBB2_75
	jmp	.LBB2_78
	.p2align	4, 0x90
.LBB2_77:                               # %for.inc496
                                        #   in Loop: Header=BB2_75 Depth=2
	decl	-12(%rbp)
	cmpl	$0, -12(%rbp)
	js	.LBB2_78
.LBB2_75:                               # %for.body481
                                        #   Parent Loop BB2_33 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-64(%rbp), %rax
	movslq	-116(%rbp), %rcx
	movslq	-12(%rbp), %rdx
	addq	%rcx, %rdx
	movl	(%rax,%rdx,4), %eax
	movl	%eax, -96(%rbp)
	movl	-12(%rbp), %eax
	movzbl	-76(%rbp), %ecx
	sarl	%cl, %eax
	movw	%ax, -106(%rbp)
	movq	-72(%rbp), %rcx
	movslq	-96(%rbp), %rdx
	movw	%ax, (%rcx,%rdx,2)
	cmpl	$33, -96(%rbp)
	jg	.LBB2_77
# BB#76:                                # %if.then491
                                        #   in Loop: Header=BB2_75 Depth=2
	movzwl	-106(%rbp), %eax
	movq	-72(%rbp), %rcx
	movslq	-96(%rbp), %rdx
	movslq	-36(%rbp), %rsi
	addq	%rdx, %rsi
	movw	%ax, (%rcx,%rsi,2)
	jmp	.LBB2_77
	.p2align	4, 0x90
.LBB2_78:                               # %for.end498
                                        #   in Loop: Header=BB2_33 Depth=1
	movl	-100(%rbp), %eax
	decl	%eax
	movb	-76(%rbp), %cl
	sarl	%cl, %eax
	cmpl	$65536, %eax            # imm = 0x10000
	jl	.LBB2_80
# BB#79:                                # %if.then503
                                        #   in Loop: Header=BB2_33 Depth=1
	movl	$1002, %edi             # imm = 0x3EA
	callq	BZ2_bz__AssertH__fail
	jmp	.LBB2_80
.LBB2_81:                               # %for.end508
	cmpl	$4, -92(%rbp)
	jl	.LBB2_83
# BB#82:                                # %if.then511
	movq	stderr(%rip), %rdi
	movl	-36(%rbp), %edx
	movl	-84(%rbp), %ecx
	movl	%edx, %r8d
	subl	%ecx, %r8d
	movl	$.L.str.54, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB2_83:                               # %if.end514
	addq	$3448, %rsp             # imm = 0xD78
	popq	%rbx
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
.Lcfi10:
	.cfi_def_cfa_offset 16
.Lcfi11:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi12:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$16, %rsp
.Lcfi13:
	.cfi_offset %rbx, -32
.Lcfi14:
	.cfi_offset %r14, -24
	movl	%edi, %ebx
	movl	%ebx, -20(%rbp)
	movq	stderr(%rip), %r14
	callq	BZ2_bzlibVersion
	movq	%rax, %rcx
	movl	$.L.str.6, %esi
	xorl	%eax, %eax
	movq	%r14, %rdi
	movl	%ebx, %edx
	callq	fprintf
	cmpl	$1007, -20(%rbp)        # imm = 0x3EF
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
.Lcfi15:
	.cfi_def_cfa_offset 16
.Lcfi16:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi17:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$5304, %rsp             # imm = 0x14B8
.Lcfi18:
	.cfi_offset %rbx, -24
	movq	%rdi, -120(%rbp)
	movq	%rsi, -112(%rbp)
	movl	%edx, -48(%rbp)
	movl	%ecx, -100(%rbp)
	movl	$0, -12(%rbp)
	jmp	.LBB4_1
	.p2align	4, 0x90
.LBB4_51:                               # %cond.end17
                                        #   in Loop: Header=BB4_1 Depth=1
	movl	-72(%rbp), %eax
	shll	$8, %eax
	movslq	-12(%rbp), %rcx
	movl	%eax, -3244(%rbp,%rcx,4)
	incl	-12(%rbp)
.LBB4_1:                                # %for.cond1
                                        # =>This Inner Loop Header: Depth=1
	movl	-12(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jge	.LBB4_2
# BB#48:                                # %for.body3
                                        #   in Loop: Header=BB4_1 Depth=1
	movq	-112(%rbp), %rax
	movslq	-12(%rbp), %rcx
	cmpl	$0, (%rax,%rcx,4)
	je	.LBB4_49
# BB#50:                                # %cond.false12
                                        #   in Loop: Header=BB4_1 Depth=1
	movq	-112(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -124(%rbp)
	movl	%eax, -72(%rbp)
	jmp	.LBB4_51
	.p2align	4, 0x90
.LBB4_49:                               # %cond.true11
                                        #   in Loop: Header=BB4_1 Depth=1
	movl	$1, -72(%rbp)
	jmp	.LBB4_51
.LBB4_2:
	movl	$-256, %ebx
	jmp	.LBB4_3
	.p2align	4, 0x90
.LBB4_44:                               # %if.end227
                                        #   in Loop: Header=BB4_3 Depth=1
	movl	$1, -12(%rbp)
	jmp	.LBB4_45
	.p2align	4, 0x90
.LBB4_46:                               # %for.body231
                                        #   in Loop: Header=BB4_45 Depth=2
	movslq	-12(%rbp), %rax
	movl	-3248(%rbp,%rax,4), %eax
	movl	%eax, %ecx
	sarl	$8, %ecx
	movl	%ecx, -44(%rbp)
	shrl	$31, %eax
	addl	%ecx, %eax
	sarl	%eax
	incl	%eax
	movl	%eax, -44(%rbp)
	shll	$8, %eax
	movslq	-12(%rbp), %rcx
	movl	%eax, -3248(%rbp,%rcx,4)
	incl	-12(%rbp)
.LBB4_45:                               # %for.cond228
                                        #   Parent Loop BB4_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-12(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jl	.LBB4_46
.LBB4_3:                                # %while.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB4_4 Depth 2
                                        #       Child Loop BB4_6 Depth 3
                                        #     Child Loop BB4_36 Depth 2
                                        #       Child Loop BB4_38 Depth 3
                                        #     Child Loop BB4_45 Depth 2
                                        #     Child Loop BB4_13 Depth 2
                                        #     Child Loop BB4_20 Depth 2
                                        #     Child Loop BB4_30 Depth 2
	movl	-48(%rbp), %eax
	movl	%eax, -32(%rbp)
	movl	$0, -16(%rbp)
	movl	$0, -1184(%rbp)
	movl	$0, -3248(%rbp)
	movl	$-2, -5312(%rbp)
	movl	$1, -12(%rbp)
	jmp	.LBB4_4
	.p2align	4, 0x90
.LBB4_8:                                # %while.end
                                        #   in Loop: Header=BB4_4 Depth=2
	movl	-92(%rbp), %eax
	movslq	-40(%rbp), %rcx
	movl	%eax, -1184(%rbp,%rcx,4)
	incl	-12(%rbp)
.LBB4_4:                                # %for.cond9
                                        #   Parent Loop BB4_3 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB4_6 Depth 3
	movl	-12(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jg	.LBB4_9
# BB#5:                                 # %for.body11
                                        #   in Loop: Header=BB4_4 Depth=2
	movslq	-12(%rbp), %rax
	movl	$-1, -5312(%rbp,%rax,4)
	incl	-16(%rbp)
	movl	-12(%rbp), %eax
	movslq	-16(%rbp), %rcx
	movl	%eax, -1184(%rbp,%rcx,4)
	movl	-16(%rbp), %eax
	movl	%eax, -40(%rbp)
	movslq	-40(%rbp), %rax
	movl	-1184(%rbp,%rax,4), %eax
	movl	%eax, -92(%rbp)
	jmp	.LBB4_6
	.p2align	4, 0x90
.LBB4_7:                                # %while.body27
                                        #   in Loop: Header=BB4_6 Depth=3
	movslq	-40(%rbp), %rax
	movl	%eax, %ecx
	sarl	%ecx
	movslq	%ecx, %rcx
	movl	-1184(%rbp,%rcx,4), %ecx
	movl	%ecx, -1184(%rbp,%rax,4)
	sarl	-40(%rbp)
.LBB4_6:                                # %while.cond19
                                        #   Parent Loop BB4_3 Depth=1
                                        #     Parent Loop BB4_4 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movslq	-92(%rbp), %rax
	movl	-3248(%rbp,%rax,4), %eax
	movl	-40(%rbp), %ecx
	sarl	%ecx
	movslq	%ecx, %rcx
	movslq	-1184(%rbp,%rcx,4), %rcx
	cmpl	-3248(%rbp,%rcx,4), %eax
	jl	.LBB4_7
	jmp	.LBB4_8
	.p2align	4, 0x90
.LBB4_9:                                # %for.end38
                                        #   in Loop: Header=BB4_3 Depth=1
	cmpl	$260, -16(%rbp)         # imm = 0x104
	jl	.LBB4_11
# BB#10:                                # %if.then
                                        #   in Loop: Header=BB4_3 Depth=1
	movl	$2001, %edi             # imm = 0x7D1
	callq	BZ2_bz__AssertH__fail
	cmpl	$2, -16(%rbp)
	jge	.LBB4_12
	jmp	.LBB4_33
	.p2align	4, 0x90
.LBB4_32:                               # %while.end198
                                        #   in Loop: Header=BB4_3 Depth=1
	movl	-80(%rbp), %eax
	movslq	-36(%rbp), %rcx
	movl	%eax, -1184(%rbp,%rcx,4)
.LBB4_11:                               # %while.cond40
                                        #   in Loop: Header=BB4_3 Depth=1
	cmpl	$2, -16(%rbp)
	jl	.LBB4_33
.LBB4_12:                               # %while.body42
                                        #   in Loop: Header=BB4_3 Depth=1
	movl	-1180(%rbp), %eax
	movl	%eax, -64(%rbp)
	movslq	-16(%rbp), %rax
	movl	-1184(%rbp,%rax,4), %eax
	decl	-16(%rbp)
	movl	%eax, -1180(%rbp)
	movl	$1, -56(%rbp)
	movl	-1180(%rbp), %eax
	movl	%eax, -88(%rbp)
	jmp	.LBB4_13
	.p2align	4, 0x90
.LBB4_18:                               # %if.end82
                                        #   in Loop: Header=BB4_13 Depth=2
	movslq	-28(%rbp), %rax
	movl	-1184(%rbp,%rax,4), %eax
	movslq	-56(%rbp), %rcx
	movl	%eax, -1184(%rbp,%rcx,4)
	movl	-28(%rbp), %eax
	movl	%eax, -56(%rbp)
.LBB4_13:                               # %while.body55
                                        #   Parent Loop BB4_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-56(%rbp), %eax
	addl	%eax, %eax
	movl	%eax, -28(%rbp)
	cmpl	-16(%rbp), %eax
	jg	.LBB4_19
# BB#14:                                # %if.end59
                                        #   in Loop: Header=BB4_13 Depth=2
	movl	-28(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB4_17
# BB#15:                                # %land.lhs.true
                                        #   in Loop: Header=BB4_13 Depth=2
	movslq	-28(%rbp), %rax
	movslq	-1180(%rbp,%rax,4), %rcx
	movl	-3248(%rbp,%rcx,4), %ecx
	movslq	-1184(%rbp,%rax,4), %rax
	cmpl	-3248(%rbp,%rax,4), %ecx
	jge	.LBB4_17
# BB#16:                                # %if.then71
                                        #   in Loop: Header=BB4_13 Depth=2
	incl	-28(%rbp)
.LBB4_17:                               # %if.end73
                                        #   in Loop: Header=BB4_13 Depth=2
	movslq	-88(%rbp), %rax
	movl	-3248(%rbp,%rax,4), %eax
	movslq	-28(%rbp), %rcx
	movslq	-1184(%rbp,%rcx,4), %rcx
	cmpl	-3248(%rbp,%rcx,4), %eax
	jge	.LBB4_18
.LBB4_19:                               # %while.end87
                                        #   in Loop: Header=BB4_3 Depth=1
	movl	-88(%rbp), %eax
	movslq	-56(%rbp), %rcx
	movl	%eax, -1184(%rbp,%rcx,4)
	movl	-1180(%rbp), %eax
	movl	%eax, -60(%rbp)
	movslq	-16(%rbp), %rax
	movl	-1184(%rbp,%rax,4), %eax
	decl	-16(%rbp)
	movl	%eax, -1180(%rbp)
	movl	$1, -52(%rbp)
	movl	-1180(%rbp), %eax
	movl	%eax, -84(%rbp)
	jmp	.LBB4_20
	.p2align	4, 0x90
.LBB4_25:                               # %if.end132
                                        #   in Loop: Header=BB4_20 Depth=2
	movslq	-24(%rbp), %rax
	movl	-1184(%rbp,%rax,4), %eax
	movslq	-52(%rbp), %rcx
	movl	%eax, -1184(%rbp,%rcx,4)
	movl	-24(%rbp), %eax
	movl	%eax, -52(%rbp)
.LBB4_20:                               # %while.body104
                                        #   Parent Loop BB4_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-52(%rbp), %eax
	addl	%eax, %eax
	movl	%eax, -24(%rbp)
	cmpl	-16(%rbp), %eax
	jg	.LBB4_26
# BB#21:                                # %if.end108
                                        #   in Loop: Header=BB4_20 Depth=2
	movl	-24(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB4_24
# BB#22:                                # %land.lhs.true110
                                        #   in Loop: Header=BB4_20 Depth=2
	movslq	-24(%rbp), %rax
	movslq	-1180(%rbp,%rax,4), %rcx
	movl	-3248(%rbp,%rcx,4), %ecx
	movslq	-1184(%rbp,%rax,4), %rax
	cmpl	-3248(%rbp,%rax,4), %ecx
	jge	.LBB4_24
# BB#23:                                # %if.then121
                                        #   in Loop: Header=BB4_20 Depth=2
	incl	-24(%rbp)
.LBB4_24:                               # %if.end123
                                        #   in Loop: Header=BB4_20 Depth=2
	movslq	-84(%rbp), %rax
	movl	-3248(%rbp,%rax,4), %eax
	movslq	-24(%rbp), %rcx
	movslq	-1184(%rbp,%rcx,4), %rcx
	cmpl	-3248(%rbp,%rcx,4), %eax
	jge	.LBB4_25
.LBB4_26:                               # %while.end137
                                        #   in Loop: Header=BB4_3 Depth=1
	movl	-84(%rbp), %eax
	movslq	-52(%rbp), %rcx
	movl	%eax, -1184(%rbp,%rcx,4)
	movl	-32(%rbp), %eax
	incl	%eax
	movl	%eax, -32(%rbp)
	movslq	-60(%rbp), %rcx
	movl	%eax, -5312(%rbp,%rcx,4)
	movslq	-64(%rbp), %rcx
	movl	%eax, -5312(%rbp,%rcx,4)
	movslq	-64(%rbp), %rax
	movl	-3248(%rbp,%rax,4), %eax
	andl	%ebx, %eax
	movslq	-60(%rbp), %rcx
	movl	-3248(%rbp,%rcx,4), %ecx
	andl	%ebx, %ecx
	addl	%eax, %ecx
	movl	%ecx, -96(%rbp)
	movslq	-64(%rbp), %rax
	movzbl	-3248(%rbp,%rax,4), %eax
	movslq	-60(%rbp), %rcx
	movzbl	-3248(%rbp,%rcx,4), %ecx
	cmpl	%ecx, %eax
	jle	.LBB4_28
# BB#27:                                # %cond.true158
                                        #   in Loop: Header=BB4_3 Depth=1
	movslq	-64(%rbp), %rax
	movzbl	-3248(%rbp,%rax,4), %eax
	movl	%eax, -128(%rbp)
	jmp	.LBB4_29
	.p2align	4, 0x90
.LBB4_28:                               # %cond.false162
                                        #   in Loop: Header=BB4_3 Depth=1
	movslq	-60(%rbp), %rax
	movzbl	-3248(%rbp,%rax,4), %eax
	movl	%eax, -132(%rbp)
.LBB4_29:                               # %cond.end166
                                        #   in Loop: Header=BB4_3 Depth=1
	movl	%eax, -76(%rbp)
	movl	-76(%rbp), %eax
	incl	%eax
	orl	-96(%rbp), %eax
	movslq	-32(%rbp), %rcx
	movl	%eax, -3248(%rbp,%rcx,4)
	movslq	-32(%rbp), %rax
	movl	$-1, -5312(%rbp,%rax,4)
	incl	-16(%rbp)
	movl	-32(%rbp), %eax
	movslq	-16(%rbp), %rcx
	movl	%eax, -1184(%rbp,%rcx,4)
	movl	-16(%rbp), %eax
	movl	%eax, -36(%rbp)
	movslq	-36(%rbp), %rax
	movl	-1184(%rbp,%rax,4), %eax
	movl	%eax, -80(%rbp)
	jmp	.LBB4_30
	.p2align	4, 0x90
.LBB4_31:                               # %while.body191
                                        #   in Loop: Header=BB4_30 Depth=2
	movslq	-36(%rbp), %rax
	movl	%eax, %ecx
	sarl	%ecx
	movslq	%ecx, %rcx
	movl	-1184(%rbp,%rcx,4), %ecx
	movl	%ecx, -1184(%rbp,%rax,4)
	sarl	-36(%rbp)
.LBB4_30:                               # %while.cond182
                                        #   Parent Loop BB4_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	-80(%rbp), %rax
	movl	-3248(%rbp,%rax,4), %eax
	movl	-36(%rbp), %ecx
	sarl	%ecx
	movslq	%ecx, %rcx
	movslq	-1184(%rbp,%rcx,4), %rcx
	cmpl	-3248(%rbp,%rcx,4), %eax
	jl	.LBB4_31
	jmp	.LBB4_32
	.p2align	4, 0x90
.LBB4_33:                               # %while.end201
                                        #   in Loop: Header=BB4_3 Depth=1
	cmpl	$516, -32(%rbp)         # imm = 0x204
	jl	.LBB4_35
# BB#34:                                # %if.then203
                                        #   in Loop: Header=BB4_3 Depth=1
	movl	$2002, %edi             # imm = 0x7D2
	callq	BZ2_bz__AssertH__fail
.LBB4_35:                               # %if.end204
                                        #   in Loop: Header=BB4_3 Depth=1
	movb	$0, -17(%rbp)
	movl	$1, -12(%rbp)
	jmp	.LBB4_36
	.p2align	4, 0x90
.LBB4_42:                               # %for.inc223
                                        #   in Loop: Header=BB4_36 Depth=2
	incl	-12(%rbp)
.LBB4_36:                               # %for.cond205
                                        #   Parent Loop BB4_3 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB4_38 Depth 3
	movl	-12(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jg	.LBB4_43
# BB#37:                                # %for.body207
                                        #   in Loop: Header=BB4_36 Depth=2
	movl	$0, -44(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -68(%rbp)
	jmp	.LBB4_38
	.p2align	4, 0x90
.LBB4_39:                               # %while.body212
                                        #   in Loop: Header=BB4_38 Depth=3
	movslq	-68(%rbp), %rax
	movl	-5312(%rbp,%rax,4), %eax
	movl	%eax, -68(%rbp)
	incl	-44(%rbp)
.LBB4_38:                               # %while.cond208
                                        #   Parent Loop BB4_3 Depth=1
                                        #     Parent Loop BB4_36 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movslq	-68(%rbp), %rax
	cmpl	$0, -5312(%rbp,%rax,4)
	jns	.LBB4_39
# BB#40:                                # %while.end216
                                        #   in Loop: Header=BB4_36 Depth=2
	movb	-44(%rbp), %al
	movq	-120(%rbp), %rcx
	movslq	-12(%rbp), %rdx
	movb	%al, -1(%rcx,%rdx)
	movl	-44(%rbp), %eax
	cmpl	-100(%rbp), %eax
	jle	.LBB4_42
# BB#41:                                # %if.then221
                                        #   in Loop: Header=BB4_36 Depth=2
	movb	$1, -17(%rbp)
	jmp	.LBB4_42
	.p2align	4, 0x90
.LBB4_43:                               # %for.end225
                                        #   in Loop: Header=BB4_3 Depth=1
	cmpb	$0, -17(%rbp)
	jne	.LBB4_44
# BB#47:                                # %while.end242
	addq	$5304, %rsp             # imm = 0x14B8
	popq	%rbx
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
.Lcfi19:
	.cfi_def_cfa_offset 16
.Lcfi20:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi21:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -24(%rbp)
	movl	%ecx, -20(%rbp)
	movl	%r8d, -16(%rbp)
	movl	$0, -8(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB5_1
	.p2align	4, 0x90
.LBB5_8:                                # %for.end12
                                        #   in Loop: Header=BB5_1 Depth=1
	shll	-8(%rbp)
	incl	-12(%rbp)
.LBB5_1:                                # %for.cond2
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB5_3 Depth 2
	movl	-12(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jg	.LBB5_7
# BB#2:                                 # %for.body4
                                        #   in Loop: Header=BB5_1 Depth=1
	movl	$0, -4(%rbp)
	jmp	.LBB5_3
	.p2align	4, 0x90
.LBB5_6:                                # %for.inc22
                                        #   in Loop: Header=BB5_3 Depth=2
	incl	-4(%rbp)
.LBB5_3:                                # %for.cond15
                                        #   Parent Loop BB5_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-4(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB5_8
# BB#4:                                 # %for.body37
                                        #   in Loop: Header=BB5_3 Depth=2
	movq	-32(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	-12(%rbp), %eax
	jne	.LBB5_6
# BB#5:                                 # %if.then14
                                        #   in Loop: Header=BB5_3 Depth=2
	movl	-8(%rbp), %eax
	movq	-40(%rbp), %rcx
	movslq	-4(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	-8(%rbp)
	jmp	.LBB5_6
.LBB5_7:                                # %for.end11
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
.Lcfi22:
	.cfi_def_cfa_offset 16
.Lcfi23:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi24:
	.cfi_def_cfa_register %rbp
	movl	16(%rbp), %eax
	movq	%rdi, -48(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -64(%rbp)
	movq	%rcx, -56(%rbp)
	movl	%r8d, -20(%rbp)
	movl	%r9d, -16(%rbp)
	movl	%eax, -40(%rbp)
	movl	$0, -36(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB6_1
	.p2align	4, 0x90
.LBB6_7:                                # %for.inc9
                                        #   in Loop: Header=BB6_1 Depth=1
	incl	-4(%rbp)
.LBB6_1:                                # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB6_3 Depth 2
	movl	-4(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jg	.LBB6_21
# BB#2:                                 # %for.body
                                        #   in Loop: Header=BB6_1 Depth=1
	movl	$0, -8(%rbp)
	jmp	.LBB6_3
	.p2align	4, 0x90
.LBB6_6:                                # %for.inc
                                        #   in Loop: Header=BB6_3 Depth=2
	incl	-8(%rbp)
.LBB6_3:                                # %for.cond1
                                        #   Parent Loop BB6_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-8(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jge	.LBB6_7
# BB#4:                                 # %for.body3
                                        #   in Loop: Header=BB6_3 Depth=2
	movq	-56(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	cmpl	-4(%rbp), %eax
	jne	.LBB6_6
# BB#5:                                 # %if.then
                                        #   in Loop: Header=BB6_3 Depth=2
	movl	-8(%rbp), %eax
	movq	-64(%rbp), %rcx
	movslq	-36(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	-36(%rbp)
	jmp	.LBB6_6
.LBB6_21:                               # %for.end11
	movl	$0, -4(%rbp)
	cmpl	$22, -4(%rbp)
	jg	.LBB6_24
	.p2align	4, 0x90
.LBB6_23:                               # %for.body153
                                        # =>This Inner Loop Header: Depth=1
	movq	-32(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movl	$0, (%rax,%rcx,4)
	incl	-4(%rbp)
	cmpl	$22, -4(%rbp)
	jle	.LBB6_23
.LBB6_24:                               # %for.end20
	movl	$0, -4(%rbp)
	jmp	.LBB6_25
	.p2align	4, 0x90
.LBB6_26:                               # %for.body2410
                                        #   in Loop: Header=BB6_25 Depth=1
	movq	-32(%rbp), %rax
	movq	-56(%rbp), %rcx
	movslq	-4(%rbp), %rdx
	movzbl	(%rcx,%rdx), %ecx
	incl	4(%rax,%rcx,4)
	incl	-4(%rbp)
.LBB6_25:                               # %for.cond218
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jl	.LBB6_26
# BB#8:                                 # %for.end33
	movl	$1, -4(%rbp)
	cmpl	$22, -4(%rbp)
	jg	.LBB6_11
	.p2align	4, 0x90
.LBB6_10:                               # %for.body37
                                        # =>This Inner Loop Header: Depth=1
	movq	-32(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movl	-4(%rax,%rcx,4), %edx
	addl	%edx, (%rax,%rcx,4)
	incl	-4(%rbp)
	cmpl	$22, -4(%rbp)
	jle	.LBB6_10
.LBB6_11:                               # %for.end45
	movl	$0, -4(%rbp)
	cmpl	$22, -4(%rbp)
	jg	.LBB6_14
	.p2align	4, 0x90
.LBB6_13:                               # %for.body49
                                        # =>This Inner Loop Header: Depth=1
	movq	-48(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movl	$0, (%rax,%rcx,4)
	incl	-4(%rbp)
	cmpl	$22, -4(%rbp)
	jle	.LBB6_13
.LBB6_14:                               # %for.end54
	movl	$0, -12(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB6_15
	.p2align	4, 0x90
.LBB6_16:                               # %for.body58
                                        #   in Loop: Header=BB6_15 Depth=1
	movq	-32(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movl	4(%rax,%rcx,4), %edx
	subl	(%rax,%rcx,4), %edx
	movl	-12(%rbp), %eax
	leal	(%rax,%rdx), %ecx
	movl	%ecx, -12(%rbp)
	leal	-1(%rax,%rdx), %eax
	movq	-48(%rbp), %rcx
	movslq	-4(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	shll	-12(%rbp)
	incl	-4(%rbp)
.LBB6_15:                               # %for.cond55
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jle	.LBB6_16
# BB#17:                                # %for.end71
	movl	-20(%rbp), %eax
	incl	%eax
	movl	%eax, -4(%rbp)
	jmp	.LBB6_18
	.p2align	4, 0x90
.LBB6_19:                               # %for.body76
                                        #   in Loop: Header=BB6_18 Depth=1
	movq	-48(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movl	-4(%rax,%rcx,4), %eax
	leal	2(%rax,%rax), %eax
	movq	-32(%rbp), %rdx
	subl	(%rdx,%rcx,4), %eax
	movl	%eax, (%rdx,%rcx,4)
	incl	-4(%rbp)
.LBB6_18:                               # %for.cond73
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jle	.LBB6_19
# BB#20:                                # %for.end89
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
.Lcfi25:
	.cfi_def_cfa_offset 16
.Lcfi26:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi27:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	$0, 644(%rdi)
	movq	-8(%rbp), %rax
	movl	$0, 640(%rax)
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
.Lcfi28:
	.cfi_def_cfa_offset 16
.Lcfi29:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi30:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movb	%sil, -9(%rbp)
	movq	-8(%rbp), %rax
	cmpl	$0, 108(%rax)
	jle	.LBB8_6
# BB#1:                                 # %if.then
	movq	-8(%rbp), %rax
	notl	648(%rax)
	movq	-8(%rbp), %rax
	roll	652(%rax)
	movq	-8(%rbp), %rax
	movl	648(%rax), %ecx
	xorl	%ecx, 652(%rax)
	movq	-8(%rbp), %rax
	cmpl	$2, 660(%rax)
	jl	.LBB8_3
# BB#2:                                 # %if.then7
	movq	-8(%rbp), %rax
	movl	$0, 116(%rax)
.LBB8_3:                                # %if.end
	movq	-8(%rbp), %rax
	cmpl	$2, 656(%rax)
	jl	.LBB8_5
# BB#4:                                 # %if.then9
	movq	stderr(%rip), %rdi
	movq	-8(%rbp), %rax
	movl	660(%rax), %edx
	movl	648(%rax), %ecx
	movl	652(%rax), %r8d
	movl	108(%rax), %r9d
	movl	$.L.str.2, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB8_5:                                # %if.end14
	movq	-8(%rbp), %rdi
	callq	BZ2_blockSort
.LBB8_6:                                # %if.end15
	movq	-8(%rbp), %rax
	movslq	108(%rax), %rcx
	addq	32(%rax), %rcx
	movq	%rcx, 80(%rax)
	movq	-8(%rbp), %rax
	cmpl	$1, 660(%rax)
	jne	.LBB8_8
# BB#7:                                 # %if.then19
	movq	-8(%rbp), %rdi
	callq	BZ2_bsInitWrite
	movq	-8(%rbp), %rdi
	movl	$66, %esi
	callq	bsPutUChar
	movq	-8(%rbp), %rdi
	movl	$90, %esi
	callq	bsPutUChar
	movq	-8(%rbp), %rdi
	movl	$104, %esi
	callq	bsPutUChar
	movq	-8(%rbp), %rdi
	movl	664(%rdi), %eax
	addl	$48, %eax
	movzbl	%al, %esi
	callq	bsPutUChar
.LBB8_8:                                # %if.end20
	movq	-8(%rbp), %rax
	cmpl	$0, 108(%rax)
	jle	.LBB8_10
# BB#9:                                 # %if.then24
	movq	-8(%rbp), %rdi
	movl	$49, %esi
	callq	bsPutUChar
	movq	-8(%rbp), %rdi
	movl	$65, %esi
	callq	bsPutUChar
	movq	-8(%rbp), %rdi
	movl	$89, %esi
	callq	bsPutUChar
	movq	-8(%rbp), %rdi
	movl	$38, %esi
	callq	bsPutUChar
	movq	-8(%rbp), %rdi
	movl	$83, %esi
	callq	bsPutUChar
	movq	-8(%rbp), %rdi
	movl	$89, %esi
	callq	bsPutUChar
	movq	-8(%rbp), %rdi
	movl	648(%rdi), %esi
	callq	bsPutUInt32
	movq	-8(%rbp), %rdi
	movl	$1, %esi
	xorl	%edx, %edx
	callq	bsW
	movq	-8(%rbp), %rdi
	movl	48(%rdi), %edx
	movl	$24, %esi
	callq	bsW
	movq	-8(%rbp), %rdi
	callq	generateMTFValues
	movq	-8(%rbp), %rdi
	callq	sendMTFValues
.LBB8_10:                               # %if.end26
	cmpb	$0, -9(%rbp)
	je	.LBB8_14
# BB#11:                                # %if.then27
	movq	-8(%rbp), %rdi
	movl	$23, %esi
	callq	bsPutUChar
	movq	-8(%rbp), %rdi
	movl	$114, %esi
	callq	bsPutUChar
	movq	-8(%rbp), %rdi
	movl	$69, %esi
	callq	bsPutUChar
	movq	-8(%rbp), %rdi
	movl	$56, %esi
	callq	bsPutUChar
	movq	-8(%rbp), %rdi
	movl	$80, %esi
	callq	bsPutUChar
	movq	-8(%rbp), %rdi
	movl	$144, %esi
	callq	bsPutUChar
	movq	-8(%rbp), %rdi
	movl	652(%rdi), %esi
	callq	bsPutUInt32
	movq	-8(%rbp), %rax
	cmpl	$2, 656(%rax)
	jl	.LBB8_13
# BB#12:                                # %if.then32
	movq	stderr(%rip), %rdi
	movq	-8(%rbp), %rax
	movl	652(%rax), %edx
	movl	$.L.str.3, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB8_13:                               # %if.end35
	movq	-8(%rbp), %rdi
	callq	bsFinishWrite
.LBB8_14:                               # %if.end36
	addq	$16, %rsp
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
.Lcfi31:
	.cfi_def_cfa_offset 16
.Lcfi32:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi33:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -16(%rbp)
	movb	%sil, -1(%rbp)
	movq	-16(%rbp), %rdi
	movzbl	-1(%rbp), %edx
	movl	$8, %esi
	callq	bsW
	addq	$16, %rsp
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
.Lcfi34:
	.cfi_def_cfa_offset 16
.Lcfi35:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi36:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -16(%rbp)
	movl	%esi, -4(%rbp)
	movq	-16(%rbp), %rdi
	movzbl	-1(%rbp), %edx
	movl	$8, %esi
	callq	bsW
	movq	-16(%rbp), %rdi
	movzbl	-2(%rbp), %edx
	movl	$8, %esi
	callq	bsW
	movq	-16(%rbp), %rdi
	movl	-4(%rbp), %eax
	movzbl	%ah, %edx  # NOREX
	movl	$8, %esi
	callq	bsW
	movq	-16(%rbp), %rdi
	movzbl	-4(%rbp), %edx
	movl	$8, %esi
	callq	bsW
	addq	$16, %rsp
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
.Lcfi37:
	.cfi_def_cfa_offset 16
.Lcfi38:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi39:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	jmp	.LBB11_1
	.p2align	4, 0x90
.LBB11_2:                               # %while.body
                                        #   in Loop: Header=BB11_1 Depth=1
	movq	-8(%rbp), %rax
	movzbl	643(%rax), %ecx
	movq	80(%rax), %rdx
	movslq	116(%rax), %rax
	movb	%cl, (%rdx,%rax)
	movq	-8(%rbp), %rax
	incl	116(%rax)
	movq	-8(%rbp), %rax
	shll	$8, 640(%rax)
	movq	-8(%rbp), %rax
	addl	$-8, 644(%rax)
.LBB11_1:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 644(%rax)
	jge	.LBB11_2
# BB#3:                                 # %while.end
	movl	-16(%rbp), %eax
	movq	-8(%rbp), %rdx
	movl	$32, %ecx
	subl	644(%rdx), %ecx
	subl	-12(%rbp), %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shll	%cl, %eax
	orl	%eax, 640(%rdx)
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	addl	%eax, 644(%rcx)
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
.Lcfi40:
	.cfi_def_cfa_offset 16
.Lcfi41:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi42:
	.cfi_def_cfa_register %rbp
	subq	$336, %rsp              # imm = 0x150
	movq	%rdi, -32(%rbp)
	movq	56(%rdi), %rax
	movq	%rax, -80(%rbp)
	movq	-32(%rbp), %rax
	movq	64(%rax), %rax
	movq	%rax, -72(%rbp)
	movq	-32(%rbp), %rax
	movq	72(%rax), %rax
	movq	%rax, -64(%rbp)
	movq	-32(%rbp), %rdi
	callq	makeMaps_e
	movq	-32(%rbp), %rax
	movl	124(%rax), %eax
	incl	%eax
	movl	%eax, -44(%rbp)
	movl	$0, -12(%rbp)
	jmp	.LBB12_1
	.p2align	4, 0x90
.LBB12_2:                               # %for.body3
                                        #   in Loop: Header=BB12_1 Depth=1
	movq	-32(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movl	$0, 672(%rax,%rcx,4)
	incl	-12(%rbp)
.LBB12_1:                               # %for.cond1
                                        # =>This Inner Loop Header: Depth=1
	movl	-12(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jle	.LBB12_2
# BB#30:                                # %for.end
	movl	$0, -16(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -12(%rbp)
	jmp	.LBB12_31
	.p2align	4, 0x90
.LBB12_32:                              # %for.body712
                                        #   in Loop: Header=BB12_31 Depth=1
	movslq	-12(%rbp), %rax
	movb	%al, -336(%rbp,%rax)
	incl	-12(%rbp)
.LBB12_31:                              # %for.cond49
                                        # =>This Inner Loop Header: Depth=1
	movl	-12(%rbp), %eax
	movq	-32(%rbp), %rcx
	cmpl	124(%rcx), %eax
	jl	.LBB12_32
# BB#3:                                 # %for.end12
	movl	$0, -12(%rbp)
	leaq	-335(%rbp), %rax
	leaq	-336(%rbp), %rcx
	jmp	.LBB12_4
	.p2align	4, 0x90
.LBB12_8:                               # %if.then32
                                        #   in Loop: Header=BB12_4 Depth=1
	incl	%edx
	movl	%edx, -8(%rbp)
	incl	-12(%rbp)
.LBB12_4:                               # %for.cond13
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB12_11 Depth 2
                                        #     Child Loop BB12_18 Depth 2
	movl	-12(%rbp), %edx
	movq	-32(%rbp), %rsi
	cmpl	108(%rsi), %edx
	jge	.LBB12_21
# BB#5:                                 # %for.body16
                                        #   in Loop: Header=BB12_4 Depth=1
	movq	-80(%rbp), %rdx
	movslq	-12(%rbp), %rsi
	movl	(%rdx,%rsi,4), %edx
	decl	%edx
	movl	%edx, -40(%rbp)
	jns	.LBB12_7
# BB#6:                                 # %if.then
                                        #   in Loop: Header=BB12_4 Depth=1
	movq	-32(%rbp), %rdx
	movl	108(%rdx), %edx
	addl	%edx, -40(%rbp)
.LBB12_7:                               # %if.end
                                        #   in Loop: Header=BB12_4 Depth=1
	movq	-32(%rbp), %rdx
	movq	-72(%rbp), %rsi
	movslq	-40(%rbp), %rdi
	movzbl	(%rsi,%rdi), %esi
	movb	384(%rdx,%rsi), %dl
	movb	%dl, -17(%rbp)
	movzbl	-336(%rbp), %esi
	movzbl	-17(%rbp), %edi
	movl	-8(%rbp), %edx
	cmpl	%edi, %esi
	je	.LBB12_8
# BB#9:                                 # %if.else
                                        #   in Loop: Header=BB12_4 Depth=1
	testl	%edx, %edx
	jle	.LBB12_17
# BB#10:                                # %if.then36
                                        #   in Loop: Header=BB12_4 Depth=1
	decl	-8(%rbp)
	jmp	.LBB12_11
	.p2align	4, 0x90
.LBB12_15:                              # %if.end55
                                        #   in Loop: Header=BB12_11 Depth=2
	movl	-8(%rbp), %edx
	leal	-2(%rdx), %esi
	shrl	$31, %esi
	leal	-2(%rdx,%rsi), %edx
	sarl	%edx
	movl	%edx, -8(%rbp)
.LBB12_11:                              # %while.body
                                        #   Parent Loop BB12_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-64(%rbp), %rdx
	movslq	-16(%rbp), %rsi
	testb	$1, -8(%rbp)
	je	.LBB12_13
# BB#12:                                # %if.then37
                                        #   in Loop: Header=BB12_11 Depth=2
	movw	$1, (%rdx,%rsi,2)
	incl	-16(%rbp)
	movq	-32(%rbp), %rdx
	incl	676(%rdx)
	cmpl	$2, -8(%rbp)
	jge	.LBB12_15
	jmp	.LBB12_16
	.p2align	4, 0x90
.LBB12_13:                              # %if.else44
                                        #   in Loop: Header=BB12_11 Depth=2
	movw	$0, (%rdx,%rsi,2)
	incl	-16(%rbp)
	movq	-32(%rbp), %rdx
	incl	672(%rdx)
	cmpl	$2, -8(%rbp)
	jge	.LBB12_15
.LBB12_16:                              # %while.end
                                        #   in Loop: Header=BB12_4 Depth=1
	movl	$0, -8(%rbp)
.LBB12_17:                              # %if.end57
                                        #   in Loop: Header=BB12_4 Depth=1
	movb	-335(%rbp), %dl
	movb	%dl, -1(%rbp)
	movb	-336(%rbp), %dl
	movb	%dl, -335(%rbp)
	movq	%rax, -56(%rbp)
	movb	-17(%rbp), %dl
	movb	%dl, -34(%rbp)
	jmp	.LBB12_18
	.p2align	4, 0x90
.LBB12_19:                              # %while.body66
                                        #   in Loop: Header=BB12_18 Depth=2
	incq	-56(%rbp)
	movzbl	-1(%rbp), %edx
	movb	%dl, -33(%rbp)
	movq	-56(%rbp), %rdx
	movzbl	(%rdx), %edx
	movb	%dl, -1(%rbp)
	movzbl	-33(%rbp), %edx
	movq	-56(%rbp), %rsi
	movb	%dl, (%rsi)
.LBB12_18:                              # %while.cond
                                        #   Parent Loop BB12_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	-34(%rbp), %edx
	movzbl	-1(%rbp), %esi
	cmpl	%esi, %edx
	jne	.LBB12_19
# BB#20:                                # %while.end67
                                        #   in Loop: Header=BB12_4 Depth=1
	movb	-1(%rbp), %dl
	movb	%dl, -336(%rbp)
	movl	-56(%rbp), %edx
	subl	%ecx, %edx
	movl	%edx, -40(%rbp)
	incl	%edx
	movq	-64(%rbp), %rsi
	movslq	-16(%rbp), %rdi
	movw	%dx, (%rsi,%rdi,2)
	incl	-16(%rbp)
	movq	-32(%rbp), %rdx
	movslq	-40(%rbp), %rsi
	incl	676(%rdx,%rsi,4)
	incl	-12(%rbp)
	jmp	.LBB12_4
.LBB12_21:                              # %for.end84
	cmpl	$0, -8(%rbp)
	jle	.LBB12_29
# BB#22:                                # %if.then87
	decl	-8(%rbp)
	jmp	.LBB12_23
	.p2align	4, 0x90
.LBB12_27:                              # %if.end111
                                        #   in Loop: Header=BB12_23 Depth=1
	movl	-8(%rbp), %eax
	leal	-2(%rax), %ecx
	shrl	$31, %ecx
	leal	-2(%rax,%rcx), %eax
	sarl	%eax
	movl	%eax, -8(%rbp)
.LBB12_23:                              # %while.body90
                                        # =>This Inner Loop Header: Depth=1
	movq	-64(%rbp), %rax
	movslq	-16(%rbp), %rcx
	testb	$1, -8(%rbp)
	je	.LBB12_25
# BB#24:                                # %if.then93
                                        #   in Loop: Header=BB12_23 Depth=1
	movw	$1, (%rax,%rcx,2)
	incl	-16(%rbp)
	movq	-32(%rbp), %rax
	incl	676(%rax)
	cmpl	$2, -8(%rbp)
	jge	.LBB12_27
	jmp	.LBB12_28
	.p2align	4, 0x90
.LBB12_25:                              # %if.else100
                                        #   in Loop: Header=BB12_23 Depth=1
	movw	$0, (%rax,%rcx,2)
	incl	-16(%rbp)
	movq	-32(%rbp), %rax
	incl	672(%rax)
	cmpl	$2, -8(%rbp)
	jge	.LBB12_27
.LBB12_28:                              # %while.end114
	movl	$0, -8(%rbp)
.LBB12_29:                              # %if.end115
	movzwl	-44(%rbp), %eax
	movq	-64(%rbp), %rcx
	movslq	-16(%rbp), %rdx
	movw	%ax, (%rcx,%rdx,2)
	incl	-16(%rbp)
	movq	-32(%rbp), %rax
	movslq	-44(%rbp), %rcx
	incl	672(%rax,%rcx,4)
	movl	-16(%rbp), %eax
	movq	-32(%rbp), %rcx
	movl	%eax, 668(%rcx)
	addq	$336, %rsp              # imm = 0x150
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
.Lcfi43:
	.cfi_def_cfa_offset 16
.Lcfi44:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi45:
	.cfi_def_cfa_register %rbp
	subq	$224, %rsp
	movq	%rdi, -16(%rbp)
	movq	72(%rdi), %rax
	movq	%rax, -24(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$3, 656(%rax)
	jl	.LBB13_2
# BB#1:                                 # %if.then
	movq	stderr(%rip), %rdi
	movq	-16(%rbp), %rax
	movl	668(%rax), %ecx
	movl	108(%rax), %edx
	movl	124(%rax), %r8d
	movl	$.L.str.55, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB13_2:                               # %if.end
	movq	-16(%rbp), %rax
	movl	124(%rax), %eax
	addl	$2, %eax
	movl	%eax, -92(%rbp)
	movl	$0, -48(%rbp)
	cmpl	$5, -48(%rbp)
	jle	.LBB13_4
	jmp	.LBB13_8
	.p2align	4, 0x90
.LBB13_7:                               # %for.inc9
                                        #   in Loop: Header=BB13_4 Depth=1
	incl	-48(%rbp)
	cmpl	$5, -48(%rbp)
	jg	.LBB13_8
.LBB13_4:                               # %for.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_5 Depth 2
	movl	$0, -76(%rbp)
	jmp	.LBB13_5
	.p2align	4, 0x90
.LBB13_6:                               # %for.body6
                                        #   in Loop: Header=BB13_5 Depth=2
	movslq	-48(%rbp), %rax
	imulq	$258, %rax, %rax        # imm = 0x102
	addq	-16(%rbp), %rax
	movslq	-76(%rbp), %rcx
	movb	$15, 37708(%rcx,%rax)
	incl	-76(%rbp)
.LBB13_5:                               # %for.cond4
                                        #   Parent Loop BB13_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-76(%rbp), %eax
	cmpl	-92(%rbp), %eax
	jl	.LBB13_6
	jmp	.LBB13_7
.LBB13_8:                               # %for.end11
	movq	-16(%rbp), %rax
	cmpl	$0, 668(%rax)
	jg	.LBB13_10
# BB#9:                                 # %if.then14
	movl	$3001, %edi             # imm = 0xBB9
	callq	BZ2_bz__AssertH__fail
.LBB13_10:                              # %if.end15
	movq	-16(%rbp), %rax
	cmpl	$199, 668(%rax)
	jg	.LBB13_12
# BB#11:                                # %if.then18
	movl	$2, -68(%rbp)
	jmp	.LBB13_19
.LBB13_12:                              # %if.else
	movq	-16(%rbp), %rax
	cmpl	$599, 668(%rax)         # imm = 0x257
	jg	.LBB13_14
# BB#13:                                # %if.then21
	movl	$3, -68(%rbp)
	jmp	.LBB13_19
.LBB13_14:                              # %if.else22
	movq	-16(%rbp), %rax
	cmpl	$1199, 668(%rax)        # imm = 0x4AF
	jg	.LBB13_16
# BB#15:                                # %if.then25
	movl	$4, -68(%rbp)
	jmp	.LBB13_19
.LBB13_16:                              # %if.else26
	movq	-16(%rbp), %rax
	cmpl	$2399, 668(%rax)        # imm = 0x95F
	jg	.LBB13_18
# BB#17:                                # %if.then29
	movl	$5, -68(%rbp)
	jmp	.LBB13_19
.LBB13_18:                              # %if.else30
	movl	$6, -68(%rbp)
.LBB13_19:                              # %if.end34
	movl	-68(%rbp), %eax
	movl	%eax, -96(%rbp)
	movq	-16(%rbp), %rax
	movl	668(%rax), %eax
	movl	%eax, -164(%rbp)
	movl	$0, -8(%rbp)
	cmpl	$0, -96(%rbp)
	jg	.LBB13_21
	jmp	.LBB13_42
	.p2align	4, 0x90
.LBB13_41:                              # %for.end95
                                        #   in Loop: Header=BB13_21 Depth=1
	decl	-96(%rbp)
	movl	-72(%rbp), %eax
	incl	%eax
	movl	%eax, -8(%rbp)
	movl	-116(%rbp), %eax
	subl	%eax, -164(%rbp)
	cmpl	$0, -96(%rbp)
	jle	.LBB13_42
.LBB13_21:                              # %while.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_22 Depth 2
                                        #     Child Loop BB13_35 Depth 2
	movl	-164(%rbp), %eax
	cltd
	idivl	-96(%rbp)
	movl	%eax, -172(%rbp)
	movl	-8(%rbp), %eax
	decl	%eax
	movl	%eax, -72(%rbp)
	movl	$0, -116(%rbp)
	jmp	.LBB13_22
	.p2align	4, 0x90
.LBB13_26:                              # %while.body41
                                        #   in Loop: Header=BB13_22 Depth=2
	incl	%eax
	movl	%eax, -72(%rbp)
	movq	-16(%rbp), %rax
	movslq	-72(%rbp), %rcx
	movl	672(%rax,%rcx,4), %eax
	addl	%eax, -116(%rbp)
.LBB13_22:                              # %while.cond37
                                        #   Parent Loop BB13_21 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-116(%rbp), %eax
	cmpl	-172(%rbp), %eax
	jge	.LBB13_23
# BB#24:                                # %land.rhs
                                        #   in Loop: Header=BB13_22 Depth=2
	movl	-92(%rbp), %eax
	decl	%eax
	cmpl	%eax, -72(%rbp)
	setl	-139(%rbp)
	setl	-85(%rbp)
	jmp	.LBB13_25
	.p2align	4, 0x90
.LBB13_23:                              # %while.cond37.land.end_crit_edge
                                        #   in Loop: Header=BB13_22 Depth=2
	movb	$0, -85(%rbp)
.LBB13_25:                              # %land.end
                                        #   in Loop: Header=BB13_22 Depth=2
	movl	-72(%rbp), %eax
	cmpb	$1, -85(%rbp)
	je	.LBB13_26
# BB#27:                                # %while.end
                                        #   in Loop: Header=BB13_21 Depth=1
	cmpl	-8(%rbp), %eax
	jle	.LBB13_32
# BB#28:                                # %land.lhs.true
                                        #   in Loop: Header=BB13_21 Depth=1
	movl	-96(%rbp), %eax
	cmpl	-68(%rbp), %eax
	je	.LBB13_32
# BB#29:                                # %land.lhs.true
                                        #   in Loop: Header=BB13_21 Depth=1
	cmpl	$1, %eax
	je	.LBB13_32
# BB#30:                                # %land.lhs.true50
                                        #   in Loop: Header=BB13_21 Depth=1
	movl	-68(%rbp), %eax
	subl	-96(%rbp), %eax
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%eax, %ecx
	andl	$-2, %ecx
	subl	%ecx, %eax
	cmpl	$1, %eax
	jne	.LBB13_32
# BB#31:                                # %if.then53
                                        #   in Loop: Header=BB13_21 Depth=1
	movq	-16(%rbp), %rax
	movslq	-72(%rbp), %rcx
	movl	672(%rax,%rcx,4), %eax
	subl	%eax, -116(%rbp)
	decl	-72(%rbp)
	.p2align	4, 0x90
.LBB13_32:                              # %if.end58
                                        #   in Loop: Header=BB13_21 Depth=1
	movq	-16(%rbp), %rax
	cmpl	$3, 656(%rax)
	jl	.LBB13_34
# BB#33:                                # %if.then61
                                        #   in Loop: Header=BB13_21 Depth=1
	movq	stderr(%rip), %rdi
	movl	-96(%rbp), %edx
	movl	-8(%rbp), %ecx
	movl	-72(%rbp), %r8d
	movl	-116(%rbp), %r9d
	cvtsi2ssl	%r9d, %xmm0
	cvtss2sd	%xmm0, %xmm0
	mulsd	.LCPI13_0(%rip), %xmm0
	movq	-16(%rbp), %rax
	cvtsi2ssl	668(%rax), %xmm1
	cvtss2sd	%xmm1, %xmm1
	divsd	%xmm1, %xmm0
	movl	$.L.str.56, %esi
	movb	$1, %al
	callq	fprintf
.LBB13_34:                              # %if.end68
                                        #   in Loop: Header=BB13_21 Depth=1
	movl	$0, -76(%rbp)
	jmp	.LBB13_35
	.p2align	4, 0x90
.LBB13_40:                              # %if.end92
                                        #   in Loop: Header=BB13_35 Depth=2
	movslq	%edx, %rdx
	movb	%cl, (%rax,%rdx)
	incl	-76(%rbp)
.LBB13_35:                              # %for.cond69
                                        #   Parent Loop BB13_21 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-76(%rbp), %eax
	cmpl	-92(%rbp), %eax
	jge	.LBB13_41
# BB#36:                                # %for.body72
                                        #   in Loop: Header=BB13_35 Depth=2
	movl	-76(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jl	.LBB13_39
# BB#37:                                # %land.lhs.true75
                                        #   in Loop: Header=BB13_35 Depth=2
	movl	-76(%rbp), %eax
	cmpl	-72(%rbp), %eax
	jg	.LBB13_39
# BB#38:                                # %if.then78
                                        #   in Loop: Header=BB13_35 Depth=2
	movq	-16(%rbp), %rax
	movslq	-96(%rbp), %rcx
	imulq	$258, %rcx, %rcx        # imm = 0x102
	leaq	37450(%rax,%rcx), %rax
	movl	-76(%rbp), %edx
	xorl	%ecx, %ecx
	jmp	.LBB13_40
	.p2align	4, 0x90
.LBB13_39:                              # %if.else85
                                        #   in Loop: Header=BB13_35 Depth=2
	movq	-16(%rbp), %rax
	movslq	-96(%rbp), %rcx
	imulq	$258, %rcx, %rcx        # imm = 0x102
	leaq	37450(%rax,%rcx), %rax
	movb	$15, %cl
	movl	-76(%rbp), %edx
	jmp	.LBB13_40
.LBB13_42:                              # %while.end99
	movl	$0, -132(%rbp)
	cmpl	$3, -132(%rbp)
	jle	.LBB13_44
	jmp	.LBB13_94
	.p2align	4, 0x90
.LBB13_93:                              # %for.inc1702
                                        #   in Loop: Header=BB13_44 Depth=1
	incl	-132(%rbp)
	cmpl	$3, -132(%rbp)
	jg	.LBB13_94
.LBB13_44:                              # %for.body103
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_45 Depth 2
                                        #     Child Loop BB13_48 Depth 2
                                        #       Child Loop BB13_50 Depth 3
                                        #     Child Loop BB13_55 Depth 2
                                        #     Child Loop BB13_58 Depth 2
                                        #       Child Loop BB13_62 Depth 3
                                        #       Child Loop BB13_73 Depth 3
                                        #         Child Loop BB13_75 Depth 4
                                        #       Child Loop BB13_68 Depth 3
                                        #       Child Loop BB13_83 Depth 3
                                        #     Child Loop BB13_87 Depth 2
                                        #     Child Loop BB13_91 Depth 2
	movl	$0, -48(%rbp)
	jmp	.LBB13_45
	.p2align	4, 0x90
.LBB13_46:                              # %for.body107
                                        #   in Loop: Header=BB13_45 Depth=2
	movslq	-48(%rbp), %rax
	movl	$0, -224(%rbp,%rax,4)
	incl	-48(%rbp)
.LBB13_45:                              # %for.cond104
                                        #   Parent Loop BB13_44 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-48(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jl	.LBB13_46
# BB#47:                                # %for.end112
                                        #   in Loop: Header=BB13_44 Depth=1
	movl	$0, -48(%rbp)
	jmp	.LBB13_48
	.p2align	4, 0x90
.LBB13_52:                              # %for.inc128
                                        #   in Loop: Header=BB13_48 Depth=2
	incl	-48(%rbp)
.LBB13_48:                              # %for.cond113
                                        #   Parent Loop BB13_44 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB13_50 Depth 3
	movl	-48(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jge	.LBB13_53
# BB#49:                                # %for.body116
                                        #   in Loop: Header=BB13_48 Depth=2
	movl	$0, -76(%rbp)
	jmp	.LBB13_50
	.p2align	4, 0x90
.LBB13_51:                              # %for.body120
                                        #   in Loop: Header=BB13_50 Depth=3
	movslq	-48(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movslq	-76(%rbp), %rcx
	movl	$0, 45448(%rax,%rcx,4)
	incl	-76(%rbp)
.LBB13_50:                              # %for.cond117
                                        #   Parent Loop BB13_44 Depth=1
                                        #     Parent Loop BB13_48 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-76(%rbp), %eax
	cmpl	-92(%rbp), %eax
	jl	.LBB13_51
	jmp	.LBB13_52
	.p2align	4, 0x90
.LBB13_53:                              # %for.end130
                                        #   in Loop: Header=BB13_44 Depth=1
	cmpl	$6, -68(%rbp)
	jne	.LBB13_57
# BB#54:                                # %if.then133
                                        #   in Loop: Header=BB13_44 Depth=1
	movl	$0, -76(%rbp)
	jmp	.LBB13_55
	.p2align	4, 0x90
.LBB13_56:                              # %for.body137
                                        #   in Loop: Header=BB13_55 Depth=2
	movq	-16(%rbp), %rax
	movslq	-76(%rbp), %rcx
	movzbl	37966(%rax,%rcx), %edx
	shll	$16, %edx
	movzbl	37708(%rax,%rcx), %esi
	orl	%edx, %esi
	shlq	$4, %rcx
	movl	%esi, 51640(%rax,%rcx)
	movq	-16(%rbp), %rax
	movslq	-76(%rbp), %rcx
	movzbl	38482(%rax,%rcx), %edx
	shll	$16, %edx
	movzbl	38224(%rax,%rcx), %esi
	orl	%edx, %esi
	shlq	$4, %rcx
	movl	%esi, 51644(%rax,%rcx)
	movq	-16(%rbp), %rax
	movslq	-76(%rbp), %rcx
	movzbl	38998(%rax,%rcx), %edx
	shll	$16, %edx
	movzbl	38740(%rax,%rcx), %esi
	orl	%edx, %esi
	shlq	$4, %rcx
	movl	%esi, 51648(%rax,%rcx)
	incl	-76(%rbp)
.LBB13_55:                              # %for.cond134
                                        #   Parent Loop BB13_44 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-76(%rbp), %eax
	cmpl	-92(%rbp), %eax
	jl	.LBB13_56
.LBB13_57:                              # %if.end186
                                        #   in Loop: Header=BB13_44 Depth=1
	movl	$0, -104(%rbp)
	movl	$0, -168(%rbp)
	movl	$0, -8(%rbp)
	jmp	.LBB13_58
	.p2align	4, 0x90
.LBB13_81:                              # %if.end1665
                                        #   in Loop: Header=BB13_58 Depth=2
	movl	-72(%rbp), %eax
	incl	%eax
	movl	%eax, -8(%rbp)
.LBB13_58:                              # %while.body188
                                        #   Parent Loop BB13_44 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB13_62 Depth 3
                                        #       Child Loop BB13_73 Depth 3
                                        #         Child Loop BB13_75 Depth 4
                                        #       Child Loop BB13_68 Depth 3
                                        #       Child Loop BB13_83 Depth 3
	movl	-8(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	668(%rcx), %eax
	jge	.LBB13_85
# BB#59:                                # %if.end193
                                        #   in Loop: Header=BB13_58 Depth=2
	movl	-8(%rbp), %eax
	addl	$49, %eax
	movl	%eax, -72(%rbp)
	movq	-16(%rbp), %rcx
	cmpl	668(%rcx), %eax
	jl	.LBB13_61
# BB#60:                                # %if.then199
                                        #   in Loop: Header=BB13_58 Depth=2
	movq	-16(%rbp), %rax
	movl	668(%rax), %eax
	decl	%eax
	movl	%eax, -72(%rbp)
.LBB13_61:                              # %if.end202
                                        #   in Loop: Header=BB13_58 Depth=2
	movl	$0, -48(%rbp)
	jmp	.LBB13_62
	.p2align	4, 0x90
.LBB13_63:                              # %for.body206
                                        #   in Loop: Header=BB13_62 Depth=3
	movslq	-48(%rbp), %rax
	movw	$0, -152(%rbp,%rax,2)
	incl	-48(%rbp)
.LBB13_62:                              # %for.cond203
                                        #   Parent Loop BB13_44 Depth=1
                                        #     Parent Loop BB13_58 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-48(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jl	.LBB13_63
# BB#64:                                # %for.end211
                                        #   in Loop: Header=BB13_58 Depth=2
	cmpl	$6, -68(%rbp)
	jne	.LBB13_72
# BB#65:                                # %land.lhs.true214
                                        #   in Loop: Header=BB13_58 Depth=2
	movl	-72(%rbp), %eax
	subl	-8(%rbp), %eax
	cmpl	$49, %eax
	jne	.LBB13_72
# BB#66:                                # %if.then219
                                        #   in Loop: Header=BB13_58 Depth=2
	movl	$0, -32(%rbp)
	movl	$0, -36(%rbp)
	movl	$0, -40(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	2(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	4(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	6(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	8(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	10(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	12(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	14(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	16(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	18(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	20(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	22(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	24(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	26(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	28(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	30(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	32(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	34(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	36(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	38(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	40(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	42(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	44(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	46(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	48(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	50(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	52(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	54(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	56(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	58(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	60(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	62(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	64(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	66(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	68(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	70(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	72(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	74(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	76(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	78(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	80(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	82(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	84(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	86(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	88(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	90(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	92(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	94(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	96(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	98(%rax,%rcx,2), %eax
	movw	%ax, -2(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51640(%rax,%rcx), %eax
	addl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51644(%rax,%rcx), %eax
	addl	%eax, -36(%rbp)
	movq	-16(%rbp), %rax
	movzwl	-2(%rbp), %ecx
	shlq	$4, %rcx
	movl	51648(%rax,%rcx), %eax
	addl	%eax, -32(%rbp)
	movzwl	-40(%rbp), %eax
	movw	%ax, -152(%rbp)
	movzwl	-38(%rbp), %eax
	movw	%ax, -150(%rbp)
	movzwl	-36(%rbp), %eax
	movw	%ax, -148(%rbp)
	movzwl	-34(%rbp), %eax
	movw	%ax, -146(%rbp)
	movzwl	-32(%rbp), %eax
	movw	%ax, -144(%rbp)
	movzwl	-30(%rbp), %eax
	movw	%ax, -142(%rbp)
	jmp	.LBB13_67
	.p2align	4, 0x90
.LBB13_72:                              # %if.else1136
                                        #   in Loop: Header=BB13_58 Depth=2
	movl	-8(%rbp), %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB13_73
	.p2align	4, 0x90
.LBB13_77:                              # %for.inc1162
                                        #   in Loop: Header=BB13_73 Depth=3
	incl	-44(%rbp)
.LBB13_73:                              # %for.cond1137
                                        #   Parent Loop BB13_44 Depth=1
                                        #     Parent Loop BB13_58 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB13_75 Depth 4
	movl	-44(%rbp), %eax
	cmpl	-72(%rbp), %eax
	jg	.LBB13_67
# BB#74:                                # %for.body1140
                                        #   in Loop: Header=BB13_73 Depth=3
	movq	-24(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -138(%rbp)
	movl	$0, -48(%rbp)
	jmp	.LBB13_75
	.p2align	4, 0x90
.LBB13_76:                              # %for.body1147
                                        #   in Loop: Header=BB13_75 Depth=4
	movslq	-48(%rbp), %rax
	imulq	$258, %rax, %rcx        # imm = 0x102
	addq	-16(%rbp), %rcx
	movzwl	-138(%rbp), %edx
	movzbl	37708(%rdx,%rcx), %ecx
	movzwl	-152(%rbp,%rax,2), %edx
	addl	%ecx, %edx
	movw	%dx, -152(%rbp,%rax,2)
	incl	-48(%rbp)
.LBB13_75:                              # %for.cond1144
                                        #   Parent Loop BB13_44 Depth=1
                                        #     Parent Loop BB13_58 Depth=2
                                        #       Parent Loop BB13_73 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movl	-48(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jl	.LBB13_76
	jmp	.LBB13_77
	.p2align	4, 0x90
.LBB13_67:                              # %if.end1165
                                        #   in Loop: Header=BB13_58 Depth=2
	movl	$999999999, -136(%rbp)  # imm = 0x3B9AC9FF
	movl	$-1, -28(%rbp)
	movl	$0, -48(%rbp)
	jmp	.LBB13_68
	.p2align	4, 0x90
.LBB13_71:                              # %for.inc1180
                                        #   in Loop: Header=BB13_68 Depth=3
	incl	-48(%rbp)
.LBB13_68:                              # %for.cond1166
                                        #   Parent Loop BB13_44 Depth=1
                                        #     Parent Loop BB13_58 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-48(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jge	.LBB13_78
# BB#69:                                # %for.body1169
                                        #   in Loop: Header=BB13_68 Depth=3
	movslq	-48(%rbp), %rax
	movzwl	-152(%rbp,%rax,2), %eax
	cmpl	-136(%rbp), %eax
	jge	.LBB13_71
# BB#70:                                # %if.then1175
                                        #   in Loop: Header=BB13_68 Depth=3
	movslq	-48(%rbp), %rax
	movzwl	-152(%rbp,%rax,2), %eax
	movl	%eax, -136(%rbp)
	movl	-48(%rbp), %eax
	movl	%eax, -28(%rbp)
	jmp	.LBB13_71
	.p2align	4, 0x90
.LBB13_78:                              # %for.end1182
                                        #   in Loop: Header=BB13_58 Depth=2
	movl	-136(%rbp), %eax
	addl	%eax, -168(%rbp)
	movslq	-28(%rbp), %rax
	incl	-224(%rbp,%rax,4)
	movb	-28(%rbp), %al
	movq	-16(%rbp), %rcx
	movslq	-104(%rbp), %rdx
	movb	%al, 1704(%rcx,%rdx)
	incl	-104(%rbp)
	cmpl	$6, -68(%rbp)
	jne	.LBB13_82
# BB#79:                                # %land.lhs.true1193
                                        #   in Loop: Header=BB13_58 Depth=2
	movl	-72(%rbp), %eax
	subl	-8(%rbp), %eax
	cmpl	$49, %eax
	jne	.LBB13_82
# BB#80:                                # %if.then1198
                                        #   in Loop: Header=BB13_58 Depth=2
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	2(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	4(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	6(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	8(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	10(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	12(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	14(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	16(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	18(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	20(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	22(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	24(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	26(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	28(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	30(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	32(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	34(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	36(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	38(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	40(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	42(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	44(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	46(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	48(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	50(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	52(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	54(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	56(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	58(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	60(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	62(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	64(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	66(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	68(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	70(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	72(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	74(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	76(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	78(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	80(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	82(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	84(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	86(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	88(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	90(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	92(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	94(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	96(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	98(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	jmp	.LBB13_81
	.p2align	4, 0x90
.LBB13_82:                              # %if.else1649
                                        #   in Loop: Header=BB13_58 Depth=2
	movl	-8(%rbp), %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB13_83
	.p2align	4, 0x90
.LBB13_84:                              # %for.body1653
                                        #   in Loop: Header=BB13_83 Depth=3
	movslq	-28(%rbp), %rax
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	-16(%rbp), %rax
	movq	-24(%rbp), %rcx
	movslq	-44(%rbp), %rdx
	movzwl	(%rcx,%rdx,2), %ecx
	incl	45448(%rax,%rcx,4)
	incl	-44(%rbp)
.LBB13_83:                              # %for.cond1650
                                        #   Parent Loop BB13_44 Depth=1
                                        #     Parent Loop BB13_58 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-44(%rbp), %eax
	cmpl	-72(%rbp), %eax
	jle	.LBB13_84
	jmp	.LBB13_81
	.p2align	4, 0x90
.LBB13_85:                              # %while.end1667
                                        #   in Loop: Header=BB13_44 Depth=1
	movq	-16(%rbp), %rax
	cmpl	$3, 656(%rax)
	jl	.LBB13_90
# BB#86:                                # %if.then1671
                                        #   in Loop: Header=BB13_44 Depth=1
	movq	stderr(%rip), %rdi
	movl	-132(%rbp), %edx
	incl	%edx
	movl	-168(%rbp), %eax
	movl	%eax, %ecx
	sarl	$31, %ecx
	shrl	$29, %ecx
	addl	%eax, %ecx
	sarl	$3, %ecx
	movl	$.L.str.57, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	$0, -48(%rbp)
	jmp	.LBB13_87
	.p2align	4, 0x90
.LBB13_88:                              # %for.body1678
                                        #   in Loop: Header=BB13_87 Depth=2
	movslq	-48(%rbp), %rax
	movl	-224(%rbp,%rax,4), %edx
	movl	$.L.str.58, %esi
	xorl	%eax, %eax
	callq	fprintf
	incl	-48(%rbp)
.LBB13_87:                              # %for.cond1675
                                        #   Parent Loop BB13_44 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-48(%rbp), %eax
	movq	stderr(%rip), %rdi
	cmpl	-68(%rbp), %eax
	jl	.LBB13_88
# BB#89:                                # %for.end1684
                                        #   in Loop: Header=BB13_44 Depth=1
	movl	$.L.str.59, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB13_90:                              # %if.end1686
                                        #   in Loop: Header=BB13_44 Depth=1
	movl	$0, -48(%rbp)
	jmp	.LBB13_91
	.p2align	4, 0x90
.LBB13_92:                              # %for.body1690
                                        #   in Loop: Header=BB13_91 Depth=2
	movq	-16(%rbp), %rax
	movslq	-48(%rbp), %rcx
	imulq	$258, %rcx, %rdx        # imm = 0x102
	leaq	37708(%rax,%rdx), %rdi
	imulq	$1032, %rcx, %rcx       # imm = 0x408
	leaq	45448(%rax,%rcx), %rsi
	movl	-92(%rbp), %edx
	movl	$20, %ecx
	callq	BZ2_hbMakeCodeLengths
	incl	-48(%rbp)
.LBB13_91:                              # %for.cond1687
                                        #   Parent Loop BB13_44 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-48(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jl	.LBB13_92
	jmp	.LBB13_93
.LBB13_94:                              # %for.end1704
	cmpl	$8, -68(%rbp)
	jl	.LBB13_96
# BB#95:                                # %if.then1707
	movl	$3002, %edi             # imm = 0xBBA
	callq	BZ2_bz__AssertH__fail
.LBB13_96:                              # %if.end1708
	movl	-104(%rbp), %eax
	cmpl	$32767, %eax            # imm = 0x7FFF
	jg	.LBB13_98
# BB#97:                                # %if.end1708
	cmpl	$18003, %eax            # imm = 0x4653
	jl	.LBB13_99
.LBB13_98:                              # %if.then1714
	movl	$3003, %edi             # imm = 0xBBB
	callq	BZ2_bz__AssertH__fail
.LBB13_99:                              # %if.end1715
	movl	$0, -44(%rbp)
	jmp	.LBB13_100
	.p2align	4, 0x90
.LBB13_101:                             # %for.body17193
                                        #   in Loop: Header=BB13_100 Depth=1
	movslq	-44(%rbp), %rax
	movb	%al, -158(%rbp,%rax)
	incl	-44(%rbp)
.LBB13_100:                             # %for.cond17161
                                        # =>This Inner Loop Header: Depth=1
	movl	-44(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jl	.LBB13_101
# BB#180:                               # %for.end1725
	movl	$0, -44(%rbp)
	jmp	.LBB13_181
	.p2align	4, 0x90
.LBB13_185:                             # %while.end174627
                                        #   in Loop: Header=BB13_181 Depth=1
	movb	-77(%rbp), %al
	movb	%al, -158(%rbp)
	movb	-84(%rbp), %al
	movq	-16(%rbp), %rcx
	movslq	-44(%rbp), %rdx
	movb	%al, 19706(%rcx,%rdx)
	incl	-44(%rbp)
.LBB13_181:                             # %for.cond17269
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_183 Depth 2
	movl	-44(%rbp), %eax
	cmpl	-104(%rbp), %eax
	jge	.LBB13_102
# BB#182:                               # %for.body172911
                                        #   in Loop: Header=BB13_181 Depth=1
	movq	-16(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movb	1704(%rax,%rcx), %al
	movb	%al, -106(%rbp)
	movl	$0, -84(%rbp)
	movb	-158(%rbp), %al
	movb	%al, -77(%rbp)
	jmp	.LBB13_183
	.p2align	4, 0x90
.LBB13_184:                             # %while.body174021
                                        #   in Loop: Header=BB13_183 Depth=2
	incl	-84(%rbp)
	movzbl	-77(%rbp), %eax
	movb	%al, -105(%rbp)
	movslq	-84(%rbp), %rax
	movzbl	-158(%rbp,%rax), %eax
	movb	%al, -77(%rbp)
	movzbl	-105(%rbp), %eax
	movslq	-84(%rbp), %rcx
	movb	%al, -158(%rbp,%rcx)
.LBB13_183:                             # %while.cond173517
                                        #   Parent Loop BB13_181 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	-106(%rbp), %eax
	movzbl	-77(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB13_184
	jmp	.LBB13_185
.LBB13_102:                             # %for.end1753
	movl	$0, -48(%rbp)
	jmp	.LBB13_103
	.p2align	4, 0x90
.LBB13_115:                             # %if.end1804
                                        #   in Loop: Header=BB13_103 Depth=1
	movq	-16(%rbp), %rax
	movslq	-48(%rbp), %rcx
	imulq	$1032, %rcx, %rdx       # imm = 0x408
	leaq	39256(%rax,%rdx), %rdi
	imulq	$258, %rcx, %rcx        # imm = 0x102
	leaq	37708(%rax,%rcx), %rsi
	movl	-128(%rbp), %edx
	movl	-124(%rbp), %ecx
	movl	-92(%rbp), %r8d
	callq	BZ2_hbAssignCodes
	incl	-48(%rbp)
.LBB13_103:                             # %for.cond1754
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_105 Depth 2
	movl	-48(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jge	.LBB13_116
# BB#104:                               # %for.body1757
                                        #   in Loop: Header=BB13_103 Depth=1
	movl	$32, -128(%rbp)
	movl	$0, -124(%rbp)
	movl	$0, -44(%rbp)
	jmp	.LBB13_105
	.p2align	4, 0x90
.LBB13_110:                             # %for.inc1794
                                        #   in Loop: Header=BB13_105 Depth=2
	incl	-44(%rbp)
.LBB13_105:                             # %for.cond1758
                                        #   Parent Loop BB13_103 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	cmpl	-92(%rbp), %eax
	jge	.LBB13_111
# BB#106:                               # %for.body1761
                                        #   in Loop: Header=BB13_105 Depth=2
	movslq	-48(%rbp), %rax
	imulq	$258, %rax, %rax        # imm = 0x102
	addq	-16(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movzbl	37708(%rcx,%rax), %eax
	cmpl	-124(%rbp), %eax
	jle	.LBB13_108
# BB#107:                               # %if.then1770
                                        #   in Loop: Header=BB13_105 Depth=2
	movslq	-48(%rbp), %rax
	imulq	$258, %rax, %rax        # imm = 0x102
	addq	-16(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movzbl	37708(%rcx,%rax), %eax
	movl	%eax, -124(%rbp)
.LBB13_108:                             # %if.end1777
                                        #   in Loop: Header=BB13_105 Depth=2
	movslq	-48(%rbp), %rax
	imulq	$258, %rax, %rax        # imm = 0x102
	addq	-16(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movzbl	37708(%rcx,%rax), %eax
	cmpl	-128(%rbp), %eax
	jge	.LBB13_110
# BB#109:                               # %if.then1786
                                        #   in Loop: Header=BB13_105 Depth=2
	movslq	-48(%rbp), %rax
	imulq	$258, %rax, %rax        # imm = 0x102
	addq	-16(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movzbl	37708(%rcx,%rax), %eax
	movl	%eax, -128(%rbp)
	jmp	.LBB13_110
	.p2align	4, 0x90
.LBB13_111:                             # %for.end1796
                                        #   in Loop: Header=BB13_103 Depth=1
	cmpl	$21, -124(%rbp)
	jl	.LBB13_113
# BB#112:                               # %if.then1799
                                        #   in Loop: Header=BB13_103 Depth=1
	movl	$3004, %edi             # imm = 0xBBC
	callq	BZ2_bz__AssertH__fail
.LBB13_113:                             # %if.end1800
                                        #   in Loop: Header=BB13_103 Depth=1
	cmpl	$0, -128(%rbp)
	jg	.LBB13_115
# BB#114:                               # %if.then1803
                                        #   in Loop: Header=BB13_103 Depth=1
	movl	$3005, %edi             # imm = 0xBBD
	callq	BZ2_bz__AssertH__fail
	jmp	.LBB13_115
.LBB13_116:                             # %for.end1814
	movl	$0, -44(%rbp)
	cmpl	$15, -44(%rbp)
	jle	.LBB13_118
	jmp	.LBB13_124
	.p2align	4, 0x90
.LBB13_123:                             # %for.inc1837
                                        #   in Loop: Header=BB13_118 Depth=1
	incl	-44(%rbp)
	cmpl	$15, -44(%rbp)
	jg	.LBB13_124
.LBB13_118:                             # %for.body1819
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_120 Depth 2
	movslq	-44(%rbp), %rax
	movb	$0, -192(%rbp,%rax)
	movl	$0, -84(%rbp)
	cmpl	$15, -84(%rbp)
	jle	.LBB13_120
	jmp	.LBB13_123
	.p2align	4, 0x90
.LBB13_122:                             # %for.inc1834
                                        #   in Loop: Header=BB13_120 Depth=2
	incl	-84(%rbp)
	cmpl	$15, -84(%rbp)
	jg	.LBB13_123
.LBB13_120:                             # %for.body1825
                                        #   Parent Loop BB13_118 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-16(%rbp), %rax
	movslq	-44(%rbp), %rcx
	shlq	$4, %rcx
	movslq	-84(%rbp), %rdx
	addq	%rcx, %rdx
	cmpb	$0, 128(%rax,%rdx)
	je	.LBB13_122
# BB#121:                               # %if.then1830
                                        #   in Loop: Header=BB13_120 Depth=2
	movslq	-44(%rbp), %rax
	movb	$1, -192(%rbp,%rax)
	jmp	.LBB13_122
.LBB13_124:                             # %for.end1839
	movq	-16(%rbp), %rax
	movl	116(%rax), %eax
	movl	%eax, -100(%rbp)
	movl	$0, -44(%rbp)
	cmpl	$15, -44(%rbp)
	jle	.LBB13_126
	jmp	.LBB13_130
	.p2align	4, 0x90
.LBB13_128:                             # %for.cond1840
                                        #   in Loop: Header=BB13_126 Depth=1
	callq	bsW
	incl	-44(%rbp)
	cmpl	$15, -44(%rbp)
	jg	.LBB13_130
.LBB13_126:                             # %for.body1843
                                        # =>This Inner Loop Header: Depth=1
	movslq	-44(%rbp), %rax
	movq	-16(%rbp), %rdi
	cmpb	$0, -192(%rbp,%rax)
	je	.LBB13_129
# BB#127:                               # %if.then1847
                                        #   in Loop: Header=BB13_126 Depth=1
	movl	$1, %esi
	movl	$1, %edx
	jmp	.LBB13_128
	.p2align	4, 0x90
.LBB13_129:                             # %if.else1848
                                        #   in Loop: Header=BB13_126 Depth=1
	movl	$1, %esi
	xorl	%edx, %edx
	jmp	.LBB13_128
.LBB13_130:                             # %for.end1852
	movl	$0, -44(%rbp)
	cmpl	$15, -44(%rbp)
	jle	.LBB13_132
	jmp	.LBB13_140
	.p2align	4, 0x90
.LBB13_139:                             # %for.inc1878
                                        #   in Loop: Header=BB13_132 Depth=1
	incl	-44(%rbp)
	cmpl	$15, -44(%rbp)
	jg	.LBB13_140
.LBB13_132:                             # %for.body1856
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_135 Depth 2
	movslq	-44(%rbp), %rax
	cmpb	$0, -192(%rbp,%rax)
	je	.LBB13_139
# BB#133:                               # %if.then1860
                                        #   in Loop: Header=BB13_132 Depth=1
	movl	$0, -84(%rbp)
	cmpl	$15, -84(%rbp)
	jle	.LBB13_135
	jmp	.LBB13_139
	.p2align	4, 0x90
.LBB13_137:                             # %for.cond1861
                                        #   in Loop: Header=BB13_135 Depth=2
	callq	bsW
	incl	-84(%rbp)
	cmpl	$15, -84(%rbp)
	jg	.LBB13_139
.LBB13_135:                             # %for.body1864
                                        #   Parent Loop BB13_132 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-16(%rbp), %rdi
	movslq	-44(%rbp), %rax
	shlq	$4, %rax
	movslq	-84(%rbp), %rcx
	addq	%rax, %rcx
	cmpb	$0, 128(%rdi,%rcx)
	je	.LBB13_138
# BB#136:                               # %if.then1871
                                        #   in Loop: Header=BB13_135 Depth=2
	movl	$1, %esi
	movl	$1, %edx
	jmp	.LBB13_137
	.p2align	4, 0x90
.LBB13_138:                             # %if.else1872
                                        #   in Loop: Header=BB13_135 Depth=2
	movl	$1, %esi
	xorl	%edx, %edx
	jmp	.LBB13_137
.LBB13_140:                             # %for.end1880
	movq	-16(%rbp), %rax
	cmpl	$3, 656(%rax)
	jl	.LBB13_142
# BB#141:                               # %if.then1884
	movq	stderr(%rip), %rdi
	movq	-16(%rbp), %rax
	movl	116(%rax), %edx
	subl	-100(%rbp), %edx
	movl	$.L.str.60, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB13_142:                             # %if.end1888
	movq	-16(%rbp), %rax
	movl	116(%rax), %eax
	movl	%eax, -100(%rbp)
	movq	-16(%rbp), %rdi
	movl	-68(%rbp), %edx
	movl	$3, %esi
	callq	bsW
	movq	-16(%rbp), %rdi
	movl	-104(%rbp), %edx
	movl	$15, %esi
	callq	bsW
	movl	$0, -44(%rbp)
	jmp	.LBB13_143
	.p2align	4, 0x90
.LBB13_147:                             # %for.end1904
                                        #   in Loop: Header=BB13_143 Depth=1
	movl	$1, %esi
	xorl	%edx, %edx
	callq	bsW
	incl	-44(%rbp)
.LBB13_143:                             # %for.cond1890
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_145 Depth 2
	movl	-44(%rbp), %eax
	cmpl	-104(%rbp), %eax
	jge	.LBB13_148
# BB#144:                               # %for.body1893
                                        #   in Loop: Header=BB13_143 Depth=1
	movl	$0, -84(%rbp)
	jmp	.LBB13_145
	.p2align	4, 0x90
.LBB13_146:                             # %for.body1901
                                        #   in Loop: Header=BB13_145 Depth=2
	movl	$1, %esi
	movl	$1, %edx
	callq	bsW
	incl	-84(%rbp)
.LBB13_145:                             # %for.cond1894
                                        #   Parent Loop BB13_143 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-16(%rbp), %rdi
	movslq	-44(%rbp), %rax
	movzbl	19706(%rdi,%rax), %eax
	cmpl	%eax, -84(%rbp)
	jl	.LBB13_146
	jmp	.LBB13_147
.LBB13_148:                             # %for.end1907
	movq	-16(%rbp), %rax
	cmpl	$3, 656(%rax)
	jl	.LBB13_150
# BB#149:                               # %if.then1911
	movq	stderr(%rip), %rdi
	movq	-16(%rbp), %rax
	movl	116(%rax), %edx
	subl	-100(%rbp), %edx
	movl	$.L.str.61, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB13_150:                             # %if.end1915
	movq	-16(%rbp), %rax
	movl	116(%rax), %eax
	movl	%eax, -100(%rbp)
	movl	$0, -48(%rbp)
	jmp	.LBB13_151
	.p2align	4, 0x90
.LBB13_159:                             # %for.inc1958
                                        #   in Loop: Header=BB13_151 Depth=1
	incl	-48(%rbp)
.LBB13_151:                             # %for.cond1917
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_153 Depth 2
                                        #       Child Loop BB13_154 Depth 3
                                        #       Child Loop BB13_156 Depth 3
	movl	-48(%rbp), %ecx
	movq	-16(%rbp), %rax
	cmpl	-68(%rbp), %ecx
	jge	.LBB13_160
# BB#152:                               # %for.body1920
                                        #   in Loop: Header=BB13_151 Depth=1
	movslq	-48(%rbp), %rcx
	imulq	$258, %rcx, %rcx        # imm = 0x102
	movzbl	37708(%rax,%rcx), %edx
	movl	%edx, -120(%rbp)
	movq	-16(%rbp), %rdi
	movl	$5, %esi
	callq	bsW
	movl	$0, -44(%rbp)
	jmp	.LBB13_153
	.p2align	4, 0x90
.LBB13_158:                             # %while.end1954
                                        #   in Loop: Header=BB13_153 Depth=2
	movl	$1, %esi
	xorl	%edx, %edx
	callq	bsW
	incl	-44(%rbp)
.LBB13_153:                             # %for.cond1927
                                        #   Parent Loop BB13_151 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB13_154 Depth 3
                                        #       Child Loop BB13_156 Depth 3
	movl	-44(%rbp), %eax
	cmpl	-92(%rbp), %eax
	jl	.LBB13_154
	jmp	.LBB13_159
	.p2align	4, 0x90
.LBB13_155:                             # %while.body1940
                                        #   in Loop: Header=BB13_154 Depth=3
	movq	-16(%rbp), %rdi
	movl	$2, %esi
	movl	$2, %edx
	callq	bsW
	incl	-120(%rbp)
.LBB13_154:                             # %while.cond1931
                                        #   Parent Loop BB13_151 Depth=1
                                        #     Parent Loop BB13_153 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movslq	-48(%rbp), %rax
	imulq	$258, %rax, %rax        # imm = 0x102
	addq	-16(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movzbl	37708(%rcx,%rax), %eax
	cmpl	%eax, -120(%rbp)
	jl	.LBB13_155
	jmp	.LBB13_156
	.p2align	4, 0x90
.LBB13_157:                             # %while.body1952
                                        #   in Loop: Header=BB13_156 Depth=3
	movl	$2, %esi
	movl	$3, %edx
	callq	bsW
	decl	-120(%rbp)
.LBB13_156:                             # %while.cond1943
                                        #   Parent Loop BB13_151 Depth=1
                                        #     Parent Loop BB13_153 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	-16(%rbp), %rdi
	movslq	-48(%rbp), %rax
	imulq	$258, %rax, %rax        # imm = 0x102
	addq	%rdi, %rax
	movslq	-44(%rbp), %rcx
	movzbl	37708(%rcx,%rax), %eax
	cmpl	%eax, -120(%rbp)
	jg	.LBB13_157
	jmp	.LBB13_158
.LBB13_160:                             # %for.end1960
	cmpl	$3, 656(%rax)
	jl	.LBB13_162
# BB#161:                               # %if.then1964
	movq	stderr(%rip), %rdi
	movq	-16(%rbp), %rax
	movl	116(%rax), %edx
	subl	-100(%rbp), %edx
	movl	$.L.str.62, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB13_162:                             # %if.end1968
	movq	-16(%rbp), %rax
	movl	116(%rax), %eax
	movl	%eax, -100(%rbp)
	movl	$0, -112(%rbp)
	movl	$0, -8(%rbp)
	jmp	.LBB13_163
	.p2align	4, 0x90
.LBB13_171:                             # %if.end2448
                                        #   in Loop: Header=BB13_163 Depth=1
	movl	-72(%rbp), %eax
	incl	%eax
	movl	%eax, -8(%rbp)
	incl	-112(%rbp)
.LBB13_163:                             # %while.body1971
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB13_173 Depth 2
	movl	-8(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	668(%rcx), %eax
	jge	.LBB13_175
# BB#164:                               # %if.end1976
                                        #   in Loop: Header=BB13_163 Depth=1
	movl	-8(%rbp), %eax
	addl	$49, %eax
	movl	%eax, -72(%rbp)
	movq	-16(%rbp), %rcx
	cmpl	668(%rcx), %eax
	jl	.LBB13_166
# BB#165:                               # %if.then1982
                                        #   in Loop: Header=BB13_163 Depth=1
	movq	-16(%rbp), %rax
	movl	668(%rax), %eax
	decl	%eax
	movl	%eax, -72(%rbp)
.LBB13_166:                             # %if.end1985
                                        #   in Loop: Header=BB13_163 Depth=1
	movq	-16(%rbp), %rax
	movslq	-112(%rbp), %rcx
	movzbl	1704(%rax,%rcx), %eax
	cmpl	-68(%rbp), %eax
	jl	.LBB13_168
# BB#167:                               # %if.then1992
                                        #   in Loop: Header=BB13_163 Depth=1
	movl	$3006, %edi             # imm = 0xBBE
	callq	BZ2_bz__AssertH__fail
.LBB13_168:                             # %if.end1993
                                        #   in Loop: Header=BB13_163 Depth=1
	cmpl	$6, -68(%rbp)
	jne	.LBB13_172
# BB#169:                               # %land.lhs.true1996
                                        #   in Loop: Header=BB13_163 Depth=1
	movl	-72(%rbp), %eax
	subl	-8(%rbp), %eax
	cmpl	$49, %eax
	jne	.LBB13_172
# BB#170:                               # %if.then2001
                                        #   in Loop: Header=BB13_163 Depth=1
	movq	-16(%rbp), %rax
	movslq	-112(%rbp), %rcx
	movzbl	1704(%rax,%rcx), %ecx
	imulq	$258, %rcx, %rcx        # imm = 0x102
	leaq	37708(%rax,%rcx), %rax
	movq	%rax, -64(%rbp)
	movq	-16(%rbp), %rax
	movslq	-112(%rbp), %rcx
	movzbl	1704(%rax,%rcx), %ecx
	imulq	$1032, %rcx, %rcx       # imm = 0x408
	leaq	39256(%rax,%rcx), %rax
	movq	%rax, -56(%rbp)
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	2(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	4(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	6(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	8(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	10(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	12(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	14(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	16(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	18(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	20(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	22(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	24(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	26(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	28(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	30(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	32(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	34(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	36(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	38(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	40(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	42(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	44(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	46(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	48(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	50(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	52(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	54(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	56(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	58(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	60(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	62(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	64(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	66(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	68(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	70(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	72(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	74(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	76(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	78(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	80(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	82(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	84(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	86(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	88(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	90(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	92(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	94(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	96(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	movq	-24(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	98(%rax,%rcx,2), %eax
	movw	%ax, -4(%rbp)
	movq	-16(%rbp), %rdi
	movq	-64(%rbp), %rax
	movzwl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %esi
	movq	-56(%rbp), %rax
	movl	(%rax,%rcx,4), %edx
	callq	bsW
	jmp	.LBB13_171
	.p2align	4, 0x90
.LBB13_172:                             # %if.else2419
                                        #   in Loop: Header=BB13_163 Depth=1
	movl	-8(%rbp), %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB13_173
	.p2align	4, 0x90
.LBB13_174:                             # %for.body2423
                                        #   in Loop: Header=BB13_173 Depth=2
	movq	-16(%rbp), %rdi
	movslq	-112(%rbp), %rax
	movzbl	1704(%rdi,%rax), %eax
	imulq	$258, %rax, %rcx        # imm = 0x102
	addq	%rdi, %rcx
	movq	-24(%rbp), %rdx
	movslq	-44(%rbp), %rsi
	movzwl	(%rdx,%rsi,2), %edx
	movzbl	37708(%rdx,%rcx), %esi
	imulq	$1032, %rax, %rax       # imm = 0x408
	addq	%rdi, %rax
	movl	39256(%rax,%rdx,4), %edx
	callq	bsW
	incl	-44(%rbp)
.LBB13_173:                             # %for.cond2420
                                        #   Parent Loop BB13_163 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-44(%rbp), %eax
	cmpl	-72(%rbp), %eax
	jle	.LBB13_174
	jmp	.LBB13_171
.LBB13_175:                             # %while.end2451
	movl	-112(%rbp), %eax
	cmpl	-104(%rbp), %eax
	je	.LBB13_177
# BB#176:                               # %if.then2454
	movl	$3007, %edi             # imm = 0xBBF
	callq	BZ2_bz__AssertH__fail
.LBB13_177:                             # %if.end2455
	movq	-16(%rbp), %rax
	cmpl	$3, 656(%rax)
	jl	.LBB13_179
# BB#178:                               # %if.then2459
	movq	stderr(%rip), %rdi
	movq	-16(%rbp), %rax
	movl	116(%rax), %edx
	subl	-100(%rbp), %edx
	movl	$.L.str.63, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB13_179:                             # %if.end2463
	addq	$224, %rsp
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
.Lcfi46:
	.cfi_def_cfa_offset 16
.Lcfi47:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi48:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	jmp	.LBB14_1
	.p2align	4, 0x90
.LBB14_2:                               # %while.body
                                        #   in Loop: Header=BB14_1 Depth=1
	movq	-8(%rbp), %rax
	movzbl	643(%rax), %ecx
	movq	80(%rax), %rdx
	movslq	116(%rax), %rax
	movb	%cl, (%rdx,%rax)
	movq	-8(%rbp), %rax
	incl	116(%rax)
	movq	-8(%rbp), %rax
	shll	$8, 640(%rax)
	movq	-8(%rbp), %rax
	addl	$-8, 644(%rax)
.LBB14_1:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$0, 644(%rax)
	jg	.LBB14_2
# BB#3:                                 # %while.end
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
.Lcfi49:
	.cfi_def_cfa_offset 16
.Lcfi50:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi51:
	.cfi_def_cfa_register %rbp
	subq	$400, %rsp              # imm = 0x190
	movq	%rdi, -8(%rbp)
	movq	(%rdi), %rax
	movq	%rax, -376(%rbp)
	movq	-8(%rbp), %rax
	cmpl	$10, 8(%rax)
	jne	.LBB15_2
# BB#1:                                 # %if.then
	movq	-8(%rbp), %rax
	movl	$0, 64036(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64040(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64044(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64048(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64052(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64056(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64060(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64064(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64068(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64072(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64076(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64080(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64084(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64088(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64092(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64096(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64100(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64104(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64108(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64112(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 64116(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 64120(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 64128(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 64136(%rax)
.LBB15_2:                               # %if.end
	movq	-8(%rbp), %rax
	movl	64036(%rax), %eax
	movl	%eax, -20(%rbp)
	movq	-8(%rbp), %rax
	movl	64040(%rax), %eax
	movl	%eax, -40(%rbp)
	movq	-8(%rbp), %rax
	movl	64044(%rax), %eax
	movl	%eax, -48(%rbp)
	movq	-8(%rbp), %rax
	movl	64048(%rax), %eax
	movl	%eax, -120(%rbp)
	movq	-8(%rbp), %rax
	movl	64052(%rax), %eax
	movl	%eax, -108(%rbp)
	movq	-8(%rbp), %rax
	movl	64056(%rax), %eax
	movl	%eax, -92(%rbp)
	movq	-8(%rbp), %rax
	movl	64060(%rax), %eax
	movl	%eax, -180(%rbp)
	movq	-8(%rbp), %rax
	movl	64064(%rax), %eax
	movl	%eax, -52(%rbp)
	movq	-8(%rbp), %rax
	movl	64068(%rax), %eax
	movl	%eax, -68(%rbp)
	movq	-8(%rbp), %rax
	movl	64072(%rax), %eax
	movl	%eax, -64(%rbp)
	movq	-8(%rbp), %rax
	movl	64076(%rax), %eax
	movl	%eax, -116(%rbp)
	movq	-8(%rbp), %rax
	movl	64080(%rax), %eax
	movl	%eax, -44(%rbp)
	movq	-8(%rbp), %rax
	movl	64084(%rax), %eax
	movl	%eax, -60(%rbp)
	movq	-8(%rbp), %rax
	movl	64088(%rax), %eax
	movl	%eax, -112(%rbp)
	movq	-8(%rbp), %rax
	movl	64092(%rax), %eax
	movl	%eax, -88(%rbp)
	movq	-8(%rbp), %rax
	movl	64096(%rax), %eax
	movl	%eax, -364(%rbp)
	movq	-8(%rbp), %rax
	movl	64100(%rax), %eax
	movl	%eax, -28(%rbp)
	movq	-8(%rbp), %rax
	movl	64104(%rax), %eax
	movl	%eax, -32(%rbp)
	movq	-8(%rbp), %rax
	movl	64108(%rax), %eax
	movl	%eax, -136(%rbp)
	movq	-8(%rbp), %rax
	movl	64112(%rax), %eax
	movl	%eax, -36(%rbp)
	movq	-8(%rbp), %rax
	movl	64116(%rax), %eax
	movl	%eax, -84(%rbp)
	movq	-8(%rbp), %rax
	movq	64120(%rax), %rax
	movq	%rax, -160(%rbp)
	movq	-8(%rbp), %rax
	movq	64128(%rax), %rax
	movq	%rax, -104(%rbp)
	movq	-8(%rbp), %rax
	movq	64136(%rax), %rax
	movq	%rax, -152(%rbp)
	movl	$0, -16(%rbp)
	movq	-8(%rbp), %rax
	movl	8(%rax), %eax
	addl	$-10, %eax
	cmpl	$40, %eax
	ja	.LBB15_9
# BB#3:                                 # %if.end
	jmpq	*.LJTI15_0(,%rax,8)
.LBB15_4:                               # %sw.bb
	movq	-8(%rbp), %rax
	movl	$10, 8(%rax)
	jmp	.LBB15_6
.LBB15_5:                               # %if.then53
                                        #   in Loop: Header=BB15_6 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_6:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_10
# BB#7:                                 # %if.end33
                                        #   in Loop: Header=BB15_6 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#8:                                 # %if.end38
                                        #   in Loop: Header=BB15_6 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_6
	jmp	.LBB15_5
.LBB15_9:                               # %sw.default
	movl	$4001, %edi             # imm = 0xFA1
	callq	BZ2_bz__AssertH__fail
	movl	$4002, %edi             # imm = 0xFA2
	callq	BZ2_bz__AssertH__fail
	jmp	.LBB15_184
.LBB15_10:                              # %if.then29
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -360(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-360(%rbp), %al
	movb	%al, -9(%rbp)
	cmpb	$66, %al
	je	.LBB15_12
# BB#11:                                # %if.then60
	movl	$-5, -16(%rbp)
	jmp	.LBB15_184
.LBB15_12:                              # %sw.bb62
	movq	-8(%rbp), %rax
	movl	$11, 8(%rax)
	jmp	.LBB15_14
	.p2align	4, 0x90
.LBB15_13:                              # %if.then107
                                        #   in Loop: Header=BB15_14 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_14:                              # %while.body64
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_17
# BB#15:                                # %if.end78
                                        #   in Loop: Header=BB15_14 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#16:                                # %if.end84
                                        #   in Loop: Header=BB15_14 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_14
	jmp	.LBB15_13
.LBB15_17:                              # %if.then68
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -356(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-356(%rbp), %al
	movb	%al, -9(%rbp)
	cmpb	$90, %al
	je	.LBB15_19
# BB#18:                                # %if.then116
	movl	$-5, -16(%rbp)
	jmp	.LBB15_184
.LBB15_19:                              # %sw.bb118
	movq	-8(%rbp), %rax
	movl	$12, 8(%rax)
	jmp	.LBB15_21
	.p2align	4, 0x90
.LBB15_20:                              # %if.then163
                                        #   in Loop: Header=BB15_21 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_21:                              # %while.body120
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_24
# BB#22:                                # %if.end134
                                        #   in Loop: Header=BB15_21 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#23:                                # %if.end140
                                        #   in Loop: Header=BB15_21 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_21
	jmp	.LBB15_20
.LBB15_24:                              # %if.then124
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -352(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-352(%rbp), %al
	movb	%al, -9(%rbp)
	cmpb	$104, %al
	je	.LBB15_26
# BB#25:                                # %if.then172
	movl	$-5, -16(%rbp)
	jmp	.LBB15_184
.LBB15_26:                              # %sw.bb174
	movq	-8(%rbp), %rax
	movl	$13, 8(%rax)
	jmp	.LBB15_28
	.p2align	4, 0x90
.LBB15_27:                              # %if.then218
                                        #   in Loop: Header=BB15_28 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_28:                              # %while.body176
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_31
# BB#29:                                # %if.end189
                                        #   in Loop: Header=BB15_28 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#30:                                # %if.end195
                                        #   in Loop: Header=BB15_28 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_28
	jmp	.LBB15_27
.LBB15_31:                              # %if.then180
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -348(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movl	-348(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 40(%rcx)
	movq	-8(%rbp), %rax
	cmpl	$49, 40(%rax)
	jl	.LBB15_33
# BB#32:                                # %lor.lhs.false
	movq	-8(%rbp), %rax
	cmpl	$58, 40(%rax)
	jl	.LBB15_34
.LBB15_33:                              # %if.then230
	movl	$-5, -16(%rbp)
	jmp	.LBB15_184
.LBB15_34:                              # %if.end231
	movq	-8(%rbp), %rax
	addl	$-48, 40(%rax)
	movq	-8(%rbp), %rcx
	movq	-376(%rbp), %rdx
	movq	56(%rdx), %rax
	movq	72(%rdx), %rdi
	movslq	40(%rcx), %rdx
	imulq	$100000, %rdx, %rsi     # imm = 0x186A0
	cmpb	$0, 44(%rcx)
	je	.LBB15_38
# BB#35:                                # %if.then234
	addl	%esi, %esi
	movl	$1, %edx
                                        # kill: %ESI<def> %ESI<kill> %RSI<kill>
	callq	*%rax
	movq	-8(%rbp), %rcx
	movq	%rax, 3160(%rcx)
	movq	-376(%rbp), %rax
	movq	72(%rax), %rdi
	movq	-8(%rbp), %rcx
	imull	$100000, 40(%rcx), %esi # imm = 0x186A0
	sarl	%esi
	movl	$1, %edx
	callq	*56(%rax)
	movq	-8(%rbp), %rcx
	movq	%rax, 3168(%rcx)
	movq	-8(%rbp), %rax
	cmpq	$0, 3160(%rax)
	je	.LBB15_37
# BB#36:                                # %lor.lhs.false252
	movq	-8(%rbp), %rax
	cmpq	$0, 3168(%rax)
	jne	.LBB15_39
	jmp	.LBB15_37
.LBB15_38:                              # %if.else
	shll	$2, %esi
	movl	$1, %edx
                                        # kill: %ESI<def> %ESI<kill> %RSI<kill>
	callq	*%rax
	movq	-8(%rbp), %rcx
	movq	%rax, 3152(%rcx)
	movq	-8(%rbp), %rax
	cmpq	$0, 3152(%rax)
	je	.LBB15_37
.LBB15_39:                              # %sw.bb272
	movq	-8(%rbp), %rax
	movl	$14, 8(%rax)
	jmp	.LBB15_41
.LBB15_40:                              # %if.then317
                                        #   in Loop: Header=BB15_41 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_41:                              # %while.body274
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_44
# BB#42:                                # %if.end288
                                        #   in Loop: Header=BB15_41 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#43:                                # %if.end294
                                        #   in Loop: Header=BB15_41 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_41
	jmp	.LBB15_40
.LBB15_44:                              # %if.then278
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -344(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-344(%rbp), %al
	movb	%al, -9(%rbp)
	cmpb	$23, %al
	jne	.LBB15_100
.LBB15_45:                              # %sw.bb2922
	movq	-8(%rbp), %rax
	movl	$42, 8(%rax)
	jmp	.LBB15_47
	.p2align	4, 0x90
.LBB15_46:                              # %if.then2969
                                        #   in Loop: Header=BB15_47 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_47:                              # %while.body2925
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_50
# BB#48:                                # %if.end2940
                                        #   in Loop: Header=BB15_47 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#49:                                # %if.end2946
                                        #   in Loop: Header=BB15_47 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_47
	jmp	.LBB15_46
.LBB15_50:                              # %if.then2929
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -228(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-228(%rbp), %al
	movb	%al, -9(%rbp)
	cmpb	$114, %al
	jne	.LBB15_183
.LBB15_51:                              # %sw.bb2980
	movq	-8(%rbp), %rax
	movl	$43, 8(%rax)
	jmp	.LBB15_53
	.p2align	4, 0x90
.LBB15_52:                              # %if.then3027
                                        #   in Loop: Header=BB15_53 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_53:                              # %while.body2983
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_56
# BB#54:                                # %if.end2998
                                        #   in Loop: Header=BB15_53 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#55:                                # %if.end3004
                                        #   in Loop: Header=BB15_53 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_53
	jmp	.LBB15_52
.LBB15_56:                              # %if.then2987
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -224(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-224(%rbp), %al
	movb	%al, -9(%rbp)
	cmpb	$69, %al
	jne	.LBB15_183
.LBB15_57:                              # %sw.bb3038
	movq	-8(%rbp), %rax
	movl	$44, 8(%rax)
	jmp	.LBB15_59
	.p2align	4, 0x90
.LBB15_58:                              # %if.then3085
                                        #   in Loop: Header=BB15_59 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_59:                              # %while.body3041
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_62
# BB#60:                                # %if.end3056
                                        #   in Loop: Header=BB15_59 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#61:                                # %if.end3062
                                        #   in Loop: Header=BB15_59 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_59
	jmp	.LBB15_58
.LBB15_62:                              # %if.then3045
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -220(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-220(%rbp), %al
	movb	%al, -9(%rbp)
	cmpb	$56, %al
	jne	.LBB15_183
.LBB15_63:                              # %sw.bb3096
	movq	-8(%rbp), %rax
	movl	$45, 8(%rax)
	jmp	.LBB15_65
	.p2align	4, 0x90
.LBB15_64:                              # %if.then3143
                                        #   in Loop: Header=BB15_65 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_65:                              # %while.body3099
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_68
# BB#66:                                # %if.end3114
                                        #   in Loop: Header=BB15_65 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#67:                                # %if.end3120
                                        #   in Loop: Header=BB15_65 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_65
	jmp	.LBB15_64
.LBB15_68:                              # %if.then3103
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -216(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-216(%rbp), %al
	movb	%al, -9(%rbp)
	cmpb	$80, %al
	jne	.LBB15_183
.LBB15_69:                              # %sw.bb3154
	movq	-8(%rbp), %rax
	movl	$46, 8(%rax)
	jmp	.LBB15_71
	.p2align	4, 0x90
.LBB15_70:                              # %if.then3201
                                        #   in Loop: Header=BB15_71 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_71:                              # %while.body3157
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_74
# BB#72:                                # %if.end3172
                                        #   in Loop: Header=BB15_71 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#73:                                # %if.end3178
                                        #   in Loop: Header=BB15_71 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_71
	jmp	.LBB15_70
.LBB15_74:                              # %if.then3161
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -212(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-212(%rbp), %al
	movb	%al, -9(%rbp)
	cmpb	$-112, %al
	jne	.LBB15_183
# BB#75:                                # %if.end3211
	movq	-8(%rbp), %rax
	movl	$0, 3180(%rax)
.LBB15_76:                              # %sw.bb3212
	movq	-8(%rbp), %rax
	movl	$47, 8(%rax)
	jmp	.LBB15_78
	.p2align	4, 0x90
.LBB15_77:                              # %if.then3259
                                        #   in Loop: Header=BB15_78 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_78:                              # %while.body3215
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_81
# BB#79:                                # %if.end3230
                                        #   in Loop: Header=BB15_78 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#80:                                # %if.end3236
                                        #   in Loop: Header=BB15_78 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_78
	jmp	.LBB15_77
.LBB15_81:                              # %if.then3219
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -208(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-208(%rbp), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movl	3180(%rax), %ecx
	shll	$8, %ecx
	movzbl	-9(%rbp), %edx
	orl	%ecx, %edx
	movl	%edx, 3180(%rax)
.LBB15_82:                              # %sw.bb3270
	movq	-8(%rbp), %rax
	movl	$48, 8(%rax)
	jmp	.LBB15_84
	.p2align	4, 0x90
.LBB15_83:                              # %if.then3317
                                        #   in Loop: Header=BB15_84 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_84:                              # %while.body3273
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_87
# BB#85:                                # %if.end3288
                                        #   in Loop: Header=BB15_84 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#86:                                # %if.end3294
                                        #   in Loop: Header=BB15_84 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_84
	jmp	.LBB15_83
.LBB15_87:                              # %if.then3277
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -204(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-204(%rbp), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movl	3180(%rax), %ecx
	shll	$8, %ecx
	movzbl	-9(%rbp), %edx
	orl	%ecx, %edx
	movl	%edx, 3180(%rax)
.LBB15_88:                              # %sw.bb3328
	movq	-8(%rbp), %rax
	movl	$49, 8(%rax)
	jmp	.LBB15_90
	.p2align	4, 0x90
.LBB15_89:                              # %if.then3375
                                        #   in Loop: Header=BB15_90 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_90:                              # %while.body3331
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_93
# BB#91:                                # %if.end3346
                                        #   in Loop: Header=BB15_90 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#92:                                # %if.end3352
                                        #   in Loop: Header=BB15_90 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_90
	jmp	.LBB15_89
.LBB15_93:                              # %if.then3335
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -200(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-200(%rbp), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movl	3180(%rax), %ecx
	shll	$8, %ecx
	movzbl	-9(%rbp), %edx
	orl	%ecx, %edx
	movl	%edx, 3180(%rax)
.LBB15_94:                              # %sw.bb3386
	movq	-8(%rbp), %rax
	movl	$50, 8(%rax)
	jmp	.LBB15_96
	.p2align	4, 0x90
.LBB15_95:                              # %if.then3433
                                        #   in Loop: Header=BB15_96 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_96:                              # %while.body3389
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_99
# BB#97:                                # %if.end3404
                                        #   in Loop: Header=BB15_96 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#98:                                # %if.end3410
                                        #   in Loop: Header=BB15_96 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_96
	jmp	.LBB15_95
.LBB15_99:                              # %if.then3393
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -196(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-196(%rbp), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movl	3180(%rax), %ecx
	shll	$8, %ecx
	movzbl	-9(%rbp), %edx
	orl	%ecx, %edx
	movl	%edx, 3180(%rax)
	movq	-8(%rbp), %rax
	movl	$1, 8(%rax)
	movl	$4, -16(%rbp)
	jmp	.LBB15_184
.LBB15_100:                             # %if.end327
	cmpb	$49, -9(%rbp)
	jne	.LBB15_183
.LBB15_101:                             # %sw.bb333
	movq	-8(%rbp), %rax
	movl	$15, 8(%rax)
	jmp	.LBB15_103
	.p2align	4, 0x90
.LBB15_102:                             # %if.then378
                                        #   in Loop: Header=BB15_103 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_103:                             # %while.body335
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_106
# BB#104:                               # %if.end349
                                        #   in Loop: Header=BB15_103 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#105:                               # %if.end355
                                        #   in Loop: Header=BB15_103 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_103
	jmp	.LBB15_102
.LBB15_106:                             # %if.then339
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -340(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-340(%rbp), %al
	movb	%al, -9(%rbp)
	cmpb	$65, %al
	jne	.LBB15_183
.LBB15_107:                             # %sw.bb389
	movq	-8(%rbp), %rax
	movl	$16, 8(%rax)
	jmp	.LBB15_109
	.p2align	4, 0x90
.LBB15_108:                             # %if.then434
                                        #   in Loop: Header=BB15_109 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_109:                             # %while.body391
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_112
# BB#110:                               # %if.end405
                                        #   in Loop: Header=BB15_109 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#111:                               # %if.end411
                                        #   in Loop: Header=BB15_109 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_109
	jmp	.LBB15_108
.LBB15_112:                             # %if.then395
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -336(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-336(%rbp), %al
	movb	%al, -9(%rbp)
	cmpb	$89, %al
	jne	.LBB15_183
.LBB15_113:                             # %sw.bb445
	movq	-8(%rbp), %rax
	movl	$17, 8(%rax)
	jmp	.LBB15_115
	.p2align	4, 0x90
.LBB15_114:                             # %if.then490
                                        #   in Loop: Header=BB15_115 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_115:                             # %while.body447
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_118
# BB#116:                               # %if.end461
                                        #   in Loop: Header=BB15_115 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#117:                               # %if.end467
                                        #   in Loop: Header=BB15_115 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_115
	jmp	.LBB15_114
.LBB15_118:                             # %if.then451
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -332(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-332(%rbp), %al
	movb	%al, -9(%rbp)
	cmpb	$38, %al
	jne	.LBB15_183
.LBB15_119:                             # %sw.bb501
	movq	-8(%rbp), %rax
	movl	$18, 8(%rax)
	jmp	.LBB15_121
	.p2align	4, 0x90
.LBB15_120:                             # %if.then546
                                        #   in Loop: Header=BB15_121 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_121:                             # %while.body503
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_124
# BB#122:                               # %if.end517
                                        #   in Loop: Header=BB15_121 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#123:                               # %if.end523
                                        #   in Loop: Header=BB15_121 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_121
	jmp	.LBB15_120
.LBB15_124:                             # %if.then507
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -328(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-328(%rbp), %al
	movb	%al, -9(%rbp)
	cmpb	$83, %al
	jne	.LBB15_183
.LBB15_125:                             # %sw.bb557
	movq	-8(%rbp), %rax
	movl	$19, 8(%rax)
	jmp	.LBB15_127
	.p2align	4, 0x90
.LBB15_126:                             # %if.then602
                                        #   in Loop: Header=BB15_127 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_127:                             # %while.body559
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_130
# BB#128:                               # %if.end573
                                        #   in Loop: Header=BB15_127 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#129:                               # %if.end579
                                        #   in Loop: Header=BB15_127 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_127
	jmp	.LBB15_126
.LBB15_130:                             # %if.then563
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -324(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-324(%rbp), %al
	movb	%al, -9(%rbp)
	cmpb	$89, %al
	jne	.LBB15_183
# BB#131:                               # %if.end612
	movq	-8(%rbp), %rax
	incl	48(%rax)
	movq	-8(%rbp), %rax
	cmpl	$2, 52(%rax)
	jl	.LBB15_133
# BB#132:                               # %if.then616
	movq	stderr(%rip), %rdi
	movq	-8(%rbp), %rax
	movl	48(%rax), %edx
	movl	$.L.str.4, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB15_133:                             # %if.end619
	movq	-8(%rbp), %rax
	movl	$0, 3176(%rax)
.LBB15_134:                             # %sw.bb620
	movq	-8(%rbp), %rax
	movl	$20, 8(%rax)
	jmp	.LBB15_136
	.p2align	4, 0x90
.LBB15_135:                             # %if.then665
                                        #   in Loop: Header=BB15_136 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_136:                             # %while.body622
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_139
# BB#137:                               # %if.end636
                                        #   in Loop: Header=BB15_136 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#138:                               # %if.end642
                                        #   in Loop: Header=BB15_136 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_136
	jmp	.LBB15_135
.LBB15_139:                             # %if.then626
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -320(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-320(%rbp), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movl	3176(%rax), %ecx
	shll	$8, %ecx
	movzbl	-9(%rbp), %edx
	orl	%ecx, %edx
	movl	%edx, 3176(%rax)
.LBB15_140:                             # %sw.bb676
	movq	-8(%rbp), %rax
	movl	$21, 8(%rax)
	jmp	.LBB15_142
	.p2align	4, 0x90
.LBB15_141:                             # %if.then721
                                        #   in Loop: Header=BB15_142 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_142:                             # %while.body678
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_145
# BB#143:                               # %if.end692
                                        #   in Loop: Header=BB15_142 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#144:                               # %if.end698
                                        #   in Loop: Header=BB15_142 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_142
	jmp	.LBB15_141
.LBB15_145:                             # %if.then682
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -316(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-316(%rbp), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movl	3176(%rax), %ecx
	shll	$8, %ecx
	movzbl	-9(%rbp), %edx
	orl	%ecx, %edx
	movl	%edx, 3176(%rax)
.LBB15_146:                             # %sw.bb732
	movq	-8(%rbp), %rax
	movl	$22, 8(%rax)
	jmp	.LBB15_148
	.p2align	4, 0x90
.LBB15_147:                             # %if.then777
                                        #   in Loop: Header=BB15_148 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_148:                             # %while.body734
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_151
# BB#149:                               # %if.end748
                                        #   in Loop: Header=BB15_148 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#150:                               # %if.end754
                                        #   in Loop: Header=BB15_148 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_148
	jmp	.LBB15_147
.LBB15_151:                             # %if.then738
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -312(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-312(%rbp), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movl	3176(%rax), %ecx
	shll	$8, %ecx
	movzbl	-9(%rbp), %edx
	orl	%ecx, %edx
	movl	%edx, 3176(%rax)
.LBB15_152:                             # %sw.bb788
	movq	-8(%rbp), %rax
	movl	$23, 8(%rax)
	jmp	.LBB15_154
	.p2align	4, 0x90
.LBB15_153:                             # %if.then833
                                        #   in Loop: Header=BB15_154 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_154:                             # %while.body790
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_157
# BB#155:                               # %if.end804
                                        #   in Loop: Header=BB15_154 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#156:                               # %if.end810
                                        #   in Loop: Header=BB15_154 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_154
	jmp	.LBB15_153
.LBB15_157:                             # %if.then794
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -308(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-308(%rbp), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movl	3176(%rax), %ecx
	shll	$8, %ecx
	movzbl	-9(%rbp), %edx
	orl	%ecx, %edx
	movl	%edx, 3176(%rax)
.LBB15_158:                             # %sw.bb844
	movq	-8(%rbp), %rax
	movl	$24, 8(%rax)
	jmp	.LBB15_160
	.p2align	4, 0x90
.LBB15_159:                             # %if.then889
                                        #   in Loop: Header=BB15_160 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_160:                             # %while.body846
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$0, 36(%rax)
	jg	.LBB15_163
# BB#161:                               # %if.end860
                                        #   in Loop: Header=BB15_160 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#162:                               # %if.end866
                                        #   in Loop: Header=BB15_160 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_160
	jmp	.LBB15_159
.LBB15_163:                             # %if.then850
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	decl	%ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	andl	$1, %eax
	movl	%eax, -304(%rbp)
	movq	-8(%rbp), %rax
	decl	36(%rax)
	movb	-304(%rbp), %al
	movq	-8(%rbp), %rcx
	movb	%al, 20(%rcx)
	movq	-8(%rbp), %rax
	movl	$0, 56(%rax)
.LBB15_164:                             # %sw.bb895
	movq	-8(%rbp), %rax
	movl	$25, 8(%rax)
	jmp	.LBB15_166
	.p2align	4, 0x90
.LBB15_165:                             # %if.then940
                                        #   in Loop: Header=BB15_166 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_166:                             # %while.body897
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_169
# BB#167:                               # %if.end911
                                        #   in Loop: Header=BB15_166 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#168:                               # %if.end917
                                        #   in Loop: Header=BB15_166 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_166
	jmp	.LBB15_165
.LBB15_169:                             # %if.then901
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -300(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-300(%rbp), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movl	56(%rax), %ecx
	shll	$8, %ecx
	movzbl	-9(%rbp), %edx
	orl	%ecx, %edx
	movl	%edx, 56(%rax)
.LBB15_170:                             # %sw.bb951
	movq	-8(%rbp), %rax
	movl	$26, 8(%rax)
	jmp	.LBB15_172
	.p2align	4, 0x90
.LBB15_171:                             # %if.then996
                                        #   in Loop: Header=BB15_172 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_172:                             # %while.body953
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_175
# BB#173:                               # %if.end967
                                        #   in Loop: Header=BB15_172 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#174:                               # %if.end973
                                        #   in Loop: Header=BB15_172 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_172
	jmp	.LBB15_171
.LBB15_175:                             # %if.then957
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -296(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-296(%rbp), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movl	56(%rax), %ecx
	shll	$8, %ecx
	movzbl	-9(%rbp), %edx
	orl	%ecx, %edx
	movl	%edx, 56(%rax)
.LBB15_176:                             # %sw.bb1007
	movq	-8(%rbp), %rax
	movl	$27, 8(%rax)
	jmp	.LBB15_178
	.p2align	4, 0x90
.LBB15_177:                             # %if.then1052
                                        #   in Loop: Header=BB15_178 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_178:                             # %while.body1009
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$8, 36(%rax)
	jge	.LBB15_181
# BB#179:                               # %if.end1023
                                        #   in Loop: Header=BB15_178 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#180:                               # %if.end1029
                                        #   in Loop: Header=BB15_178 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_178
	jmp	.LBB15_177
.LBB15_181:                             # %if.then1013
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-8, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzbl	%al, %eax
	movl	%eax, -292(%rbp)
	movq	-8(%rbp), %rax
	addl	$-8, 36(%rax)
	movb	-292(%rbp), %al
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movl	56(%rax), %ecx
	shll	$8, %ecx
	movzbl	-9(%rbp), %edx
	orl	%ecx, %edx
	movl	%edx, 56(%rax)
	movq	-8(%rbp), %rax
	cmpl	$0, 56(%rax)
	js	.LBB15_183
# BB#182:                               # %if.end1067
	movq	-8(%rbp), %rax
	imull	$100000, 40(%rax), %ecx # imm = 0x186A0
	orl	$10, %ecx
	cmpl	%ecx, 56(%rax)
	jg	.LBB15_183
# BB#185:                               # %if.end1075
	movl	$0, -20(%rbp)
	cmpl	$15, -20(%rbp)
	jg	.LBB15_192
	jmp	.LBB15_186
.LBB15_37:                              # %if.then269
	movl	$-3, -16(%rbp)
	jmp	.LBB15_184
.LBB15_183:                             # %if.then1066
	movl	$-4, -16(%rbp)
.LBB15_184:                             # %save_state_and_return
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64036(%rcx)
	movl	-40(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64040(%rcx)
	movl	-48(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64044(%rcx)
	movl	-120(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64048(%rcx)
	movl	-108(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64052(%rcx)
	movl	-92(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64056(%rcx)
	movl	-180(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64060(%rcx)
	movl	-52(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64064(%rcx)
	movl	-68(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64068(%rcx)
	movl	-64(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64072(%rcx)
	movl	-116(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64076(%rcx)
	movl	-44(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64080(%rcx)
	movl	-60(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64084(%rcx)
	movl	-112(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64088(%rcx)
	movl	-88(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64092(%rcx)
	movl	-364(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64096(%rcx)
	movl	-28(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64100(%rcx)
	movl	-32(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64104(%rcx)
	movl	-136(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64108(%rcx)
	movl	-36(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64112(%rcx)
	movl	-84(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 64116(%rcx)
	movq	-160(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	%rax, 64120(%rcx)
	movq	-104(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	%rax, 64128(%rcx)
	movq	-152(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	%rax, 64136(%rcx)
	movl	-16(%rbp), %eax
	addq	$400, %rsp              # imm = 0x190
	popq	%rbp
	retq
.LBB15_186:                             # %sw.bb1078
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB15_188 Depth 2
	movq	-8(%rbp), %rax
	movl	$28, 8(%rax)
	jmp	.LBB15_188
	.p2align	4, 0x90
.LBB15_187:                             # %if.then1123
                                        #   in Loop: Header=BB15_188 Depth=2
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_188:                             # %while.body1080
                                        #   Parent Loop BB15_186 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-8(%rbp), %rax
	cmpl	$0, 36(%rax)
	jg	.LBB15_191
# BB#189:                               # %if.end1094
                                        #   in Loop: Header=BB15_188 Depth=2
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#190:                               # %if.end1100
                                        #   in Loop: Header=BB15_188 Depth=2
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_188
	jmp	.LBB15_187
.LBB15_191:                             # %if.then1084
                                        #   in Loop: Header=BB15_186 Depth=1
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	decl	%ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	andl	$1, %eax
	movl	%eax, -288(%rbp)
	movq	-8(%rbp), %rax
	decl	36(%rax)
	movb	-288(%rbp), %al
	movb	%al, -9(%rbp)
	cmpb	$1, %al
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	sete	3452(%rax,%rcx)
	incl	-20(%rbp)
	cmpl	$15, -20(%rbp)
	jle	.LBB15_186
.LBB15_192:                             # %for.end
	movl	$0, -20(%rbp)
	cmpl	$255, -20(%rbp)
	jg	.LBB15_194
	.p2align	4, 0x90
.LBB15_193:                             # %for.body11423
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movb	$0, 3196(%rax,%rcx)
	incl	-20(%rbp)
	cmpl	$255, -20(%rbp)
	jle	.LBB15_193
.LBB15_194:                             # %for.end1147
	movl	$0, -20(%rbp)
.LBB15_195:                             # %for.cond1148
	movq	-8(%rbp), %rdi
	cmpl	$15, -20(%rbp)
	jg	.LBB15_199
# BB#196:                               # %for.body1151
	movslq	-20(%rbp), %rax
	cmpb	$0, 3452(%rdi,%rax)
	je	.LBB15_241
# BB#197:                               # %if.then1156
	movl	$0, -40(%rbp)
	cmpl	$15, -40(%rbp)
	jg	.LBB15_241
	jmp	.LBB15_198
.LBB15_199:                             # %for.end1228
	callq	makeMaps_d
	movq	-8(%rbp), %rax
	cmpl	$0, 3192(%rax)
	je	.LBB15_183
# BB#200:                               # %if.end1232
	movq	-8(%rbp), %rax
	movl	3192(%rax), %eax
	addl	$2, %eax
	movl	%eax, -120(%rbp)
.LBB15_201:                             # %sw.bb1235
	movq	-8(%rbp), %rax
	movl	$30, 8(%rax)
	jmp	.LBB15_203
	.p2align	4, 0x90
.LBB15_202:                             # %if.then1279
                                        #   in Loop: Header=BB15_203 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_203:                             # %while.body1237
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$3, 36(%rax)
	jge	.LBB15_206
# BB#204:                               # %if.end1250
                                        #   in Loop: Header=BB15_203 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#205:                               # %if.end1256
                                        #   in Loop: Header=BB15_203 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_203
	jmp	.LBB15_202
.LBB15_206:                             # %if.then1241
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-3, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	andl	$7, %eax
	movl	%eax, -280(%rbp)
	movq	-8(%rbp), %rax
	addl	$-3, 36(%rax)
	movl	-280(%rbp), %eax
	movl	%eax, -108(%rbp)
	cmpl	$2, %eax
	jl	.LBB15_183
# BB#207:                               # %if.then1241
	cmpl	$6, %eax
	jg	.LBB15_183
.LBB15_208:                             # %sw.bb1292
	movq	-8(%rbp), %rax
	movl	$31, 8(%rax)
	jmp	.LBB15_210
	.p2align	4, 0x90
.LBB15_209:                             # %if.then1336
                                        #   in Loop: Header=BB15_210 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_210:                             # %while.body1294
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$15, 36(%rax)
	jge	.LBB15_213
# BB#211:                               # %if.end1307
                                        #   in Loop: Header=BB15_210 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#212:                               # %if.end1313
                                        #   in Loop: Header=BB15_210 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_210
	jmp	.LBB15_209
.LBB15_213:                             # %if.then1298
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-15, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	andl	$32767, %eax            # imm = 0x7FFF
	movl	%eax, -276(%rbp)
	movq	-8(%rbp), %rax
	addl	$-15, 36(%rax)
	movl	-276(%rbp), %eax
	movl	%eax, -92(%rbp)
	testl	%eax, %eax
	jle	.LBB15_183
# BB#214:                               # %if.end1345
	movl	$0, -20(%rbp)
.LBB15_215:                             # %for.cond1346
	movl	-20(%rbp), %eax
	cmpl	-92(%rbp), %eax
	jge	.LBB15_224
# BB#216:                               # %for.body1349
	movl	$0, -40(%rbp)
.LBB15_217:                             # %sw.bb1351
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB15_219 Depth 2
	movq	-8(%rbp), %rax
	movl	$32, 8(%rax)
	jmp	.LBB15_219
	.p2align	4, 0x90
.LBB15_218:                             # %if.then1397
                                        #   in Loop: Header=BB15_219 Depth=2
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_219:                             # %while.body1354
                                        #   Parent Loop BB15_217 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-8(%rbp), %rax
	cmpl	$0, 36(%rax)
	jg	.LBB15_222
# BB#220:                               # %if.end1368
                                        #   in Loop: Header=BB15_219 Depth=2
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#221:                               # %if.end1374
                                        #   in Loop: Header=BB15_219 Depth=2
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_219
	jmp	.LBB15_218
.LBB15_222:                             # %if.then1358
                                        #   in Loop: Header=BB15_217 Depth=1
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	decl	%ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	andl	$1, %eax
	movl	%eax, -272(%rbp)
	movq	-8(%rbp), %rax
	decl	36(%rax)
	movb	-272(%rbp), %al
	movb	%al, -9(%rbp)
	testb	%al, %al
	movl	-40(%rbp), %eax
	je	.LBB15_233
# BB#223:                               # %if.end1407
                                        #   in Loop: Header=BB15_217 Depth=1
	incl	%eax
	movl	%eax, -40(%rbp)
	cmpl	-108(%rbp), %eax
	jl	.LBB15_217
	jmp	.LBB15_183
.LBB15_224:                             # %for.end1419
	movb	$0, -21(%rbp)
	jmp	.LBB15_226
	.p2align	4, 0x90
.LBB15_225:                             # %for.body142612
                                        #   in Loop: Header=BB15_226 Depth=1
	movzbl	-21(%rbp), %eax
	movb	%al, -191(%rbp,%rax)
	incb	-21(%rbp)
.LBB15_226:                             # %for.cond14229
                                        # =>This Inner Loop Header: Depth=1
	movzbl	-21(%rbp), %eax
	cmpl	-108(%rbp), %eax
	jl	.LBB15_225
# BB#227:                               # %for.end1431
	movl	$0, -20(%rbp)
	jmp	.LBB15_229
	.p2align	4, 0x90
.LBB15_228:                             # %while.end1452
                                        #   in Loop: Header=BB15_229 Depth=1
	movb	-54(%rbp), %al
	movb	%al, -191(%rbp)
	movb	-54(%rbp), %al
	movq	-8(%rbp), %rcx
	movslq	-20(%rbp), %rdx
	movb	%al, 7884(%rcx,%rdx)
	incl	-20(%rbp)
.LBB15_229:                             # %for.cond1432
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB15_232 Depth 2
	movl	-20(%rbp), %eax
	cmpl	-92(%rbp), %eax
	jge	.LBB15_242
# BB#230:                               # %for.body1435
                                        #   in Loop: Header=BB15_229 Depth=1
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movb	25886(%rax,%rcx), %al
	movb	%al, -21(%rbp)
	movzbl	-21(%rbp), %eax
	movb	-191(%rbp,%rax), %al
	movb	%al, -54(%rbp)
	jmp	.LBB15_232
	.p2align	4, 0x90
.LBB15_231:                             # %while.body1444
                                        #   in Loop: Header=BB15_232 Depth=2
	movzbl	-21(%rbp), %eax
	movzbl	-192(%rbp,%rax), %ecx
	movb	%cl, -191(%rbp,%rax)
	decb	-21(%rbp)
.LBB15_232:                             # %while.cond
                                        #   Parent Loop BB15_229 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	-21(%rbp), %eax
	testl	%eax, %eax
	jg	.LBB15_231
	jmp	.LBB15_228
.LBB15_242:                             # %for.end1458
	movl	$0, -48(%rbp)
	jmp	.LBB15_243
.LBB15_233:                             # %while.end1413
	movq	-8(%rbp), %rcx
	movslq	-20(%rbp), %rdx
	movb	%al, 25886(%rcx,%rdx)
	incl	-20(%rbp)
	jmp	.LBB15_215
.LBB15_198:                             # %sw.bb1161
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB15_235 Depth 2
	movq	-8(%rbp), %rax
	movl	$29, 8(%rax)
	jmp	.LBB15_235
	.p2align	4, 0x90
.LBB15_234:                             # %if.then1206
                                        #   in Loop: Header=BB15_235 Depth=2
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_235:                             # %while.body1163
                                        #   Parent Loop BB15_198 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-8(%rbp), %rax
	cmpl	$0, 36(%rax)
	jg	.LBB15_238
# BB#236:                               # %if.end1177
                                        #   in Loop: Header=BB15_235 Depth=2
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#237:                               # %if.end1183
                                        #   in Loop: Header=BB15_235 Depth=2
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_235
	jmp	.LBB15_234
.LBB15_238:                             # %if.then1167
                                        #   in Loop: Header=BB15_198 Depth=1
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	decl	%ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	andl	$1, %eax
	movl	%eax, -284(%rbp)
	movq	-8(%rbp), %rax
	decl	36(%rax)
	movb	-284(%rbp), %al
	movb	%al, -9(%rbp)
	cmpb	$1, %al
	jne	.LBB15_240
# BB#239:                               # %if.then1215
                                        #   in Loop: Header=BB15_198 Depth=1
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	shlq	$4, %rcx
	movslq	-40(%rbp), %rdx
	addq	%rcx, %rdx
	movb	$1, 3196(%rax,%rdx)
.LBB15_240:                             # %for.inc1222
                                        #   in Loop: Header=BB15_198 Depth=1
	incl	-40(%rbp)
	cmpl	$15, -40(%rbp)
	jle	.LBB15_198
.LBB15_241:                             # %for.inc1226
	incl	-20(%rbp)
	jmp	.LBB15_195
.LBB15_243:                             # %for.cond1459
	movl	-48(%rbp), %eax
	cmpl	-108(%rbp), %eax
	jge	.LBB15_249
.LBB15_244:                             # %sw.bb1463
	movq	-8(%rbp), %rax
	movl	$33, 8(%rax)
	jmp	.LBB15_246
	.p2align	4, 0x90
.LBB15_245:                             # %if.then1509
                                        #   in Loop: Header=BB15_246 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_246:                             # %while.body1466
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$5, 36(%rax)
	jge	.LBB15_274
# BB#247:                               # %if.end1480
                                        #   in Loop: Header=BB15_246 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#248:                               # %if.end1486
                                        #   in Loop: Header=BB15_246 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_246
	jmp	.LBB15_245
.LBB15_274:                             # %if.then1470
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	addl	$-5, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	andl	$31, %eax
	movl	%eax, -268(%rbp)
	movq	-8(%rbp), %rax
	addl	$-5, 36(%rax)
	movl	-268(%rbp), %eax
	movl	%eax, -88(%rbp)
	movl	$0, -20(%rbp)
	jmp	.LBB15_275
.LBB15_249:                             # %for.end1658
	movl	$0, -48(%rbp)
	jmp	.LBB15_251
	.p2align	4, 0x90
.LBB15_250:                             # %for.end1701
                                        #   in Loop: Header=BB15_251 Depth=1
	movslq	-48(%rbp), %rcx
	imulq	$1032, %rcx, %rdx       # imm = 0x408
	leaq	45436(%rax,%rdx), %rdi
	movq	-8(%rbp), %rax
	leaq	51628(%rax,%rdx), %rsi
	leaq	57820(%rax,%rdx), %rdx
	imulq	$258, %rcx, %rcx        # imm = 0x102
	leaq	43888(%rax,%rcx), %rcx
	movl	-140(%rbp), %r8d
	movl	-184(%rbp), %r9d
	movl	-120(%rbp), %eax
	movl	%eax, (%rsp)
	callq	BZ2_hbCreateDecodeTables
	movl	-140(%rbp), %eax
	movq	-8(%rbp), %rcx
	movslq	-48(%rbp), %rdx
	movl	%eax, 64012(%rcx,%rdx,4)
	incl	-48(%rbp)
.LBB15_251:                             # %for.cond1659
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB15_254 Depth 2
	movl	-48(%rbp), %eax
	cmpl	-108(%rbp), %eax
	jge	.LBB15_259
# BB#252:                               # %for.body1662
                                        #   in Loop: Header=BB15_251 Depth=1
	movl	$32, -140(%rbp)
	movl	$0, -184(%rbp)
	movl	$0, -20(%rbp)
	jmp	.LBB15_254
	.p2align	4, 0x90
.LBB15_253:                             # %for.inc1699
                                        #   in Loop: Header=BB15_254 Depth=2
	incl	-20(%rbp)
.LBB15_254:                             # %for.cond1663
                                        #   Parent Loop BB15_251 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-20(%rbp), %ecx
	movq	-8(%rbp), %rax
	cmpl	-120(%rbp), %ecx
	jge	.LBB15_250
# BB#255:                               # %for.body1666
                                        #   in Loop: Header=BB15_254 Depth=2
	movslq	-48(%rbp), %rcx
	imulq	$258, %rcx, %rcx        # imm = 0x102
	addq	%rcx, %rax
	movslq	-20(%rbp), %rcx
	movzbl	43888(%rcx,%rax), %eax
	cmpl	-184(%rbp), %eax
	jle	.LBB15_257
# BB#256:                               # %if.then1675
                                        #   in Loop: Header=BB15_254 Depth=2
	movslq	-48(%rbp), %rax
	imulq	$258, %rax, %rax        # imm = 0x102
	addq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movzbl	43888(%rcx,%rax), %eax
	movl	%eax, -184(%rbp)
.LBB15_257:                             # %if.end1682
                                        #   in Loop: Header=BB15_254 Depth=2
	movslq	-48(%rbp), %rax
	imulq	$258, %rax, %rax        # imm = 0x102
	addq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movzbl	43888(%rcx,%rax), %eax
	cmpl	-140(%rbp), %eax
	jge	.LBB15_253
# BB#258:                               # %if.then1691
                                        #   in Loop: Header=BB15_254 Depth=2
	movslq	-48(%rbp), %rax
	imulq	$258, %rax, %rax        # imm = 0x102
	addq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movzbl	43888(%rcx,%rax), %eax
	movl	%eax, -140(%rbp)
	jmp	.LBB15_253
.LBB15_259:                             # %for.end1719
	movq	-8(%rbp), %rax
	movl	3192(%rax), %eax
	incl	%eax
	movl	%eax, -180(%rbp)
	movq	-8(%rbp), %rax
	imull	$100000, 40(%rax), %eax # imm = 0x186A0
	movl	%eax, -116(%rbp)
	movl	$-1, -52(%rbp)
	movl	$0, -68(%rbp)
	movl	$0, -20(%rbp)
	cmpl	$255, -20(%rbp)
	jg	.LBB15_261
	.p2align	4, 0x90
.LBB15_260:                             # %for.body1727
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	$0, 68(%rax,%rcx,4)
	incl	-20(%rbp)
	cmpl	$255, -20(%rbp)
	jle	.LBB15_260
.LBB15_261:                             # %for.end1732
	movl	$4095, -172(%rbp)       # imm = 0xFFF
	movl	$15, -132(%rbp)
	cmpl	$0, -132(%rbp)
	js	.LBB15_262
	.p2align	4, 0x90
.LBB15_268:                             # %for.body1739
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB15_269 Depth 2
	movl	$15, -176(%rbp)
	cmpl	$0, -176(%rbp)
	js	.LBB15_267
	.p2align	4, 0x90
.LBB15_269:                             # %for.body1743
                                        #   Parent Loop BB15_268 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-132(%rbp), %eax
	shll	$4, %eax
	addl	-176(%rbp), %eax
	movq	-8(%rbp), %rcx
	movslq	-172(%rbp), %rdx
	movb	%al, 3724(%rcx,%rdx)
	decl	-172(%rbp)
	decl	-176(%rbp)
	cmpl	$0, -176(%rbp)
	jns	.LBB15_269
.LBB15_267:                             # %for.end1752
                                        #   in Loop: Header=BB15_268 Depth=1
	movl	-172(%rbp), %eax
	incl	%eax
	movq	-8(%rbp), %rcx
	movslq	-132(%rbp), %rdx
	movl	%eax, 7820(%rcx,%rdx,4)
	decl	-132(%rbp)
	cmpl	$0, -132(%rbp)
	jns	.LBB15_268
.LBB15_262:                             # %for.end1758
	movl	$0, -44(%rbp)
	xorl	%eax, %eax
	testb	%al, %al
	jne	.LBB15_265
# BB#263:                               # %if.then1761
	movl	-52(%rbp), %eax
	incl	%eax
	movl	%eax, -52(%rbp)
	cmpl	-92(%rbp), %eax
	jge	.LBB15_183
# BB#264:                               # %if.end1766
	movl	$50, -68(%rbp)
	movq	-8(%rbp), %rax
	movslq	-52(%rbp), %rcx
	movzbl	7884(%rax,%rcx), %eax
	movl	%eax, -36(%rbp)
	movq	-8(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	64012(%rax,%rcx,4), %eax
	movl	%eax, -84(%rbp)
	movq	-8(%rbp), %rax
	movslq	-36(%rbp), %rcx
	imulq	$1032, %rcx, %rcx       # imm = 0x408
	leaq	45436(%rax,%rcx), %rax
	movq	%rax, -160(%rbp)
	movq	-8(%rbp), %rax
	movslq	-36(%rbp), %rcx
	imulq	$1032, %rcx, %rcx       # imm = 0x408
	leaq	57820(%rax,%rcx), %rax
	movq	%rax, -152(%rbp)
	movq	-8(%rbp), %rax
	movslq	-36(%rbp), %rcx
	imulq	$1032, %rcx, %rcx       # imm = 0x408
	leaq	51628(%rax,%rcx), %rax
	movq	%rax, -104(%rbp)
.LBB15_265:                             # %if.end1786
	decl	-68(%rbp)
	movl	-84(%rbp), %eax
	movl	%eax, -28(%rbp)
.LBB15_266:                             # %sw.bb1788
	movq	-8(%rbp), %rax
	movl	$36, 8(%rax)
	jmp	.LBB15_271
	.p2align	4, 0x90
.LBB15_270:                             # %if.then1836
                                        #   in Loop: Header=BB15_271 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_271:                             # %while.body1791
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movl	36(%rax), %ecx
	cmpl	-28(%rbp), %ecx
	jge	.LBB15_295
# BB#272:                               # %if.end1807
                                        #   in Loop: Header=BB15_271 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#273:                               # %if.end1813
                                        #   in Loop: Header=BB15_271 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_271
	jmp	.LBB15_270
.LBB15_295:                             # %if.then1795
	movl	32(%rax), %edx
	movq	-8(%rbp), %rax
	movl	36(%rax), %ecx
	movl	-28(%rbp), %eax
	subl	%eax, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %edx
	movl	$1, %esi
	movl	%eax, %ecx
	shll	%cl, %esi
	decl	%esi
	andl	%edx, %esi
	movl	%esi, -256(%rbp)
	movl	-28(%rbp), %eax
	movq	-8(%rbp), %rcx
	subl	%eax, 36(%rcx)
	movl	-256(%rbp), %eax
	movl	%eax, -32(%rbp)
	cmpl	$21, -28(%rbp)
	jge	.LBB15_183
	jmp	.LBB15_297
.LBB15_275:                             # %for.cond1515
	movl	-20(%rbp), %eax
	cmpl	-120(%rbp), %eax
	jl	.LBB15_279
# BB#276:                               # %for.inc1656
	incl	-48(%rbp)
	jmp	.LBB15_243
.LBB15_277:                             # %if.then1642
	incl	%eax
.LBB15_278:                             # %while.body1520
	movl	%eax, -88(%rbp)
.LBB15_279:                             # %while.body1520
	movl	-88(%rbp), %eax
	testl	%eax, %eax
	jle	.LBB15_183
# BB#280:                               # %while.body1520
	cmpl	$21, %eax
	jge	.LBB15_183
.LBB15_281:                             # %sw.bb1528
	movq	-8(%rbp), %rax
	movl	$34, 8(%rax)
	jmp	.LBB15_283
	.p2align	4, 0x90
.LBB15_282:                             # %if.then1575
                                        #   in Loop: Header=BB15_283 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_283:                             # %while.body1531
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$0, 36(%rax)
	jg	.LBB15_286
# BB#284:                               # %if.end1546
                                        #   in Loop: Header=BB15_283 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#285:                               # %if.end1552
                                        #   in Loop: Header=BB15_283 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_283
	jmp	.LBB15_282
.LBB15_286:                             # %if.then1535
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	decl	%ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	andl	$1, %eax
	movl	%eax, -264(%rbp)
	movq	-8(%rbp), %rax
	decl	36(%rax)
	movb	-264(%rbp), %al
	movb	%al, -9(%rbp)
	testb	%al, %al
	je	.LBB15_294
.LBB15_287:                             # %sw.bb1586
	movq	-8(%rbp), %rax
	movl	$35, 8(%rax)
	jmp	.LBB15_289
	.p2align	4, 0x90
.LBB15_288:                             # %if.then1633
                                        #   in Loop: Header=BB15_289 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_289:                             # %while.body1589
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$0, 36(%rax)
	jg	.LBB15_292
# BB#290:                               # %if.end1604
                                        #   in Loop: Header=BB15_289 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#291:                               # %if.end1610
                                        #   in Loop: Header=BB15_289 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_289
	jmp	.LBB15_288
.LBB15_292:                             # %if.then1593
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	decl	%ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	andl	$1, %eax
	movl	%eax, -260(%rbp)
	movq	-8(%rbp), %rax
	decl	36(%rax)
	movb	-260(%rbp), %al
	movb	%al, -9(%rbp)
	testb	%al, %al
	movl	-88(%rbp), %eax
	je	.LBB15_277
# BB#293:                               # %if.else1644
	decl	%eax
	jmp	.LBB15_278
.LBB15_294:                             # %while.end1647
	movb	-88(%rbp), %al
	movslq	-48(%rbp), %rcx
	imulq	$258, %rcx, %rcx        # imm = 0x102
	addq	-8(%rbp), %rcx
	movslq	-20(%rbp), %rdx
	movb	%al, 43888(%rdx,%rcx)
	incl	-20(%rbp)
	jmp	.LBB15_275
.LBB15_296:                             # %if.then1862
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	decl	%ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	andl	$1, %eax
	movl	%eax, -252(%rbp)
	movq	-8(%rbp), %rax
	decl	36(%rax)
	movl	-252(%rbp), %eax
	movl	%eax, -136(%rbp)
	movl	-32(%rbp), %ecx
	addl	%ecx, %ecx
	orl	%eax, %ecx
	movl	%ecx, -32(%rbp)
	cmpl	$21, -28(%rbp)
	jge	.LBB15_183
.LBB15_297:                             # %if.end1847
	movl	-32(%rbp), %eax
	movq	-160(%rbp), %rcx
	movslq	-28(%rbp), %rdx
	cmpl	(%rcx,%rdx,4), %eax
	jle	.LBB15_298
# BB#309:                               # %if.end1853
	incl	-28(%rbp)
.LBB15_310:                             # %sw.bb1855
	movq	-8(%rbp), %rax
	movl	$37, 8(%rax)
	jmp	.LBB15_312
	.p2align	4, 0x90
.LBB15_311:                             # %if.then1901
                                        #   in Loop: Header=BB15_312 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_312:                             # %while.body1858
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$0, 36(%rax)
	jg	.LBB15_296
# BB#313:                               # %if.end1872
                                        #   in Loop: Header=BB15_312 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#314:                               # %if.end1878
                                        #   in Loop: Header=BB15_312 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_312
	jmp	.LBB15_311
.LBB15_298:                             # %while.end1909
	movl	-32(%rbp), %eax
	movq	-104(%rbp), %rcx
	movslq	-28(%rbp), %rdx
	cmpl	(%rcx,%rdx,4), %eax
	js	.LBB15_183
# BB#299:                               # %lor.lhs.false1915
	movl	-32(%rbp), %eax
	movq	-104(%rbp), %rcx
	movslq	-28(%rbp), %rdx
	subl	(%rcx,%rdx,4), %eax
	cmpl	$258, %eax              # imm = 0x102
	jge	.LBB15_183
# BB#300:                               # %if.end1922
	movq	-152(%rbp), %rax
	movslq	-32(%rbp), %rcx
	movq	-104(%rbp), %rdx
	movslq	-28(%rbp), %rsi
	movslq	(%rdx,%rsi,4), %rdx
	subq	%rdx, %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -64(%rbp)
.LBB15_301:                             # %while.body1929
	movl	-64(%rbp), %eax
	cmpl	-180(%rbp), %eax
	jne	.LBB15_315
# BB#302:                               # %while.end2549
	movq	-8(%rbp), %rax
	cmpl	$0, 56(%rax)
	js	.LBB15_183
# BB#303:                               # %lor.lhs.false2553
	movq	-8(%rbp), %rax
	movl	56(%rax), %eax
	cmpl	-44(%rbp), %eax
	jge	.LBB15_183
# BB#304:                               # %if.end2558
	movq	-8(%rbp), %rax
	movl	$0, 16(%rax)
	movq	-8(%rbp), %rax
	movb	$0, 12(%rax)
	movq	-8(%rbp), %rax
	movl	$-1, 3184(%rax)
	movq	-8(%rbp), %rax
	movl	$2, 8(%rax)
	movq	-8(%rbp), %rax
	cmpl	$2, 52(%rax)
	jl	.LBB15_306
# BB#305:                               # %if.then2563
	movq	stderr(%rip), %rdi
	movl	$.L.str.5, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB15_306:                             # %if.end2565
	movq	-8(%rbp), %rax
	movl	$0, 1096(%rax)
	movl	$1, -20(%rbp)
	cmpl	$256, -20(%rbp)         # imm = 0x100
	jg	.LBB15_308
.LBB15_307:                             # %for.body2570
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	64(%rax,%rcx,4), %edx
	movl	%edx, 1096(%rax,%rcx,4)
	incl	-20(%rbp)
	cmpl	$256, -20(%rbp)         # imm = 0x100
	jle	.LBB15_307
.LBB15_308:                             # %for.end2580
	movl	$1, -20(%rbp)
	jmp	.LBB15_337
.LBB15_336:                             # %for.body2584
                                        #   in Loop: Header=BB15_337 Depth=1
	movslq	-20(%rbp), %rcx
	movl	1092(%rax,%rcx,4), %eax
	movq	-8(%rbp), %rdx
	addl	%eax, 1096(%rdx,%rcx,4)
	incl	-20(%rbp)
.LBB15_337:                             # %for.cond2581
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$256, -20(%rbp)         # imm = 0x100
	jle	.LBB15_336
# BB#338:                               # %for.end2595
	cmpb	$0, 44(%rax)
	movl	$0, -20(%rbp)
	jne	.LBB15_340
	jmp	.LBB15_348
.LBB15_339:                             # %for.body2602
                                        #   in Loop: Header=BB15_340 Depth=1
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	1096(%rax,%rcx,4), %edx
	movl	%edx, 2124(%rax,%rcx,4)
	incl	-20(%rbp)
.LBB15_340:                             # %for.cond2599
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$256, -20(%rbp)         # imm = 0x100
	jle	.LBB15_339
# BB#341:                               # %for.end2610
	movl	$0, -20(%rbp)
	jmp	.LBB15_344
.LBB15_343:                             # %if.end2665
                                        #   in Loop: Header=BB15_344 Depth=1
	movq	3168(%rdx), %rcx
	movl	-20(%rbp), %edx
	sarl	%edx
	movslq	%edx, %rdx
	movb	%al, (%rcx,%rdx)
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
	incl	2124(%rax,%rcx,4)
	incl	-20(%rbp)
.LBB15_344:                             # %for.cond2611
                                        # =>This Inner Loop Header: Depth=1
	movl	-20(%rbp), %ecx
	movq	-8(%rbp), %rax
	cmpl	-44(%rbp), %ecx
	jge	.LBB15_356
# BB#345:                               # %for.body2614
                                        #   in Loop: Header=BB15_344 Depth=1
	movq	3160(%rax), %rax
	movslq	-20(%rbp), %rcx
	movzbl	(%rax,%rcx,2), %eax
	movb	%al, -9(%rbp)
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
	movzwl	2124(%rax,%rcx,4), %ecx
	movq	3160(%rax), %rax
	movslq	-20(%rbp), %rdx
	movw	%cx, (%rax,%rdx,2)
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	movq	3168(%rcx), %rcx
	movl	%eax, %edx
	sarl	%edx
	movslq	%edx, %rdx
	movzbl	(%rcx,%rdx), %ecx
	testb	$1, %al
	jne	.LBB15_342
# BB#346:                               # %if.then2630
                                        #   in Loop: Header=BB15_344 Depth=1
	andl	$240, %ecx
	movq	-8(%rbp), %rdx
	movzbl	-9(%rbp), %eax
	movzwl	2126(%rdx,%rax,4), %eax
	orl	%ecx, %eax
	jmp	.LBB15_343
.LBB15_342:                             # %if.else2647
                                        #   in Loop: Header=BB15_344 Depth=1
	andl	$15, %ecx
	movq	-8(%rbp), %rdx
	movzbl	-9(%rbp), %eax
	movzwl	2126(%rdx,%rax,4), %eax
	shll	$4, %eax
	orl	%ecx, %eax
	jmp	.LBB15_343
.LBB15_347:                             # %for.body2833
                                        #   in Loop: Header=BB15_348 Depth=1
	movslq	-20(%rbp), %rcx
	movzbl	(%rax,%rcx,4), %eax
	movb	%al, -9(%rbp)
	movl	-20(%rbp), %eax
	shll	$8, %eax
	movq	-8(%rbp), %rcx
	movq	3152(%rcx), %rdx
	movzbl	-9(%rbp), %esi
	movslq	1096(%rcx,%rsi,4), %rcx
	orl	%eax, (%rdx,%rcx,4)
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
	incl	1096(%rax,%rcx,4)
	incl	-20(%rbp)
.LBB15_348:                             # %for.cond2830
                                        # =>This Inner Loop Header: Depth=1
	movl	-20(%rbp), %ecx
	movq	-8(%rbp), %rax
	movq	3152(%rax), %rax
	cmpl	-44(%rbp), %ecx
	jl	.LBB15_347
# BB#349:                               # %for.end2853
	movq	-8(%rbp), %rcx
	movslq	56(%rcx), %rdx
	movl	(%rax,%rdx,4), %eax
	shrl	$8, %eax
	movl	%eax, 60(%rcx)
	movq	-8(%rbp), %rax
	movl	$0, 1092(%rax)
	movq	-8(%rbp), %rax
	cmpb	$0, 20(%rax)
	je	.LBB15_388
# BB#350:                               # %if.then2863
	movl	$0, 24(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 28(%rax)
	movq	-8(%rbp), %rax
	movq	3152(%rax), %rcx
	movl	60(%rax), %edx
	movl	(%rcx,%rdx,4), %ecx
	movl	%ecx, 60(%rax)
	movq	-8(%rbp), %rax
	movzbl	60(%rax), %ecx
	movl	%ecx, 64(%rax)
	movq	-8(%rbp), %rax
	shrl	$8, 60(%rax)
	jmp	.LBB15_363
.LBB15_315:                             # %if.end1933
	movl	-64(%rbp), %eax
	testl	%eax, %eax
	je	.LBB15_321
# BB#316:                               # %if.end1933
	cmpl	$1, %eax
	je	.LBB15_321
# BB#317:                               # %if.else2174
	movl	-44(%rbp), %eax
	cmpl	-116(%rbp), %eax
	jge	.LBB15_183
# BB#318:                               # %if.end2178
	movl	-64(%rbp), %eax
	decl	%eax
	movl	%eax, -72(%rbp)
	cmpl	$15, %eax
	ja	.LBB15_367
# BB#319:                               # %if.then2192
	movq	-8(%rbp), %rax
	movl	7820(%rax), %eax
	movl	%eax, -76(%rbp)
	movq	-8(%rbp), %rcx
	addl	-72(%rbp), %eax
	movb	3724(%rcx,%rax), %al
	movb	%al, -9(%rbp)
	cmpl	$3, -72(%rbp)
	jbe	.LBB15_352
.LBB15_320:                             # %while.body2202
                                        # =>This Inner Loop Header: Depth=1
	movl	-76(%rbp), %eax
	addl	-72(%rbp), %eax
	movl	%eax, -124(%rbp)
	movq	-8(%rbp), %rax
	movslq	-124(%rbp), %rcx
	movzbl	3723(%rax,%rcx), %edx
	movb	%dl, 3724(%rax,%rcx)
	movq	-8(%rbp), %rax
	movslq	-124(%rbp), %rcx
	movzbl	3722(%rax,%rcx), %edx
	movb	%dl, 3723(%rax,%rcx)
	movq	-8(%rbp), %rax
	movslq	-124(%rbp), %rcx
	movzbl	3721(%rax,%rcx), %edx
	movb	%dl, 3722(%rax,%rcx)
	movq	-8(%rbp), %rax
	movslq	-124(%rbp), %rcx
	movzbl	3720(%rax,%rcx), %edx
	movb	%dl, 3721(%rax,%rcx)
	addl	$-4, -72(%rbp)
	cmpl	$3, -72(%rbp)
	ja	.LBB15_320
	jmp	.LBB15_352
.LBB15_351:                             # %while.body2241
                                        #   in Loop: Header=BB15_352 Depth=1
	movq	-8(%rbp), %rax
	movl	-76(%rbp), %ecx
	movl	-72(%rbp), %edx
	leal	(%rcx,%rdx), %esi
	leal	-1(%rcx,%rdx), %ecx
	movzbl	3724(%rax,%rcx), %ecx
	movb	%cl, 3724(%rax,%rsi)
	decl	-72(%rbp)
.LBB15_352:                             # %while.cond2238
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$0, -72(%rbp)
	jne	.LBB15_351
# BB#353:                               # %while.end2252
	movb	-9(%rbp), %al
	movq	-8(%rbp), %rcx
	movslq	-76(%rbp), %rdx
	movb	%al, 3724(%rcx,%rdx)
	jmp	.LBB15_354
.LBB15_321:                             # %if.then1939
	movl	$-1, -60(%rbp)
	movl	$1, -112(%rbp)
.LBB15_322:                             # %do.body
	cmpl	$0, -64(%rbp)
	je	.LBB15_325
# BB#323:                               # %if.else1945
	cmpl	$1, -64(%rbp)
	jne	.LBB15_327
# BB#324:                               # %if.then1948
	movl	-112(%rbp), %eax
	addl	%eax, %eax
	jmp	.LBB15_326
.LBB15_325:                             # %if.then1942
	movl	-112(%rbp), %eax
.LBB15_326:                             # %if.end1952
	addl	%eax, -60(%rbp)
.LBB15_327:                             # %if.end1952
	shll	-112(%rbp)
	cmpl	$0, -68(%rbp)
	jne	.LBB15_330
# BB#328:                               # %if.then1956
	movl	-52(%rbp), %eax
	incl	%eax
	movl	%eax, -52(%rbp)
	cmpl	-92(%rbp), %eax
	jge	.LBB15_183
# BB#329:                               # %if.end1961
	movl	$50, -68(%rbp)
	movq	-8(%rbp), %rax
	movslq	-52(%rbp), %rcx
	movzbl	7884(%rax,%rcx), %eax
	movl	%eax, -36(%rbp)
	movq	-8(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	64012(%rax,%rcx,4), %eax
	movl	%eax, -84(%rbp)
	movq	-8(%rbp), %rax
	movslq	-36(%rbp), %rcx
	imulq	$1032, %rcx, %rcx       # imm = 0x408
	leaq	45436(%rax,%rcx), %rax
	movq	%rax, -160(%rbp)
	movq	-8(%rbp), %rax
	movslq	-36(%rbp), %rcx
	imulq	$1032, %rcx, %rcx       # imm = 0x408
	leaq	57820(%rax,%rcx), %rax
	movq	%rax, -152(%rbp)
	movq	-8(%rbp), %rax
	movslq	-36(%rbp), %rcx
	imulq	$1032, %rcx, %rcx       # imm = 0x408
	leaq	51628(%rax,%rcx), %rax
	movq	%rax, -104(%rbp)
.LBB15_330:                             # %if.end1981
	decl	-68(%rbp)
	movl	-84(%rbp), %eax
	movl	%eax, -28(%rbp)
.LBB15_331:                             # %sw.bb1983
	movq	-8(%rbp), %rax
	movl	$38, 8(%rax)
	jmp	.LBB15_333
.LBB15_332:                             # %if.then2031
                                        #   in Loop: Header=BB15_333 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_333:                             # %while.body1986
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movl	36(%rax), %ecx
	cmpl	-28(%rbp), %ecx
	jge	.LBB15_391
# BB#334:                               # %if.end2002
                                        #   in Loop: Header=BB15_333 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#335:                               # %if.end2008
                                        #   in Loop: Header=BB15_333 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_333
	jmp	.LBB15_332
.LBB15_391:                             # %if.then1990
	movl	32(%rax), %edx
	movq	-8(%rbp), %rax
	movl	36(%rax), %ecx
	movl	-28(%rbp), %eax
	subl	%eax, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %edx
	movl	$1, %esi
	movl	%eax, %ecx
	shll	%cl, %esi
	decl	%esi
	andl	%edx, %esi
	movl	%esi, -248(%rbp)
	movl	-28(%rbp), %eax
	movq	-8(%rbp), %rcx
	subl	%eax, 36(%rcx)
	movl	-248(%rbp), %eax
	movl	%eax, -32(%rbp)
	cmpl	$21, -28(%rbp)
	jge	.LBB15_183
	jmp	.LBB15_393
.LBB15_356:                             # %for.end2672
	movl	56(%rax), %eax
	movl	%eax, -20(%rbp)
	movq	-8(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movq	3160(%rax), %rdx
	movq	3168(%rax), %rax
	movzwl	(%rdx,%rcx,2), %edx
	movl	%ecx, %esi
	sarl	%esi
	movslq	%esi, %rsi
	movzbl	(%rax,%rsi), %eax
	shlb	$2, %cl
	andb	$4, %cl
                                        # kill: %CL<def> %CL<kill> %RCX<kill>
	shrl	%cl, %eax
	andl	$15, %eax
	shll	$16, %eax
	orl	%edx, %eax
	movl	%eax, -40(%rbp)
.LBB15_357:                             # %do.body2689
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movq	3160(%rax), %rdx
	movq	3168(%rax), %rax
	movzwl	(%rdx,%rcx,2), %edx
	movl	%ecx, %esi
	sarl	%esi
	movslq	%esi, %rsi
	movzbl	(%rax,%rsi), %eax
	shlb	$2, %cl
	andb	$4, %cl
                                        # kill: %CL<def> %CL<kill> %RCX<kill>
	shrl	%cl, %eax
	andl	$15, %eax
	shll	$16, %eax
	orl	%edx, %eax
	movl	%eax, -232(%rbp)
	movzwl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	movq	3160(%rcx), %rcx
	movslq	-40(%rbp), %rdx
	movw	%ax, (%rcx,%rdx,2)
	movl	-40(%rbp), %eax
	movq	-8(%rbp), %rcx
	movq	3168(%rcx), %rcx
	movl	%eax, %edx
	sarl	%edx
	movslq	%edx, %rdx
	movzbl	(%rcx,%rdx), %ecx
	testb	$1, %al
	jne	.LBB15_359
# BB#358:                               # %if.then2715
                                        #   in Loop: Header=BB15_357 Depth=1
	andl	$240, %ecx
	movzwl	-18(%rbp), %eax
	orl	%ecx, %eax
	jmp	.LBB15_360
.LBB15_359:                             # %if.else2729
                                        #   in Loop: Header=BB15_357 Depth=1
	andl	$15, %ecx
	movzwl	-18(%rbp), %eax
	shll	$4, %eax
	orl	%ecx, %eax
.LBB15_360:                             # %if.end2744
                                        #   in Loop: Header=BB15_357 Depth=1
	movq	-8(%rbp), %rcx
	movq	3168(%rcx), %rcx
	movl	-40(%rbp), %edx
	sarl	%edx
	movslq	%edx, %rdx
	movb	%al, (%rcx,%rdx)
	movl	-40(%rbp), %eax
	movl	%eax, -20(%rbp)
	movl	-232(%rbp), %eax
	movl	%eax, -40(%rbp)
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	56(%rcx), %eax
	jne	.LBB15_357
# BB#361:                               # %do.end2749
	movq	-8(%rbp), %rax
	movl	56(%rax), %ecx
	movl	%ecx, 60(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 1092(%rax)
	movq	-8(%rbp), %rax
	cmpb	$0, 20(%rax)
	je	.LBB15_423
# BB#362:                               # %if.then2753
	movl	$0, 24(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 28(%rax)
	movq	-8(%rbp), %rsi
	movl	60(%rsi), %edi
	addq	$1096, %rsi             # imm = 0x448
	callq	BZ2_indexIntoF
	movq	-8(%rbp), %rcx
	movl	%eax, 64(%rcx)
	movq	-8(%rbp), %rax
	movq	3160(%rax), %rdx
	movl	60(%rax), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rax), %rsi
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
	movl	%esi, 60(%rax)
.LBB15_363:                             # %if.then2753
	movq	-8(%rbp), %rax
	incl	1092(%rax)
	movq	-8(%rbp), %rax
	cmpl	$0, 24(%rax)
	jne	.LBB15_366
# BB#364:                               # %if.then2781
	movq	-8(%rbp), %rax
	movslq	28(%rax), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rax)
	movq	-8(%rbp), %rax
	incl	28(%rax)
	movq	-8(%rbp), %rax
	cmpl	$512, 28(%rax)          # imm = 0x200
	jne	.LBB15_366
# BB#365:                               # %if.then2791
	movq	-8(%rbp), %rax
	movl	$0, 28(%rax)
.LBB15_366:                             # %if.end2794
	movq	-8(%rbp), %rax
	decl	24(%rax)
	movq	-8(%rbp), %rax
	xorl	%ecx, %ecx
	cmpl	$1, 24(%rax)
	sete	%cl
	xorl	%ecx, 64(%rax)
	jmp	.LBB15_390
.LBB15_367:                             # %if.else2256
	movl	-72(%rbp), %eax
	shrl	$4, %eax
	movl	%eax, -80(%rbp)
	movl	-72(%rbp), %eax
	andl	$15, %eax
	movl	%eax, -380(%rbp)
	movq	-8(%rbp), %rcx
	movslq	-80(%rbp), %rdx
	addl	7820(%rcx,%rdx,4), %eax
	movl	%eax, -76(%rbp)
	movq	-8(%rbp), %rax
	movslq	-76(%rbp), %rcx
	movb	3724(%rax,%rcx), %al
	movb	%al, -9(%rbp)
	jmp	.LBB15_369
.LBB15_368:                             # %while.body2270
                                        #   in Loop: Header=BB15_369 Depth=1
	movslq	-76(%rbp), %rcx
	movzbl	3723(%rax,%rcx), %eax
	movq	-8(%rbp), %rdx
	movb	%al, 3724(%rdx,%rcx)
	decl	-76(%rbp)
.LBB15_369:                             # %while.cond2264
                                        # =>This Inner Loop Header: Depth=1
	movl	-76(%rbp), %ecx
	movq	-8(%rbp), %rax
	movslq	-80(%rbp), %rdx
	cmpl	7820(%rax,%rdx,4), %ecx
	jg	.LBB15_368
# BB#370:                               # %while.end2279
	movslq	-80(%rbp), %rcx
	incl	7820(%rax,%rcx,4)
	jmp	.LBB15_372
.LBB15_371:                             # %while.body2287
                                        #   in Loop: Header=BB15_372 Depth=1
	movslq	-80(%rbp), %rcx
	decl	7820(%rax,%rcx,4)
	movq	-8(%rbp), %rax
	movslq	-80(%rbp), %rcx
	movslq	7816(%rax,%rcx,4), %rdx
	movzbl	3739(%rax,%rdx), %edx
	movslq	7820(%rax,%rcx,4), %rcx
	movb	%dl, 3724(%rax,%rcx)
	decl	-80(%rbp)
.LBB15_372:                             # %while.cond2284
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$0, -80(%rbp)
	jg	.LBB15_371
# BB#373:                               # %while.end2308
	decl	7820(%rax)
	movb	-9(%rbp), %al
	movq	-8(%rbp), %rcx
	movslq	7820(%rcx), %rdx
	movb	%al, 3724(%rcx,%rdx)
	movq	-8(%rbp), %rax
	cmpl	$0, 7820(%rax)
	jne	.LBB15_354
# BB#374:                               # %if.then2321
	movl	$4095, -164(%rbp)       # imm = 0xFFF
	movl	$15, -128(%rbp)
	cmpl	$0, -128(%rbp)
	js	.LBB15_354
.LBB15_376:                             # %for.body2325
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB15_377 Depth 2
	movl	$15, -168(%rbp)
	cmpl	$0, -168(%rbp)
	js	.LBB15_375
	.p2align	4, 0x90
.LBB15_377:                             # %for.body2329
                                        #   Parent Loop BB15_376 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-8(%rbp), %rax
	movslq	-128(%rbp), %rcx
	movslq	7820(%rax,%rcx,4), %rcx
	movslq	-168(%rbp), %rdx
	addq	%rcx, %rdx
	movzbl	3724(%rax,%rdx), %ecx
	movslq	-164(%rbp), %rdx
	movb	%cl, 3724(%rax,%rdx)
	decl	-164(%rbp)
	decl	-168(%rbp)
	cmpl	$0, -168(%rbp)
	jns	.LBB15_377
.LBB15_375:                             # %for.end2343
                                        #   in Loop: Header=BB15_376 Depth=1
	movl	-164(%rbp), %eax
	incl	%eax
	movq	-8(%rbp), %rcx
	movslq	-128(%rbp), %rdx
	movl	%eax, 7820(%rcx,%rdx,4)
	decl	-128(%rbp)
	cmpl	$0, -128(%rbp)
	jns	.LBB15_376
.LBB15_354:                             # %if.end2352
	movq	-8(%rbp), %rax
	movzbl	-9(%rbp), %ecx
	movzbl	3468(%rax,%rcx), %ecx
	incl	68(%rax,%rcx,4)
	movq	-8(%rbp), %rcx
	movzbl	-9(%rbp), %eax
	movzbl	3468(%rcx,%rax), %eax
	cmpb	$0, 44(%rcx)
	je	.LBB15_378
# BB#355:                               # %if.then2362
	movq	-8(%rbp), %rcx
	movq	3160(%rcx), %rcx
	movslq	-44(%rbp), %rdx
	movw	%ax, (%rcx,%rdx,2)
	jmp	.LBB15_379
.LBB15_378:                             # %if.else2370
	movzwl	%ax, %eax
	movq	-8(%rbp), %rcx
	movq	3152(%rcx), %rcx
	movslq	-44(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
.LBB15_379:                             # %if.end2378
	incl	-44(%rbp)
	cmpl	$0, -68(%rbp)
	jne	.LBB15_382
# BB#380:                               # %if.then2382
	movl	-52(%rbp), %eax
	incl	%eax
	movl	%eax, -52(%rbp)
	cmpl	-92(%rbp), %eax
	jge	.LBB15_183
# BB#381:                               # %if.end2387
	movl	$50, -68(%rbp)
	movq	-8(%rbp), %rax
	movslq	-52(%rbp), %rcx
	movzbl	7884(%rax,%rcx), %eax
	movl	%eax, -36(%rbp)
	movq	-8(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movl	64012(%rax,%rcx,4), %eax
	movl	%eax, -84(%rbp)
	movq	-8(%rbp), %rax
	movslq	-36(%rbp), %rcx
	imulq	$1032, %rcx, %rcx       # imm = 0x408
	leaq	45436(%rax,%rcx), %rax
	movq	%rax, -160(%rbp)
	movq	-8(%rbp), %rax
	movslq	-36(%rbp), %rcx
	imulq	$1032, %rcx, %rcx       # imm = 0x408
	leaq	57820(%rax,%rcx), %rax
	movq	%rax, -152(%rbp)
	movq	-8(%rbp), %rax
	movslq	-36(%rbp), %rcx
	imulq	$1032, %rcx, %rcx       # imm = 0x408
	leaq	51628(%rax,%rcx), %rax
	movq	%rax, -104(%rbp)
.LBB15_382:                             # %if.end2407
	decl	-68(%rbp)
	movl	-84(%rbp), %eax
	movl	%eax, -28(%rbp)
.LBB15_383:                             # %sw.bb2409
	movq	-8(%rbp), %rax
	movl	$40, 8(%rax)
	jmp	.LBB15_385
.LBB15_384:                             # %if.then2457
                                        #   in Loop: Header=BB15_385 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_385:                             # %while.body2412
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movl	36(%rax), %ecx
	cmpl	-28(%rbp), %ecx
	jge	.LBB15_413
# BB#386:                               # %if.end2428
                                        #   in Loop: Header=BB15_385 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#387:                               # %if.end2434
                                        #   in Loop: Header=BB15_385 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_385
	jmp	.LBB15_384
.LBB15_413:                             # %if.then2416
	movl	32(%rax), %edx
	movq	-8(%rbp), %rax
	movl	36(%rax), %ecx
	movl	-28(%rbp), %eax
	subl	%eax, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %edx
	movl	$1, %esi
	movl	%eax, %ecx
	shll	%cl, %esi
	decl	%esi
	andl	%edx, %esi
	movl	%esi, -240(%rbp)
	movl	-28(%rbp), %eax
	movq	-8(%rbp), %rcx
	subl	%eax, 36(%rcx)
	movl	-240(%rbp), %eax
	movl	%eax, -32(%rbp)
	cmpl	$21, -28(%rbp)
	jge	.LBB15_183
	jmp	.LBB15_414
.LBB15_423:                             # %if.else2801
	movl	60(%rax), %edi
	movl	$1096, %esi             # imm = 0x448
	addq	-8(%rbp), %rsi
	callq	BZ2_indexIntoF
	movq	-8(%rbp), %rcx
	movl	%eax, 64(%rcx)
	movq	-8(%rbp), %rax
	movq	3160(%rax), %rdx
	movl	60(%rax), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rax), %rsi
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
	movl	%esi, 60(%rax)
	jmp	.LBB15_389
.LBB15_388:                             # %if.else2905
	movq	3152(%rax), %rax
	movq	-8(%rbp), %rcx
	movl	60(%rcx), %edx
	movl	(%rax,%rdx,4), %eax
	movl	%eax, 60(%rcx)
	movq	-8(%rbp), %rax
	movzbl	60(%rax), %ecx
	movl	%ecx, 64(%rax)
	movq	-8(%rbp), %rax
	shrl	$8, 60(%rax)
.LBB15_389:                             # %save_state_and_return
	movq	-8(%rbp), %rax
	incl	1092(%rax)
.LBB15_390:                             # %if.then2498
	movl	$0, -16(%rbp)
	jmp	.LBB15_184
.LBB15_392:                             # %if.then2057
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	decl	%ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	andl	$1, %eax
	movl	%eax, -244(%rbp)
	movq	-8(%rbp), %rax
	decl	36(%rax)
	movl	-244(%rbp), %eax
	movl	%eax, -136(%rbp)
	movl	-32(%rbp), %ecx
	addl	%ecx, %ecx
	orl	%eax, %ecx
	movl	%ecx, -32(%rbp)
	cmpl	$21, -28(%rbp)
	jge	.LBB15_183
.LBB15_393:                             # %if.end2042
	movl	-32(%rbp), %eax
	movq	-160(%rbp), %rcx
	movslq	-28(%rbp), %rdx
	cmpl	(%rcx,%rdx,4), %eax
	jg	.LBB15_398
# BB#394:                               # %while.end2104
	movl	-32(%rbp), %eax
	movq	-104(%rbp), %rcx
	movslq	-28(%rbp), %rdx
	cmpl	(%rcx,%rdx,4), %eax
	js	.LBB15_183
# BB#395:                               # %lor.lhs.false2110
	movl	-32(%rbp), %eax
	movq	-104(%rbp), %rcx
	movslq	-28(%rbp), %rdx
	subl	(%rcx,%rdx,4), %eax
	cmpl	$258, %eax              # imm = 0x102
	jge	.LBB15_183
# BB#396:                               # %if.end2117
	movq	-152(%rbp), %rax
	movslq	-32(%rbp), %rcx
	movq	-104(%rbp), %rdx
	movslq	-28(%rbp), %rsi
	movslq	(%rdx,%rsi,4), %rdx
	subq	%rdx, %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -64(%rbp)
	testl	%eax, %eax
	je	.LBB15_404
# BB#397:                               # %lor.rhs
	cmpl	$1, -64(%rbp)
	sete	-185(%rbp)
	sete	-53(%rbp)
	jmp	.LBB15_405
.LBB15_398:                             # %if.end2048
	incl	-28(%rbp)
.LBB15_399:                             # %sw.bb2050
	movq	-8(%rbp), %rax
	movl	$39, 8(%rax)
	jmp	.LBB15_401
.LBB15_400:                             # %if.then2096
                                        #   in Loop: Header=BB15_401 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_401:                             # %while.body2053
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$0, 36(%rax)
	jg	.LBB15_392
# BB#402:                               # %if.end2067
                                        #   in Loop: Header=BB15_401 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#403:                               # %if.end2073
                                        #   in Loop: Header=BB15_401 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_401
	jmp	.LBB15_400
.LBB15_404:                             # %do.cond.lor.end_crit_edge
	movb	$1, -53(%rbp)
.LBB15_405:                             # %lor.end
	movb	-53(%rbp), %al
	testb	%al, %al
	jne	.LBB15_322
# BB#406:                               # %do.end
	incl	-60(%rbp)
	movq	-8(%rbp), %rax
	movslq	7820(%rax), %rcx
	movzbl	3724(%rax,%rcx), %ecx
	movb	3468(%rax,%rcx), %al
	movb	%al, -9(%rbp)
	movl	-60(%rbp), %eax
	movq	-8(%rbp), %rcx
	movzbl	-9(%rbp), %edx
	addl	%eax, 68(%rcx,%rdx,4)
	movq	-8(%rbp), %rax
	cmpb	$0, 44(%rax)
	jne	.LBB15_408
	jmp	.LBB15_411
.LBB15_407:                             # %if.end2149
                                        #   in Loop: Header=BB15_408 Depth=1
	movzbl	-9(%rbp), %eax
	movq	-8(%rbp), %rcx
	movq	3160(%rcx), %rcx
	movslq	-44(%rbp), %rdx
	movw	%ax, (%rcx,%rdx,2)
	incl	-44(%rbp)
	decl	-60(%rbp)
.LBB15_408:                             # %while.cond2142
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$0, -60(%rbp)
	jle	.LBB15_301
# BB#409:                               # %while.body2145
                                        #   in Loop: Header=BB15_408 Depth=1
	movl	-44(%rbp), %eax
	cmpl	-116(%rbp), %eax
	jl	.LBB15_407
	jmp	.LBB15_183
.LBB15_410:                             # %if.end2165
                                        #   in Loop: Header=BB15_411 Depth=1
	movzbl	-9(%rbp), %eax
	movq	-8(%rbp), %rcx
	movq	3152(%rcx), %rcx
	movslq	-44(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	-44(%rbp)
	decl	-60(%rbp)
.LBB15_411:                             # %while.cond2158
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$0, -60(%rbp)
	jle	.LBB15_301
# BB#412:                               # %while.body2161
                                        #   in Loop: Header=BB15_411 Depth=1
	movl	-44(%rbp), %eax
	cmpl	-116(%rbp), %eax
	jl	.LBB15_410
	jmp	.LBB15_183
.LBB15_414:                             # %if.end2468
	movl	-32(%rbp), %eax
	movq	-160(%rbp), %rcx
	movslq	-28(%rbp), %rdx
	cmpl	(%rcx,%rdx,4), %eax
	jle	.LBB15_298
# BB#416:                               # %if.end2474
	incl	-28(%rbp)
.LBB15_417:                             # %sw.bb2476
	movq	-8(%rbp), %rax
	movl	$41, 8(%rax)
	jmp	.LBB15_419
.LBB15_418:                             # %if.then2522
                                        #   in Loop: Header=BB15_419 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB15_419:                             # %while.body2479
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$0, 36(%rax)
	jg	.LBB15_422
# BB#420:                               # %if.end2493
                                        #   in Loop: Header=BB15_419 Depth=1
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB15_390
# BB#421:                               # %if.end2499
                                        #   in Loop: Header=BB15_419 Depth=1
	movq	-8(%rbp), %rax
	movl	32(%rax), %ecx
	shll	$8, %ecx
	movq	(%rax), %rdx
	movq	(%rdx), %rdx
	movzbl	(%rdx), %edx
	orl	%ecx, %edx
	movl	%edx, 32(%rax)
	movq	-8(%rbp), %rax
	addl	$8, 36(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB15_419
	jmp	.LBB15_418
.LBB15_422:                             # %if.then2483
	movl	32(%rax), %eax
	movq	-8(%rbp), %rcx
	movl	36(%rcx), %ecx
	decl	%ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	andl	$1, %eax
	movl	%eax, -236(%rbp)
	movq	-8(%rbp), %rax
	decl	36(%rax)
	movl	-236(%rbp), %eax
	movl	%eax, -136(%rbp)
	movl	-32(%rbp), %ecx
	addl	%ecx, %ecx
	orl	%eax, %ecx
	movl	%ecx, -32(%rbp)
	cmpl	$21, -28(%rbp)
	jge	.LBB15_183
	jmp	.LBB15_414
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
	.quad	.LBB15_39
	.quad	.LBB15_101
	.quad	.LBB15_107
	.quad	.LBB15_113
	.quad	.LBB15_119
	.quad	.LBB15_125
	.quad	.LBB15_134
	.quad	.LBB15_140
	.quad	.LBB15_146
	.quad	.LBB15_152
	.quad	.LBB15_158
	.quad	.LBB15_164
	.quad	.LBB15_170
	.quad	.LBB15_176
	.quad	.LBB15_186
	.quad	.LBB15_198
	.quad	.LBB15_201
	.quad	.LBB15_208
	.quad	.LBB15_217
	.quad	.LBB15_244
	.quad	.LBB15_281
	.quad	.LBB15_287
	.quad	.LBB15_266
	.quad	.LBB15_310
	.quad	.LBB15_331
	.quad	.LBB15_399
	.quad	.LBB15_383
	.quad	.LBB15_417
	.quad	.LBB15_45
	.quad	.LBB15_51
	.quad	.LBB15_57
	.quad	.LBB15_63
	.quad	.LBB15_69
	.quad	.LBB15_76
	.quad	.LBB15_82
	.quad	.LBB15_88
	.quad	.LBB15_94

	.text
	.p2align	4, 0x90
	.type	makeMaps_d,@function
makeMaps_d:                             # @makeMaps_d
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi52:
	.cfi_def_cfa_offset 16
.Lcfi53:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi54:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	$0, 3192(%rdi)
	movl	$0, -4(%rbp)
	cmpl	$255, -4(%rbp)
	jle	.LBB16_2
	jmp	.LBB16_5
	.p2align	4, 0x90
.LBB16_4:                               # %for.inc18
                                        #   in Loop: Header=BB16_2 Depth=1
	incl	-4(%rbp)
	cmpl	$255, -4(%rbp)
	jg	.LBB16_5
.LBB16_2:                               # %for.body3
                                        # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	movslq	-4(%rbp), %rcx
	cmpb	$0, 3196(%rax,%rcx)
	je	.LBB16_4
# BB#3:                                 # %if.then8
                                        #   in Loop: Header=BB16_2 Depth=1
	movzbl	-4(%rbp), %eax
	movq	-16(%rbp), %rcx
	movslq	3192(%rcx), %rdx
	movb	%al, 3468(%rcx,%rdx)
	movq	-16(%rbp), %rax
	incl	3192(%rax)
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
.Lcfi55:
	.cfi_def_cfa_offset 16
.Lcfi56:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi57:
	.cfi_def_cfa_register %rbp
	movl	%edi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movl	$0, -4(%rbp)
	movl	$256, -8(%rbp)          # imm = 0x100
	.p2align	4, 0x90
.LBB17_1:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	addl	-8(%rbp), %eax
	sarl	%eax
	movl	%eax, -12(%rbp)
	movl	-16(%rbp), %ecx
	movq	-24(%rbp), %rdx
	movslq	-12(%rbp), %rax
	cmpl	(%rdx,%rax,4), %ecx
	jl	.LBB17_3
# BB#2:                                 # %if.then
                                        #   in Loop: Header=BB17_1 Depth=1
	movl	%eax, -4(%rbp)
	jmp	.LBB17_4
	.p2align	4, 0x90
.LBB17_3:                               # %if.else
                                        #   in Loop: Header=BB17_1 Depth=1
	movl	%eax, -8(%rbp)
.LBB17_4:                               # %do.cond
                                        #   in Loop: Header=BB17_1 Depth=1
	movl	-8(%rbp), %eax
	subl	-4(%rbp), %eax
	cmpl	$1, %eax
	jne	.LBB17_1
# BB#5:                                 # %do.end
	movl	-4(%rbp), %eax
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
.Lcfi58:
	.cfi_def_cfa_offset 16
.Lcfi59:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi60:
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
.Lcfi61:
	.cfi_def_cfa_offset 16
.Lcfi62:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi63:
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movl	%edx, -36(%rbp)
	movl	%ecx, -28(%rbp)
	callq	bz_config_ok
	testl	%eax, %eax
	je	.LBB19_1
# BB#2:                                 # %if.end
	cmpq	$0, -16(%rbp)
	je	.LBB19_7
# BB#3:                                 # %if.end
	movl	-20(%rbp), %eax
	testl	%eax, %eax
	jle	.LBB19_7
# BB#4:                                 # %if.end
	cmpl	$9, %eax
	jg	.LBB19_7
# BB#5:                                 # %if.end
	movl	-28(%rbp), %eax
	testl	%eax, %eax
	js	.LBB19_7
# BB#6:                                 # %if.end
	cmpl	$251, %eax
	jge	.LBB19_7
# BB#8:                                 # %if.end9
	cmpl	$0, -28(%rbp)
	je	.LBB19_9
# BB#26:                                # %if.end121
	movq	-16(%rbp), %rax
	cmpq	$0, 56(%rax)
	jne	.LBB19_28
# BB#27:                                # %if.then144
	movq	-16(%rbp), %rax
	movq	$default_bzalloc, 56(%rax)
.LBB19_28:                              # %if.end167
	movq	-16(%rbp), %rax
	cmpq	$0, 64(%rax)
	jne	.LBB19_30
# BB#29:                                # %if.then1810
	movq	-16(%rbp), %rax
	movq	$default_bzfree, 64(%rax)
.LBB19_30:                              # %if.end2013
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	movl	$55768, %esi            # imm = 0xD9D8
	movl	$1, %edx
	callq	*56(%rax)
	movq	%rax, -8(%rbp)
	testq	%rax, %rax
	je	.LBB19_23
# BB#31:                                # %if.end2518
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	%rax, (%rcx)
	movq	-8(%rbp), %rax
	movq	$0, 24(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 32(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 40(%rax)
	imull	$100000, -20(%rbp), %esi # imm = 0x186A0
	movl	%esi, -32(%rbp)
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	shll	$2, %esi
	movl	$1, %edx
	callq	*56(%rax)
	movq	-8(%rbp), %rcx
	movq	%rax, 24(%rcx)
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	movl	-32(%rbp), %ecx
	leal	136(,%rcx,4), %esi
	movl	$1, %edx
	callq	*56(%rax)
	movq	-8(%rbp), %rcx
	movq	%rax, 32(%rcx)
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	movl	$262148, %esi           # imm = 0x40004
	movl	$1, %edx
	callq	*56(%rax)
	movq	-8(%rbp), %rcx
	movq	%rax, 40(%rcx)
	movq	-8(%rbp), %rax
	cmpq	$0, 24(%rax)
	je	.LBB19_15
# BB#32:                                # %lor.lhs.false4745
	movq	-8(%rbp), %rax
	cmpq	$0, 32(%rax)
	je	.LBB19_15
# BB#33:                                # %lor.lhs.false5148
	movq	-8(%rbp), %rax
	cmpq	$0, 40(%rax)
	je	.LBB19_15
# BB#34:                                # %if.end8651
	movq	-8(%rbp), %rax
	movl	$0, 660(%rax)
	movq	-8(%rbp), %rax
	movl	$2, 12(%rax)
	movq	-8(%rbp), %rax
	movl	$2, 8(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 652(%rax)
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 664(%rcx)
	imull	$100000, -20(%rbp), %eax # imm = 0x186A0
	addl	$-19, %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 112(%rcx)
	movl	-36(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 656(%rcx)
	movl	-28(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 88(%rcx)
	jmp	.LBB19_38
.LBB19_1:                               # %if.then
	movl	$-9, -24(%rbp)
	movl	$-9, %eax
	jmp	.LBB19_25
.LBB19_7:                               # %if.then8
	movl	$-2, -24(%rbp)
	movl	$-2, %eax
	jmp	.LBB19_25
.LBB19_9:                               # %if.then11
	movl	$30, -28(%rbp)
	movq	-16(%rbp), %rax
	cmpq	$0, 56(%rax)
	jne	.LBB19_11
# BB#10:                                # %if.then1477
	movq	-16(%rbp), %rax
	movq	$default_bzalloc, 56(%rax)
.LBB19_11:                              # %if.end1680
	movq	-16(%rbp), %rax
	cmpq	$0, 64(%rax)
	jne	.LBB19_13
# BB#12:                                # %if.then1883
	movq	-16(%rbp), %rax
	movq	$default_bzfree, 64(%rax)
.LBB19_13:                              # %if.end2086
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	movl	$55768, %esi            # imm = 0xD9D8
	movl	$1, %edx
	callq	*56(%rax)
	movq	%rax, -8(%rbp)
	testq	%rax, %rax
	je	.LBB19_23
# BB#14:                                # %if.end2591
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	%rax, (%rcx)
	movq	-8(%rbp), %rax
	movq	$0, 24(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 32(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 40(%rax)
	imull	$100000, -20(%rbp), %esi # imm = 0x186A0
	movl	%esi, -32(%rbp)
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	shll	$2, %esi
	movl	$1, %edx
	callq	*56(%rax)
	movq	-8(%rbp), %rcx
	movq	%rax, 24(%rcx)
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	movl	-32(%rbp), %ecx
	leal	136(,%rcx,4), %esi
	movl	$1, %edx
	callq	*56(%rax)
	movq	-8(%rbp), %rcx
	movq	%rax, 32(%rcx)
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	movl	$262148, %esi           # imm = 0x40004
	movl	$1, %edx
	callq	*56(%rax)
	movq	-8(%rbp), %rcx
	movq	%rax, 40(%rcx)
	movq	-8(%rbp), %rax
	cmpq	$0, 24(%rax)
	je	.LBB19_15
# BB#35:                                # %lor.lhs.false47119
	movq	-8(%rbp), %rax
	cmpq	$0, 32(%rax)
	je	.LBB19_15
# BB#36:                                # %lor.lhs.false51122
	movq	-8(%rbp), %rax
	cmpq	$0, 40(%rax)
	je	.LBB19_15
# BB#37:                                # %if.end86125
	movq	-8(%rbp), %rax
	movl	$0, 660(%rax)
	movq	-8(%rbp), %rax
	movl	$2, 12(%rax)
	movq	-8(%rbp), %rax
	movl	$2, 8(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 652(%rax)
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 664(%rcx)
	imull	$100000, -20(%rbp), %eax # imm = 0x186A0
	addl	$-19, %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 112(%rcx)
	movl	-36(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 656(%rcx)
	movq	-8(%rbp), %rax
	movl	$30, 88(%rax)
.LBB19_38:                              # %return
	movq	-8(%rbp), %rax
	movq	32(%rax), %rcx
	movq	%rcx, 64(%rax)
	movq	-8(%rbp), %rax
	movq	24(%rax), %rcx
	movq	%rcx, 72(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 80(%rax)
	movq	-8(%rbp), %rax
	movq	24(%rax), %rcx
	movq	%rcx, 56(%rax)
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rcx
	movq	%rax, 48(%rcx)
	movq	-16(%rbp), %rax
	movl	$0, 12(%rax)
	movq	-16(%rbp), %rax
	movl	$0, 16(%rax)
	movq	-16(%rbp), %rax
	movl	$0, 36(%rax)
	movq	-16(%rbp), %rax
	movl	$0, 40(%rax)
	movq	-8(%rbp), %rdi
	callq	init_RL
	movq	-8(%rbp), %rdi
	callq	prepare_new_block
	movl	$0, -24(%rbp)
# BB#24:                                # %return
	xorl	%eax, %eax
	jmp	.LBB19_25
.LBB19_15:                              # %if.then55
	movq	-8(%rbp), %rax
	cmpq	$0, 24(%rax)
	je	.LBB19_17
# BB#16:                                # %if.then59
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	movq	-8(%rbp), %rcx
	movq	24(%rcx), %rsi
	callq	*64(%rax)
.LBB19_17:                              # %if.end63
	movq	-8(%rbp), %rax
	cmpq	$0, 32(%rax)
	je	.LBB19_19
# BB#18:                                # %if.then67
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	movq	-8(%rbp), %rcx
	movq	32(%rcx), %rsi
	callq	*64(%rax)
.LBB19_19:                              # %if.end71
	movq	-8(%rbp), %rax
	cmpq	$0, 40(%rax)
	je	.LBB19_21
# BB#20:                                # %if.then75
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	movq	-8(%rbp), %rcx
	movq	40(%rcx), %rsi
	callq	*64(%rax)
.LBB19_21:                              # %if.end79
	cmpq	$0, -8(%rbp)
	je	.LBB19_23
# BB#22:                                # %if.then82
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	movq	-8(%rbp), %rsi
	callq	*64(%rax)
.LBB19_23:                              # %if.then24
	movl	$-3, -24(%rbp)
	movl	$-3, %eax
.LBB19_25:                              # %return
	addq	$48, %rsp
	popq	%rbp
	retq
.Lfunc_end19:
	.size	BZ2_bzCompressInit, .Lfunc_end19-BZ2_bzCompressInit
	.cfi_endproc

	.p2align	4, 0x90
	.type	bz_config_ok,@function
bz_config_ok:                           # @bz_config_ok
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
.Lcfi67:
	.cfi_def_cfa_offset 16
.Lcfi68:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi69:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -4(%rbp)
	movslq	-8(%rbp), %rax
	movslq	-4(%rbp), %rdi
	imulq	%rax, %rdi
	callq	malloc
	movq	%rax, -16(%rbp)
	addq	$32, %rsp
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
	pushq	%rbp
.Lcfi70:
	.cfi_def_cfa_offset 16
.Lcfi71:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi72:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -8(%rbp)
	testq	%rsi, %rsi
	je	.LBB22_2
# BB#1:                                 # %if.then
	movq	-8(%rbp), %rdi
	callq	free
.LBB22_2:                               # %if.end
	addq	$16, %rsp
	popq	%rbp
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
.Lcfi73:
	.cfi_def_cfa_offset 16
.Lcfi74:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi75:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movl	$256, 92(%rdi)          # imm = 0x100
	movq	-8(%rbp), %rax
	movl	$0, 96(%rax)
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
.Lcfi76:
	.cfi_def_cfa_offset 16
.Lcfi77:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi78:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	$0, 108(%rdi)
	movq	-16(%rbp), %rax
	movl	$0, 116(%rax)
	movq	-16(%rbp), %rax
	movl	$0, 120(%rax)
	movq	-16(%rbp), %rax
	movl	$-1, 648(%rax)
	movl	$0, -4(%rbp)
	jmp	.LBB24_1
	.p2align	4, 0x90
.LBB24_2:                               # %for.body3
                                        #   in Loop: Header=BB24_1 Depth=1
	movslq	-4(%rbp), %rcx
	movb	$0, 128(%rax,%rcx)
	incl	-4(%rbp)
.LBB24_1:                               # %for.cond1
                                        # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	cmpl	$255, -4(%rbp)
	jle	.LBB24_2
# BB#3:                                 # %for.end
	incl	660(%rax)
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
.Lcfi79:
	.cfi_def_cfa_offset 16
.Lcfi80:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi81:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -32(%rbp)
	movl	%esi, -20(%rbp)
	cmpq	$0, -32(%rbp)
	je	.LBB25_1
# BB#3:                                 # %if.end
	movq	-32(%rbp), %rax
	movq	48(%rax), %rax
	movq	%rax, -16(%rbp)
	testq	%rax, %rax
	je	.LBB25_1
# BB#4:                                 # %if.end3
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	-32(%rbp), %rax
	je	.LBB25_6
.LBB25_1:                               # %if.then
	movl	$-2, -4(%rbp)
	movl	$-2, %eax
.LBB25_2:                               # %if.then
	addq	$32, %rsp
	popq	%rbp
	retq
	.p2align	4, 0x90
.LBB25_5:                               # %preswitch.sink.split
                                        #   in Loop: Header=BB25_6 Depth=1
	movl	%eax, 8(%rcx)
.LBB25_6:                               # %preswitch
                                        # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	movl	8(%rax), %eax
	decl	%eax
	cmpl	$3, %eax
	ja	.LBB25_30
# BB#7:                                 # %preswitch
                                        #   in Loop: Header=BB25_6 Depth=1
	jmpq	*.LJTI25_0(,%rax,8)
.LBB25_8:                               # %sw.bb8
                                        #   in Loop: Header=BB25_6 Depth=1
	cmpl	$0, -20(%rbp)
	je	.LBB25_9
# BB#10:                                # %if.else
                                        #   in Loop: Header=BB25_6 Depth=1
	cmpl	$1, -20(%rbp)
	jne	.LBB25_12
# BB#11:                                # %if.then13
                                        #   in Loop: Header=BB25_6 Depth=1
	movq	-32(%rbp), %rax
	movl	8(%rax), %eax
	movq	-16(%rbp), %rcx
	movl	%eax, 16(%rcx)
	movl	$3, %eax
	movq	-16(%rbp), %rcx
	jmp	.LBB25_5
	.p2align	4, 0x90
.LBB25_12:                              # %if.else15
                                        #   in Loop: Header=BB25_6 Depth=1
	cmpl	$2, -20(%rbp)
	jne	.LBB25_1
# BB#13:                                # %if.then18
                                        #   in Loop: Header=BB25_6 Depth=1
	movq	-32(%rbp), %rax
	movl	8(%rax), %eax
	movq	-16(%rbp), %rcx
	movl	%eax, 16(%rcx)
	movl	$4, %eax
	movq	-16(%rbp), %rcx
	jmp	.LBB25_5
.LBB25_9:                               # %if.then10
	movq	-32(%rbp), %rdi
	callq	handle_compress
	movb	%al, -5(%rbp)
	testb	%al, %al
	movl	$1, %ecx
	movl	$-2, %eax
	cmovnel	%ecx, %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB25_2
.LBB25_30:                              # %sw.epilog
	movl	$0, -4(%rbp)
	xorl	%eax, %eax
	jmp	.LBB25_2
.LBB25_14:                              # %sw.bb23
	cmpl	$1, -20(%rbp)
	jne	.LBB25_24
# BB#15:                                # %if.end27
	movq	-16(%rbp), %rax
	movl	16(%rax), %ecx
	movq	(%rax), %rax
	cmpl	8(%rax), %ecx
	jne	.LBB25_24
# BB#16:                                # %if.end34
	movq	-32(%rbp), %rdi
	callq	handle_compress
	movb	%al, -5(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$0, 16(%rax)
	jne	.LBB25_19
# BB#17:                                # %lor.lhs.false
	movq	-16(%rbp), %rdi
	callq	isempty_RL
	testb	%al, %al
	je	.LBB25_19
# BB#18:                                # %lor.lhs.false41
	movq	-16(%rbp), %rax
	movl	120(%rax), %ecx
	cmpl	116(%rax), %ecx
	jge	.LBB25_20
.LBB25_19:                              # %if.then44
	movl	$2, -4(%rbp)
	movl	$2, %eax
	jmp	.LBB25_2
.LBB25_21:                              # %sw.bb47
	cmpl	$2, -20(%rbp)
	jne	.LBB25_24
# BB#22:                                # %if.end51
	movq	-16(%rbp), %rax
	movl	16(%rax), %ecx
	movq	(%rax), %rax
	cmpl	8(%rax), %ecx
	jne	.LBB25_24
# BB#23:                                # %if.end58
	movq	-32(%rbp), %rdi
	callq	handle_compress
	movb	%al, -5(%rbp)
	testb	%al, %al
	je	.LBB25_24
# BB#25:                                # %if.end62
	movq	-16(%rbp), %rax
	cmpl	$0, 16(%rax)
	jne	.LBB25_28
# BB#26:                                # %lor.lhs.false66
	movq	-16(%rbp), %rdi
	callq	isempty_RL
	testb	%al, %al
	je	.LBB25_28
# BB#27:                                # %lor.lhs.false69
	movq	-16(%rbp), %rax
	movl	120(%rax), %ecx
	cmpl	116(%rax), %ecx
	jge	.LBB25_29
.LBB25_28:                              # %if.then74
	movl	$3, -4(%rbp)
	movl	$3, %eax
	jmp	.LBB25_2
.LBB25_24:                              # %sw.bb
	movl	$-1, -4(%rbp)
	movl	$-1, %eax
	jmp	.LBB25_2
.LBB25_20:                              # %if.end45
	movq	-16(%rbp), %rax
	movl	$2, 8(%rax)
	movl	$1, -4(%rbp)
	movl	$1, %eax
	jmp	.LBB25_2
.LBB25_29:                              # %if.end75
	movq	-16(%rbp), %rax
	movl	$1, 8(%rax)
	movl	$4, -4(%rbp)
	movl	$4, %eax
	jmp	.LBB25_2
.Lfunc_end25:
	.size	BZ2_bzCompress, .Lfunc_end25-BZ2_bzCompress
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	3
.LJTI25_0:
	.quad	.LBB25_24
	.quad	.LBB25_8
	.quad	.LBB25_14
	.quad	.LBB25_21

	.text
	.p2align	4, 0x90
	.type	handle_compress,@function
handle_compress:                        # @handle_compress
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi82:
	.cfi_def_cfa_offset 16
.Lcfi83:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi84:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -32(%rbp)
	movb	$0, -2(%rbp)
	movb	$0, -1(%rbp)
	movq	-32(%rbp), %rax
	movq	48(%rax), %rax
	movq	%rax, -16(%rbp)
	jmp	.LBB26_1
	.p2align	4, 0x90
.LBB26_20:                              # %while.body1
                                        #   in Loop: Header=BB26_1 Depth=1
	callq	BZ2_compressBlock
	movq	-16(%rbp), %rax
	movl	$1, 12(%rax)
.LBB26_1:                               # %while.body1
                                        # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	cmpl	$1, 12(%rax)
	jne	.LBB26_9
# BB#2:                                 # %if.then4
                                        #   in Loop: Header=BB26_1 Depth=1
	movq	-16(%rbp), %rdi
	callq	copy_output_until_stop
	movzbl	%al, %eax
	movzbl	-1(%rbp), %ecx
	orl	%eax, %ecx
	movb	%cl, -1(%rbp)
	movq	-16(%rbp), %rax
	movl	120(%rax), %ecx
	cmpl	116(%rax), %ecx
	jl	.LBB26_16
# BB#3:                                 # %if.end16
                                        #   in Loop: Header=BB26_1 Depth=1
	movq	-16(%rbp), %rax
	cmpl	$4, 8(%rax)
	jne	.LBB26_6
# BB#4:                                 # %land.lhs.true26
                                        #   in Loop: Header=BB26_1 Depth=1
	movq	-16(%rbp), %rax
	cmpl	$0, 16(%rax)
	jne	.LBB26_6
# BB#5:                                 # %land.lhs.true1143
                                        #   in Loop: Header=BB26_1 Depth=1
	movq	-16(%rbp), %rdi
	callq	isempty_RL
	testb	%al, %al
	jne	.LBB26_16
	.p2align	4, 0x90
.LBB26_6:                               # %if.end1548
                                        #   in Loop: Header=BB26_1 Depth=1
	movq	-16(%rbp), %rdi
	callq	prepare_new_block
	movq	-16(%rbp), %rax
	movl	$2, 12(%rax)
	movq	-16(%rbp), %rax
	cmpl	$3, 8(%rax)
	jne	.LBB26_9
# BB#7:                                 # %land.lhs.true2059
                                        #   in Loop: Header=BB26_1 Depth=1
	movq	-16(%rbp), %rax
	cmpl	$0, 16(%rax)
	jne	.LBB26_9
# BB#8:                                 # %land.lhs.true2474
                                        #   in Loop: Header=BB26_1 Depth=1
	movq	-16(%rbp), %rdi
	callq	isempty_RL
	testb	%al, %al
	jne	.LBB26_16
	.p2align	4, 0x90
.LBB26_9:                               # %if.end3020
                                        #   in Loop: Header=BB26_1 Depth=1
	movq	-16(%rbp), %rax
	cmpl	$2, 12(%rax)
	jne	.LBB26_1
# BB#10:                                # %if.then3430
                                        #   in Loop: Header=BB26_1 Depth=1
	movq	-16(%rbp), %rdi
	callq	copy_input_until_stop
	movzbl	%al, %eax
	movzbl	-2(%rbp), %ecx
	orl	%eax, %ecx
	movb	%cl, -2(%rbp)
	movq	-16(%rbp), %rax
	cmpl	$2, 8(%rax)
	je	.LBB26_18
# BB#11:                                # %land.lhs.true4352
                                        #   in Loop: Header=BB26_1 Depth=1
	movq	-16(%rbp), %rax
	cmpl	$0, 16(%rax)
	je	.LBB26_12
.LBB26_18:                              # %if.else70
                                        #   in Loop: Header=BB26_1 Depth=1
	movq	-16(%rbp), %rdi
	movl	108(%rdi), %eax
	cmpl	112(%rdi), %eax
	jl	.LBB26_15
# BB#19:                                # %if.then5581
                                        #   in Loop: Header=BB26_1 Depth=1
	xorl	%esi, %esi
	jmp	.LBB26_20
.LBB26_15:                              # %if.else5783
                                        #   in Loop: Header=BB26_1 Depth=1
	movq	(%rdi), %rax
	cmpl	$0, 8(%rax)
	jne	.LBB26_1
	jmp	.LBB26_16
.LBB26_12:                              # %if.then4763
                                        #   in Loop: Header=BB26_1 Depth=1
	movq	-16(%rbp), %rdi
	callq	flush_RL
	movq	-16(%rbp), %rdi
	xorl	%esi, %esi
	cmpl	$4, 8(%rdi)
	sete	%sil
	jmp	.LBB26_20
.LBB26_16:                              # %while.end23
	cmpb	$0, -2(%rbp)
	je	.LBB26_17
# BB#13:                                # %while.end.lor.end_crit_edge
	movb	$1, -3(%rbp)
	movb	$1, %al
	jmp	.LBB26_14
.LBB26_17:                              # %lor.rhs39
	cmpb	$0, -1(%rbp)
	setne	-17(%rbp)
	setne	-3(%rbp)
	movb	-3(%rbp), %al
.LBB26_14:                              # %while.end.lor.end_crit_edge
	addq	$32, %rsp
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
.Lcfi85:
	.cfi_def_cfa_offset 16
.Lcfi86:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi87:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	cmpl	$255, 92(%rdi)
	ja	.LBB27_3
# BB#1:                                 # %land.lhs.true
	movq	-16(%rbp), %rax
	cmpl	$0, 96(%rax)
	jle	.LBB27_3
# BB#2:                                 # %if.then
	movb	$0, -1(%rbp)
	xorl	%eax, %eax
	popq	%rbp
	retq
.LBB27_3:                               # %if.else
	movb	$1, -1(%rbp)
	movb	$1, %al
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
.Lcfi88:
	.cfi_def_cfa_offset 16
.Lcfi89:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi90:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	testq	%rdi, %rdi
	je	.LBB28_1
# BB#3:                                 # %if.end
	movq	-16(%rbp), %rax
	movq	48(%rax), %rax
	movq	%rax, -8(%rbp)
	testq	%rax, %rax
	je	.LBB28_1
# BB#4:                                 # %if.end3
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpq	-16(%rbp), %rax
	je	.LBB28_5
.LBB28_1:                               # %if.then
	movl	$-2, -20(%rbp)
	movl	$-2, %eax
.LBB28_2:                               # %if.then
	addq	$32, %rsp
	popq	%rbp
	retq
.LBB28_5:                               # %if.end7
	movq	-8(%rbp), %rax
	cmpq	$0, 24(%rax)
	je	.LBB28_7
# BB#6:                                 # %if.then9
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	movq	-8(%rbp), %rcx
	movq	24(%rcx), %rsi
	callq	*64(%rax)
.LBB28_7:                               # %if.end11
	movq	-8(%rbp), %rax
	cmpq	$0, 32(%rax)
	je	.LBB28_9
# BB#8:                                 # %if.then13
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	movq	-8(%rbp), %rcx
	movq	32(%rcx), %rsi
	callq	*64(%rax)
.LBB28_9:                               # %if.end17
	movq	-8(%rbp), %rax
	cmpq	$0, 40(%rax)
	je	.LBB28_11
# BB#10:                                # %if.then19
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	movq	-8(%rbp), %rcx
	movq	40(%rcx), %rsi
	callq	*64(%rax)
.LBB28_11:                              # %if.end23
	movq	-16(%rbp), %rax
	movq	48(%rax), %rsi
	movq	72(%rax), %rdi
	callq	*64(%rax)
	movq	-16(%rbp), %rax
	movq	$0, 48(%rax)
	movl	$0, -20(%rbp)
	xorl	%eax, %eax
	jmp	.LBB28_2
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
.Lcfi91:
	.cfi_def_cfa_offset 16
.Lcfi92:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi93:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	movl	%esi, -28(%rbp)
	movl	%edx, -24(%rbp)
	callq	bz_config_ok
	testl	%eax, %eax
	je	.LBB29_1
# BB#3:                                 # %if.end
	cmpq	$0, -16(%rbp)
	je	.LBB29_4
# BB#5:                                 # %if.end2
	movl	-24(%rbp), %eax
	testl	%eax, %eax
	je	.LBB29_7
# BB#6:                                 # %if.end2
	cmpl	$1, %eax
	je	.LBB29_7
.LBB29_4:                               # %if.then1
	movl	$-2, -20(%rbp)
	movl	$-2, %eax
	jmp	.LBB29_2
.LBB29_1:                               # %if.then
	movl	$-9, -20(%rbp)
	movl	$-9, %eax
.LBB29_2:                               # %if.then
	addq	$32, %rsp
	popq	%rbp
	retq
.LBB29_7:                               # %if.end6
	movl	-28(%rbp), %eax
	testl	%eax, %eax
	js	.LBB29_4
# BB#8:                                 # %if.end6
	cmpl	$5, %eax
	jge	.LBB29_4
# BB#9:                                 # %if.end10
	movq	-16(%rbp), %rax
	cmpq	$0, 56(%rax)
	jne	.LBB29_11
# BB#10:                                # %if.then12
	movq	-16(%rbp), %rax
	movq	$default_bzalloc, 56(%rax)
.LBB29_11:                              # %if.end14
	movq	-16(%rbp), %rax
	cmpq	$0, 64(%rax)
	jne	.LBB29_13
# BB#12:                                # %if.then16
	movq	-16(%rbp), %rax
	movq	$default_bzfree, 64(%rax)
.LBB29_13:                              # %if.end18
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	movl	$64144, %esi            # imm = 0xFA90
	movl	$1, %edx
	callq	*56(%rax)
	movq	%rax, -8(%rbp)
	testq	%rax, %rax
	je	.LBB29_14
# BB#15:                                # %if.end23
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	%rax, (%rcx)
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rcx
	movq	%rax, 48(%rcx)
	movq	-8(%rbp), %rax
	movl	$10, 8(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 36(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 32(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 3188(%rax)
	movq	-16(%rbp), %rax
	movl	$0, 12(%rax)
	movq	-16(%rbp), %rax
	movl	$0, 16(%rax)
	movq	-16(%rbp), %rax
	movl	$0, 36(%rax)
	movq	-16(%rbp), %rax
	movl	$0, 40(%rax)
	movb	-24(%rbp), %al
	movq	-8(%rbp), %rcx
	movb	%al, 44(%rcx)
	movq	-8(%rbp), %rax
	movq	$0, 3168(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 3160(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 3152(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 48(%rax)
	movl	-28(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 52(%rcx)
	movl	$0, -20(%rbp)
	xorl	%eax, %eax
	jmp	.LBB29_2
.LBB29_14:                              # %if.then22
	movl	$-3, -20(%rbp)
	movl	$-3, %eax
	jmp	.LBB29_2
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
.Lcfi94:
	.cfi_def_cfa_offset 16
.Lcfi95:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi96:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	testq	%rdi, %rdi
	je	.LBB30_1
# BB#3:                                 # %if.end
	movq	-24(%rbp), %rax
	movq	48(%rax), %rax
	movq	%rax, -8(%rbp)
	testq	%rax, %rax
	je	.LBB30_1
# BB#4:                                 # %if.end3
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpq	-24(%rbp), %rax
	je	.LBB30_5
.LBB30_1:                               # %if.then
	movl	$-2, -12(%rbp)
	movl	$-2, %eax
.LBB30_2:                               # %if.then
	addq	$32, %rsp
	popq	%rbp
	retq
	.p2align	4, 0x90
.LBB30_5:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpl	$1, 8(%rax)
	je	.LBB30_6
# BB#7:                                 # %if.end11
                                        #   in Loop: Header=BB30_5 Depth=1
	movq	-8(%rbp), %rax
	cmpl	$2, 8(%rax)
	jne	.LBB30_21
# BB#8:                                 # %if.then14
                                        #   in Loop: Header=BB30_5 Depth=1
	movq	-8(%rbp), %rdi
	cmpb	$0, 44(%rdi)
	je	.LBB30_10
# BB#9:                                 # %if.then15
                                        #   in Loop: Header=BB30_5 Depth=1
	callq	unRLE_obuf_to_output_SMALL
	jmp	.LBB30_11
.LBB30_10:                              # %if.else
                                        #   in Loop: Header=BB30_5 Depth=1
	callq	unRLE_obuf_to_output_FAST
.LBB30_11:                              # %if.end16
                                        #   in Loop: Header=BB30_5 Depth=1
	movq	-8(%rbp), %rax
	movl	64080(%rax), %ecx
	incl	%ecx
	cmpl	%ecx, 1092(%rax)
	jne	.LBB30_19
# BB#12:                                # %land.lhs.true
                                        #   in Loop: Header=BB30_5 Depth=1
	movq	-8(%rbp), %rax
	cmpl	$0, 16(%rax)
	jne	.LBB30_19
# BB#13:                                # %if.then19
                                        #   in Loop: Header=BB30_5 Depth=1
	movq	-8(%rbp), %rax
	notl	3184(%rax)
	movq	-8(%rbp), %rax
	cmpl	$3, 52(%rax)
	jl	.LBB30_15
# BB#14:                                # %if.then22
                                        #   in Loop: Header=BB30_5 Depth=1
	movq	stderr(%rip), %rdi
	movq	-8(%rbp), %rax
	movl	3176(%rax), %edx
	movl	3184(%rax), %ecx
	movl	$.L.str.8, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB30_15:                              # %if.end24
                                        #   in Loop: Header=BB30_5 Depth=1
	movq	-8(%rbp), %rax
	cmpl	$2, 52(%rax)
	jl	.LBB30_17
# BB#16:                                # %if.then27
                                        #   in Loop: Header=BB30_5 Depth=1
	movq	stderr(%rip), %rdi
	movl	$.L.str.9, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB30_17:                              # %if.end29
                                        #   in Loop: Header=BB30_5 Depth=1
	movq	-8(%rbp), %rax
	movl	3184(%rax), %ecx
	cmpl	3176(%rax), %ecx
	jne	.LBB30_18
# BB#20:                                # %if.end34
                                        #   in Loop: Header=BB30_5 Depth=1
	movq	-8(%rbp), %rax
	roll	3188(%rax)
	movq	-8(%rbp), %rax
	movl	3184(%rax), %ecx
	xorl	%ecx, 3188(%rax)
	movq	-8(%rbp), %rax
	movl	$14, 8(%rax)
.LBB30_21:                              # %if.end42
                                        #   in Loop: Header=BB30_5 Depth=1
	movq	-8(%rbp), %rax
	cmpl	$10, 8(%rax)
	jl	.LBB30_5
# BB#22:                                # %if.then45
                                        #   in Loop: Header=BB30_5 Depth=1
	movq	-8(%rbp), %rdi
	callq	BZ2_decompress
	movl	%eax, -16(%rbp)
	movq	-8(%rbp), %rcx
	cmpl	$4, %eax
	je	.LBB30_23
# BB#27:                                # %if.end60
                                        #   in Loop: Header=BB30_5 Depth=1
	cmpl	$2, 8(%rcx)
	je	.LBB30_5
	jmp	.LBB30_26
.LBB30_6:                               # %if.then10
	movl	$-1, -12(%rbp)
	movl	$-1, %eax
	jmp	.LBB30_2
.LBB30_19:                              # %if.else40
	movl	$0, -12(%rbp)
	xorl	%eax, %eax
	jmp	.LBB30_2
.LBB30_23:                              # %if.then48
	cmpl	$3, 52(%rcx)
	jl	.LBB30_25
# BB#24:                                # %if.then51
	movq	stderr(%rip), %rdi
	movq	-8(%rbp), %rax
	movl	3180(%rax), %edx
	movl	3188(%rax), %ecx
	movl	$.L.str.10, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB30_25:                              # %if.end54
	movq	-8(%rbp), %rax
	movl	3188(%rax), %ecx
	cmpl	3180(%rax), %ecx
	je	.LBB30_26
.LBB30_18:                              # %if.then33
	movl	$-4, -12(%rbp)
	movl	$-4, %eax
	jmp	.LBB30_2
.LBB30_26:                              # %if.end59
	movl	-16(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB30_2
.Lfunc_end30:
	.size	BZ2_bzDecompress, .Lfunc_end30-BZ2_bzDecompress
	.cfi_endproc

	.p2align	4, 0x90
	.type	unRLE_obuf_to_output_SMALL,@function
unRLE_obuf_to_output_SMALL:             # @unRLE_obuf_to_output_SMALL
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
	subq	$16, %rsp
	movq	%rdi, -16(%rbp)
	cmpb	$0, 20(%rdi)
	jne	.LBB31_1
	jmp	.LBB31_29
	.p2align	4, 0x90
.LBB31_4:                               # %if.then23
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	incl	40(%rax)
.LBB31_1:                               # %while.body2
                                        # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 32(%rax)
	je	.LBB31_42
# BB#2:                                 # %if.end
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	cmpl	$0, 16(%rax)
	je	.LBB31_5
# BB#3:                                 # %if.end6
                                        #   in Loop: Header=BB31_1 Depth=1
	movzbl	12(%rax), %eax
	movq	-16(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	24(%rcx), %rcx
	movb	%al, (%rcx)
	movq	-16(%rbp), %rax
	movl	3184(%rax), %ecx
	movl	%ecx, %edx
	shll	$8, %edx
	shrl	$24, %ecx
	movzbl	12(%rax), %esi
	xorl	%ecx, %esi
	xorl	BZ2_crc32Table(,%rsi,4), %edx
	movl	%edx, 3184(%rax)
	movq	-16(%rbp), %rax
	decl	16(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	incq	24(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	decl	32(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	incl	36(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 36(%rax)
	jne	.LBB31_1
	jmp	.LBB31_4
.LBB31_5:                               # %while.end
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rcx
	movl	64080(%rcx), %ecx
	incl	%ecx
	cmpl	%ecx, 1092(%rax)
	je	.LBB31_42
# BB#6:                                 # %if.end30
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	movl	$1, 16(%rax)
	movq	-16(%rbp), %rax
	movzbl	64(%rax), %ecx
	movb	%cl, 12(%rax)
	movq	-16(%rbp), %rsi
	movl	60(%rsi), %edi
	addq	$1096, %rsi             # imm = 0x448
	callq	BZ2_indexIntoF
	movb	%al, -1(%rbp)
	movq	-16(%rbp), %rax
	movq	3160(%rax), %rdx
	movl	60(%rax), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rax), %rsi
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
	movl	%esi, 60(%rax)
	movq	-16(%rbp), %rax
	cmpl	$0, 24(%rax)
	jne	.LBB31_9
# BB#7:                                 # %if.then52
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	movslq	28(%rax), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rax)
	movq	-16(%rbp), %rax
	incl	28(%rax)
	movq	-16(%rbp), %rax
	cmpl	$512, 28(%rax)          # imm = 0x200
	jne	.LBB31_9
# BB#8:                                 # %if.then61
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	movl	$0, 28(%rax)
.LBB31_9:                               # %if.end64
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	decl	24(%rax)
	movq	-16(%rbp), %rax
	xorl	%ecx, %ecx
	cmpl	$1, 24(%rax)
	sete	%cl
	movzbl	-1(%rbp), %eax
	xorl	%eax, %ecx
	movb	%cl, -1(%rbp)
	movq	-16(%rbp), %rax
	incl	1092(%rax)
	movq	-16(%rbp), %rax
	movl	64080(%rax), %ecx
	incl	%ecx
	cmpl	%ecx, 1092(%rax)
	je	.LBB31_1
# BB#10:                                # %if.end81
                                        #   in Loop: Header=BB31_1 Depth=1
	movzbl	-1(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	64(%rcx), %eax
	je	.LBB31_12
.LBB31_11:                              # %if.then86
                                        #   in Loop: Header=BB31_1 Depth=1
	movzbl	-1(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	%eax, 64(%rcx)
	jmp	.LBB31_1
.LBB31_12:                              # %if.end89
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	movl	$2, 16(%rax)
	movq	-16(%rbp), %rsi
	movl	60(%rsi), %edi
	addq	$1096, %rsi             # imm = 0x448
	callq	BZ2_indexIntoF
	movb	%al, -1(%rbp)
	movq	-16(%rbp), %rax
	movq	3160(%rax), %rdx
	movl	60(%rax), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rax), %rsi
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
	movl	%esi, 60(%rax)
	movq	-16(%rbp), %rax
	cmpl	$0, 24(%rax)
	jne	.LBB31_15
# BB#13:                                # %if.then118
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	movslq	28(%rax), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rax)
	movq	-16(%rbp), %rax
	incl	28(%rax)
	movq	-16(%rbp), %rax
	cmpl	$512, 28(%rax)          # imm = 0x200
	jne	.LBB31_15
# BB#14:                                # %if.then128
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	movl	$0, 28(%rax)
.LBB31_15:                              # %if.end131
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	decl	24(%rax)
	movq	-16(%rbp), %rax
	xorl	%ecx, %ecx
	cmpl	$1, 24(%rax)
	sete	%cl
	movzbl	-1(%rbp), %eax
	xorl	%eax, %ecx
	movb	%cl, -1(%rbp)
	movq	-16(%rbp), %rax
	incl	1092(%rax)
	movq	-16(%rbp), %rax
	movl	64080(%rax), %ecx
	incl	%ecx
	cmpl	%ecx, 1092(%rax)
	je	.LBB31_1
# BB#16:                                # %if.end149
                                        #   in Loop: Header=BB31_1 Depth=1
	movzbl	-1(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	64(%rcx), %eax
	jne	.LBB31_11
# BB#17:                                # %if.end157
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	movl	$3, 16(%rax)
	movq	-16(%rbp), %rsi
	movl	60(%rsi), %edi
	addq	$1096, %rsi             # imm = 0x448
	callq	BZ2_indexIntoF
	movb	%al, -1(%rbp)
	movq	-16(%rbp), %rax
	movq	3160(%rax), %rdx
	movl	60(%rax), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rax), %rsi
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
	movl	%esi, 60(%rax)
	movq	-16(%rbp), %rax
	cmpl	$0, 24(%rax)
	jne	.LBB31_20
# BB#18:                                # %if.then186
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	movslq	28(%rax), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rax)
	movq	-16(%rbp), %rax
	incl	28(%rax)
	movq	-16(%rbp), %rax
	cmpl	$512, 28(%rax)          # imm = 0x200
	jne	.LBB31_20
# BB#19:                                # %if.then196
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	movl	$0, 28(%rax)
.LBB31_20:                              # %if.end199
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	decl	24(%rax)
	movq	-16(%rbp), %rax
	xorl	%ecx, %ecx
	cmpl	$1, 24(%rax)
	sete	%cl
	movzbl	-1(%rbp), %eax
	xorl	%eax, %ecx
	movb	%cl, -1(%rbp)
	movq	-16(%rbp), %rax
	incl	1092(%rax)
	movq	-16(%rbp), %rax
	movl	64080(%rax), %ecx
	incl	%ecx
	cmpl	%ecx, 1092(%rax)
	je	.LBB31_1
# BB#21:                                # %if.end217
                                        #   in Loop: Header=BB31_1 Depth=1
	movzbl	-1(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	64(%rcx), %eax
	jne	.LBB31_11
# BB#22:                                # %if.end225
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rsi
	movl	60(%rsi), %edi
	addq	$1096, %rsi             # imm = 0x448
	callq	BZ2_indexIntoF
	movb	%al, -1(%rbp)
	movq	-16(%rbp), %rax
	movq	3160(%rax), %rdx
	movl	60(%rax), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rax), %rsi
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
	movl	%esi, 60(%rax)
	movq	-16(%rbp), %rax
	cmpl	$0, 24(%rax)
	jne	.LBB31_25
# BB#23:                                # %if.then253
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	movslq	28(%rax), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rax)
	movq	-16(%rbp), %rax
	incl	28(%rax)
	movq	-16(%rbp), %rax
	cmpl	$512, 28(%rax)          # imm = 0x200
	jne	.LBB31_25
# BB#24:                                # %if.then263
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	movl	$0, 28(%rax)
.LBB31_25:                              # %if.end266
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	decl	24(%rax)
	movq	-16(%rbp), %rax
	xorl	%ecx, %ecx
	cmpl	$1, 24(%rax)
	sete	%cl
	movzbl	-1(%rbp), %eax
	xorl	%eax, %ecx
	movb	%cl, -1(%rbp)
	movq	-16(%rbp), %rax
	incl	1092(%rax)
	movzbl	-1(%rbp), %eax
	addl	$4, %eax
	movq	-16(%rbp), %rcx
	movl	%eax, 16(%rcx)
	movq	-16(%rbp), %rsi
	movl	60(%rsi), %edi
	addq	$1096, %rsi             # imm = 0x448
	callq	BZ2_indexIntoF
	movq	-16(%rbp), %rcx
	movl	%eax, 64(%rcx)
	movq	-16(%rbp), %rax
	movq	3160(%rax), %rdx
	movl	60(%rax), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rax), %rsi
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
	movl	%esi, 60(%rax)
	movq	-16(%rbp), %rax
	cmpl	$0, 24(%rax)
	jne	.LBB31_28
# BB#26:                                # %if.then308
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	movslq	28(%rax), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rax)
	movq	-16(%rbp), %rax
	incl	28(%rax)
	movq	-16(%rbp), %rax
	cmpl	$512, 28(%rax)          # imm = 0x200
	jne	.LBB31_28
# BB#27:                                # %if.then318
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	movl	$0, 28(%rax)
.LBB31_28:                              # %if.end321
                                        #   in Loop: Header=BB31_1 Depth=1
	movq	-16(%rbp), %rax
	decl	24(%rax)
	movq	-16(%rbp), %rax
	xorl	%ecx, %ecx
	cmpl	$1, 24(%rax)
	sete	%cl
	xorl	%ecx, 64(%rax)
	movq	-16(%rbp), %rax
	incl	1092(%rax)
	jmp	.LBB31_1
	.p2align	4, 0x90
.LBB31_32:                              # %if.then375
                                        #   in Loop: Header=BB31_29 Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	incl	40(%rax)
.LBB31_29:                              # %while.body334
                                        # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 32(%rax)
	je	.LBB31_42
# BB#30:                                # %if.end340
                                        #   in Loop: Header=BB31_29 Depth=1
	movq	-16(%rbp), %rax
	cmpl	$0, 16(%rax)
	je	.LBB31_33
# BB#31:                                # %if.end345
                                        #   in Loop: Header=BB31_29 Depth=1
	movzbl	12(%rax), %eax
	movq	-16(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	24(%rcx), %rcx
	movb	%al, (%rcx)
	movq	-16(%rbp), %rax
	movl	3184(%rax), %ecx
	movl	%ecx, %edx
	shll	$8, %edx
	shrl	$24, %ecx
	movzbl	12(%rax), %esi
	xorl	%ecx, %esi
	xorl	BZ2_crc32Table(,%rsi,4), %edx
	movl	%edx, 3184(%rax)
	movq	-16(%rbp), %rax
	decl	16(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	incq	24(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	decl	32(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	incl	36(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 36(%rax)
	jne	.LBB31_29
	jmp	.LBB31_32
.LBB31_33:                              # %while.end380
                                        #   in Loop: Header=BB31_29 Depth=1
	movq	-16(%rbp), %rcx
	movl	64080(%rcx), %ecx
	incl	%ecx
	cmpl	%ecx, 1092(%rax)
	je	.LBB31_42
# BB#34:                                # %if.end387
                                        #   in Loop: Header=BB31_29 Depth=1
	movq	-16(%rbp), %rax
	movl	$1, 16(%rax)
	movq	-16(%rbp), %rax
	movzbl	64(%rax), %ecx
	movb	%cl, 12(%rax)
	movq	-16(%rbp), %rsi
	movl	60(%rsi), %edi
	addq	$1096, %rsi             # imm = 0x448
	callq	BZ2_indexIntoF
	movb	%al, -1(%rbp)
	movq	-16(%rbp), %rax
	movq	3160(%rax), %rdx
	movl	60(%rax), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rax), %rsi
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
	movl	%esi, 60(%rax)
	movq	-16(%rbp), %rax
	incl	1092(%rax)
	movq	-16(%rbp), %rax
	movl	64080(%rax), %ecx
	incl	%ecx
	cmpl	%ecx, 1092(%rax)
	je	.LBB31_29
# BB#35:                                # %if.end424
                                        #   in Loop: Header=BB31_29 Depth=1
	movzbl	-1(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	64(%rcx), %eax
	jne	.LBB31_36
# BB#37:                                # %if.end432
                                        #   in Loop: Header=BB31_29 Depth=1
	movq	-16(%rbp), %rax
	movl	$2, 16(%rax)
	movq	-16(%rbp), %rsi
	movl	60(%rsi), %edi
	addq	$1096, %rsi             # imm = 0x448
	callq	BZ2_indexIntoF
	movb	%al, -1(%rbp)
	movq	-16(%rbp), %rax
	movq	3160(%rax), %rdx
	movl	60(%rax), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rax), %rsi
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
	movl	%esi, 60(%rax)
	movq	-16(%rbp), %rax
	incl	1092(%rax)
	movq	-16(%rbp), %rax
	movl	64080(%rax), %ecx
	incl	%ecx
	cmpl	%ecx, 1092(%rax)
	je	.LBB31_29
# BB#38:                                # %if.end466
                                        #   in Loop: Header=BB31_29 Depth=1
	movzbl	-1(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	64(%rcx), %eax
	je	.LBB31_39
.LBB31_36:                              # %if.then429
                                        #   in Loop: Header=BB31_29 Depth=1
	movzbl	-1(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	%eax, 64(%rcx)
	jmp	.LBB31_29
.LBB31_39:                              # %if.end474
                                        #   in Loop: Header=BB31_29 Depth=1
	movq	-16(%rbp), %rax
	movl	$3, 16(%rax)
	movq	-16(%rbp), %rsi
	movl	60(%rsi), %edi
	addq	$1096, %rsi             # imm = 0x448
	callq	BZ2_indexIntoF
	movb	%al, -1(%rbp)
	movq	-16(%rbp), %rax
	movq	3160(%rax), %rdx
	movl	60(%rax), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rax), %rsi
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
	movl	%esi, 60(%rax)
	movq	-16(%rbp), %rax
	incl	1092(%rax)
	movq	-16(%rbp), %rax
	movl	64080(%rax), %ecx
	incl	%ecx
	cmpl	%ecx, 1092(%rax)
	je	.LBB31_29
# BB#40:                                # %if.end508
                                        #   in Loop: Header=BB31_29 Depth=1
	movzbl	-1(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	64(%rcx), %eax
	jne	.LBB31_36
# BB#41:                                # %if.end516
                                        #   in Loop: Header=BB31_29 Depth=1
	movq	-16(%rbp), %rsi
	movl	60(%rsi), %edi
	addq	$1096, %rsi             # imm = 0x448
	callq	BZ2_indexIntoF
	movb	%al, -1(%rbp)
	movq	-16(%rbp), %rax
	movq	3160(%rax), %rdx
	movl	60(%rax), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rax), %rsi
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
	movl	%esi, 60(%rax)
	movq	-16(%rbp), %rax
	incl	1092(%rax)
	movzbl	-1(%rbp), %eax
	addl	$4, %eax
	movq	-16(%rbp), %rcx
	movl	%eax, 16(%rcx)
	movq	-16(%rbp), %rsi
	movl	60(%rsi), %edi
	addq	$1096, %rsi             # imm = 0x448
	callq	BZ2_indexIntoF
	movq	-16(%rbp), %rcx
	movl	%eax, 64(%rcx)
	movq	-16(%rbp), %rax
	movq	3160(%rax), %rdx
	movl	60(%rax), %ecx
	movzwl	(%rdx,%rcx,2), %edx
	movq	3168(%rax), %rsi
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
	movl	%esi, 60(%rax)
	movq	-16(%rbp), %rax
	incl	1092(%rax)
	jmp	.LBB31_29
.LBB31_42:                              # %return
	addq	$16, %rsp
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
.Lcfi100:
	.cfi_def_cfa_offset 16
.Lcfi101:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi102:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	cmpb	$0, 20(%rdi)
	jne	.LBB32_1
# BB#29:                                # %if.else
	movq	-16(%rbp), %rax
	movl	3184(%rax), %eax
	movl	%eax, -44(%rbp)
	movq	-16(%rbp), %rax
	movb	12(%rax), %al
	movb	%al, -17(%rbp)
	movq	-16(%rbp), %rax
	movl	16(%rax), %eax
	movl	%eax, -40(%rbp)
	movq	-16(%rbp), %rax
	movl	1092(%rax), %eax
	movl	%eax, -28(%rbp)
	movq	-16(%rbp), %rax
	movl	64(%rax), %eax
	movl	%eax, -32(%rbp)
	movq	-16(%rbp), %rax
	movq	3152(%rax), %rax
	movq	%rax, -64(%rbp)
	movq	-16(%rbp), %rax
	movl	60(%rax), %eax
	movl	%eax, -24(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	24(%rax), %rax
	movq	%rax, -72(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movl	32(%rax), %eax
	movl	%eax, -36(%rbp)
	movl	%eax, -76(%rbp)
	movq	-16(%rbp), %rax
	movl	64080(%rax), %eax
	incl	%eax
	movl	%eax, -52(%rbp)
	cmpl	$0, -40(%rbp)
	jg	.LBB32_31
	jmp	.LBB32_39
	.p2align	4, 0x90
.LBB32_4:                               # %if.then23
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	incl	40(%rax)
.LBB32_1:                               # %while.body2
                                        # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 32(%rax)
	je	.LBB32_44
# BB#2:                                 # %if.end
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	cmpl	$0, 16(%rax)
	je	.LBB32_5
# BB#3:                                 # %if.end6
                                        #   in Loop: Header=BB32_1 Depth=1
	movzbl	12(%rax), %eax
	movq	-16(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	24(%rcx), %rcx
	movb	%al, (%rcx)
	movq	-16(%rbp), %rax
	movl	3184(%rax), %ecx
	movl	%ecx, %edx
	shll	$8, %edx
	shrl	$24, %ecx
	movzbl	12(%rax), %esi
	xorl	%ecx, %esi
	xorl	BZ2_crc32Table(,%rsi,4), %edx
	movl	%edx, 3184(%rax)
	movq	-16(%rbp), %rax
	decl	16(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	incq	24(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	decl	32(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	incl	36(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 36(%rax)
	jne	.LBB32_1
	jmp	.LBB32_4
.LBB32_5:                               # %while.end
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rcx
	movl	64080(%rcx), %ecx
	incl	%ecx
	cmpl	%ecx, 1092(%rax)
	je	.LBB32_44
# BB#6:                                 # %if.end30
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	movl	$1, 16(%rax)
	movq	-16(%rbp), %rax
	movzbl	64(%rax), %ecx
	movb	%cl, 12(%rax)
	movq	-16(%rbp), %rax
	movq	3152(%rax), %rcx
	movl	60(%rax), %edx
	movl	(%rcx,%rdx,4), %ecx
	movl	%ecx, 60(%rax)
	movq	-16(%rbp), %rax
	movzbl	60(%rax), %eax
	movb	%al, -1(%rbp)
	movq	-16(%rbp), %rax
	shrl	$8, 60(%rax)
	movq	-16(%rbp), %rax
	cmpl	$0, 24(%rax)
	jne	.LBB32_9
# BB#7:                                 # %if.then43
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	movslq	28(%rax), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rax)
	movq	-16(%rbp), %rax
	incl	28(%rax)
	movq	-16(%rbp), %rax
	cmpl	$512, 28(%rax)          # imm = 0x200
	jne	.LBB32_9
# BB#8:                                 # %if.then52
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	movl	$0, 28(%rax)
.LBB32_9:                               # %if.end55
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	decl	24(%rax)
	movq	-16(%rbp), %rax
	xorl	%ecx, %ecx
	cmpl	$1, 24(%rax)
	sete	%cl
	movzbl	-1(%rbp), %eax
	xorl	%eax, %ecx
	movb	%cl, -1(%rbp)
	movq	-16(%rbp), %rax
	incl	1092(%rax)
	movq	-16(%rbp), %rax
	movl	64080(%rax), %ecx
	incl	%ecx
	cmpl	%ecx, 1092(%rax)
	je	.LBB32_1
# BB#10:                                # %if.end72
                                        #   in Loop: Header=BB32_1 Depth=1
	movzbl	-1(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	64(%rcx), %eax
	je	.LBB32_12
.LBB32_11:                              # %if.then77
                                        #   in Loop: Header=BB32_1 Depth=1
	movzbl	-1(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	%eax, 64(%rcx)
	jmp	.LBB32_1
.LBB32_12:                              # %if.end80
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	movl	$2, 16(%rax)
	movq	-16(%rbp), %rax
	movq	3152(%rax), %rcx
	movl	60(%rax), %edx
	movl	(%rcx,%rdx,4), %ecx
	movl	%ecx, 60(%rax)
	movq	-16(%rbp), %rax
	movzbl	60(%rax), %eax
	movb	%al, -1(%rbp)
	movq	-16(%rbp), %rax
	shrl	$8, 60(%rax)
	movq	-16(%rbp), %rax
	cmpl	$0, 24(%rax)
	jne	.LBB32_15
# BB#13:                                # %if.then95
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	movslq	28(%rax), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rax)
	movq	-16(%rbp), %rax
	incl	28(%rax)
	movq	-16(%rbp), %rax
	cmpl	$512, 28(%rax)          # imm = 0x200
	jne	.LBB32_15
# BB#14:                                # %if.then105
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	movl	$0, 28(%rax)
.LBB32_15:                              # %if.end108
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	decl	24(%rax)
	movq	-16(%rbp), %rax
	xorl	%ecx, %ecx
	cmpl	$1, 24(%rax)
	sete	%cl
	movzbl	-1(%rbp), %eax
	xorl	%eax, %ecx
	movb	%cl, -1(%rbp)
	movq	-16(%rbp), %rax
	incl	1092(%rax)
	movq	-16(%rbp), %rax
	movl	64080(%rax), %ecx
	incl	%ecx
	cmpl	%ecx, 1092(%rax)
	je	.LBB32_1
# BB#16:                                # %if.end126
                                        #   in Loop: Header=BB32_1 Depth=1
	movzbl	-1(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	64(%rcx), %eax
	jne	.LBB32_11
# BB#17:                                # %if.end134
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	movl	$3, 16(%rax)
	movq	-16(%rbp), %rax
	movq	3152(%rax), %rcx
	movl	60(%rax), %edx
	movl	(%rcx,%rdx,4), %ecx
	movl	%ecx, 60(%rax)
	movq	-16(%rbp), %rax
	movzbl	60(%rax), %eax
	movb	%al, -1(%rbp)
	movq	-16(%rbp), %rax
	shrl	$8, 60(%rax)
	movq	-16(%rbp), %rax
	cmpl	$0, 24(%rax)
	jne	.LBB32_20
# BB#18:                                # %if.then149
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	movslq	28(%rax), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rax)
	movq	-16(%rbp), %rax
	incl	28(%rax)
	movq	-16(%rbp), %rax
	cmpl	$512, 28(%rax)          # imm = 0x200
	jne	.LBB32_20
# BB#19:                                # %if.then159
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	movl	$0, 28(%rax)
.LBB32_20:                              # %if.end162
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	decl	24(%rax)
	movq	-16(%rbp), %rax
	xorl	%ecx, %ecx
	cmpl	$1, 24(%rax)
	sete	%cl
	movzbl	-1(%rbp), %eax
	xorl	%eax, %ecx
	movb	%cl, -1(%rbp)
	movq	-16(%rbp), %rax
	incl	1092(%rax)
	movq	-16(%rbp), %rax
	movl	64080(%rax), %ecx
	incl	%ecx
	cmpl	%ecx, 1092(%rax)
	je	.LBB32_1
# BB#21:                                # %if.end180
                                        #   in Loop: Header=BB32_1 Depth=1
	movzbl	-1(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	64(%rcx), %eax
	jne	.LBB32_11
# BB#22:                                # %if.end188
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	movq	3152(%rax), %rcx
	movl	60(%rax), %edx
	movl	(%rcx,%rdx,4), %ecx
	movl	%ecx, 60(%rax)
	movq	-16(%rbp), %rax
	movzbl	60(%rax), %eax
	movb	%al, -1(%rbp)
	movq	-16(%rbp), %rax
	shrl	$8, 60(%rax)
	movq	-16(%rbp), %rax
	cmpl	$0, 24(%rax)
	jne	.LBB32_25
# BB#23:                                # %if.then202
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	movslq	28(%rax), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rax)
	movq	-16(%rbp), %rax
	incl	28(%rax)
	movq	-16(%rbp), %rax
	cmpl	$512, 28(%rax)          # imm = 0x200
	jne	.LBB32_25
# BB#24:                                # %if.then212
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	movl	$0, 28(%rax)
.LBB32_25:                              # %if.end215
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	decl	24(%rax)
	movq	-16(%rbp), %rax
	xorl	%ecx, %ecx
	cmpl	$1, 24(%rax)
	sete	%cl
	movzbl	-1(%rbp), %eax
	xorl	%eax, %ecx
	movb	%cl, -1(%rbp)
	movq	-16(%rbp), %rax
	incl	1092(%rax)
	movzbl	-1(%rbp), %eax
	addl	$4, %eax
	movq	-16(%rbp), %rcx
	movl	%eax, 16(%rcx)
	movq	-16(%rbp), %rax
	movq	3152(%rax), %rcx
	movl	60(%rax), %edx
	movl	(%rcx,%rdx,4), %ecx
	movl	%ecx, 60(%rax)
	movq	-16(%rbp), %rax
	movzbl	60(%rax), %ecx
	movl	%ecx, 64(%rax)
	movq	-16(%rbp), %rax
	shrl	$8, 60(%rax)
	movq	-16(%rbp), %rax
	cmpl	$0, 24(%rax)
	jne	.LBB32_28
# BB#26:                                # %if.then245
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	movslq	28(%rax), %rcx
	movl	BZ2_rNums(,%rcx,4), %ecx
	movl	%ecx, 24(%rax)
	movq	-16(%rbp), %rax
	incl	28(%rax)
	movq	-16(%rbp), %rax
	cmpl	$512, 28(%rax)          # imm = 0x200
	jne	.LBB32_28
# BB#27:                                # %if.then255
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	movl	$0, 28(%rax)
.LBB32_28:                              # %if.end258
                                        #   in Loop: Header=BB32_1 Depth=1
	movq	-16(%rbp), %rax
	decl	24(%rax)
	movq	-16(%rbp), %rax
	xorl	%ecx, %ecx
	cmpl	$1, 24(%rax)
	sete	%cl
	xorl	%ecx, 64(%rax)
	movq	-16(%rbp), %rax
	incl	1092(%rax)
	jmp	.LBB32_1
.LBB32_50:                              # %if.then355
                                        #   in Loop: Header=BB32_39 Depth=1
	movzbl	-1(%rbp), %eax
	movl	%eax, -32(%rbp)
	.p2align	4, 0x90
.LBB32_30:                              # %while.body282
                                        #   in Loop: Header=BB32_39 Depth=1
	cmpl	$0, -40(%rbp)
	jg	.LBB32_31
	jmp	.LBB32_39
	.p2align	4, 0x90
.LBB32_33:                              # %if.end295
                                        #   in Loop: Header=BB32_31 Depth=1
	movzbl	-17(%rbp), %eax
	movq	-72(%rbp), %rcx
	movb	%al, (%rcx)
	movl	-44(%rbp), %eax
	movl	%eax, %ecx
	shll	$8, %ecx
	shrl	$24, %eax
	movzbl	-17(%rbp), %edx
	xorl	%eax, %edx
	xorl	BZ2_crc32Table(,%rdx,4), %ecx
	movl	%ecx, -44(%rbp)
	decl	-40(%rbp)
	incq	-72(%rbp)
	decl	-36(%rbp)
.LBB32_31:                              # %while.body287
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$0, -36(%rbp)
	je	.LBB32_54
# BB#32:                                # %if.end291
                                        #   in Loop: Header=BB32_31 Depth=1
	cmpl	$1, -40(%rbp)
	jne	.LBB32_33
	.p2align	4, 0x90
.LBB32_34:                              # %s_state_out_len_eq_one
	cmpl	$0, -36(%rbp)
	je	.LBB32_35
.LBB32_38:                              # %if.end310
	movb	-17(%rbp), %al
	movq	-72(%rbp), %rcx
	movb	%al, (%rcx)
	movl	-44(%rbp), %eax
	movl	%eax, %ecx
	shll	$8, %ecx
	shrl	$24, %eax
	movzbl	-17(%rbp), %edx
	xorl	%eax, %edx
	xorl	BZ2_crc32Table(,%rdx,4), %ecx
	movl	%ecx, -44(%rbp)
	incq	-72(%rbp)
	decl	-36(%rbp)
.LBB32_39:                              # %if.end320
                                        # =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	cmpl	-52(%rbp), %eax
	je	.LBB32_40
# BB#45:                                # %if.end324
                                        #   in Loop: Header=BB32_39 Depth=1
	movzbl	-32(%rbp), %eax
	movb	%al, -17(%rbp)
	movq	-64(%rbp), %rax
	movl	-24(%rbp), %ecx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -24(%rbp)
	movzbl	-24(%rbp), %eax
	movb	%al, -1(%rbp)
	shrl	$8, -24(%rbp)
	incl	-28(%rbp)
	movzbl	-1(%rbp), %eax
	cmpl	-32(%rbp), %eax
	je	.LBB32_47
# BB#46:                                # %if.then335
	movzbl	-1(%rbp), %eax
	movl	%eax, -32(%rbp)
	cmpl	$0, -36(%rbp)
	jne	.LBB32_38
	jmp	.LBB32_35
	.p2align	4, 0x90
.LBB32_47:                              # %if.end337
                                        #   in Loop: Header=BB32_39 Depth=1
	movl	-28(%rbp), %eax
	cmpl	-52(%rbp), %eax
	je	.LBB32_34
# BB#48:                                # %if.end341
                                        #   in Loop: Header=BB32_39 Depth=1
	movl	$2, -40(%rbp)
	movq	-64(%rbp), %rax
	movl	-24(%rbp), %ecx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -24(%rbp)
	movzbl	-24(%rbp), %eax
	movb	%al, -1(%rbp)
	shrl	$8, -24(%rbp)
	movl	-28(%rbp), %eax
	incl	%eax
	movl	%eax, -28(%rbp)
	cmpl	-52(%rbp), %eax
	je	.LBB32_30
# BB#49:                                # %if.end351
                                        #   in Loop: Header=BB32_39 Depth=1
	movzbl	-1(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jne	.LBB32_50
# BB#51:                                # %if.end357
                                        #   in Loop: Header=BB32_39 Depth=1
	movl	$3, -40(%rbp)
	movq	-64(%rbp), %rax
	movl	-24(%rbp), %ecx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -24(%rbp)
	movzbl	-24(%rbp), %eax
	movb	%al, -1(%rbp)
	shrl	$8, -24(%rbp)
	movl	-28(%rbp), %eax
	incl	%eax
	movl	%eax, -28(%rbp)
	cmpl	-52(%rbp), %eax
	je	.LBB32_30
# BB#52:                                # %if.end367
                                        #   in Loop: Header=BB32_39 Depth=1
	movzbl	-1(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jne	.LBB32_50
# BB#53:                                # %if.end373
                                        #   in Loop: Header=BB32_39 Depth=1
	movq	-64(%rbp), %rax
	movl	-24(%rbp), %ecx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -24(%rbp)
	movzbl	-24(%rbp), %eax
	shrl	$8, -24(%rbp)
	movb	%al, -1(%rbp)
	incl	-28(%rbp)
	movzbl	-1(%rbp), %eax
	addl	$4, %eax
	movl	%eax, -40(%rbp)
	movq	-64(%rbp), %rax
	movl	-24(%rbp), %ecx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -24(%rbp)
	movzbl	-24(%rbp), %eax
	movl	%eax, -32(%rbp)
	shrl	$8, -24(%rbp)
	incl	-28(%rbp)
	cmpl	$0, -40(%rbp)
	jg	.LBB32_31
	jmp	.LBB32_39
.LBB32_54:                              # %return_notr55
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movl	36(%rax), %eax
	movl	%eax, -48(%rbp)
	movl	-76(%rbp), %eax
	subl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	movq	(%rcx), %rcx
	addl	%eax, 36(%rcx)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movl	36(%rax), %eax
	cmpl	-48(%rbp), %eax
	jae	.LBB32_56
# BB#55:                                # %if.then39865
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	incl	40(%rax)
.LBB32_56:                              # %if.end40270
	movl	-44(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	%eax, 3184(%rcx)
	movb	-17(%rbp), %al
	movq	-16(%rbp), %rcx
	movb	%al, 12(%rcx)
	movl	-40(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	%eax, 16(%rcx)
.LBB32_43:                              # %if.end414
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	%eax, 1092(%rcx)
	movl	-32(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	%eax, 64(%rcx)
	movq	-64(%rbp), %rax
	movq	-16(%rbp), %rcx
	movq	%rax, 3152(%rcx)
	movl	-24(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	%eax, 60(%rcx)
	movq	-72(%rbp), %rax
	movq	-16(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	%rax, 24(%rcx)
	movl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	movq	(%rcx), %rcx
	movl	%eax, 32(%rcx)
.LBB32_44:                              # %if.end414
	popq	%rbp
	retq
.LBB32_40:                              # %if.then323
	movl	$0, -40(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movl	36(%rax), %eax
	movl	%eax, -48(%rbp)
	movl	-76(%rbp), %eax
	subl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	movq	(%rcx), %rcx
	addl	%eax, 36(%rcx)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movl	36(%rax), %eax
	cmpl	-48(%rbp), %eax
	jae	.LBB32_42
# BB#41:                                # %if.then39811
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	incl	40(%rax)
.LBB32_42:                              # %if.end40216
	movl	-44(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	%eax, 3184(%rcx)
	movb	-17(%rbp), %al
	movq	-16(%rbp), %rcx
	movb	%al, 12(%rcx)
	movq	-16(%rbp), %rax
	movl	$0, 16(%rax)
	jmp	.LBB32_43
.LBB32_35:                              # %if.then309
	movl	$1, -40(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movl	36(%rax), %eax
	movl	%eax, -48(%rbp)
	movl	-76(%rbp), %eax
	subl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	movq	(%rcx), %rcx
	addl	%eax, 36(%rcx)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movl	36(%rax), %eax
	cmpl	-48(%rbp), %eax
	jae	.LBB32_37
# BB#36:                                # %if.then39838
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	incl	40(%rax)
.LBB32_37:                              # %if.end40243
	movl	-44(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	%eax, 3184(%rcx)
	movb	-17(%rbp), %al
	movq	-16(%rbp), %rcx
	movb	%al, 12(%rcx)
	movq	-16(%rbp), %rax
	movl	$1, 16(%rax)
	jmp	.LBB32_43
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
.Lcfi103:
	.cfi_def_cfa_offset 16
.Lcfi104:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi105:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	testq	%rdi, %rdi
	je	.LBB33_1
# BB#3:                                 # %if.end
	movq	-16(%rbp), %rax
	movq	48(%rax), %rax
	movq	%rax, -8(%rbp)
	testq	%rax, %rax
	je	.LBB33_1
# BB#4:                                 # %if.end3
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpq	-16(%rbp), %rax
	je	.LBB33_5
.LBB33_1:                               # %if.then
	movl	$-2, -20(%rbp)
	movl	$-2, %eax
.LBB33_2:                               # %if.then
	addq	$32, %rsp
	popq	%rbp
	retq
.LBB33_5:                               # %if.end7
	movq	-8(%rbp), %rax
	cmpq	$0, 3152(%rax)
	je	.LBB33_7
# BB#6:                                 # %if.then9
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	movq	-8(%rbp), %rcx
	movq	3152(%rcx), %rsi
	callq	*64(%rax)
.LBB33_7:                               # %if.end11
	movq	-8(%rbp), %rax
	cmpq	$0, 3160(%rax)
	je	.LBB33_9
# BB#8:                                 # %if.then13
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	movq	-8(%rbp), %rcx
	movq	3160(%rcx), %rsi
	callq	*64(%rax)
.LBB33_9:                               # %if.end17
	movq	-8(%rbp), %rax
	cmpq	$0, 3168(%rax)
	je	.LBB33_11
# BB#10:                                # %if.then19
	movq	-16(%rbp), %rax
	movq	72(%rax), %rdi
	movq	-8(%rbp), %rcx
	movq	3168(%rcx), %rsi
	callq	*64(%rax)
.LBB33_11:                              # %if.end23
	movq	-16(%rbp), %rax
	movq	48(%rax), %rsi
	movq	72(%rax), %rdi
	callq	*64(%rax)
	movq	-16(%rbp), %rax
	movq	$0, 48(%rax)
	movl	$0, -20(%rbp)
	xorl	%eax, %eax
	jmp	.LBB33_2
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
.Lcfi106:
	.cfi_def_cfa_offset 16
.Lcfi107:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi108:
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -48(%rbp)
	movl	%edx, -32(%rbp)
	movl	%ecx, -28(%rbp)
	movl	%r8d, -20(%rbp)
	movq	$0, -8(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB34_2
# BB#1:                                 # %if.then
	movq	-16(%rbp), %rax
	movl	$0, (%rax)
.LBB34_2:                               # %if.end
	cmpq	$0, -8(%rbp)
	je	.LBB34_4
# BB#3:                                 # %if.then2
	movq	-8(%rbp), %rax
	movl	$0, 5096(%rax)
.LBB34_4:                               # %if.end3
	cmpq	$0, -48(%rbp)
	je	.LBB34_17
# BB#5:                                 # %if.end3
	movl	-32(%rbp), %eax
	testl	%eax, %eax
	jle	.LBB34_17
# BB#6:                                 # %if.end3
	cmpl	$9, %eax
	jg	.LBB34_17
# BB#7:                                 # %if.end3
	movl	-20(%rbp), %eax
	testl	%eax, %eax
	js	.LBB34_17
# BB#8:                                 # %if.end3
	cmpl	$250, %eax
	jg	.LBB34_17
# BB#9:                                 # %if.end3
	movl	-28(%rbp), %eax
	testl	%eax, %eax
	js	.LBB34_17
# BB#10:                                # %if.end3
	cmpl	$5, %eax
	jge	.LBB34_17
# BB#11:                                # %if.end24
	movq	-48(%rbp), %rdi
	callq	ferror
	testl	%eax, %eax
	je	.LBB34_23
# BB#12:                                # %if.then25
	cmpq	$0, -16(%rbp)
	je	.LBB34_14
# BB#13:                                # %if.then27
	movq	-16(%rbp), %rax
	movl	$-6, (%rax)
.LBB34_14:                              # %if.end28
	cmpq	$0, -8(%rbp)
	je	.LBB34_21
# BB#15:                                # %if.then30
	movq	-8(%rbp), %rax
	movl	$-6, 5096(%rax)
	jmp	.LBB34_21
.LBB34_17:                              # %if.then16
	cmpq	$0, -16(%rbp)
	je	.LBB34_19
# BB#18:                                # %if.then18
	movq	-16(%rbp), %rax
	movl	$-2, (%rax)
.LBB34_19:                              # %if.end19
	cmpq	$0, -8(%rbp)
	je	.LBB34_21
# BB#20:                                # %if.then21
	movq	-8(%rbp), %rax
	movl	$-2, 5096(%rax)
.LBB34_21:                              # %if.end23
	movq	$0, -40(%rbp)
.LBB34_22:                              # %return
	movq	-40(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	retq
.LBB34_23:                              # %if.end33
	movl	$5104, %edi             # imm = 0x13F0
	callq	malloc
	movq	%rax, -8(%rbp)
	movq	-16(%rbp), %rcx
	testq	%rax, %rax
	je	.LBB34_30
# BB#24:                                # %if.end44
	testq	%rcx, %rcx
	je	.LBB34_26
# BB#25:                                # %if.then46
	movq	-16(%rbp), %rax
	movl	$0, (%rax)
.LBB34_26:                              # %if.end47
	cmpq	$0, -8(%rbp)
	je	.LBB34_28
# BB#27:                                # %if.then49
	movq	-8(%rbp), %rax
	movl	$0, 5096(%rax)
.LBB34_28:                              # %if.end51
	movq	-8(%rbp), %rax
	movb	$0, 5100(%rax)
	movq	-8(%rbp), %rax
	movl	$0, 5008(%rax)
	movq	-48(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	%rax, (%rcx)
	movq	-8(%rbp), %rax
	movb	$1, 5012(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 5072(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 5080(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 5088(%rax)
	cmpl	$0, -20(%rbp)
	je	.LBB34_35
# BB#29:                                # %if.end561
	movl	$5016, %edi             # imm = 0x1398
	addq	-8(%rbp), %rdi
	movl	-32(%rbp), %esi
	movl	-28(%rbp), %edx
	movl	-20(%rbp), %ecx
	jmp	.LBB34_36
.LBB34_30:                              # %if.then36
	testq	%rcx, %rcx
	je	.LBB34_32
# BB#31:                                # %if.then38
	movq	-16(%rbp), %rax
	movl	$-3, (%rax)
.LBB34_32:                              # %if.end39
	cmpq	$0, -8(%rbp)
	je	.LBB34_21
# BB#33:                                # %if.then41
	movq	-8(%rbp), %rax
	movl	$-3, 5096(%rax)
	jmp	.LBB34_21
.LBB34_35:                              # %if.then55
	movl	$30, -20(%rbp)
	movl	$5016, %edi             # imm = 0x1398
	addq	-8(%rbp), %rdi
	movl	-32(%rbp), %esi
	movl	-28(%rbp), %edx
	movl	$30, %ecx
.LBB34_36:                              # %if.then55
	callq	BZ2_bzCompressInit
	movl	%eax, -24(%rbp)
	testl	%eax, %eax
	je	.LBB34_42
# BB#37:                                # %if.then60
	cmpq	$0, -16(%rbp)
	je	.LBB34_39
# BB#38:                                # %if.then62
	movl	-24(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	%eax, (%rcx)
.LBB34_39:                              # %if.end63
	cmpq	$0, -8(%rbp)
	je	.LBB34_41
# BB#40:                                # %if.then65
	movl	-24(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 5096(%rcx)
.LBB34_41:                              # %if.end67
	movq	-8(%rbp), %rdi
	callq	free
	jmp	.LBB34_21
.LBB34_42:                              # %if.end68
	movq	-8(%rbp), %rax
	movl	$0, 5024(%rax)
	movq	-8(%rbp), %rax
	movb	$1, 5100(%rax)
	movq	-8(%rbp), %rax
	movq	%rax, -40(%rbp)
	jmp	.LBB34_22
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
.Lcfi109:
	.cfi_def_cfa_offset 16
.Lcfi110:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi111:
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -40(%rbp)
	movl	%ecx, -20(%rbp)
	movq	-48(%rbp), %rax
	movq	%rax, -8(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB35_2
# BB#1:                                 # %if.then
	movq	-16(%rbp), %rax
	movl	$0, (%rax)
.LBB35_2:                               # %if.end
	cmpq	$0, -8(%rbp)
	je	.LBB35_4
# BB#3:                                 # %if.then2
	movq	-8(%rbp), %rax
	movl	$0, 5096(%rax)
.LBB35_4:                               # %if.end3
	cmpq	$0, -8(%rbp)
	je	.LBB35_7
# BB#5:                                 # %if.end3
	movq	-40(%rbp), %rax
	testq	%rax, %rax
	je	.LBB35_7
# BB#6:                                 # %if.end3
	movl	-20(%rbp), %eax
	testl	%eax, %eax
	js	.LBB35_7
# BB#11:                                # %if.end16
	movq	-8(%rbp), %rax
	cmpb	$0, 5012(%rax)
	je	.LBB35_12
# BB#16:                                # %if.end25
	movq	-8(%rbp), %rax
	movq	(%rax), %rdi
	callq	ferror
	testl	%eax, %eax
	je	.LBB35_21
.LBB35_17:                              # %if.then27
	cmpq	$0, -16(%rbp)
	je	.LBB35_19
# BB#18:                                # %if.then29
	movq	-16(%rbp), %rax
	movl	$-6, (%rax)
.LBB35_19:                              # %if.end30
	cmpq	$0, -8(%rbp)
	je	.LBB35_36
# BB#20:                                # %if.then32
	movq	-8(%rbp), %rax
	movl	$-6, 5096(%rax)
	jmp	.LBB35_36
.LBB35_7:                               # %if.then8
	cmpq	$0, -16(%rbp)
	je	.LBB35_9
# BB#8:                                 # %if.then10
	movq	-16(%rbp), %rax
	movl	$-2, (%rax)
.LBB35_9:                               # %if.end11
	cmpq	$0, -8(%rbp)
	je	.LBB35_36
# BB#10:                                # %if.then13
	movq	-8(%rbp), %rax
	movl	$-2, 5096(%rax)
	jmp	.LBB35_36
.LBB35_12:                              # %if.then17
	cmpq	$0, -16(%rbp)
	je	.LBB35_14
# BB#13:                                # %if.then19
	movq	-16(%rbp), %rax
	movl	$-1, (%rax)
.LBB35_14:                              # %if.end20
	cmpq	$0, -8(%rbp)
	je	.LBB35_36
# BB#15:                                # %if.then22
	movq	-8(%rbp), %rax
	movl	$-1, 5096(%rax)
	jmp	.LBB35_36
.LBB35_21:                              # %if.end35
	cmpl	$0, -20(%rbp)
	je	.LBB35_32
# BB#22:                                # %if.end45
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 5024(%rcx)
	movq	-40(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	%rax, 5016(%rcx)
	.p2align	4, 0x90
.LBB35_23:                              # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movl	$5000, 5048(%rax)       # imm = 0x1388
	movq	-8(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	%rcx, 5040(%rax)
	movq	-8(%rbp), %rdi
	addq	$5016, %rdi             # imm = 0x1398
	xorl	%esi, %esi
	callq	BZ2_bzCompress
	movl	%eax, -24(%rbp)
	cmpl	$1, %eax
	jne	.LBB35_24
# BB#28:                                # %if.end61
                                        #   in Loop: Header=BB35_23 Depth=1
	movq	-8(%rbp), %rax
	cmpl	$4999, 5048(%rax)       # imm = 0x1387
	ja	.LBB35_31
# BB#29:                                # %if.then65
                                        #   in Loop: Header=BB35_23 Depth=1
	movq	-8(%rbp), %rax
	movl	$5000, %ecx             # imm = 0x1388
	subl	5048(%rax), %ecx
	movl	%ecx, -28(%rbp)
	movq	-8(%rbp), %rdi
	movslq	-28(%rbp), %rdx
	movq	(%rdi), %rcx
	addq	$8, %rdi
	movl	$1, %esi
	callq	fwrite
	movl	%eax, -52(%rbp)
	cmpl	%eax, -28(%rbp)
	jne	.LBB35_17
# BB#30:                                # %lor.lhs.false75
                                        #   in Loop: Header=BB35_23 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB35_17
.LBB35_31:                              # %if.end90
                                        #   in Loop: Header=BB35_23 Depth=1
	movq	-8(%rbp), %rax
	cmpl	$0, 5024(%rax)
	jne	.LBB35_23
.LBB35_32:                              # %if.then95
	cmpq	$0, -16(%rbp)
	je	.LBB35_34
# BB#33:                                # %if.then98
	movq	-16(%rbp), %rax
	movl	$0, (%rax)
.LBB35_34:                              # %if.end99
	cmpq	$0, -8(%rbp)
	je	.LBB35_36
# BB#35:                                # %if.then102
	movq	-8(%rbp), %rax
	movl	$0, 5096(%rax)
	jmp	.LBB35_36
.LBB35_24:                              # %if.then53
	cmpq	$0, -16(%rbp)
	je	.LBB35_26
# BB#25:                                # %if.then55
	movl	-24(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	%eax, (%rcx)
.LBB35_26:                              # %if.end56
	cmpq	$0, -8(%rbp)
	je	.LBB35_36
# BB#27:                                # %if.then58
	movl	-24(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 5096(%rcx)
.LBB35_36:                              # %return
	addq	$64, %rsp
	popq	%rbp
	retq
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
.Lcfi112:
	.cfi_def_cfa_offset 16
.Lcfi113:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi114:
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%r8, %rax
	movq	%rdi, -32(%rbp)
	movq	%rsi, -24(%rbp)
	movl	%edx, -4(%rbp)
	movq	%rcx, -16(%rbp)
	movq	%rax, -40(%rbp)
	movq	-32(%rbp), %rdi
	movq	-24(%rbp), %rsi
	movl	-4(%rbp), %edx
	movq	-16(%rbp), %rcx
	movq	$0, (%rsp)
	xorl	%r8d, %r8d
	movq	%rax, %r9
	callq	BZ2_bzWriteClose64
	addq	$48, %rsp
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
.Lcfi115:
	.cfi_def_cfa_offset 16
.Lcfi116:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi117:
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movq	16(%rbp), %rax
	movq	%rdi, -16(%rbp)
	movq	%rsi, -72(%rbp)
	movl	%edx, -28(%rbp)
	movq	%rcx, -64(%rbp)
	movq	%r8, -56(%rbp)
	movq	%r9, -48(%rbp)
	movq	%rax, -40(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, -8(%rbp)
	testq	%rax, %rax
	je	.LBB37_1
# BB#5:                                 # %if.end6
	movq	-8(%rbp), %rax
	cmpb	$0, 5012(%rax)
	je	.LBB37_6
# BB#10:                                # %if.end15
	movq	-8(%rbp), %rax
	movq	(%rax), %rdi
	callq	ferror
	testl	%eax, %eax
	je	.LBB37_15
.LBB37_11:                              # %if.then17
	cmpq	$0, -16(%rbp)
	je	.LBB37_13
# BB#12:                                # %if.then19
	movq	-16(%rbp), %rax
	movl	$-6, (%rax)
.LBB37_13:                              # %if.end20
	cmpq	$0, -8(%rbp)
	je	.LBB37_51
# BB#14:                                # %if.then22
	movq	-8(%rbp), %rax
	movl	$-6, 5096(%rax)
	jmp	.LBB37_51
.LBB37_1:                               # %if.then
	cmpq	$0, -16(%rbp)
	je	.LBB37_3
# BB#2:                                 # %if.then2
	movq	-16(%rbp), %rax
	movl	$0, (%rax)
.LBB37_3:                               # %if.end
	cmpq	$0, -8(%rbp)
	je	.LBB37_51
# BB#4:                                 # %if.then4
	movq	-8(%rbp), %rax
	movl	$0, 5096(%rax)
	jmp	.LBB37_51
.LBB37_6:                               # %if.then7
	cmpq	$0, -16(%rbp)
	je	.LBB37_8
# BB#7:                                 # %if.then9
	movq	-16(%rbp), %rax
	movl	$-1, (%rax)
.LBB37_8:                               # %if.end10
	cmpq	$0, -8(%rbp)
	je	.LBB37_51
# BB#9:                                 # %if.then12
	movq	-8(%rbp), %rax
	movl	$-1, 5096(%rax)
	jmp	.LBB37_51
.LBB37_15:                              # %if.end25
	cmpq	$0, -64(%rbp)
	je	.LBB37_17
# BB#16:                                # %if.then27
	movq	-64(%rbp), %rax
	movl	$0, (%rax)
.LBB37_17:                              # %if.end28
	cmpq	$0, -56(%rbp)
	je	.LBB37_19
# BB#18:                                # %if.then30
	movq	-56(%rbp), %rax
	movl	$0, (%rax)
.LBB37_19:                              # %if.end31
	cmpq	$0, -48(%rbp)
	je	.LBB37_21
# BB#20:                                # %if.then33
	movq	-48(%rbp), %rax
	movl	$0, (%rax)
.LBB37_21:                              # %if.end34
	cmpq	$0, -40(%rbp)
	je	.LBB37_23
# BB#22:                                # %if.then36
	movq	-40(%rbp), %rax
	movl	$0, (%rax)
.LBB37_23:                              # %if.end37
	cmpl	$0, -28(%rbp)
	jne	.LBB37_35
# BB#24:                                # %land.lhs.true
	movq	-8(%rbp), %rax
	cmpl	$0, 5096(%rax)
	je	.LBB37_25
.LBB37_35:                              # %if.end89
	cmpl	$0, -28(%rbp)
	jne	.LBB37_38
# BB#36:                                # %land.lhs.true91
	movq	-8(%rbp), %rax
	movq	(%rax), %rdi
	callq	ferror
	testl	%eax, %eax
	je	.LBB37_37
.LBB37_38:                              # %if.end112
	cmpq	$0, -64(%rbp)
	je	.LBB37_40
# BB#39:                                # %if.then115
	movq	-8(%rbp), %rax
	movl	5028(%rax), %eax
	movq	-64(%rbp), %rcx
	movl	%eax, (%rcx)
.LBB37_40:                              # %if.end117
	cmpq	$0, -56(%rbp)
	je	.LBB37_42
# BB#41:                                # %if.then120
	movq	-8(%rbp), %rax
	movl	5032(%rax), %eax
	movq	-56(%rbp), %rcx
	movl	%eax, (%rcx)
.LBB37_42:                              # %if.end122
	cmpq	$0, -48(%rbp)
	je	.LBB37_44
# BB#43:                                # %if.then125
	movq	-8(%rbp), %rax
	movl	5052(%rax), %eax
	movq	-48(%rbp), %rcx
	movl	%eax, (%rcx)
.LBB37_44:                              # %if.end127
	cmpq	$0, -40(%rbp)
	je	.LBB37_46
# BB#45:                                # %if.then130
	movq	-8(%rbp), %rax
	movl	5056(%rax), %eax
	movq	-40(%rbp), %rcx
	movl	%eax, (%rcx)
.LBB37_46:                              # %if.end132
	cmpq	$0, -16(%rbp)
	je	.LBB37_48
# BB#47:                                # %if.then135
	movq	-16(%rbp), %rax
	movl	$0, (%rax)
.LBB37_48:                              # %if.end136
	cmpq	$0, -8(%rbp)
	je	.LBB37_50
# BB#49:                                # %if.then139
	movq	-8(%rbp), %rax
	movl	$0, 5096(%rax)
.LBB37_50:                              # %if.end141
	movq	-8(%rbp), %rdi
	addq	$5016, %rdi             # imm = 0x1398
	callq	BZ2_bzCompressEnd
	movq	-8(%rbp), %rdi
	callq	free
.LBB37_51:                              # %return
	addq	$80, %rsp
	popq	%rbp
	retq
	.p2align	4, 0x90
.LBB37_25:                              # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movl	$5000, 5048(%rax)       # imm = 0x1388
	movq	-8(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	%rcx, 5040(%rax)
	movq	-8(%rbp), %rdi
	addq	$5016, %rdi             # imm = 0x1398
	movl	$2, %esi
	callq	BZ2_bzCompress
	movl	%eax, -20(%rbp)
	cmpl	$3, %eax
	je	.LBB37_31
# BB#26:                                # %while.body
                                        #   in Loop: Header=BB37_25 Depth=1
	cmpl	$4, %eax
	jne	.LBB37_27
.LBB37_31:                              # %if.end56
                                        #   in Loop: Header=BB37_25 Depth=1
	movq	-8(%rbp), %rax
	cmpl	$4999, 5048(%rax)       # imm = 0x1387
	ja	.LBB37_34
# BB#32:                                # %if.then60
                                        #   in Loop: Header=BB37_25 Depth=1
	movq	-8(%rbp), %rax
	movl	$5000, %ecx             # imm = 0x1388
	subl	5048(%rax), %ecx
	movl	%ecx, -24(%rbp)
	movq	-8(%rbp), %rdi
	movslq	-24(%rbp), %rdx
	movq	(%rdi), %rcx
	addq	$8, %rdi
	movl	$1, %esi
	callq	fwrite
	movl	%eax, -76(%rbp)
	cmpl	%eax, -24(%rbp)
	jne	.LBB37_11
# BB#33:                                # %lor.lhs.false
                                        #   in Loop: Header=BB37_25 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB37_11
.LBB37_34:                              # %if.end84
                                        #   in Loop: Header=BB37_25 Depth=1
	cmpl	$4, -20(%rbp)
	jne	.LBB37_25
	jmp	.LBB37_35
.LBB37_37:                              # %if.then95
	movq	-8(%rbp), %rax
	movq	(%rax), %rdi
	callq	fflush
	movq	-8(%rbp), %rax
	movq	(%rax), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB37_11
	jmp	.LBB37_38
.LBB37_27:                              # %if.then48
	cmpq	$0, -16(%rbp)
	je	.LBB37_29
# BB#28:                                # %if.then50
	movl	-20(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	%eax, (%rcx)
.LBB37_29:                              # %if.end51
	cmpq	$0, -8(%rbp)
	je	.LBB37_51
# BB#30:                                # %if.then53
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 5096(%rcx)
	jmp	.LBB37_51
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
.Lcfi118:
	.cfi_def_cfa_offset 16
.Lcfi119:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi120:
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -64(%rbp)
	movl	%edx, -44(%rbp)
	movl	%ecx, -40(%rbp)
	movq	%r8, -56(%rbp)
	movl	%r9d, -20(%rbp)
	movq	$0, -8(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB38_2
# BB#1:                                 # %if.then
	movq	-16(%rbp), %rax
	movl	$0, (%rax)
.LBB38_2:                               # %if.end
	cmpq	$0, -8(%rbp)
	je	.LBB38_4
# BB#3:                                 # %if.then2
	movq	-8(%rbp), %rax
	movl	$0, 5096(%rax)
.LBB38_4:                               # %if.end3
	cmpq	$0, -64(%rbp)
	je	.LBB38_10
# BB#5:                                 # %lor.lhs.false
	movl	-40(%rbp), %eax
	testl	%eax, %eax
	setne	%cl
	cmpl	$1, %eax
	setne	%al
	testb	%al, %cl
	jne	.LBB38_10
# BB#6:                                 # %lor.lhs.false
	movl	-44(%rbp), %eax
	testl	%eax, %eax
	js	.LBB38_10
# BB#7:                                 # %lor.lhs.false
	cmpl	$4, %eax
	jg	.LBB38_10
# BB#8:                                 # %lor.lhs.false11
	cmpq	$0, -56(%rbp)
	jne	.LBB38_16
# BB#9:                                 # %lor.lhs.false11
	movl	-20(%rbp), %eax
	testl	%eax, %eax
	je	.LBB38_16
.LBB38_10:                              # %if.then21
	cmpq	$0, -16(%rbp)
	je	.LBB38_12
# BB#11:                                # %if.then23
	movq	-16(%rbp), %rax
	movl	$-2, (%rax)
.LBB38_12:                              # %if.end24
	cmpq	$0, -8(%rbp)
	je	.LBB38_14
# BB#13:                                # %if.then26
	movq	-8(%rbp), %rax
	movl	$-2, 5096(%rax)
.LBB38_14:                              # %if.end28
	movq	$0, -32(%rbp)
.LBB38_15:                              # %return
	movq	-32(%rbp), %rax
	addq	$64, %rsp
	popq	%rbp
	retq
.LBB38_16:                              # %lor.lhs.false15
	cmpq	$0, -56(%rbp)
	je	.LBB38_19
# BB#17:                                # %land.lhs.true17
	movl	-20(%rbp), %eax
	testl	%eax, %eax
	js	.LBB38_10
# BB#18:                                # %land.lhs.true17
	cmpl	$5001, %eax             # imm = 0x1389
	jge	.LBB38_10
.LBB38_19:                              # %if.end29
	movq	-64(%rbp), %rdi
	callq	ferror
	testl	%eax, %eax
	je	.LBB38_25
# BB#20:                                # %if.then30
	cmpq	$0, -16(%rbp)
	je	.LBB38_22
# BB#21:                                # %if.then32
	movq	-16(%rbp), %rax
	movl	$-6, (%rax)
.LBB38_22:                              # %if.end33
	cmpq	$0, -8(%rbp)
	je	.LBB38_14
# BB#23:                                # %if.then35
	movq	-8(%rbp), %rax
	movl	$-6, 5096(%rax)
	jmp	.LBB38_14
.LBB38_25:                              # %if.end38
	movl	$5104, %edi             # imm = 0x13F0
	callq	malloc
	movq	%rax, -8(%rbp)
	movq	-16(%rbp), %rcx
	testq	%rax, %rax
	je	.LBB38_38
# BB#26:                                # %if.end49
	testq	%rcx, %rcx
	je	.LBB38_28
# BB#27:                                # %if.then51
	movq	-16(%rbp), %rax
	movl	$0, (%rax)
.LBB38_28:                              # %if.end52
	cmpq	$0, -8(%rbp)
	je	.LBB38_30
# BB#29:                                # %if.then54
	movq	-8(%rbp), %rax
	movl	$0, 5096(%rax)
.LBB38_30:                              # %if.end56
	movq	-8(%rbp), %rax
	movb	$0, 5100(%rax)
	movq	-64(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	%rax, (%rcx)
	movq	-8(%rbp), %rax
	movl	$0, 5008(%rax)
	movq	-8(%rbp), %rax
	movb	$0, 5012(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 5072(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 5080(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 5088(%rax)
	cmpl	$0, -20(%rbp)
	jle	.LBB38_32
	.p2align	4, 0x90
.LBB38_31:                              # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	movq	-8(%rbp), %rcx
	movslq	5008(%rcx), %rdx
	movb	%al, 8(%rcx,%rdx)
	movq	-8(%rbp), %rax
	incl	5008(%rax)
	incq	-56(%rbp)
	decl	-20(%rbp)
	cmpl	$0, -20(%rbp)
	jg	.LBB38_31
.LBB38_32:                              # %while.end
	movl	$5016, %edi             # imm = 0x1398
	addq	-8(%rbp), %rdi
	movl	-44(%rbp), %esi
	movl	-40(%rbp), %edx
	callq	BZ2_bzDecompressInit
	movl	%eax, -36(%rbp)
	testl	%eax, %eax
	je	.LBB38_43
# BB#33:                                # %if.then65
	cmpq	$0, -16(%rbp)
	je	.LBB38_35
# BB#34:                                # %if.then67
	movl	-36(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	%eax, (%rcx)
.LBB38_35:                              # %if.end68
	cmpq	$0, -8(%rbp)
	je	.LBB38_37
# BB#36:                                # %if.then70
	movl	-36(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 5096(%rcx)
.LBB38_37:                              # %if.end72
	movq	-8(%rbp), %rdi
	callq	free
	jmp	.LBB38_14
.LBB38_38:                              # %if.then41
	testq	%rcx, %rcx
	je	.LBB38_40
# BB#39:                                # %if.then43
	movq	-16(%rbp), %rax
	movl	$-3, (%rax)
.LBB38_40:                              # %if.end44
	cmpq	$0, -8(%rbp)
	je	.LBB38_14
# BB#41:                                # %if.then46
	movq	-8(%rbp), %rax
	movl	$-3, 5096(%rax)
	jmp	.LBB38_14
.LBB38_43:                              # %if.end73
	movq	-8(%rbp), %rax
	movl	5008(%rax), %ecx
	movl	%ecx, 5024(%rax)
	movq	-8(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	%rcx, 5016(%rax)
	movq	-8(%rbp), %rax
	movb	$1, 5100(%rax)
	movq	-8(%rbp), %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB38_15
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
.Lcfi121:
	.cfi_def_cfa_offset 16
.Lcfi122:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi123:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rsi, -8(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB39_2
# BB#1:                                 # %if.then
	movq	-16(%rbp), %rax
	movl	$0, (%rax)
.LBB39_2:                               # %if.end
	cmpq	$0, -8(%rbp)
	je	.LBB39_4
# BB#3:                                 # %if.then2
	movq	-8(%rbp), %rax
	movl	$0, 5096(%rax)
.LBB39_4:                               # %if.end3
	cmpq	$0, -8(%rbp)
	je	.LBB39_5
# BB#9:                                 # %if.end13
	movq	-8(%rbp), %rax
	cmpb	$0, 5012(%rax)
	je	.LBB39_14
# BB#10:                                # %if.then14
	cmpq	$0, -16(%rbp)
	je	.LBB39_12
# BB#11:                                # %if.then16
	movq	-16(%rbp), %rax
	movl	$-1, (%rax)
.LBB39_12:                              # %if.end17
	cmpq	$0, -8(%rbp)
	je	.LBB39_17
# BB#13:                                # %if.then19
	movq	-8(%rbp), %rax
	movl	$-1, 5096(%rax)
	jmp	.LBB39_17
.LBB39_5:                               # %if.then5
	cmpq	$0, -16(%rbp)
	je	.LBB39_7
# BB#6:                                 # %if.then7
	movq	-16(%rbp), %rax
	movl	$0, (%rax)
.LBB39_7:                               # %if.end8
	cmpq	$0, -8(%rbp)
	je	.LBB39_17
# BB#8:                                 # %if.then10
	movq	-8(%rbp), %rax
	movl	$0, 5096(%rax)
	jmp	.LBB39_17
.LBB39_14:                              # %if.end22
	movq	-8(%rbp), %rax
	cmpb	$0, 5100(%rax)
	je	.LBB39_16
# BB#15:                                # %if.then24
	movq	-8(%rbp), %rdi
	addq	$5016, %rdi             # imm = 0x1398
	callq	BZ2_bzDecompressEnd
.LBB39_16:                              # %if.end25
	movq	-8(%rbp), %rdi
	callq	free
.LBB39_17:                              # %return
	addq	$32, %rsp
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
.Lcfi124:
	.cfi_def_cfa_offset 16
.Lcfi125:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi126:
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -40(%rbp)
	movl	%ecx, -24(%rbp)
	movq	-48(%rbp), %rax
	movq	%rax, -8(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB40_2
# BB#1:                                 # %if.then
	movq	-16(%rbp), %rax
	movl	$0, (%rax)
.LBB40_2:                               # %if.end
	cmpq	$0, -8(%rbp)
	je	.LBB40_4
# BB#3:                                 # %if.then2
	movq	-8(%rbp), %rax
	movl	$0, 5096(%rax)
.LBB40_4:                               # %if.end3
	cmpq	$0, -8(%rbp)
	je	.LBB40_7
# BB#5:                                 # %if.end3
	movq	-40(%rbp), %rax
	testq	%rax, %rax
	je	.LBB40_7
# BB#6:                                 # %if.end3
	movl	-24(%rbp), %eax
	testl	%eax, %eax
	js	.LBB40_7
# BB#12:                                # %if.end16
	movq	-8(%rbp), %rax
	cmpb	$0, 5012(%rax)
	je	.LBB40_17
# BB#13:                                # %if.then17
	cmpq	$0, -16(%rbp)
	je	.LBB40_15
# BB#14:                                # %if.then19
	movq	-16(%rbp), %rax
	movl	$-1, (%rax)
.LBB40_15:                              # %if.end20
	cmpq	$0, -8(%rbp)
	je	.LBB40_11
# BB#16:                                # %if.then22
	movq	-8(%rbp), %rax
	movl	$-1, 5096(%rax)
	jmp	.LBB40_11
.LBB40_7:                               # %if.then8
	cmpq	$0, -16(%rbp)
	je	.LBB40_9
# BB#8:                                 # %if.then10
	movq	-16(%rbp), %rax
	movl	$-2, (%rax)
.LBB40_9:                               # %if.end11
	cmpq	$0, -8(%rbp)
	je	.LBB40_11
# BB#10:                                # %if.then13
	movq	-8(%rbp), %rax
	movl	$-2, 5096(%rax)
.LBB40_11:                              # %if.end15
	movl	$0, -20(%rbp)
	xorl	%eax, %eax
.LBB40_59:                              # %if.end151
	addq	$48, %rsp
	popq	%rbp
	retq
.LBB40_17:                              # %if.end25
	cmpl	$0, -24(%rbp)
	je	.LBB40_18
# BB#22:                                # %if.end35
	movl	-24(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 5048(%rcx)
	movq	-40(%rbp), %rax
	movq	-8(%rbp), %rcx
	movq	%rax, 5040(%rcx)
	.p2align	4, 0x90
.LBB40_23:                              # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB40_24
# BB#28:                                # %if.end46
                                        #   in Loop: Header=BB40_23 Depth=1
	movq	-8(%rbp), %rax
	cmpl	$0, 5024(%rax)
	jne	.LBB40_32
# BB#29:                                # %land.lhs.true
                                        #   in Loop: Header=BB40_23 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rdi
	callq	myfeof
	testb	%al, %al
	jne	.LBB40_32
# BB#30:                                # %if.then52
                                        #   in Loop: Header=BB40_23 Depth=1
	movq	-8(%rbp), %rdi
	movq	(%rdi), %rcx
	addq	$8, %rdi
	movl	$1, %esi
	movl	$5000, %edx             # imm = 0x1388
	callq	fread
	movl	%eax, -32(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB40_24
# BB#31:                                # %if.end69
                                        #   in Loop: Header=BB40_23 Depth=1
	movl	-32(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 5008(%rcx)
	movq	-8(%rbp), %rax
	movl	5008(%rax), %ecx
	movl	%ecx, 5024(%rax)
	movq	-8(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	%rcx, 5016(%rax)
	.p2align	4, 0x90
.LBB40_32:                              # %if.end76
                                        #   in Loop: Header=BB40_23 Depth=1
	movq	-8(%rbp), %rdi
	addq	$5016, %rdi             # imm = 0x1398
	callq	BZ2_bzDecompress
	movl	%eax, -28(%rbp)
	testl	%eax, %eax
	je	.LBB40_38
# BB#33:                                # %if.end76
                                        #   in Loop: Header=BB40_23 Depth=1
	cmpl	$4, %eax
	jne	.LBB40_34
.LBB40_38:                              # %if.end94
                                        #   in Loop: Header=BB40_23 Depth=1
	cmpl	$0, -28(%rbp)
	je	.LBB40_39
.LBB40_46:                              # %if.end122
                                        #   in Loop: Header=BB40_23 Depth=1
	cmpl	$4, -28(%rbp)
	je	.LBB40_47
# BB#52:                                # %if.end137
                                        #   in Loop: Header=BB40_23 Depth=1
	movq	-8(%rbp), %rax
	cmpl	$0, 5048(%rax)
	jne	.LBB40_23
	jmp	.LBB40_53
	.p2align	4, 0x90
.LBB40_39:                              # %land.lhs.true97
                                        #   in Loop: Header=BB40_23 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rdi
	callq	myfeof
	testb	%al, %al
	je	.LBB40_46
# BB#40:                                # %land.lhs.true102
                                        #   in Loop: Header=BB40_23 Depth=1
	movq	-8(%rbp), %rax
	cmpl	$0, 5024(%rax)
	jne	.LBB40_46
# BB#41:                                # %land.lhs.true107
                                        #   in Loop: Header=BB40_23 Depth=1
	movq	-8(%rbp), %rax
	cmpl	$0, 5048(%rax)
	je	.LBB40_46
# BB#42:                                # %if.then112
	cmpq	$0, -16(%rbp)
	je	.LBB40_44
# BB#43:                                # %if.then115
	movq	-16(%rbp), %rax
	movl	$-7, (%rax)
.LBB40_44:                              # %if.end116
	cmpq	$0, -8(%rbp)
	je	.LBB40_11
# BB#45:                                # %if.then119
	movq	-8(%rbp), %rax
	movl	$-7, 5096(%rax)
	jmp	.LBB40_11
.LBB40_18:                              # %if.then27
	cmpq	$0, -16(%rbp)
	je	.LBB40_20
# BB#19:                                # %if.then29
	movq	-16(%rbp), %rax
	movl	$0, (%rax)
.LBB40_20:                              # %if.end30
	cmpq	$0, -8(%rbp)
	je	.LBB40_11
# BB#21:                                # %if.then32
	movq	-8(%rbp), %rax
	movl	$0, 5096(%rax)
	jmp	.LBB40_11
.LBB40_24:                              # %if.then38
	cmpq	$0, -16(%rbp)
	je	.LBB40_26
# BB#25:                                # %if.then40
	movq	-16(%rbp), %rax
	movl	$-6, (%rax)
.LBB40_26:                              # %if.end41
	cmpq	$0, -8(%rbp)
	je	.LBB40_11
# BB#27:                                # %if.then43
	movq	-8(%rbp), %rax
	movl	$-6, 5096(%rax)
	jmp	.LBB40_11
.LBB40_34:                              # %if.then84
	cmpq	$0, -16(%rbp)
	je	.LBB40_36
# BB#35:                                # %if.then87
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	%eax, (%rcx)
.LBB40_36:                              # %if.end88
	cmpq	$0, -8(%rbp)
	je	.LBB40_11
# BB#37:                                # %if.then91
	movl	-28(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 5096(%rcx)
	jmp	.LBB40_11
.LBB40_47:                              # %if.then125
	cmpq	$0, -16(%rbp)
	je	.LBB40_49
# BB#48:                                # %if.then128
	movq	-16(%rbp), %rax
	movl	$4, (%rax)
.LBB40_49:                              # %if.end129
	cmpq	$0, -8(%rbp)
	je	.LBB40_51
# BB#50:                                # %if.then132
	movq	-8(%rbp), %rax
	movl	$4, 5096(%rax)
.LBB40_51:                              # %if.end134
	movl	-24(%rbp), %eax
	movq	-8(%rbp), %rcx
	subl	5048(%rcx), %eax
	jmp	.LBB40_58
.LBB40_53:                              # %if.then142
	cmpq	$0, -16(%rbp)
	je	.LBB40_55
# BB#54:                                # %if.then145
	movq	-16(%rbp), %rax
	movl	$0, (%rax)
.LBB40_55:                              # %if.end146
	cmpq	$0, -8(%rbp)
	je	.LBB40_57
# BB#56:                                # %if.then149
	movq	-8(%rbp), %rax
	movl	$0, 5096(%rax)
.LBB40_57:                              # %if.end151
	movl	-24(%rbp), %eax
.LBB40_58:                              # %if.end151
	movl	%eax, -20(%rbp)
	jmp	.LBB40_59
.Lfunc_end40:
	.size	BZ2_bzRead, .Lfunc_end40-BZ2_bzRead
	.cfi_endproc

	.p2align	4, 0x90
	.type	myfeof,@function
myfeof:                                 # @myfeof
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi127:
	.cfi_def_cfa_offset 16
.Lcfi128:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi129:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -16(%rbp)
	callq	fgetc
	movl	%eax, -8(%rbp)
	cmpl	$-1, %eax
	je	.LBB41_1
# BB#3:                                 # %if.end
	movl	-8(%rbp), %edi
	movq	-16(%rbp), %rsi
	callq	ungetc
	movb	$0, -1(%rbp)
	xorl	%eax, %eax
	jmp	.LBB41_2
.LBB41_1:                               # %if.then
	movb	$1, -1(%rbp)
	movb	$1, %al
.LBB41_2:                               # %if.then
	addq	$16, %rsp
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
.Lcfi130:
	.cfi_def_cfa_offset 16
.Lcfi131:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi132:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -40(%rbp)
	movq	%rdx, -32(%rbp)
	movq	%rcx, -24(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
	testq	%rax, %rax
	je	.LBB42_1
# BB#5:                                 # %if.end6
	movq	-8(%rbp), %rax
	cmpl	$4, 5096(%rax)
	je	.LBB42_10
# BB#6:                                 # %if.then9
	cmpq	$0, -16(%rbp)
	je	.LBB42_8
# BB#7:                                 # %if.then11
	movq	-16(%rbp), %rax
	movl	$-1, (%rax)
.LBB42_8:                               # %if.end12
	cmpq	$0, -8(%rbp)
	je	.LBB42_18
# BB#9:                                 # %if.then14
	movq	-8(%rbp), %rax
	movl	$-1, 5096(%rax)
	popq	%rbp
	retq
.LBB42_1:                               # %if.then
	cmpq	$0, -16(%rbp)
	jne	.LBB42_2
	jmp	.LBB42_3
.LBB42_10:                              # %if.end17
	cmpq	$0, -32(%rbp)
	movq	-16(%rbp), %rax
	je	.LBB42_12
# BB#11:                                # %if.end17
	movq	-24(%rbp), %rcx
	testq	%rcx, %rcx
	je	.LBB42_12
# BB#13:                                # %if.end28
	testq	%rax, %rax
	je	.LBB42_15
# BB#14:                                # %if.then30
	movq	-16(%rbp), %rax
	movl	$0, (%rax)
.LBB42_15:                              # %if.end31
	cmpq	$0, -8(%rbp)
	je	.LBB42_17
# BB#16:                                # %if.then33
	movq	-8(%rbp), %rax
	movl	$0, 5096(%rax)
.LBB42_17:                              # %if.end35
	movq	-8(%rbp), %rax
	movl	5024(%rax), %eax
	movq	-24(%rbp), %rcx
	movl	%eax, (%rcx)
	movq	-8(%rbp), %rax
	movq	5016(%rax), %rax
	movq	-32(%rbp), %rcx
	movq	%rax, (%rcx)
	popq	%rbp
	retq
.LBB42_12:                              # %if.then20
	testq	%rax, %rax
	je	.LBB42_3
.LBB42_2:                               # %if.then2
	movq	-16(%rbp), %rax
	movl	$-2, (%rax)
.LBB42_3:                               # %if.end
	cmpq	$0, -8(%rbp)
	je	.LBB42_18
# BB#4:                                 # %if.then4
	movq	-8(%rbp), %rax
	movl	$-2, 5096(%rax)
	popq	%rbp
	retq
.LBB42_18:                              # %return
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
.Lcfi133:
	.cfi_def_cfa_offset 16
.Lcfi134:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi135:
	.cfi_def_cfa_register %rbp
	subq	$144, %rsp
	movl	16(%rbp), %eax
	movq	%rdi, -56(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -48(%rbp)
	movl	%ecx, -36(%rbp)
	movl	%r8d, -20(%rbp)
	movl	%r9d, -16(%rbp)
	movl	%eax, -8(%rbp)
	cmpq	$0, -56(%rbp)
	je	.LBB43_9
# BB#1:                                 # %entry
	movq	-32(%rbp), %rcx
	testq	%rcx, %rcx
	je	.LBB43_9
# BB#2:                                 # %entry
	movq	-48(%rbp), %rcx
	testq	%rcx, %rcx
	je	.LBB43_9
# BB#3:                                 # %entry
	movl	-20(%rbp), %ecx
	testl	%ecx, %ecx
	jle	.LBB43_9
# BB#4:                                 # %entry
	cmpl	$9, %ecx
	jg	.LBB43_9
# BB#5:                                 # %entry
	movl	-16(%rbp), %ecx
	testl	%ecx, %ecx
	js	.LBB43_9
# BB#6:                                 # %entry
	cmpl	$4, %ecx
	jg	.LBB43_9
# BB#7:                                 # %entry
	testl	%eax, %eax
	js	.LBB43_9
# BB#8:                                 # %entry
	cmpl	$251, %eax
	jge	.LBB43_9
# BB#11:                                # %if.end
	cmpl	$0, -8(%rbp)
	jne	.LBB43_13
# BB#12:                                # %if.then17
	movl	$30, -8(%rbp)
.LBB43_13:                              # %if.then17
	xorps	%xmm0, %xmm0
	movups	%xmm0, -80(%rbp)
	movq	$0, -64(%rbp)
	movl	-20(%rbp), %esi
	movl	-16(%rbp), %edx
	movl	-8(%rbp), %ecx
	leaq	-136(%rbp), %rdi
	callq	BZ2_bzCompressInit
	movl	%eax, -4(%rbp)
	testl	%eax, %eax
	je	.LBB43_15
.LBB43_14:                              # %if.then20
	movl	-4(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB43_10
.LBB43_9:                               # %if.then
	movl	$-2, -12(%rbp)
	movl	$-2, %eax
.LBB43_10:                              # %if.then
	addq	$144, %rsp
	popq	%rbp
	retq
.LBB43_15:                              # %if.end21
	movq	-48(%rbp), %rax
	movq	%rax, -136(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, -112(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -128(%rbp)
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -104(%rbp)
	leaq	-136(%rbp), %rdi
	movl	$2, %esi
	callq	BZ2_bzCompress
	movl	%eax, -4(%rbp)
	cmpl	$3, %eax
	jne	.LBB43_16
# BB#18:                                # %output_overflow
	leaq	-136(%rbp), %rdi
	callq	BZ2_bzCompressEnd
	movl	$-8, -12(%rbp)
	movl	$-8, %eax
	jmp	.LBB43_10
.LBB43_16:                              # %if.end25
	cmpl	$4, -4(%rbp)
	je	.LBB43_17
# BB#19:                                # %errhandler
	leaq	-136(%rbp), %rdi
	callq	BZ2_bzCompressEnd
	jmp	.LBB43_14
.LBB43_17:                              # %if.end28
	movl	-104(%rbp), %eax
	movq	-32(%rbp), %rcx
	subl	%eax, (%rcx)
	leaq	-136(%rbp), %rdi
	callq	BZ2_bzCompressEnd
	movl	$0, -12(%rbp)
	xorl	%eax, %eax
	jmp	.LBB43_10
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
.Lcfi136:
	.cfi_def_cfa_offset 16
.Lcfi137:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi138:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$136, %rsp
.Lcfi139:
	.cfi_offset %rbx, -24
	movq	%rdi, -56(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -48(%rbp)
	movl	%ecx, -36(%rbp)
	movl	%r8d, -24(%rbp)
	movl	%r9d, -20(%rbp)
	cmpq	$0, -56(%rbp)
	je	.LBB44_6
# BB#1:                                 # %entry
	movq	-32(%rbp), %rax
	testq	%rax, %rax
	je	.LBB44_6
# BB#2:                                 # %entry
	movq	-48(%rbp), %rax
	testq	%rax, %rax
	je	.LBB44_6
# BB#3:                                 # %lor.lhs.false4
	movl	-24(%rbp), %eax
	testl	%eax, %eax
	setne	%cl
	cmpl	$1, %eax
	setne	%al
	testb	%al, %cl
	jne	.LBB44_6
# BB#4:                                 # %lor.lhs.false4
	movl	-20(%rbp), %eax
	testl	%eax, %eax
	js	.LBB44_6
# BB#5:                                 # %lor.lhs.false4
	cmpl	$5, %eax
	jge	.LBB44_6
# BB#8:                                 # %if.end
	xorps	%xmm0, %xmm0
	movups	%xmm0, -80(%rbp)
	movq	$0, -64(%rbp)
	movl	-20(%rbp), %esi
	movl	-24(%rbp), %edx
	leaq	-136(%rbp), %rdi
	callq	BZ2_bzDecompressInit
	movl	%eax, -16(%rbp)
	testl	%eax, %eax
	je	.LBB44_10
.LBB44_9:                               # %if.then12
	movl	-16(%rbp), %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB44_7
.LBB44_6:                               # %if.then
	movl	$-2, -12(%rbp)
	movl	$-2, %eax
.LBB44_7:                               # %if.then
	addq	$136, %rsp
	popq	%rbx
	popq	%rbp
	retq
.LBB44_10:                              # %if.end13
	movq	-48(%rbp), %rax
	movq	%rax, -136(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, -112(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -128(%rbp)
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -104(%rbp)
	leaq	-136(%rbp), %rdi
	callq	BZ2_bzDecompress
	movl	%eax, -16(%rbp)
	testl	%eax, %eax
	je	.LBB44_13
# BB#11:                                # %if.end17
	cmpl	$4, -16(%rbp)
	je	.LBB44_12
# BB#16:                                # %errhandler
	leaq	-136(%rbp), %rdi
	callq	BZ2_bzDecompressEnd
	jmp	.LBB44_9
.LBB44_13:                              # %output_overflow_or_eof
	movl	-104(%rbp), %ebx
	leaq	-136(%rbp), %rdi
	callq	BZ2_bzDecompressEnd
	cmpl	$0, %ebx
	je	.LBB44_15
# BB#14:                                # %if.then25
	movl	$-7, -12(%rbp)
	movl	$-7, %eax
	jmp	.LBB44_7
.LBB44_12:                              # %if.end20
	movl	-104(%rbp), %eax
	movq	-32(%rbp), %rcx
	subl	%eax, (%rcx)
	leaq	-136(%rbp), %rdi
	callq	BZ2_bzDecompressEnd
	movl	$0, -12(%rbp)
	xorl	%eax, %eax
	jmp	.LBB44_7
.LBB44_15:                              # %if.else
	movl	$-8, -12(%rbp)
	movl	$-8, %eax
	jmp	.LBB44_7
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
.Lcfi140:
	.cfi_def_cfa_offset 16
.Lcfi141:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi142:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rsi, %rax
	movq	%rdi, -8(%rbp)
	movq	%rax, -16(%rbp)
	movq	-8(%rbp), %rdi
	movl	$-1, %esi
	xorl	%ecx, %ecx
	movq	%rax, %rdx
	callq	bzopen_or_bzdopen
	addq	$16, %rsp
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
.Lcfi143:
	.cfi_def_cfa_offset 16
.Lcfi144:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi145:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$5128, %rsp             # imm = 0x1408
.Lcfi146:
	.cfi_offset %rbx, -24
	movq	%rdi, -96(%rbp)
	movl	%esi, -108(%rbp)
	movq	%rdx, -40(%rbp)
	movl	%ecx, -104(%rbp)
	movl	$9, -12(%rbp)
	movl	$0, -16(%rbp)
	movw	$0, -80(%rbp)
	movq	$0, -88(%rbp)
	movq	$0, -24(%rbp)
	movq	$0, -48(%rbp)
	movl	$0, -28(%rbp)
	movl	$30, -56(%rbp)
	movl	$0, -52(%rbp)
	movl	$0, -100(%rbp)
	cmpq	$0, -40(%rbp)
	jne	.LBB46_3
	jmp	.LBB46_36
	.p2align	4, 0x90
.LBB46_2:                               # %sw.epilog
                                        #   in Loop: Header=BB46_3 Depth=1
	incq	-40(%rbp)
.LBB46_3:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	-40(%rbp), %rax
	cmpb	$0, (%rax)
	je	.LBB46_12
# BB#4:                                 # %while.body
                                        #   in Loop: Header=BB46_3 Depth=1
	movq	-40(%rbp), %rax
	movsbl	(%rax), %eax
	cmpl	$119, %eax
	je	.LBB46_8
# BB#5:                                 # %while.body
                                        #   in Loop: Header=BB46_3 Depth=1
	cmpl	$115, %eax
	je	.LBB46_9
# BB#6:                                 # %while.body
                                        #   in Loop: Header=BB46_3 Depth=1
	cmpl	$114, %eax
	jne	.LBB46_10
# BB#7:                                 # %sw.bb
                                        #   in Loop: Header=BB46_3 Depth=1
	movl	$0, -16(%rbp)
	incq	-40(%rbp)
	jmp	.LBB46_3
	.p2align	4, 0x90
.LBB46_8:                               # %sw.bb1
                                        #   in Loop: Header=BB46_3 Depth=1
	movl	$1, -16(%rbp)
	incq	-40(%rbp)
	jmp	.LBB46_3
	.p2align	4, 0x90
.LBB46_9:                               # %sw.bb2
                                        #   in Loop: Header=BB46_3 Depth=1
	movl	$1, -52(%rbp)
	incq	-40(%rbp)
	jmp	.LBB46_3
	.p2align	4, 0x90
.LBB46_10:                              # %sw.default
                                        #   in Loop: Header=BB46_3 Depth=1
	callq	__ctype_b_loc
	movq	(%rax), %rax
	movq	-40(%rbp), %rcx
	movsbq	(%rcx), %rcx
	movzwl	(%rax,%rcx,2), %eax
	testb	$8, %ah
	je	.LBB46_2
# BB#11:                                # %if.then6
                                        #   in Loop: Header=BB46_3 Depth=1
	movq	-40(%rbp), %rax
	movsbl	(%rax), %eax
	addl	$-48, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB46_2
.LBB46_12:                              # %while.end
	cmpl	$0, -16(%rbp)
	movl	$.L.str.64, %eax
	movl	$.L.str.65, %esi
	cmovneq	%rax, %rsi
	leaq	-88(%rbp), %rbx
	movq	%rbx, %rdi
	callq	strcat
	movl	$.L.str.66, %esi
	movq	%rbx, %rdi
	callq	strcat
	cmpl	$0, -104(%rbp)
	je	.LBB46_14
# BB#13:                                # %if.else27
	movl	-108(%rbp), %edi
	leaq	-88(%rbp), %rsi
	callq	fdopen
	jmp	.LBB46_21
.LBB46_14:                              # %if.then15
	cmpq	$0, -96(%rbp)
	je	.LBB46_17
# BB#15:                                # %lor.lhs.false
	movq	-96(%rbp), %rdi
	movl	$.L.str.16, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB46_17
# BB#16:                                # %if.else
	movq	-96(%rbp), %rdi
	leaq	-88(%rbp), %rsi
	callq	fopen
	jmp	.LBB46_21
.LBB46_17:                              # %if.then21
	cmpl	$0, -16(%rbp)
	je	.LBB46_19
# BB#18:                                # %cond.true
	movq	stdout(%rip), %rax
	movq	%rax, -128(%rbp)
	jmp	.LBB46_20
.LBB46_19:                              # %cond.false
	movq	stdin(%rip), %rax
	movq	%rax, -136(%rbp)
.LBB46_20:                              # %cond.end
	movq	%rax, -120(%rbp)
	movq	-120(%rbp), %rax
.LBB46_21:                              # %if.end30
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.LBB46_36
# BB#22:                                # %if.end34
	cmpl	$0, -16(%rbp)
	je	.LBB46_26
# BB#23:                                # %if.then36
	cmpl	$0, -12(%rbp)
	jle	.LBB46_27
# BB#24:                                # %if.end403
	cmpl	$9, -12(%rbp)
	jg	.LBB46_28
	jmp	.LBB46_29
.LBB46_26:                              # %if.else46
	movq	-24(%rbp), %rsi
	movl	-28(%rbp), %edx
	movl	-52(%rbp), %ecx
	movl	-100(%rbp), %r9d
	leaq	-60(%rbp), %rdi
	leaq	-5136(%rbp), %r8
	callq	BZ2_bzReadOpen
	jmp	.LBB46_31
.LBB46_27:                              # %if.then39
	movl	$1, -12(%rbp)
	movb	$1, %al
	testb	%al, %al
	jne	.LBB46_29
.LBB46_28:                              # %if.then43
	movl	$9, -12(%rbp)
	movq	-24(%rbp), %rsi
	movl	-28(%rbp), %ecx
	movl	-56(%rbp), %r8d
	leaq	-60(%rbp), %rdi
	movl	$9, %edx
	jmp	.LBB46_30
.LBB46_29:                              # %if.end447
	movq	-24(%rbp), %rsi
	movl	-12(%rbp), %edx
	movl	-28(%rbp), %ecx
	movl	-56(%rbp), %r8d
	leaq	-60(%rbp), %rdi
.LBB46_30:                              # %if.end49
	callq	BZ2_bzWriteOpen
.LBB46_31:                              # %if.end49
	movq	%rax, -48(%rbp)
	cmpq	$0, -48(%rbp)
	je	.LBB46_33
# BB#32:                                # %if.end60
	movq	-48(%rbp), %rax
	movq	%rax, -72(%rbp)
	jmp	.LBB46_37
.LBB46_33:                              # %if.then52
	movq	-24(%rbp), %rax
	cmpq	stdin(%rip), %rax
	je	.LBB46_36
# BB#34:                                # %land.lhs.true
	movq	-24(%rbp), %rax
	cmpq	stdout(%rip), %rax
	je	.LBB46_36
# BB#35:                                # %if.then57
	movq	-24(%rbp), %rdi
	callq	fclose
.LBB46_36:                              # %if.end59
	movq	$0, -72(%rbp)
.LBB46_37:                              # %return
	movq	-72(%rbp), %rax
	addq	$5128, %rsp             # imm = 0x1408
	popq	%rbx
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
.Lcfi147:
	.cfi_def_cfa_offset 16
.Lcfi148:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi149:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rsi, %rax
	movl	%edi, -4(%rbp)
	movq	%rax, -16(%rbp)
	movl	-4(%rbp), %esi
	xorl	%edi, %edi
	movl	$1, %ecx
	movq	%rax, %rdx
	callq	bzopen_or_bzdopen
	addq	$16, %rsp
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
	pushq	%rbp
.Lcfi150:
	.cfi_def_cfa_offset 16
.Lcfi151:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi152:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movl	%edx, -16(%rbp)
	movq	-24(%rbp), %rax
	cmpl	$4, 5096(%rax)
	jne	.LBB48_3
# BB#1:                                 # %if.then
	movl	$0, -4(%rbp)
	xorl	%eax, %eax
	jmp	.LBB48_2
.LBB48_3:                               # %if.end
	movq	-24(%rbp), %rsi
	movq	-32(%rbp), %rdx
	movl	-16(%rbp), %ecx
	leaq	-12(%rbp), %rdi
	callq	BZ2_bzRead
	movl	%eax, -8(%rbp)
	movl	-12(%rbp), %eax
	testl	%eax, %eax
	je	.LBB48_5
# BB#4:                                 # %if.end
	cmpl	$4, %eax
	je	.LBB48_5
# BB#6:                                 # %if.else
	movl	$-1, -4(%rbp)
	movl	$-1, %eax
	jmp	.LBB48_2
.LBB48_5:                               # %if.then3
	movl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
.LBB48_2:                               # %if.then
	addq	$32, %rsp
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
.Lcfi153:
	.cfi_def_cfa_offset 16
.Lcfi154:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi155:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	%edx, %eax
	movq	%rdi, -32(%rbp)
	movq	%rsi, -24(%rbp)
	movl	%eax, -8(%rbp)
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rdx
	leaq	-4(%rbp), %rdi
	movl	%eax, %ecx
	callq	BZ2_bzWrite
	cmpl	$0, -4(%rbp)
	je	.LBB49_1
# BB#2:                                 # %if.else
	movl	$-1, -12(%rbp)
	movl	$-1, %eax
	jmp	.LBB49_3
.LBB49_1:                               # %if.then
	movl	-8(%rbp), %eax
	movl	%eax, -12(%rbp)
.LBB49_3:                               # %if.else
	addq	$32, %rsp
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
.Lcfi156:
	.cfi_def_cfa_offset 16
.Lcfi157:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi158:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
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
.Lcfi159:
	.cfi_def_cfa_offset 16
.Lcfi160:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi161:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	(%rdi), %rax
	movq	%rax, -16(%rbp)
	cmpq	$0, -24(%rbp)
	je	.LBB51_8
# BB#1:                                 # %if.end
	movq	-24(%rbp), %rsi
	cmpb	$0, 5012(%rsi)
	je	.LBB51_4
# BB#2:                                 # %if.then1
	leaq	-4(%rbp), %rdi
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	BZ2_bzWriteClose
	cmpl	$0, -4(%rbp)
	je	.LBB51_5
# BB#3:                                 # %if.then3
	movq	-24(%rbp), %rsi
	xorl	%edi, %edi
	movl	$1, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	BZ2_bzWriteClose
	jmp	.LBB51_5
.LBB51_4:                               # %if.else
	leaq	-4(%rbp), %rdi
	callq	BZ2_bzReadClose
.LBB51_5:                               # %if.end5
	movq	-16(%rbp), %rax
	cmpq	stdin(%rip), %rax
	je	.LBB51_8
# BB#6:                                 # %land.lhs.true
	movq	-16(%rbp), %rax
	cmpq	stdout(%rip), %rax
	je	.LBB51_8
# BB#7:                                 # %if.then8
	movq	-16(%rbp), %rdi
	callq	fclose
.LBB51_8:                               # %if.end9
	addq	$32, %rsp
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
.Lcfi162:
	.cfi_def_cfa_offset 16
.Lcfi163:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi164:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-24(%rbp), %rax
	movl	5096(%rax), %eax
	movl	%eax, -4(%rbp)
	testl	%eax, %eax
	jle	.LBB52_2
# BB#1:                                 # %if.then
	movl	$0, -4(%rbp)
	movq	-16(%rbp), %rax
	movl	$0, (%rax)
	movq	bzerrorstrings(%rip), %rax
	popq	%rbp
	retq
.LBB52_2:                               # %if.end1
	movl	-4(%rbp), %eax
	movq	-16(%rbp), %rcx
	movl	%eax, (%rcx)
	movslq	-4(%rbp), %rax
	movl	$bzerrorstrings, %ecx
	shlq	$3, %rax
	subq	%rax, %rcx
	movq	(%rcx), %rax
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
.Lcfi165:
	.cfi_def_cfa_offset 16
.Lcfi166:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi167:
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-40(%rbp), %rdi
	movl	$193, %esi
	movl	$384, %edx              # imm = 0x180
	xorl	%eax, %eax
	callq	open
	movl	%eax, -4(%rbp)
	cmpl	$-1, %eax
	je	.LBB53_1
# BB#2:                                 # %if.end
	movl	-4(%rbp), %edi
	movq	-32(%rbp), %rsi
	callq	fdopen
	movq	%rax, -24(%rbp)
	testq	%rax, %rax
	jne	.LBB53_4
# BB#3:                                 # %if.then3
	movl	-4(%rbp), %edi
	callq	close
.LBB53_4:                               # %if.end5
	movq	-24(%rbp), %rax
	movq	%rax, -16(%rbp)
	jmp	.LBB53_5
.LBB53_1:                               # %if.then
	movq	$0, -16(%rbp)
.LBB53_5:                               # %return
	movq	-16(%rbp), %rax
	addq	$48, %rsp
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
.Lcfi168:
	.cfi_def_cfa_offset 16
.Lcfi169:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi170:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$88, %rsp
.Lcfi171:
	.cfi_offset %rbx, -24
	movl	$0, -84(%rbp)
	movl	%edi, -60(%rbp)
	movq	%rsi, -72(%rbp)
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
	movl	$0, -28(%rbp)
	movl	$0, -44(%rbp)
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
	movq	-72(%rbp), %rax
	movq	(%rax), %rsi
	movl	$progNameReally, %edi
	callq	copyFileName
	movq	$progNameReally, progName(%rip)
	movq	$progNameReally, -56(%rbp)
	jmp	.LBB54_2
	.p2align	4, 0x90
.LBB54_1:                               # %for.inc
                                        #   in Loop: Header=BB54_2 Depth=1
	incq	-56(%rbp)
.LBB54_2:                               # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	-56(%rbp), %rax
	cmpb	$0, (%rax)
	je	.LBB54_5
# BB#3:                                 # %for.body
                                        #   in Loop: Header=BB54_2 Depth=1
	movq	-56(%rbp), %rax
	cmpb	$47, (%rax)
	jne	.LBB54_1
# BB#4:                                 # %if.then
                                        #   in Loop: Header=BB54_2 Depth=1
	movq	-56(%rbp), %rax
	incq	%rax
	movq	%rax, progName(%rip)
	jmp	.LBB54_1
.LBB54_5:                               # %for.end
	movq	$0, -40(%rbp)
	leaq	-40(%rbp), %rbx
	movl	$.L.str.19, %esi
	movq	%rbx, %rdi
	callq	addFlagsFromEnvVar
	movl	$.L.str.20, %esi
	movq	%rbx, %rdi
	callq	addFlagsFromEnvVar
	movl	$1, -44(%rbp)
	jmp	.LBB54_7
	.p2align	4, 0x90
.LBB54_6:                               # %for.body125
                                        #   in Loop: Header=BB54_7 Depth=1
	movq	-40(%rbp), %rdi
	movq	-72(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movq	(%rax,%rcx,8), %rsi
	callq	snocString
	movq	%rax, -40(%rbp)
	incl	-44(%rbp)
.LBB54_7:                               # %for.cond92
                                        # =>This Inner Loop Header: Depth=1
	movl	-60(%rbp), %eax
	decl	%eax
	cmpl	%eax, -44(%rbp)
	jle	.LBB54_6
# BB#8:                                 # %for.end16
	movl	$7, longestFileName(%rip)
	movl	$0, numFileNames(%rip)
	movb	$1, -9(%rbp)
	movq	-40(%rbp), %rax
	jmp	.LBB54_10
	.p2align	4, 0x90
.LBB54_9:                               # %for.inc45
                                        #   in Loop: Header=BB54_10 Depth=1
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
.LBB54_10:                              # %for.cond17
                                        # =>This Inner Loop Header: Depth=1
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.LBB54_17
# BB#11:                                # %for.body20
                                        #   in Loop: Header=BB54_10 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.21, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_16
# BB#12:                                # %if.end25
                                        #   in Loop: Header=BB54_10 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	cmpb	$45, (%rax)
	jne	.LBB54_14
# BB#13:                                # %land.lhs.true
                                        #   in Loop: Header=BB54_10 Depth=1
	cmpb	$0, -9(%rbp)
	jne	.LBB54_9
.LBB54_14:                              # %if.end33
                                        #   in Loop: Header=BB54_10 Depth=1
	incl	numFileNames(%rip)
	movl	longestFileName(%rip), %ebx
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	callq	strlen
	cmpl	%eax, %ebx
	jge	.LBB54_9
# BB#15:                                # %if.then40
                                        #   in Loop: Header=BB54_10 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	callq	strlen
	movl	%eax, longestFileName(%rip)
	jmp	.LBB54_9
	.p2align	4, 0x90
.LBB54_16:                              # %if.then24
                                        #   in Loop: Header=BB54_10 Depth=1
	movb	$0, -9(%rbp)
	jmp	.LBB54_9
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
	movq	-40(%rbp), %rax
	jmp	.LBB54_27
	.p2align	4, 0x90
.LBB54_26:                              # %for.inc138
                                        #   in Loop: Header=BB54_27 Depth=1
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
.LBB54_27:                              # %for.cond78
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB54_33 Depth 2
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.LBB54_54
# BB#28:                                # %for.body81
                                        #   in Loop: Header=BB54_27 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.21, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_54
# BB#29:                                # %if.end87
                                        #   in Loop: Header=BB54_27 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	cmpb	$45, (%rax)
	jne	.LBB54_26
# BB#30:                                # %land.lhs.true93
                                        #   in Loop: Header=BB54_27 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	cmpb	$45, 1(%rax)
	je	.LBB54_26
# BB#31:                                # %if.then99
                                        #   in Loop: Header=BB54_27 Depth=1
	movl	$1, -28(%rbp)
	jmp	.LBB54_33
.LBB54_32:                              # %sw.bb128
                                        #   in Loop: Header=BB54_33 Depth=2
	callq	license
	incl	-28(%rbp)
	.p2align	4, 0x90
.LBB54_33:                              # %for.cond100
                                        #   Parent Loop BB54_27 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movslq	-28(%rbp), %rcx
	cmpb	$0, (%rax,%rcx)
	je	.LBB54_26
# BB#34:                                # %for.body107
                                        #   in Loop: Header=BB54_33 Depth=2
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movslq	-28(%rbp), %rcx
	movsbl	(%rax,%rcx), %eax
	addl	$-49, %eax
	cmpl	$73, %eax
	ja	.LBB54_149
# BB#35:                                # %for.body107
                                        #   in Loop: Header=BB54_33 Depth=2
	jmpq	*.LJTI54_0(,%rax,8)
.LBB54_36:                              # %sw.bb119
                                        #   in Loop: Header=BB54_33 Depth=2
	movl	$1, blockSize100k(%rip)
	incl	-28(%rbp)
	jmp	.LBB54_33
.LBB54_37:                              # %sw.bb123
                                        #   in Loop: Header=BB54_33 Depth=2
	movl	$5, blockSize100k(%rip)
	incl	-28(%rbp)
	jmp	.LBB54_33
.LBB54_38:                              # %sw.bb114
                                        #   in Loop: Header=BB54_33 Depth=2
	movb	$1, forceOverwrite(%rip)
	incl	-28(%rbp)
	jmp	.LBB54_33
.LBB54_39:                              # %sw.bb113
                                        #   in Loop: Header=BB54_33 Depth=2
	movl	$1, opMode(%rip)
	incl	-28(%rbp)
	jmp	.LBB54_33
.LBB54_40:                              # %sw.bb120
                                        #   in Loop: Header=BB54_33 Depth=2
	movl	$2, blockSize100k(%rip)
	incl	-28(%rbp)
	jmp	.LBB54_33
.LBB54_41:                              # %sw.bb121
                                        #   in Loop: Header=BB54_33 Depth=2
	movl	$3, blockSize100k(%rip)
	incl	-28(%rbp)
	jmp	.LBB54_33
.LBB54_42:                              # %sw.bb122
                                        #   in Loop: Header=BB54_33 Depth=2
	movl	$4, blockSize100k(%rip)
	incl	-28(%rbp)
	jmp	.LBB54_33
.LBB54_43:                              # %sw.bb124
                                        #   in Loop: Header=BB54_33 Depth=2
	movl	$6, blockSize100k(%rip)
	incl	-28(%rbp)
	jmp	.LBB54_33
.LBB54_44:                              # %sw.bb125
                                        #   in Loop: Header=BB54_33 Depth=2
	movl	$7, blockSize100k(%rip)
	incl	-28(%rbp)
	jmp	.LBB54_33
.LBB54_45:                              # %sw.bb126
                                        #   in Loop: Header=BB54_33 Depth=2
	movl	$8, blockSize100k(%rip)
	incl	-28(%rbp)
	jmp	.LBB54_33
.LBB54_46:                              # %sw.bb127
                                        #   in Loop: Header=BB54_33 Depth=2
	movl	$9, blockSize100k(%rip)
	incl	-28(%rbp)
	jmp	.LBB54_33
.LBB54_47:                              # %sw.bb112
                                        #   in Loop: Header=BB54_33 Depth=2
	movl	$2, opMode(%rip)
	incl	-28(%rbp)
	jmp	.LBB54_33
.LBB54_48:                              # %sw.bb116
                                        #   in Loop: Header=BB54_33 Depth=2
	movb	$1, keepInputFiles(%rip)
	incl	-28(%rbp)
	jmp	.LBB54_33
.LBB54_49:                              # %sw.bb118
                                        #   in Loop: Header=BB54_33 Depth=2
	movb	$0, noisy(%rip)
	incl	-28(%rbp)
	jmp	.LBB54_33
.LBB54_50:                              # %sw.bb129
                                        #   in Loop: Header=BB54_33 Depth=2
	incl	verbosity(%rip)
	incl	-28(%rbp)
	jmp	.LBB54_33
.LBB54_51:                              # %sw.bb
                                        #   in Loop: Header=BB54_33 Depth=2
	movl	$2, srcMode(%rip)
	incl	-28(%rbp)
	jmp	.LBB54_33
.LBB54_52:                              # %sw.bb117
                                        #   in Loop: Header=BB54_33 Depth=2
	movb	$1, smallMode(%rip)
	incl	-28(%rbp)
	jmp	.LBB54_33
.LBB54_53:                              # %sw.bb115
                                        #   in Loop: Header=BB54_33 Depth=2
	movl	$3, opMode(%rip)
	incl	-28(%rbp)
	jmp	.LBB54_33
.LBB54_54:                              # %for.end140
	movq	-40(%rbp), %rax
	jmp	.LBB54_56
	.p2align	4, 0x90
.LBB54_55:                              # %for.inc281
                                        #   in Loop: Header=BB54_56 Depth=1
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
.LBB54_56:                              # %for.cond141
                                        # =>This Inner Loop Header: Depth=1
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.LBB54_92
# BB#57:                                # %for.body144
                                        #   in Loop: Header=BB54_56 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.21, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_92
# BB#58:                                # %if.end150
                                        #   in Loop: Header=BB54_56 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.29, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_76
# BB#59:                                # %if.else156
                                        #   in Loop: Header=BB54_56 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.30, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_77
# BB#60:                                # %if.else162
                                        #   in Loop: Header=BB54_56 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.31, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_78
# BB#61:                                # %if.else168
                                        #   in Loop: Header=BB54_56 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.32, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_79
# BB#62:                                # %if.else174
                                        #   in Loop: Header=BB54_56 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.33, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_80
# BB#63:                                # %if.else180
                                        #   in Loop: Header=BB54_56 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.34, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_81
# BB#64:                                # %if.else186
                                        #   in Loop: Header=BB54_56 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.35, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_82
# BB#65:                                # %if.else192
                                        #   in Loop: Header=BB54_56 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.36, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_83
# BB#66:                                # %if.else198
                                        #   in Loop: Header=BB54_56 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.37, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_85
# BB#67:                                # %if.else204
                                        #   in Loop: Header=BB54_56 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.38, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_85
# BB#68:                                # %if.else210
                                        #   in Loop: Header=BB54_56 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.39, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_86
# BB#69:                                # %if.else216
                                        #   in Loop: Header=BB54_56 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.40, %esi
	callq	strcmp
	movq	-24(%rbp), %rcx
	movq	(%rcx), %rdi
	testl	%eax, %eax
	je	.LBB54_88
# BB#70:                                # %if.else223
                                        #   in Loop: Header=BB54_56 Depth=1
	movl	$.L.str.41, %esi
	callq	strcmp
	movq	-24(%rbp), %rcx
	movq	(%rcx), %rdi
	testl	%eax, %eax
	je	.LBB54_88
# BB#71:                                # %if.else230
                                        #   in Loop: Header=BB54_56 Depth=1
	movl	$.L.str.42, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_89
# BB#72:                                # %if.else236
                                        #   in Loop: Header=BB54_56 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.43, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_90
# BB#73:                                # %if.else242
                                        #   in Loop: Header=BB54_56 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.44, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_91
# BB#74:                                # %if.else249
                                        #   in Loop: Header=BB54_56 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.45, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_148
# BB#75:                                # %if.else255
                                        #   in Loop: Header=BB54_56 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.21, %esi
	movl	$2, %edx
	callq	strncmp
	testl	%eax, %eax
	jne	.LBB54_55
	jmp	.LBB54_149
	.p2align	4, 0x90
.LBB54_76:                              # %if.then155
                                        #   in Loop: Header=BB54_56 Depth=1
	movl	$2, srcMode(%rip)
	jmp	.LBB54_55
	.p2align	4, 0x90
.LBB54_77:                              # %if.then161
                                        #   in Loop: Header=BB54_56 Depth=1
	movl	$2, opMode(%rip)
	jmp	.LBB54_55
.LBB54_78:                              # %if.then167
                                        #   in Loop: Header=BB54_56 Depth=1
	movl	$1, opMode(%rip)
	jmp	.LBB54_55
.LBB54_79:                              # %if.then173
                                        #   in Loop: Header=BB54_56 Depth=1
	movb	$1, forceOverwrite(%rip)
	jmp	.LBB54_55
.LBB54_80:                              # %if.then179
                                        #   in Loop: Header=BB54_56 Depth=1
	movl	$3, opMode(%rip)
	jmp	.LBB54_55
.LBB54_81:                              # %if.then185
                                        #   in Loop: Header=BB54_56 Depth=1
	movb	$1, keepInputFiles(%rip)
	jmp	.LBB54_55
.LBB54_82:                              # %if.then191
                                        #   in Loop: Header=BB54_56 Depth=1
	movb	$1, smallMode(%rip)
	jmp	.LBB54_55
.LBB54_85:                              # %if.then209
                                        #   in Loop: Header=BB54_56 Depth=1
	callq	license
	jmp	.LBB54_55
.LBB54_83:                              # %if.then197
                                        #   in Loop: Header=BB54_56 Depth=1
	movb	$0, noisy(%rip)
	jmp	.LBB54_55
.LBB54_88:                              # %if.then228
                                        #   in Loop: Header=BB54_56 Depth=1
	callq	redundant
	jmp	.LBB54_55
.LBB54_86:                              # %if.then215
                                        #   in Loop: Header=BB54_56 Depth=1
	movl	$1, workFactor(%rip)
	jmp	.LBB54_55
.LBB54_89:                              # %if.then235
                                        #   in Loop: Header=BB54_56 Depth=1
	movl	$1, blockSize100k(%rip)
	jmp	.LBB54_55
.LBB54_90:                              # %if.then241
                                        #   in Loop: Header=BB54_56 Depth=1
	movl	$9, blockSize100k(%rip)
	jmp	.LBB54_55
.LBB54_91:                              # %if.then247
                                        #   in Loop: Header=BB54_56 Depth=1
	incl	verbosity(%rip)
	jmp	.LBB54_55
.LBB54_92:                              # %for.end283
	cmpl	$5, verbosity(%rip)
	jl	.LBB54_94
# BB#93:                                # %if.then286
	movl	$4, verbosity(%rip)
.LBB54_94:                              # %if.end287
	cmpl	$1, opMode(%rip)
	jne	.LBB54_98
# BB#95:                                # %land.lhs.true290
	cmpb	$0, smallMode(%rip)
	je	.LBB54_98
# BB#96:                                # %land.lhs.true290
	cmpl	$3, blockSize100k(%rip)
	jl	.LBB54_98
# BB#97:                                # %if.then296
	movl	$2, blockSize100k(%rip)
.LBB54_98:                              # %if.end297
	cmpl	$3, opMode(%rip)
	jne	.LBB54_100
# BB#99:                                # %if.end297
	cmpl	$2, srcMode(%rip)
	je	.LBB54_150
.LBB54_100:                             # %if.end305
	cmpl	$2, srcMode(%rip)
	jne	.LBB54_103
# BB#101:                               # %if.end305
	movl	numFileNames(%rip), %eax
	testl	%eax, %eax
	jne	.LBB54_103
# BB#102:                               # %if.then311
	movl	$1, srcMode(%rip)
.LBB54_103:                             # %if.end312
	cmpl	$1, opMode(%rip)
	je	.LBB54_105
# BB#104:                               # %if.then315
	movl	$0, blockSize100k(%rip)
.LBB54_105:                             # %if.end316
	cmpl	$3, srcMode(%rip)
	jne	.LBB54_107
# BB#106:                               # %if.then319
	movl	$2, %edi
	movl	$mySignalCatcher, %esi
	callq	signal
	movl	$15, %edi
	movl	$mySignalCatcher, %esi
	callq	signal
	movl	$1, %edi
	movl	$mySignalCatcher, %esi
	callq	signal
.LBB54_107:                             # %if.end323
	cmpl	$1, opMode(%rip)
	jne	.LBB54_110
# BB#108:                               # %if.then326
	cmpl	$1, srcMode(%rip)
	jne	.LBB54_113
# BB#109:                               # %if.then329
	xorl	%edi, %edi
	callq	compress
	jmp	.LBB54_142
.LBB54_110:                             # %if.else357
	cmpl	$2, opMode(%rip)
	jne	.LBB54_121
# BB#111:                               # %if.then360
	movb	$0, unzFailsExist(%rip)
	cmpl	$1, srcMode(%rip)
	jne	.LBB54_123
# BB#112:                               # %if.then363
	xorl	%edi, %edi
	callq	uncompress
	jmp	.LBB54_131
.LBB54_113:                             # %if.else330
	movb	$1, -9(%rbp)
	movq	-40(%rbp), %rax
	jmp	.LBB54_115
	.p2align	4, 0x90
.LBB54_114:                             # %for.inc353
                                        #   in Loop: Header=BB54_115 Depth=1
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
.LBB54_115:                             # %for.cond331
                                        # =>This Inner Loop Header: Depth=1
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.LBB54_142
# BB#116:                               # %for.body334
                                        #   in Loop: Header=BB54_115 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.21, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_120
# BB#117:                               # %if.end340
                                        #   in Loop: Header=BB54_115 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	cmpb	$45, (%rax)
	jne	.LBB54_119
# BB#118:                               # %land.lhs.true346
                                        #   in Loop: Header=BB54_115 Depth=1
	cmpb	$0, -9(%rbp)
	jne	.LBB54_114
.LBB54_119:                             # %if.end350
                                        #   in Loop: Header=BB54_115 Depth=1
	incl	numFilesProcessed(%rip)
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	callq	compress
	jmp	.LBB54_114
	.p2align	4, 0x90
.LBB54_120:                             # %if.then339
                                        #   in Loop: Header=BB54_115 Depth=1
	movb	$0, -9(%rbp)
	jmp	.LBB54_114
.LBB54_121:                             # %if.else394
	movb	$0, testFailsExist(%rip)
	cmpl	$1, srcMode(%rip)
	jne	.LBB54_132
# BB#122:                               # %if.then397
	xorl	%edi, %edi
	callq	testf
	jmp	.LBB54_140
.LBB54_123:                             # %if.else364
	movb	$1, -9(%rbp)
	movq	-40(%rbp), %rax
	jmp	.LBB54_125
	.p2align	4, 0x90
.LBB54_124:                             # %for.inc387
                                        #   in Loop: Header=BB54_125 Depth=1
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
.LBB54_125:                             # %for.cond365
                                        # =>This Inner Loop Header: Depth=1
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.LBB54_131
# BB#126:                               # %for.body368
                                        #   in Loop: Header=BB54_125 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.21, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_130
# BB#127:                               # %if.end374
                                        #   in Loop: Header=BB54_125 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	cmpb	$45, (%rax)
	jne	.LBB54_129
# BB#128:                               # %land.lhs.true380
                                        #   in Loop: Header=BB54_125 Depth=1
	cmpb	$0, -9(%rbp)
	jne	.LBB54_124
.LBB54_129:                             # %if.end384
                                        #   in Loop: Header=BB54_125 Depth=1
	incl	numFilesProcessed(%rip)
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	callq	uncompress
	jmp	.LBB54_124
	.p2align	4, 0x90
.LBB54_130:                             # %if.then373
                                        #   in Loop: Header=BB54_125 Depth=1
	movb	$0, -9(%rbp)
	jmp	.LBB54_124
.LBB54_131:                             # %if.end390
	movb	$1, %al
	testb	%al, %al
	jne	.LBB54_142
	jmp	.LBB54_152
.LBB54_132:                             # %if.else398
	movb	$1, -9(%rbp)
	movq	-40(%rbp), %rax
	jmp	.LBB54_134
	.p2align	4, 0x90
.LBB54_133:                             # %for.inc421
                                        #   in Loop: Header=BB54_134 Depth=1
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
.LBB54_134:                             # %for.cond399
                                        # =>This Inner Loop Header: Depth=1
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.LBB54_140
# BB#135:                               # %for.body402
                                        #   in Loop: Header=BB54_134 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	movl	$.L.str.21, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB54_139
# BB#136:                               # %if.end408
                                        #   in Loop: Header=BB54_134 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	cmpb	$45, (%rax)
	jne	.LBB54_138
# BB#137:                               # %land.lhs.true414
                                        #   in Loop: Header=BB54_134 Depth=1
	cmpb	$0, -9(%rbp)
	jne	.LBB54_133
.LBB54_138:                             # %if.end418
                                        #   in Loop: Header=BB54_134 Depth=1
	incl	numFilesProcessed(%rip)
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	callq	testf
	jmp	.LBB54_133
	.p2align	4, 0x90
.LBB54_139:                             # %if.then407
                                        #   in Loop: Header=BB54_134 Depth=1
	movb	$0, -9(%rbp)
	jmp	.LBB54_133
.LBB54_140:                             # %if.end424
	movb	$1, %al
	testb	%al, %al
	jne	.LBB54_142
# BB#141:                               # %land.lhs.true427
	cmpb	$0, noisy(%rip)
	jne	.LBB54_151
.LBB54_142:                             # %if.end434
	movq	-40(%rbp), %rax
	jmp	.LBB54_144
	.p2align	4, 0x90
.LBB54_143:                             # %if.end444
                                        #   in Loop: Header=BB54_144 Depth=1
	movq	-24(%rbp), %rdi
	callq	free
	movq	-80(%rbp), %rax
.LBB54_144:                             # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.LBB54_147
# BB#145:                               # %while.body
                                        #   in Loop: Header=BB54_144 Depth=1
	movq	-24(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -80(%rbp)
	movq	-24(%rbp), %rax
	cmpq	$0, (%rax)
	je	.LBB54_143
# BB#146:                               # %if.then442
                                        #   in Loop: Header=BB54_144 Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	callq	free
	jmp	.LBB54_143
.LBB54_147:                             # %while.end
	movl	exitValue(%rip), %eax
	addq	$88, %rsp
	popq	%rbx
	popq	%rbp
	retq
.LBB54_148:                             # %sw.bb131
	movq	progName(%rip), %rdi
	callq	usage
	xorl	%edi, %edi
	callq	exit
.LBB54_149:                             # %sw.default
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movq	-24(%rbp), %rax
	movq	(%rax), %rcx
	movl	$.L.str.28, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	progName(%rip), %rdi
	callq	usage
	movl	$1, %edi
	callq	exit
.LBB54_150:                             # %if.then303
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.46, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, %edi
	callq	exit
.LBB54_151:                             # %if.then430
	movq	stderr(%rip), %rdi
	movl	$.L.str.47, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB54_152:                             # %if.then392
	movl	$2, %edi
	callq	setExit
	movl	exitValue(%rip), %edi
	callq	exit
.Lfunc_end54:
	.size	main, .Lfunc_end54-main
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	3
.LJTI54_0:
	.quad	.LBB54_36
	.quad	.LBB54_40
	.quad	.LBB54_41
	.quad	.LBB54_42
	.quad	.LBB54_37
	.quad	.LBB54_43
	.quad	.LBB54_44
	.quad	.LBB54_45
	.quad	.LBB54_46
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_32
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_32
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_51
	.quad	.LBB54_47
	.quad	.LBB54_149
	.quad	.LBB54_38
	.quad	.LBB54_149
	.quad	.LBB54_148
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_48
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_49
	.quad	.LBB54_149
	.quad	.LBB54_52
	.quad	.LBB54_53
	.quad	.LBB54_149
	.quad	.LBB54_50
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_149
	.quad	.LBB54_39

	.text
	.p2align	4, 0x90
	.type	mySIGSEGVorSIGBUScatcher,@function
mySIGSEGVorSIGBUScatcher:               # @mySIGSEGVorSIGBUScatcher
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi172:
	.cfi_def_cfa_offset 16
.Lcfi173:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi174:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
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
.Lcfi175:
	.cfi_def_cfa_offset 16
.Lcfi176:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi177:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -8(%rbp)
	movq	%rsi, %rdi
	callq	strlen
	cmpq	$1025, %rax             # imm = 0x401
	jae	.LBB56_2
# BB#1:                                 # %if.end
	movq	-16(%rbp), %rdi
	movq	-8(%rbp), %rsi
	movl	$1024, %edx             # imm = 0x400
	callq	strncpy
	movq	-16(%rbp), %rax
	movb	$0, 1024(%rax)
	addq	$16, %rsp
	popq	%rbp
	retq
.LBB56_2:                               # %if.then
	movq	stderr(%rip), %rdi
	movq	-8(%rbp), %rdx
	movl	$.L.str.89, %esi
	movl	$1024, %ecx             # imm = 0x400
	xorl	%eax, %eax
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
.Lcfi178:
	.cfi_def_cfa_offset 16
.Lcfi179:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi180:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$56, %rsp
.Lcfi181:
	.cfi_offset %rbx, -24
	movq	%rdi, -48(%rbp)
	movq	%rsi, -64(%rbp)
	movq	%rsi, %rdi
	callq	getenv
	movq	%rax, -56(%rbp)
	testq	%rax, %rax
	je	.LBB57_16
# BB#1:                                 # %if.then
	movq	-56(%rbp), %rax
	movq	%rax, -40(%rbp)
	movl	$0, -16(%rbp)
	movl	$1024, %ebx             # imm = 0x400
	jmp	.LBB57_2
	.p2align	4, 0x90
.LBB57_15:                              # %for.end60
                                        #   in Loop: Header=BB57_2 Depth=1
	movslq	-20(%rbp), %rax
	movb	$0, tmpName(%rax)
	movq	-48(%rbp), %rax
	movq	(%rax), %rdi
	movl	$tmpName, %esi
	callq	snocString
	movq	-48(%rbp), %rcx
	movq	%rax, (%rcx)
.LBB57_2:                               # %while.body1
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB57_4 Depth 2
                                        #     Child Loop BB57_6 Depth 2
                                        #     Child Loop BB57_13 Depth 2
	movq	-40(%rbp), %rax
	movslq	-16(%rbp), %rcx
	cmpb	$0, (%rax,%rcx)
	je	.LBB57_16
# BB#3:                                 # %if.end6
                                        #   in Loop: Header=BB57_2 Depth=1
	movl	$0, -16(%rbp)
	jmp	.LBB57_4
	.p2align	4, 0x90
.LBB57_5:                               # %while.body1118
                                        #   in Loop: Header=BB57_4 Depth=2
	incq	-40(%rbp)
.LBB57_4:                               # %while.cond49
                                        #   Parent Loop BB57_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	callq	__ctype_b_loc
	movq	(%rax), %rax
	movq	-40(%rbp), %rcx
	movsbq	(%rcx), %rcx
	movzwl	(%rax,%rcx,2), %eax
	testb	$32, %ah
	jne	.LBB57_5
	jmp	.LBB57_6
	.p2align	4, 0x90
.LBB57_10:                              # %while.body2741
                                        #   in Loop: Header=BB57_6 Depth=2
	incl	%eax
	movl	%eax, -16(%rbp)
.LBB57_6:                               # %while.cond1221
                                        #   Parent Loop BB57_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-40(%rbp), %rax
	movslq	-16(%rbp), %rcx
	cmpb	$0, (%rax,%rcx)
	je	.LBB57_8
# BB#7:                                 # %land.rhs26
                                        #   in Loop: Header=BB57_6 Depth=2
	callq	__ctype_b_loc
	movq	(%rax), %rax
	movq	-40(%rbp), %rcx
	movslq	-16(%rbp), %rdx
	movsbq	(%rcx,%rdx), %rcx
	movzwl	(%rax,%rcx,2), %eax
	testb	$32, %ah
	sete	-25(%rbp)
	sete	-9(%rbp)
	jmp	.LBB57_9
	.p2align	4, 0x90
.LBB57_8:                               # %while.cond12.land.end_crit_edge38
                                        #   in Loop: Header=BB57_6 Depth=2
	movb	$0, -9(%rbp)
.LBB57_9:                               # %land.end39
                                        #   in Loop: Header=BB57_6 Depth=2
	movl	-16(%rbp), %eax
	cmpb	$1, -9(%rbp)
	je	.LBB57_10
# BB#11:                                # %while.end2844
                                        #   in Loop: Header=BB57_2 Depth=1
	testl	%eax, %eax
	jle	.LBB57_2
# BB#12:                                # %if.then3146
                                        #   in Loop: Header=BB57_2 Depth=1
	movl	-16(%rbp), %eax
	movl	%eax, -20(%rbp)
	cmpl	$1024, %eax             # imm = 0x400
	cmovgl	%ebx, %eax
	movl	%eax, -20(%rbp)
	movl	$0, -24(%rbp)
	jmp	.LBB57_13
	.p2align	4, 0x90
.LBB57_14:                              # %for.body55
                                        #   in Loop: Header=BB57_13 Depth=2
	movq	-40(%rbp), %rax
	movslq	-24(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movb	%al, tmpName(%rcx)
	incl	-24(%rbp)
.LBB57_13:                              # %for.cond53
                                        #   Parent Loop BB57_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-24(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jl	.LBB57_14
	jmp	.LBB57_15
.LBB57_16:                              # %if.end48
	addq	$56, %rsp
	popq	%rbx
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
.Lcfi182:
	.cfi_def_cfa_offset 16
.Lcfi183:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi184:
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -32(%rbp)
	movq	%rsi, -24(%rbp)
	cmpq	$0, -32(%rbp)
	je	.LBB58_1
# BB#2:                                 # %if.else
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.LBB58_3
	.p2align	4, 0x90
.LBB58_4:                               # %while.body
                                        #   in Loop: Header=BB58_3 Depth=1
	movq	%rdi, -8(%rbp)
.LBB58_3:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdi
	testq	%rdi, %rdi
	jne	.LBB58_4
# BB#5:                                 # %while.end
	movq	-24(%rbp), %rsi
	callq	snocString
	movq	-8(%rbp), %rcx
	movq	%rax, 8(%rcx)
	movq	-32(%rbp), %rax
	jmp	.LBB58_6
.LBB58_1:                               # %if.then
	callq	mkCell
	movq	%rax, -16(%rbp)
	movq	-24(%rbp), %rdi
	callq	strlen
	leal	5(%rax), %edi
	callq	myMalloc
	movq	-16(%rbp), %rcx
	movq	%rax, (%rcx)
	movq	-16(%rbp), %rax
	movq	(%rax), %rdi
	movq	-24(%rbp), %rsi
	callq	strcpy
	movq	-16(%rbp), %rax
.LBB58_6:                               # %return
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rax
	addq	$48, %rsp
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
.Lcfi185:
	.cfi_def_cfa_offset 16
.Lcfi186:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi187:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi188:
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
.Lcfi189:
	.cfi_def_cfa_offset 16
.Lcfi190:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi191:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi192:
	.cfi_offset %rbx, -24
	movq	%rdi, -16(%rbp)
	movq	stderr(%rip), %rbx
	callq	BZ2_bzlibVersion
	movq	%rax, %rdx
	movq	-16(%rbp), %rcx
	movl	$.L.str.92, %esi
	xorl	%eax, %eax
	movq	%rbx, %rdi
	callq	fprintf
	addq	$8, %rsp
	popq	%rbx
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
.Lcfi193:
	.cfi_def_cfa_offset 16
.Lcfi194:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi195:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, %rcx
	movq	%rcx, -8(%rbp)
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.93, %esi
	xorl	%eax, %eax
	callq	fprintf
	addq	$16, %rsp
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
.Lcfi196:
	.cfi_def_cfa_offset 16
.Lcfi197:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi198:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
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
.Lcfi199:
	.cfi_def_cfa_offset 16
.Lcfi200:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi201:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$184, %rsp
.Lcfi202:
	.cfi_offset %rbx, -40
.Lcfi203:
	.cfi_offset %r14, -32
.Lcfi204:
	.cfi_offset %r15, -24
	movq	%rdi, -56(%rbp)
	movb	$0, deleteOutputOnInterrupt(%rip)
	cmpq	$0, -56(%rbp)
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
	movq	-56(%rbp), %rsi
	movl	$inName, %edi
	callq	copyFileName
	movq	-56(%rbp), %rsi
	movl	$outName, %edi
	callq	copyFileName
	movl	$outName, %edi
	movl	$.L.str.12, %esi
	callq	strcat
	cmpl	$1, srcMode(%rip)
	jne	.LBB63_10
	jmp	.LBB63_13
.LBB63_7:                               # %sw.bb3
	movq	-56(%rbp), %rsi
	movl	$inName, %edi
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
.LBB63_15:                              # %if.end22
	movl	$0, -36(%rbp)
	cmpl	$3, -36(%rbp)
	jg	.LBB63_20
	.p2align	4, 0x90
.LBB63_17:                              # %for.body3
                                        # =>This Inner Loop Header: Depth=1
	movslq	-36(%rbp), %rax
	movq	zSuffix(,%rax,8), %rsi
	movl	$inName, %edi
	callq	hasSuffix
	testb	%al, %al
	jne	.LBB63_18
# BB#16:                                # %for.inc16
                                        #   in Loop: Header=BB63_17 Depth=1
	incl	-36(%rbp)
	cmpl	$3, -36(%rbp)
	jle	.LBB63_17
.LBB63_20:                              # %for.end
	movl	srcMode(%rip), %eax
	cmpl	$3, %eax
	je	.LBB63_22
# BB#21:                                # %for.end
	cmpl	$2, %eax
	jne	.LBB63_24
.LBB63_22:                              # %if.then39
	leaq	-208(%rbp), %rsi
	movl	$inName, %edi
	callq	stat
	movl	$61440, %eax            # imm = 0xF000
	andl	-184(%rbp), %eax
	cmpl	$16384, %eax            # imm = 0x4000
	jne	.LBB63_24
# BB#23:                                # %if.then43
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.101, %esi
	jmp	.LBB63_29
.LBB63_18:                              # %if.then278
	cmpb	$0, noisy(%rip)
	je	.LBB63_65
# BB#19:                                # %if.then2911
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movslq	-36(%rbp), %rax
	movq	zSuffix(,%rax,8), %r8
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
	movl	%eax, -60(%rbp)
	testl	%eax, %eax
	jle	.LBB63_40
# BB#39:                                # %if.then82
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	-60(%rbp), %r8d
	cmpl	$1, %r8d
	movl	$.L.str.105, %eax
	movl	$.L.str.16, %r9d
	cmovgq	%rax, %r9
	movl	$.L.str.104, %esi
	movl	$inName, %ecx
	xorl	%eax, %eax
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
	movq	stdin(%rip), %rax
	movq	%rax, -32(%rbp)
	movq	stdout(%rip), %rax
	movq	%rax, -48(%rbp)
	movq	stdout(%rip), %rdi
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
	movq	%rax, -32(%rbp)
	movl	$outName, %edi
	movl	$.L.str.109, %esi
	callq	fopen_output_safely
	movq	%rax, -48(%rbp)
	testq	%rax, %rax
	je	.LBB63_54
# BB#48:                                # %if.end134
	cmpq	$0, -32(%rbp)
	jne	.LBB63_57
# BB#49:                                # %if.then137
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
	callq	fprintf
	cmpq	$0, -48(%rbp)
	je	.LBB63_65
# BB#50:                                # %if.then143
	movq	-48(%rbp), %rdi
	callq	fclose
	jmp	.LBB63_65
.LBB63_51:                              # %sw.bb99
	movl	$inName, %edi
	movl	$.L.str.108, %esi
	callq	fopen
	movq	%rax, -32(%rbp)
	movq	stdout(%rip), %rax
	movq	%rax, -48(%rbp)
	movq	stdout(%rip), %rdi
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
	cmpq	$0, -32(%rbp)
	jne	.LBB63_55
	jmp	.LBB63_65
.LBB63_53:                              # %if.else
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.103, %esi
	movl	$outName, %ecx
	jmp	.LBB63_30
.LBB63_54:                              # %if.then125
	movq	stderr(%rip), %r14
	movq	progName(%rip), %r15
	callq	__errno_location
	movl	(%rax), %edi
	callq	strerror
	movq	%rax, %rbx
	movl	$.L.str.110, %esi
	movl	$outName, %ecx
	xorl	%eax, %eax
	movq	%r14, %rdi
	movq	%r15, %rdx
	movq	%rbx, %r8
	callq	fprintf
	cmpq	$0, -32(%rbp)
	je	.LBB63_65
.LBB63_55:                              # %if.then109
	movq	-32(%rbp), %rdi
	callq	fclose
	jmp	.LBB63_65
.LBB63_56:                              # %if.end112
	cmpq	$0, -32(%rbp)
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
	movq	-48(%rbp), %rax
	movq	%rax, outputHandleJustInCase(%rip)
	movb	$1, deleteOutputOnInterrupt(%rip)
	movq	-32(%rbp), %rdi
	movq	-48(%rbp), %rsi
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
	movl	%eax, -64(%rbp)
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
	addq	$184, %rsp
	popq	%rbx
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
.Lcfi205:
	.cfi_def_cfa_offset 16
.Lcfi206:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi207:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$200, %rsp
.Lcfi208:
	.cfi_offset %rbx, -40
.Lcfi209:
	.cfi_offset %r14, -32
.Lcfi210:
	.cfi_offset %r15, -24
	movq	%rdi, -64(%rbp)
	movb	$0, deleteOutputOnInterrupt(%rip)
	cmpq	$0, -64(%rbp)
	jne	.LBB64_2
# BB#1:                                 # %entry
	cmpl	$1, srcMode(%rip)
	jne	.LBB64_116
.LBB64_2:                               # %if.end
	movb	$0, -26(%rbp)
	movl	srcMode(%rip), %eax
	cmpl	$3, %eax
	je	.LBB64_67
# BB#3:                                 # %if.end
	cmpl	$2, %eax
	je	.LBB64_7
# BB#4:                                 # %if.end
	cmpl	$1, %eax
	jne	.LBB64_9
# BB#5:                                 # %sw.bb
	movl	$inName, %edi
	movl	$.L.str.96, %esi
	jmp	.LBB64_8
.LBB64_7:                               # %sw.bb9
	movq	-64(%rbp), %rsi
	movl	$inName, %edi
.LBB64_8:                               # %zzz
	callq	copyFileName
	movl	$outName, %edi
	movl	$.L.str.97, %esi
	callq	copyFileName
	cmpl	$1, srcMode(%rip)
	jne	.LBB64_10
	jmp	.LBB64_17
.LBB64_67:                              # %sw.bb2
	movq	-64(%rbp), %rsi
	movl	$inName, %edi
	callq	copyFileName
	movq	-64(%rbp), %rsi
	movl	$outName, %edi
	callq	copyFileName
	movl	$0, -52(%rbp)
	cmpl	$3, -52(%rbp)
	jle	.LBB64_69
	jmp	.LBB64_6
	.p2align	4, 0x90
.LBB64_117:                             # %for.inc15
                                        #   in Loop: Header=BB64_69 Depth=1
	incl	-52(%rbp)
	cmpl	$3, -52(%rbp)
	jg	.LBB64_6
.LBB64_69:                              # %for.body4
                                        # =>This Inner Loop Header: Depth=1
	movslq	-52(%rbp), %rax
	movq	zSuffix(,%rax,8), %rsi
	movq	unzSuffix(,%rax,8), %rdx
	movl	$outName, %edi
	callq	mapSuffix
	testb	%al, %al
	je	.LBB64_117
# BB#70:                                # %zzz13
	cmpl	$1, srcMode(%rip)
	je	.LBB64_72
# BB#71:                                # %land.lhs.true1117
	movl	$inName, %edi
	callq	containsDubiousChars
	testb	%al, %al
	jne	.LBB64_11
.LBB64_72:                              # %if.end1925
	cmpl	$1, srcMode(%rip)
	je	.LBB64_74
# BB#73:                                # %land.lhs.true2230
	movl	$inName, %edi
	callq	fileExists
	testb	%al, %al
	je	.LBB64_19
.LBB64_74:                              # %if.end2940
	movl	srcMode(%rip), %eax
	cmpl	$3, %eax
	je	.LBB64_76
# BB#75:                                # %if.end2940
	cmpl	$2, %eax
	jne	.LBB64_77
.LBB64_76:                              # %if.then3446
	leaq	-216(%rbp), %rsi
	movl	$inName, %edi
	callq	stat
	movl	$61440, %eax            # imm = 0xF000
	andl	-192(%rbp), %eax
	cmpl	$16384, %eax            # imm = 0x4000
	je	.LBB64_23
.LBB64_77:                              # %if.end4156
	cmpl	$3, srcMode(%rip)
	jne	.LBB64_80
# BB#78:                                # %if.end4156
	movb	forceOverwrite(%rip), %al
	testb	%al, %al
	jne	.LBB64_80
# BB#79:                                # %land.lhs.true4662
	movl	$inName, %edi
	callq	notAStandardFile
	testb	%al, %al
	jne	.LBB64_27
.LBB64_80:                              # %if.end5566
	movb	$1, %al
	testb	%al, %al
	jne	.LBB64_83
# BB#81:                                # %if.end5566
	movb	noisy(%rip), %al
	testb	%al, %al
	je	.LBB64_83
# BB#82:                                # %if.then5977
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.122, %esi
	movl	$inName, %ecx
	movl	$outName, %r8d
	xorl	%eax, %eax
	callq	fprintf
.LBB64_83:                              # %if.end6280
	cmpl	$3, srcMode(%rip)
	jne	.LBB64_87
# BB#84:                                # %land.lhs.true6584
	movl	$outName, %edi
	callq	fileExists
	testb	%al, %al
	je	.LBB64_87
# BB#85:                                # %if.then6989
	cmpb	$0, forceOverwrite(%rip)
	je	.LBB64_118
# BB#86:                                # %if.then7194
	movl	$outName, %edi
	callq	remove
.LBB64_87:                              # %if.end7592
	cmpl	$3, srcMode(%rip)
	jne	.LBB64_90
# BB#88:                                # %if.end7592
	movb	forceOverwrite(%rip), %al
	testb	%al, %al
	jne	.LBB64_90
# BB#89:                                # %land.lhs.true80103
	movl	$inName, %edi
	callq	countHardLinks
	movl	%eax, -56(%rbp)
	testl	%eax, %eax
	jg	.LBB64_39
.LBB64_90:                              # %if.end88106
	cmpl	$3, srcMode(%rip)
	jne	.LBB64_92
# BB#91:                                # %if.then91113
	movl	$inName, %edi
	callq	saveInputFileMetaInfo
.LBB64_92:                              # %if.end92115
	movl	srcMode(%rip), %eax
	cmpl	$1, %eax
	je	.LBB64_96
# BB#93:                                # %if.end92115
	cmpl	$2, %eax
	je	.LBB64_47
# BB#94:                                # %if.end92115
	cmpl	$3, %eax
	je	.LBB64_51
# BB#95:                                # %sw.default116
	movl	$.L.str.125, %edi
	callq	panic
.LBB64_6:                               # %for.end
	movb	$1, -26(%rbp)
	movl	$outName, %edi
	movl	$.L.str.121, %esi
	callq	strcat
.LBB64_9:                               # %zzz
	cmpl	$1, srcMode(%rip)
	je	.LBB64_17
.LBB64_10:                              # %land.lhs.true11
	movl	$inName, %edi
	callq	containsDubiousChars
	testb	%al, %al
	je	.LBB64_17
.LBB64_11:                              # %if.then14
	cmpb	$0, noisy(%rip)
	je	.LBB64_16
# BB#12:                                # %if.then16
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.98, %esi
	jmp	.LBB64_13
.LBB64_17:                              # %if.end19
	cmpl	$1, srcMode(%rip)
	je	.LBB64_20
# BB#18:                                # %land.lhs.true22
	movl	$inName, %edi
	callq	fileExists
	testb	%al, %al
	je	.LBB64_19
.LBB64_20:                              # %if.end29
	movl	srcMode(%rip), %eax
	cmpl	$3, %eax
	je	.LBB64_22
# BB#21:                                # %if.end29
	cmpl	$2, %eax
	jne	.LBB64_24
.LBB64_22:                              # %if.then34
	leaq	-216(%rbp), %rsi
	movl	$inName, %edi
	callq	stat
	movl	$61440, %eax            # imm = 0xF000
	andl	-192(%rbp), %eax
	cmpl	$16384, %eax            # imm = 0x4000
	jne	.LBB64_24
.LBB64_23:                              # %if.then38
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.101, %esi
	jmp	.LBB64_13
.LBB64_24:                              # %if.end41
	cmpl	$3, srcMode(%rip)
	jne	.LBB64_29
# BB#25:                                # %if.end41
	movb	forceOverwrite(%rip), %al
	testb	%al, %al
	jne	.LBB64_29
# BB#26:                                # %land.lhs.true46
	movl	$inName, %edi
	callq	notAStandardFile
	testb	%al, %al
	je	.LBB64_29
.LBB64_27:                              # %if.then50
	cmpb	$0, noisy(%rip)
	je	.LBB64_16
# BB#28:                                # %if.then52
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.102, %esi
.LBB64_13:                              # %if.end18
	movl	$inName, %ecx
.LBB64_14:                              # %if.end18
	xorl	%eax, %eax
.LBB64_15:                              # %if.end18
	callq	fprintf
	jmp	.LBB64_16
.LBB64_29:                              # %if.end55
	cmpb	$0, -26(%rbp)
	je	.LBB64_32
# BB#30:                                # %if.end55
	movb	noisy(%rip), %al
	testb	%al, %al
	je	.LBB64_32
# BB#31:                                # %if.then59
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.122, %esi
	movl	$inName, %ecx
	movl	$outName, %r8d
	xorl	%eax, %eax
	callq	fprintf
.LBB64_32:                              # %if.end62
	cmpl	$3, srcMode(%rip)
	jne	.LBB64_36
# BB#33:                                # %land.lhs.true65
	movl	$outName, %edi
	callq	fileExists
	testb	%al, %al
	je	.LBB64_36
# BB#34:                                # %if.then69
	cmpb	$0, forceOverwrite(%rip)
	je	.LBB64_118
# BB#35:                                # %if.then71
	movl	$outName, %edi
	callq	remove
.LBB64_36:                              # %if.end75
	cmpl	$3, srcMode(%rip)
	jne	.LBB64_40
# BB#37:                                # %if.end75
	movb	forceOverwrite(%rip), %al
	testb	%al, %al
	jne	.LBB64_40
# BB#38:                                # %land.lhs.true80
	movl	$inName, %edi
	callq	countHardLinks
	movl	%eax, -56(%rbp)
	testl	%eax, %eax
	jle	.LBB64_40
.LBB64_39:                              # %if.then84
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	-56(%rbp), %r8d
	cmpl	$1, %r8d
	movl	$.L.str.105, %eax
	movl	$.L.str.16, %r9d
	cmovgq	%rax, %r9
	movl	$.L.str.104, %esi
	movl	$inName, %ecx
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB64_16
.LBB64_40:                              # %if.end88
	cmpl	$3, srcMode(%rip)
	jne	.LBB64_42
# BB#41:                                # %if.then91
	movl	$inName, %edi
	callq	saveInputFileMetaInfo
.LBB64_42:                              # %if.end92
	movl	srcMode(%rip), %eax
	cmpl	$3, %eax
	je	.LBB64_51
# BB#43:                                # %if.end92
	cmpl	$2, %eax
	je	.LBB64_47
# BB#44:                                # %if.end92
	cmpl	$1, %eax
	jne	.LBB64_56
# BB#45:                                # %sw.bb93
	movq	stdin(%rip), %rax
	movq	%rax, -40(%rbp)
	movq	stdout(%rip), %rax
	movq	%rax, -48(%rbp)
	movq	stdin(%rip), %rdi
	callq	fileno
	movl	%eax, %edi
	callq	isatty
	testl	%eax, %eax
	je	.LBB64_57
# BB#46:                                # %if.then97
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
	jmp	.LBB64_15
.LBB64_19:                              # %if.then25
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
	callq	fprintf
.LBB64_16:                              # %if.end18
	movl	$1, %edi
	callq	setExit
.LBB64_115:                             # %if.end191
	addq	$200, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB64_51:                              # %sw.bb115
	movl	$inName, %edi
	movl	$.L.str.108, %esi
	callq	fopen
	movq	%rax, -40(%rbp)
	movl	$outName, %edi
	movl	$.L.str.109, %esi
	callq	fopen_output_safely
	movq	%rax, -48(%rbp)
	testq	%rax, %rax
	je	.LBB64_52
# BB#53:                                # %if.end129
	cmpq	$0, -40(%rbp)
	jne	.LBB64_57
.LBB64_54:                              # %if.then132
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
	callq	fprintf
	cmpq	$0, -48(%rbp)
	je	.LBB64_16
# BB#55:                                # %if.then138
	movq	-48(%rbp), %rdi
	callq	fclose
	jmp	.LBB64_16
.LBB64_47:                              # %sw.bb101
	movl	$inName, %edi
	movl	$.L.str.108, %esi
	callq	fopen
	movq	%rax, -40(%rbp)
	movq	stdout(%rip), %rax
	movq	%rax, -48(%rbp)
	cmpq	$0, -40(%rbp)
	je	.LBB64_48
.LBB64_57:                              # %sw.epilog142
	cmpl	$0, verbosity(%rip)
	jle	.LBB64_59
# BB#58:                                # %if.then145
	movq	stderr(%rip), %rdi
	movl	$.L.str.112, %esi
	movl	$inName, %edx
	xorl	%eax, %eax
	callq	fprintf
	movl	$inName, %edi
	callq	pad
	movq	stderr(%rip), %rdi
	callq	fflush
.LBB64_59:                              # %if.end148
	movq	-48(%rbp), %rax
	movq	%rax, outputHandleJustInCase(%rip)
	movb	$1, deleteOutputOnInterrupt(%rip)
	movq	-40(%rbp), %rdi
	movq	-48(%rbp), %rsi
	callq	uncompressStream
	movb	%al, -25(%rbp)
	movq	$0, outputHandleJustInCase(%rip)
	cmpb	$0, -25(%rbp)
	je	.LBB64_64
# BB#60:                                # %if.then151
	cmpl	$3, srcMode(%rip)
	jne	.LBB64_108
# BB#61:                                # %if.then154
	movl	$outName, %edi
	callq	applySavedMetaInfoToOutputFile
	movb	$0, deleteOutputOnInterrupt(%rip)
	cmpb	$0, keepInputFiles(%rip)
	jne	.LBB64_108
# BB#62:                                # %if.then156
	movl	$inName, %edi
	callq	remove
	movl	%eax, -72(%rbp)
	testl	%eax, %eax
	je	.LBB64_108
# BB#63:                                # %if.then160
	callq	ioError
.LBB64_118:                             # %if.else
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.103, %esi
	movl	$outName, %ecx
	jmp	.LBB64_14
.LBB64_64:                              # %if.else164
	movb	$1, unzFailsExist(%rip)
	movb	$0, deleteOutputOnInterrupt(%rip)
	cmpl	$3, srcMode(%rip)
	jne	.LBB64_108
# BB#65:                                # %if.then167
	movl	$outName, %edi
	callq	remove
	movl	%eax, -68(%rbp)
	testl	%eax, %eax
	jne	.LBB64_66
.LBB64_108:                             # %if.end175194
	movb	$0, deleteOutputOnInterrupt(%rip)
	cmpb	$0, -25(%rbp)
	je	.LBB64_111
# BB#109:                               # %if.then177196
	cmpl	$0, verbosity(%rip)
	jle	.LBB64_115
# BB#110:                               # %if.then180200
	movq	stderr(%rip), %rdi
	movl	$.L.str.126, %esi
	jmp	.LBB64_113
.LBB64_111:                             # %if.else183198
	movl	$2, %edi
	callq	setExit
	cmpl	$0, verbosity(%rip)
	movq	stderr(%rip), %rdi
	jle	.LBB64_114
# BB#112:                               # %if.then186203
	movl	$.L.str.127, %esi
.LBB64_113:                             # %if.end191
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB64_115
.LBB64_48:                              # %if.then105
	movq	stderr(%rip), %r14
	movq	progName(%rip), %r15
	callq	__errno_location
	movl	(%rax), %edi
	callq	strerror
	movq	%rax, %rbx
	movl	$.L.str.124, %esi
	movl	$inName, %ecx
	jmp	.LBB64_49
.LBB64_114:                             # %if.else188205
	movq	progName(%rip), %rdx
	movl	$.L.str.128, %esi
	movl	$inName, %ecx
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB64_115
.LBB64_96:                              # %sw.bb115124
	movl	$inName, %edi
	movl	$.L.str.108, %esi
	callq	fopen
	movq	%rax, -40(%rbp)
	movl	$outName, %edi
	movl	$.L.str.109, %esi
	callq	fopen_output_safely
	movq	%rax, -48(%rbp)
	testq	%rax, %rax
	je	.LBB64_52
# BB#97:                                # %if.end129143
	cmpq	$0, -40(%rbp)
	je	.LBB64_54
# BB#98:                                # %if.end141158
	cmpl	$0, verbosity(%rip)
	jle	.LBB64_100
# BB#99:                                # %if.then145159
	movq	stderr(%rip), %rdi
	movl	$.L.str.112, %esi
	movl	$inName, %edx
	xorl	%eax, %eax
	callq	fprintf
	movl	$inName, %edi
	callq	pad
	movq	stderr(%rip), %rdi
	callq	fflush
.LBB64_100:                             # %if.end148168
	movq	-48(%rbp), %rax
	movq	%rax, outputHandleJustInCase(%rip)
	movb	$1, deleteOutputOnInterrupt(%rip)
	movq	-40(%rbp), %rdi
	movq	-48(%rbp), %rsi
	callq	uncompressStream
	movb	%al, -25(%rbp)
	movq	$0, outputHandleJustInCase(%rip)
	cmpb	$0, -25(%rbp)
	je	.LBB64_106
# BB#101:                               # %if.then151172
	cmpl	$3, srcMode(%rip)
	jne	.LBB64_108
# BB#102:                               # %if.then154176
	movl	$outName, %edi
	callq	applySavedMetaInfoToOutputFile
	movb	$0, deleteOutputOnInterrupt(%rip)
	cmpb	$0, keepInputFiles(%rip)
	jne	.LBB64_108
# BB#103:                               # %if.then156184
	movl	$inName, %edi
	callq	remove
	movl	%eax, -72(%rbp)
	testl	%eax, %eax
	je	.LBB64_108
	jmp	.LBB64_105
.LBB64_52:                              # %if.then120
	movq	stderr(%rip), %r14
	movq	progName(%rip), %r15
	callq	__errno_location
	movl	(%rax), %edi
	callq	strerror
	movq	%rax, %rbx
	movl	$.L.str.110, %esi
	movl	$outName, %ecx
.LBB64_49:                              # %if.then105
	xorl	%eax, %eax
	movq	%r14, %rdi
	movq	%r15, %rdx
	movq	%rbx, %r8
	callq	fprintf
	cmpq	$0, -40(%rbp)
	je	.LBB64_16
# BB#50:                                # %if.then111
	movq	-40(%rbp), %rdi
	callq	fclose
	jmp	.LBB64_16
.LBB64_106:                             # %if.else164174
	movb	$1, unzFailsExist(%rip)
	movb	$0, deleteOutputOnInterrupt(%rip)
	cmpl	$3, srcMode(%rip)
	jne	.LBB64_108
# BB#107:                               # %if.then167179
	movl	$outName, %edi
	callq	remove
	movl	%eax, -68(%rbp)
	testl	%eax, %eax
	je	.LBB64_108
.LBB64_105:                             # %if.then160192
	callq	ioError
.LBB64_116:                             # %if.then
	movl	$.L.str.120, %edi
	callq	panic
.LBB64_56:                              # %sw.default
	movl	$.L.str.125, %edi
	callq	panic
.LBB64_66:                              # %if.then172
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
.Lcfi211:
	.cfi_def_cfa_offset 16
.Lcfi212:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi213:
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	cmpl	exitValue(%rip), %edi
	jle	.LBB65_2
# BB#1:                                 # %if.then
	movl	-4(%rbp), %eax
	movl	%eax, exitValue(%rip)
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
.Lcfi214:
	.cfi_def_cfa_offset 16
.Lcfi215:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi216:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$168, %rsp
.Lcfi217:
	.cfi_offset %rbx, -40
.Lcfi218:
	.cfi_offset %r14, -32
.Lcfi219:
	.cfi_offset %r15, -24
	movq	%rdi, -40(%rbp)
	movb	$0, deleteOutputOnInterrupt(%rip)
	cmpq	$0, -40(%rbp)
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
	movq	-40(%rbp), %rsi
	movl	$inName, %edi
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
	leaq	-192(%rbp), %rsi
	movl	$inName, %edi
	callq	stat
	movl	$61440, %eax            # imm = 0xF000
	andl	-168(%rbp), %eax
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
	movq	%rax, -48(%rbp)
	testq	%rax, %rax
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
.LBB66_18:                              # %if.end672
	movl	$inName, %ecx
	xorl	%eax, %eax
	movq	%r14, %rdi
	movq	%r15, %rdx
	movq	%rbx, %r8
	callq	fprintf
.LBB66_14:                              # %if.end10
	movl	$1, %edi
	callq	setExit
.LBB66_37:                              # %if.end672
	addq	$168, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB66_29:                              # %if.end39
	movq	stdin(%rip), %rax
	movq	%rax, -48(%rbp)
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
	movq	-48(%rbp), %rdi
	callq	testStream
	movb	%al, -25(%rbp)
	testb	%al, %al
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
	cmpb	$0, -25(%rbp)
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
.Lcfi220:
	.cfi_def_cfa_offset 16
.Lcfi221:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi222:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$952, %rsp              # imm = 0x3B8
.Lcfi223:
	.cfi_offset %rbx, -24
	movq	%rdi, -40(%rbp)
	movq	%rsi, -88(%rbp)
	movl	%edx, -136(%rbp)
	movl	%ecx, -132(%rbp)
	movl	$0, -76(%rbp)
	movl	$0, -12(%rbp)
	movl	-136(%rbp), %eax
	movslq	-12(%rbp), %rcx
	movl	%eax, -960(%rbp,%rcx,4)
	movl	-132(%rbp), %eax
	movslq	-12(%rbp), %rcx
	movl	%eax, -560(%rbp,%rcx,4)
	incl	-12(%rbp)
	movl	$2863311531, %ebx       # imm = 0xAAAAAAAB
	cmpl	$0, -12(%rbp)
	jg	.LBB67_2
	jmp	.LBB67_40
	.p2align	4, 0x90
.LBB67_5:                               # %if.then915
                                        #   in Loop: Header=BB67_2 Depth=1
	movq	-40(%rbp), %rdi
	movq	-88(%rbp), %rsi
	movl	-24(%rbp), %edx
	movl	-28(%rbp), %ecx
	callq	fallbackSimpleSort
.LBB67_1:                               # %while.cond1
                                        #   in Loop: Header=BB67_2 Depth=1
	cmpl	$0, -12(%rbp)
	jle	.LBB67_40
.LBB67_2:                               # %while.body3
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB67_12 Depth 2
                                        #       Child Loop BB67_16 Depth 3
                                        #     Child Loop BB67_29 Depth 2
                                        #     Child Loop BB67_35 Depth 2
	cmpl	$100, -12(%rbp)
	jl	.LBB67_4
# BB#3:                                 # %if.then6
                                        #   in Loop: Header=BB67_2 Depth=1
	movl	$1004, %edi             # imm = 0x3EC
	callq	BZ2_bz__AssertH__fail
.LBB67_4:                               # %if.end7
                                        #   in Loop: Header=BB67_2 Depth=1
	decl	-12(%rbp)
	movslq	-12(%rbp), %rax
	movl	-960(%rbp,%rax,4), %eax
	movl	%eax, -24(%rbp)
	movslq	-12(%rbp), %rax
	movl	-560(%rbp,%rax,4), %eax
	movl	%eax, -28(%rbp)
	subl	-24(%rbp), %eax
	cmpl	$9, %eax
	jle	.LBB67_5
# BB#6:                                 # %if.end1016
                                        #   in Loop: Header=BB67_2 Depth=1
	imull	$7621, -76(%rbp), %eax  # imm = 0x1DC5
	incl	%eax
	andl	$32767, %eax            # imm = 0x7FFF
	movl	%eax, -76(%rbp)
	movl	-76(%rbp), %eax
	movq	%rax, %rcx
	imulq	%rbx, %rcx
	shrq	$33, %rcx
	leal	(%rcx,%rcx,2), %ecx
	subl	%ecx, %eax
	movl	%eax, -128(%rbp)
	je	.LBB67_7
# BB#8:                                 # %if.else27
                                        #   in Loop: Header=BB67_2 Depth=1
	cmpl	$1, -128(%rbp)
	movq	-88(%rbp), %rax
	movq	-40(%rbp), %rcx
	jne	.LBB67_10
# BB#9:                                 # %if.then1930
                                        #   in Loop: Header=BB67_2 Depth=1
	movl	-24(%rbp), %edx
	addl	-28(%rbp), %edx
	sarl	%edx
	movslq	%edx, %rdx
	jmp	.LBB67_11
.LBB67_7:                               # %if.then1322
                                        #   in Loop: Header=BB67_2 Depth=1
	movq	-88(%rbp), %rax
	movq	-40(%rbp), %rcx
	movslq	-24(%rbp), %rdx
	jmp	.LBB67_11
.LBB67_10:                              # %if.else2537
                                        #   in Loop: Header=BB67_2 Depth=1
	movslq	-28(%rbp), %rdx
.LBB67_11:                              # %if.end3129
                                        #   in Loop: Header=BB67_2 Depth=1
	movl	(%rcx,%rdx,4), %ecx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -56(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	%eax, -16(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -44(%rbp)
	movl	%eax, -20(%rbp)
	jmp	.LBB67_12
	.p2align	4, 0x90
.LBB67_41:                              # %if.end5971
                                        #   in Loop: Header=BB67_12 Depth=2
	incl	-16(%rbp)
.LBB67_12:                              # %while.body3544
                                        #   Parent Loop BB67_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB67_16 Depth 3
	movl	-16(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jg	.LBB67_16
# BB#13:                                # %if.end3847
                                        #   in Loop: Header=BB67_12 Depth=2
	movq	-88(%rbp), %rax
	movq	-40(%rbp), %rcx
	movslq	-16(%rbp), %rdx
	movl	(%rcx,%rdx,4), %ecx
	movl	(%rax,%rcx,4), %eax
	subl	-56(%rbp), %eax
	movl	%eax, -32(%rbp)
	je	.LBB67_14
# BB#15:                                # %if.end5666
                                        #   in Loop: Header=BB67_12 Depth=2
	cmpl	$0, -32(%rbp)
	jle	.LBB67_41
	jmp	.LBB67_16
	.p2align	4, 0x90
.LBB67_22:                              # %if.end87109
                                        #   in Loop: Header=BB67_16 Depth=3
	decl	-20(%rbp)
.LBB67_16:                              # %while.body6268
                                        #   Parent Loop BB67_2 Depth=1
                                        #     Parent Loop BB67_12 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-16(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jg	.LBB67_20
# BB#17:                                # %if.end6574
                                        #   in Loop: Header=BB67_16 Depth=3
	movq	-88(%rbp), %rax
	movq	-40(%rbp), %rcx
	movslq	-20(%rbp), %rdx
	movl	(%rcx,%rdx,4), %ecx
	movl	(%rax,%rcx,4), %eax
	subl	-56(%rbp), %eax
	movl	%eax, -32(%rbp)
	je	.LBB67_18
# BB#19:                                # %if.end8494
                                        #   in Loop: Header=BB67_16 Depth=3
	cmpl	$0, -32(%rbp)
	jns	.LBB67_22
	jmp	.LBB67_20
	.p2align	4, 0x90
.LBB67_18:                              # %if.then7283
                                        #   in Loop: Header=BB67_16 Depth=3
	movq	-40(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -120(%rbp)
	movq	-40(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movl	(%rax,%rcx,4), %ecx
	movslq	-20(%rbp), %rdx
	movl	%ecx, (%rax,%rdx,4)
	movl	-120(%rbp), %eax
	movq	-40(%rbp), %rcx
	movslq	-44(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	decl	-44(%rbp)
	decl	-20(%rbp)
	jmp	.LBB67_16
	.p2align	4, 0x90
.LBB67_14:                              # %if.then4555
                                        #   in Loop: Header=BB67_12 Depth=2
	movq	-40(%rbp), %rax
	movslq	-16(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -124(%rbp)
	movq	-40(%rbp), %rax
	movslq	-48(%rbp), %rcx
	movl	(%rax,%rcx,4), %ecx
	movslq	-16(%rbp), %rdx
	movl	%ecx, (%rax,%rdx,4)
	movl	-124(%rbp), %eax
	movq	-40(%rbp), %rcx
	movslq	-48(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	-48(%rbp)
	incl	-16(%rbp)
	jmp	.LBB67_12
.LBB67_20:                              # %while.end8981
                                        #   in Loop: Header=BB67_12 Depth=2
	movl	-16(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jg	.LBB67_23
# BB#21:                                # %if.end9297
                                        #   in Loop: Header=BB67_12 Depth=2
	movq	-40(%rbp), %rax
	movslq	-16(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -116(%rbp)
	movq	-40(%rbp), %rax
	movslq	-20(%rbp), %rcx
	movl	(%rax,%rcx,4), %ecx
	movslq	-16(%rbp), %rdx
	movl	%ecx, (%rax,%rdx,4)
	movl	-116(%rbp), %eax
	movq	-40(%rbp), %rcx
	movslq	-20(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	-16(%rbp)
	decl	-20(%rbp)
	jmp	.LBB67_12
	.p2align	4, 0x90
.LBB67_23:                              # %while.end104111
                                        #   in Loop: Header=BB67_2 Depth=1
	movl	-44(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jl	.LBB67_1
# BB#24:                                # %if.end107114
                                        #   in Loop: Header=BB67_2 Depth=1
	movl	-48(%rbp), %eax
	movl	-16(%rbp), %ecx
	subl	%eax, %ecx
	subl	-24(%rbp), %eax
	cmpl	%ecx, %eax
	jge	.LBB67_26
# BB#25:                                # %cond.true118
                                        #   in Loop: Header=BB67_2 Depth=1
	movl	-48(%rbp), %eax
	subl	-24(%rbp), %eax
	movl	%eax, -140(%rbp)
	jmp	.LBB67_27
.LBB67_26:                              # %cond.false121
                                        #   in Loop: Header=BB67_2 Depth=1
	movl	-16(%rbp), %eax
	subl	-48(%rbp), %eax
	movl	%eax, -144(%rbp)
.LBB67_27:                              # %cond.end124
                                        #   in Loop: Header=BB67_2 Depth=1
	movl	%eax, -92(%rbp)
	movl	-92(%rbp), %eax
	movl	%eax, -32(%rbp)
	movl	-24(%rbp), %eax
	movl	%eax, -72(%rbp)
	movl	-16(%rbp), %eax
	subl	-32(%rbp), %eax
	movl	%eax, -68(%rbp)
	movl	-32(%rbp), %eax
	movl	%eax, -104(%rbp)
	cmpl	$0, -104(%rbp)
	jle	.LBB67_30
	.p2align	4, 0x90
.LBB67_29:                              # %while.body116129
                                        #   Parent Loop BB67_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-40(%rbp), %rax
	movslq	-72(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -112(%rbp)
	movq	-40(%rbp), %rax
	movslq	-68(%rbp), %rcx
	movl	(%rax,%rcx,4), %ecx
	movslq	-72(%rbp), %rdx
	movl	%ecx, (%rax,%rdx,4)
	movl	-112(%rbp), %eax
	movq	-40(%rbp), %rcx
	movslq	-68(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	-72(%rbp)
	incl	-68(%rbp)
	decl	-104(%rbp)
	cmpl	$0, -104(%rbp)
	jg	.LBB67_29
.LBB67_30:                              # %while.end129141
                                        #   in Loop: Header=BB67_2 Depth=1
	movl	-28(%rbp), %eax
	movl	-44(%rbp), %ecx
	subl	%ecx, %eax
	subl	-20(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB67_32
# BB#31:                                # %cond.true133145
                                        #   in Loop: Header=BB67_2 Depth=1
	movl	-28(%rbp), %eax
	subl	-44(%rbp), %eax
	movl	%eax, -148(%rbp)
	jmp	.LBB67_33
.LBB67_32:                              # %cond.false135148
                                        #   in Loop: Header=BB67_2 Depth=1
	movl	-44(%rbp), %eax
	subl	-20(%rbp), %eax
	movl	%eax, -152(%rbp)
.LBB67_33:                              # %cond.end137151
                                        #   in Loop: Header=BB67_2 Depth=1
	movl	%eax, -96(%rbp)
	movl	-96(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -64(%rbp)
	movl	-28(%rbp), %eax
	subl	-52(%rbp), %eax
	incl	%eax
	movl	%eax, -60(%rbp)
	movl	-52(%rbp), %eax
	movl	%eax, -100(%rbp)
	cmpl	$0, -100(%rbp)
	jle	.LBB67_36
	.p2align	4, 0x90
.LBB67_35:                              # %while.body146157
                                        #   Parent Loop BB67_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-40(%rbp), %rax
	movslq	-64(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -108(%rbp)
	movq	-40(%rbp), %rax
	movslq	-60(%rbp), %rcx
	movl	(%rax,%rcx,4), %ecx
	movslq	-64(%rbp), %rdx
	movl	%ecx, (%rax,%rdx,4)
	movl	-108(%rbp), %eax
	movq	-40(%rbp), %rcx
	movslq	-60(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	-64(%rbp)
	incl	-60(%rbp)
	decl	-100(%rbp)
	cmpl	$0, -100(%rbp)
	jg	.LBB67_35
.LBB67_36:                              # %while.end159169
                                        #   in Loop: Header=BB67_2 Depth=1
	movl	-24(%rbp), %eax
	addl	-16(%rbp), %eax
	subl	-48(%rbp), %eax
	decl	%eax
	movl	%eax, -32(%rbp)
	movl	-28(%rbp), %eax
	movl	-44(%rbp), %ecx
	subl	-20(%rbp), %ecx
	negl	%ecx
	leal	1(%rax,%rcx), %eax
	movl	%eax, -52(%rbp)
	movl	-32(%rbp), %ecx
	subl	-24(%rbp), %ecx
	movl	-28(%rbp), %edx
	subl	%eax, %edx
	cmpl	%edx, %ecx
	jle	.LBB67_39
# BB#37:                                # %if.then169179
                                        #   in Loop: Header=BB67_2 Depth=1
	movl	-24(%rbp), %eax
	movslq	-12(%rbp), %rcx
	movl	%eax, -960(%rbp,%rcx,4)
	movl	-32(%rbp), %eax
	movslq	-12(%rbp), %rcx
	movl	%eax, -560(%rbp,%rcx,4)
	incl	-12(%rbp)
	movl	-52(%rbp), %eax
	movslq	-12(%rbp), %rcx
	movl	%eax, -960(%rbp,%rcx,4)
	movl	-28(%rbp), %eax
	jmp	.LBB67_38
.LBB67_39:                              # %if.else180190
                                        #   in Loop: Header=BB67_2 Depth=1
	movl	-52(%rbp), %eax
	movslq	-12(%rbp), %rcx
	movl	%eax, -960(%rbp,%rcx,4)
	movl	-28(%rbp), %eax
	movslq	-12(%rbp), %rcx
	movl	%eax, -560(%rbp,%rcx,4)
	incl	-12(%rbp)
	movl	-24(%rbp), %eax
	movslq	-12(%rbp), %rcx
	movl	%eax, -960(%rbp,%rcx,4)
	movl	-32(%rbp), %eax
.LBB67_38:                              # %while.cond1
                                        #   in Loop: Header=BB67_2 Depth=1
	movslq	-12(%rbp), %rcx
	movl	%eax, -560(%rbp,%rcx,4)
	incl	-12(%rbp)
	cmpl	$0, -12(%rbp)
	jg	.LBB67_2
.LBB67_40:                              # %while.end192
	addq	$952, %rsp              # imm = 0x3B8
	popq	%rbx
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
.Lcfi224:
	.cfi_def_cfa_offset 16
.Lcfi225:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi226:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -32(%rbp)
	movq	%rsi, -48(%rbp)
	movl	%edx, -24(%rbp)
	movl	%ecx, -20(%rbp)
	cmpl	%ecx, -24(%rbp)
	je	.LBB68_20
# BB#1:                                 # %if.end
	movl	-20(%rbp), %eax
	subl	-24(%rbp), %eax
	cmpl	$4, %eax
	jl	.LBB68_11
# BB#2:                                 # %if.then3
	movl	-20(%rbp), %eax
	addl	$-4, %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB68_3
	.p2align	4, 0x90
.LBB68_10:                              # %for.end
                                        #   in Loop: Header=BB68_3 Depth=1
	movl	-16(%rbp), %eax
	movq	-32(%rbp), %rcx
	movslq	-4(%rbp), %rdx
	movl	%eax, -16(%rcx,%rdx,4)
	decl	-12(%rbp)
.LBB68_3:                               # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB68_5 Depth 2
	movl	-12(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jl	.LBB68_11
# BB#4:                                 # %for.body
                                        #   in Loop: Header=BB68_3 Depth=1
	movq	-32(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -16(%rbp)
	movq	-48(%rbp), %rax
	movslq	-16(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -36(%rbp)
	movl	-12(%rbp), %eax
	addl	$4, %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB68_5
	.p2align	4, 0x90
.LBB68_9:                               # %for.body15
                                        #   in Loop: Header=BB68_5 Depth=2
	movq	-32(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	movl	%edx, -16(%rax,%rcx,4)
	addl	$4, -4(%rbp)
.LBB68_5:                               # %for.cond8
                                        #   Parent Loop BB68_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-4(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jg	.LBB68_6
# BB#7:                                 # %land.rhs
                                        #   in Loop: Header=BB68_5 Depth=2
	movq	-48(%rbp), %rax
	movq	-32(%rbp), %rcx
	movslq	-4(%rbp), %rdx
	movl	(%rcx,%rdx,4), %ecx
	movl	(%rax,%rcx,4), %eax
	cmpl	-36(%rbp), %eax
	setb	%al
	movb	%al, -37(%rbp)
	movb	%al, -5(%rbp)
	cmpb	$1, -5(%rbp)
	je	.LBB68_9
	jmp	.LBB68_10
	.p2align	4, 0x90
.LBB68_6:                               # %for.cond8.land.end_crit_edge
                                        #   in Loop: Header=BB68_5 Depth=2
	movb	$0, -5(%rbp)
	cmpb	$1, -5(%rbp)
	je	.LBB68_9
	jmp	.LBB68_10
.LBB68_11:                              # %if.end27
	movl	-20(%rbp), %eax
	decl	%eax
	movl	%eax, -12(%rbp)
	jmp	.LBB68_12
	.p2align	4, 0x90
.LBB68_19:                              # %for.end53
                                        #   in Loop: Header=BB68_12 Depth=1
	movl	-16(%rbp), %eax
	movq	-32(%rbp), %rcx
	movslq	-4(%rbp), %rdx
	movl	%eax, -4(%rcx,%rdx,4)
	decl	-12(%rbp)
.LBB68_12:                              # %for.cond29
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB68_14 Depth 2
	movl	-12(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jl	.LBB68_20
# BB#13:                                # %for.body31
                                        #   in Loop: Header=BB68_12 Depth=1
	movq	-32(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -16(%rbp)
	movq	-48(%rbp), %rax
	movslq	-16(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -36(%rbp)
	movl	-12(%rbp), %eax
	incl	%eax
	movl	%eax, -4(%rbp)
	jmp	.LBB68_14
	.p2align	4, 0x90
.LBB68_18:                              # %for.body46
                                        #   in Loop: Header=BB68_14 Depth=2
	movq	-32(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movl	(%rax,%rcx,4), %edx
	movl	%edx, -4(%rax,%rcx,4)
	incl	-4(%rbp)
.LBB68_14:                              # %for.cond37
                                        #   Parent Loop BB68_12 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-4(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jg	.LBB68_15
# BB#16:                                # %land.rhs39
                                        #   in Loop: Header=BB68_14 Depth=2
	movq	-48(%rbp), %rax
	movq	-32(%rbp), %rcx
	movslq	-4(%rbp), %rdx
	movl	(%rcx,%rdx,4), %ecx
	movl	(%rax,%rcx,4), %eax
	cmpl	-36(%rbp), %eax
	setb	%al
	movb	%al, -38(%rbp)
	movb	%al, -6(%rbp)
	cmpb	$1, -6(%rbp)
	je	.LBB68_18
	jmp	.LBB68_19
	.p2align	4, 0x90
.LBB68_15:                              # %for.cond37.land.end45_crit_edge
                                        #   in Loop: Header=BB68_14 Depth=2
	movb	$0, -6(%rbp)
	cmpb	$1, -6(%rbp)
	je	.LBB68_18
	jmp	.LBB68_19
.LBB68_20:                              # %for.end59
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
.Lcfi227:
	.cfi_def_cfa_offset 16
.Lcfi228:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi229:
	.cfi_def_cfa_register %rbp
	subq	$1424, %rsp             # imm = 0x590
	movq	24(%rbp), %r10
	movl	16(%rbp), %eax
	movq	%rdi, -32(%rbp)
	movq	%rsi, -144(%rbp)
	movq	%rdx, -200(%rbp)
	movl	%ecx, -180(%rbp)
	movl	%r8d, -176(%rbp)
	movl	%r9d, -172(%rbp)
	movl	%eax, -168(%rbp)
	movq	%r10, -192(%rbp)
	movl	$0, -4(%rbp)
	movl	-176(%rbp), %eax
	movslq	-4(%rbp), %rcx
	movl	%eax, -1424(%rbp,%rcx,4)
	movl	-172(%rbp), %eax
	movslq	-4(%rbp), %rcx
	movl	%eax, -1024(%rbp,%rcx,4)
	movl	-168(%rbp), %eax
	jmp	.LBB69_1
	.p2align	4, 0x90
.LBB69_6:                               # %if.then14
                                        #   in Loop: Header=BB69_2 Depth=2
	movq	-32(%rbp), %rdi
	movq	-144(%rbp), %rsi
	movq	-200(%rbp), %rdx
	movl	-180(%rbp), %ecx
	movl	-20(%rbp), %r8d
	movl	-16(%rbp), %r9d
	movl	-40(%rbp), %eax
	pushq	-192(%rbp)
	pushq	%rax
	callq	mainSimpleSort
	addq	$16, %rsp
	movq	-192(%rbp), %rax
	cmpl	$0, (%rax)
	js	.LBB69_8
# BB#7:                                 # %if.then14
                                        #   in Loop: Header=BB69_2 Depth=2
	movl	-4(%rbp), %eax
	testl	%eax, %eax
	jg	.LBB69_2
	jmp	.LBB69_8
	.p2align	4, 0x90
.LBB69_9:                               # %if.end18
                                        #   in Loop: Header=BB69_1 Depth=1
	movq	-144(%rbp), %r9
	movq	-32(%rbp), %rcx
	movslq	-20(%rbp), %r8
	movl	-40(%rbp), %edx
	movl	(%rcx,%r8,4), %edi
	addl	%edx, %edi
	movslq	-16(%rbp), %rsi
	movl	(%rcx,%rsi,4), %eax
	addl	%edx, %eax
	leal	(%rsi,%r8), %esi
	sarl	%esi
	movslq	%esi, %rsi
	addl	(%rcx,%rsi,4), %edx
	movzbl	(%r9,%rax), %esi
	movzbl	(%r9,%rdi), %edi
	movzbl	(%r9,%rdx), %edx
	callq	mmed3
	movzbl	%al, %eax
	movl	%eax, -136(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	%eax, -8(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -44(%rbp)
	movl	%eax, -12(%rbp)
	jmp	.LBB69_10
	.p2align	4, 0x90
.LBB69_14:                              # %if.end66
                                        #   in Loop: Header=BB69_10 Depth=2
	incl	-8(%rbp)
.LBB69_10:                              # %while.body37
                                        #   Parent Loop BB69_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB69_15 Depth 3
	movl	-8(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jg	.LBB69_15
# BB#11:                                # %if.end41
                                        #   in Loop: Header=BB69_10 Depth=2
	movq	-144(%rbp), %rax
	movq	-32(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movl	(%rcx,%rdx,4), %ecx
	addl	-40(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	subl	-136(%rbp), %eax
	movl	%eax, -36(%rbp)
	je	.LBB69_12
# BB#13:                                # %if.end62
                                        #   in Loop: Header=BB69_10 Depth=2
	cmpl	$0, -36(%rbp)
	jle	.LBB69_14
	jmp	.LBB69_15
	.p2align	4, 0x90
.LBB69_19:                              # %if.end99
                                        #   in Loop: Header=BB69_15 Depth=3
	decl	-12(%rbp)
.LBB69_15:                              # %while.body69
                                        #   Parent Loop BB69_1 Depth=1
                                        #     Parent Loop BB69_10 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-8(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jg	.LBB69_20
# BB#16:                                # %if.end73
                                        #   in Loop: Header=BB69_15 Depth=3
	movq	-144(%rbp), %rax
	movq	-32(%rbp), %rcx
	movslq	-12(%rbp), %rdx
	movl	(%rcx,%rdx,4), %ecx
	addl	-40(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	subl	-136(%rbp), %eax
	movl	%eax, -36(%rbp)
	je	.LBB69_17
# BB#18:                                # %if.end95
                                        #   in Loop: Header=BB69_15 Depth=3
	cmpl	$0, -36(%rbp)
	jns	.LBB69_19
	jmp	.LBB69_20
	.p2align	4, 0x90
.LBB69_17:                              # %if.then83
                                        #   in Loop: Header=BB69_15 Depth=3
	movq	-32(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -160(%rbp)
	movq	-32(%rbp), %rax
	movslq	-44(%rbp), %rcx
	movl	(%rax,%rcx,4), %ecx
	movslq	-12(%rbp), %rdx
	movl	%ecx, (%rax,%rdx,4)
	movl	-160(%rbp), %eax
	movq	-32(%rbp), %rcx
	movslq	-44(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	decl	-44(%rbp)
	decl	-12(%rbp)
	jmp	.LBB69_15
	.p2align	4, 0x90
.LBB69_12:                              # %if.then51
                                        #   in Loop: Header=BB69_10 Depth=2
	movq	-32(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -164(%rbp)
	movq	-32(%rbp), %rax
	movslq	-48(%rbp), %rcx
	movl	(%rax,%rcx,4), %ecx
	movslq	-8(%rbp), %rdx
	movl	%ecx, (%rax,%rdx,4)
	movl	-164(%rbp), %eax
	movq	-32(%rbp), %rcx
	movslq	-48(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	-48(%rbp)
	incl	-8(%rbp)
	jmp	.LBB69_10
.LBB69_20:                              # %while.end101
                                        #   in Loop: Header=BB69_10 Depth=2
	movl	-8(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jg	.LBB69_22
# BB#21:                                # %if.end105
                                        #   in Loop: Header=BB69_10 Depth=2
	movq	-32(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -156(%rbp)
	movq	-32(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %ecx
	movslq	-8(%rbp), %rdx
	movl	%ecx, (%rax,%rdx,4)
	movl	-156(%rbp), %eax
	movq	-32(%rbp), %rcx
	movslq	-12(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	-8(%rbp)
	decl	-12(%rbp)
	jmp	.LBB69_10
	.p2align	4, 0x90
.LBB69_22:                              # %while.end117
                                        #   in Loop: Header=BB69_1 Depth=1
	movl	-44(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jl	.LBB69_23
# BB#24:                                # %if.end129
                                        #   in Loop: Header=BB69_1 Depth=1
	movl	-48(%rbp), %eax
	movl	-8(%rbp), %ecx
	subl	%eax, %ecx
	subl	-20(%rbp), %eax
	cmpl	%ecx, %eax
	jge	.LBB69_26
# BB#25:                                # %cond.true
                                        #   in Loop: Header=BB69_1 Depth=1
	movl	-48(%rbp), %eax
	subl	-20(%rbp), %eax
	movl	%eax, -204(%rbp)
	jmp	.LBB69_27
.LBB69_26:                              # %cond.false
                                        #   in Loop: Header=BB69_1 Depth=1
	movl	-8(%rbp), %eax
	subl	-48(%rbp), %eax
	movl	%eax, -208(%rbp)
.LBB69_27:                              # %cond.end
                                        #   in Loop: Header=BB69_1 Depth=1
	movl	%eax, -120(%rbp)
	movl	-120(%rbp), %eax
	movl	%eax, -36(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -116(%rbp)
	movl	-8(%rbp), %eax
	subl	-36(%rbp), %eax
	movl	%eax, -112(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -132(%rbp)
	cmpl	$0, -132(%rbp)
	jle	.LBB69_30
	.p2align	4, 0x90
.LBB69_29:                              # %while.body140
                                        #   Parent Loop BB69_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-32(%rbp), %rax
	movslq	-116(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -152(%rbp)
	movq	-32(%rbp), %rax
	movslq	-112(%rbp), %rcx
	movl	(%rax,%rcx,4), %ecx
	movslq	-116(%rbp), %rdx
	movl	%ecx, (%rax,%rdx,4)
	movl	-152(%rbp), %eax
	movq	-32(%rbp), %rcx
	movslq	-112(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	-116(%rbp)
	incl	-112(%rbp)
	decl	-132(%rbp)
	cmpl	$0, -132(%rbp)
	jg	.LBB69_29
.LBB69_30:                              # %while.end153
                                        #   in Loop: Header=BB69_1 Depth=1
	movl	-16(%rbp), %eax
	movl	-44(%rbp), %ecx
	subl	%ecx, %eax
	subl	-12(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB69_32
# BB#31:                                # %cond.true158
                                        #   in Loop: Header=BB69_1 Depth=1
	movl	-16(%rbp), %eax
	subl	-44(%rbp), %eax
	movl	%eax, -212(%rbp)
	jmp	.LBB69_33
.LBB69_32:                              # %cond.false160
                                        #   in Loop: Header=BB69_1 Depth=1
	movl	-44(%rbp), %eax
	subl	-12(%rbp), %eax
	movl	%eax, -216(%rbp)
.LBB69_33:                              # %cond.end162
                                        #   in Loop: Header=BB69_1 Depth=1
	movl	%eax, -124(%rbp)
	movl	-124(%rbp), %eax
	movl	%eax, -100(%rbp)
	movl	-8(%rbp), %eax
	movl	%eax, -108(%rbp)
	movl	-16(%rbp), %eax
	subl	-100(%rbp), %eax
	incl	%eax
	movl	%eax, -104(%rbp)
	movl	-100(%rbp), %eax
	movl	%eax, -128(%rbp)
	cmpl	$0, -128(%rbp)
	jle	.LBB69_36
	.p2align	4, 0x90
.LBB69_35:                              # %while.body172
                                        #   Parent Loop BB69_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-32(%rbp), %rax
	movslq	-108(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -148(%rbp)
	movq	-32(%rbp), %rax
	movslq	-104(%rbp), %rcx
	movl	(%rax,%rcx,4), %ecx
	movslq	-108(%rbp), %rdx
	movl	%ecx, (%rax,%rdx,4)
	movl	-148(%rbp), %eax
	movq	-32(%rbp), %rcx
	movslq	-104(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	-108(%rbp)
	incl	-104(%rbp)
	decl	-128(%rbp)
	cmpl	$0, -128(%rbp)
	jg	.LBB69_35
.LBB69_36:                              # %while.end185
                                        #   in Loop: Header=BB69_1 Depth=1
	movl	-20(%rbp), %eax
	addl	-8(%rbp), %eax
	subl	-48(%rbp), %eax
	decl	%eax
	movl	%eax, -36(%rbp)
	movl	-16(%rbp), %eax
	movl	-44(%rbp), %ecx
	subl	-12(%rbp), %ecx
	negl	%ecx
	leal	1(%rax,%rcx), %eax
	movl	%eax, -100(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, -72(%rbp)
	movl	-36(%rbp), %eax
	movl	%eax, -60(%rbp)
	movl	-40(%rbp), %eax
	movl	%eax, -96(%rbp)
	movl	-100(%rbp), %eax
	movl	%eax, -68(%rbp)
	movl	-16(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-40(%rbp), %eax
	movl	%eax, -92(%rbp)
	movl	-36(%rbp), %eax
	incl	%eax
	movl	%eax, -64(%rbp)
	movl	-100(%rbp), %eax
	decl	%eax
	movl	%eax, -52(%rbp)
	movl	-40(%rbp), %eax
	incl	%eax
	movl	%eax, -88(%rbp)
	movl	-60(%rbp), %eax
	movl	-56(%rbp), %ecx
	subl	-72(%rbp), %eax
	subl	-68(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB69_38
# BB#37:                                # %if.then212
                                        #   in Loop: Header=BB69_1 Depth=1
	movl	-72(%rbp), %eax
	movl	%eax, -84(%rbp)
	movl	-68(%rbp), %eax
	movl	%eax, -72(%rbp)
	movl	-84(%rbp), %eax
	movl	%eax, -68(%rbp)
	movl	-60(%rbp), %eax
	movl	%eax, -84(%rbp)
	movl	-56(%rbp), %eax
	movl	%eax, -60(%rbp)
	movl	-84(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-96(%rbp), %eax
	movl	%eax, -84(%rbp)
	movl	-92(%rbp), %eax
	movl	%eax, -96(%rbp)
	movl	-84(%rbp), %eax
	movl	%eax, -92(%rbp)
.LBB69_38:                              # %if.end225
                                        #   in Loop: Header=BB69_1 Depth=1
	movl	-56(%rbp), %eax
	movl	-52(%rbp), %ecx
	subl	-68(%rbp), %eax
	subl	-64(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB69_40
# BB#39:                                # %if.then234
                                        #   in Loop: Header=BB69_1 Depth=1
	movl	-68(%rbp), %eax
	movl	%eax, -80(%rbp)
	movl	-64(%rbp), %eax
	movl	%eax, -68(%rbp)
	movl	-80(%rbp), %eax
	movl	%eax, -64(%rbp)
	movl	-56(%rbp), %eax
	movl	%eax, -80(%rbp)
	movl	-52(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-80(%rbp), %eax
	movl	%eax, -52(%rbp)
	movl	-92(%rbp), %eax
	movl	%eax, -80(%rbp)
	movl	-88(%rbp), %eax
	movl	%eax, -92(%rbp)
	movl	-80(%rbp), %eax
	movl	%eax, -88(%rbp)
.LBB69_40:                              # %if.end248
                                        #   in Loop: Header=BB69_1 Depth=1
	movl	-60(%rbp), %eax
	movl	-56(%rbp), %ecx
	subl	-72(%rbp), %eax
	subl	-68(%rbp), %ecx
	cmpl	%ecx, %eax
	jge	.LBB69_42
# BB#41:                                # %if.then257
                                        #   in Loop: Header=BB69_1 Depth=1
	movl	-72(%rbp), %eax
	movl	%eax, -76(%rbp)
	movl	-68(%rbp), %eax
	movl	%eax, -72(%rbp)
	movl	-76(%rbp), %eax
	movl	%eax, -68(%rbp)
	movl	-60(%rbp), %eax
	movl	%eax, -76(%rbp)
	movl	-56(%rbp), %eax
	movl	%eax, -60(%rbp)
	movl	-76(%rbp), %eax
	movl	%eax, -56(%rbp)
	movl	-96(%rbp), %eax
	movl	%eax, -76(%rbp)
	movl	-92(%rbp), %eax
	movl	%eax, -96(%rbp)
	movl	-76(%rbp), %eax
	movl	%eax, -92(%rbp)
.LBB69_42:                              # %if.end271
                                        #   in Loop: Header=BB69_1 Depth=1
	movl	-72(%rbp), %eax
	movslq	-4(%rbp), %rcx
	movl	%eax, -1424(%rbp,%rcx,4)
	movl	-60(%rbp), %eax
	movslq	-4(%rbp), %rcx
	movl	%eax, -1024(%rbp,%rcx,4)
	movl	-96(%rbp), %eax
	movslq	-4(%rbp), %rcx
	movl	%eax, -624(%rbp,%rcx,4)
	incl	-4(%rbp)
	movl	-68(%rbp), %eax
	movslq	-4(%rbp), %rcx
	movl	%eax, -1424(%rbp,%rcx,4)
	movl	-56(%rbp), %eax
	movslq	-4(%rbp), %rcx
	movl	%eax, -1024(%rbp,%rcx,4)
	movl	-92(%rbp), %eax
	movslq	-4(%rbp), %rcx
	incl	-4(%rbp)
	movl	%eax, -624(%rbp,%rcx,4)
	movl	-64(%rbp), %eax
	movslq	-4(%rbp), %rcx
	movl	%eax, -1424(%rbp,%rcx,4)
	movl	-52(%rbp), %eax
	movslq	-4(%rbp), %rcx
	movl	%eax, -1024(%rbp,%rcx,4)
	movl	-88(%rbp), %eax
	jmp	.LBB69_1
	.p2align	4, 0x90
.LBB69_23:                              # %if.then120
                                        #   in Loop: Header=BB69_1 Depth=1
	movl	-20(%rbp), %eax
	movslq	-4(%rbp), %rcx
	movl	%eax, -1424(%rbp,%rcx,4)
	movl	-16(%rbp), %eax
	movslq	-4(%rbp), %rcx
	movl	%eax, -1024(%rbp,%rcx,4)
	movl	-40(%rbp), %eax
	incl	%eax
.LBB69_1:                               # %while.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB69_2 Depth 2
                                        #     Child Loop BB69_10 Depth 2
                                        #       Child Loop BB69_15 Depth 3
                                        #     Child Loop BB69_29 Depth 2
                                        #     Child Loop BB69_35 Depth 2
	movslq	-4(%rbp), %rcx
	movl	%eax, -624(%rbp,%rcx,4)
	incl	-4(%rbp)
	cmpl	$0, -4(%rbp)
	jle	.LBB69_8
	.p2align	4, 0x90
.LBB69_2:                               # %while.body
                                        #   Parent Loop BB69_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$100, -4(%rbp)
	jl	.LBB69_4
# BB#3:                                 # %if.then
                                        #   in Loop: Header=BB69_2 Depth=2
	movl	$1001, %edi             # imm = 0x3E9
	callq	BZ2_bz__AssertH__fail
.LBB69_4:                               # %if.end
                                        #   in Loop: Header=BB69_2 Depth=2
	decl	-4(%rbp)
	movslq	-4(%rbp), %rax
	movl	-1424(%rbp,%rax,4), %eax
	movl	%eax, -20(%rbp)
	movslq	-4(%rbp), %rax
	movl	-1024(%rbp,%rax,4), %eax
	movl	%eax, -16(%rbp)
	movslq	-4(%rbp), %rax
	movl	-624(%rbp,%rax,4), %eax
	movl	%eax, -40(%rbp)
	movl	-16(%rbp), %ecx
	subl	-20(%rbp), %ecx
	cmpl	$20, %ecx
	jl	.LBB69_6
# BB#5:                                 # %if.end
                                        #   in Loop: Header=BB69_2 Depth=2
	cmpl	$15, %eax
	jge	.LBB69_6
	jmp	.LBB69_9
.LBB69_8:                               # %while.end302
	addq	$1424, %rsp             # imm = 0x590
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
.Lcfi230:
	.cfi_def_cfa_offset 16
.Lcfi231:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi232:
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movq	24(%rbp), %r10
	movl	16(%rbp), %eax
	movq	%rdi, -32(%rbp)
	movq	%rsi, -72(%rbp)
	movq	%rdx, -64(%rbp)
	movl	%ecx, -48(%rbp)
	movl	%r8d, -36(%rbp)
	movl	%r9d, -40(%rbp)
	movl	%eax, -44(%rbp)
	movq	%r10, -56(%rbp)
	movl	-40(%rbp), %eax
	subl	-36(%rbp), %eax
	incl	%eax
	movl	%eax, -76(%rbp)
	cmpl	$2, %eax
	jl	.LBB70_20
# BB#1:                                 # %if.end
	movl	$0, -20(%rbp)
	jmp	.LBB70_2
	.p2align	4, 0x90
.LBB70_3:                               # %while.body5
                                        #   in Loop: Header=BB70_2 Depth=1
	leal	1(%rax), %eax
	movl	%eax, -20(%rbp)
.LBB70_2:                               # %while.cond1
                                        # =>This Inner Loop Header: Depth=1
	movslq	-20(%rbp), %rax
	movl	incs(,%rax,4), %ecx
	cmpl	-76(%rbp), %ecx
	jl	.LBB70_3
# BB#4:                                 # %while.end7
	leal	-1(%rax), %eax
	movl	%eax, -20(%rbp)
	cmpl	$0, -20(%rbp)
	jns	.LBB70_6
	jmp	.LBB70_20
	.p2align	4, 0x90
.LBB70_21:                              # %for.inc32
                                        #   in Loop: Header=BB70_6 Depth=1
	decl	-20(%rbp)
	cmpl	$0, -20(%rbp)
	js	.LBB70_20
.LBB70_6:                               # %for.body11
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB70_7 Depth 2
                                        #       Child Loop BB70_9 Depth 3
                                        #       Child Loop BB70_13 Depth 3
                                        #       Child Loop BB70_17 Depth 3
	movslq	-20(%rbp), %rax
	movl	incs(,%rax,4), %eax
	movl	%eax, -8(%rbp)
	addl	-36(%rbp), %eax
	movl	%eax, -12(%rbp)
	.p2align	4, 0x90
.LBB70_7:                               # %while.body716
                                        #   Parent Loop BB70_6 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB70_9 Depth 3
                                        #       Child Loop BB70_13 Depth 3
                                        #       Child Loop BB70_17 Depth 3
	movl	-12(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jg	.LBB70_21
# BB#8:                                 # %if.end1020
                                        #   in Loop: Header=BB70_7 Depth=2
	movq	-32(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -16(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -4(%rbp)
	.p2align	4, 0x90
.LBB70_9:                               # %while.cond1324
                                        #   Parent Loop BB70_6 Depth=1
                                        #     Parent Loop BB70_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	-32(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	subq	%rdx, %rcx
	movl	-44(%rbp), %esi
	movl	(%rax,%rcx,4), %edi
	addl	%esi, %edi
	addl	-16(%rbp), %esi
	movq	-72(%rbp), %rdx
	movq	-64(%rbp), %rcx
	movl	-48(%rbp), %r8d
	movq	-56(%rbp), %r9
	callq	mainGtU
	testb	%al, %al
	je	.LBB70_11
# BB#10:                                # %while.body1934
                                        #   in Loop: Header=BB70_9 Depth=3
	movq	-32(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movq	%rcx, %rsi
	subq	%rdx, %rsi
	movl	(%rax,%rsi,4), %edx
	movl	%edx, (%rax,%rcx,4)
	movl	-4(%rbp), %eax
	subl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	-36(%rbp), %ecx
	movl	-8(%rbp), %edx
	leal	-1(%rcx,%rdx), %ecx
	cmpl	%ecx, %eax
	jg	.LBB70_9
.LBB70_11:                              # %while.end3147
                                        #   in Loop: Header=BB70_7 Depth=2
	movl	-16(%rbp), %eax
	movq	-32(%rbp), %rcx
	movslq	-4(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movl	-12(%rbp), %eax
	incl	%eax
	movl	%eax, -12(%rbp)
	cmpl	-40(%rbp), %eax
	jg	.LBB70_21
# BB#12:                                # %if.end3753
                                        #   in Loop: Header=BB70_7 Depth=2
	movq	-32(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -16(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -4(%rbp)
	.p2align	4, 0x90
.LBB70_13:                              # %while.cond4056
                                        #   Parent Loop BB70_6 Depth=1
                                        #     Parent Loop BB70_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	-32(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	subq	%rdx, %rcx
	movl	-44(%rbp), %esi
	movl	(%rax,%rcx,4), %edi
	addl	%esi, %edi
	addl	-16(%rbp), %esi
	movq	-72(%rbp), %rdx
	movq	-64(%rbp), %rcx
	movl	-48(%rbp), %r8d
	movq	-56(%rbp), %r9
	callq	mainGtU
	testb	%al, %al
	je	.LBB70_15
# BB#14:                                # %while.body4864
                                        #   in Loop: Header=BB70_13 Depth=3
	movq	-32(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movq	%rcx, %rsi
	subq	%rdx, %rsi
	movl	(%rax,%rsi,4), %edx
	movl	%edx, (%rax,%rcx,4)
	movl	-4(%rbp), %eax
	subl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	-36(%rbp), %ecx
	movl	-8(%rbp), %edx
	leal	-1(%rcx,%rdx), %ecx
	cmpl	%ecx, %eax
	jg	.LBB70_13
.LBB70_15:                              # %while.end6077
                                        #   in Loop: Header=BB70_7 Depth=2
	movl	-16(%rbp), %eax
	movq	-32(%rbp), %rcx
	movslq	-4(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	movl	-12(%rbp), %eax
	incl	%eax
	movl	%eax, -12(%rbp)
	cmpl	-40(%rbp), %eax
	jg	.LBB70_21
# BB#16:                                # %if.end6683
                                        #   in Loop: Header=BB70_7 Depth=2
	movq	-32(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -16(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, -4(%rbp)
	.p2align	4, 0x90
.LBB70_17:                              # %while.cond6986
                                        #   Parent Loop BB70_6 Depth=1
                                        #     Parent Loop BB70_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	-32(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	subq	%rdx, %rcx
	movl	-44(%rbp), %esi
	movl	(%rax,%rcx,4), %edi
	addl	%esi, %edi
	addl	-16(%rbp), %esi
	movq	-72(%rbp), %rdx
	movq	-64(%rbp), %rcx
	movl	-48(%rbp), %r8d
	movq	-56(%rbp), %r9
	callq	mainGtU
	testb	%al, %al
	je	.LBB70_19
# BB#18:                                # %while.body7794
                                        #   in Loop: Header=BB70_17 Depth=3
	movq	-32(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movq	%rcx, %rsi
	subq	%rdx, %rsi
	movl	(%rax,%rsi,4), %edx
	movl	%edx, (%rax,%rcx,4)
	movl	-4(%rbp), %eax
	subl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	-36(%rbp), %ecx
	movl	-8(%rbp), %edx
	leal	-1(%rcx,%rdx), %ecx
	cmpl	%ecx, %eax
	jg	.LBB70_17
.LBB70_19:                              # %while.end89107
                                        #   in Loop: Header=BB70_7 Depth=2
	movl	-16(%rbp), %eax
	movq	-32(%rbp), %rcx
	movslq	-4(%rbp), %rdx
	movl	%eax, (%rcx,%rdx,4)
	incl	-12(%rbp)
	movq	-56(%rbp), %rax
	cmpl	$0, (%rax)
	jns	.LBB70_7
.LBB70_20:                              # %for.end
	addq	$80, %rsp
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
.Lcfi233:
	.cfi_def_cfa_offset 16
.Lcfi234:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi235:
	.cfi_def_cfa_register %rbp
	movb	%dil, -2(%rbp)
	movb	%sil, -1(%rbp)
	movb	%dl, -3(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jle	.LBB71_2
# BB#1:                                 # %if.then
	movb	-2(%rbp), %al
	movb	%al, -4(%rbp)
	movb	-1(%rbp), %al
	movb	%al, -2(%rbp)
	movb	-4(%rbp), %al
	movb	%al, -1(%rbp)
.LBB71_2:                               # %if.end
	movzbl	-1(%rbp), %eax
	movzbl	-3(%rbp), %ecx
	cmpl	%ecx, %eax
	jle	.LBB71_5
# BB#3:                                 # %if.then7
	movb	-3(%rbp), %al
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jle	.LBB71_5
# BB#4:                                 # %if.then12
	movb	-2(%rbp), %al
	movb	%al, -1(%rbp)
.LBB71_5:                               # %if.end14
	movb	-1(%rbp), %al
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
.Lcfi236:
	.cfi_def_cfa_offset 16
.Lcfi237:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi238:
	.cfi_def_cfa_register %rbp
	movl	%edi, -12(%rbp)
	movl	%esi, -8(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movl	%r8d, -36(%rbp)
	movq	%r9, -48(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#3:                                 # %if.end
	incl	-12(%rbp)
	incl	-8(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#4:                                 # %if.end25
	incl	-12(%rbp)
	incl	-8(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#5:                                 # %if.end42
	incl	-12(%rbp)
	incl	-8(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#6:                                 # %if.end59
	incl	-12(%rbp)
	incl	-8(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#7:                                 # %if.end76
	incl	-12(%rbp)
	incl	-8(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#8:                                 # %if.end93
	incl	-12(%rbp)
	incl	-8(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#9:                                 # %if.end110
	incl	-12(%rbp)
	incl	-8(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#10:                                # %if.end127
	incl	-12(%rbp)
	incl	-8(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#11:                                # %if.end144
	incl	-12(%rbp)
	incl	-8(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#12:                                # %if.end161
	incl	-12(%rbp)
	incl	-8(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#13:                                # %if.end178
	incl	-12(%rbp)
	incl	-8(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movb	(%rax,%rcx), %al
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	je	.LBB72_14
.LBB72_1:                               # %if.then
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
.LBB72_2:                               # %if.then
	cmpl	%ecx, %eax
	setg	%al
	setg	-3(%rbp)
	popq	%rbp
	retq
.LBB72_14:                              # %if.end195
	incl	-12(%rbp)
	incl	-8(%rbp)
	movl	-36(%rbp), %eax
	addl	$8, %eax
	movl	%eax, -40(%rbp)
.LBB72_15:                              # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#16:                                # %if.end212
                                        #   in Loop: Header=BB72_15 Depth=1
	movq	-32(%rbp), %rax
	movl	-12(%rbp), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -16(%rbp)
	movq	-32(%rbp), %rax
	movl	-8(%rbp), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -14(%rbp)
	movzwl	-16(%rbp), %eax
	movzwl	-14(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_17
# BB#18:                                # %if.end227
                                        #   in Loop: Header=BB72_15 Depth=1
	incl	-12(%rbp)
	incl	-8(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#19:                                # %if.end244
                                        #   in Loop: Header=BB72_15 Depth=1
	movq	-32(%rbp), %rax
	movl	-12(%rbp), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -16(%rbp)
	movq	-32(%rbp), %rax
	movl	-8(%rbp), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -14(%rbp)
	movzwl	-16(%rbp), %eax
	movzwl	-14(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_17
# BB#20:                                # %if.end259
                                        #   in Loop: Header=BB72_15 Depth=1
	incl	-12(%rbp)
	incl	-8(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#21:                                # %if.end276
                                        #   in Loop: Header=BB72_15 Depth=1
	movq	-32(%rbp), %rax
	movl	-12(%rbp), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -16(%rbp)
	movq	-32(%rbp), %rax
	movl	-8(%rbp), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -14(%rbp)
	movzwl	-16(%rbp), %eax
	movzwl	-14(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_17
# BB#22:                                # %if.end291
                                        #   in Loop: Header=BB72_15 Depth=1
	incl	-12(%rbp)
	incl	-8(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#23:                                # %if.end308
                                        #   in Loop: Header=BB72_15 Depth=1
	movq	-32(%rbp), %rax
	movl	-12(%rbp), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -16(%rbp)
	movq	-32(%rbp), %rax
	movl	-8(%rbp), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -14(%rbp)
	movzwl	-16(%rbp), %eax
	movzwl	-14(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_17
# BB#24:                                # %if.end323
                                        #   in Loop: Header=BB72_15 Depth=1
	incl	-12(%rbp)
	incl	-8(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#25:                                # %if.end340
                                        #   in Loop: Header=BB72_15 Depth=1
	movq	-32(%rbp), %rax
	movl	-12(%rbp), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -16(%rbp)
	movq	-32(%rbp), %rax
	movl	-8(%rbp), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -14(%rbp)
	movzwl	-16(%rbp), %eax
	movzwl	-14(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_17
# BB#26:                                # %if.end355
                                        #   in Loop: Header=BB72_15 Depth=1
	incl	-12(%rbp)
	incl	-8(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#27:                                # %if.end372
                                        #   in Loop: Header=BB72_15 Depth=1
	movq	-32(%rbp), %rax
	movl	-12(%rbp), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -16(%rbp)
	movq	-32(%rbp), %rax
	movl	-8(%rbp), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -14(%rbp)
	movzwl	-16(%rbp), %eax
	movzwl	-14(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_17
# BB#28:                                # %if.end387
                                        #   in Loop: Header=BB72_15 Depth=1
	incl	-12(%rbp)
	incl	-8(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#29:                                # %if.end404
                                        #   in Loop: Header=BB72_15 Depth=1
	movq	-32(%rbp), %rax
	movl	-12(%rbp), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -16(%rbp)
	movq	-32(%rbp), %rax
	movl	-8(%rbp), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -14(%rbp)
	movzwl	-16(%rbp), %eax
	movzwl	-14(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_17
# BB#30:                                # %if.end419
                                        #   in Loop: Header=BB72_15 Depth=1
	incl	-12(%rbp)
	incl	-8(%rbp)
	movq	-24(%rbp), %rax
	movl	-12(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -2(%rbp)
	movq	-24(%rbp), %rax
	movl	-8(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -1(%rbp)
	movzbl	-2(%rbp), %eax
	movzbl	-1(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_1
# BB#31:                                # %if.end436
                                        #   in Loop: Header=BB72_15 Depth=1
	movq	-32(%rbp), %rax
	movl	-12(%rbp), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -16(%rbp)
	movq	-32(%rbp), %rax
	movl	-8(%rbp), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -14(%rbp)
	movzwl	-16(%rbp), %eax
	movzwl	-14(%rbp), %ecx
	cmpl	%ecx, %eax
	jne	.LBB72_17
# BB#32:                                # %if.end451
                                        #   in Loop: Header=BB72_15 Depth=1
	incl	-12(%rbp)
	incl	-8(%rbp)
	movl	-12(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jb	.LBB72_34
# BB#33:                                # %if.then456
                                        #   in Loop: Header=BB72_15 Depth=1
	movl	-36(%rbp), %eax
	subl	%eax, -12(%rbp)
.LBB72_34:                              # %if.end457
                                        #   in Loop: Header=BB72_15 Depth=1
	movl	-8(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jb	.LBB72_36
# BB#35:                                # %if.then460
                                        #   in Loop: Header=BB72_15 Depth=1
	movl	-36(%rbp), %eax
	subl	%eax, -8(%rbp)
.LBB72_36:                              # %if.end462
                                        #   in Loop: Header=BB72_15 Depth=1
	addl	$-8, -40(%rbp)
	movq	-48(%rbp), %rax
	decl	(%rax)
	cmpl	$0, -40(%rbp)
	jns	.LBB72_15
# BB#37:                                # %do.end
	movb	$0, -3(%rbp)
	xorl	%eax, %eax
	popq	%rbp
	retq
.LBB72_17:                              # %if.then221
	movzwl	-16(%rbp), %eax
	movzwl	-14(%rbp), %ecx
	jmp	.LBB72_2
.Lfunc_end72:
	.size	mainGtU, .Lfunc_end72-mainGtU
	.cfi_endproc

	.p2align	4, 0x90
	.type	makeMaps_e,@function
makeMaps_e:                             # @makeMaps_e
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi239:
	.cfi_def_cfa_offset 16
.Lcfi240:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi241:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	$0, 124(%rdi)
	movl	$0, -4(%rbp)
	cmpl	$255, -4(%rbp)
	jle	.LBB73_2
	jmp	.LBB73_5
	.p2align	4, 0x90
.LBB73_4:                               # %for.inc18
                                        #   in Loop: Header=BB73_2 Depth=1
	incl	-4(%rbp)
	cmpl	$255, -4(%rbp)
	jg	.LBB73_5
.LBB73_2:                               # %for.body3
                                        # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	movslq	-4(%rbp), %rcx
	cmpb	$0, 128(%rax,%rcx)
	je	.LBB73_4
# BB#3:                                 # %if.then8
                                        #   in Loop: Header=BB73_2 Depth=1
	movq	-16(%rbp), %rax
	movzbl	124(%rax), %ecx
	movslq	-4(%rbp), %rdx
	movb	%cl, 384(%rax,%rdx)
	movq	-16(%rbp), %rax
	incl	124(%rax)
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
.Lcfi242:
	.cfi_def_cfa_offset 16
.Lcfi243:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi244:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movb	$0, -1(%rbp)
	jmp	.LBB74_1
	.p2align	4, 0x90
.LBB74_4:                               # %if.then16
                                        #   in Loop: Header=BB74_1 Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	incl	40(%rax)
.LBB74_1:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 32(%rax)
	je	.LBB74_5
# BB#2:                                 # %if.end
                                        #   in Loop: Header=BB74_1 Depth=1
	movq	-16(%rbp), %rax
	movl	120(%rax), %ecx
	cmpl	116(%rax), %ecx
	jge	.LBB74_5
# BB#3:                                 # %if.end3
                                        #   in Loop: Header=BB74_1 Depth=1
	movb	$1, -1(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rcx
	movq	80(%rax), %rdx
	movslq	120(%rax), %rax
	movzbl	(%rdx,%rax), %eax
	movq	24(%rcx), %rcx
	movb	%al, (%rcx)
	movq	-16(%rbp), %rax
	incl	120(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	decl	32(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	incq	24(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	incl	36(%rax)
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 36(%rax)
	jne	.LBB74_1
	jmp	.LBB74_4
.LBB74_5:                               # %while.end
	movb	-1(%rbp), %al
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
.Lcfi245:
	.cfi_def_cfa_offset 16
.Lcfi246:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi247:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movb	$0, -9(%rbp)
	movq	-8(%rbp), %rax
	cmpl	$2, 8(%rax)
	jne	.LBB75_14
	jmp	.LBB75_1
	.p2align	4, 0x90
.LBB75_28:                              # %if.end151
                                        #   in Loop: Header=BB75_14 Depth=1
	movq	-8(%rbp), %rax
	decl	16(%rax)
.LBB75_14:                              # %while.body60
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movl	108(%rax), %ecx
	cmpl	112(%rax), %ecx
	jge	.LBB75_29
# BB#15:                                # %if.end66
                                        #   in Loop: Header=BB75_14 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB75_29
# BB#16:                                # %if.end72
                                        #   in Loop: Header=BB75_14 Depth=1
	movq	-8(%rbp), %rax
	cmpl	$0, 16(%rax)
	je	.LBB75_29
# BB#17:                                # %if.end76
                                        #   in Loop: Header=BB75_14 Depth=1
	movb	$1, -9(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	(%rax), %rax
	movzbl	(%rax), %eax
	movl	%eax, -16(%rbp)
	movq	-8(%rbp), %rcx
	cmpl	92(%rcx), %eax
	je	.LBB75_20
# BB#18:                                # %land.lhs.true84
                                        #   in Loop: Header=BB75_14 Depth=1
	movq	-8(%rbp), %rax
	cmpl	$1, 96(%rax)
	jne	.LBB75_20
# BB#19:                                # %if.then88
                                        #   in Loop: Header=BB75_14 Depth=1
	movq	-8(%rbp), %rax
	movzbl	92(%rax), %eax
	movb	%al, -10(%rbp)
	movq	-8(%rbp), %rax
	movl	648(%rax), %ecx
	movl	%ecx, %edx
	shll	$8, %edx
	shrl	$24, %ecx
	movzbl	-10(%rbp), %esi
	xorl	%ecx, %esi
	xorl	BZ2_crc32Table(,%rsi,4), %edx
	movl	%edx, 648(%rax)
	movq	-8(%rbp), %rax
	movl	92(%rax), %ecx
	movb	$1, 128(%rax,%rcx)
	movzbl	-10(%rbp), %eax
	movq	-8(%rbp), %rcx
	movq	64(%rcx), %rdx
	movslq	108(%rcx), %rcx
	movb	%al, (%rdx,%rcx)
	movq	-8(%rbp), %rax
	incl	108(%rax)
	movl	-16(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 92(%rcx)
	jmp	.LBB75_26
	.p2align	4, 0x90
.LBB75_20:                              # %if.else113
                                        #   in Loop: Header=BB75_14 Depth=1
	movl	-16(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	92(%rcx), %eax
	jne	.LBB75_22
# BB#21:                                # %lor.lhs.false117
                                        #   in Loop: Header=BB75_14 Depth=1
	movq	-8(%rbp), %rax
	cmpl	$255, 96(%rax)
	jne	.LBB75_25
.LBB75_22:                              # %if.then121
                                        #   in Loop: Header=BB75_14 Depth=1
	movq	-8(%rbp), %rax
	cmpl	$255, 92(%rax)
	ja	.LBB75_24
# BB#23:                                # %if.then125
                                        #   in Loop: Header=BB75_14 Depth=1
	movq	-8(%rbp), %rdi
	callq	add_pair_to_block
.LBB75_24:                              # %if.end126
                                        #   in Loop: Header=BB75_14 Depth=1
	movl	-16(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 92(%rcx)
	movq	-8(%rbp), %rax
	movl	$1, 96(%rax)
	jmp	.LBB75_26
.LBB75_25:                              # %if.else129
                                        #   in Loop: Header=BB75_14 Depth=1
	movq	-8(%rbp), %rax
	incl	96(%rax)
	.p2align	4, 0x90
.LBB75_26:                              # %if.end133
                                        #   in Loop: Header=BB75_14 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB75_28
# BB#27:                                # %if.then147
                                        #   in Loop: Header=BB75_14 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
	jmp	.LBB75_28
	.p2align	4, 0x90
.LBB75_13:                              # %if.then55
                                        #   in Loop: Header=BB75_1 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	16(%rax)
.LBB75_1:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	movl	108(%rax), %ecx
	cmpl	112(%rax), %ecx
	jge	.LBB75_29
# BB#2:                                 # %if.end
                                        #   in Loop: Header=BB75_1 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 8(%rax)
	je	.LBB75_29
# BB#3:                                 # %if.end5
                                        #   in Loop: Header=BB75_1 Depth=1
	movb	$1, -9(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	(%rax), %rax
	movzbl	(%rax), %eax
	movl	%eax, -20(%rbp)
	movq	-8(%rbp), %rcx
	cmpl	92(%rcx), %eax
	je	.LBB75_6
# BB#4:                                 # %land.lhs.true
                                        #   in Loop: Header=BB75_1 Depth=1
	movq	-8(%rbp), %rax
	cmpl	$1, 96(%rax)
	jne	.LBB75_6
# BB#5:                                 # %if.then11
                                        #   in Loop: Header=BB75_1 Depth=1
	movq	-8(%rbp), %rax
	movzbl	92(%rax), %eax
	movb	%al, -11(%rbp)
	movq	-8(%rbp), %rax
	movl	648(%rax), %ecx
	movl	%ecx, %edx
	shll	$8, %edx
	shrl	$24, %ecx
	movzbl	-11(%rbp), %esi
	xorl	%ecx, %esi
	xorl	BZ2_crc32Table(,%rsi,4), %edx
	movl	%edx, 648(%rax)
	movq	-8(%rbp), %rax
	movl	92(%rax), %ecx
	movb	$1, 128(%rax,%rcx)
	movzbl	-11(%rbp), %eax
	movq	-8(%rbp), %rcx
	movq	64(%rcx), %rdx
	movslq	108(%rcx), %rcx
	movb	%al, (%rdx,%rcx)
	movq	-8(%rbp), %rax
	incl	108(%rax)
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 92(%rcx)
	jmp	.LBB75_12
	.p2align	4, 0x90
.LBB75_6:                               # %if.else
                                        #   in Loop: Header=BB75_1 Depth=1
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	92(%rcx), %eax
	jne	.LBB75_8
# BB#7:                                 # %lor.lhs.false
                                        #   in Loop: Header=BB75_1 Depth=1
	movq	-8(%rbp), %rax
	cmpl	$255, 96(%rax)
	jne	.LBB75_11
.LBB75_8:                               # %if.then32
                                        #   in Loop: Header=BB75_1 Depth=1
	movq	-8(%rbp), %rax
	cmpl	$255, 92(%rax)
	ja	.LBB75_10
# BB#9:                                 # %if.then36
                                        #   in Loop: Header=BB75_1 Depth=1
	movq	-8(%rbp), %rdi
	callq	add_pair_to_block
.LBB75_10:                              # %if.end37
                                        #   in Loop: Header=BB75_1 Depth=1
	movl	-20(%rbp), %eax
	movq	-8(%rbp), %rcx
	movl	%eax, 92(%rcx)
	movq	-8(%rbp), %rax
	movl	$1, 96(%rax)
	jmp	.LBB75_12
.LBB75_11:                              # %if.else40
                                        #   in Loop: Header=BB75_1 Depth=1
	movq	-8(%rbp), %rax
	incl	96(%rax)
	.p2align	4, 0x90
.LBB75_12:                              # %if.end44
                                        #   in Loop: Header=BB75_1 Depth=1
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incq	(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	decl	8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	incl	12(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpl	$0, 12(%rax)
	jne	.LBB75_1
	jmp	.LBB75_13
.LBB75_29:                              # %if.end155
	movb	-9(%rbp), %al
	addq	$32, %rsp
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
.Lcfi248:
	.cfi_def_cfa_offset 16
.Lcfi249:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi250:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	cmpl	$255, 92(%rdi)
	ja	.LBB76_2
# BB#1:                                 # %if.then
	movq	-8(%rbp), %rdi
	callq	add_pair_to_block
.LBB76_2:                               # %if.end
	movq	-8(%rbp), %rdi
	callq	init_RL
	addq	$16, %rsp
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
.Lcfi251:
	.cfi_def_cfa_offset 16
.Lcfi252:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi253:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movb	92(%rdi), %al
	movb	%al, -1(%rbp)
	movl	$0, -20(%rbp)
	jmp	.LBB77_1
	.p2align	4, 0x90
.LBB77_10:                              # %for.body4
                                        #   in Loop: Header=BB77_1 Depth=1
	movl	648(%rax), %eax
	shll	$8, %eax
	movq	-16(%rbp), %rcx
	movzbl	651(%rcx), %edx
	movzbl	-1(%rbp), %esi
	xorl	%edx, %esi
	xorl	BZ2_crc32Table(,%rsi,4), %eax
	movl	%eax, 648(%rcx)
	incl	-20(%rbp)
.LBB77_1:                               # %for.cond1
                                        # =>This Inner Loop Header: Depth=1
	movl	-20(%rbp), %ecx
	movq	-16(%rbp), %rax
	cmpl	96(%rax), %ecx
	jl	.LBB77_10
# BB#2:                                 # %for.end
	movq	-16(%rbp), %rcx
	movl	92(%rcx), %ecx
	movb	$1, 128(%rax,%rcx)
	movq	-16(%rbp), %rax
	movl	96(%rax), %eax
	cmpl	$3, %eax
	je	.LBB77_6
# BB#3:                                 # %for.end
	cmpl	$2, %eax
	je	.LBB77_7
# BB#4:                                 # %for.end
	cmpl	$1, %eax
	je	.LBB77_5
# BB#8:                                 # %sw.default
	movq	-16(%rbp), %rax
	movslq	96(%rax), %rcx
	movb	$1, 124(%rax,%rcx)
	movb	-1(%rbp), %al
	movq	-16(%rbp), %rcx
	movq	64(%rcx), %rdx
	movslq	108(%rcx), %rcx
	movb	%al, (%rdx,%rcx)
	movq	-16(%rbp), %rax
	incl	108(%rax)
	movb	-1(%rbp), %al
	movq	-16(%rbp), %rcx
	movq	64(%rcx), %rdx
	movslq	108(%rcx), %rcx
	movb	%al, (%rdx,%rcx)
	movq	-16(%rbp), %rax
	incl	108(%rax)
	movb	-1(%rbp), %al
	movq	-16(%rbp), %rcx
	movq	64(%rcx), %rdx
	movslq	108(%rcx), %rcx
	movb	%al, (%rdx,%rcx)
	movq	-16(%rbp), %rax
	incl	108(%rax)
	movb	-1(%rbp), %al
	movq	-16(%rbp), %rcx
	movq	64(%rcx), %rdx
	movslq	108(%rcx), %rcx
	movb	%al, (%rdx,%rcx)
	movq	-16(%rbp), %rax
	incl	108(%rax)
	movq	-16(%rbp), %rax
	movl	96(%rax), %ecx
	addl	$-4, %ecx
	movq	64(%rax), %rdx
	movslq	108(%rax), %rax
	movb	%cl, (%rdx,%rax)
	jmp	.LBB77_9
.LBB77_6:                               # %sw.bb27
	movb	-1(%rbp), %al
	movq	-16(%rbp), %rcx
	movq	64(%rcx), %rdx
	movslq	108(%rcx), %rcx
	movb	%al, (%rdx,%rcx)
	movq	-16(%rbp), %rax
	incl	108(%rax)
.LBB77_7:                               # %sw.bb14
	movb	-1(%rbp), %al
	movq	-16(%rbp), %rcx
	movq	64(%rcx), %rdx
	movslq	108(%rcx), %rcx
	movb	%al, (%rdx,%rcx)
	movq	-16(%rbp), %rax
	incl	108(%rax)
.LBB77_5:                               # %sw.bb
	movb	-1(%rbp), %al
	movq	-16(%rbp), %rcx
	movq	64(%rcx), %rdx
	movslq	108(%rcx), %rcx
	movb	%al, (%rdx,%rcx)
.LBB77_9:                               # %sw.epilog
	movq	-16(%rbp), %rax
	incl	108(%rax)
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
.Lcfi254:
	.cfi_def_cfa_offset 16
.Lcfi255:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi256:
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
.Lcfi257:
	.cfi_def_cfa_offset 16
.Lcfi258:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi259:
	.cfi_def_cfa_register %rbp
	subq	$160, %rsp
	movl	%edi, -8(%rbp)
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
	movl	%eax, -4(%rbp)
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
	movl	%eax, -4(%rbp)
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
	movl	-8(%rbp), %edi
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
.Lcfi260:
	.cfi_def_cfa_offset 16
.Lcfi261:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi262:
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
.Lcfi263:
	.cfi_def_cfa_offset 16
.Lcfi264:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi265:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$16, %edi
	callq	myMalloc
	movq	%rax, -8(%rbp)
	movq	$0, (%rax)
	movq	-8(%rbp), %rax
	movq	$0, 8(%rax)
	movq	-8(%rbp), %rax
	addq	$16, %rsp
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
.Lcfi266:
	.cfi_def_cfa_offset 16
.Lcfi267:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi268:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movslq	-4(%rbp), %rdi
	callq	malloc
	movq	%rax, -16(%rbp)
	testq	%rax, %rax
	je	.LBB82_2
# BB#1:                                 # %if.end
	movq	-16(%rbp), %rax
	addq	$16, %rsp
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
.Lcfi269:
	.cfi_def_cfa_offset 16
.Lcfi270:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi271:
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
.Lcfi272:
	.cfi_def_cfa_offset 16
.Lcfi273:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi274:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, %rcx
	movq	%rcx, -8(%rbp)
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
.Lcfi275:
	.cfi_def_cfa_offset 16
.Lcfi276:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi277:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
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
.Lcfi278:
	.cfi_def_cfa_offset 16
.Lcfi279:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi280:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	$.L.str.108, %esi
	callq	fopen
	movq	%rax, -16(%rbp)
	testq	%rax, %rax
	setne	-1(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB86_2
# BB#1:                                 # %if.then
	movq	-16(%rbp), %rdi
	callq	fclose
.LBB86_2:                               # %if.end
	movb	-1(%rbp), %al
	addq	$32, %rsp
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
.Lcfi281:
	.cfi_def_cfa_offset 16
.Lcfi282:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi283:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -32(%rbp)
	movq	%rsi, -24(%rbp)
	movq	-32(%rbp), %rdi
	callq	strlen
	movl	%eax, -8(%rbp)
	movq	-24(%rbp), %rdi
	callq	strlen
	movl	%eax, -12(%rbp)
	cmpl	%eax, -8(%rbp)
	jl	.LBB87_1
# BB#3:                                 # %if.end
	movslq	-8(%rbp), %rdi
	addq	-32(%rbp), %rdi
	movslq	-12(%rbp), %rax
	subq	%rax, %rdi
	movq	-24(%rbp), %rsi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB87_4
.LBB87_1:                               # %if.then
	movb	$0, -1(%rbp)
	xorl	%eax, %eax
	jmp	.LBB87_2
.LBB87_4:                               # %if.then9
	movb	$1, -1(%rbp)
	movb	$1, %al
.LBB87_2:                               # %if.then
	addq	$32, %rsp
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
.Lcfi284:
	.cfi_def_cfa_offset 16
.Lcfi285:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi286:
	.cfi_def_cfa_register %rbp
	subq	$160, %rsp
	movq	%rdi, -16(%rbp)
	leaq	-160(%rbp), %rsi
	callq	lstat
	movl	%eax, -8(%rbp)
	testl	%eax, %eax
	jne	.LBB88_1
# BB#3:                                 # %if.end
	movl	$61440, %eax            # imm = 0xF000
	andl	-136(%rbp), %eax
	cmpl	$32768, %eax            # imm = 0x8000
	jne	.LBB88_1
# BB#4:                                 # %if.then2
	movb	$0, -1(%rbp)
	xorl	%eax, %eax
	jmp	.LBB88_2
.LBB88_1:                               # %if.then
	movb	$1, -1(%rbp)
	movb	$1, %al
.LBB88_2:                               # %if.then
	addq	$160, %rsp
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
.Lcfi287:
	.cfi_def_cfa_offset 16
.Lcfi288:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi289:
	.cfi_def_cfa_register %rbp
	subq	$160, %rsp
	movq	%rdi, -16(%rbp)
	leaq	-160(%rbp), %rsi
	callq	lstat
	movl	%eax, -8(%rbp)
	testl	%eax, %eax
	je	.LBB89_3
# BB#1:                                 # %if.then
	movl	$0, -4(%rbp)
	xorl	%eax, %eax
	jmp	.LBB89_2
.LBB89_3:                               # %if.end
	movl	-144(%rbp), %eax
	decl	%eax
	movl	%eax, -4(%rbp)
.LBB89_2:                               # %if.then
	addq	$160, %rsp
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
.Lcfi290:
	.cfi_def_cfa_offset 16
.Lcfi291:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi292:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -16(%rbp)
	movl	$fileMetaInfo, %esi
	callq	stat
	movl	%eax, -4(%rbp)
	testl	%eax, %eax
	jne	.LBB90_2
# BB#1:                                 # %if.end
	addq	$16, %rsp
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
.Lcfi293:
	.cfi_def_cfa_offset 16
.Lcfi294:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi295:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$16, %rsp
.Lcfi296:
	.cfi_offset %rbx, -32
.Lcfi297:
	.cfi_offset %r14, -24
	movq	%rdi, -32(%rbp)
	callq	strlen
	cmpl	longestFileName(%rip), %eax
	jge	.LBB91_4
# BB#1:                                 # %if.end
	movl	$1, -20(%rbp)
	jmp	.LBB91_2
	.p2align	4, 0x90
.LBB91_3:                               # %for.body6
                                        #   in Loop: Header=BB91_2 Depth=1
	movq	stderr(%rip), %rdi
	movl	$.L.str.114, %esi
	xorl	%eax, %eax
	callq	fprintf
	incl	-20(%rbp)
.LBB91_2:                               # %for.cond1
                                        # =>This Inner Loop Header: Depth=1
	movl	-20(%rbp), %r14d
	movl	longestFileName(%rip), %ebx
	movq	-32(%rbp), %rdi
	callq	strlen
	subl	%eax, %ebx
	cmpl	%ebx, %r14d
	jle	.LBB91_3
.LBB91_4:                               # %for.end
	addq	$16, %rsp
	popq	%rbx
	popq	%r14
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
.Lcfi298:
	.cfi_def_cfa_offset 16
.Lcfi299:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi300:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$5192, %rsp             # imm = 0x1448
.Lcfi301:
	.cfi_offset %rbx, -40
.Lcfi302:
	.cfi_offset %r14, -32
.Lcfi303:
	.cfi_offset %r15, -24
	movq	%rdi, -56(%rbp)
	movq	%rsi, -48(%rbp)
	movq	$0, -80(%rbp)
	movq	-56(%rbp), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB92_28
# BB#1:                                 # %if.end
	movq	-48(%rbp), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB92_28
# BB#2:                                 # %if.end4
	movq	-48(%rbp), %rsi
	movl	blockSize100k(%rip), %edx
	movl	verbosity(%rip), %ecx
	movl	workFactor(%rip), %r8d
	leaq	-28(%rbp), %rdi
	callq	BZ2_bzWriteOpen
	movq	%rax, -80(%rbp)
	cmpl	$0, -28(%rbp)
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
	leaq	-5200(%rbp), %rbx
	leaq	-28(%rbp), %r14
	.p2align	4, 0x90
.LBB92_6:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movq	-56(%rbp), %rdi
	callq	myfeof
	testb	%al, %al
	jne	.LBB92_15
# BB#7:                                 # %if.end15
                                        #   in Loop: Header=BB92_6 Depth=1
	movq	-56(%rbp), %rcx
	movl	$1, %esi
	movl	$5000, %edx             # imm = 0x1388
	movq	%rbx, %rdi
	callq	fread
	movl	%eax, -68(%rbp)
	movq	-56(%rbp), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB92_28
# BB#8:                                 # %if.end20
                                        #   in Loop: Header=BB92_6 Depth=1
	cmpl	$0, -68(%rbp)
	jle	.LBB92_10
# BB#9:                                 # %if.then23
                                        #   in Loop: Header=BB92_6 Depth=1
	movq	-80(%rbp), %rsi
	movl	-68(%rbp), %ecx
	movq	%r14, %rdi
	movq	%rbx, %rdx
	callq	BZ2_bzWrite
.LBB92_10:                              # %if.end25
                                        #   in Loop: Header=BB92_6 Depth=1
	cmpl	$0, -28(%rbp)
	je	.LBB92_6
.LBB92_11:                              # %errhandler
	movq	-80(%rbp), %rsi
	leaq	-60(%rbp), %rax
	movq	%rax, (%rsp)
	leaq	-100(%rbp), %rdi
	leaq	-40(%rbp), %rcx
	leaq	-36(%rbp), %r8
	leaq	-64(%rbp), %r9
	movl	$1, %edx
	callq	BZ2_bzWriteClose64
	movl	-28(%rbp), %eax
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
	movq	-80(%rbp), %rsi
	leaq	-60(%rbp), %rax
	movq	%rax, (%rsp)
	leaq	-28(%rbp), %rdi
	leaq	-40(%rbp), %rcx
	leaq	-36(%rbp), %r8
	leaq	-64(%rbp), %r9
	xorl	%edx, %edx
	callq	BZ2_bzWriteClose64
	cmpl	$0, -28(%rbp)
	jne	.LBB92_11
# BB#16:                                # %if.end33
	movq	-48(%rbp), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB92_28
# BB#17:                                # %if.end37
	movq	-48(%rbp), %rdi
	callq	fflush
	movl	%eax, -32(%rbp)
	cmpl	$-1, %eax
	je	.LBB92_28
# BB#18:                                # %if.end42
	movq	-48(%rbp), %rax
	cmpq	stdout(%rip), %rax
	je	.LBB92_20
# BB#19:                                # %if.then45
	movq	-48(%rbp), %rdi
	callq	fclose
	movl	%eax, -32(%rbp)
	movq	$0, outputHandleJustInCase(%rip)
	cmpl	$-1, -32(%rbp)
	je	.LBB92_28
.LBB92_20:                              # %if.end51
	movq	$0, outputHandleJustInCase(%rip)
	movq	-56(%rbp), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB92_28
# BB#21:                                # %if.end55
	movq	-56(%rbp), %rdi
	callq	fclose
	movl	%eax, -32(%rbp)
	cmpl	$-1, %eax
	je	.LBB92_28
# BB#22:                                # %if.end60
	cmpl	$0, verbosity(%rip)
	jle	.LBB92_26
# BB#23:                                # %if.then63
	movl	-40(%rbp), %eax
	orl	-36(%rbp), %eax
	jne	.LBB92_25
# BB#24:                                # %if.then68
	movq	stderr(%rip), %rdi
	movl	$.L.str.115, %esi
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB92_26
.LBB92_25:                              # %if.else
	movl	-40(%rbp), %esi
	movl	-36(%rbp), %edx
	leaq	-120(%rbp), %r15
	movq	%r15, %rdi
	callq	uInt64_from_UInt32s
	movl	-64(%rbp), %esi
	movl	-60(%rbp), %edx
	leaq	-112(%rbp), %rbx
	movq	%rbx, %rdi
	callq	uInt64_from_UInt32s
	movq	%r15, %rdi
	callq	uInt64_to_double
	movsd	%xmm0, -96(%rbp)
	movq	%rbx, %rdi
	callq	uInt64_to_double
	movsd	%xmm0, -88(%rbp)
	leaq	-192(%rbp), %r14
	movq	%r14, %rdi
	movq	%r15, %rsi
	callq	uInt64_toAscii
	leaq	-160(%rbp), %r15
	movq	%r15, %rdi
	movq	%rbx, %rsi
	callq	uInt64_toAscii
	movq	stderr(%rip), %rdi
	movsd	-96(%rbp), %xmm2        # xmm2 = mem[0],zero
	movsd	-88(%rbp), %xmm3        # xmm3 = mem[0],zero
	movapd	%xmm2, %xmm0
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
	addq	$5192, %rsp             # imm = 0x1448
	popq	%rbx
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
.Lcfi304:
	.cfi_def_cfa_offset 16
.Lcfi305:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi306:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -16(%rbp)
	movq	fileMetaInfo+72(%rip), %rax
	movq	%rax, -32(%rbp)
	movq	fileMetaInfo+88(%rip), %rax
	movq	%rax, -24(%rbp)
	movq	-16(%rbp), %rdi
	movl	fileMetaInfo+24(%rip), %esi
	callq	chmod
	movl	%eax, -4(%rbp)
	testl	%eax, %eax
	jne	.LBB93_3
# BB#1:                                 # %if.end
	movq	-16(%rbp), %rdi
	leaq	-32(%rbp), %rsi
	callq	utime
	movl	%eax, -4(%rbp)
	testl	%eax, %eax
	jne	.LBB93_3
# BB#2:                                 # %if.end4
	movq	-16(%rbp), %rdi
	movl	fileMetaInfo+28(%rip), %esi
	movl	fileMetaInfo+32(%rip), %edx
	callq	chown
	movl	%eax, -4(%rbp)
	addq	$32, %rsp
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
.Lcfi307:
	.cfi_def_cfa_offset 16
.Lcfi308:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi309:
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
.Lcfi310:
	.cfi_def_cfa_offset 16
.Lcfi311:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi312:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	%esi, -8(%rbp)
	movl	%edx, -4(%rbp)
	movb	-1(%rbp), %al
	movq	-16(%rbp), %rcx
	movb	%al, 7(%rcx)
	movb	-2(%rbp), %al
	movq	-16(%rbp), %rcx
	movb	%al, 6(%rcx)
	movb	-3(%rbp), %al
	movq	-16(%rbp), %rcx
	movb	%al, 5(%rcx)
	movb	-4(%rbp), %al
	movq	-16(%rbp), %rcx
	movb	%al, 4(%rcx)
	movb	-5(%rbp), %al
	movq	-16(%rbp), %rcx
	movb	%al, 3(%rcx)
	movb	-6(%rbp), %al
	movq	-16(%rbp), %rcx
	movb	%al, 2(%rcx)
	movb	-7(%rbp), %al
	movq	-16(%rbp), %rcx
	movb	%al, 1(%rcx)
	movb	-8(%rbp), %al
	movq	-16(%rbp), %rcx
	movb	%al, (%rcx)
	popq	%rbp
	retq
.Lfunc_end95:
	.size	uInt64_from_UInt32s, .Lfunc_end95-uInt64_from_UInt32s
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI96_0:
	.quad	4643211215818981376     # double 256
	.text
	.p2align	4, 0x90
	.type	uInt64_to_double,@function
uInt64_to_double:                       # @uInt64_to_double
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi313:
	.cfi_def_cfa_offset 16
.Lcfi314:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi315:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -32(%rbp)
	movabsq	$4607182418800017408, %rax # imm = 0x3FF0000000000000
	movq	%rax, -24(%rbp)
	movq	$0, -16(%rbp)
	movl	$0, -4(%rbp)
	movsd	.LCPI96_0(%rip), %xmm0  # xmm0 = mem[0],zero
	cmpl	$7, -4(%rbp)
	jg	.LBB96_3
	.p2align	4, 0x90
.LBB96_2:                               # %for.body3
                                        # =>This Inner Loop Header: Depth=1
	movq	-32(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	xorps	%xmm1, %xmm1
	cvtsi2sdl	%eax, %xmm1
	mulsd	-24(%rbp), %xmm1
	addsd	-16(%rbp), %xmm1
	movsd	%xmm1, -16(%rbp)
	movsd	-24(%rbp), %xmm1        # xmm1 = mem[0],zero
	mulsd	%xmm0, %xmm1
	movsd	%xmm1, -24(%rbp)
	incl	-4(%rbp)
	cmpl	$7, -4(%rbp)
	jle	.LBB96_2
.LBB96_3:                               # %for.end
	movsd	-16(%rbp), %xmm0        # xmm0 = mem[0],zero
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
.Lcfi316:
	.cfi_def_cfa_offset 16
.Lcfi317:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi318:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$72, %rsp
.Lcfi319:
	.cfi_offset %rbx, -24
	movq	%rdi, -24(%rbp)
	movq	%rsi, -40(%rbp)
	movl	$0, -12(%rbp)
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -32(%rbp)
	leaq	-32(%rbp), %rbx
	.p2align	4, 0x90
.LBB97_1:                               # %do.body1
                                        # =>This Inner Loop Header: Depth=1
	movq	%rbx, %rdi
	callq	uInt64_qrm10
	movl	%eax, -44(%rbp)
	addl	$48, %eax
	movslq	-12(%rbp), %rcx
	movb	%al, -80(%rbp,%rcx)
	incl	-12(%rbp)
	movq	%rbx, %rdi
	callq	uInt64_isZero
	testb	%al, %al
	je	.LBB97_1
# BB#2:                                 # %do.end13
	movq	-24(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movb	$0, (%rax,%rcx)
	movl	$0, -16(%rbp)
	jmp	.LBB97_3
	.p2align	4, 0x90
.LBB97_4:                               # %for.body18
                                        #   in Loop: Header=BB97_3 Depth=1
	movslq	-12(%rbp), %rax
	movslq	-16(%rbp), %rcx
	subq	%rcx, %rax
	movzbl	-81(%rbp,%rax), %eax
	movq	-24(%rbp), %rdx
	movb	%al, (%rdx,%rcx)
	incl	-16(%rbp)
.LBB97_3:                               # %for.cond16
                                        # =>This Inner Loop Header: Depth=1
	movl	-16(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jl	.LBB97_4
# BB#5:                                 # %for.end
	addq	$72, %rsp
	popq	%rbx
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
.Lcfi320:
	.cfi_def_cfa_offset 16
.Lcfi321:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi322:
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
.Lcfi323:
	.cfi_def_cfa_offset 16
.Lcfi324:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi325:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -24(%rbp)
	movl	$0, -12(%rbp)
	movl	$7, -4(%rbp)
	movl	$3435973837, %ecx       # imm = 0xCCCCCCCD
	jmp	.LBB99_1
	.p2align	4, 0x90
.LBB99_2:                               # %for.body3
                                        #   in Loop: Header=BB99_1 Depth=1
	shll	$8, %eax
	movq	-24(%rbp), %rdx
	movslq	-4(%rbp), %rsi
	movzbl	(%rdx,%rsi), %edx
	orl	%eax, %edx
	movl	%edx, -8(%rbp)
	movl	-8(%rbp), %eax
	imulq	%rcx, %rax
	shrq	$35, %rax
	movq	-24(%rbp), %rdx
	movslq	-4(%rbp), %rsi
	movb	%al, (%rdx,%rsi)
	movl	-8(%rbp), %eax
	movq	%rax, %rdx
	imulq	%rcx, %rdx
	shrq	$35, %rdx
	addl	%edx, %edx
	leal	(%rdx,%rdx,4), %edx
	subl	%edx, %eax
	movl	%eax, -12(%rbp)
	decl	-4(%rbp)
.LBB99_1:                               # %for.cond1
                                        # =>This Inner Loop Header: Depth=1
	movl	-12(%rbp), %eax
	cmpl	$0, -4(%rbp)
	jns	.LBB99_2
# BB#3:                                 # %for.end16
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
.Lcfi326:
	.cfi_def_cfa_offset 16
.Lcfi327:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi328:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movl	$0, -8(%rbp)
	cmpl	$7, -8(%rbp)
	jle	.LBB100_2
	jmp	.LBB100_4
	.p2align	4, 0x90
.LBB100_3:                              # %for.inc12
                                        #   in Loop: Header=BB100_2 Depth=1
	incl	-8(%rbp)
	cmpl	$7, -8(%rbp)
	jg	.LBB100_4
.LBB100_2:                              # %for.body3
                                        # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rax
	movslq	-8(%rbp), %rcx
	cmpb	$0, (%rax,%rcx)
	je	.LBB100_3
# BB#5:                                 # %if.then9
	movb	$0, -1(%rbp)
	xorl	%eax, %eax
	popq	%rbp
	retq
.LBB100_4:                              # %for.end
	movb	$1, -1(%rbp)
	movb	$1, %al
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
.Lcfi329:
	.cfi_def_cfa_offset 16
.Lcfi330:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi331:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$32, %rsp
.Lcfi332:
	.cfi_offset %rbx, -32
.Lcfi333:
	.cfi_offset %r14, -24
	movq	%rdi, -32(%rbp)
	movq	%rsi, -40(%rbp)
	movq	%rdx, -48(%rbp)
	movq	-32(%rbp), %rdi
	movq	-40(%rbp), %rsi
	callq	hasSuffix
	testb	%al, %al
	je	.LBB101_1
# BB#3:                                 # %if.end
	movq	-32(%rbp), %r14
	movq	%r14, %rdi
	callq	strlen
	movq	%rax, %rbx
	movq	-40(%rbp), %rdi
	callq	strlen
	subq	%rax, %rbx
	movb	$0, (%r14,%rbx)
	movq	-32(%rbp), %rdi
	movq	-48(%rbp), %rsi
	callq	strcat
	movb	$1, -17(%rbp)
	movb	$1, %al
	jmp	.LBB101_2
.LBB101_1:                              # %if.then
	movb	$0, -17(%rbp)
	xorl	%eax, %eax
.LBB101_2:                              # %if.then
	addq	$32, %rsp
	popq	%rbx
	popq	%r14
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
.Lcfi334:
	.cfi_def_cfa_offset 16
.Lcfi335:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi336:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$10088, %rsp            # imm = 0x2768
.Lcfi337:
	.cfi_offset %rbx, -56
.Lcfi338:
	.cfi_offset %r12, -48
.Lcfi339:
	.cfi_offset %r13, -40
.Lcfi340:
	.cfi_offset %r14, -32
.Lcfi341:
	.cfi_offset %r15, -24
	movq	%rdi, -64(%rbp)
	movq	%rsi, -56(%rbp)
	movq	$0, -88(%rbp)
	movl	$0, -92(%rbp)
	movl	$0, -76(%rbp)
	movq	-56(%rbp), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB102_29
# BB#1:                                 # %if.end
	movq	-64(%rbp), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB102_29
# BB#2:
	leaq	-48(%rbp), %r15
	leaq	-5120(%rbp), %r14
	leaq	-10128(%rbp), %rbx
	leaq	-92(%rbp), %r13
	xorl	%r12d, %r12d
.LBB102_3:                              # %while.body1
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB102_6 Depth 2
                                        #     Child Loop BB102_48 Depth 2
	movq	-64(%rbp), %rsi
	movl	verbosity(%rip), %edx
	movzbl	smallMode(%rip), %ecx
	movl	-92(%rbp), %r9d
	movq	%r15, %rdi
	movq	%r14, %r8
	callq	BZ2_bzReadOpen
	movq	%rax, -88(%rbp)
	testq	%rax, %rax
	je	.LBB102_43
# BB#4:                                 # %while.body1
                                        #   in Loop: Header=BB102_3 Depth=1
	movl	-48(%rbp), %eax
	testl	%eax, %eax
	jne	.LBB102_43
# BB#5:                                 # %if.end1011
                                        #   in Loop: Header=BB102_3 Depth=1
	incl	-76(%rbp)
	.p2align	4, 0x90
.LBB102_6:                              # %while.cond1114
                                        #   Parent Loop BB102_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$0, -48(%rbp)
	jne	.LBB102_42
# BB#7:                                 # %while.body1418
                                        #   in Loop: Header=BB102_6 Depth=2
	movq	-88(%rbp), %rsi
	movl	$5000, %ecx             # imm = 0x1388
	movq	%r15, %rdi
	movq	%rbx, %rdx
	callq	BZ2_bzRead
	movl	%eax, -68(%rbp)
	cmpl	$-5, -48(%rbp)
	je	.LBB102_22
# BB#8:                                 # %if.end2028
                                        #   in Loop: Header=BB102_6 Depth=2
	movl	-48(%rbp), %eax
	testl	%eax, %eax
	sete	%cl
	cmpl	$4, %eax
	sete	%al
	orb	%cl, %al
	cmpb	$1, %al
	jne	.LBB102_11
# BB#9:                                 # %if.end2028
                                        #   in Loop: Header=BB102_6 Depth=2
	movl	-68(%rbp), %eax
	testl	%eax, %eax
	jle	.LBB102_11
# BB#10:                                # %if.then2853
                                        #   in Loop: Header=BB102_6 Depth=2
	movslq	-68(%rbp), %rdx
	movq	-56(%rbp), %rcx
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	fwrite
.LBB102_11:                             # %if.end3258
                                        #   in Loop: Header=BB102_6 Depth=2
	movq	-56(%rbp), %rdi
	callq	ferror
	testl	%eax, %eax
	je	.LBB102_6
	jmp	.LBB102_29
	.p2align	4, 0x90
.LBB102_42:                             # %while.end22
                                        #   in Loop: Header=BB102_3 Depth=1
	cmpl	$4, -48(%rbp)
	jne	.LBB102_43
# BB#45:                                # %if.end4031
                                        #   in Loop: Header=BB102_3 Depth=1
	movq	-88(%rbp), %rsi
	movq	%r15, %rdi
	leaq	-104(%rbp), %rdx
	movq	%r13, %rcx
	callq	BZ2_bzReadGetUnused
	cmpl	$0, -48(%rbp)
	jne	.LBB102_52
# BB#46:                                # %if.end4440
                                        #   in Loop: Header=BB102_3 Depth=1
	movl	$0, -72(%rbp)
	cmpl	$0, -72(%rbp)
	jns	.LBB102_49
	.p2align	4, 0x90
.LBB102_48:                             # %for.body61
                                        #   Parent Loop BB102_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-104(%rbp), %rax
	movslq	-72(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -5120(%rbp,%rcx)
	incl	-72(%rbp)
	cmpl	$0, -72(%rbp)
	js	.LBB102_48
.LBB102_49:                             # %for.end66
                                        #   in Loop: Header=BB102_3 Depth=1
	movq	-88(%rbp), %rsi
	movq	%r15, %rdi
	callq	BZ2_bzReadClose
	cmpl	$0, -48(%rbp)
	jne	.LBB102_52
# BB#50:                                # %if.end5371
                                        #   in Loop: Header=BB102_3 Depth=1
	testb	%r12b, %r12b
	jne	.LBB102_3
# BB#51:                                # %land.lhs.true5673
                                        #   in Loop: Header=BB102_3 Depth=1
	movq	-64(%rbp), %rdi
	callq	myfeof
	testb	%al, %al
	je	.LBB102_3
	jmp	.LBB102_12
.LBB102_22:                             # %trycat35
	cmpb	$0, forceOverwrite(%rip)
	je	.LBB102_43
# BB#23:                                # %if.then96
	movq	-64(%rbp), %rdi
	callq	rewind
	leaq	-10128(%rbp), %rbx
	.p2align	4, 0x90
.LBB102_24:                             # %while.body97
                                        # =>This Inner Loop Header: Depth=1
	movq	-64(%rbp), %rdi
	callq	myfeof
	testb	%al, %al
	jne	.LBB102_12
# BB#25:                                # %if.end101
                                        #   in Loop: Header=BB102_24 Depth=1
	movq	-64(%rbp), %rcx
	movl	$1, %esi
	movl	$5000, %edx             # imm = 0x1388
	movq	%rbx, %rdi
	callq	fread
	movl	%eax, -68(%rbp)
	movq	-64(%rbp), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB102_29
# BB#26:                                # %if.end108
                                        #   in Loop: Header=BB102_24 Depth=1
	cmpl	$0, -68(%rbp)
	jle	.LBB102_28
# BB#27:                                # %if.then111
                                        #   in Loop: Header=BB102_24 Depth=1
	movslq	-68(%rbp), %rdx
	movq	-56(%rbp), %rcx
	movl	$1, %esi
	movq	%rbx, %rdi
	callq	fwrite
.LBB102_28:                             # %if.end115
                                        #   in Loop: Header=BB102_24 Depth=1
	movq	-56(%rbp), %rdi
	callq	ferror
	testl	%eax, %eax
	je	.LBB102_24
.LBB102_29:                             # %errhandler_io
	callq	ioError
.LBB102_12:                             # %closeok
	movq	-64(%rbp), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB102_29
# BB#13:                                # %if.end66
	movq	-64(%rbp), %rdi
	callq	fclose
	movl	%eax, -80(%rbp)
	cmpl	$-1, %eax
	je	.LBB102_29
# BB#14:                                # %if.end71
	movq	-56(%rbp), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB102_29
# BB#15:                                # %if.end75
	movq	-56(%rbp), %rdi
	callq	fflush
	movl	%eax, -80(%rbp)
	testl	%eax, %eax
	jne	.LBB102_29
# BB#16:                                # %if.end80
	movq	-56(%rbp), %rax
	cmpq	stdout(%rip), %rax
	je	.LBB102_18
# BB#17:                                # %if.then83
	movq	-56(%rbp), %rdi
	callq	fclose
	movl	%eax, -80(%rbp)
	movq	$0, outputHandleJustInCase(%rip)
	cmpl	$-1, -80(%rbp)
	je	.LBB102_29
.LBB102_18:                             # %if.end89
	movq	$0, outputHandleJustInCase(%rip)
	cmpl	$2, verbosity(%rip)
	jl	.LBB102_20
# BB#19:                                # %if.then92
	movq	stderr(%rip), %rdi
	movl	$.L.str.130, %esi
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB102_20
.LBB102_43:                             # %errhandler13
	movq	-88(%rbp), %rsi
	leaq	-108(%rbp), %rdi
	callq	BZ2_bzReadClose
	movl	-48(%rbp), %eax
	addl	$9, %eax
	cmpl	$6, %eax
	ja	.LBB102_41
# BB#44:                                # %errhandler13
	jmpq	*.LJTI102_0(,%rax,8)
.LBB102_33:                             # %sw.bb126
	movq	-64(%rbp), %rax
	cmpq	stdin(%rip), %rax
	je	.LBB102_35
# BB#34:                                # %if.then129
	movq	-64(%rbp), %rdi
	callq	fclose
.LBB102_35:                             # %if.end131
	movq	-56(%rbp), %rax
	cmpq	stdout(%rip), %rax
	je	.LBB102_37
# BB#36:                                # %if.then134
	movq	-56(%rbp), %rdi
	callq	fclose
.LBB102_37:                             # %if.end136
	cmpl	$1, -76(%rbp)
	jne	.LBB102_39
# BB#38:                                # %if.then139
	movb	$0, -41(%rbp)
	xorl	%eax, %eax
	jmp	.LBB102_21
.LBB102_39:                             # %if.else
	cmpb	$0, noisy(%rip)
	je	.LBB102_20
# BB#40:                                # %if.then141
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.131, %esi
	movl	$inName, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB102_20:                             # %if.end94
	movb	$1, -41(%rbp)
	movb	$1, %al
.LBB102_21:                             # %if.end94
	addq	$10088, %rsp            # imm = 0x2768
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB102_52:                             # %if.then52
	movl	$.L.str.129, %edi
	callq	panic
.LBB102_41:                             # %sw.default
	movl	$.L.str.132, %edi
	callq	panic
.LBB102_32:                             # %sw.bb125
	callq	compressedStreamEOF
.LBB102_30:                             # %sw.bb123
	callq	crcError
.LBB102_31:                             # %sw.bb124
	callq	outOfMemory
.Lfunc_end102:
	.size	uncompressStream, .Lfunc_end102-uncompressStream
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	3
.LJTI102_0:
	.quad	.LBB102_33
	.quad	.LBB102_41
	.quad	.LBB102_32
	.quad	.LBB102_29
	.quad	.LBB102_33
	.quad	.LBB102_30
	.quad	.LBB102_31

	.text
	.p2align	4, 0x90
	.type	crcError,@function
crcError:                               # @crcError
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi342:
	.cfi_def_cfa_offset 16
.Lcfi343:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi344:
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
.Lcfi345:
	.cfi_def_cfa_offset 16
.Lcfi346:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi347:
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
.Lcfi348:
	.cfi_def_cfa_offset 16
.Lcfi349:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi350:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$10072, %rsp            # imm = 0x2758
.Lcfi351:
	.cfi_offset %rbx, -56
.Lcfi352:
	.cfi_offset %r12, -48
.Lcfi353:
	.cfi_offset %r13, -40
.Lcfi354:
	.cfi_offset %r14, -32
.Lcfi355:
	.cfi_offset %r15, -24
	movq	%rdi, -56(%rbp)
	movq	$0, -72(%rbp)
	movl	$0, -76(%rbp)
	movl	$0, -64(%rbp)
	movq	-56(%rbp), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB105_14
# BB#1:
	leaq	-48(%rbp), %rbx
	leaq	-5104(%rbp), %r14
	leaq	-10112(%rbp), %r15
	leaq	-76(%rbp), %r13
	xorl	%r12d, %r12d
.LBB105_2:                              # %while.body1
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB105_5 Depth 2
                                        #     Child Loop BB105_34 Depth 2
	movq	-56(%rbp), %rsi
	movl	verbosity(%rip), %edx
	movzbl	smallMode(%rip), %ecx
	movl	-76(%rbp), %r9d
	movq	%rbx, %rdi
	movq	%r14, %r8
	callq	BZ2_bzReadOpen
	movq	%rax, -72(%rbp)
	testq	%rax, %rax
	je	.LBB105_28
# BB#3:                                 # %while.body1
                                        #   in Loop: Header=BB105_2 Depth=1
	movl	-48(%rbp), %eax
	testl	%eax, %eax
	jne	.LBB105_28
# BB#4:                                 # %if.end611
                                        #   in Loop: Header=BB105_2 Depth=1
	incl	-64(%rbp)
	.p2align	4, 0x90
.LBB105_5:                              # %while.cond715
                                        #   Parent Loop BB105_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$0, -48(%rbp)
	jne	.LBB105_27
# BB#6:                                 # %while.body1020
                                        #   in Loop: Header=BB105_5 Depth=2
	movq	-72(%rbp), %rsi
	movl	$5000, %ecx             # imm = 0x1388
	movq	%rbx, %rdi
	movq	%r15, %rdx
	callq	BZ2_bzRead
	movl	%eax, -92(%rbp)
	cmpl	$-5, -48(%rbp)
	jne	.LBB105_5
	jmp	.LBB105_28
	.p2align	4, 0x90
.LBB105_27:                             # %while.end24
                                        #   in Loop: Header=BB105_2 Depth=1
	cmpl	$4, -48(%rbp)
	jne	.LBB105_28
# BB#31:                                # %if.end2030
                                        #   in Loop: Header=BB105_2 Depth=1
	movq	-72(%rbp), %rsi
	movq	%rbx, %rdi
	leaq	-88(%rbp), %rdx
	movq	%r13, %rcx
	callq	BZ2_bzReadGetUnused
	cmpl	$0, -48(%rbp)
	jne	.LBB105_38
# BB#32:                                # %if.end2434
                                        #   in Loop: Header=BB105_2 Depth=1
	movl	$0, -60(%rbp)
	cmpl	$0, -60(%rbp)
	jns	.LBB105_35
	.p2align	4, 0x90
.LBB105_34:                             # %for.body42
                                        #   Parent Loop BB105_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-88(%rbp), %rax
	movslq	-60(%rbp), %rcx
	movzbl	(%rax,%rcx), %eax
	movb	%al, -5104(%rbp,%rcx)
	incl	-60(%rbp)
	cmpl	$0, -60(%rbp)
	js	.LBB105_34
.LBB105_35:                             # %for.end47
                                        #   in Loop: Header=BB105_2 Depth=1
	movq	-72(%rbp), %rsi
	movq	%rbx, %rdi
	callq	BZ2_bzReadClose
	cmpl	$0, -48(%rbp)
	jne	.LBB105_38
# BB#36:                                # %if.end3351
                                        #   in Loop: Header=BB105_2 Depth=1
	testb	%r12b, %r12b
	jne	.LBB105_2
# BB#37:                                # %land.lhs.true53
                                        #   in Loop: Header=BB105_2 Depth=1
	movq	-56(%rbp), %rdi
	callq	myfeof
	testb	%al, %al
	je	.LBB105_2
# BB#7:                                 # %while.end41
	movq	-56(%rbp), %rdi
	callq	ferror
	testl	%eax, %eax
	jne	.LBB105_14
# BB#8:                                 # %if.end45
	movq	-56(%rbp), %rdi
	callq	fclose
	movl	%eax, -96(%rbp)
	cmpl	$-1, %eax
	je	.LBB105_14
# BB#9:                                 # %if.end50
	cmpl	$2, verbosity(%rip)
	jl	.LBB105_12
# BB#10:                                # %if.then53
	movq	stderr(%rip), %rdi
	movl	$.L.str.130, %esi
	jmp	.LBB105_11
.LBB105_28:                             # %errhandler13
	movq	-72(%rbp), %rsi
	leaq	-100(%rbp), %rdi
	callq	BZ2_bzReadClose
	cmpl	$0, verbosity(%rip)
	jne	.LBB105_29
# BB#26:                                # %if.then5817
	movq	stderr(%rip), %rdi
	movq	progName(%rip), %rdx
	movl	$.L.str.140, %esi
	movl	$inName, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB105_29:                             # %if.end6026
	movl	-48(%rbp), %eax
	addl	$9, %eax
	cmpl	$6, %eax
	ja	.LBB105_25
# BB#30:                                # %if.end6026
	jmpq	*.LJTI105_0(,%rax,8)
.LBB105_19:                             # %sw.bb67
	movq	-56(%rbp), %rax
	cmpq	stdin(%rip), %rax
	je	.LBB105_21
# BB#20:                                # %if.then70
	movq	-56(%rbp), %rdi
	callq	fclose
.LBB105_21:                             # %if.end72
	cmpl	$1, -64(%rbp)
	jne	.LBB105_23
# BB#22:                                # %if.then75
	movq	stderr(%rip), %rdi
	movl	$.L.str.143, %esi
	jmp	.LBB105_16
.LBB105_18:                             # %sw.bb65
	movq	stderr(%rip), %rdi
	movl	$.L.str.142, %esi
	jmp	.LBB105_16
.LBB105_15:                             # %sw.bb62
	movq	stderr(%rip), %rdi
	movl	$.L.str.141, %esi
.LBB105_16:                             # %sw.bb62
	xorl	%eax, %eax
	callq	fprintf
	movb	$0, -41(%rbp)
	xorl	%eax, %eax
	jmp	.LBB105_13
.LBB105_23:                             # %if.else
	cmpb	$0, noisy(%rip)
	je	.LBB105_12
# BB#24:                                # %if.then78
	movq	stderr(%rip), %rdi
	movl	$.L.str.144, %esi
.LBB105_11:                             # %if.end55
	xorl	%eax, %eax
	callq	fprintf
.LBB105_12:                             # %if.end55
	movb	$1, -41(%rbp)
	movb	$1, %al
.LBB105_13:                             # %if.end55
	addq	$10072, %rsp            # imm = 0x2758
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB105_38:                             # %if.then32
	movl	$.L.str.139, %edi
	callq	panic
.LBB105_14:                             # %errhandler_io
	callq	ioError
.LBB105_25:                             # %sw.default
	movl	$.L.str.145, %edi
	callq	panic
.LBB105_17:                             # %sw.bb64
	callq	outOfMemory
.Lfunc_end105:
	.size	testStream, .Lfunc_end105-testStream
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	3
.LJTI105_0:
	.quad	.LBB105_19
	.quad	.LBB105_25
	.quad	.LBB105_18
	.quad	.LBB105_14
	.quad	.LBB105_19
	.quad	.LBB105_15
	.quad	.LBB105_17

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
