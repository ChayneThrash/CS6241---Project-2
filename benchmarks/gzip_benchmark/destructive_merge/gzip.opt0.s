	.text
	.file	"gzip.opt0.bc"
	.globl	bi_init
	.p2align	4, 0x90
	.type	bi_init,@function
bi_init:                                # @bi_init
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
	movl	%edi, -4(%rbp)
	movl	%edi, zfile(%rip)
	movw	$0, bi_buf(%rip)
	movl	$0, bi_valid(%rip)
	cmpl	$-1, zfile(%rip)
	je	.LBB0_2
# BB#1:                                 # %if.then
	movq	$file_read, read_buf(%rip)
.LBB0_2:                                # %if.end
	popq	%rbp
	retq
.Lfunc_end0:
	.size	bi_init, .Lfunc_end0-bi_init
	.cfi_endproc

	.globl	file_read
	.p2align	4, 0x90
	.type	file_read,@function
file_read:                              # @file_read
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
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movl	%esi, -12(%rbp)
	movl	ifd(%rip), %edi
	movq	-24(%rbp), %rsi
	movl	-12(%rbp), %edx
	callq	read
	movl	%eax, -4(%rbp)
	testl	%eax, %eax
	je	.LBB1_4
# BB#1:                                 # %if.end
	cmpl	$-1, -4(%rbp)
	je	.LBB1_2
# BB#3:                                 # %if.end6
	movq	-24(%rbp), %rdi
	movl	-4(%rbp), %esi
	callq	updcrc
	movq	%rax, crc(%rip)
	movl	-4(%rbp), %eax
	addq	%rax, bytes_in(%rip)
.LBB1_4:                                # %return
	movl	-4(%rbp), %eax
	movl	%eax, -8(%rbp)
	jmp	.LBB1_5
.LBB1_2:                                # %if.then5
	callq	read_error
	movl	$-1, -8(%rbp)
.LBB1_5:                                # %return
	movl	-8(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	retq
.Lfunc_end1:
	.size	file_read, .Lfunc_end1-file_read
	.cfi_endproc

	.globl	send_bits
	.p2align	4, 0x90
	.type	send_bits,@function
send_bits:                              # @send_bits
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
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movl	$16, %eax
	subl	%esi, %eax
	cmpl	%eax, bi_valid(%rip)
	jle	.LBB2_8
# BB#1:                                 # %if.then
	movl	-4(%rbp), %eax
	movb	bi_valid(%rip), %cl
	shll	%cl, %eax
	movzwl	bi_buf(%rip), %ecx
	orl	%eax, %ecx
	movw	%cx, bi_buf(%rip)
	cmpl	$16381, outcnt(%rip)    # imm = 0x3FFD
	ja	.LBB2_3
# BB#2:                                 # %if.then4
	movb	bi_buf(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	movb	bi_buf+1(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	jmp	.LBB2_7
.LBB2_8:                                # %if.else42
	movl	-4(%rbp), %eax
	movb	bi_valid(%rip), %cl
	shll	%cl, %eax
	movzwl	bi_buf(%rip), %ecx
	orl	%eax, %ecx
	movw	%cx, bi_buf(%rip)
	movl	-8(%rbp), %eax
	addl	%eax, bi_valid(%rip)
	jmp	.LBB2_9
.LBB2_3:                                # %if.else
	movb	bi_buf(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB2_5
# BB#4:                                 # %if.then20
	callq	flush_outbuf
.LBB2_5:                                # %if.end
	movb	bi_buf+1(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB2_7
# BB#6:                                 # %if.then29
	callq	flush_outbuf
.LBB2_7:                                # %if.end31
	movzwl	-4(%rbp), %eax
	movl	$16, %ecx
	subl	bi_valid(%rip), %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movw	%ax, bi_buf(%rip)
	movl	-8(%rbp), %eax
	movl	bi_valid(%rip), %ecx
	leal	-16(%rcx,%rax), %eax
	movl	%eax, bi_valid(%rip)
.LBB2_9:                                # %if.end48
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end2:
	.size	send_bits, .Lfunc_end2-send_bits
	.cfi_endproc

	.globl	flush_outbuf
	.p2align	4, 0x90
	.type	flush_outbuf,@function
flush_outbuf:                           # @flush_outbuf
	.cfi_startproc
# BB#0:                                 # %entry
	cmpl	$0, outcnt(%rip)
	je	.LBB3_2
# BB#1:                                 # %if.end
	pushq	%rbp
.Lcfi9:
	.cfi_def_cfa_offset 16
.Lcfi10:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi11:
	.cfi_def_cfa_register %rbp
	movl	ofd(%rip), %edi
	movl	outcnt(%rip), %edx
	movl	$outbuf, %esi
	callq	write_buf
	movl	outcnt(%rip), %eax
	addq	%rax, bytes_out(%rip)
	movl	$0, outcnt(%rip)
	popq	%rbp
.LBB3_2:                                # %return
	retq
.Lfunc_end3:
	.size	flush_outbuf, .Lfunc_end3-flush_outbuf
	.cfi_endproc

	.globl	bi_reverse
	.p2align	4, 0x90
	.type	bi_reverse,@function
bi_reverse:                             # @bi_reverse
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi12:
	.cfi_def_cfa_offset 16
.Lcfi13:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi14:
	.cfi_def_cfa_register %rbp
	movl	%edi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	$0, -4(%rbp)
	.p2align	4, 0x90
.LBB4_1:                                # %do.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	-8(%rbp), %eax
	andl	$1, %eax
	orl	%eax, -4(%rbp)
	shrl	-8(%rbp)
	shll	-4(%rbp)
	decl	-12(%rbp)
	jg	.LBB4_1
# BB#2:                                 # %do.end
	movl	-4(%rbp), %eax
	shrl	%eax
	popq	%rbp
	retq
.Lfunc_end4:
	.size	bi_reverse, .Lfunc_end4-bi_reverse
	.cfi_endproc

	.globl	bi_windup
	.p2align	4, 0x90
	.type	bi_windup,@function
bi_windup:                              # @bi_windup
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
	cmpl	$9, bi_valid(%rip)
	jl	.LBB5_6
# BB#1:                                 # %if.then
	cmpl	$16381, outcnt(%rip)    # imm = 0x3FFD
	ja	.LBB5_3
# BB#2:                                 # %if.then2
	movb	bi_buf(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	movb	bi_buf+1(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	jmp	.LBB5_10
.LBB5_6:                                # %if.else29
	cmpl	$0, bi_valid(%rip)
	jle	.LBB5_10
# BB#7:                                 # %if.then32
	movb	bi_buf(%rip), %al
	jmp	.LBB5_8
.LBB5_3:                                # %if.else
	movb	bi_buf(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB5_5
# BB#4:                                 # %if.then17
	callq	flush_outbuf
.LBB5_5:                                # %if.end
	movb	bi_buf+1(%rip), %al
.LBB5_8:                                # %if.then32
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB5_10
# BB#9:                                 # %if.then39
	callq	flush_outbuf
.LBB5_10:                               # %if.end42
	movw	$0, bi_buf(%rip)
	movl	$0, bi_valid(%rip)
	popq	%rbp
	retq
.Lfunc_end5:
	.size	bi_windup, .Lfunc_end5-bi_windup
	.cfi_endproc

	.globl	copy_block
	.p2align	4, 0x90
	.type	copy_block,@function
copy_block:                             # @copy_block
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi18:
	.cfi_def_cfa_offset 16
.Lcfi19:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi20:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -16(%rbp)
	movl	%esi, -4(%rbp)
	movl	%edx, -8(%rbp)
	callq	bi_windup
	cmpl	$0, -8(%rbp)
	je	.LBB6_14
# BB#1:                                 # %if.then
	cmpl	$16381, outcnt(%rip)    # imm = 0x3FFD
	ja	.LBB6_3
# BB#2:                                 # %if.then1
	movb	-4(%rbp), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	movb	-3(%rbp), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16381, outcnt(%rip)    # imm = 0x3FFD
	jbe	.LBB6_8
	jmp	.LBB6_9
.LBB6_3:                                # %if.else
	movb	-4(%rbp), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB6_5
# BB#4:                                 # %if.then19
	callq	flush_outbuf
.LBB6_5:                                # %if.end
	movb	-3(%rbp), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB6_7
# BB#6:                                 # %if.then29
	callq	flush_outbuf
.LBB6_7:                                # %if.end31
	cmpl	$16381, outcnt(%rip)    # imm = 0x3FFD
	ja	.LBB6_9
.LBB6_8:                                # %if.then34
	movl	-4(%rbp), %eax
	notl	%eax
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	movl	-4(%rbp), %eax
	notl	%eax
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%ah, outbuf(%rcx)  # NOREX
	jmp	.LBB6_14
.LBB6_9:                                # %if.else50
	movl	-4(%rbp), %eax
	notl	%eax
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB6_11
# BB#10:                                # %if.then61
	callq	flush_outbuf
.LBB6_11:                               # %if.end62
	movl	-4(%rbp), %eax
	notl	%eax
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%ah, outbuf(%rcx)  # NOREX
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB6_14
.LBB6_13:                               # %if.then73
	callq	flush_outbuf
.LBB6_14:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	leal	-1(%rax), %ecx
	movl	%ecx, -4(%rbp)
	testl	%eax, %eax
	je	.LBB6_16
# BB#15:                                # %while.body
                                        #   in Loop: Header=BB6_14 Depth=1
	movq	-16(%rbp), %rax
	leaq	1(%rax), %rcx
	movq	%rcx, -16(%rbp)
	movzbl	(%rax), %eax
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	je	.LBB6_13
	jmp	.LBB6_14
.LBB6_16:                               # %while.end
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end6:
	.size	copy_block, .Lfunc_end6-copy_block
	.cfi_endproc

	.globl	lm_init
	.p2align	4, 0x90
	.type	lm_init,@function
lm_init:                                # @lm_init
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi21:
	.cfi_def_cfa_offset 16
.Lcfi22:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi23:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	%edi, -8(%rbp)
	movq	%rsi, -24(%rbp)
	cmpl	$0, -8(%rbp)
	jle	.LBB7_2
# BB#1:                                 # %lor.lhs.false
	cmpl	$10, -8(%rbp)
	jl	.LBB7_3
.LBB7_2:                                # %if.then
	movl	$.L.str, %edi
	callq	error
.LBB7_3:                                # %if.end
	movl	-8(%rbp), %eax
	movl	%eax, compr_level(%rip)
	movl	$prev+65536, %edi
	xorl	%esi, %esi
	movl	$65536, %edx            # imm = 0x10000
	callq	memset
	movl	$4294967295, %eax       # imm = 0xFFFFFFFF
	movq	%rax, rsync_chunk_end(%rip)
	movq	$0, rsync_sum(%rip)
	movslq	-8(%rbp), %rax
	movzwl	configuration_table+2(,%rax,8), %eax
	movl	%eax, max_lazy_match(%rip)
	movslq	-8(%rbp), %rax
	movzwl	configuration_table(,%rax,8), %eax
	movl	%eax, good_match(%rip)
	movslq	-8(%rbp), %rax
	movzwl	configuration_table+4(,%rax,8), %eax
	movl	%eax, nice_match(%rip)
	movslq	-8(%rbp), %rax
	movzwl	configuration_table+6(,%rax,8), %eax
	movl	%eax, max_chain_length(%rip)
	cmpl	$1, -8(%rbp)
	jne	.LBB7_5
# BB#4:                                 # %if.then13
	movq	-24(%rbp), %rax
	movzwl	(%rax), %ecx
	orl	$4, %ecx
	jmp	.LBB7_7
.LBB7_5:                                # %if.else
	cmpl	$9, -8(%rbp)
	jne	.LBB7_8
# BB#6:                                 # %if.then18
	movq	-24(%rbp), %rax
	movzwl	(%rax), %ecx
	orl	$2, %ecx
.LBB7_7:                                # %if.end23
	movw	%cx, (%rax)
.LBB7_8:                                # %if.end23
	movl	$0, strstart(%rip)
	movq	$0, block_start(%rip)
	movl	$window, %edi
	movl	$65536, %esi            # imm = 0x10000
	callq	*read_buf(%rip)
	movl	%eax, lookahead(%rip)
	testl	%eax, %eax
	je	.LBB7_10
# BB#9:                                 # %lor.lhs.false26
	cmpl	$-1, lookahead(%rip)
	je	.LBB7_10
# BB#12:                                # %if.end30
	movl	$0, eofile(%rip)
	cmpl	$262, lookahead(%rip)   # imm = 0x106
	jb	.LBB7_15
	jmp	.LBB7_14
	.p2align	4, 0x90
.LBB7_17:                               # %while.body
	callq	fill_window
	cmpl	$262, lookahead(%rip)   # imm = 0x106
	jae	.LBB7_14
.LBB7_15:                               # %land.rhs
	cmpl	$0, eofile(%rip)
	sete	-13(%rbp)
	sete	-1(%rbp)
	cmpb	$1, -1(%rbp)
	je	.LBB7_17
	jmp	.LBB7_18
	.p2align	4, 0x90
.LBB7_14:                               # %while.cond.land.end_crit_edge
	movb	$0, -1(%rbp)
	cmpb	$1, -1(%rbp)
	je	.LBB7_17
.LBB7_18:                               # %while.end
	movl	$0, ins_h(%rip)
	movl	$0, -12(%rbp)
	cmpl	$1, -12(%rbp)
	ja	.LBB7_11
	.p2align	4, 0x90
.LBB7_20:                               # %for.inc
                                        # =>This Inner Loop Header: Depth=1
	movl	ins_h(%rip), %eax
	shll	$5, %eax
	movl	-12(%rbp), %ecx
	movzbl	window(%rcx), %ecx
	xorl	%eax, %ecx
	andl	$32767, %ecx            # imm = 0x7FFF
	movl	%ecx, ins_h(%rip)
	incl	-12(%rbp)
	cmpl	$1, -12(%rbp)
	jbe	.LBB7_20
	jmp	.LBB7_11
.LBB7_10:                               # %if.then29
	movl	$1, eofile(%rip)
	movl	$0, lookahead(%rip)
.LBB7_11:                               # %for.end
	addq	$32, %rsp
	popq	%rbp
	retq
.Lfunc_end7:
	.size	lm_init, .Lfunc_end7-lm_init
	.cfi_endproc

	.globl	error
	.p2align	4, 0x90
	.type	error,@function
error:                                  # @error
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
	subq	$16, %rsp
	movq	%rdi, %r8
	movq	%r8, -8(%rbp)
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.73, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	callq	abort_gzip
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end8:
	.size	error, .Lfunc_end8-error
	.cfi_endproc

	.p2align	4, 0x90
	.type	fill_window,@function
fill_window:                            # @fill_window
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi27:
	.cfi_def_cfa_offset 16
.Lcfi28:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi29:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	window_size(%rip), %eax
	subl	lookahead(%rip), %eax
	subl	strstart(%rip), %eax
	movl	%eax, -8(%rbp)
	cmpl	$-1, %eax
	je	.LBB9_1
# BB#2:                                 # %if.else
	cmpl	$65274, strstart(%rip)  # imm = 0xFEFA
	jb	.LBB9_18
# BB#3:                                 # %if.then7
	movl	$window, %edi
	movl	$window+32768, %esi
	movl	$32768, %edx            # imm = 0x8000
	callq	memcpy
	addl	$-32768, match_start(%rip) # imm = 0x8000
	addl	$-32768, strstart(%rip) # imm = 0x8000
	movl	$4294967295, %eax       # imm = 0xFFFFFFFF
	cmpq	%rax, rsync_chunk_end(%rip)
	je	.LBB9_5
# BB#4:                                 # %if.then12
	addq	$-32768, rsync_chunk_end(%rip) # imm = 0x8000
.LBB9_5:                                # %if.end
	addq	$-32768, block_start(%rip) # imm = 0x8000
	movl	$0, -4(%rbp)
	movl	$-32768, %eax           # imm = 0x8000
	cmpl	$32767, -4(%rbp)        # imm = 0x7FFF
	jbe	.LBB9_7
	jmp	.LBB9_11
	.p2align	4, 0x90
.LBB9_10:                               # %for.inc
                                        #   in Loop: Header=BB9_7 Depth=1
	movzwl	-16(%rbp), %ecx
	movl	-4(%rbp), %edx
	movw	%cx, prev+65536(%rdx,%rdx)
	incl	-4(%rbp)
	cmpl	$32767, -4(%rbp)        # imm = 0x7FFF
	ja	.LBB9_11
.LBB9_7:                                # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %ecx
	movzwl	prev+65536(%rcx,%rcx), %ecx
	movl	%ecx, -12(%rbp)
	testw	%cx, %cx
	jns	.LBB9_9
# BB#8:                                 # %cond.true
                                        #   in Loop: Header=BB9_7 Depth=1
	movl	-12(%rbp), %ecx
	addl	%eax, %ecx
	movl	%ecx, -24(%rbp)
	movl	%ecx, -16(%rbp)
	jmp	.LBB9_10
	.p2align	4, 0x90
.LBB9_9:                                # %cond.false
                                        #   in Loop: Header=BB9_7 Depth=1
	movl	$0, -16(%rbp)
	jmp	.LBB9_10
.LBB9_1:                                # %if.then
	decl	-8(%rbp)
	cmpl	$0, eofile(%rip)
	jne	.LBB9_23
	jmp	.LBB9_19
.LBB9_11:                               # %for.end
	movl	$0, -4(%rbp)
	movl	$-32768, %eax           # imm = 0x8000
	cmpl	$32767, -4(%rbp)        # imm = 0x7FFF
	jbe	.LBB9_13
	jmp	.LBB9_17
	.p2align	4, 0x90
.LBB9_16:                               # %for.inc41
                                        #   in Loop: Header=BB9_13 Depth=1
	movzwl	-20(%rbp), %ecx
	movl	-4(%rbp), %edx
	movw	%cx, prev(%rdx,%rdx)
	incl	-4(%rbp)
	cmpl	$32767, -4(%rbp)        # imm = 0x7FFF
	ja	.LBB9_17
.LBB9_13:                               # %for.body27
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %ecx
	movzwl	prev(%rcx,%rcx), %ecx
	movl	%ecx, -12(%rbp)
	testw	%cx, %cx
	jns	.LBB9_15
# BB#14:                                # %cond.true33
                                        #   in Loop: Header=BB9_13 Depth=1
	movl	-12(%rbp), %ecx
	addl	%eax, %ecx
	movl	%ecx, -28(%rbp)
	movl	%ecx, -20(%rbp)
	jmp	.LBB9_16
	.p2align	4, 0x90
.LBB9_15:                               # %cond.false35
                                        #   in Loop: Header=BB9_13 Depth=1
	movl	$0, -20(%rbp)
	jmp	.LBB9_16
.LBB9_17:                               # %for.end43
	addl	$32768, -8(%rbp)        # imm = 0x8000
.LBB9_18:                               # %if.end45
	cmpl	$0, eofile(%rip)
	jne	.LBB9_23
.LBB9_19:                               # %if.then46
	movl	strstart(%rip), %eax
	movl	lookahead(%rip), %ecx
	leaq	window(%rax,%rcx), %rdi
	movl	-8(%rbp), %esi
	callq	*read_buf(%rip)
	movl	%eax, -4(%rbp)
	testl	%eax, %eax
	je	.LBB9_21
# BB#20:                                # %lor.lhs.false
	cmpl	$-1, -4(%rbp)
	je	.LBB9_21
# BB#22:                                # %if.else54
	movl	-4(%rbp), %eax
	addl	%eax, lookahead(%rip)
	jmp	.LBB9_23
.LBB9_21:                               # %if.then53
	movl	$1, eofile(%rip)
.LBB9_23:                               # %if.end57
	addq	$32, %rsp
	popq	%rbp
	retq
.Lfunc_end9:
	.size	fill_window, .Lfunc_end9-fill_window
	.cfi_endproc

	.globl	longest_match
	.p2align	4, 0x90
	.type	longest_match,@function
longest_match:                          # @longest_match
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi30:
	.cfi_def_cfa_offset 16
.Lcfi31:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi32:
	.cfi_def_cfa_register %rbp
	movl	%edi, -40(%rbp)
	movl	max_chain_length(%rip), %eax
	movl	%eax, -56(%rbp)
	movl	strstart(%rip), %eax
	leaq	window(%rax), %rax
	movq	%rax, -16(%rbp)
	movl	prev_length(%rip), %eax
	movl	%eax, -36(%rbp)
	cmpl	$32507, strstart(%rip)  # imm = 0x7EFB
	jb	.LBB10_2
# BB#1:                                 # %cond.true
	movl	$-32506, %eax           # imm = 0x8106
	addl	strstart(%rip), %eax
	movl	%eax, -72(%rbp)
	movl	%eax, -52(%rbp)
	jmp	.LBB10_3
.LBB10_2:                               # %cond.false
	movl	$0, -52(%rbp)
.LBB10_3:                               # %cond.end
	movl	-52(%rbp), %eax
	movl	%eax, -68(%rbp)
	movl	strstart(%rip), %eax
	leaq	window+258(%rax), %rax
	movq	%rax, -64(%rbp)
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movb	-1(%rax,%rcx), %al
	movb	%al, -19(%rbp)
	movq	-16(%rbp), %rax
	movslq	-36(%rbp), %rcx
	movb	(%rax,%rcx), %al
	movb	%al, -18(%rbp)
	movl	prev_length(%rip), %eax
	cmpl	good_match(%rip), %eax
	jb	.LBB10_5
# BB#4:                                 # %if.then
	shrl	$2, -56(%rbp)
.LBB10_5:                               # %if.end
	movq	$-258, %rax             # imm = 0xFEFE
	.p2align	4, 0x90
.LBB10_6:                               # %do.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB10_11 Depth 2
	movl	-40(%rbp), %ecx
	leaq	window(%rcx), %rdx
	movq	%rdx, -32(%rbp)
	movslq	-36(%rbp), %rdx
	movzbl	window(%rcx,%rdx), %ecx
	movzbl	-18(%rbp), %edx
	cmpl	%edx, %ecx
	jne	.LBB10_32
# BB#7:                                 # %lor.lhs.false
                                        #   in Loop: Header=BB10_6 Depth=1
	movq	-32(%rbp), %rcx
	movslq	-36(%rbp), %rdx
	movzbl	-1(%rcx,%rdx), %ecx
	movzbl	-19(%rbp), %edx
	cmpl	%edx, %ecx
	jne	.LBB10_32
# BB#8:                                 # %lor.lhs.false22
                                        #   in Loop: Header=BB10_6 Depth=1
	movq	-32(%rbp), %rcx
	movzbl	(%rcx), %ecx
	movq	-16(%rbp), %rdx
	movzbl	(%rdx), %edx
	cmpl	%edx, %ecx
	jne	.LBB10_32
# BB#9:                                 # %lor.lhs.false27
                                        #   in Loop: Header=BB10_6 Depth=1
	movq	-32(%rbp), %rcx
	leaq	1(%rcx), %rdx
	movq	%rdx, -32(%rbp)
	movzbl	1(%rcx), %ecx
	movq	-16(%rbp), %rdx
	movzbl	1(%rdx), %edx
	cmpl	%edx, %ecx
	jne	.LBB10_32
# BB#10:                                # %if.end34
                                        #   in Loop: Header=BB10_6 Depth=1
	addq	$2, -16(%rbp)
	incq	-32(%rbp)
	.p2align	4, 0x90
.LBB10_11:                              # %do.cond
                                        #   Parent Loop BB10_6 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-16(%rbp), %rcx
	leaq	1(%rcx), %rdx
	movq	%rdx, -16(%rbp)
	movzbl	1(%rcx), %ecx
	movq	-32(%rbp), %rdx
	leaq	1(%rdx), %rsi
	movq	%rsi, -32(%rbp)
	movzbl	1(%rdx), %edx
	cmpl	%edx, %ecx
	jne	.LBB10_27
# BB#12:                                # %land.lhs.true
                                        #   in Loop: Header=BB10_11 Depth=2
	movq	-16(%rbp), %rcx
	leaq	1(%rcx), %rdx
	movq	%rdx, -16(%rbp)
	movzbl	1(%rcx), %ecx
	movq	-32(%rbp), %rdx
	leaq	1(%rdx), %rsi
	movq	%rsi, -32(%rbp)
	movzbl	1(%rdx), %edx
	cmpl	%edx, %ecx
	jne	.LBB10_27
# BB#13:                                # %land.lhs.true50
                                        #   in Loop: Header=BB10_11 Depth=2
	movq	-16(%rbp), %rcx
	leaq	1(%rcx), %rdx
	movq	%rdx, -16(%rbp)
	movzbl	1(%rcx), %ecx
	movq	-32(%rbp), %rdx
	leaq	1(%rdx), %rsi
	movq	%rsi, -32(%rbp)
	movzbl	1(%rdx), %edx
	cmpl	%edx, %ecx
	jne	.LBB10_27
# BB#14:                                # %land.lhs.true57
                                        #   in Loop: Header=BB10_11 Depth=2
	movq	-16(%rbp), %rcx
	leaq	1(%rcx), %rdx
	movq	%rdx, -16(%rbp)
	movzbl	1(%rcx), %ecx
	movq	-32(%rbp), %rdx
	leaq	1(%rdx), %rsi
	movq	%rsi, -32(%rbp)
	movzbl	1(%rdx), %edx
	cmpl	%edx, %ecx
	jne	.LBB10_27
# BB#15:                                # %land.lhs.true64
                                        #   in Loop: Header=BB10_11 Depth=2
	movq	-16(%rbp), %rcx
	leaq	1(%rcx), %rdx
	movq	%rdx, -16(%rbp)
	movzbl	1(%rcx), %ecx
	movq	-32(%rbp), %rdx
	leaq	1(%rdx), %rsi
	movq	%rsi, -32(%rbp)
	movzbl	1(%rdx), %edx
	cmpl	%edx, %ecx
	jne	.LBB10_27
# BB#16:                                # %land.lhs.true71
                                        #   in Loop: Header=BB10_11 Depth=2
	movq	-16(%rbp), %rcx
	leaq	1(%rcx), %rdx
	movq	%rdx, -16(%rbp)
	movzbl	1(%rcx), %ecx
	movq	-32(%rbp), %rdx
	leaq	1(%rdx), %rsi
	movq	%rsi, -32(%rbp)
	movzbl	1(%rdx), %edx
	cmpl	%edx, %ecx
	jne	.LBB10_27
# BB#17:                                # %land.lhs.true78
                                        #   in Loop: Header=BB10_11 Depth=2
	movq	-16(%rbp), %rcx
	leaq	1(%rcx), %rdx
	movq	%rdx, -16(%rbp)
	movzbl	1(%rcx), %ecx
	movq	-32(%rbp), %rdx
	leaq	1(%rdx), %rsi
	movq	%rsi, -32(%rbp)
	movzbl	1(%rdx), %edx
	cmpl	%edx, %ecx
	jne	.LBB10_27
# BB#18:                                # %land.lhs.true85
                                        #   in Loop: Header=BB10_11 Depth=2
	movq	-16(%rbp), %rcx
	leaq	1(%rcx), %rdx
	movq	%rdx, -16(%rbp)
	movzbl	1(%rcx), %ecx
	movq	-32(%rbp), %rdx
	leaq	1(%rdx), %rsi
	movq	%rsi, -32(%rbp)
	movzbl	1(%rdx), %edx
	cmpl	%edx, %ecx
	jne	.LBB10_27
# BB#19:                                # %land.rhs
                                        #   in Loop: Header=BB10_11 Depth=2
	movq	-16(%rbp), %rcx
	cmpq	-64(%rbp), %rcx
	setb	%cl
	movb	%cl, -45(%rbp)
	movb	%cl, -1(%rbp)
	jmp	.LBB10_28
	.p2align	4, 0x90
.LBB10_27:                              # %land.lhs.true85.land.end_crit_edge
                                        #   in Loop: Header=BB10_11 Depth=2
	movb	$0, -1(%rbp)
.LBB10_28:                              # %land.end
                                        #   in Loop: Header=BB10_11 Depth=2
	movzbl	-1(%rbp), %ecx
	testb	%cl, %cl
	jne	.LBB10_11
# BB#29:                                # %do.end
                                        #   in Loop: Header=BB10_6 Depth=1
	movl	-64(%rbp), %ecx
	subl	-16(%rbp), %ecx
	movl	$258, %edx              # imm = 0x102
	subl	%ecx, %edx
	movl	%edx, -44(%rbp)
	movq	-64(%rbp), %rcx
	addq	%rax, %rcx
	movq	%rcx, -16(%rbp)
	movl	-44(%rbp), %ecx
	cmpl	-36(%rbp), %ecx
	jle	.LBB10_32
# BB#30:                                # %if.then99
                                        #   in Loop: Header=BB10_6 Depth=1
	movl	-40(%rbp), %ecx
	movl	%ecx, match_start(%rip)
	movl	-44(%rbp), %ecx
	movl	%ecx, -36(%rbp)
	movl	-44(%rbp), %ecx
	cmpl	nice_match(%rip), %ecx
	jge	.LBB10_36
# BB#31:                                # %if.end103
                                        #   in Loop: Header=BB10_6 Depth=1
	movq	-16(%rbp), %rcx
	movslq	-36(%rbp), %rdx
	movb	-1(%rcx,%rdx), %cl
	movb	%cl, -19(%rbp)
	movq	-16(%rbp), %rcx
	movslq	-36(%rbp), %rdx
	movb	(%rcx,%rdx), %cl
	movb	%cl, -18(%rbp)
	.p2align	4, 0x90
.LBB10_32:                              # %do.cond110
                                        #   in Loop: Header=BB10_6 Depth=1
	movl	-40(%rbp), %ecx
	andl	$32767, %ecx            # imm = 0x7FFF
	movzwl	prev(%rcx,%rcx), %ecx
	movl	%ecx, -40(%rbp)
	cmpl	-68(%rbp), %ecx
	jbe	.LBB10_34
# BB#33:                                # %land.rhs116
                                        #   in Loop: Header=BB10_6 Depth=1
	decl	-56(%rbp)
	setne	-46(%rbp)
	setne	-17(%rbp)
	jmp	.LBB10_35
	.p2align	4, 0x90
.LBB10_34:                              # %do.cond110.land.end119_crit_edge
                                        #   in Loop: Header=BB10_6 Depth=1
	movb	$0, -17(%rbp)
.LBB10_35:                              # %land.end119
                                        #   in Loop: Header=BB10_6 Depth=1
	movb	-17(%rbp), %cl
	testb	%cl, %cl
	jne	.LBB10_6
.LBB10_36:                              # %do.end120
	movl	-36(%rbp), %eax
	popq	%rbp
	retq
.Lfunc_end10:
	.size	longest_match, .Lfunc_end10-longest_match
	.cfi_endproc

	.globl	deflate
	.p2align	4, 0x90
	.type	deflate,@function
deflate:                                # @deflate
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi33:
	.cfi_def_cfa_offset 16
.Lcfi34:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi35:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$112, %rsp
.Lcfi36:
	.cfi_offset %rbx, -32
.Lcfi37:
	.cfi_offset %r14, -24
	movl	$0, -32(%rbp)
	movl	$2, -28(%rbp)
	cmpl	$3, compr_level(%rip)
	jg	.LBB11_2
# BB#1:                                 # %if.then
	callq	deflate_fast
	jmp	.LBB11_56
.LBB11_2:                               # %if.end
	movq	$-262, %r14             # imm = 0xFEFA
	movl	$4294967295, %ebx       # imm = 0xFFFFFFFF
	jmp	.LBB11_3
	.p2align	4, 0x90
.LBB11_4:                               # %while.body
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	ins_h(%rip), %eax
	shll	$5, %eax
	movl	strstart(%rip), %ecx
	addl	$2, %ecx
	movzbl	window(%rcx), %ecx
	xorl	%eax, %ecx
	andl	$32767, %ecx            # imm = 0x7FFF
	movl	%ecx, ins_h(%rip)
	movl	ins_h(%rip), %eax
	movzwl	prev+65536(%rax,%rax), %eax
	movl	%eax, -36(%rbp)
	movl	strstart(%rip), %ecx
	andl	$32767, %ecx            # imm = 0x7FFF
	movw	%ax, prev(%rcx,%rcx)
	movzwl	strstart(%rip), %eax
	movl	ins_h(%rip), %ecx
	movw	%ax, prev+65536(%rcx,%rcx)
	movl	-28(%rbp), %eax
	movl	%eax, prev_length(%rip)
	movl	match_start(%rip), %eax
	movl	%eax, -44(%rbp)
	movl	$2, -28(%rbp)
	cmpl	$0, -36(%rbp)
	je	.LBB11_13
# BB#5:                                 # %land.lhs.true
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	prev_length(%rip), %eax
	cmpl	max_lazy_match(%rip), %eax
	jae	.LBB11_13
# BB#6:                                 # %land.lhs.true16
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	strstart(%rip), %eax
	subl	-36(%rbp), %eax
	cmpl	$32506, %eax            # imm = 0x7EFA
	ja	.LBB11_13
# BB#7:                                 # %land.lhs.true20
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	strstart(%rip), %eax
	movq	window_size(%rip), %rcx
	addq	%r14, %rcx
	cmpq	%rcx, %rax
	ja	.LBB11_13
# BB#8:                                 # %if.then25
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	-36(%rbp), %edi
	callq	longest_match
	movl	%eax, -28(%rbp)
	cmpl	lookahead(%rip), %eax
	jbe	.LBB11_10
# BB#9:                                 # %if.then29
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	lookahead(%rip), %eax
	movl	%eax, -28(%rbp)
.LBB11_10:                              # %if.end30
                                        #   in Loop: Header=BB11_3 Depth=1
	cmpl	$3, -28(%rbp)
	jne	.LBB11_13
# BB#11:                                # %land.lhs.true33
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	strstart(%rip), %eax
	subl	match_start(%rip), %eax
	cmpl	$4097, %eax             # imm = 0x1001
	jb	.LBB11_13
# BB#12:                                # %if.then37
                                        #   in Loop: Header=BB11_3 Depth=1
	decl	-28(%rbp)
	.p2align	4, 0x90
.LBB11_13:                              # %if.end39
                                        #   in Loop: Header=BB11_3 Depth=1
	cmpl	$3, prev_length(%rip)
	jb	.LBB11_26
# BB#14:                                # %land.lhs.true42
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	-28(%rbp), %eax
	cmpl	prev_length(%rip), %eax
	ja	.LBB11_26
# BB#15:                                # %do.body
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	strstart(%rip), %edi
	decl	%edi
	subl	-44(%rbp), %edi
	movl	prev_length(%rip), %esi
	addl	$-3, %esi
	callq	ct_tally
	movl	%eax, -24(%rbp)
	movl	prev_length(%rip), %eax
	decl	%eax
	subl	%eax, lookahead(%rip)
	addl	$-2, prev_length(%rip)
	cmpl	$0, rsync(%rip)
	je	.LBB11_17
# BB#16:                                # %if.then53
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	strstart(%rip), %edi
	movl	prev_length(%rip), %esi
	incl	%esi
	callq	rsync_roll
	.p2align	4, 0x90
.LBB11_17:                              # %do.cond
                                        #   Parent Loop BB11_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	strstart(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, strstart(%rip)
	movl	ins_h(%rip), %ecx
	shll	$5, %ecx
	addl	$3, %eax
	movzbl	window(%rax), %eax
	xorl	%ecx, %eax
	andl	$32767, %eax            # imm = 0x7FFF
	movl	%eax, ins_h(%rip)
	movl	ins_h(%rip), %eax
	movzwl	prev+65536(%rax,%rax), %eax
	movl	%eax, -36(%rbp)
	movl	strstart(%rip), %ecx
	andl	$32767, %ecx            # imm = 0x7FFF
	movw	%ax, prev(%rcx,%rcx)
	movzwl	strstart(%rip), %eax
	movl	ins_h(%rip), %ecx
	movw	%ax, prev+65536(%rcx,%rcx)
	decl	prev_length(%rip)
	jne	.LBB11_17
# BB#18:                                # %do.end78
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	$0, -32(%rbp)
	movl	$2, -28(%rbp)
	incl	strstart(%rip)
	cmpl	$0, rsync(%rip)
	je	.LBB11_21
# BB#19:                                # %land.lhs.true81
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	strstart(%rip), %eax
	cmpq	rsync_chunk_end(%rip), %rax
	jbe	.LBB11_21
# BB#20:                                # %if.then85
                                        #   in Loop: Header=BB11_3 Depth=1
	movq	%rbx, rsync_chunk_end(%rip)
	movl	$2, -24(%rbp)
.LBB11_21:                              # %if.end86
                                        #   in Loop: Header=BB11_3 Depth=1
	cmpl	$0, -24(%rbp)
	je	.LBB11_45
# BB#22:                                # %if.then88
                                        #   in Loop: Header=BB11_3 Depth=1
	cmpq	$0, block_start(%rip)
	js	.LBB11_24
# BB#23:                                # %cond.true
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	block_start(%rip), %eax
	leaq	window(%rax), %rax
	movq	%rax, -96(%rbp)
	movq	%rax, -56(%rbp)
	jmp	.LBB11_25
	.p2align	4, 0x90
.LBB11_26:                              # %if.else
                                        #   in Loop: Header=BB11_3 Depth=1
	cmpl	$0, -32(%rbp)
	je	.LBB11_35
# BB#27:                                # %if.then101
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	strstart(%rip), %eax
	decl	%eax
	movzbl	window(%rax), %esi
	xorl	%edi, %edi
	callq	ct_tally
	movl	%eax, -24(%rbp)
	cmpl	$0, rsync(%rip)
	je	.LBB11_30
# BB#28:                                # %land.lhs.true108
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	strstart(%rip), %eax
	cmpq	rsync_chunk_end(%rip), %rax
	jbe	.LBB11_30
# BB#29:                                # %if.then112
                                        #   in Loop: Header=BB11_3 Depth=1
	movq	%rbx, rsync_chunk_end(%rip)
	movl	$2, -24(%rbp)
.LBB11_30:                              # %if.end113
                                        #   in Loop: Header=BB11_3 Depth=1
	cmpl	$0, -24(%rbp)
	je	.LBB11_42
# BB#31:                                # %if.then115
                                        #   in Loop: Header=BB11_3 Depth=1
	cmpq	$0, block_start(%rip)
	js	.LBB11_33
# BB#32:                                # %cond.true118
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	block_start(%rip), %eax
	leaq	window(%rax), %rax
	movq	%rax, -104(%rbp)
	movq	%rax, -64(%rbp)
	jmp	.LBB11_34
	.p2align	4, 0x90
.LBB11_35:                              # %if.else139
                                        #   in Loop: Header=BB11_3 Depth=1
	cmpl	$0, rsync(%rip)
	je	.LBB11_41
# BB#36:                                # %land.lhs.true141
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	strstart(%rip), %eax
	cmpq	rsync_chunk_end(%rip), %rax
	jbe	.LBB11_41
# BB#37:                                # %if.then145
                                        #   in Loop: Header=BB11_3 Depth=1
	movq	%rbx, rsync_chunk_end(%rip)
	movl	$2, -24(%rbp)
	cmpq	$0, block_start(%rip)
	js	.LBB11_39
# BB#38:                                # %cond.true148
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	block_start(%rip), %eax
	leaq	window(%rax), %rax
	movq	%rax, -112(%rbp)
	movq	%rax, -72(%rbp)
	jmp	.LBB11_40
.LBB11_33:                              # %cond.false122
                                        #   in Loop: Header=BB11_3 Depth=1
	movq	$0, -64(%rbp)
.LBB11_34:                              # %cond.end123
                                        #   in Loop: Header=BB11_3 Depth=1
	movq	-64(%rbp), %rdi
	movl	strstart(%rip), %esi
	subq	block_start(%rip), %rsi
	movl	-24(%rbp), %edx
	decl	%edx
	xorl	%ecx, %ecx
	callq	flush_block
	movl	strstart(%rip), %eax
	movq	%rax, block_start(%rip)
	cmpl	$0, rsync(%rip)
	jne	.LBB11_43
	jmp	.LBB11_44
.LBB11_24:                              # %cond.false
                                        #   in Loop: Header=BB11_3 Depth=1
	movq	$0, -56(%rbp)
.LBB11_25:                              # %cond.end
                                        #   in Loop: Header=BB11_3 Depth=1
	movq	-56(%rbp), %rdi
	movl	strstart(%rip), %esi
	subq	block_start(%rip), %rsi
	movl	-24(%rbp), %edx
	decl	%edx
	xorl	%ecx, %ecx
	callq	flush_block
	movl	strstart(%rip), %eax
	movq	%rax, block_start(%rip)
	cmpl	$262, lookahead(%rip)   # imm = 0x106
	jb	.LBB11_47
	jmp	.LBB11_46
.LBB11_39:                              # %cond.false152
                                        #   in Loop: Header=BB11_3 Depth=1
	movq	$0, -72(%rbp)
.LBB11_40:                              # %cond.end153
                                        #   in Loop: Header=BB11_3 Depth=1
	movq	-72(%rbp), %rdi
	movl	strstart(%rip), %esi
	subq	block_start(%rip), %rsi
	movl	-24(%rbp), %edx
	decl	%edx
	xorl	%ecx, %ecx
	callq	flush_block
	movl	strstart(%rip), %eax
	movq	%rax, block_start(%rip)
.LBB11_41:                              # %do.body161
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	$1, -32(%rbp)
.LBB11_42:                              # %do.body161
                                        #   in Loop: Header=BB11_3 Depth=1
	cmpl	$0, rsync(%rip)
	je	.LBB11_44
.LBB11_43:                              # %if.then163
                                        #   in Loop: Header=BB11_3 Depth=1
	movl	strstart(%rip), %edi
	movl	$1, %esi
	callq	rsync_roll
.LBB11_44:                              # %do.end166
                                        #   in Loop: Header=BB11_3 Depth=1
	incl	strstart(%rip)
	decl	lookahead(%rip)
	cmpl	$262, lookahead(%rip)   # imm = 0x106
	jb	.LBB11_47
	jmp	.LBB11_46
	.p2align	4, 0x90
.LBB11_49:                              # %while.body175
                                        #   in Loop: Header=BB11_3 Depth=1
	callq	fill_window
.LBB11_45:                              # %while.cond171
                                        #   in Loop: Header=BB11_3 Depth=1
	cmpl	$262, lookahead(%rip)   # imm = 0x106
	jae	.LBB11_46
.LBB11_47:                              # %land.rhs
                                        #   in Loop: Header=BB11_3 Depth=1
	cmpl	$0, eofile(%rip)
	sete	-37(%rbp)
	sete	-17(%rbp)
	cmpb	$1, -17(%rbp)
	je	.LBB11_49
	jmp	.LBB11_3
	.p2align	4, 0x90
.LBB11_46:                              # %while.cond171.land.end_crit_edge
                                        #   in Loop: Header=BB11_3 Depth=1
	movb	$0, -17(%rbp)
	cmpb	$1, -17(%rbp)
	je	.LBB11_49
.LBB11_3:                               # %while.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB11_17 Depth 2
	cmpl	$0, lookahead(%rip)
	jne	.LBB11_4
# BB#50:                                # %while.end176
	cmpl	$0, -32(%rbp)
	je	.LBB11_52
# BB#51:                                # %if.then178
	movl	strstart(%rip), %eax
	decl	%eax
	movzbl	window(%rax), %esi
	xorl	%edi, %edi
	callq	ct_tally
.LBB11_52:                              # %if.end184
	cmpq	$0, block_start(%rip)
	js	.LBB11_54
# BB#53:                                # %cond.true187
	movl	block_start(%rip), %eax
	leaq	window(%rax), %rax
	movq	%rax, -120(%rbp)
	movq	%rax, -80(%rbp)
	jmp	.LBB11_55
.LBB11_54:                              # %cond.false191
	movq	$0, -80(%rbp)
.LBB11_55:                              # %cond.end192
	movq	-80(%rbp), %rdi
	movl	strstart(%rip), %esi
	subq	block_start(%rip), %rsi
	movl	-24(%rbp), %edx
	decl	%edx
	movl	$1, %ecx
	callq	flush_block
.LBB11_56:                              # %return
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	addq	$112, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end11:
	.size	deflate, .Lfunc_end11-deflate
	.cfi_endproc

	.p2align	4, 0x90
	.type	deflate_fast,@function
deflate_fast:                           # @deflate_fast
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi38:
	.cfi_def_cfa_offset 16
.Lcfi39:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi40:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$64, %rsp
.Lcfi41:
	.cfi_offset %rbx, -32
.Lcfi42:
	.cfi_offset %r14, -24
	movl	$0, -20(%rbp)
	movl	$2, prev_length(%rip)
	movq	$-262, %r14             # imm = 0xFEFA
	movl	$4294967295, %ebx       # imm = 0xFFFFFFFF
	jmp	.LBB12_1
	.p2align	4, 0x90
.LBB12_2:                               # %while.body
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	ins_h(%rip), %eax
	shll	$5, %eax
	movl	strstart(%rip), %ecx
	addl	$2, %ecx
	movzbl	window(%rcx), %ecx
	xorl	%eax, %ecx
	andl	$32767, %ecx            # imm = 0x7FFF
	movl	%ecx, ins_h(%rip)
	movl	ins_h(%rip), %eax
	movzwl	prev+65536(%rax,%rax), %eax
	movl	%eax, -32(%rbp)
	movl	strstart(%rip), %ecx
	andl	$32767, %ecx            # imm = 0x7FFF
	movw	%ax, prev(%rcx,%rcx)
	movzwl	strstart(%rip), %eax
	movl	ins_h(%rip), %ecx
	movw	%ax, prev+65536(%rcx,%rcx)
	cmpl	$0, -32(%rbp)
	je	.LBB12_7
# BB#3:                                 # %land.lhs.true
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	strstart(%rip), %eax
	subl	-32(%rbp), %eax
	cmpl	$32506, %eax            # imm = 0x7EFA
	ja	.LBB12_7
# BB#4:                                 # %land.lhs.true16
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	strstart(%rip), %eax
	movq	window_size(%rip), %rcx
	addq	%r14, %rcx
	cmpq	%rcx, %rax
	ja	.LBB12_7
# BB#5:                                 # %if.then
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	-32(%rbp), %edi
	callq	longest_match
	movl	%eax, -20(%rbp)
	cmpl	lookahead(%rip), %eax
	jbe	.LBB12_7
# BB#6:                                 # %if.then23
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	lookahead(%rip), %eax
	movl	%eax, -20(%rbp)
	.p2align	4, 0x90
.LBB12_7:                               # %if.end24
                                        #   in Loop: Header=BB12_1 Depth=1
	cmpl	$3, -20(%rbp)
	jb	.LBB12_14
# BB#8:                                 # %do.body
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	strstart(%rip), %edi
	subl	match_start(%rip), %edi
	movl	-20(%rbp), %esi
	addl	$-3, %esi
	callq	ct_tally
	movl	%eax, -28(%rbp)
	movl	-20(%rbp), %eax
	subl	%eax, lookahead(%rip)
	cmpl	$0, rsync(%rip)
	je	.LBB12_10
# BB#9:                                 # %if.then32
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	strstart(%rip), %edi
	movl	-20(%rbp), %esi
	callq	rsync_roll
.LBB12_10:                              # %do.end
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	-20(%rbp), %eax
	cmpl	max_lazy_match(%rip), %eax
	ja	.LBB12_13
# BB#11:                                # %if.then36
                                        #   in Loop: Header=BB12_1 Depth=1
	decl	-20(%rbp)
	.p2align	4, 0x90
.LBB12_12:                              # %do.cond
                                        #   Parent Loop BB12_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	strstart(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, strstart(%rip)
	movl	ins_h(%rip), %ecx
	shll	$5, %ecx
	addl	$3, %eax
	movzbl	window(%rax), %eax
	xorl	%ecx, %eax
	andl	$32767, %eax            # imm = 0x7FFF
	movl	%eax, ins_h(%rip)
	movl	ins_h(%rip), %eax
	movzwl	prev+65536(%rax,%rax), %eax
	movl	%eax, -32(%rbp)
	movl	strstart(%rip), %ecx
	andl	$32767, %ecx            # imm = 0x7FFF
	movw	%ax, prev(%rcx,%rcx)
	movzwl	strstart(%rip), %eax
	movl	ins_h(%rip), %ecx
	movw	%ax, prev+65536(%rcx,%rcx)
	decl	-20(%rbp)
	jne	.LBB12_12
	jmp	.LBB12_17
	.p2align	4, 0x90
.LBB12_14:                              # %do.body78
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	strstart(%rip), %eax
	movzbl	window(%rax), %esi
	xorl	%edi, %edi
	callq	ct_tally
	movl	%eax, -28(%rbp)
	cmpl	$0, rsync(%rip)
	je	.LBB12_16
# BB#15:                                # %if.then80
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	strstart(%rip), %edi
	movl	$1, %esi
	callq	rsync_roll
.LBB12_16:                              # %do.end83
                                        #   in Loop: Header=BB12_1 Depth=1
	decl	lookahead(%rip)
.LBB12_17:                              # %if.end86
                                        #   in Loop: Header=BB12_1 Depth=1
	incl	strstart(%rip)
	cmpl	$0, rsync(%rip)
	jne	.LBB12_19
	jmp	.LBB12_21
	.p2align	4, 0x90
.LBB12_13:                              # %if.else
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	-20(%rbp), %eax
	addl	%eax, strstart(%rip)
	movl	$0, -20(%rbp)
	movl	strstart(%rip), %eax
	movzbl	window(%rax), %eax
	movl	%eax, ins_h(%rip)
	shll	$5, %eax
	movl	strstart(%rip), %ecx
	incl	%ecx
	movzbl	window(%rcx), %ecx
	xorl	%eax, %ecx
	movl	%ecx, ins_h(%rip)
	cmpl	$0, rsync(%rip)
	je	.LBB12_21
.LBB12_19:                              # %land.lhs.true88
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	strstart(%rip), %eax
	cmpq	rsync_chunk_end(%rip), %rax
	jbe	.LBB12_21
# BB#20:                                # %if.then92
                                        #   in Loop: Header=BB12_1 Depth=1
	movq	%rbx, rsync_chunk_end(%rip)
	movl	$2, -28(%rbp)
.LBB12_21:                              # %if.end93
                                        #   in Loop: Header=BB12_1 Depth=1
	cmpl	$0, -28(%rbp)
	je	.LBB12_26
# BB#22:                                # %if.then95
                                        #   in Loop: Header=BB12_1 Depth=1
	cmpq	$0, block_start(%rip)
	js	.LBB12_24
# BB#23:                                # %cond.true
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	block_start(%rip), %eax
	leaq	window(%rax), %rax
	movq	%rax, -64(%rbp)
	movq	%rax, -48(%rbp)
	jmp	.LBB12_25
	.p2align	4, 0x90
.LBB12_24:                              # %cond.false
                                        #   in Loop: Header=BB12_1 Depth=1
	movq	$0, -48(%rbp)
.LBB12_25:                              # %cond.end
                                        #   in Loop: Header=BB12_1 Depth=1
	movq	-48(%rbp), %rdi
	movl	strstart(%rip), %esi
	subq	block_start(%rip), %rsi
	movl	-28(%rbp), %edx
	decl	%edx
	xorl	%ecx, %ecx
	callq	flush_block
	movl	strstart(%rip), %eax
	movq	%rax, block_start(%rip)
	cmpl	$262, lookahead(%rip)   # imm = 0x106
	jb	.LBB12_28
	jmp	.LBB12_27
	.p2align	4, 0x90
.LBB12_30:                              # %while.body111
                                        #   in Loop: Header=BB12_1 Depth=1
	callq	fill_window
.LBB12_26:                              # %while.cond107
                                        #   in Loop: Header=BB12_1 Depth=1
	cmpl	$262, lookahead(%rip)   # imm = 0x106
	jae	.LBB12_27
.LBB12_28:                              # %land.rhs
                                        #   in Loop: Header=BB12_1 Depth=1
	cmpl	$0, eofile(%rip)
	sete	-33(%rbp)
	sete	-21(%rbp)
	cmpb	$1, -21(%rbp)
	je	.LBB12_30
	jmp	.LBB12_1
	.p2align	4, 0x90
.LBB12_27:                              # %while.cond107.land.end_crit_edge
                                        #   in Loop: Header=BB12_1 Depth=1
	movb	$0, -21(%rbp)
	cmpb	$1, -21(%rbp)
	je	.LBB12_30
.LBB12_1:                               # %while.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB12_12 Depth 2
	cmpl	$0, lookahead(%rip)
	jne	.LBB12_2
# BB#31:                                # %while.end112
	cmpq	$0, block_start(%rip)
	js	.LBB12_33
# BB#32:                                # %cond.true115
	movl	block_start(%rip), %eax
	leaq	window(%rax), %rax
	movq	%rax, -72(%rbp)
	movq	%rax, -56(%rbp)
	jmp	.LBB12_34
.LBB12_33:                              # %cond.false119
	movq	$0, -56(%rbp)
.LBB12_34:                              # %cond.end120
	movq	-56(%rbp), %rdi
	movl	strstart(%rip), %esi
	subq	block_start(%rip), %rsi
	movl	-28(%rbp), %edx
	decl	%edx
	movl	$1, %ecx
	callq	flush_block
	addq	$64, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end12:
	.size	deflate_fast, .Lfunc_end12-deflate_fast
	.cfi_endproc

	.globl	ct_tally
	.p2align	4, 0x90
	.type	ct_tally,@function
ct_tally:                               # @ct_tally
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
	movl	%edi, -8(%rbp)
	movl	%esi, -16(%rbp)
	movb	-16(%rbp), %al
	movl	last_lit(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, last_lit(%rip)
	movb	%al, inbuf(%rcx)
	cmpl	$0, -8(%rbp)
	je	.LBB13_1
# BB#2:                                 # %if.else
	decl	-8(%rbp)
	movslq	-16(%rbp), %rax
	movzbl	length_code(%rax), %eax
	incw	dyn_ltree+1028(,%rax,4)
	cmpl	$255, -8(%rbp)
	jg	.LBB13_4
# BB#3:                                 # %cond.true
	movslq	-8(%rbp), %rax
	movzbl	dist_code(%rax), %eax
	movl	%eax, -52(%rbp)
	jmp	.LBB13_5
.LBB13_1:                               # %if.then
	movslq	-16(%rbp), %rax
	incw	dyn_ltree(,%rax,4)
	jmp	.LBB13_6
.LBB13_4:                               # %cond.false
	movl	-8(%rbp), %eax
	sarl	$7, %eax
	cltq
	movzbl	dist_code+256(%rax), %eax
	movl	%eax, -56(%rbp)
.LBB13_5:                               # %cond.end
	movl	%eax, -24(%rbp)
	movslq	-24(%rbp), %rax
	incw	dyn_dtree(,%rax,4)
	movzwl	-8(%rbp), %eax
	movl	last_dist(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, last_dist(%rip)
	movw	%ax, d_buf(%rcx,%rcx)
	movzbl	flag_bit(%rip), %eax
	movzbl	flags(%rip), %ecx
	orl	%eax, %ecx
	movb	%cl, flags(%rip)
.LBB13_6:                               # %if.end
	shlb	flag_bit(%rip)
	testb	$7, last_lit(%rip)
	jne	.LBB13_8
# BB#7:                                 # %if.then39
	movb	flags(%rip), %al
	movl	last_flags(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, last_flags(%rip)
	movb	%al, flag_buf(%rcx)
	movb	$0, flags(%rip)
	movb	$1, flag_bit(%rip)
.LBB13_8:                               # %if.end43
	cmpl	$3, level(%rip)
	jl	.LBB13_16
# BB#9:                                 # %land.lhs.true
	movzwl	last_lit(%rip), %eax
	testw	$4095, %ax              # imm = 0xFFF
	jne	.LBB13_16
# BB#10:                                # %if.then49
	movl	last_lit(%rip), %eax
	shlq	$3, %rax
	movq	%rax, -40(%rbp)
	movl	strstart(%rip), %eax
	subq	block_start(%rip), %rax
	movq	%rax, -48(%rbp)
	movl	$0, -12(%rbp)
	cmpl	$29, -12(%rbp)
	jg	.LBB13_13
	.p2align	4, 0x90
.LBB13_12:                              # %for.inc
                                        # =>This Inner Loop Header: Depth=1
	movslq	-12(%rbp), %rax
	movzwl	dyn_dtree(,%rax,4), %ecx
	movslq	extra_dbits(,%rax,4), %rax
	addq	$5, %rax
	imulq	%rcx, %rax
	addq	%rax, -40(%rbp)
	incl	-12(%rbp)
	cmpl	$29, -12(%rbp)
	jle	.LBB13_12
.LBB13_13:                              # %for.end
	shrq	$3, -40(%rbp)
	movl	last_lit(%rip), %eax
	shrl	%eax
	cmpl	%eax, last_dist(%rip)
	jae	.LBB13_16
# BB#14:                                # %land.lhs.true69
	movq	-48(%rbp), %rax
	shrq	%rax
	cmpq	%rax, -40(%rbp)
	jae	.LBB13_16
# BB#15:                                # %if.then73
	movl	$1, -28(%rbp)
	jmp	.LBB13_20
.LBB13_16:                              # %if.end75
	cmpl	$32767, last_lit(%rip)  # imm = 0x7FFF
	jne	.LBB13_18
# BB#17:                                # %if.end75.lor.end_crit_edge
	movb	$1, -1(%rbp)
	jmp	.LBB13_19
.LBB13_18:                              # %lor.rhs
	cmpl	$32768, last_dist(%rip) # imm = 0x8000
	sete	-17(%rbp)
	sete	-1(%rbp)
.LBB13_19:                              # %lor.end
	movzbl	-1(%rbp), %eax
	movl	%eax, -28(%rbp)
.LBB13_20:                              # %return
	movl	-28(%rbp), %eax
	popq	%rbp
	retq
.Lfunc_end13:
	.size	ct_tally, .Lfunc_end13-ct_tally
	.cfi_endproc

	.p2align	4, 0x90
	.type	rsync_roll,@function
rsync_roll:                             # @rsync_roll
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
	movl	%edi, -8(%rbp)
	movl	%esi, -12(%rbp)
	cmpl	$4095, -8(%rbp)         # imm = 0xFFF
	ja	.LBB14_6
# BB#1:                                 # %if.then
	movl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	cmpl	$4095, -4(%rbp)         # imm = 0xFFF
	jbe	.LBB14_3
	jmp	.LBB14_5
	.p2align	4, 0x90
.LBB14_4:                               # %for.inc
                                        #   in Loop: Header=BB14_3 Depth=1
	movl	-4(%rbp), %eax
	movzbl	window(%rax), %eax
	addq	%rax, rsync_sum(%rip)
	incl	-4(%rbp)
	cmpl	$4095, -4(%rbp)         # imm = 0xFFF
	ja	.LBB14_5
.LBB14_3:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	-8(%rbp), %eax
	addl	-12(%rbp), %eax
	cmpl	%eax, -4(%rbp)
	jne	.LBB14_4
	jmp	.LBB14_12
.LBB14_5:                               # %for.end
	movl	$4096, %eax             # imm = 0x1000
	subl	-8(%rbp), %eax
	subl	%eax, -12(%rbp)
	movl	$4096, -8(%rbp)         # imm = 0x1000
.LBB14_6:                               # %if.end6
	movl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	movl	$-4096, %eax            # imm = 0xF000
	movl	$4294967295, %ecx       # imm = 0xFFFFFFFF
	jmp	.LBB14_7
	.p2align	4, 0x90
.LBB14_11:                              # %for.inc28
                                        #   in Loop: Header=BB14_7 Depth=1
	incl	-4(%rbp)
.LBB14_7:                               # %for.cond7
                                        # =>This Inner Loop Header: Depth=1
	movl	-8(%rbp), %edx
	addl	-12(%rbp), %edx
	cmpl	%edx, -4(%rbp)
	jae	.LBB14_12
# BB#8:                                 # %for.body11
                                        #   in Loop: Header=BB14_7 Depth=1
	movl	-4(%rbp), %edx
	movzbl	window(%rdx), %edx
	addq	rsync_sum(%rip), %rdx
	movq	%rdx, rsync_sum(%rip)
	movl	-4(%rbp), %esi
	addl	%eax, %esi
	movzbl	window(%rsi), %esi
	subq	%rsi, %rdx
	movq	%rdx, rsync_sum(%rip)
	cmpq	%rcx, rsync_chunk_end(%rip)
	jne	.LBB14_11
# BB#9:                                 # %land.lhs.true
                                        #   in Loop: Header=BB14_7 Depth=1
	movzwl	rsync_sum(%rip), %edx
	testw	$4095, %dx              # imm = 0xFFF
	jne	.LBB14_11
# BB#10:                                # %if.then25
                                        #   in Loop: Header=BB14_7 Depth=1
	movl	-4(%rbp), %edx
	movq	%rdx, rsync_chunk_end(%rip)
	jmp	.LBB14_11
.LBB14_12:                              # %for.end30
	popq	%rbp
	retq
.Lfunc_end14:
	.size	rsync_roll, .Lfunc_end14-rsync_roll
	.cfi_endproc

	.globl	flush_block
	.p2align	4, 0x90
	.type	flush_block,@function
flush_block:                            # @flush_block
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
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -24(%rbp)
	movl	%edx, -48(%rbp)
	movl	%ecx, -4(%rbp)
	movb	flags(%rip), %al
	movl	last_flags(%rip), %ecx
	movb	%al, flag_buf(%rcx)
	movq	file_type(%rip), %rax
	movzwl	(%rax), %eax
	cmpl	$65535, %eax            # imm = 0xFFFF
	jne	.LBB15_2
# BB#1:                                 # %if.then
	callq	set_file_type
.LBB15_2:                               # %if.end
	movl	$l_desc, %edi
	callq	build_tree_1
	movl	$d_desc, %edi
	callq	build_tree_1
	callq	build_bl_tree
	movl	%eax, -44(%rbp)
	movq	opt_len(%rip), %rax
	addq	$10, %rax
	shrq	$3, %rax
	movq	%rax, -16(%rbp)
	movq	static_len(%rip), %rax
	addq	$10, %rax
	shrq	$3, %rax
	movq	%rax, -32(%rbp)
	movq	-24(%rbp), %rax
	addq	%rax, input_len(%rip)
	movq	-32(%rbp), %rax
	cmpq	-16(%rbp), %rax
	ja	.LBB15_4
# BB#3:                                 # %if.then9
	movq	-32(%rbp), %rax
	movq	%rax, -16(%rbp)
.LBB15_4:                               # %if.end10
	movq	-24(%rbp), %rax
	cmpq	-16(%rbp), %rax
	ja	.LBB15_7
# BB#5:                                 # %land.lhs.true
	cmpl	$0, -4(%rbp)
	je	.LBB15_7
# BB#6:                                 # %land.lhs.true13
	cmpq	$0, compressed_len(%rip)
.LBB15_7:                               # %if.else
	movq	-24(%rbp), %rax
	addq	$4, %rax
	cmpq	-16(%rbp), %rax
	ja	.LBB15_10
# BB#8:                                 # %land.lhs.true26
	cmpq	$0, -40(%rbp)
	je	.LBB15_10
# BB#9:                                 # %if.then29
	movl	-4(%rbp), %edi
	movl	$3, %esi
	callq	send_bits
	movq	compressed_len(%rip), %rax
	addq	$10, %rax
	andq	$-8, %rax
	movq	%rax, compressed_len(%rip)
	movq	-24(%rbp), %rcx
	leaq	32(%rax,%rcx,8), %rax
	movq	%rax, compressed_len(%rip)
	movq	-40(%rbp), %rdi
	movl	-24(%rbp), %esi
	movl	$1, %edx
	callq	copy_block
	jmp	.LBB15_14
.LBB15_10:                              # %if.else37
	movq	-32(%rbp), %rax
	cmpq	-16(%rbp), %rax
	jne	.LBB15_12
# BB#11:                                # %if.then40
	movl	-4(%rbp), %edi
	addl	$2, %edi
	movl	$3, %esi
	callq	send_bits
	movl	$static_ltree, %edi
	movl	$static_dtree, %esi
	callq	compress_block
	movq	static_len(%rip), %rax
	jmp	.LBB15_13
.LBB15_12:                              # %if.else44
	movl	-4(%rbp), %edi
	addl	$4, %edi
	movl	$3, %esi
	callq	send_bits
	movl	l_desc+36(%rip), %edi
	incl	%edi
	movl	d_desc+36(%rip), %esi
	incl	%esi
	movl	-44(%rbp), %edx
	incl	%edx
	callq	send_all_trees
	movl	$dyn_ltree, %edi
	movl	$dyn_dtree, %esi
	callq	compress_block
	movq	opt_len(%rip), %rax
.LBB15_13:                              # %if.end53
	movq	compressed_len(%rip), %rcx
	leaq	3(%rcx,%rax), %rax
	movq	%rax, compressed_len(%rip)
.LBB15_14:                              # %if.end53
	callq	init_block
	cmpl	$0, -4(%rbp)
	je	.LBB15_16
# BB#15:                                # %if.then55
	callq	bi_windup
	addq	$7, compressed_len(%rip)
	jmp	.LBB15_19
.LBB15_16:                              # %if.else57
	cmpl	$0, -48(%rbp)
	je	.LBB15_19
# BB#17:                                # %land.lhs.true59
	movq	compressed_len(%rip), %rax
	movq	%rax, %rcx
	sarq	$63, %rcx
	shrq	$61, %rcx
	addq	%rax, %rcx
	andq	$-8, %rcx
	cmpq	%rcx, %rax
	je	.LBB15_19
# BB#18:                                # %if.then62
	movl	-4(%rbp), %edi
	movl	$3, %esi
	callq	send_bits
	movq	compressed_len(%rip), %rax
	addq	$10, %rax
	andq	$-8, %rax
	movq	%rax, compressed_len(%rip)
	movq	-40(%rbp), %rdi
	xorl	%esi, %esi
	movl	$1, %edx
	callq	copy_block
.LBB15_19:                              # %if.end68
	movq	compressed_len(%rip), %rax
	sarq	$3, %rax
	addq	$48, %rsp
	popq	%rbp
	retq
.Lfunc_end15:
	.size	flush_block, .Lfunc_end15-flush_block
	.cfi_endproc

	.globl	_getopt_internal
	.p2align	4, 0x90
	.type	_getopt_internal,@function
_getopt_internal:                       # @_getopt_internal
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
	pushq	%rbx
	subq	$168, %rsp
.Lcfi55:
	.cfi_offset %rbx, -24
	movl	%edi, -32(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -72(%rbp)
	movq	%rcx, -168(%rbp)
	movq	%r8, -160(%rbp)
	movl	%r9d, -108(%rbp)
	movl	opterr(%rip), %eax
	movl	%eax, -28(%rbp)
	movq	-72(%rbp), %rax
	cmpb	$58, (%rax)
	jne	.LBB16_2
# BB#1:                                 # %if.then
	movl	$0, -28(%rbp)
.LBB16_2:                               # %if.end
	cmpl	$0, -32(%rbp)
	jle	.LBB16_3
# BB#4:                                 # %if.end5
	movq	$0, optarg(%rip)
	cmpl	$0, optind(%rip)
	je	.LBB16_6
# BB#5:                                 # %lor.lhs.false
	cmpl	$0, __getopt_initialized(%rip)
	jne	.LBB16_9
.LBB16_6:                               # %if.then8
	cmpl	$0, optind(%rip)
	jne	.LBB16_8
# BB#7:                                 # %if.then11
	movl	$1, optind(%rip)
.LBB16_8:                               # %if.end12
	movl	-32(%rbp), %edi
	movq	-24(%rbp), %rsi
	movq	-72(%rbp), %rdx
	callq	_getopt_initialize
	movq	%rax, -72(%rbp)
	movl	$1, __getopt_initialized(%rip)
.LBB16_9:                               # %if.end13
	cmpq	$0, nextchar(%rip)
	je	.LBB16_11
# BB#10:                                # %lor.lhs.false16
	movq	nextchar(%rip), %rax
	cmpb	$0, (%rax)
	je	.LBB16_11
# BB#51:                                # %if.end121
	cmpq	$0, -168(%rbp)
	je	.LBB16_112
.LBB16_52:                              # %land.lhs.true124
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	movq	(%rax,%rcx,8), %rax
	cmpb	$45, 1(%rax)
	je	.LBB16_56
# BB#53:                                # %lor.lhs.false131
	cmpl	$0, -108(%rbp)
	je	.LBB16_112
# BB#54:                                # %land.lhs.true133
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	movq	(%rax,%rcx,8), %rax
	cmpb	$0, 2(%rax)
	je	.LBB16_55
.LBB16_56:                              # %if.then146
	movq	$0, -48(%rbp)
	movl	$0, -152(%rbp)
	movl	$0, -148(%rbp)
	movl	$-1, -104(%rbp)
	movq	nextchar(%rip), %rax
	movq	%rax, -96(%rbp)
	jmp	.LBB16_57
	.p2align	4, 0x90
.LBB16_61:                              # %for.inc
                                        #   in Loop: Header=BB16_57 Depth=1
	incq	-96(%rbp)
.LBB16_57:                              # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	-96(%rbp), %rax
	cmpb	$0, (%rax)
	je	.LBB16_58
# BB#59:                                # %land.rhs149
                                        #   in Loop: Header=BB16_57 Depth=1
	movq	-96(%rbp), %rax
	cmpb	$61, (%rax)
	setne	-112(%rbp)
	setne	-36(%rbp)
	cmpb	$1, -36(%rbp)
	je	.LBB16_61
	jmp	.LBB16_62
	.p2align	4, 0x90
.LBB16_58:                              # %for.cond.land.end153_crit_edge
                                        #   in Loop: Header=BB16_57 Depth=1
	movb	$0, -36(%rbp)
	cmpb	$1, -36(%rbp)
	je	.LBB16_61
.LBB16_62:                              # %for.end
	movq	-168(%rbp), %rax
	movq	%rax, -80(%rbp)
	movl	$0, -56(%rbp)
	jmp	.LBB16_63
	.p2align	4, 0x90
.LBB16_79:                              # %for.inc195
                                        #   in Loop: Header=BB16_63 Depth=1
	addq	$32, -80(%rbp)
	incl	-56(%rbp)
.LBB16_63:                              # %for.cond155
                                        # =>This Inner Loop Header: Depth=1
	movq	-80(%rbp), %rax
	cmpq	$0, (%rax)
	je	.LBB16_67
# BB#64:                                # %for.body157
                                        #   in Loop: Header=BB16_63 Depth=1
	movq	-80(%rbp), %rax
	movq	(%rax), %rdi
	movq	nextchar(%rip), %rsi
	movq	-96(%rbp), %rdx
	subq	%rsi, %rdx
	callq	strncmp
	testl	%eax, %eax
	jne	.LBB16_79
# BB#65:                                # %if.then161
                                        #   in Loop: Header=BB16_63 Depth=1
	movl	-96(%rbp), %ebx
	subl	nextchar(%rip), %ebx
	movq	-80(%rbp), %rax
	movq	(%rax), %rdi
	callq	strlen
	cmpl	%eax, %ebx
	je	.LBB16_66
# BB#72:                                # %if.else172
                                        #   in Loop: Header=BB16_63 Depth=1
	cmpq	$0, -48(%rbp)
	je	.LBB16_73
# BB#74:                                # %if.else176
                                        #   in Loop: Header=BB16_63 Depth=1
	cmpl	$0, -108(%rbp)
	jne	.LBB16_78
# BB#75:                                # %lor.lhs.false178
                                        #   in Loop: Header=BB16_63 Depth=1
	movq	-48(%rbp), %rax
	movl	8(%rax), %eax
	movq	-80(%rbp), %rcx
	cmpl	8(%rcx), %eax
	jne	.LBB16_78
# BB#76:                                # %lor.lhs.false182
                                        #   in Loop: Header=BB16_63 Depth=1
	movq	-48(%rbp), %rax
	movq	16(%rax), %rax
	movq	-80(%rbp), %rcx
	cmpq	16(%rcx), %rax
	jne	.LBB16_78
# BB#77:                                # %lor.lhs.false186
                                        #   in Loop: Header=BB16_63 Depth=1
	movq	-48(%rbp), %rax
	movl	24(%rax), %eax
	movq	-80(%rbp), %rcx
	cmpl	24(%rcx), %eax
	je	.LBB16_79
	.p2align	4, 0x90
.LBB16_78:                              # %if.then190
                                        #   in Loop: Header=BB16_63 Depth=1
	movl	$1, -148(%rbp)
	jmp	.LBB16_79
.LBB16_73:                              # %if.then175
                                        #   in Loop: Header=BB16_63 Depth=1
	movq	-80(%rbp), %rax
	movq	%rax, -48(%rbp)
	movl	-56(%rbp), %eax
	movl	%eax, -104(%rbp)
	jmp	.LBB16_79
.LBB16_11:                              # %if.then20
	movl	last_nonopt(%rip), %eax
	cmpl	optind(%rip), %eax
	jle	.LBB16_13
# BB#12:                                # %if.then23
	movl	optind(%rip), %eax
	movl	%eax, last_nonopt(%rip)
.LBB16_13:                              # %if.end24
	movl	first_nonopt(%rip), %eax
	cmpl	optind(%rip), %eax
	jle	.LBB16_15
# BB#14:                                # %if.then27
	movl	optind(%rip), %eax
	movl	%eax, first_nonopt(%rip)
.LBB16_15:                              # %if.end28
	cmpl	$1, ordering(%rip)
	jne	.LBB16_30
# BB#16:                                # %if.then31
	movl	first_nonopt(%rip), %eax
	cmpl	last_nonopt(%rip), %eax
	je	.LBB16_19
# BB#17:                                # %land.lhs.true
	movl	last_nonopt(%rip), %eax
	cmpl	optind(%rip), %eax
	je	.LBB16_19
# BB#18:                                # %if.then36
	movq	-24(%rbp), %rdi
	callq	exchange
	jmp	.LBB16_21
.LBB16_3:                               # %if.then4
	movl	$-1, -16(%rbp)
	jmp	.LBB16_191
.LBB16_19:                              # %if.else
	movl	last_nonopt(%rip), %eax
	cmpl	optind(%rip), %eax
	je	.LBB16_21
# BB#20:                                # %if.then39
	movl	optind(%rip), %eax
	movl	%eax, first_nonopt(%rip)
	jmp	.LBB16_21
	.p2align	4, 0x90
.LBB16_28:                              # %while.body
                                        #   in Loop: Header=BB16_21 Depth=1
	incl	optind(%rip)
.LBB16_21:                              # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	optind(%rip), %eax
	cmpl	-32(%rbp), %eax
	jge	.LBB16_22
# BB#23:                                # %land.rhs
                                        #   in Loop: Header=BB16_21 Depth=1
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	movq	(%rax,%rcx,8), %rax
	cmpb	$45, (%rax)
	je	.LBB16_25
# BB#24:                                # %land.rhs.lor.end_crit_edge
                                        #   in Loop: Header=BB16_21 Depth=1
	movb	$1, -33(%rbp)
	jmp	.LBB16_26
	.p2align	4, 0x90
.LBB16_22:                              # %while.cond.land.end_crit_edge
                                        #   in Loop: Header=BB16_21 Depth=1
	movb	$0, -34(%rbp)
	cmpb	$1, -34(%rbp)
	je	.LBB16_28
	jmp	.LBB16_29
	.p2align	4, 0x90
.LBB16_25:                              # %lor.rhs
                                        #   in Loop: Header=BB16_21 Depth=1
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	movq	(%rax,%rcx,8), %rax
	cmpb	$0, 1(%rax)
	sete	-109(%rbp)
	sete	-33(%rbp)
.LBB16_26:                              # %lor.end
                                        #   in Loop: Header=BB16_21 Depth=1
	movzbl	-33(%rbp), %eax
	movb	%al, -110(%rbp)
	movb	%al, -34(%rbp)
	cmpb	$1, -34(%rbp)
	je	.LBB16_28
.LBB16_29:                              # %while.end
	movl	optind(%rip), %eax
	movl	%eax, last_nonopt(%rip)
.LBB16_30:                              # %if.end55
	movl	optind(%rip), %eax
	cmpl	-32(%rbp), %eax
	je	.LBB16_38
# BB#31:                                # %land.lhs.true58
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	movq	(%rax,%rcx,8), %rdi
	movl	$.L.str.1, %esi
	callq	strcmp
	testl	%eax, %eax
	jne	.LBB16_38
# BB#32:                                # %if.then63
	incl	optind(%rip)
	movl	first_nonopt(%rip), %eax
	cmpl	last_nonopt(%rip), %eax
	je	.LBB16_35
# BB#33:                                # %land.lhs.true67
	movl	last_nonopt(%rip), %eax
	cmpl	optind(%rip), %eax
	je	.LBB16_35
# BB#34:                                # %if.then70
	movq	-24(%rbp), %rdi
	callq	exchange
	jmp	.LBB16_37
.LBB16_35:                              # %if.else71
	movl	first_nonopt(%rip), %eax
	cmpl	last_nonopt(%rip), %eax
	jne	.LBB16_37
# BB#36:                                # %if.then74
	movl	optind(%rip), %eax
	movl	%eax, first_nonopt(%rip)
.LBB16_37:                              # %if.end76
	movl	-32(%rbp), %eax
	movl	%eax, last_nonopt(%rip)
	movl	-32(%rbp), %eax
	movl	%eax, optind(%rip)
.LBB16_38:                              # %if.end77
	movl	optind(%rip), %eax
	cmpl	-32(%rbp), %eax
	jne	.LBB16_42
# BB#39:                                # %if.then80
	movl	first_nonopt(%rip), %eax
	cmpl	last_nonopt(%rip), %eax
	je	.LBB16_41
# BB#40:                                # %if.then83
	movl	first_nonopt(%rip), %eax
	movl	%eax, optind(%rip)
.LBB16_41:                              # %if.end84
	movl	$-1, -16(%rbp)
	jmp	.LBB16_191
.LBB16_42:                              # %if.end85
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	movq	(%rax,%rcx,8), %rax
	cmpb	$45, (%rax)
	jne	.LBB16_44
# BB#43:                                # %lor.lhs.false92
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	movq	(%rax,%rcx,8), %rax
	cmpb	$0, 1(%rax)
	je	.LBB16_44
# BB#47:                                # %if.end107
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	movq	(%rax,%rcx,8), %rax
	incq	%rax
	movq	%rax, -176(%rbp)
	cmpq	$0, -168(%rbp)
	je	.LBB16_48
# BB#49:                                # %land.rhs112
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	movq	(%rax,%rcx,8), %rax
	cmpb	$45, 1(%rax)
	sete	-111(%rbp)
	sete	-35(%rbp)
	jmp	.LBB16_50
.LBB16_44:                              # %if.then99
	cmpl	$0, ordering(%rip)
	je	.LBB16_45
# BB#46:                                # %if.end103
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	leal	1(%rcx), %edx
	movl	%edx, optind(%rip)
	movq	(%rax,%rcx,8), %rax
	movq	%rax, optarg(%rip)
	movl	$1, -16(%rbp)
	jmp	.LBB16_191
.LBB16_45:                              # %if.then102
	movl	$-1, -16(%rbp)
	jmp	.LBB16_191
.LBB16_66:                              # %if.then171
	movq	-80(%rbp), %rax
	movq	%rax, -48(%rbp)
	movl	-56(%rbp), %eax
	movl	%eax, -104(%rbp)
	movl	$1, -152(%rbp)
.LBB16_67:                              # %for.end198
	cmpl	$0, -148(%rbp)
	je	.LBB16_80
# BB#68:                                # %land.lhs.true200
	cmpl	$0, -152(%rbp)
	je	.LBB16_69
.LBB16_80:                              # %if.end213
	cmpq	$0, -48(%rbp)
	je	.LBB16_103
# BB#81:                                # %if.then216
	movl	-104(%rbp), %eax
	incl	optind(%rip)
	movl	%eax, -56(%rbp)
	movq	-96(%rbp), %rax
	cmpb	$0, (%rax)
	je	.LBB16_89
# BB#82:                                # %if.then219
	movq	-48(%rbp), %rax
	cmpl	$0, 8(%rax)
	je	.LBB16_84
# BB#83:                                # %if.then222
	movq	-96(%rbp), %rax
	incq	%rax
.LBB16_92:                              # %if.end281
	movq	%rax, optarg(%rip)
	jmp	.LBB16_93
.LBB16_103:                             # %if.end295
	cmpl	$0, -108(%rbp)
	je	.LBB16_106
# BB#104:                               # %lor.lhs.false297
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	movq	(%rax,%rcx,8), %rax
	cmpb	$45, 1(%rax)
	je	.LBB16_106
# BB#105:                               # %lor.lhs.false304
	movq	-72(%rbp), %rdi
	movq	nextchar(%rip), %rax
	movsbl	(%rax), %esi
	xorl	%eax, %eax
	callq	my_index
	testl	%eax, %eax
	jne	.LBB16_112
.LBB16_106:                             # %if.then310
	cmpl	$0, -28(%rbp)
	je	.LBB16_110
# BB#107:                               # %if.then312
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	movq	(%rax,%rcx,8), %rax
	cmpb	$45, 1(%rax)
	jne	.LBB16_109
# BB#108:                               # %if.then319
	movq	stderr(%rip), %rdi
	movq	-24(%rbp), %rax
	movq	(%rax), %rdx
	movq	nextchar(%rip), %rcx
	movl	$.L.str.6, %esi
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB16_110
.LBB16_69:                              # %if.then202
	cmpl	$0, -28(%rbp)
	je	.LBB16_71
# BB#70:                                # %if.then204
	movq	stderr(%rip), %rdi
	movq	-24(%rbp), %rax
	movq	(%rax), %rdx
	movslq	optind(%rip), %rcx
	movq	(%rax,%rcx,8), %rcx
	movl	$.L.str.2, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB16_71:                              # %if.end209
	movq	nextchar(%rip), %rdi
	callq	strlen
	addq	%rax, nextchar(%rip)
	jmp	.LBB16_111
.LBB16_89:                              # %if.else252
	movq	-48(%rbp), %rax
	cmpl	$1, 8(%rax)
	jne	.LBB16_93
# BB#90:                                # %if.then256
	movl	optind(%rip), %eax
	cmpl	-32(%rbp), %eax
	jge	.LBB16_98
# BB#91:                                # %if.then259
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	leal	1(%rcx), %edx
	movl	%edx, optind(%rip)
	movq	(%rax,%rcx,8), %rax
	jmp	.LBB16_92
.LBB16_93:                              # %if.end281
	movq	nextchar(%rip), %rdi
	callq	strlen
	addq	%rax, nextchar(%rip)
	cmpq	$0, -160(%rbp)
	je	.LBB16_95
# BB#94:                                # %if.then286
	movl	-56(%rbp), %eax
	movq	-160(%rbp), %rcx
	movl	%eax, (%rcx)
.LBB16_95:                              # %if.end287
	movq	-48(%rbp), %rax
	cmpq	$0, 16(%rax)
	je	.LBB16_101
# BB#96:                                # %if.then290
	movq	-48(%rbp), %rax
.LBB16_97:                              # %return
	movl	24(%rax), %ecx
	movq	16(%rax), %rax
	movl	%ecx, (%rax)
	movl	$0, -16(%rbp)
	jmp	.LBB16_191
.LBB16_48:                              # %if.end107.land.end119_crit_edge
	movb	$0, -35(%rbp)
.LBB16_50:                              # %land.end119
	movzbl	-35(%rbp), %eax
	addq	-176(%rbp), %rax
	movq	%rax, nextchar(%rip)
	cmpq	$0, -168(%rbp)
	jne	.LBB16_52
	jmp	.LBB16_112
.LBB16_55:                              # %lor.lhs.false139
	movq	-72(%rbp), %rdi
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	movq	(%rax,%rcx,8), %rax
	movsbl	1(%rax), %esi
	xorl	%eax, %eax
	callq	my_index
	testl	%eax, %eax
	je	.LBB16_56
.LBB16_112:                             # %if.end333
	movq	nextchar(%rip), %rax
	leaq	1(%rax), %rcx
	movq	%rcx, nextchar(%rip)
	movb	(%rax), %al
	movb	%al, -9(%rbp)
	movq	-72(%rbp), %rdi
	movsbl	-9(%rbp), %esi
	xorl	%eax, %eax
	callq	my_index
	cltq
	movq	%rax, -136(%rbp)
	movq	nextchar(%rip), %rax
	cmpb	$0, (%rax)
	jne	.LBB16_114
# BB#113:                               # %if.then341
	incl	optind(%rip)
.LBB16_114:                             # %if.end343
	cmpq	$0, -136(%rbp)
	je	.LBB16_116
# BB#115:                               # %lor.lhs.false346
	cmpb	$58, -9(%rbp)
	jne	.LBB16_123
.LBB16_116:                             # %if.then350
	cmpl	$0, -28(%rbp)
	je	.LBB16_121
# BB#117:                               # %if.then352
	cmpq	$0, posixly_correct(%rip)
	je	.LBB16_119
# BB#118:                               # %if.then354
	movq	stderr(%rip), %rdi
	movq	-24(%rbp), %rax
	movq	(%rax), %rdx
	movsbl	-9(%rbp), %ecx
	movl	$.L.str.9, %esi
	jmp	.LBB16_120
.LBB16_123:                             # %if.end365
	movq	-136(%rbp), %rax
	cmpb	$87, (%rax)
	jne	.LBB16_175
# BB#124:                               # %land.lhs.true370
	movq	-136(%rbp), %rax
	cmpb	$59, 1(%rax)
	jne	.LBB16_175
# BB#125:                               # %if.then375
	movq	$0, -64(%rbp)
	movl	$0, -144(%rbp)
	movl	$0, -140(%rbp)
	movl	$0, -100(%rbp)
	movq	nextchar(%rip), %rax
	cmpb	$0, (%rax)
	je	.LBB16_127
# BB#126:                               # %if.then386
	movq	nextchar(%rip), %rax
	movq	%rax, optarg(%rip)
	incl	optind(%rip)
	jmp	.LBB16_134
.LBB16_175:                             # %if.end537
	movq	-136(%rbp), %rax
	cmpb	$58, 1(%rax)
	jne	.LBB16_189
# BB#176:                               # %if.then542
	movq	-136(%rbp), %rax
	cmpb	$58, 2(%rax)
	jne	.LBB16_180
# BB#177:                               # %if.then547
	movq	nextchar(%rip), %rax
	cmpb	$0, (%rax)
	jne	.LBB16_178
# BB#179:                               # %if.else553
	movq	$0, optarg(%rip)
	jmp	.LBB16_188
.LBB16_119:                             # %if.else358
	movq	stderr(%rip), %rdi
	movq	-24(%rbp), %rax
	movq	(%rax), %rdx
	movsbl	-9(%rbp), %ecx
	movl	$.L.str.10, %esi
.LBB16_120:                             # %if.end363
	xorl	%eax, %eax
	callq	fprintf
.LBB16_121:                             # %if.end363
	movsbl	-9(%rbp), %eax
.LBB16_122:                             # %return
	movl	%eax, optopt(%rip)
	movl	$63, -16(%rbp)
	jmp	.LBB16_191
.LBB16_101:                             # %if.end293
	movq	-48(%rbp), %rax
	movl	24(%rax), %eax
	jmp	.LBB16_190
.LBB16_84:                              # %if.else224
	cmpl	$0, -28(%rbp)
	je	.LBB16_88
# BB#85:                                # %if.then226
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	movq	-8(%rax,%rcx,8), %rax
	cmpb	$45, 1(%rax)
	jne	.LBB16_87
# BB#86:                                # %if.then233
	movq	stderr(%rip), %rdi
	movq	-24(%rbp), %rax
	movq	(%rax), %rdx
	movq	-48(%rbp), %rax
	movq	(%rax), %rcx
	movl	$.L.str.3, %esi
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB16_88
.LBB16_109:                             # %if.else322
	movq	stderr(%rip), %rdi
	movq	-24(%rbp), %rax
	movq	(%rax), %rdx
	movslq	optind(%rip), %rcx
	movq	(%rax,%rcx,8), %rax
	movsbl	(%rax), %ecx
	movq	nextchar(%rip), %r8
	movl	$.L.str.7, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB16_110:                             # %if.end330
	movq	$.L.str.8, nextchar(%rip)
.LBB16_111:                             # %return
	incl	optind(%rip)
	movl	$0, optopt(%rip)
	movl	$63, -16(%rbp)
	jmp	.LBB16_191
.LBB16_180:                             # %if.else555
	movq	nextchar(%rip), %rax
	cmpb	$0, (%rax)
	je	.LBB16_181
.LBB16_178:                             # %if.then551
	movq	nextchar(%rip), %rax
	movq	%rax, optarg(%rip)
	incl	optind(%rip)
.LBB16_188:                             # %if.end584
	movq	$0, nextchar(%rip)
.LBB16_189:                             # %if.end586
	movsbl	-9(%rbp), %eax
.LBB16_190:                             # %return
	movl	%eax, -16(%rbp)
.LBB16_191:                             # %return
	movl	-16(%rbp), %eax
	addq	$168, %rsp
	popq	%rbx
	popq	%rbp
	retq
.LBB16_98:                              # %if.else263
	cmpl	$0, -28(%rbp)
	je	.LBB16_100
# BB#99:                                # %if.then265
	movq	stderr(%rip), %rdi
	movq	-24(%rbp), %rax
	movq	(%rax), %rdx
	movslq	optind(%rip), %rcx
	movq	-8(%rax,%rcx,8), %rcx
	movl	$.L.str.5, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB16_100:                             # %if.end271
	movq	nextchar(%rip), %rdi
	callq	strlen
	addq	%rax, nextchar(%rip)
	movq	-48(%rbp), %rax
	movl	24(%rax), %eax
	movl	%eax, optopt(%rip)
.LBB16_172:                             # %return
	movq	-72(%rbp), %rax
	xorl	%ecx, %ecx
	cmpb	$58, (%rax)
	setne	%cl
	leal	58(%rcx,%rcx,4), %eax
	jmp	.LBB16_190
.LBB16_127:                             # %if.else388
	movl	optind(%rip), %eax
	cmpl	-32(%rbp), %eax
	jne	.LBB16_133
# BB#128:                               # %if.then391
	cmpl	$0, -28(%rbp)
	je	.LBB16_130
# BB#129:                               # %if.then393
	movq	stderr(%rip), %rdi
	movq	-24(%rbp), %rax
	movq	(%rax), %rdx
	movsbl	-9(%rbp), %ecx
	movl	$.L.str.11, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB16_130:                             # %if.end397
	movsbl	-9(%rbp), %eax
	movl	%eax, optopt(%rip)
	movq	-72(%rbp), %rax
	cmpb	$58, (%rax)
	jne	.LBB16_132
# BB#131:                               # %if.then403
	movb	$58, -9(%rbp)
	jmp	.LBB16_189
.LBB16_87:                              # %if.else237
	movq	stderr(%rip), %rdi
	movq	-24(%rbp), %rax
	movq	(%rax), %rdx
	movslq	optind(%rip), %rcx
	movq	-8(%rax,%rcx,8), %rax
	movsbl	(%rax), %ecx
	movq	-48(%rbp), %rax
	movq	(%rax), %r8
	movl	$.L.str.4, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB16_88:                              # %if.end247
	movq	nextchar(%rip), %rdi
	callq	strlen
	addq	%rax, nextchar(%rip)
	movq	-48(%rbp), %rax
	movl	24(%rax), %eax
	jmp	.LBB16_122
.LBB16_181:                             # %if.else561
	movl	optind(%rip), %eax
	cmpl	-32(%rbp), %eax
	jne	.LBB16_187
# BB#182:                               # %if.then564
	cmpl	$0, -28(%rbp)
	je	.LBB16_184
# BB#183:                               # %if.then566
	movq	stderr(%rip), %rdi
	movq	-24(%rbp), %rax
	movq	(%rax), %rdx
	movsbl	-9(%rbp), %ecx
	movl	$.L.str.11, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB16_184:                             # %if.end570
	movsbl	-9(%rbp), %eax
	movl	%eax, optopt(%rip)
	movq	-72(%rbp), %rax
	cmpb	$58, (%rax)
	jne	.LBB16_186
# BB#185:                               # %if.then576
	movb	$58, -9(%rbp)
	jmp	.LBB16_188
.LBB16_133:                             # %if.else407
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	leal	1(%rcx), %edx
	movl	%edx, optind(%rip)
	movq	(%rax,%rcx,8), %rax
	movq	%rax, optarg(%rip)
.LBB16_134:                             # %if.end412
	movq	optarg(%rip), %rax
	movq	%rax, -88(%rbp)
	movq	%rax, nextchar(%rip)
	jmp	.LBB16_135
	.p2align	4, 0x90
.LBB16_139:                             # %for.inc423
                                        #   in Loop: Header=BB16_135 Depth=1
	incq	-88(%rbp)
.LBB16_135:                             # %for.cond413
                                        # =>This Inner Loop Header: Depth=1
	movq	-88(%rbp), %rax
	cmpb	$0, (%rax)
	je	.LBB16_136
# BB#137:                               # %land.rhs416
                                        #   in Loop: Header=BB16_135 Depth=1
	movq	-88(%rbp), %rax
	cmpb	$61, (%rax)
	setne	-113(%rbp)
	setne	-37(%rbp)
	cmpb	$1, -37(%rbp)
	je	.LBB16_139
	jmp	.LBB16_140
.LBB16_136:                             # %for.cond413.land.end420_crit_edge
                                        #   in Loop: Header=BB16_135 Depth=1
	movb	$0, -37(%rbp)
	cmpb	$1, -37(%rbp)
	je	.LBB16_139
.LBB16_140:                             # %for.end425
	movq	-168(%rbp), %rax
	movq	%rax, -128(%rbp)
	movl	$0, -52(%rbp)
	jmp	.LBB16_141
	.p2align	4, 0x90
.LBB16_153:                             # %for.inc455
                                        #   in Loop: Header=BB16_141 Depth=1
	addq	$32, -128(%rbp)
	incl	-52(%rbp)
.LBB16_141:                             # %for.cond426
                                        # =>This Inner Loop Header: Depth=1
	movq	-128(%rbp), %rax
	cmpq	$0, (%rax)
	je	.LBB16_145
# BB#142:                               # %for.body429
                                        #   in Loop: Header=BB16_141 Depth=1
	movq	-128(%rbp), %rax
	movq	(%rax), %rdi
	movq	nextchar(%rip), %rsi
	movq	-88(%rbp), %rdx
	subq	%rsi, %rdx
	callq	strncmp
	testl	%eax, %eax
	jne	.LBB16_153
# BB#143:                               # %if.then436
                                        #   in Loop: Header=BB16_141 Depth=1
	movl	-88(%rbp), %ebx
	subl	nextchar(%rip), %ebx
	movq	-128(%rbp), %rax
	movq	(%rax), %rdi
	callq	strlen
	cmpq	%rax, %rbx
	je	.LBB16_144
# BB#150:                               # %if.else447
                                        #   in Loop: Header=BB16_141 Depth=1
	cmpq	$0, -64(%rbp)
	je	.LBB16_151
# BB#152:                               # %if.else451
                                        #   in Loop: Header=BB16_141 Depth=1
	movl	$1, -140(%rbp)
	jmp	.LBB16_153
.LBB16_151:                             # %if.then450
                                        #   in Loop: Header=BB16_141 Depth=1
	movq	-128(%rbp), %rax
	movq	%rax, -64(%rbp)
	movl	-52(%rbp), %eax
	movl	%eax, -100(%rbp)
	jmp	.LBB16_153
.LBB16_144:                             # %if.then446
	movq	-128(%rbp), %rax
	movq	%rax, -64(%rbp)
	movl	-52(%rbp), %eax
	movl	%eax, -100(%rbp)
	movl	$1, -144(%rbp)
.LBB16_145:                             # %for.end458
	cmpl	$0, -140(%rbp)
	je	.LBB16_154
# BB#146:                               # %land.lhs.true460
	cmpl	$0, -144(%rbp)
	je	.LBB16_147
.LBB16_154:                             # %if.end473
	cmpq	$0, -64(%rbp)
	je	.LBB16_174
# BB#155:                               # %if.then476
	movl	-100(%rbp), %eax
	movl	%eax, -52(%rbp)
	movq	-88(%rbp), %rax
	cmpb	$0, (%rax)
	je	.LBB16_161
# BB#156:                               # %if.then478
	movq	-64(%rbp), %rax
	cmpl	$0, 8(%rax)
	je	.LBB16_158
# BB#157:                               # %if.then481
	movq	-88(%rbp), %rax
	incq	%rax
.LBB16_164:                             # %if.end522
	movq	%rax, optarg(%rip)
	jmp	.LBB16_165
.LBB16_174:                             # %if.end536
	movq	$0, nextchar(%rip)
	movl	$87, -16(%rbp)
	jmp	.LBB16_191
.LBB16_147:                             # %if.then462
	cmpl	$0, -28(%rbp)
	je	.LBB16_149
# BB#148:                               # %if.then464
	movq	stderr(%rip), %rdi
	movq	-24(%rbp), %rax
	movq	(%rax), %rdx
	movslq	optind(%rip), %rcx
	movq	(%rax,%rcx,8), %rcx
	movl	$.L.str.12, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB16_149:                             # %if.end469
	movq	nextchar(%rip), %rdi
	callq	strlen
	addq	%rax, nextchar(%rip)
	incl	optind(%rip)
	movl	$63, -16(%rbp)
	jmp	.LBB16_191
.LBB16_161:                             # %if.else493
	movq	-64(%rbp), %rax
	cmpl	$1, 8(%rax)
	jne	.LBB16_165
# BB#162:                               # %if.then497
	movl	optind(%rip), %eax
	cmpl	-32(%rbp), %eax
	jge	.LBB16_169
# BB#163:                               # %if.then500
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	leal	1(%rcx), %edx
	movl	%edx, optind(%rip)
	movq	(%rax,%rcx,8), %rax
	jmp	.LBB16_164
.LBB16_165:                             # %if.end522
	movq	nextchar(%rip), %rdi
	callq	strlen
	addq	%rax, nextchar(%rip)
	cmpq	$0, -160(%rbp)
	je	.LBB16_167
# BB#166:                               # %if.then527
	movl	-52(%rbp), %eax
	movq	-160(%rbp), %rcx
	movl	%eax, (%rcx)
.LBB16_167:                             # %if.end528
	movq	-64(%rbp), %rax
	cmpq	$0, 16(%rax)
	je	.LBB16_173
# BB#168:                               # %if.then531
	movq	-64(%rbp), %rax
	jmp	.LBB16_97
.LBB16_187:                             # %if.else579
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	leal	1(%rcx), %edx
	movl	%edx, optind(%rip)
	movq	(%rax,%rcx,8), %rax
	movq	%rax, optarg(%rip)
	jmp	.LBB16_188
.LBB16_173:                             # %if.end534
	movq	-64(%rbp), %rax
	movl	24(%rax), %eax
	jmp	.LBB16_190
.LBB16_132:                             # %if.else404
	movb	$63, -9(%rbp)
	jmp	.LBB16_189
.LBB16_158:                             # %if.else483
	cmpl	$0, -28(%rbp)
	je	.LBB16_160
# BB#159:                               # %if.then485
	movq	stderr(%rip), %rdi
	movq	-24(%rbp), %rax
	movq	(%rax), %rdx
	movq	-64(%rbp), %rax
	movq	(%rax), %rcx
	movl	$.L.str.13, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB16_160:                             # %if.end489
	movq	nextchar(%rip), %rdi
	callq	strlen
	addq	%rax, nextchar(%rip)
	movl	$63, -16(%rbp)
	jmp	.LBB16_191
.LBB16_186:                             # %if.else577
	movb	$63, -9(%rbp)
	jmp	.LBB16_188
.LBB16_169:                             # %if.else504
	cmpl	$0, -28(%rbp)
	je	.LBB16_171
# BB#170:                               # %if.then506
	movq	stderr(%rip), %rdi
	movq	-24(%rbp), %rax
	movq	(%rax), %rdx
	movslq	optind(%rip), %rcx
	movq	-8(%rax,%rcx,8), %rcx
	movl	$.L.str.5, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB16_171:                             # %if.end512
	movq	nextchar(%rip), %rdi
	callq	strlen
	addq	%rax, nextchar(%rip)
	jmp	.LBB16_172
.Lfunc_end16:
	.size	_getopt_internal, .Lfunc_end16-_getopt_internal
	.cfi_endproc

	.p2align	4, 0x90
	.type	_getopt_initialize,@function
_getopt_initialize:                     # @_getopt_initialize
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
	subq	$32, %rsp
	movl	%edi, -12(%rbp)
	movq	%rsi, -24(%rbp)
	movq	%rdx, -8(%rbp)
	movl	optind(%rip), %eax
	movl	%eax, last_nonopt(%rip)
	movl	%eax, first_nonopt(%rip)
	movq	$0, nextchar(%rip)
	movl	$.L.str.83, %edi
	callq	getenv
	movq	%rax, posixly_correct(%rip)
	movq	-8(%rbp), %rax
	cmpb	$45, (%rax)
	jne	.LBB17_2
# BB#1:                                 # %if.then
	movl	$2, ordering(%rip)
	incq	-8(%rbp)
	jmp	.LBB17_7
.LBB17_2:                               # %if.else
	movq	-8(%rbp), %rax
	cmpb	$43, (%rax)
	jne	.LBB17_4
# BB#3:                                 # %if.then6
	movl	$0, ordering(%rip)
	incq	-8(%rbp)
	jmp	.LBB17_7
.LBB17_4:                               # %if.else8
	cmpq	$0, posixly_correct(%rip)
	je	.LBB17_6
# BB#5:                                 # %if.then11
	movl	$0, ordering(%rip)
	jmp	.LBB17_7
.LBB17_6:                               # %if.else12
	movl	$1, ordering(%rip)
.LBB17_7:                               # %if.end14
	movq	-8(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	retq
.Lfunc_end17:
	.size	_getopt_initialize, .Lfunc_end17-_getopt_initialize
	.cfi_endproc

	.p2align	4, 0x90
	.type	exchange,@function
exchange:                               # @exchange
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi59:
	.cfi_def_cfa_offset 16
.Lcfi60:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi61:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -40(%rbp)
	movl	first_nonopt(%rip), %eax
	movl	%eax, -12(%rbp)
	movl	last_nonopt(%rip), %eax
	movl	%eax, -8(%rbp)
	movl	optind(%rip), %eax
	movl	%eax, -16(%rbp)
	jmp	.LBB18_1
	.p2align	4, 0x90
.LBB18_13:                              # %for.end40
                                        #   in Loop: Header=BB18_1 Depth=1
	movl	-44(%rbp), %eax
	addl	%eax, -12(%rbp)
.LBB18_1:                               # %while.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB18_11 Depth 2
                                        #     Child Loop BB18_7 Depth 2
	movl	-16(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jle	.LBB18_2
# BB#3:                                 # %land.rhs
                                        #   in Loop: Header=BB18_1 Depth=1
	movl	-8(%rbp), %eax
	cmpl	-12(%rbp), %eax
	setg	-25(%rbp)
	setg	-1(%rbp)
	cmpb	$1, -1(%rbp)
	je	.LBB18_5
	jmp	.LBB18_14
	.p2align	4, 0x90
.LBB18_2:                               # %while.cond.land.end_crit_edge
                                        #   in Loop: Header=BB18_1 Depth=1
	movb	$0, -1(%rbp)
	cmpb	$1, -1(%rbp)
	jne	.LBB18_14
.LBB18_5:                               # %while.body
                                        #   in Loop: Header=BB18_1 Depth=1
	movl	-16(%rbp), %eax
	movl	-8(%rbp), %ecx
	subl	%ecx, %eax
	subl	-12(%rbp), %ecx
	cmpl	%ecx, %eax
	jle	.LBB18_10
# BB#6:                                 # %if.then
                                        #   in Loop: Header=BB18_1 Depth=1
	movl	-8(%rbp), %eax
	subl	-12(%rbp), %eax
	movl	%eax, -48(%rbp)
	movl	$0, -24(%rbp)
	jmp	.LBB18_7
	.p2align	4, 0x90
.LBB18_8:                               # %for.inc
                                        #   in Loop: Header=BB18_7 Depth=2
	movq	-40(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movslq	-24(%rbp), %rdx
	addq	%rcx, %rdx
	movq	(%rax,%rdx,8), %rax
	movq	%rax, -56(%rbp)
	movq	-40(%rbp), %rax
	movslq	-16(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movslq	-12(%rbp), %rsi
	subq	%rsi, %rdx
	subq	%rdx, %rcx
	movslq	-24(%rbp), %rdx
	addq	%rdx, %rcx
	movq	(%rax,%rcx,8), %rcx
	addq	%rdx, %rsi
	movq	%rcx, (%rax,%rsi,8)
	movq	-56(%rbp), %rax
	movq	-40(%rbp), %rcx
	movslq	-16(%rbp), %rdx
	movslq	-8(%rbp), %rsi
	movslq	-12(%rbp), %rdi
	subq	%rdi, %rsi
	subq	%rsi, %rdx
	movslq	-24(%rbp), %rsi
	addq	%rdx, %rsi
	movq	%rax, (%rcx,%rsi,8)
	incl	-24(%rbp)
.LBB18_7:                               # %for.cond
                                        #   Parent Loop BB18_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-24(%rbp), %eax
	cmpl	-48(%rbp), %eax
	jl	.LBB18_8
# BB#9:                                 # %for.end
                                        #   in Loop: Header=BB18_1 Depth=1
	movl	-48(%rbp), %eax
	subl	%eax, -16(%rbp)
	jmp	.LBB18_1
	.p2align	4, 0x90
.LBB18_10:                              # %if.else
                                        #   in Loop: Header=BB18_1 Depth=1
	movl	-16(%rbp), %eax
	subl	-8(%rbp), %eax
	movl	%eax, -44(%rbp)
	movl	$0, -20(%rbp)
	jmp	.LBB18_11
	.p2align	4, 0x90
.LBB18_12:                              # %for.inc38
                                        #   in Loop: Header=BB18_11 Depth=2
	movq	-40(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movslq	-20(%rbp), %rdx
	addq	%rcx, %rdx
	movq	(%rax,%rdx,8), %rax
	movq	%rax, -56(%rbp)
	movq	-40(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movslq	-20(%rbp), %rdx
	addq	%rdx, %rcx
	movq	(%rax,%rcx,8), %rcx
	movslq	-12(%rbp), %rsi
	addq	%rdx, %rsi
	movq	%rcx, (%rax,%rsi,8)
	movq	-56(%rbp), %rax
	movq	-40(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movslq	-20(%rbp), %rsi
	addq	%rdx, %rsi
	movq	%rax, (%rcx,%rsi,8)
	incl	-20(%rbp)
.LBB18_11:                              # %for.cond23
                                        #   Parent Loop BB18_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-20(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jl	.LBB18_12
	jmp	.LBB18_13
.LBB18_14:                              # %while.end
	movl	optind(%rip), %eax
	subl	last_nonopt(%rip), %eax
	addl	%eax, first_nonopt(%rip)
	movl	optind(%rip), %eax
	movl	%eax, last_nonopt(%rip)
	popq	%rbp
	retq
.Lfunc_end18:
	.size	exchange, .Lfunc_end18-exchange
	.cfi_endproc

	.globl	getopt
	.p2align	4, 0x90
	.type	getopt,@function
getopt:                                 # @getopt
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi62:
	.cfi_def_cfa_offset 16
.Lcfi63:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi64:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movl	-4(%rbp), %edi
	movq	-16(%rbp), %rsi
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	_getopt_internal
	addq	$32, %rsp
	popq	%rbp
	retq
.Lfunc_end19:
	.size	getopt, .Lfunc_end19-getopt
	.cfi_endproc

	.globl	zip
	.p2align	4, 0x90
	.type	zip,@function
zip:                                    # @zip
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi65:
	.cfi_def_cfa_offset 16
.Lcfi66:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi67:
	.cfi_def_cfa_register %rbp
	subq	$160, %rsp
	movl	%edi, -28(%rbp)
	movl	%esi, -12(%rbp)
	movb	$0, -1(%rbp)
	movw	$0, -6(%rbp)
	movw	$0, -4(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, ifd(%rip)
	movl	-12(%rbp), %eax
	movl	%eax, ofd(%rip)
	movl	$0, outcnt(%rip)
	movl	$8, method(%rip)
	movb	.L.str.79(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_2
# BB#1:                                 # %if.then
	callq	flush_outbuf
.LBB20_2:                               # %if.end
	movb	.L.str.79+1(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_4
# BB#3:                                 # %if.then5
	callq	flush_outbuf
.LBB20_4:                               # %if.end6
	movl	outcnt(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, outcnt(%rip)
	movb	$8, outbuf(%rax)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_6
# BB#5:                                 # %if.then11
	callq	flush_outbuf
.LBB20_6:                               # %if.end12
	cmpl	$0, save_orig_name(%rip)
	je	.LBB20_8
# BB#7:                                 # %if.then13
	movzbl	-1(%rbp), %eax
	orl	$8, %eax
	movb	%al, -1(%rbp)
.LBB20_8:                               # %if.end15
	movb	-1(%rbp), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_10
# BB#9:                                 # %if.then21
	callq	flush_outbuf
.LBB20_10:                              # %if.end22
	cmpl	$16381, outcnt(%rip)    # imm = 0x3FFD
	ja	.LBB20_18
# BB#11:                                # %if.then25
	movq	time_stamp(%rip), %rax
	movl	%eax, %ecx
	cmpq	%rcx, %rax
	jne	.LBB20_13
# BB#12:                                # %cond.true
	movq	time_stamp(%rip), %rax
	movq	%rax, -104(%rbp)
	movq	%rax, -40(%rbp)
	jmp	.LBB20_14
.LBB20_18:                              # %if.else
	movq	time_stamp(%rip), %rax
	movl	%eax, %ecx
	cmpq	%rcx, %rax
	jne	.LBB20_20
# BB#19:                                # %cond.true51
	movq	time_stamp(%rip), %rax
	movq	%rax, -120(%rbp)
	movq	%rax, -56(%rbp)
	jmp	.LBB20_21
.LBB20_13:                              # %cond.false
	movq	$0, -40(%rbp)
.LBB20_14:                              # %cond.end
	movb	-40(%rbp), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	movq	time_stamp(%rip), %rax
	movl	%eax, %ecx
	cmpq	%rcx, %rax
	jne	.LBB20_16
# BB#15:                                # %cond.true37
	movq	time_stamp(%rip), %rax
	movq	%rax, -112(%rbp)
	movq	%rax, -48(%rbp)
	jmp	.LBB20_17
.LBB20_20:                              # %cond.false52
	movq	$0, -56(%rbp)
.LBB20_21:                              # %cond.end53
	movb	-56(%rbp), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_23
# BB#22:                                # %if.then63
	callq	flush_outbuf
.LBB20_23:                              # %if.end64
	movq	time_stamp(%rip), %rax
	movl	%eax, %ecx
	cmpq	%rcx, %rax
	jne	.LBB20_25
# BB#24:                                # %cond.true68
	movq	time_stamp(%rip), %rax
	movq	%rax, -128(%rbp)
	movq	%rax, -64(%rbp)
	jmp	.LBB20_26
.LBB20_16:                              # %cond.false38
	movq	$0, -48(%rbp)
.LBB20_17:                              # %cond.end39
	movb	-47(%rbp), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16381, outcnt(%rip)    # imm = 0x3FFD
	jbe	.LBB20_29
	jmp	.LBB20_36
.LBB20_25:                              # %cond.false69
	movq	$0, -64(%rbp)
.LBB20_26:                              # %cond.end70
	movb	-63(%rbp), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_28
# BB#27:                                # %if.then82
	callq	flush_outbuf
.LBB20_28:                              # %if.end84
	cmpl	$16381, outcnt(%rip)    # imm = 0x3FFD
	ja	.LBB20_36
.LBB20_29:                              # %if.then87
	movq	time_stamp(%rip), %rax
	movl	%eax, %ecx
	cmpq	%rcx, %rax
	jne	.LBB20_31
# BB#30:                                # %cond.true91
	movq	time_stamp(%rip), %rax
	movq	%rax, -136(%rbp)
	movq	%rax, -72(%rbp)
	jmp	.LBB20_32
.LBB20_36:                              # %if.else116
	movq	time_stamp(%rip), %rax
	movl	%eax, %ecx
	cmpq	%rcx, %rax
	jne	.LBB20_38
# BB#37:                                # %cond.true120
	movq	time_stamp(%rip), %rax
	movq	%rax, -152(%rbp)
	movq	%rax, -88(%rbp)
	jmp	.LBB20_39
.LBB20_31:                              # %cond.false92
	movq	$0, -72(%rbp)
.LBB20_32:                              # %cond.end93
	movb	-70(%rbp), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	movq	time_stamp(%rip), %rax
	movl	%eax, %ecx
	cmpq	%rcx, %rax
	jne	.LBB20_34
# BB#33:                                # %cond.true104
	movq	time_stamp(%rip), %rax
	movq	%rax, -144(%rbp)
	movq	%rax, -80(%rbp)
	jmp	.LBB20_35
.LBB20_38:                              # %cond.false121
	movq	$0, -88(%rbp)
.LBB20_39:                              # %cond.end122
	movb	-86(%rbp), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_41
# BB#40:                                # %if.then132
	callq	flush_outbuf
.LBB20_41:                              # %if.end133
	movq	time_stamp(%rip), %rax
	movl	%eax, %ecx
	cmpq	%rcx, %rax
	jne	.LBB20_43
# BB#42:                                # %cond.true137
	movq	time_stamp(%rip), %rax
	movq	%rax, -160(%rbp)
	movq	%rax, -96(%rbp)
	jmp	.LBB20_44
.LBB20_34:                              # %cond.false105
	movq	$0, -80(%rbp)
.LBB20_35:                              # %cond.end106
	movb	-77(%rbp), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	jmp	.LBB20_46
.LBB20_43:                              # %cond.false138
	movq	$0, -96(%rbp)
.LBB20_44:                              # %cond.end139
	movb	-93(%rbp), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_46
# BB#45:                                # %if.then151
	callq	flush_outbuf
.LBB20_46:                              # %if.end153
	xorl	%edi, %edi
	xorl	%esi, %esi
	callq	updcrc
	movq	%rax, crc(%rip)
	movl	-12(%rbp), %edi
	callq	bi_init
	leaq	-6(%rbp), %rdi
	movl	$method, %esi
	callq	ct_init
	movl	level(%rip), %edi
	leaq	-4(%rbp), %rsi
	callq	lm_init
	movb	-4(%rbp), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_48
# BB#47:                                # %if.then160
	callq	flush_outbuf
.LBB20_48:                              # %if.end161
	movl	outcnt(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, outcnt(%rip)
	movb	$3, outbuf(%rax)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_50
# BB#49:                                # %if.then167
	callq	flush_outbuf
.LBB20_50:                              # %if.end168
	cmpl	$0, save_orig_name(%rip)
	je	.LBB20_55
# BB#51:                                # %if.then170
	movl	$ifname, %edi
	callq	base_name
	movq	%rax, -24(%rbp)
	.p2align	4, 0x90
.LBB20_52:                              # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_54
# BB#53:                                # %if.then177
                                        #   in Loop: Header=BB20_52 Depth=1
	callq	flush_outbuf
.LBB20_54:                              # %do.cond
                                        #   in Loop: Header=BB20_52 Depth=1
	movq	-24(%rbp), %rax
	leaq	1(%rax), %rcx
	movq	%rcx, -24(%rbp)
	cmpb	$0, (%rax)
	jne	.LBB20_52
.LBB20_55:                              # %if.end180
	movl	outcnt(%rip), %eax
	movq	%rax, header_bytes(%rip)
	callq	deflate
	cmpl	$16381, outcnt(%rip)    # imm = 0x3FFD
	ja	.LBB20_57
# BB#56:                                # %if.then185
	movb	crc(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	movb	crc+1(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16381, outcnt(%rip)    # imm = 0x3FFD
	jbe	.LBB20_62
	jmp	.LBB20_63
.LBB20_57:                              # %if.else200
	movb	crc(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_59
# BB#58:                                # %if.then209
	callq	flush_outbuf
.LBB20_59:                              # %if.end210
	movb	crc+1(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_61
# BB#60:                                # %if.then221
	callq	flush_outbuf
.LBB20_61:                              # %if.end223
	cmpl	$16381, outcnt(%rip)    # imm = 0x3FFD
	ja	.LBB20_63
.LBB20_62:                              # %if.then226
	movb	crc+2(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	movb	crc+3(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16381, outcnt(%rip)    # imm = 0x3FFD
	jbe	.LBB20_68
	jmp	.LBB20_69
.LBB20_63:                              # %if.else241
	movb	crc+2(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_65
# BB#64:                                # %if.then250
	callq	flush_outbuf
.LBB20_65:                              # %if.end251
	movb	crc+3(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_67
# BB#66:                                # %if.then262
	callq	flush_outbuf
.LBB20_67:                              # %if.end264
	cmpl	$16381, outcnt(%rip)    # imm = 0x3FFD
	ja	.LBB20_69
.LBB20_68:                              # %if.then267
	movb	bytes_in(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	movb	bytes_in+1(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16381, outcnt(%rip)    # imm = 0x3FFD
	jbe	.LBB20_74
	jmp	.LBB20_75
.LBB20_69:                              # %if.else282
	movb	bytes_in(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_71
# BB#70:                                # %if.then291
	callq	flush_outbuf
.LBB20_71:                              # %if.end292
	movb	bytes_in+1(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_73
# BB#72:                                # %if.then303
	callq	flush_outbuf
.LBB20_73:                              # %if.end305
	cmpl	$16381, outcnt(%rip)    # imm = 0x3FFD
	ja	.LBB20_75
.LBB20_74:                              # %if.then308
	movb	bytes_in+2(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	movb	bytes_in+3(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	jmp	.LBB20_79
.LBB20_75:                              # %if.else323
	movb	bytes_in+2(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_77
# BB#76:                                # %if.then332
	callq	flush_outbuf
.LBB20_77:                              # %if.end333
	movb	bytes_in+3(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_79
# BB#78:                                # %if.then344
	callq	flush_outbuf
.LBB20_79:                              # %if.end346
	addq	$16, header_bytes(%rip)
	callq	flush_outbuf
	xorl	%eax, %eax
	addq	$160, %rsp
	popq	%rbp
	retq
.Lfunc_end20:
	.size	zip, .Lfunc_end20-zip
	.cfi_endproc

	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi68:
	.cfi_def_cfa_offset 16
.Lcfi69:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi70:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	$0, -28(%rbp)
	movl	%edi, -4(%rbp)
	movq	%rsi, -24(%rbp)
	movq	(%rsi), %rdi
	callq	base_name
	movq	%rax, progname(%rip)
	movq	%rax, %rdi
	callq	strlen
	movl	%eax, -12(%rbp)
	cmpl	$5, %eax
	jl	.LBB21_3
# BB#1:                                 # %land.lhs.true
	movq	progname(%rip), %rax
	movslq	-12(%rbp), %rcx
	leaq	-4(%rax,%rcx), %rdi
	movl	$.L.str.38, %esi
	callq	strcmp
	testl	%eax, %eax
	jne	.LBB21_3
# BB#2:                                 # %if.then
	movq	progname(%rip), %rax
	movslq	-12(%rbp), %rcx
	movb	$0, -4(%rax,%rcx)
.LBB21_3:                               # %if.end
	leaq	-4(%rbp), %rdi
	leaq	-24(%rbp), %rsi
	movl	$.L.str.39, %edx
	callq	add_envopt
	movq	%rax, env(%rip)
	testq	%rax, %rax
	je	.LBB21_5
# BB#4:                                 # %if.then11
	movq	-24(%rbp), %rax
	movq	%rax, args(%rip)
.LBB21_5:                               # %if.end12
	movl	$2, %edi
	movl	$1, %esi
	callq	signal
	xorl	%ecx, %ecx
	cmpq	$1, %rax
	setne	%cl
	movl	%ecx, foreground(%rip)
	je	.LBB21_7
# BB#6:                                 # %if.then16
	movl	$2, %edi
	movl	$abort_gzip_signal, %esi
	callq	signal
.LBB21_7:                               # %if.end18
	movl	$15, %edi
	movl	$1, %esi
	callq	signal
	cmpq	$1, %rax
	je	.LBB21_9
# BB#8:                                 # %if.then22
	movl	$15, %edi
	movl	$abort_gzip_signal, %esi
	callq	signal
.LBB21_9:                               # %if.end24
	movl	$1, %edi
	movl	$1, %esi
	callq	signal
	cmpq	$1, %rax
	je	.LBB21_11
# BB#10:                                # %if.then28
	movl	$1, %edi
	movl	$abort_gzip_signal, %esi
	callq	signal
.LBB21_11:                              # %if.end30
	movq	progname(%rip), %rdi
	movl	$.L.str.40, %esi
	movl	$2, %edx
	callq	strncmp
	testl	%eax, %eax
	je	.LBB21_16
# BB#12:                                # %lor.lhs.false
	movq	progname(%rip), %rdi
	movl	$.L.str.41, %esi
	movl	$3, %edx
	callq	strncmp
	testl	%eax, %eax
	je	.LBB21_16
# BB#13:                                # %if.else
	movq	progname(%rip), %rdi
	incq	%rdi
	movl	$.L.str.42, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB21_15
# BB#14:                                # %lor.lhs.false42
	movq	progname(%rip), %rdi
	movl	$.L.str.43, %esi
	callq	strcmp
	testl	%eax, %eax
	jne	.LBB21_17
.LBB21_15:                              # %if.then46
	movl	$1, to_stdout(%rip)
.LBB21_16:                              # %if.end48
	movl	$1, decompress(%rip)
.LBB21_17:                              # %if.end48
	movq	$.L.str.44, z_suffix(%rip)
	movl	$.L.str.44, %edi
	callq	strlen
	movq	%rax, z_len(%rip)
	jmp	.LBB21_18
	.p2align	4, 0x90
.LBB21_46:                              # %sw.bb87
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	-8(%rbp), %eax
	addl	$-48, %eax
	movl	%eax, level(%rip)
.LBB21_18:                              # %while.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB21_23 Depth 2
	movl	-4(%rbp), %edi
	movq	-24(%rbp), %rsi
	movl	$.L.str.45, %edx
	movl	$longopts, %ecx
	xorl	%r8d, %r8d
	callq	getopt_long
	movl	%eax, -8(%rbp)
	cmpl	$-1, %eax
	je	.LBB21_49
# BB#19:                                # %while.body
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	-8(%rbp), %eax
	addl	$-49, %eax
	cmpl	$69, %eax
	ja	.LBB21_48
# BB#20:                                # %while.body
                                        #   in Loop: Header=BB21_18 Depth=1
	jmpq	*.LJTI21_0(,%rax,8)
.LBB21_31:                              # %sw.bb69
                                        #   in Loop: Header=BB21_18 Depth=1
	callq	help
	jmp	.LBB21_32
.LBB21_34:                              # %sw.bb71
                                        #   in Loop: Header=BB21_18 Depth=1
	callq	license
	jmp	.LBB21_32
.LBB21_36:                              # %sw.bb73
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$0, no_time(%rip)
	jmp	.LBB21_18
.LBB21_38:                              # %sw.bb75
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$0, no_time(%rip)
	movl	$0, no_name(%rip)
	jmp	.LBB21_18
.LBB21_41:                              # %sw.bb78
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, rsync(%rip)
	jmp	.LBB21_18
.LBB21_42:                              # %sw.bb79
                                        #   in Loop: Header=BB21_18 Depth=1
	movq	optarg(%rip), %rdi
	callq	strlen
	movq	%rax, z_len(%rip)
	movq	optarg(%rip), %rax
	movq	%rax, z_suffix(%rip)
	jmp	.LBB21_18
.LBB21_45:                              # %sw.bb84
                                        #   in Loop: Header=BB21_18 Depth=1
	callq	version
.LBB21_32:                              # %while.cond
                                        #   in Loop: Header=BB21_18 Depth=1
	xorl	%edi, %edi
	callq	do_exit
	jmp	.LBB21_18
.LBB21_47:                              # %sw.bb85
                                        #   in Loop: Header=BB21_18 Depth=1
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.47, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB21_48:                              # %sw.default
                                        #   in Loop: Header=BB21_18 Depth=1
	callq	usage
	movl	$1, %edi
	callq	do_exit
	jmp	.LBB21_18
.LBB21_21:                              # %sw.bb
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, ascii(%rip)
	jmp	.LBB21_18
.LBB21_22:                              # %sw.bb53
                                        #   in Loop: Header=BB21_18 Depth=1
	movq	optarg(%rip), %rdi
	callq	atoi
	movl	%eax, maxbits(%rip)
	jmp	.LBB21_23
	.p2align	4, 0x90
.LBB21_27:                              # %for.inc
                                        #   in Loop: Header=BB21_23 Depth=2
	incq	optarg(%rip)
.LBB21_23:                              # %for.cond
                                        #   Parent Loop BB21_18 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	optarg(%rip), %rax
	cmpb	$0, (%rax)
	je	.LBB21_18
# BB#24:                                # %for.body
                                        #   in Loop: Header=BB21_23 Depth=2
	movq	optarg(%rip), %rax
	movsbl	(%rax), %eax
	cmpl	$48, %eax
	jl	.LBB21_26
# BB#25:                                # %land.lhs.true59
                                        #   in Loop: Header=BB21_23 Depth=2
	movq	optarg(%rip), %rax
	movsbl	(%rax), %eax
	cmpl	$58, %eax
	jl	.LBB21_27
.LBB21_26:                              # %if.then63
                                        #   in Loop: Header=BB21_23 Depth=2
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.46, %esi
	xorl	%eax, %eax
	callq	fprintf
	callq	usage
	movl	$1, %edi
	callq	do_exit
	jmp	.LBB21_27
.LBB21_28:                              # %sw.bb66
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, to_stdout(%rip)
	jmp	.LBB21_18
.LBB21_29:                              # %sw.bb67
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, decompress(%rip)
	jmp	.LBB21_18
.LBB21_30:                              # %sw.bb68
                                        #   in Loop: Header=BB21_18 Depth=1
	incl	force(%rip)
	jmp	.LBB21_18
.LBB21_33:                              # %sw.bb70
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, to_stdout(%rip)
	movl	$1, decompress(%rip)
	movl	$1, list(%rip)
	jmp	.LBB21_18
.LBB21_35:                              # %sw.bb72
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, no_time(%rip)
	jmp	.LBB21_18
.LBB21_37:                              # %sw.bb74
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, no_time(%rip)
	movl	$1, no_name(%rip)
	jmp	.LBB21_18
.LBB21_39:                              # %sw.bb76
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, quiet(%rip)
	movl	$0, verbose(%rip)
	jmp	.LBB21_18
.LBB21_40:                              # %sw.bb77
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, recursive(%rip)
	jmp	.LBB21_18
.LBB21_43:                              # %sw.bb81
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, to_stdout(%rip)
	movl	$1, decompress(%rip)
	movl	$1, test(%rip)
	jmp	.LBB21_18
.LBB21_44:                              # %sw.bb82
                                        #   in Loop: Header=BB21_18 Depth=1
	incl	verbose(%rip)
	movl	$0, quiet(%rip)
	jmp	.LBB21_18
.LBB21_49:                              # %while.end
	cmpl	$0, quiet(%rip)
	je	.LBB21_52
# BB#50:                                # %land.lhs.true90
	movl	$13, %edi
	movl	$1, %esi
	callq	signal
	cmpq	$1, %rax
	je	.LBB21_52
# BB#51:                                # %if.then94
	movl	$13, %edi
	movl	$abort_gzip_signal, %esi
	callq	signal
.LBB21_52:                              # %if.end96
	cmpl	$0, no_time(%rip)
	jns	.LBB21_54
# BB#53:                                # %if.then99
	movl	decompress(%rip), %eax
	movl	%eax, no_time(%rip)
.LBB21_54:                              # %if.end100
	cmpl	$0, no_name(%rip)
	jns	.LBB21_56
# BB#55:                                # %if.then103
	movl	decompress(%rip), %eax
	movl	%eax, no_name(%rip)
.LBB21_56:                              # %if.end104
	movl	-4(%rbp), %eax
	subl	optind(%rip), %eax
	movl	%eax, -16(%rbp)
	cmpl	$0, ascii(%rip)
	je	.LBB21_59
# BB#57:                                # %land.lhs.true107
	cmpl	$0, quiet(%rip)
	jne	.LBB21_59
# BB#58:                                # %if.then109
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.48, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB21_59:                              # %if.end111
	cmpq	$0, z_len(%rip)
	jne	.LBB21_61
# BB#60:                                # %land.lhs.true114
	cmpl	$0, decompress(%rip)
	je	.LBB21_62
.LBB21_61:                              # %lor.lhs.false116
	cmpq	$31, z_len(%rip)
	jb	.LBB21_63
.LBB21_62:                              # %if.then119
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movq	z_suffix(%rip), %rcx
	movl	$.L.str.49, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, %edi
	callq	do_exit
.LBB21_63:                              # %if.end121
	cmpl	$0, do_lzw(%rip)
	je	.LBB21_66
# BB#64:                                # %land.lhs.true123
	cmpl	$0, decompress(%rip)
	jne	.LBB21_66
# BB#65:                                # %if.then125
	movq	$lzw, work(%rip)
.LBB21_66:                              # %if.end126
	cmpl	$0, -16(%rbp)
	je	.LBB21_73
# BB#67:                                # %if.then129
	cmpl	$0, to_stdout(%rip)
	je	.LBB21_71
# BB#68:                                # %land.lhs.true131
	cmpl	$0, test(%rip)
	jne	.LBB21_71
# BB#69:                                # %land.lhs.true133
	cmpl	$0, list(%rip)
	jne	.LBB21_71
# BB#70:                                # %land.lhs.true135
	cmpl	$0, decompress(%rip)
	jmp	.LBB21_71
	.p2align	4, 0x90
.LBB21_72:                              # %while.body144
                                        #   in Loop: Header=BB21_71 Depth=1
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	leal	1(%rcx), %edx
	movl	%edx, optind(%rip)
	movq	(%rax,%rcx,8), %rdi
	callq	treat_file
.LBB21_71:                              # %while.cond141
                                        # =>This Inner Loop Header: Depth=1
	movl	optind(%rip), %eax
	cmpl	-4(%rbp), %eax
	jl	.LBB21_72
	jmp	.LBB21_74
.LBB21_73:                              # %if.else149
	callq	treat_stdin
.LBB21_74:                              # %if.end150
	cmpl	$0, list(%rip)
	je	.LBB21_78
# BB#75:                                # %land.lhs.true152
	cmpl	$0, quiet(%rip)
	jne	.LBB21_78
# BB#76:                                # %land.lhs.true154
	cmpl	$2, -16(%rbp)
	jl	.LBB21_78
# BB#77:                                # %if.then157
	movl	$-1, %edi
	movl	$-1, %esi
	callq	do_list
.LBB21_78:                              # %if.end158
	movl	exit_code(%rip), %edi
	callq	do_exit
	movl	exit_code(%rip), %eax
	addq	$32, %rsp
	popq	%rbp
	retq
.Lfunc_end21:
	.size	main, .Lfunc_end21-main
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	3
.LJTI21_0:
	.quad	.LBB21_46
	.quad	.LBB21_46
	.quad	.LBB21_46
	.quad	.LBB21_46
	.quad	.LBB21_46
	.quad	.LBB21_46
	.quad	.LBB21_46
	.quad	.LBB21_46
	.quad	.LBB21_46
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_31
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_31
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_34
	.quad	.LBB21_36
	.quad	.LBB21_38
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_41
	.quad	.LBB21_42
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_45
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_47
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_21
	.quad	.LBB21_22
	.quad	.LBB21_28
	.quad	.LBB21_29
	.quad	.LBB21_48
	.quad	.LBB21_30
	.quad	.LBB21_48
	.quad	.LBB21_31
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_33
	.quad	.LBB21_35
	.quad	.LBB21_37
	.quad	.LBB21_48
	.quad	.LBB21_48
	.quad	.LBB21_39
	.quad	.LBB21_40
	.quad	.LBB21_48
	.quad	.LBB21_43
	.quad	.LBB21_48
	.quad	.LBB21_44

	.text
	.globl	base_name
	.p2align	4, 0x90
	.type	base_name,@function
base_name:                              # @base_name
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi71:
	.cfi_def_cfa_offset 16
.Lcfi72:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi73:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$47, %esi
	callq	strrchr
	movq	%rax, -16(%rbp)
	testq	%rax, %rax
	je	.LBB22_2
# BB#1:                                 # %if.then
	movq	-16(%rbp), %rax
	incq	%rax
	movq	%rax, -8(%rbp)
.LBB22_2:                               # %if.end
	movq	-8(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end22:
	.size	base_name, .Lfunc_end22-base_name
	.cfi_endproc

	.globl	add_envopt
	.p2align	4, 0x90
	.type	add_envopt,@function
add_envopt:                             # @add_envopt
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi74:
	.cfi_def_cfa_offset 16
.Lcfi75:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi76:
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -48(%rbp)
	movq	%rsi, -64(%rbp)
	movq	%rdx, -32(%rbp)
	movq	-48(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -16(%rbp)
	movl	$0, -12(%rbp)
	movq	-32(%rbp), %rdi
	callq	getenv
	movq	%rax, -32(%rbp)
	testq	%rax, %rax
	je	.LBB23_21
# BB#1:                                 # %if.end
	movq	-32(%rbp), %rdi
	callq	strlen
	leal	1(%rax), %edi
	callq	xmalloc
	movq	%rax, -8(%rbp)
	movq	-32(%rbp), %rsi
	movq	%rax, %rdi
	callq	strcpy
	movq	%rax, -32(%rbp)
	movq	%rax, -8(%rbp)
	jmp	.LBB23_3
	.p2align	4, 0x90
.LBB23_2:                               # %for.inc
                                        #   in Loop: Header=BB23_3 Depth=1
	incl	-12(%rbp)
.LBB23_3:                               # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpb	$0, (%rax)
	je	.LBB23_7
# BB#4:                                 # %for.body
                                        #   in Loop: Header=BB23_3 Depth=1
	movq	-8(%rbp), %rdi
	movl	$.L.str.71, %esi
	callq	strspn
	movq	-8(%rbp), %rcx
	leaq	(%rcx,%rax), %rdx
	movq	%rdx, -8(%rbp)
	cmpb	$0, (%rcx,%rax)
	je	.LBB23_7
# BB#5:                                 # %if.end9
                                        #   in Loop: Header=BB23_3 Depth=1
	movq	-8(%rbp), %rdi
	movl	$.L.str.71, %esi
	callq	strcspn
	movq	-8(%rbp), %rcx
	leaq	(%rcx,%rax), %rdx
	movq	%rdx, -8(%rbp)
	cmpb	$0, (%rcx,%rax)
	je	.LBB23_2
# BB#6:                                 # %if.then13
                                        #   in Loop: Header=BB23_3 Depth=1
	movq	-8(%rbp), %rax
	leaq	1(%rax), %rcx
	movq	%rcx, -8(%rbp)
	movb	$0, (%rax)
	jmp	.LBB23_2
.LBB23_7:                               # %for.end
	cmpl	$0, -12(%rbp)
	je	.LBB23_20
# BB#8:                                 # %if.end18
	movl	-12(%rbp), %eax
	movq	-48(%rbp), %rcx
	addl	%eax, (%rcx)
	movq	-48(%rbp), %rax
	movslq	(%rax), %rdi
	incq	%rdi
	movl	$8, %esi
	callq	calloc
	movq	%rax, -24(%rbp)
	testq	%rax, %rax
	jne	.LBB23_10
# BB#9:                                 # %if.then25
	movl	$.L.str.62, %edi
	callq	error
.LBB23_10:                              # %if.end26
	movq	-64(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-24(%rbp), %rax
	movq	-64(%rbp), %rcx
	movq	%rax, (%rcx)
	movl	-16(%rbp), %eax
	leal	-1(%rax), %ecx
	movl	%ecx, -16(%rbp)
	testl	%eax, %eax
	jns	.LBB23_12
# BB#11:                                # %if.then29
	movl	$.L.str.72, %edi
	callq	error
.LBB23_12:                              # %if.end30
	movq	-40(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	%rcx, -40(%rbp)
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	leaq	8(%rcx), %rdx
	movq	%rdx, -24(%rbp)
	movq	%rax, (%rcx)
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	cmpl	$0, -12(%rbp)
	jle	.LBB23_17
	.p2align	4, 0x90
.LBB23_14:                              # %for.body36
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB23_15 Depth 2
	movq	-8(%rbp), %rdi
	movl	$.L.str.71, %esi
	callq	strspn
	addq	-8(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-24(%rbp), %rcx
	leaq	8(%rcx), %rdx
	movq	%rdx, -24(%rbp)
	movq	%rax, (%rcx)
	.p2align	4, 0x90
.LBB23_15:                              # %while.cond
                                        #   Parent Loop BB23_14 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-8(%rbp), %rax
	leaq	1(%rax), %rcx
	movq	%rcx, -8(%rbp)
	cmpb	$0, (%rax)
	jne	.LBB23_15
# BB#13:                                # %for.inc42
                                        #   in Loop: Header=BB23_14 Depth=1
	decl	-12(%rbp)
	cmpl	$0, -12(%rbp)
	jg	.LBB23_14
	jmp	.LBB23_17
	.p2align	4, 0x90
.LBB23_16:                              # %while.body48
                                        #   in Loop: Header=BB23_17 Depth=1
	movq	-40(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	%rcx, -40(%rbp)
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	leaq	8(%rcx), %rdx
	movq	%rdx, -24(%rbp)
	movq	%rax, (%rcx)
.LBB23_17:                              # %while.cond45
                                        # =>This Inner Loop Header: Depth=1
	movl	-16(%rbp), %eax
	leal	-1(%rax), %ecx
	movl	%ecx, -16(%rbp)
	testl	%eax, %eax
	jne	.LBB23_16
# BB#18:                                # %while.end51
	movq	-24(%rbp), %rax
	movq	$0, (%rax)
	movq	-32(%rbp), %rax
	movq	%rax, -56(%rbp)
	jmp	.LBB23_22
.LBB23_20:                              # %if.then17
	movq	-32(%rbp), %rdi
	callq	free
.LBB23_21:                              # %return
	movq	$0, -56(%rbp)
.LBB23_22:                              # %return
	movq	-56(%rbp), %rax
	addq	$64, %rsp
	popq	%rbp
	retq
.Lfunc_end23:
	.size	add_envopt, .Lfunc_end23-add_envopt
	.cfi_endproc

	.globl	abort_gzip_signal
	.p2align	4, 0x90
	.type	abort_gzip_signal,@function
abort_gzip_signal:                      # @abort_gzip_signal
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi77:
	.cfi_def_cfa_offset 16
.Lcfi78:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi79:
	.cfi_def_cfa_register %rbp
	callq	do_remove
	movl	$1, %edi
	callq	_exit
.Lfunc_end24:
	.size	abort_gzip_signal, .Lfunc_end24-abort_gzip_signal
	.cfi_endproc

	.globl	getopt_long
	.p2align	4, 0x90
	.type	getopt_long,@function
getopt_long:                            # @getopt_long
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
	subq	$48, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -16(%rbp)
	movq	%r8, -40(%rbp)
	movl	-4(%rbp), %edi
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rcx
	xorl	%r9d, %r9d
	callq	_getopt_internal
	addq	$48, %rsp
	popq	%rbp
	retq
.Lfunc_end25:
	.size	getopt_long, .Lfunc_end25-getopt_long
	.cfi_endproc

	.p2align	4, 0x90
	.type	usage,@function
usage:                                  # @usage
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
	movq	progname(%rip), %rsi
	movl	$.L.str.84, %edi
	movl	$.L.str.8, %edx
	movl	$.L.str.85, %ecx
	xorl	%eax, %eax
	callq	printf
	popq	%rbp
	retq
.Lfunc_end26:
	.size	usage, .Lfunc_end26-usage
	.cfi_endproc

	.p2align	4, 0x90
	.type	do_exit,@function
do_exit:                                # @do_exit
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi86:
	.cfi_def_cfa_offset 16
.Lcfi87:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi88:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	cmpl	$0, do_exit.in_exit(%rip)
	jne	.LBB27_5
# BB#1:                                 # %if.end
	movl	$1, do_exit.in_exit(%rip)
	cmpq	$0, env(%rip)
	je	.LBB27_3
# BB#2:                                 # %if.then1
	movq	env(%rip), %rdi
	callq	free
	movq	$0, env(%rip)
.LBB27_3:                               # %if.end2
	cmpq	$0, args(%rip)
	je	.LBB27_5
# BB#4:                                 # %if.then4
	movq	args(%rip), %rdi
	callq	free
	movq	$0, args(%rip)
.LBB27_5:                               # %if.then
	movl	-4(%rbp), %edi
	callq	exit
.Lfunc_end27:
	.size	do_exit, .Lfunc_end27-do_exit
	.cfi_endproc

	.p2align	4, 0x90
	.type	help,@function
help:                                   # @help
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi89:
	.cfi_def_cfa_offset 16
.Lcfi90:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi91:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	$help.help_msg, -8(%rbp)
	movq	progname(%rip), %rsi
	movl	$.L.str.105, %edi
	movl	$.L.str.106, %edx
	movl	$.L.str.107, %ecx
	xorl	%eax, %eax
	callq	printf
	callq	usage
	jmp	.LBB28_1
	.p2align	4, 0x90
.LBB28_2:                               # %while.body
                                        #   in Loop: Header=BB28_1 Depth=1
	movq	-8(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	%rcx, -8(%rbp)
	movq	(%rax), %rsi
	movl	$.L.str.108, %edi
	xorl	%eax, %eax
	callq	printf
.LBB28_1:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpq	$0, (%rax)
	jne	.LBB28_2
# BB#3:                                 # %while.end
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end28:
	.size	help, .Lfunc_end28-help
	.cfi_endproc

	.p2align	4, 0x90
	.type	license,@function
license:                                # @license
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi92:
	.cfi_def_cfa_offset 16
.Lcfi93:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi94:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	$license_msg, -8(%rbp)
	movq	progname(%rip), %rsi
	movl	$.L.str.105, %edi
	movl	$.L.str.106, %edx
	movl	$.L.str.107, %ecx
	xorl	%eax, %eax
	callq	printf
	jmp	.LBB29_1
	.p2align	4, 0x90
.LBB29_2:                               # %while.body
                                        #   in Loop: Header=BB29_1 Depth=1
	movq	-8(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	%rcx, -8(%rbp)
	movq	(%rax), %rsi
	movl	$.L.str.108, %edi
	xorl	%eax, %eax
	callq	printf
.LBB29_1:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpq	$0, (%rax)
	jne	.LBB29_2
# BB#3:                                 # %while.end
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end29:
	.size	license, .Lfunc_end29-license
	.cfi_endproc

	.p2align	4, 0x90
	.type	version,@function
version:                                # @version
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi95:
	.cfi_def_cfa_offset 16
.Lcfi96:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi97:
	.cfi_def_cfa_register %rbp
	callq	license
	movl	$.L.str.115, %edi
	movl	$.L.str.116, %esi
	movl	$.L.str.117, %edx
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str.118, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str.119, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str.120, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str.121, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str.122, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str.123, %edi
	xorl	%eax, %eax
	callq	printf
	movl	$.L.str.124, %edi
	xorl	%eax, %eax
	callq	printf
	popq	%rbp
	retq
.Lfunc_end30:
	.size	version, .Lfunc_end30-version
	.cfi_endproc

	.globl	lzw
	.p2align	4, 0x90
	.type	lzw,@function
lzw:                                    # @lzw
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi98:
	.cfi_def_cfa_offset 16
.Lcfi99:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi100:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -12(%rbp)
	movl	%esi, -8(%rbp)
	cmpl	$0, msg_done(%rip)
	jne	.LBB31_3
# BB#1:                                 # %if.end
	movl	$1, msg_done(%rip)
	movq	stderr(%rip), %rdi
	movl	$.L.str.52, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	-12(%rbp), %eax
	cmpl	-8(%rbp), %eax
	je	.LBB31_3
# BB#2:                                 # %if.then1
	movl	$1, exit_code(%rip)
.LBB31_3:                               # %if.end2
	movl	$1, -4(%rbp)
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end31:
	.size	lzw, .Lfunc_end31-lzw
	.cfi_endproc

	.p2align	4, 0x90
	.type	treat_file,@function
treat_file:                             # @treat_file
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi101:
	.cfi_def_cfa_offset 16
.Lcfi102:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi103:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$184, %rsp
.Lcfi104:
	.cfi_offset %rbx, -24
	movq	%rdi, -24(%rbp)
	movl	$.L.str.149, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB32_1
# BB#2:                                 # %if.end
	movq	-24(%rbp), %rdi
	movl	$istat, %esi
	callq	get_istat
	testl	%eax, %eax
	jne	.LBB32_75
# BB#3:                                 # %if.end4
	movl	$61440, %eax            # imm = 0xF000
	movl	istat+24(%rip), %ecx
	andl	%eax, %ecx
	cmpl	$16384, %ecx            # imm = 0x4000
	jne	.LBB32_10
# BB#4:                                 # %if.then6
	cmpl	$0, recursive(%rip)
	je	.LBB32_6
# BB#5:                                 # %if.then7
	leaq	-192(%rbp), %rbx
	movl	$istat, %esi
	movl	$144, %edx
	movq	%rbx, %rdi
	callq	memcpy
	movq	-24(%rbp), %rdi
	callq	treat_dir
	movq	-24(%rbp), %rdi
	movq	%rbx, %rsi
	callq	reset_times
	jmp	.LBB32_75
.LBB32_1:                               # %if.then
	movl	to_stdout(%rip), %eax
	movl	%eax, -28(%rbp)
	callq	treat_stdin
	movl	-28(%rbp), %eax
	movl	%eax, to_stdout(%rip)
.LBB32_75:                              # %if.end155
	addq	$184, %rsp
	popq	%rbx
	popq	%rbp
	retq
.LBB32_10:                              # %if.end16
	andl	istat+24(%rip), %eax
	cmpl	$32768, %eax            # imm = 0x8000
	jne	.LBB32_11
# BB#15:                                # %if.end27
	cmpq	$2, istat+16(%rip)
	jb	.LBB32_22
# BB#16:                                # %land.lhs.true
	cmpl	$0, to_stdout(%rip)
	jne	.LBB32_22
# BB#17:                                # %land.lhs.true30
	cmpl	$0, force(%rip)
	je	.LBB32_18
.LBB32_22:                              # %if.end41
	movq	istat+48(%rip), %rax
	movq	%rax, ifile_size(%rip)
	cmpl	$0, no_time(%rip)
	je	.LBB32_25
# BB#23:                                # %land.lhs.true43
	cmpl	$0, list(%rip)
	je	.LBB32_24
.LBB32_25:                              # %cond.false
	movq	istat+88(%rip), %rax
	movq	%rax, -48(%rbp)
	movq	%rax, -40(%rbp)
	jmp	.LBB32_26
.LBB32_11:                              # %if.then19
	cmpl	$0, quiet(%rip)
	jne	.LBB32_13
# BB#12:                                # %if.then21
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.151, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB32_13:                              # %if.end23
	cmpl	$0, exit_code(%rip)
	jne	.LBB32_75
# BB#14:                                # %if.then25
	movl	$2, exit_code(%rip)
	jmp	.LBB32_75
.LBB32_6:                               # %if.else
	cmpl	$0, quiet(%rip)
	jne	.LBB32_8
# BB#7:                                 # %if.then9
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.150, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB32_8:                               # %if.end11
	cmpl	$0, exit_code(%rip)
	jne	.LBB32_75
# BB#9:                                 # %if.then13
	movl	$2, exit_code(%rip)
	jmp	.LBB32_75
.LBB32_24:                              # %cond.true
	movq	$0, -40(%rbp)
.LBB32_26:                              # %cond.end
	movq	-40(%rbp), %rax
	movq	%rax, time_stamp(%rip)
	cmpl	$0, to_stdout(%rip)
	je	.LBB32_30
# BB#27:                                # %land.lhs.true47
	cmpl	$0, list(%rip)
	jne	.LBB32_30
# BB#28:                                # %land.lhs.true49
	cmpl	$0, test(%rip)
	je	.LBB32_29
.LBB32_30:                              # %if.else53
	callq	make_ofname
	testl	%eax, %eax
	jne	.LBB32_75
	jmp	.LBB32_31
.LBB32_29:                              # %if.then51
	movl	$ofname, %edi
	movl	$.L.str.16, %esi
	callq	strcpy
.LBB32_31:                              # %if.end58
	cmpl	$0, ascii(%rip)
	je	.LBB32_32
# BB#33:                                # %land.rhs
	cmpl	$0, decompress(%rip)
	sete	-10(%rbp)
	sete	-9(%rbp)
	jmp	.LBB32_34
.LBB32_32:                              # %if.end58.land.end_crit_edge
	movb	$0, -9(%rbp)
.LBB32_34:                              # %land.end
	movl	$ifname, %edi
	xorl	%esi, %esi
	movl	$384, %edx              # imm = 0x180
	xorl	%eax, %eax
	callq	open
	movl	%eax, ifd(%rip)
	cmpl	$-1, %eax
	je	.LBB32_35
# BB#36:                                # %if.end65
	callq	clear_bufs
	movl	$0, part_nb(%rip)
	cmpl	$0, decompress(%rip)
	je	.LBB32_39
# BB#37:                                # %if.then67
	movl	ifd(%rip), %edi
	callq	get_method
	movl	%eax, method(%rip)
	testl	%eax, %eax
	js	.LBB32_38
.LBB32_39:                              # %if.end73
	cmpl	$0, list(%rip)
	je	.LBB32_41
# BB#40:                                # %if.then75
	movl	ifd(%rip), %edi
	movl	method(%rip), %esi
	callq	do_list
.LBB32_38:                              # %if.then70
	movl	ifd(%rip), %edi
	callq	close
	jmp	.LBB32_75
.LBB32_35:                              # %if.then64
	movl	$ifname, %edi
	callq	progerror
	jmp	.LBB32_75
.LBB32_41:                              # %if.end77
	cmpl	$0, to_stdout(%rip)
	je	.LBB32_43
# BB#42:                                # %if.then79
	movq	stdout(%rip), %rdi
	callq	fileno
	movl	%eax, ofd(%rip)
.LBB32_49:                              # %if.end96
	cmpl	$0, save_orig_name(%rip)
	jne	.LBB32_51
.LBB32_50:                              # %if.then98
	xorl	%eax, %eax
	cmpl	$0, no_name(%rip)
	sete	%al
	movl	%eax, save_orig_name(%rip)
.LBB32_51:                              # %if.end101
	cmpl	$0, verbose(%rip)
	je	.LBB32_53
# BB#52:                                # %if.then103
	movq	stderr(%rip), %rdi
	movl	$.L.str.154, %esi
	movl	$ifname, %edx
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB32_53
.LBB32_63:                              # %if.end117
                                        #   in Loop: Header=BB32_53 Depth=1
	movq	$0, bytes_out(%rip)
.LBB32_53:                              # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	ifd(%rip), %edi
	movl	ofd(%rip), %esi
	callq	*work(%rip)
	testl	%eax, %eax
	jne	.LBB32_54
# BB#61:                                # %if.end109
                                        #   in Loop: Header=BB32_53 Depth=1
	callq	input_eof
	testl	%eax, %eax
	jne	.LBB32_55
# BB#62:                                # %if.end113
                                        #   in Loop: Header=BB32_53 Depth=1
	movl	ifd(%rip), %edi
	callq	get_method
	movl	%eax, method(%rip)
	testl	%eax, %eax
	jns	.LBB32_63
	jmp	.LBB32_55
.LBB32_18:                              # %if.then32
	cmpl	$0, quiet(%rip)
	jne	.LBB32_20
# BB#19:                                # %if.then34
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movq	istat+16(%rip), %rax
	cmpq	$2, %rax
	leaq	-1(%rax), %r8
	movl	$115, %eax
	movl	$32, %r9d
	cmoval	%eax, %r9d
	movl	$.L.str.152, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB32_20:                              # %if.end37
	cmpl	$0, exit_code(%rip)
	jne	.LBB32_75
# BB#21:                                # %if.then39
	movl	$2, exit_code(%rip)
	jmp	.LBB32_75
.LBB32_43:                              # %if.else81
	callq	create_outfile
	testl	%eax, %eax
	jne	.LBB32_75
# BB#44:                                # %if.end85
	cmpl	$0, decompress(%rip)
	jne	.LBB32_49
# BB#45:                                # %land.lhs.true87
	cmpl	$0, save_orig_name(%rip)
	je	.LBB32_49
# BB#46:                                # %land.lhs.true89
	cmpl	$0, verbose(%rip)
	jne	.LBB32_49
# BB#47:                                # %land.lhs.true91
	cmpl	$0, quiet(%rip)
	jne	.LBB32_49
# BB#48:                                # %if.then93
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.153, %esi
	movl	$ifname, %ecx
	movl	$ofname, %r8d
	xorl	%eax, %eax
	callq	fprintf
	cmpl	$0, save_orig_name(%rip)
	jne	.LBB32_51
	jmp	.LBB32_50
.LBB32_54:                              # %if.then108
	movl	$-1, method(%rip)
.LBB32_55:                              # %for.end
	movl	ifd(%rip), %edi
	callq	close
	cmpl	$0, to_stdout(%rip)
	jne	.LBB32_58
# BB#56:                                # %if.then120
	movl	$istat, %edi
	callq	copy_stat
	movl	ofd(%rip), %edi
	callq	close
	testl	%eax, %eax
	je	.LBB32_58
# BB#57:                                # %if.then123
	callq	write_error
.LBB32_58:                              # %if.end125
	cmpl	$-1, method(%rip)
	je	.LBB32_59
# BB#64:                                # %if.end132
	cmpl	$0, verbose(%rip)
	je	.LBB32_75
# BB#65:                                # %if.then134
	cmpl	$0, test(%rip)
	je	.LBB32_67
# BB#66:                                # %if.then136
	movq	stderr(%rip), %rdi
	movl	$.L.str.155, %esi
	xorl	%eax, %eax
	callq	fprintf
	cmpl	$0, test(%rip)
	jne	.LBB32_74
	jmp	.LBB32_72
.LBB32_59:                              # %if.then127
	cmpl	$0, to_stdout(%rip)
	jne	.LBB32_75
# BB#60:                                # %if.then129
	movl	$ofname, %edi
	callq	xunlink
	jmp	.LBB32_75
.LBB32_67:                              # %if.else138
	cmpl	$0, decompress(%rip)
	je	.LBB32_69
# BB#68:                                # %if.then140
	movq	bytes_out(%rip), %rsi
	movq	bytes_in(%rip), %rax
	jmp	.LBB32_70
.LBB32_69:                              # %if.else143
	movq	bytes_in(%rip), %rsi
	movq	bytes_out(%rip), %rax
.LBB32_70:                              # %if.end147
	subq	header_bytes(%rip), %rax
	movq	%rsi, %rdi
	subq	%rax, %rdi
	movq	stderr(%rip), %rdx
	callq	display_ratio
	cmpl	$0, test(%rip)
	jne	.LBB32_74
.LBB32_72:                              # %land.lhs.true149
	cmpl	$0, to_stdout(%rip)
	jne	.LBB32_74
# BB#73:                                # %if.then151
	movq	stderr(%rip), %rdi
	movl	$.L.str.156, %esi
	movl	$ofname, %edx
	xorl	%eax, %eax
	callq	fprintf
.LBB32_74:                              # %if.end153
	movq	stderr(%rip), %rdi
	movl	$.L.str.123, %esi
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB32_75
.Lfunc_end32:
	.size	treat_file, .Lfunc_end32-treat_file
	.cfi_endproc

	.p2align	4, 0x90
	.type	treat_stdin,@function
treat_stdin:                            # @treat_stdin
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi105:
	.cfi_def_cfa_offset 16
.Lcfi106:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi107:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$32, %rsp
.Lcfi108:
	.cfi_offset %rbx, -32
.Lcfi109:
	.cfi_offset %r14, -24
	cmpl	$0, force(%rip)
	jne	.LBB33_7
# BB#1:                                 # %land.lhs.true
	cmpl	$0, list(%rip)
	jne	.LBB33_7
# BB#2:                                 # %land.lhs.true2
	cmpl	$0, decompress(%rip)
	je	.LBB33_4
# BB#3:                                 # %cond.true
	movq	stdin(%rip), %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB33_5
.LBB33_4:                               # %cond.false
	movq	stdout(%rip), %rax
	movq	%rax, -40(%rbp)
.LBB33_5:                               # %cond.end
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rdi
	callq	fileno
	movl	%eax, %edi
	callq	isatty
	testl	%eax, %eax
	je	.LBB33_7
# BB#6:                                 # %if.then
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	cmpl	$0, decompress(%rip)
	movl	$.L.str.126, %eax
	movl	$.L.str.127, %ecx
	cmovneq	%rax, %rcx
	movl	$.L.str.128, %eax
	movl	$.L.str.8, %r8d
	cmovneq	%rax, %r8
	movl	$.L.str.125, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.129, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, %edi
	callq	do_exit
.LBB33_7:                               # %if.end
	cmpl	$0, decompress(%rip)
	cmpl	$0, test(%rip)
	jne	.LBB33_10
# BB#8:                                 # %land.lhs.true17
	cmpl	$0, list(%rip)
	jne	.LBB33_10
# BB#9:                                 # %land.lhs.true19
	cmpl	$0, decompress(%rip)
.LBB33_10:                              # %if.end24
	movl	$ifname, %edi
	movl	$.L.str.130, %esi
	callq	strcpy
	movl	$ofname, %edi
	movl	$.L.str.16, %esi
	callq	strcpy
	movq	$0, time_stamp(%rip)
	cmpl	$0, list(%rip)
	je	.LBB33_11
.LBB33_12:                              # %if.then30
	movq	stdin(%rip), %rdi
	callq	fileno
	movl	$istat, %esi
	movl	%eax, %edi
	callq	fstat
	testl	%eax, %eax
	je	.LBB33_14
# BB#13:                                # %if.then33
	movl	$.L.str.131, %edi
	callq	progerror
	movl	$1, %edi
	callq	do_exit
.LBB33_14:                              # %if.end34
	movq	istat+88(%rip), %rax
	movq	%rax, time_stamp(%rip)
	jmp	.LBB33_15
.LBB33_11:                              # %lor.lhs.false28
	cmpl	$0, no_time(%rip)
	je	.LBB33_12
.LBB33_15:                              # %if.end35
	movq	$-1, ifile_size(%rip)
	callq	clear_bufs
	movl	$1, to_stdout(%rip)
	movl	$0, part_nb(%rip)
	cmpl	$0, decompress(%rip)
	je	.LBB33_18
# BB#16:                                # %if.then37
	movl	ifd(%rip), %edi
	callq	get_method
	movl	%eax, method(%rip)
	testl	%eax, %eax
	jns	.LBB33_18
# BB#17:                                # %if.then40
	movl	exit_code(%rip), %edi
	callq	do_exit
.LBB33_18:                              # %if.end42
	cmpl	$0, list(%rip)
	je	.LBB33_20
# BB#19:                                # %if.then44
	movl	ifd(%rip), %edi
	movl	method(%rip), %esi
	callq	do_list
.LBB33_30:                              # %if.end71
	addq	$32, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
	.p2align	4, 0x90
.LBB33_23:                              # %if.end59
                                        #   in Loop: Header=BB33_20 Depth=1
	movq	$0, bytes_out(%rip)
.LBB33_20:                              # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	work(%rip), %r14
	movq	stdin(%rip), %rdi
	callq	fileno
	movl	%eax, %ebx
	movq	stdout(%rip), %rdi
	callq	fileno
	movl	%ebx, %edi
	movl	%eax, %esi
	callq	*%r14
	testl	%eax, %eax
	jne	.LBB33_30
# BB#21:                                # %if.end51
                                        #   in Loop: Header=BB33_20 Depth=1
	callq	input_eof
	testl	%eax, %eax
	jne	.LBB33_24
# BB#22:                                # %if.end55
                                        #   in Loop: Header=BB33_20 Depth=1
	movl	ifd(%rip), %edi
	callq	get_method
	movl	%eax, method(%rip)
	testl	%eax, %eax
	jns	.LBB33_23
	jmp	.LBB33_30
.LBB33_24:                              # %for.end
	cmpl	$0, verbose(%rip)
	je	.LBB33_30
# BB#25:                                # %if.then61
	cmpl	$0, test(%rip)
	je	.LBB33_27
# BB#26:                                # %if.then63
	movq	stderr(%rip), %rdi
	movl	$.L.str.132, %esi
.LBB33_29:                              # %if.end71
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB33_30
.LBB33_27:                              # %if.else
	cmpl	$0, decompress(%rip)
	jne	.LBB33_30
# BB#28:                                # %if.then66
	movq	bytes_in(%rip), %rsi
	movq	bytes_out(%rip), %rax
	subq	header_bytes(%rip), %rax
	movq	%rsi, %rdi
	subq	%rax, %rdi
	movq	stderr(%rip), %rdx
	callq	display_ratio
	movq	stderr(%rip), %rdi
	movl	$.L.str.123, %esi
	jmp	.LBB33_29
.Lfunc_end33:
	.size	treat_stdin, .Lfunc_end33-treat_stdin
	.cfi_endproc

	.p2align	4, 0x90
	.type	do_list,@function
do_list:                                # @do_list
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi110:
	.cfi_def_cfa_offset 16
.Lcfi111:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi112:
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movl	%edi, -20(%rbp)
	movl	%esi, -8(%rbp)
	movl	$1, -4(%rbp)
	movabsq	$9223372036854775807, %rax # imm = 0x7FFFFFFFFFFFFFFF
	movq	%rax, -32(%rbp)
	movabsq	$7378697629483820647, %rcx # imm = 0x6666666666666667
	cmpq	$10, -32(%rbp)
	jl	.LBB34_3
	.p2align	4, 0x90
.LBB34_2:                               # %for.inc
                                        # =>This Inner Loop Header: Depth=1
	incl	-4(%rbp)
	movq	%rcx, %rax
	imulq	-32(%rbp)
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$2, %rdx
	addq	%rax, %rdx
	movq	%rdx, -32(%rbp)
	cmpq	$10, -32(%rbp)
	jge	.LBB34_2
.LBB34_3:                               # %for.end
	cmpl	$0, do_list.first_time(%rip)
	je	.LBB34_19
# BB#4:                                 # %land.lhs.true
	cmpl	$0, -8(%rbp)
	js	.LBB34_19
# BB#5:                                 # %if.then
	movl	$0, do_list.first_time(%rip)
	cmpl	$0, verbose(%rip)
	je	.LBB34_7
# BB#6:                                 # %if.then3
	movl	$.L.str.187, %edi
	xorl	%eax, %eax
	callq	printf
.LBB34_7:                               # %if.end
	cmpl	$0, quiet(%rip)
	jne	.LBB34_9
# BB#8:                                 # %if.then5
	movl	-4(%rbp), %esi
	movq	$.L.str.190, (%rsp)
	movl	$.L.str.188, %edi
	movl	$.L.str.189, %ecx
	xorl	%eax, %eax
	movl	%esi, %edx
	movl	%esi, %r8d
	movl	%esi, %r9d
	callq	printf
	jmp	.LBB34_9
.LBB34_19:                              # %if.else
	cmpl	$0, -8(%rbp)
	js	.LBB34_20
.LBB34_9:                               # %if.end28
	movq	$-1, -40(%rbp)
	movq	$-1, bytes_out(%rip)
	movq	ifile_size(%rip), %rax
	movq	%rax, bytes_in(%rip)
	cmpl	$8, -8(%rbp)
	jne	.LBB34_15
# BB#10:                                # %land.lhs.true30
	cmpl	$0, last_member(%rip)
	jne	.LBB34_15
# BB#11:                                # %if.then32
	movl	-20(%rbp), %edi
	movq	$-8, %rsi
	movl	$2, %edx
	callq	lseek
	movq	%rax, bytes_in(%rip)
	cmpq	$-1, %rax
	je	.LBB34_15
# BB#12:                                # %if.then35
	addq	$8, bytes_in(%rip)
	movl	-20(%rbp), %edi
	leaq	-16(%rbp), %rsi
	movl	$8, %edx
	callq	read
	cmpq	$8, %rax
	je	.LBB34_14
# BB#13:                                # %if.then38
	callq	read_error
.LBB34_14:                              # %if.end39
	movzbl	-16(%rbp), %eax
	movzbl	-15(%rbp), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	-14(%rbp), %eax
	movzbl	-13(%rbp), %edx
	shll	$8, %edx
	orl	%eax, %edx
	shlq	$16, %rdx
	orq	%rcx, %rdx
	movq	%rdx, -40(%rbp)
	movzbl	-12(%rbp), %eax
	movzbl	-11(%rbp), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	-10(%rbp), %eax
	movzbl	-9(%rbp), %edx
	shll	$8, %edx
	orl	%eax, %edx
	shlq	$16, %rdx
	orq	%rcx, %rdx
	movq	%rdx, bytes_out(%rip)
.LBB34_15:                              # %if.end90
	movl	$time_stamp, %edi
	callq	ctime
	leaq	4(%rax), %rcx
	movq	%rcx, -48(%rbp)
	movb	$0, 16(%rax)
	cmpl	$0, verbose(%rip)
	je	.LBB34_17
# BB#16:                                # %if.then95
	movslq	-8(%rbp), %rax
	movq	do_list.methods(,%rax,8), %rsi
	movq	-40(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movl	$.L.str.194, %edi
	xorl	%eax, %eax
	callq	printf
.LBB34_17:                              # %if.end98
	movq	stdout(%rip), %rdi
	movq	bytes_in(%rip), %rsi
	movl	-4(%rbp), %edx
	callq	fprint_off
	movl	$.L.str.192, %edi
	xorl	%eax, %eax
	callq	printf
	movq	stdout(%rip), %rdi
	movq	bytes_out(%rip), %rsi
	movl	-4(%rbp), %edx
	callq	fprint_off
	movl	$.L.str.192, %edi
	xorl	%eax, %eax
	callq	printf
	cmpq	$-1, bytes_in(%rip)
	je	.LBB34_18
# BB#28:                                # %if.else104
	cmpq	$0, total_in(%rip)
	js	.LBB34_30
# BB#29:                                # %if.then107
	movq	bytes_in(%rip), %rax
	addq	%rax, total_in(%rip)
	cmpq	$-1, bytes_out(%rip)
	jne	.LBB34_32
	jmp	.LBB34_31
.LBB34_18:                              # %if.then103
	movq	$-1, total_in(%rip)
	movq	$0, header_bytes(%rip)
	movq	$0, bytes_out(%rip)
	movq	$0, bytes_in(%rip)
.LBB34_30:                              # %if.end110
	cmpq	$-1, bytes_out(%rip)
	je	.LBB34_31
.LBB34_32:                              # %if.else114
	cmpq	$0, total_out(%rip)
	js	.LBB34_34
# BB#33:                                # %if.then117
	movq	bytes_out(%rip), %rax
	addq	%rax, total_out(%rip)
	jmp	.LBB34_34
.LBB34_31:                              # %if.then113
	movq	$-1, total_out(%rip)
	movq	$0, header_bytes(%rip)
	movq	$0, bytes_out(%rip)
	movq	$0, bytes_in(%rip)
.LBB34_34:                              # %if.end120
	movq	bytes_out(%rip), %rsi
	movq	bytes_in(%rip), %rax
	subq	header_bytes(%rip), %rax
	movq	%rsi, %rdi
	subq	%rax, %rdi
	movq	stdout(%rip), %rdx
	callq	display_ratio
	movl	$.L.str.195, %edi
	movl	$ofname, %esi
	xorl	%eax, %eax
	callq	printf
.LBB34_35:                              # %return
	addq	$64, %rsp
	popq	%rbp
	retq
.LBB34_20:                              # %if.then9
	cmpq	$0, total_in(%rip)
	jle	.LBB34_35
# BB#21:                                # %lor.lhs.false
	cmpq	$0, total_out(%rip)
	jle	.LBB34_35
# BB#22:                                # %if.end13
	cmpl	$0, verbose(%rip)
	je	.LBB34_24
# BB#23:                                # %if.then15
	movl	$.L.str.191, %edi
	xorl	%eax, %eax
	callq	printf
.LBB34_24:                              # %if.end17
	cmpl	$0, verbose(%rip)
	je	.LBB34_25
.LBB34_26:                              # %if.then21
	movq	stdout(%rip), %rdi
	movq	total_in(%rip), %rsi
	movl	-4(%rbp), %edx
	callq	fprint_off
	movl	$.L.str.192, %edi
	xorl	%eax, %eax
	callq	printf
	movq	stdout(%rip), %rdi
	movq	total_out(%rip), %rsi
	movl	-4(%rbp), %edx
	callq	fprint_off
	movl	$.L.str.192, %edi
	xorl	%eax, %eax
	callq	printf
	jmp	.LBB34_27
.LBB34_25:                              # %lor.lhs.false19
	cmpl	$0, quiet(%rip)
	je	.LBB34_26
.LBB34_27:                              # %if.end24
	movq	total_out(%rip), %rsi
	movq	total_in(%rip), %rax
	subq	header_bytes(%rip), %rax
	movq	%rsi, %rdi
	subq	%rax, %rdi
	movq	stdout(%rip), %rdx
	callq	display_ratio
	movl	$.L.str.193, %edi
	xorl	%eax, %eax
	callq	printf
	jmp	.LBB34_35
.Lfunc_end34:
	.size	do_list, .Lfunc_end34-do_list
	.cfi_endproc

	.globl	abort_gzip
	.p2align	4, 0x90
	.type	abort_gzip,@function
abort_gzip:                             # @abort_gzip
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi113:
	.cfi_def_cfa_offset 16
.Lcfi114:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi115:
	.cfi_def_cfa_register %rbp
	callq	do_remove
	movl	$1, %edi
	callq	do_exit
	popq	%rbp
	retq
.Lfunc_end35:
	.size	abort_gzip, .Lfunc_end35-abort_gzip
	.cfi_endproc

	.globl	huft_build
	.p2align	4, 0x90
	.type	huft_build,@function
huft_build:                             # @huft_build
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi116:
	.cfi_def_cfa_offset 16
.Lcfi117:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi118:
	.cfi_def_cfa_register %rbp
	subq	$1600, %rsp             # imm = 0x640
	movq	16(%rbp), %rax
	movq	%rdi, -136(%rbp)
	movl	%esi, -52(%rbp)
	movl	%edx, -76(%rbp)
	movq	%rcx, -152(%rbp)
	movq	%r8, -144(%rbp)
	movq	%r9, -128(%rbp)
	movq	%rax, -120(%rbp)
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -192(%rbp)
	movaps	%xmm0, -208(%rbp)
	movaps	%xmm0, -224(%rbp)
	movaps	%xmm0, -240(%rbp)
	movl	$0, -176(%rbp)
	movq	-136(%rbp), %rax
	movq	%rax, -32(%rbp)
	movl	-52(%rbp), %eax
	movl	%eax, -8(%rbp)
	.p2align	4, 0x90
.LBB36_1:                               # %do.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	incl	-240(%rbp,%rax,4)
	addq	$4, -32(%rbp)
	decl	-8(%rbp)
	jne	.LBB36_1
# BB#2:                                 # %do.end
	movl	-240(%rbp), %eax
	cmpl	-52(%rbp), %eax
	jne	.LBB36_4
# BB#3:                                 # %if.then
	movq	-128(%rbp), %rax
	movq	$0, (%rax)
	movq	-120(%rbp), %rax
	movl	$0, (%rax)
	movl	$0, -56(%rbp)
	jmp	.LBB36_68
.LBB36_4:                               # %if.end
	movq	-120(%rbp), %rax
	movl	(%rax), %eax
	movl	%eax, -12(%rbp)
	movl	$1, -4(%rbp)
	cmpl	$16, -4(%rbp)
	jbe	.LBB36_6
	jmp	.LBB36_8
	.p2align	4, 0x90
.LBB36_7:                               # %for.inc
                                        #   in Loop: Header=BB36_6 Depth=1
	incl	-4(%rbp)
	cmpl	$16, -4(%rbp)
	ja	.LBB36_8
.LBB36_6:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	$0, -240(%rbp,%rax,4)
	je	.LBB36_7
.LBB36_8:                               # %for.end
	movl	-4(%rbp), %eax
	movl	%eax, -24(%rbp)
	movl	-12(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jae	.LBB36_10
# BB#9:                                 # %if.then10
	movl	-4(%rbp), %eax
	movl	%eax, -12(%rbp)
.LBB36_10:                              # %if.end11
	movl	$16, -8(%rbp)
	cmpl	$0, -8(%rbp)
	jne	.LBB36_12
	jmp	.LBB36_14
	.p2align	4, 0x90
.LBB36_13:                              # %for.inc20
                                        #   in Loop: Header=BB36_12 Depth=1
	decl	-8(%rbp)
	cmpl	$0, -8(%rbp)
	je	.LBB36_14
.LBB36_12:                              # %for.body14
                                        # =>This Inner Loop Header: Depth=1
	movl	-8(%rbp), %eax
	cmpl	$0, -240(%rbp,%rax,4)
	je	.LBB36_13
.LBB36_14:                              # %for.end22
	movl	-8(%rbp), %eax
	movl	%eax, -60(%rbp)
	movl	-12(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jbe	.LBB36_16
# BB#15:                                # %if.then24
	movl	-8(%rbp), %eax
	movl	%eax, -12(%rbp)
.LBB36_16:                              # %if.end25
	movl	-12(%rbp), %eax
	movq	-120(%rbp), %rcx
	movl	%eax, (%rcx)
	movb	-4(%rbp), %cl
	movl	$1, %eax
	shll	%cl, %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB36_17
	.p2align	4, 0x90
.LBB36_20:                              # %for.inc34
                                        #   in Loop: Header=BB36_17 Depth=1
	incl	-4(%rbp)
	shll	-44(%rbp)
.LBB36_17:                              # %for.cond26
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jae	.LBB36_21
# BB#18:                                # %for.body28
                                        #   in Loop: Header=BB36_17 Depth=1
	movl	-4(%rbp), %eax
	movl	-44(%rbp), %ecx
	subl	-240(%rbp,%rax,4), %ecx
	movl	%ecx, -44(%rbp)
	jns	.LBB36_20
# BB#19:                                # %if.then32
	movl	$2, -56(%rbp)
	jmp	.LBB36_68
.LBB36_21:                              # %for.end37
	movl	-8(%rbp), %eax
	movl	-44(%rbp), %ecx
	subl	-240(%rbp,%rax,4), %ecx
	movl	%ecx, -44(%rbp)
	js	.LBB36_22
# BB#23:                                # %if.end43
	movl	-44(%rbp), %eax
	movl	-8(%rbp), %ecx
	addl	%eax, -240(%rbp,%rcx,4)
	movl	$0, -4(%rbp)
	movl	$0, -316(%rbp)
	leaq	-236(%rbp), %rax
	movq	%rax, -32(%rbp)
	leaq	-312(%rbp), %rax
	movq	%rax, -88(%rbp)
	decl	-8(%rbp)
	je	.LBB36_26
	.p2align	4, 0x90
.LBB36_25:                              # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movq	-32(%rbp), %rax
	leaq	4(%rax), %rcx
	movq	%rcx, -32(%rbp)
	movl	-4(%rbp), %ecx
	addl	(%rax), %ecx
	movl	%ecx, -4(%rbp)
	movq	-88(%rbp), %rax
	leaq	4(%rax), %rdx
	movq	%rdx, -88(%rbp)
	movl	%ecx, (%rax)
	decl	-8(%rbp)
	jne	.LBB36_25
.LBB36_26:                              # %while.end
	movq	-136(%rbp), %rax
	movq	%rax, -32(%rbp)
	movl	$0, -8(%rbp)
	.p2align	4, 0x90
.LBB36_27:                              # %do.body55
                                        # =>This Inner Loop Header: Depth=1
	movq	-32(%rbp), %rax
	leaq	4(%rax), %rcx
	movq	%rcx, -32(%rbp)
	movl	(%rax), %eax
	movl	%eax, -4(%rbp)
	testl	%eax, %eax
	je	.LBB36_29
# BB#28:                                # %if.then58
                                        #   in Loop: Header=BB36_27 Depth=1
	movl	-8(%rbp), %eax
	movl	-4(%rbp), %ecx
	movl	-320(%rbp,%rcx,4), %edx
	leal	1(%rdx), %esi
	movl	%esi, -320(%rbp,%rcx,4)
	movl	%eax, -1600(%rbp,%rdx,4)
.LBB36_29:                              # %do.cond65
                                        #   in Loop: Header=BB36_27 Depth=1
	movl	-8(%rbp), %eax
	incl	%eax
	movl	%eax, -8(%rbp)
	cmpl	-52(%rbp), %eax
	jb	.LBB36_27
# BB#30:                                # %do.end68
	movslq	-60(%rbp), %rax
	movl	-320(%rbp,%rax,4), %eax
	movl	%eax, -52(%rbp)
	movl	$0, -8(%rbp)
	movl	$0, -320(%rbp)
	leaq	-1600(%rbp), %rax
	movq	%rax, -32(%rbp)
	movl	$-1, -40(%rbp)
	xorl	%eax, %eax
	subl	-12(%rbp), %eax
	movl	%eax, -20(%rbp)
	movq	$0, -448(%rbp)
	movq	$0, -72(%rbp)
	movl	$0, -36(%rbp)
	jmp	.LBB36_31
.LBB36_22:                              # %if.then42
	movl	$2, -56(%rbp)
	jmp	.LBB36_68
.LBB36_63:                              # %for.inc224
                                        #   in Loop: Header=BB36_31 Depth=1
	incl	-24(%rbp)
.LBB36_31:                              # %for.cond75
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB36_33 Depth 2
                                        #       Child Loop BB36_34 Depth 3
                                        #         Child Loop BB36_40 Depth 4
                                        #       Child Loop BB36_55 Depth 3
                                        #       Child Loop BB36_58 Depth 3
                                        #       Child Loop BB36_61 Depth 3
	movl	-24(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jg	.LBB36_64
# BB#32:                                # %for.body77
                                        #   in Loop: Header=BB36_31 Depth=1
	movslq	-24(%rbp), %rax
	movl	-240(%rbp,%rax,4), %eax
	movl	%eax, -64(%rbp)
	jmp	.LBB36_33
	.p2align	4, 0x90
.LBB36_48:                              # %if.then136
                                        #   in Loop: Header=BB36_34 Depth=3
	movl	-8(%rbp), %eax
	movslq	-40(%rbp), %rcx
	movl	%eax, -320(%rbp,%rcx,4)
	movb	-12(%rbp), %al
	movb	%al, -111(%rbp)
	movl	-4(%rbp), %eax
	addl	$16, %eax
	movb	%al, -112(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, -104(%rbp)
	movl	-8(%rbp), %eax
	movl	-20(%rbp), %ecx
	subl	-12(%rbp), %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movl	%eax, -4(%rbp)
	movslq	-40(%rbp), %rax
	movq	-456(%rbp,%rax,8), %rax
	movl	-4(%rbp), %ecx
	shlq	$4, %rcx
	movups	-112(%rbp), %xmm0
	movups	%xmm0, (%rax,%rcx)
.LBB36_34:                              # %while.cond84
                                        #   Parent Loop BB36_31 Depth=1
                                        #     Parent Loop BB36_33 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB36_40 Depth 4
	movl	-20(%rbp), %eax
	addl	-12(%rbp), %eax
	cmpl	%eax, -24(%rbp)
	jle	.LBB36_49
# BB#35:                                # %while.body87
                                        #   in Loop: Header=BB36_34 Depth=3
	incl	-40(%rbp)
	movl	-20(%rbp), %eax
	addl	-12(%rbp), %eax
	movl	%eax, -20(%rbp)
	movl	-60(%rbp), %ecx
	subl	%eax, %ecx
	movl	%ecx, -36(%rbp)
	cmpl	-12(%rbp), %ecx
	jbe	.LBB36_37
# BB#36:                                # %cond.true
                                        #   in Loop: Header=BB36_34 Depth=3
	movl	-12(%rbp), %eax
	movl	%eax, -156(%rbp)
	jmp	.LBB36_38
	.p2align	4, 0x90
.LBB36_37:                              # %cond.false
                                        #   in Loop: Header=BB36_34 Depth=3
	movl	-36(%rbp), %eax
	movl	%eax, -160(%rbp)
.LBB36_38:                              # %cond.end
                                        #   in Loop: Header=BB36_34 Depth=3
	movl	%eax, -92(%rbp)
	movl	-92(%rbp), %eax
	movl	%eax, -36(%rbp)
	movl	-24(%rbp), %ecx
	subl	-20(%rbp), %ecx
	movl	%ecx, -4(%rbp)
	movl	$1, %eax
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shll	%cl, %eax
	movl	%eax, -48(%rbp)
	movl	-64(%rbp), %ecx
	incl	%ecx
	cmpl	%ecx, %eax
	jbe	.LBB36_43
# BB#39:                                # %if.then96
                                        #   in Loop: Header=BB36_34 Depth=3
	movl	-64(%rbp), %eax
	incl	%eax
	subl	%eax, -48(%rbp)
	movslq	-24(%rbp), %rax
	leaq	-240(%rbp,%rax,4), %rax
	movq	%rax, -88(%rbp)
	movl	-4(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jb	.LBB36_40
	jmp	.LBB36_43
	.p2align	4, 0x90
.LBB36_42:                              # %if.end111
                                        #   in Loop: Header=BB36_40 Depth=4
	movq	-88(%rbp), %rax
	movl	(%rax), %eax
	subl	%eax, -48(%rbp)
.LBB36_40:                              # %while.cond103
                                        #   Parent Loop BB36_31 Depth=1
                                        #     Parent Loop BB36_33 Depth=2
                                        #       Parent Loop BB36_34 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movl	-4(%rbp), %eax
	incl	%eax
	movl	%eax, -4(%rbp)
	cmpl	-36(%rbp), %eax
	jae	.LBB36_43
# BB#41:                                # %while.body106
                                        #   in Loop: Header=BB36_40 Depth=4
	movl	-48(%rbp), %eax
	addl	%eax, %eax
	movl	%eax, -48(%rbp)
	movq	-88(%rbp), %rcx
	leaq	4(%rcx), %rdx
	movq	%rdx, -88(%rbp)
	cmpl	4(%rcx), %eax
	ja	.LBB36_42
	.p2align	4, 0x90
.LBB36_43:                              # %if.end115
                                        #   in Loop: Header=BB36_34 Depth=3
	movb	-4(%rbp), %cl
	movl	$1, %edi
	shll	%cl, %edi
	movl	%edi, -36(%rbp)
	incl	%edi
	shlq	$4, %rdi
	callq	malloc
	movq	%rax, -72(%rbp)
	testq	%rax, %rax
	je	.LBB36_44
# BB#47:                                # %if.end126
                                        #   in Loop: Header=BB36_34 Depth=3
	movl	-36(%rbp), %eax
	movl	hufts(%rip), %ecx
	leal	1(%rcx,%rax), %eax
	movl	%eax, hufts(%rip)
	movq	-72(%rbp), %rax
	addq	$16, %rax
	movq	-128(%rbp), %rcx
	movq	%rax, (%rcx)
	movq	-72(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	%rcx, -128(%rbp)
	movq	$0, 8(%rax)
	movq	-72(%rbp), %rax
	addq	$16, %rax
	movq	%rax, -72(%rbp)
	movslq	-40(%rbp), %rcx
	movq	%rax, -448(%rbp,%rcx,8)
	cmpl	$0, -40(%rbp)
	je	.LBB36_34
	jmp	.LBB36_48
.LBB36_49:                              # %while.end153
                                        #   in Loop: Header=BB36_33 Depth=2
	movl	-24(%rbp), %eax
	subl	-20(%rbp), %eax
	movb	%al, -111(%rbp)
	movl	-52(%rbp), %eax
	leaq	-1600(%rbp,%rax,4), %rax
	cmpq	%rax, -32(%rbp)
	jb	.LBB36_51
# BB#50:                                # %if.then162
                                        #   in Loop: Header=BB36_33 Depth=2
	movb	$99, -112(%rbp)
	jmp	.LBB36_54
.LBB36_51:                              # %if.else
                                        #   in Loop: Header=BB36_33 Depth=2
	movq	-32(%rbp), %rax
	movl	(%rax), %eax
	cmpl	-76(%rbp), %eax
	jae	.LBB36_53
# BB#52:                                # %if.then166
                                        #   in Loop: Header=BB36_33 Depth=2
	movq	-32(%rbp), %rax
	cmpl	$256, (%rax)            # imm = 0x100
	movb	$15, %al
	adcb	$0, %al
	movb	%al, -112(%rbp)
	movq	-32(%rbp), %rax
	movzwl	(%rax), %eax
	movw	%ax, -104(%rbp)
	addq	$4, -32(%rbp)
	jmp	.LBB36_54
.LBB36_53:                              # %if.else176
                                        #   in Loop: Header=BB36_33 Depth=2
	movq	-144(%rbp), %rax
	movq	-32(%rbp), %rcx
	movl	(%rcx), %ecx
	subl	-76(%rbp), %ecx
	movb	(%rax,%rcx,2), %al
	movb	%al, -112(%rbp)
	movq	-152(%rbp), %rax
	movq	-32(%rbp), %rcx
	leaq	4(%rcx), %rdx
	movq	%rdx, -32(%rbp)
	movl	(%rcx), %ecx
	subl	-76(%rbp), %ecx
	movzwl	(%rax,%rcx,2), %eax
	movw	%ax, -104(%rbp)
.LBB36_54:                              # %if.end189
                                        #   in Loop: Header=BB36_33 Depth=2
	movl	-24(%rbp), %ecx
	subl	-20(%rbp), %ecx
	movl	$1, %eax
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shll	%cl, %eax
	movl	%eax, -48(%rbp)
	movl	-8(%rbp), %eax
	movb	-20(%rbp), %cl
	shrl	%cl, %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB36_55
	.p2align	4, 0x90
.LBB36_56:                              # %for.inc199
                                        #   in Loop: Header=BB36_55 Depth=3
	movq	-72(%rbp), %rax
	movl	-4(%rbp), %ecx
	shlq	$4, %rcx
	movups	-112(%rbp), %xmm0
	movups	%xmm0, (%rax,%rcx)
	movl	-48(%rbp), %eax
	addl	%eax, -4(%rbp)
.LBB36_55:                              # %for.cond193
                                        #   Parent Loop BB36_31 Depth=1
                                        #     Parent Loop BB36_33 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-4(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jb	.LBB36_56
# BB#57:                                # %for.end201
                                        #   in Loop: Header=BB36_33 Depth=2
	movl	-24(%rbp), %ecx
	decl	%ecx
	movl	$1, %eax
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shll	%cl, %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB36_58
	.p2align	4, 0x90
.LBB36_59:                              # %for.inc207
                                        #   in Loop: Header=BB36_58 Depth=3
	movl	-4(%rbp), %eax
	xorl	%eax, -8(%rbp)
	shrl	-4(%rbp)
.LBB36_58:                              # %for.cond204
                                        #   Parent Loop BB36_31 Depth=1
                                        #     Parent Loop BB36_33 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-8(%rbp), %eax
	testl	-4(%rbp), %eax
	jne	.LBB36_59
# BB#60:                                # %for.end209
                                        #   in Loop: Header=BB36_33 Depth=2
	movl	-4(%rbp), %eax
	xorl	%eax, -8(%rbp)
	jmp	.LBB36_61
	.p2align	4, 0x90
.LBB36_62:                              # %while.body219
                                        #   in Loop: Header=BB36_61 Depth=3
	decl	-40(%rbp)
	movl	-12(%rbp), %eax
	subl	%eax, -20(%rbp)
.LBB36_61:                              # %while.cond211
                                        #   Parent Loop BB36_31 Depth=1
                                        #     Parent Loop BB36_33 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movzbl	-20(%rbp), %ecx
	movl	$1, %eax
	shll	%cl, %eax
	decl	%eax
	andl	-8(%rbp), %eax
	movslq	-40(%rbp), %rcx
	cmpl	-320(%rbp,%rcx,4), %eax
	jne	.LBB36_62
.LBB36_33:                              # %while.cond80
                                        #   Parent Loop BB36_31 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB36_34 Depth 3
                                        #         Child Loop BB36_40 Depth 4
                                        #       Child Loop BB36_55 Depth 3
                                        #       Child Loop BB36_58 Depth 3
                                        #       Child Loop BB36_61 Depth 3
	movl	-64(%rbp), %eax
	leal	-1(%rax), %ecx
	movl	%ecx, -64(%rbp)
	testl	%eax, %eax
	jne	.LBB36_34
	jmp	.LBB36_63
.LBB36_44:                              # %if.then120
	cmpl	$0, -40(%rbp)
	je	.LBB36_46
# BB#45:                                # %if.then122
	movq	-448(%rbp), %rdi
	callq	huft_free
.LBB36_46:                              # %if.end125
	movl	$3, -56(%rbp)
.LBB36_68:                              # %return
	movl	-56(%rbp), %eax
	addq	$1600, %rsp             # imm = 0x640
	popq	%rbp
	retq
.LBB36_64:                              # %for.end226
	cmpl	$0, -44(%rbp)
	je	.LBB36_65
# BB#66:                                # %land.rhs
	cmpl	$1, -60(%rbp)
	setne	-77(%rbp)
	setne	-13(%rbp)
	jmp	.LBB36_67
.LBB36_65:                              # %for.end226.land.end_crit_edge
	movb	$0, -13(%rbp)
.LBB36_67:                              # %land.end
	movzbl	-13(%rbp), %eax
	movl	%eax, -56(%rbp)
	jmp	.LBB36_68
.Lfunc_end36:
	.size	huft_build, .Lfunc_end36-huft_build
	.cfi_endproc

	.globl	huft_free
	.p2align	4, 0x90
	.type	huft_free,@function
huft_free:                              # @huft_free
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi119:
	.cfi_def_cfa_offset 16
.Lcfi120:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi121:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rdi, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.LBB37_3
	.p2align	4, 0x90
.LBB37_2:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	leaq	-16(%rax), %rcx
	movq	%rcx, -8(%rbp)
	movq	-8(%rax), %rax
	movq	%rax, -16(%rbp)
	movq	-8(%rbp), %rdi
	callq	free
	movq	-16(%rbp), %rax
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.LBB37_2
.LBB37_3:                               # %while.end
	xorl	%eax, %eax
	addq	$32, %rsp
	popq	%rbp
	retq
.Lfunc_end37:
	.size	huft_free, .Lfunc_end37-huft_free
	.cfi_endproc

	.globl	inflate_codes
	.p2align	4, 0x90
	.type	inflate_codes,@function
inflate_codes:                          # @inflate_codes
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi122:
	.cfi_def_cfa_offset 16
.Lcfi123:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi124:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$184, %rsp
.Lcfi125:
	.cfi_offset %rbx, -24
	movq	%rdi, -120(%rbp)
	movq	%rsi, -112(%rbp)
	movl	%edx, -96(%rbp)
	movl	%ecx, -92(%rbp)
	movq	bb(%rip), %rax
	movq	%rax, -32(%rbp)
	movl	bk(%rip), %eax
	movl	%eax, -16(%rbp)
	movl	outcnt(%rip), %eax
	movl	%eax, -20(%rbp)
	movslq	-96(%rbp), %rax
	movzwl	mask_bits(%rax,%rax), %eax
	movl	%eax, -104(%rbp)
	movslq	-92(%rbp), %rax
	movzwl	mask_bits(%rax,%rax), %eax
	movl	%eax, -100(%rbp)
	movl	$32767, %ebx            # imm = 0x7FFF
	jmp	.LBB38_2
	.p2align	4, 0x90
.LBB38_1:                               # %cond.end
                                        #   in Loop: Header=BB38_2 Depth=1
	movl	%eax, -60(%rbp)
	movzbl	-60(%rbp), %eax
	movb	-16(%rbp), %cl
	shlq	%cl, %rax
	orq	%rax, -32(%rbp)
	addl	$8, -16(%rbp)
.LBB38_2:                               # %while.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB38_7 Depth 2
                                        #       Child Loop BB38_10 Depth 3
                                        #     Child Loop BB38_20 Depth 2
                                        #     Child Loop BB38_26 Depth 2
                                        #     Child Loop BB38_31 Depth 2
                                        #       Child Loop BB38_34 Depth 3
                                        #     Child Loop BB38_41 Depth 2
                                        #     Child Loop BB38_46 Depth 2
                                        #       Child Loop BB38_54 Depth 3
	movl	-16(%rbp), %eax
	cmpl	-96(%rbp), %eax
	jae	.LBB38_6
# BB#3:                                 # %while.body
                                        #   in Loop: Header=BB38_2 Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB38_5
# BB#4:                                 # %cond.true
                                        #   in Loop: Header=BB38_2 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -124(%rbp)
	jmp	.LBB38_1
	.p2align	4, 0x90
.LBB38_5:                               # %cond.false
                                        #   in Loop: Header=BB38_2 Depth=1
	movl	-20(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -128(%rbp)
	jmp	.LBB38_1
.LBB38_6:                               # %while.end
                                        #   in Loop: Header=BB38_2 Depth=1
	movq	-120(%rbp), %rax
	movl	-32(%rbp), %ecx
	andl	-104(%rbp), %ecx
	shlq	$4, %rcx
	leaq	(%rax,%rcx), %rdx
	movq	%rdx, -48(%rbp)
	movzbl	(%rax,%rcx), %eax
	cmpl	$17, %eax
	movl	%eax, -12(%rbp)
	jb	.LBB38_15
	.p2align	4, 0x90
.LBB38_7:                               # %do.body
                                        #   Parent Loop BB38_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB38_10 Depth 3
	cmpl	$99, -12(%rbp)
	je	.LBB38_59
# BB#8:                                 # %if.end
                                        #   in Loop: Header=BB38_7 Depth=2
	movq	-48(%rbp), %rax
	movb	1(%rax), %cl
	shrq	%cl, -32(%rbp)
	movq	-48(%rbp), %rax
	movzbl	1(%rax), %eax
	subl	%eax, -16(%rbp)
	addl	$-16, -12(%rbp)
	jmp	.LBB38_10
	.p2align	4, 0x90
.LBB38_9:                               # %cond.end39
                                        #   in Loop: Header=BB38_10 Depth=3
	movl	%eax, -64(%rbp)
	movzbl	-64(%rbp), %eax
	movzbl	-16(%rbp), %ecx
	shlq	%cl, %rax
	orq	%rax, -32(%rbp)
	addl	$8, -16(%rbp)
.LBB38_10:                              # %while.cond26
                                        #   Parent Loop BB38_2 Depth=1
                                        #     Parent Loop BB38_7 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-16(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jae	.LBB38_14
# BB#11:                                # %while.body29
                                        #   in Loop: Header=BB38_10 Depth=3
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB38_13
# BB#12:                                # %cond.true32
                                        #   in Loop: Header=BB38_10 Depth=3
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -132(%rbp)
	jmp	.LBB38_9
	.p2align	4, 0x90
.LBB38_13:                              # %cond.false37
                                        #   in Loop: Header=BB38_10 Depth=3
	movl	-20(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -136(%rbp)
	jmp	.LBB38_9
	.p2align	4, 0x90
.LBB38_14:                              # %do.cond
                                        #   in Loop: Header=BB38_7 Depth=2
	movq	-48(%rbp), %rax
	movq	8(%rax), %rax
	movl	-12(%rbp), %ecx
	movzwl	mask_bits(%rcx,%rcx), %ecx
	andl	-32(%rbp), %ecx
	shlq	$4, %rcx
	leaq	(%rax,%rcx), %rdx
	movq	%rdx, -48(%rbp)
	movzbl	(%rax,%rcx), %eax
	cmpl	$16, %eax
	movl	%eax, -12(%rbp)
	ja	.LBB38_7
.LBB38_15:                              # %if.end60
                                        #   in Loop: Header=BB38_2 Depth=1
	movq	-48(%rbp), %rax
	movb	1(%rax), %cl
	shrq	%cl, -32(%rbp)
	movq	-48(%rbp), %rax
	movzbl	1(%rax), %eax
	subl	%eax, -16(%rbp)
	cmpl	$16, -12(%rbp)
	jne	.LBB38_18
# BB#16:                                # %if.then70
                                        #   in Loop: Header=BB38_2 Depth=1
	movq	-48(%rbp), %rax
	movb	8(%rax), %al
	movl	-20(%rbp), %ecx
	leal	1(%rcx), %edx
	movl	%edx, -20(%rbp)
	movb	%al, window(%rcx)
	cmpl	$32768, -20(%rbp)       # imm = 0x8000
	jne	.LBB38_2
# BB#17:                                # %if.then79
                                        #   in Loop: Header=BB38_2 Depth=1
	movl	-20(%rbp), %eax
	movl	%eax, outcnt(%rip)
	callq	flush_window
	movl	$0, -20(%rbp)
	jmp	.LBB38_2
.LBB38_18:                              # %if.else
                                        #   in Loop: Header=BB38_2 Depth=1
	cmpl	$15, -12(%rbp)
	jne	.LBB38_20
	jmp	.LBB38_61
	.p2align	4, 0x90
.LBB38_19:                              # %cond.end98
                                        #   in Loop: Header=BB38_20 Depth=2
	movl	%eax, -68(%rbp)
	movzbl	-68(%rbp), %eax
	movzbl	-16(%rbp), %ecx
	shlq	%cl, %rax
	orq	%rax, -32(%rbp)
	addl	$8, -16(%rbp)
.LBB38_20:                              # %while.cond85
                                        #   Parent Loop BB38_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-16(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jae	.LBB38_24
# BB#21:                                # %while.body88
                                        #   in Loop: Header=BB38_20 Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB38_23
# BB#22:                                # %cond.true91
                                        #   in Loop: Header=BB38_20 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -140(%rbp)
	jmp	.LBB38_19
	.p2align	4, 0x90
.LBB38_23:                              # %cond.false96
                                        #   in Loop: Header=BB38_20 Depth=2
	movl	-20(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -144(%rbp)
	jmp	.LBB38_19
.LBB38_24:                              # %while.end106
                                        #   in Loop: Header=BB38_2 Depth=1
	movq	-48(%rbp), %rax
	movzwl	8(%rax), %eax
	movl	-12(%rbp), %ecx
	movzwl	mask_bits(%rcx,%rcx), %edx
	andl	-32(%rbp), %edx
	addl	%eax, %edx
	movb	-12(%rbp), %cl
	shrq	%cl, -32(%rbp)
	movl	%edx, -52(%rbp)
	movl	-12(%rbp), %eax
	subl	%eax, -16(%rbp)
	jmp	.LBB38_26
	.p2align	4, 0x90
.LBB38_25:                              # %cond.end132
                                        #   in Loop: Header=BB38_26 Depth=2
	movl	%eax, -72(%rbp)
	movzbl	-72(%rbp), %eax
	movzbl	-16(%rbp), %ecx
	shlq	%cl, %rax
	orq	%rax, -32(%rbp)
	addl	$8, -16(%rbp)
.LBB38_26:                              # %while.cond119
                                        #   Parent Loop BB38_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-16(%rbp), %eax
	cmpl	-92(%rbp), %eax
	jae	.LBB38_30
# BB#27:                                # %while.body122
                                        #   in Loop: Header=BB38_26 Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB38_29
# BB#28:                                # %cond.true125
                                        #   in Loop: Header=BB38_26 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -148(%rbp)
	jmp	.LBB38_25
	.p2align	4, 0x90
.LBB38_29:                              # %cond.false130
                                        #   in Loop: Header=BB38_26 Depth=2
	movl	-20(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -152(%rbp)
	jmp	.LBB38_25
.LBB38_30:                              # %while.end140
                                        #   in Loop: Header=BB38_2 Depth=1
	movq	-112(%rbp), %rax
	movl	-32(%rbp), %ecx
	andl	-100(%rbp), %ecx
	shlq	$4, %rcx
	leaq	(%rax,%rcx), %rdx
	movq	%rdx, -48(%rbp)
	movzbl	(%rax,%rcx), %eax
	cmpl	$17, %eax
	movl	%eax, -12(%rbp)
	jb	.LBB38_39
	.p2align	4, 0x90
.LBB38_31:                              # %do.body150
                                        #   Parent Loop BB38_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB38_34 Depth 3
	cmpl	$99, -12(%rbp)
	je	.LBB38_59
# BB#32:                                # %if.end154
                                        #   in Loop: Header=BB38_31 Depth=2
	movq	-48(%rbp), %rax
	movb	1(%rax), %cl
	shrq	%cl, -32(%rbp)
	movq	-48(%rbp), %rax
	movzbl	1(%rax), %eax
	subl	%eax, -16(%rbp)
	addl	$-16, -12(%rbp)
	jmp	.LBB38_34
	.p2align	4, 0x90
.LBB38_33:                              # %cond.end176
                                        #   in Loop: Header=BB38_34 Depth=3
	movl	%eax, -76(%rbp)
	movzbl	-76(%rbp), %eax
	movzbl	-16(%rbp), %ecx
	shlq	%cl, %rax
	orq	%rax, -32(%rbp)
	addl	$8, -16(%rbp)
.LBB38_34:                              # %while.cond163
                                        #   Parent Loop BB38_2 Depth=1
                                        #     Parent Loop BB38_31 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-16(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jae	.LBB38_38
# BB#35:                                # %while.body166
                                        #   in Loop: Header=BB38_34 Depth=3
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB38_37
# BB#36:                                # %cond.true169
                                        #   in Loop: Header=BB38_34 Depth=3
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -156(%rbp)
	jmp	.LBB38_33
	.p2align	4, 0x90
.LBB38_37:                              # %cond.false174
                                        #   in Loop: Header=BB38_34 Depth=3
	movl	-20(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -160(%rbp)
	jmp	.LBB38_33
	.p2align	4, 0x90
.LBB38_38:                              # %do.cond185
                                        #   in Loop: Header=BB38_31 Depth=2
	movq	-48(%rbp), %rax
	movq	8(%rax), %rax
	movl	-12(%rbp), %ecx
	movzwl	mask_bits(%rcx,%rcx), %ecx
	andl	-32(%rbp), %ecx
	shlq	$4, %rcx
	leaq	(%rax,%rcx), %rdx
	movq	%rdx, -48(%rbp)
	movzbl	(%rax,%rcx), %eax
	cmpl	$16, %eax
	movl	%eax, -12(%rbp)
	ja	.LBB38_31
.LBB38_39:                              # %if.end200
                                        #   in Loop: Header=BB38_2 Depth=1
	movq	-48(%rbp), %rax
	movb	1(%rax), %cl
	shrq	%cl, -32(%rbp)
	movq	-48(%rbp), %rax
	movzbl	1(%rax), %eax
	subl	%eax, -16(%rbp)
	jmp	.LBB38_41
	.p2align	4, 0x90
.LBB38_40:                              # %cond.end221
                                        #   in Loop: Header=BB38_41 Depth=2
	movl	%eax, -80(%rbp)
	movzbl	-80(%rbp), %eax
	movzbl	-16(%rbp), %ecx
	shlq	%cl, %rax
	orq	%rax, -32(%rbp)
	addl	$8, -16(%rbp)
.LBB38_41:                              # %while.cond208
                                        #   Parent Loop BB38_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-16(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jae	.LBB38_45
# BB#42:                                # %while.body211
                                        #   in Loop: Header=BB38_41 Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB38_44
# BB#43:                                # %cond.true214
                                        #   in Loop: Header=BB38_41 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -164(%rbp)
	jmp	.LBB38_40
	.p2align	4, 0x90
.LBB38_44:                              # %cond.false219
                                        #   in Loop: Header=BB38_41 Depth=2
	movl	-20(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -168(%rbp)
	jmp	.LBB38_40
.LBB38_45:                              # %while.end229
                                        #   in Loop: Header=BB38_2 Depth=1
	movl	-20(%rbp), %eax
	movq	-48(%rbp), %rcx
	movzwl	8(%rcx), %ecx
	subl	%ecx, %eax
	movl	-12(%rbp), %ecx
	movzwl	mask_bits(%rcx,%rcx), %ecx
	andl	-32(%rbp), %ecx
	subl	%ecx, %eax
	movb	-12(%rbp), %cl
	shrq	%cl, -32(%rbp)
	movl	%eax, -36(%rbp)
	movl	-12(%rbp), %eax
	subl	%eax, -16(%rbp)
	.p2align	4, 0x90
.LBB38_46:                              # %do.body243
                                        #   Parent Loop BB38_2 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB38_54 Depth 3
	movl	-36(%rbp), %eax
	andl	%ebx, %eax
	movl	%eax, -36(%rbp)
	cmpl	-20(%rbp), %eax
	jbe	.LBB38_48
# BB#47:                                # %cond.true247
                                        #   in Loop: Header=BB38_46 Depth=2
	movl	-36(%rbp), %eax
	movl	%eax, -172(%rbp)
	jmp	.LBB38_49
	.p2align	4, 0x90
.LBB38_48:                              # %cond.false248
                                        #   in Loop: Header=BB38_46 Depth=2
	movl	-20(%rbp), %eax
	movl	%eax, -176(%rbp)
.LBB38_49:                              # %cond.end249
                                        #   in Loop: Header=BB38_46 Depth=2
	movl	%eax, -84(%rbp)
	movl	$32768, %eax            # imm = 0x8000
	subl	-84(%rbp), %eax
	movl	%eax, -12(%rbp)
	cmpl	-52(%rbp), %eax
	jbe	.LBB38_51
# BB#50:                                # %cond.true254
                                        #   in Loop: Header=BB38_46 Depth=2
	movl	-52(%rbp), %eax
	movl	%eax, -180(%rbp)
	jmp	.LBB38_52
	.p2align	4, 0x90
.LBB38_51:                              # %cond.false255
                                        #   in Loop: Header=BB38_46 Depth=2
	movl	-12(%rbp), %eax
	movl	%eax, -184(%rbp)
.LBB38_52:                              # %cond.end256
                                        #   in Loop: Header=BB38_46 Depth=2
	movl	%eax, -88(%rbp)
	movl	-88(%rbp), %eax
	subl	%eax, -52(%rbp)
	movl	%eax, -12(%rbp)
	movl	-20(%rbp), %eax
	subl	-36(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jb	.LBB38_54
# BB#53:                                # %if.then262
                                        #   in Loop: Header=BB38_46 Depth=2
	movl	-20(%rbp), %eax
	leaq	window(%rax), %rdi
	movl	-36(%rbp), %eax
	leaq	window(%rax), %rsi
	movl	-12(%rbp), %edx
	callq	memcpy
	movl	-12(%rbp), %eax
	addl	%eax, -20(%rbp)
	movl	-12(%rbp), %eax
	addl	%eax, -36(%rbp)
	cmpl	$32768, -20(%rbp)       # imm = 0x8000
	je	.LBB38_56
	jmp	.LBB38_57
	.p2align	4, 0x90
.LBB38_54:                              # %do.cond278
                                        #   Parent Loop BB38_2 Depth=1
                                        #     Parent Loop BB38_46 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	-36(%rbp), %eax
	leal	1(%rax), %ecx
	movl	%ecx, -36(%rbp)
	movzbl	window(%rax), %eax
	movl	-20(%rbp), %ecx
	leal	1(%rcx), %edx
	movl	%edx, -20(%rbp)
	movb	%al, window(%rcx)
	decl	-12(%rbp)
	jne	.LBB38_54
# BB#55:                                # %if.end280
                                        #   in Loop: Header=BB38_46 Depth=2
	cmpl	$32768, -20(%rbp)       # imm = 0x8000
	jne	.LBB38_57
.LBB38_56:                              # %if.then283
                                        #   in Loop: Header=BB38_46 Depth=2
	movl	-20(%rbp), %eax
	movl	%eax, outcnt(%rip)
	callq	flush_window
	movl	$0, -20(%rbp)
.LBB38_57:                              # %do.cond285
                                        #   in Loop: Header=BB38_46 Depth=2
	cmpl	$0, -52(%rbp)
	jne	.LBB38_46
	jmp	.LBB38_2
.LBB38_59:                              # %if.then153
	movl	$1, -56(%rbp)
.LBB38_60:                              # %return
	movl	-56(%rbp), %eax
	addq	$184, %rsp
	popq	%rbx
	popq	%rbp
	retq
.LBB38_61:                              # %for.end
	movl	-20(%rbp), %eax
	movl	%eax, outcnt(%rip)
	movq	-32(%rbp), %rax
	movq	%rax, bb(%rip)
	movl	-16(%rbp), %eax
	movl	%eax, bk(%rip)
	movl	$0, -56(%rbp)
	jmp	.LBB38_60
.Lfunc_end38:
	.size	inflate_codes, .Lfunc_end38-inflate_codes
	.cfi_endproc

	.globl	fill_inbuf
	.p2align	4, 0x90
	.type	fill_inbuf,@function
fill_inbuf:                             # @fill_inbuf
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi126:
	.cfi_def_cfa_offset 16
.Lcfi127:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi128:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -12(%rbp)
	movl	$0, insize(%rip)
	.p2align	4, 0x90
.LBB39_1:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movl	ifd(%rip), %edi
	movl	insize(%rip), %eax
	leaq	inbuf(%rax), %rsi
	movl	$32768, %edx            # imm = 0x8000
	subl	%eax, %edx
	callq	read
	movl	%eax, -4(%rbp)
	testl	%eax, %eax
	je	.LBB39_5
# BB#2:                                 # %if.end
                                        #   in Loop: Header=BB39_1 Depth=1
	cmpl	$-1, -4(%rbp)
	je	.LBB39_3
# BB#4:                                 # %do.cond
                                        #   in Loop: Header=BB39_1 Depth=1
	movl	insize(%rip), %eax
	addl	-4(%rbp), %eax
	movl	%eax, insize(%rip)
	cmpl	$32768, %eax            # imm = 0x8000
	jb	.LBB39_1
	jmp	.LBB39_5
.LBB39_3:                               # %if.then5
	callq	read_error
.LBB39_5:                               # %do.end
	cmpl	$0, insize(%rip)
	je	.LBB39_6
.LBB39_9:                               # %if.end15
	movl	insize(%rip), %eax
	addq	%rax, bytes_in(%rip)
	movl	$1, inptr(%rip)
	movzbl	inbuf(%rip), %eax
	movl	%eax, -8(%rbp)
	jmp	.LBB39_10
.LBB39_6:                               # %if.then11
	cmpl	$0, -12(%rbp)
	je	.LBB39_8
# BB#7:                                 # %if.then12
	movl	$-1, -8(%rbp)
.LBB39_10:                              # %return
	movl	-8(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	retq
.LBB39_8:                               # %if.end13
	callq	flush_window
	callq	__errno_location
	movl	$0, (%rax)
	callq	read_error
	jmp	.LBB39_9
.Lfunc_end39:
	.size	fill_inbuf, .Lfunc_end39-fill_inbuf
	.cfi_endproc

	.globl	flush_window
	.p2align	4, 0x90
	.type	flush_window,@function
flush_window:                           # @flush_window
	.cfi_startproc
# BB#0:                                 # %entry
	cmpl	$0, outcnt(%rip)
	je	.LBB40_4
# BB#1:                                 # %if.end
	pushq	%rbp
.Lcfi129:
	.cfi_def_cfa_offset 16
.Lcfi130:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi131:
	.cfi_def_cfa_register %rbp
	movl	outcnt(%rip), %esi
	movl	$window, %edi
	callq	updcrc
	cmpl	$0, test(%rip)
	jne	.LBB40_3
# BB#2:                                 # %if.then1
	movl	ofd(%rip), %edi
	movl	outcnt(%rip), %edx
	movl	$window, %esi
	callq	write_buf
.LBB40_3:                               # %if.end2
	movl	outcnt(%rip), %eax
	addq	%rax, bytes_out(%rip)
	movl	$0, outcnt(%rip)
	popq	%rbp
.LBB40_4:                               # %return
	retq
.Lfunc_end40:
	.size	flush_window, .Lfunc_end40-flush_window
	.cfi_endproc

	.globl	inflate_stored
	.p2align	4, 0x90
	.type	inflate_stored,@function
inflate_stored:                         # @inflate_stored
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi132:
	.cfi_def_cfa_offset 16
.Lcfi133:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi134:
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	bb(%rip), %rax
	movq	%rax, -16(%rbp)
	movl	bk(%rip), %eax
	movl	%eax, -4(%rbp)
	movl	outcnt(%rip), %eax
	movl	%eax, -8(%rbp)
	movl	-4(%rbp), %ecx
	andl	$7, %ecx
	shrq	%cl, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movl	-20(%rbp), %eax
	subl	%eax, -4(%rbp)
	cmpl	$15, -4(%rbp)
	jbe	.LBB41_2
	jmp	.LBB41_6
	.p2align	4, 0x90
.LBB41_5:                               # %cond.end
                                        #   in Loop: Header=BB41_2 Depth=1
	movl	%eax, -24(%rbp)
	movzbl	-24(%rbp), %eax
	movzbl	-4(%rbp), %ecx
	shlq	%cl, %rax
	orq	%rax, -16(%rbp)
	addl	$8, -4(%rbp)
	cmpl	$15, -4(%rbp)
	ja	.LBB41_6
.LBB41_2:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB41_4
# BB#3:                                 # %cond.true
                                        #   in Loop: Header=BB41_2 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -40(%rbp)
	jmp	.LBB41_5
	.p2align	4, 0x90
.LBB41_4:                               # %cond.false
                                        #   in Loop: Header=BB41_2 Depth=1
	movl	-8(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -44(%rbp)
	jmp	.LBB41_5
.LBB41_6:                               # %while.end
	movzwl	-16(%rbp), %eax
	movl	%eax, -20(%rbp)
	shrq	$16, -16(%rbp)
	addl	$-16, -4(%rbp)
	cmpl	$15, -4(%rbp)
	jbe	.LBB41_8
	jmp	.LBB41_12
	.p2align	4, 0x90
.LBB41_11:                              # %cond.end22
                                        #   in Loop: Header=BB41_8 Depth=1
	movl	%eax, -28(%rbp)
	movzbl	-28(%rbp), %eax
	movzbl	-4(%rbp), %ecx
	shlq	%cl, %rax
	orq	%rax, -16(%rbp)
	addl	$8, -4(%rbp)
	cmpl	$15, -4(%rbp)
	ja	.LBB41_12
.LBB41_8:                               # %while.body12
                                        # =>This Inner Loop Header: Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB41_10
# BB#9:                                 # %cond.true15
                                        #   in Loop: Header=BB41_8 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -48(%rbp)
	jmp	.LBB41_11
	.p2align	4, 0x90
.LBB41_10:                              # %cond.false20
                                        #   in Loop: Header=BB41_8 Depth=1
	movl	-8(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -52(%rbp)
	jmp	.LBB41_11
.LBB41_12:                              # %while.end30
	movl	-16(%rbp), %eax
	notl	%eax
	movzwl	%ax, %eax
	cmpl	%eax, -20(%rbp)
	je	.LBB41_14
# BB#13:                                # %if.then
	movl	$1, -36(%rbp)
	jmp	.LBB41_25
.LBB41_14:                              # %if.end
	shrq	$16, -16(%rbp)
	addl	$-16, -4(%rbp)
	jmp	.LBB41_15
	.p2align	4, 0x90
.LBB41_23:                              # %if.end68
                                        #   in Loop: Header=BB41_15 Depth=1
	shrq	$8, -16(%rbp)
	addl	$-8, -4(%rbp)
.LBB41_15:                              # %while.cond37
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB41_16 Depth 2
	movl	-20(%rbp), %eax
	leal	-1(%rax), %ecx
	movl	%ecx, -20(%rbp)
	testl	%eax, %eax
	jne	.LBB41_16
	jmp	.LBB41_24
	.p2align	4, 0x90
.LBB41_20:                              # %cond.end52
                                        #   in Loop: Header=BB41_16 Depth=2
	movl	%eax, -32(%rbp)
	movzbl	-32(%rbp), %eax
	movzbl	-4(%rbp), %ecx
	shlq	%cl, %rax
	orq	%rax, -16(%rbp)
	addl	$8, -4(%rbp)
.LBB41_16:                              # %while.cond39
                                        #   Parent Loop BB41_15 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$7, -4(%rbp)
	ja	.LBB41_21
# BB#17:                                # %while.body42
                                        #   in Loop: Header=BB41_16 Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB41_19
# BB#18:                                # %cond.true45
                                        #   in Loop: Header=BB41_16 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -56(%rbp)
	jmp	.LBB41_20
	.p2align	4, 0x90
.LBB41_19:                              # %cond.false50
                                        #   in Loop: Header=BB41_16 Depth=2
	movl	-8(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -60(%rbp)
	jmp	.LBB41_20
	.p2align	4, 0x90
.LBB41_21:                              # %while.end60
                                        #   in Loop: Header=BB41_15 Depth=1
	movb	-16(%rbp), %al
	movl	-8(%rbp), %ecx
	leal	1(%rcx), %edx
	movl	%edx, -8(%rbp)
	movb	%al, window(%rcx)
	cmpl	$32768, -8(%rbp)        # imm = 0x8000
	jne	.LBB41_23
# BB#22:                                # %if.then67
                                        #   in Loop: Header=BB41_15 Depth=1
	movl	-8(%rbp), %eax
	movl	%eax, outcnt(%rip)
	callq	flush_window
	movl	$0, -8(%rbp)
	jmp	.LBB41_23
.LBB41_24:                              # %while.end71
	movl	-8(%rbp), %eax
	movl	%eax, outcnt(%rip)
	movq	-16(%rbp), %rax
	movq	%rax, bb(%rip)
	movl	-4(%rbp), %eax
	movl	%eax, bk(%rip)
	movl	$0, -36(%rbp)
.LBB41_25:                              # %return
	movl	-36(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	retq
.Lfunc_end41:
	.size	inflate_stored, .Lfunc_end41-inflate_stored
	.cfi_endproc

	.globl	inflate_fixed
	.p2align	4, 0x90
	.type	inflate_fixed,@function
inflate_fixed:                          # @inflate_fixed
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi135:
	.cfi_def_cfa_offset 16
.Lcfi136:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi137:
	.cfi_def_cfa_register %rbp
	subq	$1200, %rsp             # imm = 0x4B0
	movl	$0, -4(%rbp)
	cmpl	$143, -4(%rbp)
	jg	.LBB42_3
	.p2align	4, 0x90
.LBB42_2:                               # %for.inc
                                        # =>This Inner Loop Header: Depth=1
	movslq	-4(%rbp), %rax
	movl	$8, -1184(%rbp,%rax,4)
	incl	-4(%rbp)
	cmpl	$143, -4(%rbp)
	jle	.LBB42_2
	jmp	.LBB42_3
	.p2align	4, 0x90
.LBB42_4:                               # %for.inc6
                                        #   in Loop: Header=BB42_3 Depth=1
	movslq	-4(%rbp), %rax
	movl	$9, -1184(%rbp,%rax,4)
	incl	-4(%rbp)
.LBB42_3:                               # %for.cond1
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$255, -4(%rbp)
	jle	.LBB42_4
	jmp	.LBB42_5
	.p2align	4, 0x90
.LBB42_6:                               # %for.inc14
                                        #   in Loop: Header=BB42_5 Depth=1
	movslq	-4(%rbp), %rax
	movl	$7, -1184(%rbp,%rax,4)
	incl	-4(%rbp)
.LBB42_5:                               # %for.cond9
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$279, -4(%rbp)          # imm = 0x117
	jle	.LBB42_6
	jmp	.LBB42_7
	.p2align	4, 0x90
.LBB42_8:                               # %for.inc22
                                        #   in Loop: Header=BB42_7 Depth=1
	movslq	-4(%rbp), %rax
	movl	$8, -1184(%rbp,%rax,4)
	incl	-4(%rbp)
.LBB42_7:                               # %for.cond17
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$287, -4(%rbp)          # imm = 0x11F
	jle	.LBB42_8
# BB#9:                                 # %for.end24
	movl	$7, -16(%rbp)
	leaq	-16(%rbp), %rax
	movq	%rax, (%rsp)
	leaq	-1184(%rbp), %rdi
	leaq	-24(%rbp), %r9
	movl	$288, %esi              # imm = 0x120
	movl	$257, %edx              # imm = 0x101
	movl	$cplens, %ecx
	movl	$cplext, %r8d
	callq	huft_build
	movl	%eax, -4(%rbp)
	testl	%eax, %eax
	jne	.LBB42_10
# BB#11:                                # %if.end
	movl	$0, -4(%rbp)
	cmpl	$29, -4(%rbp)
	jg	.LBB42_14
	.p2align	4, 0x90
.LBB42_13:                              # %for.inc31
                                        # =>This Inner Loop Header: Depth=1
	movslq	-4(%rbp), %rax
	movl	$5, -1184(%rbp,%rax,4)
	incl	-4(%rbp)
	cmpl	$29, -4(%rbp)
	jle	.LBB42_13
.LBB42_14:                              # %for.end33
	movl	$5, -12(%rbp)
	leaq	-12(%rbp), %rax
	movq	%rax, (%rsp)
	leaq	-1184(%rbp), %rdi
	leaq	-32(%rbp), %r9
	movl	$30, %esi
	xorl	%edx, %edx
	movl	$cpdist, %ecx
	movl	$cpdext, %r8d
	callq	huft_build
	movl	%eax, -4(%rbp)
	cmpl	$2, %eax
	jl	.LBB42_16
# BB#15:                                # %if.then37
	movq	-24(%rbp), %rdi
	callq	huft_free
.LBB42_10:                              # %if.then
	movl	-4(%rbp), %eax
	movl	%eax, -8(%rbp)
.LBB42_19:                              # %return
	movl	-8(%rbp), %eax
	addq	$1200, %rsp             # imm = 0x4B0
	popq	%rbp
	retq
.LBB42_16:                              # %if.end39
	movq	-24(%rbp), %rdi
	movq	-32(%rbp), %rsi
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %ecx
	callq	inflate_codes
	testl	%eax, %eax
	je	.LBB42_18
# BB#17:                                # %if.then41
	movl	$1, -8(%rbp)
	jmp	.LBB42_19
.LBB42_18:                              # %if.end42
	movq	-24(%rbp), %rdi
	callq	huft_free
	movq	-32(%rbp), %rdi
	callq	huft_free
	movl	$0, -8(%rbp)
	jmp	.LBB42_19
.Lfunc_end42:
	.size	inflate_fixed, .Lfunc_end42-inflate_fixed
	.cfi_endproc

	.globl	inflate_dynamic
	.p2align	4, 0x90
	.type	inflate_dynamic,@function
inflate_dynamic:                        # @inflate_dynamic
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi138:
	.cfi_def_cfa_offset 16
.Lcfi139:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi140:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$1464, %rsp             # imm = 0x5B8
.Lcfi141:
	.cfi_offset %rbx, -24
	movq	bb(%rip), %rax
	movq	%rax, -32(%rbp)
	movl	bk(%rip), %eax
	movl	%eax, -12(%rbp)
	movl	outcnt(%rip), %eax
	movl	%eax, -40(%rbp)
	cmpl	$4, -12(%rbp)
	ja	.LBB43_5
	.p2align	4, 0x90
.LBB43_2:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB43_4
# BB#3:                                 # %cond.true
                                        #   in Loop: Header=BB43_2 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -128(%rbp)
	jmp	.LBB43_1
	.p2align	4, 0x90
.LBB43_4:                               # %cond.false
                                        #   in Loop: Header=BB43_2 Depth=1
	movl	-40(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -132(%rbp)
.LBB43_1:                               # %cond.end
                                        #   in Loop: Header=BB43_2 Depth=1
	movl	%eax, -84(%rbp)
	movzbl	-84(%rbp), %eax
	movzbl	-12(%rbp), %ecx
	shlq	%cl, %rax
	orq	%rax, -32(%rbp)
	addl	$8, -12(%rbp)
	cmpl	$4, -12(%rbp)
	jbe	.LBB43_2
.LBB43_5:                               # %while.end
	movl	-32(%rbp), %eax
	andl	$31, %eax
	addl	$257, %eax              # imm = 0x101
	movl	%eax, -60(%rbp)
	shrq	$5, -32(%rbp)
	addl	$-5, -12(%rbp)
	cmpl	$4, -12(%rbp)
	ja	.LBB43_10
	.p2align	4, 0x90
.LBB43_7:                               # %while.body9
                                        # =>This Inner Loop Header: Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB43_9
# BB#8:                                 # %cond.true12
                                        #   in Loop: Header=BB43_7 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -136(%rbp)
	jmp	.LBB43_6
	.p2align	4, 0x90
.LBB43_9:                               # %cond.false17
                                        #   in Loop: Header=BB43_7 Depth=1
	movl	-40(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -140(%rbp)
.LBB43_6:                               # %cond.end19
                                        #   in Loop: Header=BB43_7 Depth=1
	movl	%eax, -88(%rbp)
	movzbl	-88(%rbp), %eax
	movzbl	-12(%rbp), %ecx
	shlq	%cl, %rax
	orq	%rax, -32(%rbp)
	addl	$8, -12(%rbp)
	cmpl	$4, -12(%rbp)
	jbe	.LBB43_7
.LBB43_10:                              # %while.end27
	movl	-32(%rbp), %eax
	andl	$31, %eax
	incl	%eax
	movl	%eax, -72(%rbp)
	shrq	$5, -32(%rbp)
	addl	$-5, -12(%rbp)
	cmpl	$3, -12(%rbp)
	ja	.LBB43_15
	.p2align	4, 0x90
.LBB43_12:                              # %while.body36
                                        # =>This Inner Loop Header: Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB43_14
# BB#13:                                # %cond.true39
                                        #   in Loop: Header=BB43_12 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -144(%rbp)
	jmp	.LBB43_11
	.p2align	4, 0x90
.LBB43_14:                              # %cond.false44
                                        #   in Loop: Header=BB43_12 Depth=1
	movl	-40(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -148(%rbp)
.LBB43_11:                              # %cond.end46
                                        #   in Loop: Header=BB43_12 Depth=1
	movl	%eax, -92(%rbp)
	movzbl	-92(%rbp), %eax
	movzbl	-12(%rbp), %ecx
	shlq	%cl, %rax
	orq	%rax, -32(%rbp)
	addl	$8, -12(%rbp)
	cmpl	$3, -12(%rbp)
	jbe	.LBB43_12
.LBB43_15:                              # %while.end54
	movl	-32(%rbp), %eax
	andl	$15, %eax
	addl	$4, %eax
	movl	%eax, -120(%rbp)
	shrq	$4, -32(%rbp)
	addl	$-4, -12(%rbp)
	cmpl	$286, -60(%rbp)         # imm = 0x11E
	ja	.LBB43_17
# BB#16:                                # %lor.lhs.false
	cmpl	$31, -72(%rbp)
	jb	.LBB43_18
.LBB43_17:                              # %if.then
	movl	$1, -36(%rbp)
	jmp	.LBB43_32
.LBB43_18:                              # %if.end
	movl	$0, -16(%rbp)
	jmp	.LBB43_20
	.p2align	4, 0x90
.LBB43_19:                              # %for.inc
                                        #   in Loop: Header=BB43_20 Depth=1
	movl	-32(%rbp), %eax
	andl	$7, %eax
	movl	-16(%rbp), %ecx
	movl	border(,%rcx,4), %ecx
	movl	%eax, -1456(%rbp,%rcx,4)
	shrq	$3, -32(%rbp)
	addl	$-3, -12(%rbp)
	incl	-16(%rbp)
.LBB43_20:                              # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB43_22 Depth 2
	movl	-16(%rbp), %eax
	cmpl	-120(%rbp), %eax
	jb	.LBB43_22
	jmp	.LBB43_27
	.p2align	4, 0x90
.LBB43_21:                              # %cond.end79
                                        #   in Loop: Header=BB43_22 Depth=2
	movl	%eax, -96(%rbp)
	movzbl	-96(%rbp), %eax
	movzbl	-12(%rbp), %ecx
	shlq	%cl, %rax
	orq	%rax, -32(%rbp)
	addl	$8, -12(%rbp)
.LBB43_22:                              # %while.cond66
                                        #   Parent Loop BB43_20 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$2, -12(%rbp)
	ja	.LBB43_19
# BB#23:                                # %while.body69
                                        #   in Loop: Header=BB43_22 Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB43_25
# BB#24:                                # %cond.true72
                                        #   in Loop: Header=BB43_22 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -152(%rbp)
	jmp	.LBB43_21
	.p2align	4, 0x90
.LBB43_25:                              # %cond.false77
                                        #   in Loop: Header=BB43_22 Depth=2
	movl	-40(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -156(%rbp)
	jmp	.LBB43_21
	.p2align	4, 0x90
.LBB43_26:                              # %for.inc105
                                        #   in Loop: Header=BB43_27 Depth=1
	movl	-16(%rbp), %eax
	movl	border(,%rax,4), %eax
	movl	$0, -1456(%rbp,%rax,4)
	incl	-16(%rbp)
.LBB43_27:                              # %for.cond97
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$18, -16(%rbp)
	jbe	.LBB43_26
# BB#28:                                # %for.end107
	movl	$7, -44(%rbp)
	leaq	-44(%rbp), %rbx
	movq	%rbx, (%rsp)
	leaq	-1456(%rbp), %rdi
	leaq	-56(%rbp), %r9
	movl	$19, %esi
	movl	$19, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	huft_build
	movl	%eax, -20(%rbp)
	testl	%eax, %eax
	je	.LBB43_33
# BB#29:                                # %if.then111
	cmpl	$1, -20(%rbp)
	jne	.LBB43_31
.LBB43_30:                              # %if.then114
	movq	-56(%rbp), %rdi
	callq	huft_free
.LBB43_31:                              # %if.end116
	movl	-20(%rbp), %eax
	movl	%eax, -36(%rbp)
.LBB43_32:                              # %return
	movl	-36(%rbp), %eax
	addq	$1464, %rsp             # imm = 0x5B8
	popq	%rbx
	popq	%rbp
	retq
.LBB43_33:                              # %if.end117
	cmpq	$0, -56(%rbp)
	je	.LBB43_74
# BB#34:                                # %if.end121
	movl	-60(%rbp), %eax
	addl	-72(%rbp), %eax
	movl	%eax, -64(%rbp)
	movslq	-44(%rbp), %rax
	movzwl	mask_bits(%rax,%rax), %eax
	movl	%eax, -124(%rbp)
	movl	$0, -68(%rbp)
	movl	$0, -20(%rbp)
	jmp	.LBB43_36
	.p2align	4, 0x90
.LBB43_35:                              # %if.then163
                                        #   in Loop: Header=BB43_36 Depth=1
	movl	-16(%rbp), %eax
	movl	%eax, -68(%rbp)
	movslq	-20(%rbp), %rcx
	leal	1(%rcx), %edx
	movl	%edx, -20(%rbp)
	movl	%eax, -1456(%rbp,%rcx,4)
.LBB43_36:                              # %while.cond126
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB43_38 Depth 2
                                        #     Child Loop BB43_56 Depth 2
                                        #     Child Loop BB43_69 Depth 2
                                        #     Child Loop BB43_51 Depth 2
                                        #     Child Loop BB43_65 Depth 2
                                        #     Child Loop BB43_46 Depth 2
                                        #     Child Loop BB43_62 Depth 2
	movl	-20(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jb	.LBB43_38
	jmp	.LBB43_71
	.p2align	4, 0x90
.LBB43_37:                              # %cond.end143
                                        #   in Loop: Header=BB43_38 Depth=2
	movl	%eax, -100(%rbp)
	movzbl	-100(%rbp), %eax
	movzbl	-12(%rbp), %ecx
	shlq	%cl, %rax
	orq	%rax, -32(%rbp)
	addl	$8, -12(%rbp)
.LBB43_38:                              # %while.cond130
                                        #   Parent Loop BB43_36 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-12(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jae	.LBB43_42
# BB#39:                                # %while.body133
                                        #   in Loop: Header=BB43_38 Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB43_41
# BB#40:                                # %cond.true136
                                        #   in Loop: Header=BB43_38 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -160(%rbp)
	jmp	.LBB43_37
	.p2align	4, 0x90
.LBB43_41:                              # %cond.false141
                                        #   in Loop: Header=BB43_38 Depth=2
	movl	-40(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -164(%rbp)
	jmp	.LBB43_37
	.p2align	4, 0x90
.LBB43_42:                              # %while.end151
                                        #   in Loop: Header=BB43_36 Depth=1
	movq	-56(%rbp), %rax
	movl	-32(%rbp), %ecx
	andl	-124(%rbp), %ecx
	shlq	$4, %rcx
	leaq	(%rax,%rcx), %rdx
	movq	%rdx, -80(%rbp)
	movzbl	1(%rax,%rcx), %ecx
	shrq	%cl, -32(%rbp)
	movl	%ecx, -16(%rbp)
	movl	-16(%rbp), %eax
	subl	%eax, -12(%rbp)
	movq	-80(%rbp), %rax
	movzwl	8(%rax), %eax
	cmpl	$15, %eax
	movl	%eax, -16(%rbp)
	jbe	.LBB43_35
# BB#43:                                # %if.else
                                        #   in Loop: Header=BB43_36 Depth=1
	cmpl	$16, -16(%rbp)
	je	.LBB43_46
# BB#44:                                # %if.else208
                                        #   in Loop: Header=BB43_36 Depth=1
	cmpl	$17, -16(%rbp)
	jne	.LBB43_56
	jmp	.LBB43_51
	.p2align	4, 0x90
.LBB43_45:                              # %cond.end183
                                        #   in Loop: Header=BB43_46 Depth=2
	movl	%eax, -104(%rbp)
	movzbl	-104(%rbp), %eax
	movzbl	-12(%rbp), %ecx
	shlq	%cl, %rax
	orq	%rax, -32(%rbp)
	addl	$8, -12(%rbp)
.LBB43_46:                              # %while.cond170
                                        #   Parent Loop BB43_36 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$1, -12(%rbp)
	ja	.LBB43_60
# BB#47:                                # %while.body173
                                        #   in Loop: Header=BB43_46 Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB43_49
# BB#48:                                # %cond.true176
                                        #   in Loop: Header=BB43_46 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -168(%rbp)
	jmp	.LBB43_45
	.p2align	4, 0x90
.LBB43_49:                              # %cond.false181
                                        #   in Loop: Header=BB43_46 Depth=2
	movl	-40(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -172(%rbp)
	jmp	.LBB43_45
	.p2align	4, 0x90
.LBB43_50:                              # %cond.end225
                                        #   in Loop: Header=BB43_51 Depth=2
	movl	%eax, -108(%rbp)
	movzbl	-108(%rbp), %eax
	movzbl	-12(%rbp), %ecx
	shlq	%cl, %rax
	orq	%rax, -32(%rbp)
	addl	$8, -12(%rbp)
.LBB43_51:                              # %while.cond212
                                        #   Parent Loop BB43_36 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$2, -12(%rbp)
	ja	.LBB43_63
# BB#52:                                # %while.body215
                                        #   in Loop: Header=BB43_51 Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB43_54
# BB#53:                                # %cond.true218
                                        #   in Loop: Header=BB43_51 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -176(%rbp)
	jmp	.LBB43_50
	.p2align	4, 0x90
.LBB43_54:                              # %cond.false223
                                        #   in Loop: Header=BB43_51 Depth=2
	movl	-40(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -180(%rbp)
	jmp	.LBB43_50
	.p2align	4, 0x90
.LBB43_55:                              # %cond.end266
                                        #   in Loop: Header=BB43_56 Depth=2
	movl	%eax, -112(%rbp)
	movzbl	-112(%rbp), %eax
	movzbl	-12(%rbp), %ecx
	shlq	%cl, %rax
	orq	%rax, -32(%rbp)
	addl	$8, -12(%rbp)
.LBB43_56:                              # %while.cond253
                                        #   Parent Loop BB43_36 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$6, -12(%rbp)
	ja	.LBB43_67
# BB#57:                                # %while.body256
                                        #   in Loop: Header=BB43_56 Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB43_59
# BB#58:                                # %cond.true259
                                        #   in Loop: Header=BB43_56 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -184(%rbp)
	jmp	.LBB43_55
	.p2align	4, 0x90
.LBB43_59:                              # %cond.false264
                                        #   in Loop: Header=BB43_56 Depth=2
	movl	-40(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -188(%rbp)
	jmp	.LBB43_55
	.p2align	4, 0x90
.LBB43_60:                              # %while.end191
                                        #   in Loop: Header=BB43_36 Depth=1
	movl	-32(%rbp), %eax
	andl	$3, %eax
	addl	$3, %eax
	shrq	$2, -32(%rbp)
	addl	$-2, -12(%rbp)
	movl	%eax, -16(%rbp)
	movl	-20(%rbp), %eax
	addl	-16(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jbe	.LBB43_62
	jmp	.LBB43_78
	.p2align	4, 0x90
.LBB43_61:                              # %while.body203
                                        #   in Loop: Header=BB43_62 Depth=2
	movl	-68(%rbp), %eax
	movslq	-20(%rbp), %rcx
	leal	1(%rcx), %edx
	movl	%edx, -20(%rbp)
	movl	%eax, -1456(%rbp,%rcx,4)
.LBB43_62:                              # %while.cond202
                                        #   Parent Loop BB43_36 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-16(%rbp), %eax
	leal	-1(%rax), %ecx
	movl	%ecx, -16(%rbp)
	testl	%eax, %eax
	jne	.LBB43_61
	jmp	.LBB43_36
.LBB43_63:                              # %while.end233
                                        #   in Loop: Header=BB43_36 Depth=1
	movl	-32(%rbp), %eax
	andl	$7, %eax
	addl	$3, %eax
	shrq	$3, -32(%rbp)
	addl	$-3, -12(%rbp)
	movl	%eax, -16(%rbp)
	movl	-20(%rbp), %eax
	addl	-16(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jbe	.LBB43_65
	jmp	.LBB43_82
	.p2align	4, 0x90
.LBB43_64:                              # %while.body247
                                        #   in Loop: Header=BB43_65 Depth=2
	movslq	-20(%rbp), %rax
	leal	1(%rax), %ecx
	movl	%ecx, -20(%rbp)
	movl	$0, -1456(%rbp,%rax,4)
.LBB43_65:                              # %while.cond244
                                        #   Parent Loop BB43_36 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-16(%rbp), %eax
	leal	-1(%rax), %ecx
	movl	%ecx, -16(%rbp)
	testl	%eax, %eax
	jne	.LBB43_64
# BB#66:                                # %while.end251
                                        #   in Loop: Header=BB43_36 Depth=1
	movl	$0, -68(%rbp)
	jmp	.LBB43_36
.LBB43_67:                              # %while.end274
                                        #   in Loop: Header=BB43_36 Depth=1
	movl	-32(%rbp), %eax
	andl	$127, %eax
	addl	$11, %eax
	shrq	$7, -32(%rbp)
	addl	$-7, -12(%rbp)
	movl	%eax, -16(%rbp)
	movl	-20(%rbp), %eax
	addl	-16(%rbp), %eax
	cmpl	-64(%rbp), %eax
	jbe	.LBB43_69
	jmp	.LBB43_82
	.p2align	4, 0x90
.LBB43_68:                              # %while.body288
                                        #   in Loop: Header=BB43_69 Depth=2
	movslq	-20(%rbp), %rax
	leal	1(%rax), %ecx
	movl	%ecx, -20(%rbp)
	movl	$0, -1456(%rbp,%rax,4)
.LBB43_69:                              # %while.cond285
                                        #   Parent Loop BB43_36 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-16(%rbp), %eax
	leal	-1(%rax), %ecx
	movl	%ecx, -16(%rbp)
	testl	%eax, %eax
	jne	.LBB43_68
# BB#70:                                # %while.end292
                                        #   in Loop: Header=BB43_36 Depth=1
	movl	$0, -68(%rbp)
	jmp	.LBB43_36
.LBB43_71:                              # %while.end296
	movq	-56(%rbp), %rdi
	callq	huft_free
	movq	-32(%rbp), %rax
	movq	%rax, bb(%rip)
	movl	-12(%rbp), %eax
	movl	%eax, bk(%rip)
	movl	lbits(%rip), %eax
	movl	%eax, -44(%rbp)
	movl	-60(%rbp), %esi
	movq	%rbx, (%rsp)
	leaq	-1456(%rbp), %rdi
	leaq	-56(%rbp), %r9
	movl	$257, %edx              # imm = 0x101
	movl	$cplens, %ecx
	movl	$cplext, %r8d
	callq	huft_build
	movl	%eax, -20(%rbp)
	testl	%eax, %eax
	je	.LBB43_75
# BB#72:                                # %if.then302
	cmpl	$1, -20(%rbp)
	jne	.LBB43_31
# BB#73:                                # %if.then305
	movq	stderr(%rip), %rdi
	movl	$.L.str.50, %esi
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB43_30
.LBB43_74:                              # %if.then120
	movl	$2, -36(%rbp)
	jmp	.LBB43_32
.LBB43_75:                              # %if.end309
	movl	dbits(%rip), %eax
	movl	%eax, -116(%rbp)
	movl	-60(%rbp), %eax
	leaq	-1456(%rbp,%rax,4), %rdi
	movl	-72(%rbp), %esi
	leaq	-116(%rbp), %rax
	movq	%rax, (%rsp)
	leaq	-80(%rbp), %r9
	xorl	%edx, %edx
	movl	$cpdist, %ecx
	movl	$cpdext, %r8d
	callq	huft_build
	movl	%eax, -20(%rbp)
	testl	%eax, %eax
	je	.LBB43_79
# BB#76:                                # %if.then316
	cmpl	$1, -20(%rbp)
	jne	.LBB43_30
# BB#77:                                # %if.then319
	movq	stderr(%rip), %rdi
	movl	$.L.str.51, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	-80(%rbp), %rdi
	callq	huft_free
	jmp	.LBB43_30
.LBB43_78:                              # %if.then200
	movl	$1, -36(%rbp)
	jmp	.LBB43_32
.LBB43_79:                              # %if.end324
	movq	-56(%rbp), %rdi
	movq	-80(%rbp), %rsi
	movl	-44(%rbp), %edx
	movl	-116(%rbp), %ecx
	callq	inflate_codes
	testl	%eax, %eax
	je	.LBB43_83
.LBB43_82:                              # %if.then283
	movl	$1, -36(%rbp)
	jmp	.LBB43_32
.LBB43_83:                              # %if.end328
	movq	-56(%rbp), %rdi
	callq	huft_free
	movq	-80(%rbp), %rdi
	callq	huft_free
	movl	$0, -36(%rbp)
	jmp	.LBB43_32
.Lfunc_end43:
	.size	inflate_dynamic, .Lfunc_end43-inflate_dynamic
	.cfi_endproc

	.globl	inflate_block
	.p2align	4, 0x90
	.type	inflate_block,@function
inflate_block:                          # @inflate_block
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
	subq	$64, %rsp
	movq	%rdi, -40(%rbp)
	movq	bb(%rip), %rax
	movq	%rax, -16(%rbp)
	movl	bk(%rip), %eax
	movl	%eax, -4(%rbp)
	movl	outcnt(%rip), %eax
	movl	%eax, -32(%rbp)
	cmpl	$0, -4(%rbp)
	je	.LBB44_2
	jmp	.LBB44_6
	.p2align	4, 0x90
.LBB44_5:                               # %cond.end
                                        #   in Loop: Header=BB44_2 Depth=1
	movl	%eax, -24(%rbp)
	movzbl	-24(%rbp), %eax
	movzbl	-4(%rbp), %ecx
	shlq	%cl, %rax
	orq	%rax, -16(%rbp)
	addl	$8, -4(%rbp)
	cmpl	$0, -4(%rbp)
	jne	.LBB44_6
.LBB44_2:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB44_4
# BB#3:                                 # %cond.true
                                        #   in Loop: Header=BB44_2 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB44_5
	.p2align	4, 0x90
.LBB44_4:                               # %cond.false
                                        #   in Loop: Header=BB44_2 Depth=1
	movl	-32(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -48(%rbp)
	jmp	.LBB44_5
.LBB44_6:                               # %while.end
	movl	-16(%rbp), %eax
	andl	$1, %eax
	movq	-40(%rbp), %rcx
	movl	%eax, (%rcx)
	shrq	-16(%rbp)
	decl	-4(%rbp)
	cmpl	$1, -4(%rbp)
	jbe	.LBB44_8
	jmp	.LBB44_12
	.p2align	4, 0x90
.LBB44_11:                              # %cond.end18
                                        #   in Loop: Header=BB44_8 Depth=1
	movl	%eax, -28(%rbp)
	movzbl	-28(%rbp), %eax
	movzbl	-4(%rbp), %ecx
	shlq	%cl, %rax
	orq	%rax, -16(%rbp)
	addl	$8, -4(%rbp)
	cmpl	$1, -4(%rbp)
	ja	.LBB44_12
.LBB44_8:                               # %while.body8
                                        # =>This Inner Loop Header: Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB44_10
# BB#9:                                 # %cond.true11
                                        #   in Loop: Header=BB44_8 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -52(%rbp)
	jmp	.LBB44_11
	.p2align	4, 0x90
.LBB44_10:                              # %cond.false16
                                        #   in Loop: Header=BB44_8 Depth=1
	movl	-32(%rbp), %eax
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -56(%rbp)
	jmp	.LBB44_11
.LBB44_12:                              # %while.end26
	movl	-16(%rbp), %eax
	andl	$3, %eax
	movl	%eax, -20(%rbp)
	shrq	$2, -16(%rbp)
	addl	$-2, -4(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, bb(%rip)
	movl	-4(%rbp), %eax
	movl	%eax, bk(%rip)
	cmpl	$2, -20(%rbp)
	jne	.LBB44_14
# BB#13:                                # %if.then
	callq	inflate_dynamic
	movl	%eax, -8(%rbp)
	jmp	.LBB44_19
.LBB44_14:                              # %if.end
	cmpl	$0, -20(%rbp)
	je	.LBB44_15
# BB#16:                                # %if.end38
	cmpl	$1, -20(%rbp)
	jne	.LBB44_18
# BB#17:                                # %if.then41
	callq	inflate_fixed
	movl	%eax, -8(%rbp)
	jmp	.LBB44_19
.LBB44_15:                              # %if.then36
	callq	inflate_stored
	movl	%eax, -8(%rbp)
	jmp	.LBB44_19
.LBB44_18:                              # %if.end43
	movl	$2, -8(%rbp)
.LBB44_19:                              # %return
	movl	-8(%rbp), %eax
	addq	$64, %rsp
	popq	%rbp
	retq
.Lfunc_end44:
	.size	inflate_block, .Lfunc_end44-inflate_block
	.cfi_endproc

	.globl	inflate
	.p2align	4, 0x90
	.type	inflate,@function
inflate:                                # @inflate
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi145:
	.cfi_def_cfa_offset 16
.Lcfi146:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi147:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$24, %rsp
.Lcfi148:
	.cfi_offset %rbx, -24
	movl	$0, outcnt(%rip)
	movl	$0, bk(%rip)
	movq	$0, bb(%rip)
	movl	$0, -12(%rbp)
	leaq	-24(%rbp), %rbx
	.p2align	4, 0x90
.LBB45_1:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movl	$0, hufts(%rip)
	movq	%rbx, %rdi
	callq	inflate_block
	movl	%eax, -20(%rbp)
	testl	%eax, %eax
	jne	.LBB45_2
# BB#3:                                 # %if.end
                                        #   in Loop: Header=BB45_1 Depth=1
	movl	hufts(%rip), %eax
	cmpl	-12(%rbp), %eax
	jbe	.LBB45_5
# BB#4:                                 # %if.then2
                                        #   in Loop: Header=BB45_1 Depth=1
	movl	hufts(%rip), %eax
	movl	%eax, -12(%rbp)
.LBB45_5:                               # %do.cond
                                        #   in Loop: Header=BB45_1 Depth=1
	cmpl	$0, -24(%rbp)
	je	.LBB45_1
	jmp	.LBB45_6
	.p2align	4, 0x90
.LBB45_7:                               # %while.body
                                        #   in Loop: Header=BB45_6 Depth=1
	addl	$-8, bk(%rip)
	decl	inptr(%rip)
.LBB45_6:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$8, bk(%rip)
	jae	.LBB45_7
# BB#8:                                 # %while.end
	callq	flush_window
	movl	$0, -16(%rbp)
	jmp	.LBB45_9
.LBB45_2:                               # %if.then
	movl	-20(%rbp), %eax
	movl	%eax, -16(%rbp)
.LBB45_9:                               # %return
	movl	-16(%rbp), %eax
	addq	$24, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end45:
	.size	inflate, .Lfunc_end45-inflate
	.cfi_endproc

	.globl	ct_init
	.p2align	4, 0x90
	.type	ct_init,@function
ct_init:                                # @ct_init
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi149:
	.cfi_def_cfa_offset 16
.Lcfi150:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi151:
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, file_type(%rip)
	movq	-32(%rbp), %rax
	movq	%rax, file_method(%rip)
	movq	$0, input_len(%rip)
	movq	$0, compressed_len(%rip)
	cmpw	$0, static_dtree+2(%rip)
	jne	.LBB46_35
# BB#1:                                 # %if.end
	movl	$0, -16(%rbp)
	movl	$0, -8(%rbp)
	cmpl	$27, -8(%rbp)
	jle	.LBB46_3
	jmp	.LBB46_7
	.p2align	4, 0x90
.LBB46_6:                               # %for.inc14
                                        #   in Loop: Header=BB46_3 Depth=1
	incl	-8(%rbp)
	cmpl	$27, -8(%rbp)
	jg	.LBB46_7
.LBB46_3:                               # %for.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB46_4 Depth 2
	movl	-16(%rbp), %eax
	movslq	-8(%rbp), %rcx
	movl	%eax, base_length(,%rcx,4)
	movl	$0, -4(%rbp)
	jmp	.LBB46_4
	.p2align	4, 0x90
.LBB46_5:                               # %for.inc
                                        #   in Loop: Header=BB46_4 Depth=2
	movzbl	-8(%rbp), %eax
	movslq	-16(%rbp), %rcx
	leal	1(%rcx), %edx
	movl	%edx, -16(%rbp)
	movb	%al, length_code(%rcx)
	incl	-4(%rbp)
.LBB46_4:                               # %for.cond4
                                        #   Parent Loop BB46_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	-8(%rbp), %rax
	movzbl	extra_lbits(,%rax,4), %ecx
	movl	$1, %eax
	shll	%cl, %eax
	cmpl	%eax, -4(%rbp)
	jl	.LBB46_5
	jmp	.LBB46_6
.LBB46_7:                               # %for.end16
	movb	-8(%rbp), %al
	movslq	-16(%rbp), %rcx
	movb	%al, length_code-1(%rcx)
	movl	$0, -12(%rbp)
	movl	$0, -8(%rbp)
	cmpl	$15, -8(%rbp)
	jle	.LBB46_9
	jmp	.LBB46_13
	.p2align	4, 0x90
.LBB46_12:                              # %for.inc40
                                        #   in Loop: Header=BB46_9 Depth=1
	incl	-8(%rbp)
	cmpl	$15, -8(%rbp)
	jg	.LBB46_13
.LBB46_9:                               # %for.body23
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB46_10 Depth 2
	movl	-12(%rbp), %eax
	movslq	-8(%rbp), %rcx
	movl	%eax, base_dist(,%rcx,4)
	movl	$0, -4(%rbp)
	jmp	.LBB46_10
	.p2align	4, 0x90
.LBB46_11:                              # %for.inc37
                                        #   in Loop: Header=BB46_10 Depth=2
	movzbl	-8(%rbp), %eax
	movslq	-12(%rbp), %rcx
	leal	1(%rcx), %edx
	movl	%edx, -12(%rbp)
	movb	%al, dist_code(%rcx)
	incl	-4(%rbp)
.LBB46_10:                              # %for.cond26
                                        #   Parent Loop BB46_9 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	-8(%rbp), %rax
	movzbl	extra_dbits(,%rax,4), %ecx
	movl	$1, %eax
	shll	%cl, %eax
	cmpl	%eax, -4(%rbp)
	jl	.LBB46_11
	jmp	.LBB46_12
.LBB46_13:                              # %for.end42
	sarl	$7, -12(%rbp)
	cmpl	$29, -8(%rbp)
	jle	.LBB46_15
	jmp	.LBB46_19
	.p2align	4, 0x90
.LBB46_18:                              # %for.inc65
                                        #   in Loop: Header=BB46_15 Depth=1
	incl	-8(%rbp)
	cmpl	$29, -8(%rbp)
	jg	.LBB46_19
.LBB46_15:                              # %for.body46
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB46_16 Depth 2
	movl	-12(%rbp), %eax
	shll	$7, %eax
	movslq	-8(%rbp), %rcx
	movl	%eax, base_dist(,%rcx,4)
	movl	$0, -4(%rbp)
	jmp	.LBB46_16
	.p2align	4, 0x90
.LBB46_17:                              # %for.inc62
                                        #   in Loop: Header=BB46_16 Depth=2
	movzbl	-8(%rbp), %eax
	movslq	-12(%rbp), %rcx
	leal	1(%rcx), %edx
	movl	%edx, -12(%rbp)
	movb	%al, dist_code+256(%rcx)
	incl	-4(%rbp)
.LBB46_16:                              # %for.cond50
                                        #   Parent Loop BB46_15 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	-8(%rbp), %rax
	movl	extra_dbits(,%rax,4), %ecx
	addl	$-7, %ecx
	movl	$1, %eax
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shll	%cl, %eax
	cmpl	%eax, -4(%rbp)
	jl	.LBB46_17
	jmp	.LBB46_18
.LBB46_19:                              # %for.end67
	movl	$0, -20(%rbp)
	cmpl	$15, -20(%rbp)
	jg	.LBB46_22
	.p2align	4, 0x90
.LBB46_21:                              # %for.inc74
                                        # =>This Inner Loop Header: Depth=1
	movslq	-20(%rbp), %rax
	movw	$0, bl_count(%rax,%rax)
	incl	-20(%rbp)
	cmpl	$15, -20(%rbp)
	jle	.LBB46_21
.LBB46_22:                              # %for.end76
	movl	$0, -4(%rbp)
	cmpl	$143, -4(%rbp)
	jg	.LBB46_25
	.p2align	4, 0x90
.LBB46_24:                              # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movslq	-4(%rbp), %rax
	leal	1(%rax), %ecx
	movl	%ecx, -4(%rbp)
	movw	$8, static_ltree+2(,%rax,4)
	incw	bl_count+16(%rip)
	cmpl	$143, -4(%rbp)
	jle	.LBB46_24
	jmp	.LBB46_25
	.p2align	4, 0x90
.LBB46_26:                              # %while.body86
                                        #   in Loop: Header=BB46_25 Depth=1
	movslq	-4(%rbp), %rax
	leal	1(%rax), %ecx
	movl	%ecx, -4(%rbp)
	movw	$9, static_ltree+2(,%rax,4)
	incw	bl_count+18(%rip)
.LBB46_25:                              # %while.cond83
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$255, -4(%rbp)
	jle	.LBB46_26
	jmp	.LBB46_27
	.p2align	4, 0x90
.LBB46_28:                              # %while.body97
                                        #   in Loop: Header=BB46_27 Depth=1
	movslq	-4(%rbp), %rax
	leal	1(%rax), %ecx
	movl	%ecx, -4(%rbp)
	movw	$7, static_ltree+2(,%rax,4)
	incw	bl_count+14(%rip)
.LBB46_27:                              # %while.cond94
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$279, -4(%rbp)          # imm = 0x117
	jle	.LBB46_28
	jmp	.LBB46_29
	.p2align	4, 0x90
.LBB46_30:                              # %while.body108
                                        #   in Loop: Header=BB46_29 Depth=1
	movslq	-4(%rbp), %rax
	leal	1(%rax), %ecx
	movl	%ecx, -4(%rbp)
	movw	$8, static_ltree+2(,%rax,4)
	incw	bl_count+16(%rip)
.LBB46_29:                              # %while.cond105
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$287, -4(%rbp)          # imm = 0x11F
	jle	.LBB46_30
# BB#31:                                # %while.end115
	movl	$static_ltree, %edi
	movl	$287, %esi              # imm = 0x11F
	callq	gen_codes
	movl	$0, -4(%rbp)
	cmpl	$29, -4(%rbp)
	jg	.LBB46_34
	.p2align	4, 0x90
.LBB46_33:                              # %for.inc128
                                        # =>This Inner Loop Header: Depth=1
	movslq	-4(%rbp), %rax
	movw	$5, static_dtree+2(,%rax,4)
	movl	-4(%rbp), %edi
	movl	$5, %esi
	callq	bi_reverse
	movslq	-4(%rbp), %rcx
	movw	%ax, static_dtree(,%rcx,4)
	incl	-4(%rbp)
	cmpl	$29, -4(%rbp)
	jle	.LBB46_33
.LBB46_34:                              # %for.end130
	callq	init_block
.LBB46_35:                              # %return
	addq	$48, %rsp
	popq	%rbp
	retq
.Lfunc_end46:
	.size	ct_init, .Lfunc_end46-ct_init
	.cfi_endproc

	.p2align	4, 0x90
	.type	gen_codes,@function
gen_codes:                              # @gen_codes
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi152:
	.cfi_def_cfa_offset 16
.Lcfi153:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi154:
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -32(%rbp)
	movl	%esi, -20(%rbp)
	movw	$0, -2(%rbp)
	movl	$1, -12(%rbp)
	cmpl	$15, -12(%rbp)
	jg	.LBB47_3
	.p2align	4, 0x90
.LBB47_2:                               # %for.inc
                                        # =>This Inner Loop Header: Depth=1
	movzwl	-2(%rbp), %eax
	movslq	-12(%rbp), %rcx
	movzwl	bl_count-2(%rcx,%rcx), %ecx
	addl	%eax, %ecx
	addl	%ecx, %ecx
	movw	%cx, -2(%rbp)
	movslq	-12(%rbp), %rax
	movw	%cx, -64(%rbp,%rax,2)
	incl	-12(%rbp)
	cmpl	$15, -12(%rbp)
	jle	.LBB47_2
.LBB47_3:                               # %for.end
	movl	$0, -8(%rbp)
	jmp	.LBB47_4
	.p2align	4, 0x90
.LBB47_7:                               # %for.inc23
                                        #   in Loop: Header=BB47_4 Depth=1
	incl	-8(%rbp)
.LBB47_4:                               # %for.cond5
                                        # =>This Inner Loop Header: Depth=1
	movl	-8(%rbp), %eax
	cmpl	-20(%rbp), %eax
	jg	.LBB47_8
# BB#5:                                 # %for.body8
                                        #   in Loop: Header=BB47_4 Depth=1
	movq	-32(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	2(%rax,%rcx,4), %eax
	testl	%eax, %eax
	movl	%eax, -16(%rbp)
	je	.LBB47_7
# BB#6:                                 # %if.end
                                        #   in Loop: Header=BB47_4 Depth=1
	movslq	-16(%rbp), %rax
	movzwl	-64(%rbp,%rax,2), %edi
	leal	1(%rdi), %ecx
	movw	%cx, -64(%rbp,%rax,2)
	movl	-16(%rbp), %esi
                                        # kill: %EDI<def> %EDI<kill> %RDI<kill>
	callq	bi_reverse
	movq	-32(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movw	%ax, (%rcx,%rdx,4)
	jmp	.LBB47_7
.LBB47_8:                               # %for.end25
	addq	$64, %rsp
	popq	%rbp
	retq
.Lfunc_end47:
	.size	gen_codes, .Lfunc_end47-gen_codes
	.cfi_endproc

	.p2align	4, 0x90
	.type	init_block,@function
init_block:                             # @init_block
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi155:
	.cfi_def_cfa_offset 16
.Lcfi156:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi157:
	.cfi_def_cfa_register %rbp
	movl	$0, -4(%rbp)
	cmpl	$285, -4(%rbp)          # imm = 0x11D
	jg	.LBB48_3
	.p2align	4, 0x90
.LBB48_2:                               # %for.inc
                                        # =>This Inner Loop Header: Depth=1
	movslq	-4(%rbp), %rax
	movw	$0, dyn_ltree(,%rax,4)
	incl	-4(%rbp)
	cmpl	$285, -4(%rbp)          # imm = 0x11D
	jle	.LBB48_2
.LBB48_3:                               # %for.end
	movl	$0, -4(%rbp)
	cmpl	$29, -4(%rbp)
	jg	.LBB48_6
	.p2align	4, 0x90
.LBB48_5:                               # %for.inc8
                                        # =>This Inner Loop Header: Depth=1
	movslq	-4(%rbp), %rax
	movw	$0, dyn_dtree(,%rax,4)
	incl	-4(%rbp)
	cmpl	$29, -4(%rbp)
	jle	.LBB48_5
.LBB48_6:                               # %for.end10
	movl	$0, -4(%rbp)
	cmpl	$18, -4(%rbp)
	jg	.LBB48_9
	.p2align	4, 0x90
.LBB48_8:                               # %for.inc18
                                        # =>This Inner Loop Header: Depth=1
	movslq	-4(%rbp), %rax
	movw	$0, bl_tree(,%rax,4)
	incl	-4(%rbp)
	cmpl	$18, -4(%rbp)
	jle	.LBB48_8
.LBB48_9:                               # %for.end20
	movw	$1, dyn_ltree+1024(%rip)
	movq	$0, static_len(%rip)
	movq	$0, opt_len(%rip)
	movl	$0, last_flags(%rip)
	movl	$0, last_dist(%rip)
	movl	$0, last_lit(%rip)
	movb	$0, flags(%rip)
	movb	$1, flag_bit(%rip)
	popq	%rbp
	retq
.Lfunc_end48:
	.size	init_block, .Lfunc_end48-init_block
	.cfi_endproc

	.p2align	4, 0x90
	.type	set_file_type,@function
set_file_type:                          # @set_file_type
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
	movl	$0, -4(%rbp)
	movl	$0, -12(%rbp)
	movl	$0, -8(%rbp)
	cmpl	$6, -4(%rbp)
	jg	.LBB49_3
	.p2align	4, 0x90
.LBB49_2:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movslq	-4(%rbp), %rax
	leal	1(%rax), %ecx
	movl	%ecx, -4(%rbp)
	movzwl	dyn_ltree(,%rax,4), %eax
	addl	%eax, -8(%rbp)
	cmpl	$6, -4(%rbp)
	jle	.LBB49_2
	jmp	.LBB49_3
	.p2align	4, 0x90
.LBB49_4:                               # %while.body4
                                        #   in Loop: Header=BB49_3 Depth=1
	movslq	-4(%rbp), %rax
	leal	1(%rax), %ecx
	movl	%ecx, -4(%rbp)
	movzwl	dyn_ltree(,%rax,4), %eax
	addl	%eax, -12(%rbp)
.LBB49_3:                               # %while.cond1
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$127, -4(%rbp)
	jle	.LBB49_4
	jmp	.LBB49_5
	.p2align	4, 0x90
.LBB49_6:                               # %while.body16
                                        #   in Loop: Header=BB49_5 Depth=1
	movslq	-4(%rbp), %rax
	leal	1(%rax), %ecx
	movl	%ecx, -4(%rbp)
	movzwl	dyn_ltree(,%rax,4), %eax
	addl	%eax, -8(%rbp)
.LBB49_5:                               # %while.cond13
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$255, -4(%rbp)
	jle	.LBB49_6
# BB#7:                                 # %while.end24
	movl	-12(%rbp), %eax
	shrl	$2, %eax
	xorl	%ecx, %ecx
	cmpl	%eax, -8(%rbp)
	setbe	%cl
	movq	file_type(%rip), %rax
	movw	%cx, (%rax)
	movq	file_type(%rip), %rax
	cmpw	$0, (%rax)
	popq	%rbp
	retq
.Lfunc_end49:
	.size	set_file_type, .Lfunc_end49-set_file_type
	.cfi_endproc

	.p2align	4, 0x90
	.type	build_tree_1,@function
build_tree_1:                           # @build_tree_1
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi161:
	.cfi_def_cfa_offset 16
.Lcfi162:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi163:
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movq	%rdi, -48(%rbp)
	movq	(%rdi), %rax
	movq	%rax, -24(%rbp)
	movq	-48(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -64(%rbp)
	movq	-48(%rbp), %rax
	movl	28(%rax), %eax
	movl	%eax, -40(%rbp)
	movl	$-1, -8(%rbp)
	movl	-40(%rbp), %eax
	movl	%eax, -12(%rbp)
	movl	$0, heap_len(%rip)
	movl	$573, heap_max(%rip)    # imm = 0x23D
	movl	$0, -4(%rbp)
	jmp	.LBB50_1
	.p2align	4, 0x90
.LBB50_3:                               # %if.then
                                        #   in Loop: Header=BB50_1 Depth=1
	movl	-4(%rbp), %eax
	movl	%eax, -8(%rbp)
	movslq	heap_len(%rip), %rcx
	leaq	1(%rcx), %rdx
	movl	%edx, heap_len(%rip)
	movl	%eax, heap+4(,%rcx,4)
	movslq	-4(%rbp), %rax
	movb	$0, depth(%rax)
	incl	-4(%rbp)
.LBB50_1:                               # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jge	.LBB50_5
# BB#2:                                 # %for.body
                                        #   in Loop: Header=BB50_1 Depth=1
	movq	-24(%rbp), %rax
	movslq	-4(%rbp), %rcx
	cmpw	$0, (%rax,%rcx,4)
	jne	.LBB50_3
# BB#4:                                 # %if.else
                                        #   in Loop: Header=BB50_1 Depth=1
	movq	-24(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movw	$0, 2(%rax,%rcx,4)
	incl	-4(%rbp)
	jmp	.LBB50_1
	.p2align	4, 0x90
.LBB50_10:                              # %if.then25
                                        #   in Loop: Header=BB50_5 Depth=1
	movq	-64(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movzwl	2(%rax,%rcx,4), %eax
	subq	%rax, static_len(%rip)
.LBB50_5:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$1, heap_len(%rip)
	jg	.LBB50_11
# BB#6:                                 # %while.body
                                        #   in Loop: Header=BB50_5 Depth=1
	cmpl	$1, -8(%rbp)
	jg	.LBB50_8
# BB#7:                                 # %cond.true
                                        #   in Loop: Header=BB50_5 Depth=1
	movl	-8(%rbp), %eax
	incl	%eax
	movl	%eax, -52(%rbp)
	movl	%eax, -8(%rbp)
	movl	-52(%rbp), %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB50_9
	.p2align	4, 0x90
.LBB50_8:                               # %cond.false
                                        #   in Loop: Header=BB50_5 Depth=1
	movl	$0, -32(%rbp)
.LBB50_9:                               # %cond.end
                                        #   in Loop: Header=BB50_5 Depth=1
	movl	-32(%rbp), %eax
	movslq	heap_len(%rip), %rcx
	leaq	1(%rcx), %rdx
	movl	%edx, heap_len(%rip)
	movl	%eax, heap+4(,%rcx,4)
	movl	%eax, -28(%rbp)
	movq	-24(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movw	$1, (%rax,%rcx,4)
	movslq	-28(%rbp), %rax
	movb	$0, depth(%rax)
	decq	opt_len(%rip)
	cmpq	$0, -64(%rbp)
	je	.LBB50_5
	jmp	.LBB50_10
.LBB50_11:                              # %while.end
	movl	-8(%rbp), %eax
	movq	-48(%rbp), %rcx
	movl	%eax, 36(%rcx)
	movl	heap_len(%rip), %eax
	movl	%eax, %ecx
	shrl	$31, %ecx
	addl	%eax, %ecx
	sarl	%ecx
	movl	%ecx, -4(%rbp)
	cmpl	$0, -4(%rbp)
	jle	.LBB50_14
	.p2align	4, 0x90
.LBB50_13:                              # %for.inc37
                                        # =>This Inner Loop Header: Depth=1
	movq	-24(%rbp), %rdi
	movl	-4(%rbp), %esi
	callq	pqdownheap
	decl	-4(%rbp)
	cmpl	$0, -4(%rbp)
	jg	.LBB50_13
	.p2align	4, 0x90
.LBB50_14:                              # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movl	heap+4(%rip), %eax
	movl	%eax, -4(%rbp)
	movslq	heap_len(%rip), %rax
	leal	-1(%rax), %ecx
	movl	%ecx, heap_len(%rip)
	movl	heap(,%rax,4), %eax
	movl	%eax, heap+4(%rip)
	movq	-24(%rbp), %rdi
	movl	$1, %esi
	callq	pqdownheap
	movl	heap+4(%rip), %eax
	movl	%eax, -16(%rbp)
	movl	-4(%rbp), %eax
	movslq	heap_max(%rip), %rcx
	leaq	-1(%rcx), %rdx
	movl	%edx, heap_max(%rip)
	movl	%eax, heap-4(,%rcx,4)
	movl	-16(%rbp), %eax
	movslq	heap_max(%rip), %rcx
	leaq	-1(%rcx), %rdx
	movl	%edx, heap_max(%rip)
	movl	%eax, heap-4(,%rcx,4)
	movq	-24(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movzwl	(%rax,%rcx,4), %ecx
	movslq	-16(%rbp), %rdx
	movzwl	(%rax,%rdx,4), %edx
	addl	%ecx, %edx
	movslq	-12(%rbp), %rcx
	movw	%dx, (%rax,%rcx,4)
	movslq	-4(%rbp), %rax
	movzbl	depth(%rax), %eax
	movslq	-16(%rbp), %rcx
	movzbl	depth(%rcx), %ecx
	cmpl	%ecx, %eax
	jl	.LBB50_16
# BB#15:                                # %cond.true72
                                        #   in Loop: Header=BB50_14 Depth=1
	movslq	-4(%rbp), %rax
	movzbl	depth(%rax), %eax
	movl	%eax, -68(%rbp)
	jmp	.LBB50_17
	.p2align	4, 0x90
.LBB50_16:                              # %cond.false76
                                        #   in Loop: Header=BB50_14 Depth=1
	movslq	-16(%rbp), %rax
	movzbl	depth(%rax), %eax
	movl	%eax, -72(%rbp)
.LBB50_17:                              # %do.cond
                                        #   in Loop: Header=BB50_14 Depth=1
	movl	%eax, -36(%rbp)
	movl	-36(%rbp), %eax
	incl	%eax
	movslq	-12(%rbp), %rcx
	movb	%al, depth(%rcx)
	movzwl	-12(%rbp), %eax
	movq	-24(%rbp), %rcx
	movslq	-16(%rbp), %rdx
	movw	%ax, 2(%rcx,%rdx,4)
	movq	-24(%rbp), %rcx
	movslq	-4(%rbp), %rdx
	movw	%ax, 2(%rcx,%rdx,4)
	movl	-12(%rbp), %eax
	leal	1(%rax), %ecx
	movl	%ecx, -12(%rbp)
	movl	%eax, heap+4(%rip)
	movq	-24(%rbp), %rdi
	movl	$1, %esi
	callq	pqdownheap
	cmpl	$1, heap_len(%rip)
	jg	.LBB50_14
# BB#18:                                # %do.end
	movl	heap+4(%rip), %eax
	movslq	heap_max(%rip), %rcx
	leaq	-1(%rcx), %rdx
	movl	%edx, heap_max(%rip)
	movl	%eax, heap-4(,%rcx,4)
	movq	-48(%rbp), %rdi
	callq	gen_bitlen
	movq	-24(%rbp), %rdi
	movl	-8(%rbp), %esi
	callq	gen_codes
	addq	$80, %rsp
	popq	%rbp
	retq
.Lfunc_end50:
	.size	build_tree_1, .Lfunc_end50-build_tree_1
	.cfi_endproc

	.p2align	4, 0x90
	.type	build_bl_tree,@function
build_bl_tree:                          # @build_bl_tree
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi164:
	.cfi_def_cfa_offset 16
.Lcfi165:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi166:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	l_desc+36(%rip), %esi
	movl	$dyn_ltree, %edi
	callq	scan_tree
	movl	d_desc+36(%rip), %esi
	movl	$dyn_dtree, %edi
	callq	scan_tree
	movl	$bl_desc, %edi
	callq	build_tree_1
	movl	$18, -4(%rbp)
	cmpl	$3, -4(%rbp)
	jge	.LBB51_2
	jmp	.LBB51_4
	.p2align	4, 0x90
.LBB51_3:                               # %for.inc
                                        #   in Loop: Header=BB51_2 Depth=1
	decl	-4(%rbp)
	cmpl	$3, -4(%rbp)
	jl	.LBB51_4
.LBB51_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movslq	-4(%rbp), %rax
	movzbl	bl_order(%rax), %eax
	cmpw	$0, bl_tree+2(,%rax,4)
	je	.LBB51_3
.LBB51_4:                               # %for.end
	movslq	-4(%rbp), %rax
	leaq	(%rax,%rax,2), %rax
	movq	opt_len(%rip), %rcx
	leaq	17(%rcx,%rax), %rax
	movq	%rax, opt_len(%rip)
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end51:
	.size	build_bl_tree, .Lfunc_end51-build_bl_tree
	.cfi_endproc

	.p2align	4, 0x90
	.type	compress_block,@function
compress_block:                         # @compress_block
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi167:
	.cfi_def_cfa_offset 16
.Lcfi168:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi169:
	.cfi_def_cfa_register %rbp
	subq	$64, %rsp
	movq	%rdi, -48(%rbp)
	movq	%rsi, -56(%rbp)
	movl	$0, -12(%rbp)
	movl	$0, -36(%rbp)
	movl	$0, -32(%rbp)
	movb	$0, -1(%rbp)
	cmpl	$0, last_lit(%rip)
	je	.LBB52_14
	.p2align	4, 0x90
.LBB52_1:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	testb	$7, -12(%rbp)
	jne	.LBB52_3
# BB#2:                                 # %if.then2
                                        #   in Loop: Header=BB52_1 Depth=1
	movl	-32(%rbp), %eax
	leal	1(%rax), %ecx
	movl	%ecx, -32(%rbp)
	movzbl	flag_buf(%rax), %eax
	movb	%al, -1(%rbp)
.LBB52_3:                               # %if.end
                                        #   in Loop: Header=BB52_1 Depth=1
	movl	-12(%rbp), %eax
	leal	1(%rax), %ecx
	movl	%ecx, -12(%rbp)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -16(%rbp)
	movzbl	-1(%rbp), %eax
	testb	$1, %al
	jne	.LBB52_5
# BB#4:                                 # %if.then10
                                        #   in Loop: Header=BB52_1 Depth=1
	movq	-48(%rbp), %rax
	movslq	-16(%rbp), %rcx
	movzwl	(%rax,%rcx,4), %edi
	movzwl	2(%rax,%rcx,4), %esi
	jmp	.LBB52_12
	.p2align	4, 0x90
.LBB52_5:                               # %if.else
                                        #   in Loop: Header=BB52_1 Depth=1
	movslq	-16(%rbp), %rax
	movzbl	length_code(%rax), %eax
	movl	%eax, -8(%rbp)
	movq	-48(%rbp), %rcx
	addl	$257, %eax              # imm = 0x101
	movzwl	(%rcx,%rax,4), %edi
	movzwl	2(%rcx,%rax,4), %esi
	callq	send_bits
	movl	-8(%rbp), %eax
	movl	extra_lbits(,%rax,4), %eax
	movl	%eax, -24(%rbp)
	testl	%eax, %eax
	je	.LBB52_7
# BB#6:                                 # %if.then38
                                        #   in Loop: Header=BB52_1 Depth=1
	movl	-8(%rbp), %eax
	movl	-16(%rbp), %edi
	subl	base_length(,%rax,4), %edi
	movl	%edi, -16(%rbp)
	movl	-24(%rbp), %esi
	callq	send_bits
.LBB52_7:                               # %if.end41
                                        #   in Loop: Header=BB52_1 Depth=1
	movl	-36(%rbp), %eax
	leal	1(%rax), %ecx
	movl	%ecx, -36(%rbp)
	movzwl	d_buf(%rax,%rax), %eax
	cmpl	$255, %eax
	movl	%eax, -20(%rbp)
	ja	.LBB52_9
# BB#8:                                 # %cond.true
                                        #   in Loop: Header=BB52_1 Depth=1
	movl	-20(%rbp), %eax
	movzbl	dist_code(%rax), %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB52_10
	.p2align	4, 0x90
.LBB52_9:                               # %cond.false
                                        #   in Loop: Header=BB52_1 Depth=1
	movl	-20(%rbp), %eax
	shrl	$7, %eax
	addl	$256, %eax              # imm = 0x100
	movzbl	dist_code(%rax), %eax
	movl	%eax, -64(%rbp)
.LBB52_10:                              # %cond.end
                                        #   in Loop: Header=BB52_1 Depth=1
	movl	%eax, -28(%rbp)
	movl	-28(%rbp), %eax
	movl	%eax, -8(%rbp)
	movq	-56(%rbp), %rax
	movl	-8(%rbp), %ecx
	movzwl	(%rax,%rcx,4), %edi
	movzwl	2(%rax,%rcx,4), %esi
	callq	send_bits
	movl	-8(%rbp), %eax
	movl	extra_dbits(,%rax,4), %eax
	movl	%eax, -24(%rbp)
	testl	%eax, %eax
	je	.LBB52_13
# BB#11:                                # %if.then69
                                        #   in Loop: Header=BB52_1 Depth=1
	movl	-8(%rbp), %eax
	movl	-20(%rbp), %edi
	subl	base_dist(,%rax,4), %edi
	movl	%edi, -20(%rbp)
	movl	-24(%rbp), %esi
.LBB52_12:                              # %do.cond
                                        #   in Loop: Header=BB52_1 Depth=1
	callq	send_bits
.LBB52_13:                              # %do.cond
                                        #   in Loop: Header=BB52_1 Depth=1
	movzbl	-1(%rbp), %eax
	shrl	%eax
	movb	%al, -1(%rbp)
	movl	-12(%rbp), %eax
	cmpl	last_lit(%rip), %eax
	jb	.LBB52_1
.LBB52_14:                              # %if.end80
	movq	-48(%rbp), %rax
	movzwl	1024(%rax), %edi
	movzwl	1026(%rax), %esi
	callq	send_bits
	addq	$64, %rsp
	popq	%rbp
	retq
.Lfunc_end52:
	.size	compress_block, .Lfunc_end52-compress_block
	.cfi_endproc

	.p2align	4, 0x90
	.type	send_all_trees,@function
send_all_trees:                         # @send_all_trees
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi170:
	.cfi_def_cfa_offset 16
.Lcfi171:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi172:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -16(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -8(%rbp)
	movl	$-257, %edi             # imm = 0xFEFF
	addl	-16(%rbp), %edi
	movl	$5, %esi
	callq	send_bits
	movl	-12(%rbp), %edi
	decl	%edi
	movl	$5, %esi
	callq	send_bits
	movl	-8(%rbp), %edi
	addl	$-4, %edi
	movl	$4, %esi
	callq	send_bits
	movl	$0, -4(%rbp)
	jmp	.LBB53_1
	.p2align	4, 0x90
.LBB53_2:                               # %for.body
                                        #   in Loop: Header=BB53_1 Depth=1
	movslq	-4(%rbp), %rax
	movzbl	bl_order(%rax), %eax
	movzwl	bl_tree+2(,%rax,4), %edi
	movl	$3, %esi
	callq	send_bits
	incl	-4(%rbp)
.LBB53_1:                               # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jl	.LBB53_2
# BB#3:                                 # %for.end
	movl	-16(%rbp), %esi
	decl	%esi
	movl	$dyn_ltree, %edi
	callq	send_tree
	movl	-12(%rbp), %esi
	decl	%esi
	movl	$dyn_dtree, %edi
	callq	send_tree
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end53:
	.size	send_all_trees, .Lfunc_end53-send_all_trees
	.cfi_endproc

	.globl	unlzh
	.p2align	4, 0x90
	.type	unlzh,@function
unlzh:                                  # @unlzh
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi173:
	.cfi_def_cfa_offset 16
.Lcfi174:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi175:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -12(%rbp)
	movl	%esi, -8(%rbp)
	movl	-12(%rbp), %eax
	movl	%eax, ifd(%rip)
	movl	-8(%rbp), %eax
	movl	%eax, ofd(%rip)
	callq	decode_start
	cmpl	$0, done(%rip)
	je	.LBB54_2
	jmp	.LBB54_5
	.p2align	4, 0x90
.LBB54_4:                               # %if.then
                                        #   in Loop: Header=BB54_2 Depth=1
	movl	-8(%rbp), %edi
	movl	-4(%rbp), %edx
	movl	$window, %esi
	callq	write_buf
.LBB54_1:                               # %while.cond
                                        #   in Loop: Header=BB54_2 Depth=1
	cmpl	$0, done(%rip)
	jne	.LBB54_5
.LBB54_2:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movl	$8192, %edi             # imm = 0x2000
	movl	$window, %esi
	callq	decode
	movl	%eax, -4(%rbp)
	cmpl	$0, test(%rip)
	jne	.LBB54_1
# BB#3:                                 # %land.lhs.true
                                        #   in Loop: Header=BB54_2 Depth=1
	cmpl	$0, -4(%rbp)
	je	.LBB54_1
	jmp	.LBB54_4
.LBB54_5:                               # %while.end
	xorl	%eax, %eax
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end54:
	.size	unlzh, .Lfunc_end54-unlzh
	.cfi_endproc

	.p2align	4, 0x90
	.type	decode_start,@function
decode_start:                           # @decode_start
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi176:
	.cfi_def_cfa_offset 16
.Lcfi177:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi178:
	.cfi_def_cfa_register %rbp
	callq	huf_decode_start
	movl	$0, j(%rip)
	movl	$0, done(%rip)
	popq	%rbp
	retq
.Lfunc_end55:
	.size	decode_start, .Lfunc_end55-decode_start
	.cfi_endproc

	.p2align	4, 0x90
	.type	decode,@function
decode:                                 # @decode
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
	pushq	%r14
	pushq	%rbx
	subq	$32, %rsp
.Lcfi182:
	.cfi_offset %rbx, -32
.Lcfi183:
	.cfi_offset %r14, -24
	movl	%edi, -32(%rbp)
	movq	%rsi, -40(%rbp)
	movl	$0, -20(%rbp)
	.p2align	4, 0x90
.LBB56_1:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	decl	j(%rip)
	js	.LBB56_3
# BB#2:                                 # %while.body
                                        #   in Loop: Header=BB56_1 Depth=1
	movq	-40(%rbp), %rax
	movl	decode.i(%rip), %ecx
	movzbl	(%rax,%rcx), %ecx
	movl	-20(%rbp), %edx
	movb	%cl, (%rax,%rdx)
	movl	decode.i(%rip), %eax
	incl	%eax
	andl	$8191, %eax             # imm = 0x1FFF
	movl	%eax, decode.i(%rip)
	movl	-20(%rbp), %eax
	incl	%eax
	movl	%eax, -20(%rbp)
	cmpl	-32(%rbp), %eax
	jne	.LBB56_1
	jmp	.LBB56_11
.LBB56_3:                               # %while.end
	movl	$-253, %r14d
.LBB56_4:                               # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB56_9 Depth 2
	callq	decode_c
	movl	%eax, -28(%rbp)
	cmpl	$510, %eax              # imm = 0x1FE
	je	.LBB56_5
# BB#6:                                 # %if.end6
                                        #   in Loop: Header=BB56_4 Depth=1
	cmpl	$255, -28(%rbp)
	ja	.LBB56_8
# BB#7:                                 # %if.then8
                                        #   in Loop: Header=BB56_4 Depth=1
	movb	-28(%rbp), %al
	movq	-40(%rbp), %rcx
	movl	-20(%rbp), %edx
	movb	%al, (%rcx,%rdx)
	movl	-20(%rbp), %eax
	incl	%eax
	movl	%eax, -20(%rbp)
	cmpl	-32(%rbp), %eax
	jne	.LBB56_4
	jmp	.LBB56_11
	.p2align	4, 0x90
.LBB56_8:                               # %if.else
                                        #   in Loop: Header=BB56_4 Depth=1
	movl	-28(%rbp), %eax
	addl	%r14d, %eax
	movl	%eax, j(%rip)
	movl	-20(%rbp), %ebx
	callq	decode_p
	subl	%eax, %ebx
	decl	%ebx
	andl	$8191, %ebx             # imm = 0x1FFF
	movl	%ebx, decode.i(%rip)
	.p2align	4, 0x90
.LBB56_9:                               # %while.cond20
                                        #   Parent Loop BB56_4 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	decl	j(%rip)
	js	.LBB56_4
# BB#10:                                # %while.body24
                                        #   in Loop: Header=BB56_9 Depth=2
	movq	-40(%rbp), %rax
	movl	decode.i(%rip), %ecx
	movzbl	(%rax,%rcx), %ecx
	movl	-20(%rbp), %edx
	movb	%cl, (%rax,%rdx)
	movl	decode.i(%rip), %eax
	incl	%eax
	andl	$8191, %eax             # imm = 0x1FFF
	movl	%eax, decode.i(%rip)
	movl	-20(%rbp), %eax
	incl	%eax
	movl	%eax, -20(%rbp)
	cmpl	-32(%rbp), %eax
	jne	.LBB56_9
.LBB56_11:                              # %if.then34
	movl	-20(%rbp), %eax
	movl	%eax, -24(%rbp)
	movl	-24(%rbp), %eax
	addq	$32, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.LBB56_5:                               # %if.then5
	movl	$1, done(%rip)
	jmp	.LBB56_11
.Lfunc_end56:
	.size	decode, .Lfunc_end56-decode
	.cfi_endproc

	.globl	write_buf
	.p2align	4, 0x90
	.type	write_buf,@function
write_buf:                              # @write_buf
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi184:
	.cfi_def_cfa_offset 16
.Lcfi185:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi186:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	%edi, -12(%rbp)
	movq	%rsi, -24(%rbp)
	movl	%edx, -8(%rbp)
	jmp	.LBB57_1
	.p2align	4, 0x90
.LBB57_4:                               # %if.end
                                        #   in Loop: Header=BB57_1 Depth=1
	movl	-4(%rbp), %eax
	subl	%eax, -8(%rbp)
	movl	-4(%rbp), %eax
	addq	%rax, -24(%rbp)
.LBB57_1:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	-12(%rbp), %edi
	movq	-24(%rbp), %rsi
	movl	-8(%rbp), %edx
	callq	write
	movl	%eax, -4(%rbp)
	cmpl	-8(%rbp), %eax
	je	.LBB57_5
# BB#2:                                 # %while.body
                                        #   in Loop: Header=BB57_1 Depth=1
	cmpl	$-1, -4(%rbp)
	jne	.LBB57_4
# BB#3:                                 # %if.then
                                        #   in Loop: Header=BB57_1 Depth=1
	callq	write_error
	jmp	.LBB57_4
.LBB57_5:                               # %while.end
	addq	$32, %rsp
	popq	%rbp
	retq
.Lfunc_end57:
	.size	write_buf, .Lfunc_end57-write_buf
	.cfi_endproc

	.globl	unlzw
	.p2align	4, 0x90
	.type	unlzw,@function
unlzw:                                  # @unlzw
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
	pushq	%rbx
	subq	$184, %rsp
.Lcfi190:
	.cfi_offset %rbx, -24
	movl	%edi, -120(%rbp)
	movl	%esi, -72(%rbp)
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB58_2
# BB#1:                                 # %cond.true
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -156(%rbp)
	jmp	.LBB58_3
.LBB58_2:                               # %cond.false
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -160(%rbp)
.LBB58_3:                               # %cond.end
	movl	%eax, -92(%rbp)
	movl	-92(%rbp), %eax
	movl	%eax, maxbits(%rip)
	andl	$128, %eax
	movl	%eax, block_mode(%rip)
	testb	$96, maxbits(%rip)
	je	.LBB58_8
# BB#4:                                 # %if.then
	cmpl	$0, quiet(%rip)
	jne	.LBB58_6
# BB#5:                                 # %if.then4
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	maxbits(%rip), %r8d
	andl	$96, %r8d
	movl	$.L.str.54, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB58_6:                               # %if.end
	cmpl	$0, exit_code(%rip)
	jne	.LBB58_8
# BB#7:                                 # %if.then9
	movl	$2, exit_code(%rip)
.LBB58_8:                               # %if.end11
	movl	maxbits(%rip), %ecx
	andl	$31, %ecx
	movl	%ecx, maxbits(%rip)
	movl	$1, %eax
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shlq	%cl, %rax
	movq	%rax, -136(%rbp)
	cmpl	$17, maxbits(%rip)
	jl	.LBB58_10
# BB#9:                                 # %if.then15
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	maxbits(%rip), %r8d
	movl	$.L.str.55, %esi
	movl	$ifname, %ecx
	movl	$16, %r9d
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, exit_code(%rip)
	movl	$1, -100(%rbp)
	jmp	.LBB58_68
.LBB58_10:                              # %if.end17
	movl	insize(%rip), %eax
	movl	%eax, -44(%rbp)
	movl	$9, -16(%rbp)
	movq	$511, -112(%rbp)        # imm = 0x1FF
	movb	-16(%rbp), %cl
	movl	$1, %eax
	shll	%cl, %eax
	decl	%eax
	movl	%eax, -68(%rbp)
	movq	$-1, -88(%rbp)
	movl	$0, -60(%rbp)
	movl	$0, -12(%rbp)
	movl	inptr(%rip), %eax
	shll	$3, %eax
	movq	%rax, -56(%rbp)
	xorl	%eax, %eax
	cmpl	$0, block_mode(%rip)
	setne	%al
	orl	$256, %eax              # imm = 0x100
	movq	%rax, -80(%rbp)
	xorps	%xmm0, %xmm0
	movaps	%xmm0, prev+240(%rip)
	movaps	%xmm0, prev+224(%rip)
	movaps	%xmm0, prev+208(%rip)
	movaps	%xmm0, prev+192(%rip)
	movaps	%xmm0, prev+176(%rip)
	movaps	%xmm0, prev+160(%rip)
	movaps	%xmm0, prev+144(%rip)
	movaps	%xmm0, prev+128(%rip)
	movaps	%xmm0, prev+112(%rip)
	movaps	%xmm0, prev+96(%rip)
	movaps	%xmm0, prev+80(%rip)
	movaps	%xmm0, prev+64(%rip)
	movaps	%xmm0, prev+48(%rip)
	movaps	%xmm0, prev+32(%rip)
	movaps	%xmm0, prev+16(%rip)
	movaps	%xmm0, prev(%rip)
	movq	$255, -24(%rbp)
	cmpq	$0, -24(%rbp)
	js	.LBB58_13
	.p2align	4, 0x90
.LBB58_12:                              # %for.inc
                                        # =>This Inner Loop Header: Depth=1
	movq	-24(%rbp), %rax
	movb	%al, window(%rax)
	decq	-24(%rbp)
	cmpq	$0, -24(%rbp)
	jns	.LBB58_12
.LBB58_13:                              # %for.end
	movl	$.L.str.56, %ebx
	jmp	.LBB58_14
	.p2align	4, 0x90
.LBB58_63:                              # %do.cond230
                                        #   in Loop: Header=BB58_14 Depth=1
	cmpl	$0, -44(%rbp)
	jne	.LBB58_14
	jmp	.LBB58_64
	.p2align	4, 0x90
.LBB58_27:                              # %if.then73
                                        #   in Loop: Header=BB58_14 Depth=1
	movq	-56(%rbp), %rcx
	movl	-16(%rbp), %eax
	shll	$3, %eax
	movslq	%eax, %rsi
	leaq	-1(%rcx,%rsi), %rax
	cqto
	idivq	%rsi
	subq	%rdx, %rsi
	leaq	-1(%rcx,%rsi), %rax
	movq	%rax, -56(%rbp)
	movl	-16(%rbp), %eax
	incl	%eax
	movl	%eax, -16(%rbp)
	cmpl	maxbits(%rip), %eax
	jne	.LBB58_29
# BB#28:                                # %if.then89
                                        #   in Loop: Header=BB58_14 Depth=1
	movq	-136(%rbp), %rax
	jmp	.LBB58_30
	.p2align	4, 0x90
.LBB58_29:                              # %if.else
                                        #   in Loop: Header=BB58_14 Depth=1
	movb	-16(%rbp), %cl
	movl	$1, %eax
	shlq	%cl, %rax
	decq	%rax
.LBB58_30:                              # %if.end93
                                        #   in Loop: Header=BB58_14 Depth=1
	movq	%rax, -112(%rbp)
	jmp	.LBB58_31
.LBB58_38:                              # %if.then130
                                        #   in Loop: Header=BB58_14 Depth=1
	xorps	%xmm0, %xmm0
	movaps	%xmm0, prev+240(%rip)
	movaps	%xmm0, prev+224(%rip)
	movaps	%xmm0, prev+208(%rip)
	movaps	%xmm0, prev+192(%rip)
	movaps	%xmm0, prev+176(%rip)
	movaps	%xmm0, prev+160(%rip)
	movaps	%xmm0, prev+144(%rip)
	movaps	%xmm0, prev+128(%rip)
	movaps	%xmm0, prev+112(%rip)
	movaps	%xmm0, prev+96(%rip)
	movaps	%xmm0, prev+80(%rip)
	movaps	%xmm0, prev+64(%rip)
	movaps	%xmm0, prev+48(%rip)
	movaps	%xmm0, prev+32(%rip)
	movaps	%xmm0, prev+16(%rip)
	movaps	%xmm0, prev(%rip)
	movq	$256, -80(%rbp)         # imm = 0x100
	movq	-56(%rbp), %rcx
	movl	-16(%rbp), %eax
	shll	$3, %eax
	movslq	%eax, %rsi
	leaq	-1(%rcx,%rsi), %rax
	cqto
	idivq	%rsi
	subq	%rdx, %rsi
	leaq	-1(%rcx,%rsi), %rax
	movq	%rax, -56(%rbp)
	movl	$9, -16(%rbp)
	movq	$511, -112(%rbp)        # imm = 0x1FF
.LBB58_31:                              # %if.end93
                                        #   in Loop: Header=BB58_14 Depth=1
	movb	-16(%rbp), %cl
	movl	$1, %eax
	shll	%cl, %eax
	decl	%eax
	movl	%eax, -68(%rbp)
.LBB58_14:                              # %resetbuf
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB58_15 Depth 2
                                        #     Child Loop BB58_25 Depth 2
                                        #       Child Loop BB58_50 Depth 3
	movl	insize(%rip), %eax
	movq	-56(%rbp), %rcx
	shrq	$3, %rcx
	movl	%ecx, -116(%rbp)
	subl	%ecx, %eax
	movl	%eax, -96(%rbp)
	movl	$0, -64(%rbp)
	jmp	.LBB58_15
	.p2align	4, 0x90
.LBB58_16:                              # %for.inc38
                                        #   in Loop: Header=BB58_15 Depth=2
	movslq	-64(%rbp), %rax
	movslq	-116(%rbp), %rcx
	movzbl	inbuf(%rax,%rcx), %ecx
	movb	%cl, inbuf(%rax)
	incl	-64(%rbp)
.LBB58_15:                              # %for.cond30
                                        #   Parent Loop BB58_14 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-64(%rbp), %eax
	cmpl	-96(%rbp), %eax
	jl	.LBB58_16
# BB#17:                                # %for.end40
                                        #   in Loop: Header=BB58_14 Depth=1
	movl	-96(%rbp), %eax
	movl	%eax, insize(%rip)
	movq	$0, -56(%rbp)
	cmpl	$63, insize(%rip)
	ja	.LBB58_21
# BB#18:                                # %if.then43
                                        #   in Loop: Header=BB58_14 Depth=1
	movl	-120(%rbp), %edi
	movl	insize(%rip), %eax
	leaq	inbuf(%rax), %rsi
	movl	$32768, %edx            # imm = 0x8000
	callq	read
	movl	%eax, -44(%rbp)
	cmpl	$-1, %eax
	jne	.LBB58_20
# BB#19:                                # %if.then48
                                        #   in Loop: Header=BB58_14 Depth=1
	callq	read_error
.LBB58_20:                              # %if.end49
                                        #   in Loop: Header=BB58_14 Depth=1
	movl	-44(%rbp), %eax
	addl	%eax, insize(%rip)
	movslq	-44(%rbp), %rax
	addq	%rax, bytes_in(%rip)
.LBB58_21:                              # %if.end53
                                        #   in Loop: Header=BB58_14 Depth=1
	cmpl	$0, -44(%rbp)
	je	.LBB58_23
# BB#22:                                # %cond.true56
                                        #   in Loop: Header=BB58_14 Depth=1
	movl	insize(%rip), %ecx
	xorl	%edx, %edx
	movl	%ecx, %eax
	divl	-16(%rbp)
                                        # kill: %EDX<def> %EDX<kill> %RDX<def>
	subq	%rdx, %rcx
	shlq	$3, %rcx
	movq	%rcx, -168(%rbp)
	movq	%rcx, -128(%rbp)
	jmp	.LBB58_24
	.p2align	4, 0x90
.LBB58_23:                              # %cond.false61
                                        #   in Loop: Header=BB58_14 Depth=1
	movl	insize(%rip), %eax
	shlq	$3, %rax
	movslq	-16(%rbp), %rcx
	decq	%rcx
	subq	%rcx, %rax
	movq	%rax, -176(%rbp)
	movq	%rax, -128(%rbp)
.LBB58_24:                              # %cond.end67
                                        #   in Loop: Header=BB58_14 Depth=1
	movq	-128(%rbp), %rax
	movq	%rax, -144(%rbp)
	jmp	.LBB58_25
	.p2align	4, 0x90
.LBB58_59:                              # %if.else214
                                        #   in Loop: Header=BB58_25 Depth=2
	movslq	-12(%rbp), %rax
	leaq	outbuf(%rax), %rdi
	movq	-40(%rbp), %rsi
	movslq	-28(%rbp), %rdx
	callq	memcpy
	movl	-28(%rbp), %eax
	addl	%eax, -12(%rbp)
.LBB58_60:                              # %if.end219
                                        #   in Loop: Header=BB58_25 Depth=2
	movq	-80(%rbp), %rax
	movq	%rax, -24(%rbp)
	cmpq	-136(%rbp), %rax
	jge	.LBB58_62
# BB#61:                                # %if.then222
                                        #   in Loop: Header=BB58_25 Depth=2
	movzwl	-88(%rbp), %eax
	movq	-24(%rbp), %rcx
	movw	%ax, prev(%rcx,%rcx)
	movb	-60(%rbp), %al
	movq	-24(%rbp), %rcx
	movb	%al, window(%rcx)
	movq	-24(%rbp), %rax
	incq	%rax
	movq	%rax, -80(%rbp)
.LBB58_62:                              # %if.end228
                                        #   in Loop: Header=BB58_25 Depth=2
	movq	-152(%rbp), %rax
	movq	%rax, -88(%rbp)
.LBB58_25:                              # %while.cond
                                        #   Parent Loop BB58_14 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB58_50 Depth 3
	movq	-144(%rbp), %rax
	cmpq	-56(%rbp), %rax
	jle	.LBB58_63
# BB#26:                                # %while.body
                                        #   in Loop: Header=BB58_25 Depth=2
	movq	-80(%rbp), %rax
	cmpq	-112(%rbp), %rax
	jg	.LBB58_27
# BB#32:                                # %if.end96
                                        #   in Loop: Header=BB58_25 Depth=2
	movq	-56(%rbp), %rax
	sarq	$3, %rax
	leaq	inbuf(%rax), %rcx
	movq	%rcx, -184(%rbp)
	movzbl	inbuf(%rax), %ecx
	movzbl	inbuf+1(%rax), %edx
	shlq	$8, %rdx
	orq	%rcx, %rdx
	movzbl	inbuf+2(%rax), %eax
	shlq	$16, %rax
	orq	%rdx, %rax
	movb	-56(%rbp), %cl
	andb	$7, %cl
	shrq	%cl, %rax
	movl	-68(%rbp), %ecx
	andq	%rax, %rcx
	movq	%rcx, -24(%rbp)
	movslq	-16(%rbp), %rax
	addq	%rax, -56(%rbp)
	cmpq	$-1, -88(%rbp)
	je	.LBB58_33
# BB#36:                                # %if.end126
                                        #   in Loop: Header=BB58_25 Depth=2
	cmpq	$256, -24(%rbp)         # imm = 0x100
	jne	.LBB58_39
# BB#37:                                # %land.lhs.true
                                        #   in Loop: Header=BB58_25 Depth=2
	cmpl	$0, block_mode(%rip)
	jne	.LBB58_38
.LBB58_39:                              # %if.end145
                                        #   in Loop: Header=BB58_25 Depth=2
	movq	-24(%rbp), %rax
	movq	%rax, -152(%rbp)
	movq	$d_buf+65534, -40(%rbp)
	movq	-24(%rbp), %rax
	cmpq	-80(%rbp), %rax
	jl	.LBB58_47
# BB#40:                                # %if.then148
                                        #   in Loop: Header=BB58_25 Depth=2
	movq	-24(%rbp), %rax
	cmpq	-80(%rbp), %rax
	jle	.LBB58_45
# BB#41:                                # %if.then151
                                        #   in Loop: Header=BB58_25 Depth=2
	cmpl	$0, test(%rip)
	jne	.LBB58_44
# BB#42:                                # %land.lhs.true153
                                        #   in Loop: Header=BB58_25 Depth=2
	cmpl	$0, -12(%rbp)
	jle	.LBB58_44
# BB#43:                                # %if.then156
                                        #   in Loop: Header=BB58_25 Depth=2
	movl	-72(%rbp), %edi
	movl	-12(%rbp), %edx
	movl	$outbuf, %esi
	callq	write_buf
	movslq	-12(%rbp), %rax
	addq	%rax, bytes_out(%rip)
.LBB58_44:                              # %if.end159
                                        #   in Loop: Header=BB58_25 Depth=2
	cmpl	$0, to_stdout(%rip)
	movl	$.L.str.57, %edi
	cmovneq	%rbx, %rdi
	callq	error
.LBB58_45:                              # %if.end162
                                        #   in Loop: Header=BB58_25 Depth=2
	movb	-60(%rbp), %al
	movq	-40(%rbp), %rcx
	leaq	-1(%rcx), %rdx
	movq	%rdx, -40(%rbp)
	movb	%al, -1(%rcx)
	movq	-88(%rbp), %rax
	jmp	.LBB58_46
	.p2align	4, 0x90
.LBB58_33:                              # %if.then116
                                        #   in Loop: Header=BB58_25 Depth=2
	cmpq	$256, -24(%rbp)         # imm = 0x100
	jl	.LBB58_35
# BB#34:                                # %if.then119
                                        #   in Loop: Header=BB58_25 Depth=2
	movl	$.L.str.56, %edi
	callq	error
.LBB58_35:                              # %if.end120
                                        #   in Loop: Header=BB58_25 Depth=2
	movq	-24(%rbp), %rax
	movq	%rax, -88(%rbp)
	movl	%eax, -60(%rbp)
	movslq	-12(%rbp), %rcx
	leal	1(%rcx), %edx
	movl	%edx, -12(%rbp)
	movb	%al, outbuf(%rcx)
	jmp	.LBB58_25
	.p2align	4, 0x90
.LBB58_46:                              # %while.cond165
                                        #   in Loop: Header=BB58_25 Depth=2
	movq	%rax, -24(%rbp)
.LBB58_47:                              # %while.cond165
                                        #   in Loop: Header=BB58_25 Depth=2
	cmpq	$256, -24(%rbp)         # imm = 0x100
	jb	.LBB58_49
# BB#48:                                # %while.body168
                                        #   in Loop: Header=BB58_25 Depth=2
	movq	-24(%rbp), %rax
	movb	window(%rax), %al
	movq	-40(%rbp), %rcx
	leaq	-1(%rcx), %rdx
	movq	%rdx, -40(%rbp)
	movb	%al, -1(%rcx)
	movq	-24(%rbp), %rax
	movzwl	prev(%rax,%rax), %eax
	jmp	.LBB58_46
	.p2align	4, 0x90
.LBB58_49:                              # %while.end
                                        #   in Loop: Header=BB58_25 Depth=2
	movq	-24(%rbp), %rax
	movzbl	window(%rax), %eax
	movl	%eax, -60(%rbp)
	movq	-40(%rbp), %rcx
	leaq	-1(%rcx), %rdx
	movq	%rdx, -40(%rbp)
	movb	%al, -1(%rcx)
	movl	$d_buf+65534, %eax
	subl	-40(%rbp), %eax
	movl	-12(%rbp), %ecx
	addl	%eax, %ecx
	movl	%eax, -28(%rbp)
	cmpl	$16384, %ecx            # imm = 0x4000
	jl	.LBB58_59
	.p2align	4, 0x90
.LBB58_50:                              # %do.body183
                                        #   Parent Loop BB58_14 Depth=1
                                        #     Parent Loop BB58_25 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	$16384, %eax            # imm = 0x4000
	subl	-12(%rbp), %eax
	cmpl	%eax, -28(%rbp)
	jle	.LBB58_52
# BB#51:                                # %if.then187
                                        #   in Loop: Header=BB58_50 Depth=3
	movl	$16384, %eax            # imm = 0x4000
	subl	-12(%rbp), %eax
	movl	%eax, -28(%rbp)
.LBB58_52:                              # %if.end189
                                        #   in Loop: Header=BB58_50 Depth=3
	cmpl	$0, -28(%rbp)
	jle	.LBB58_54
# BB#53:                                # %if.then192
                                        #   in Loop: Header=BB58_50 Depth=3
	movslq	-12(%rbp), %rax
	leaq	outbuf(%rax), %rdi
	movq	-40(%rbp), %rsi
	movslq	-28(%rbp), %rdx
	callq	memcpy
	movl	-28(%rbp), %eax
	addl	%eax, -12(%rbp)
.LBB58_54:                              # %if.end197
                                        #   in Loop: Header=BB58_50 Depth=3
	cmpl	$16384, -12(%rbp)       # imm = 0x4000
	jl	.LBB58_58
# BB#55:                                # %if.then200
                                        #   in Loop: Header=BB58_50 Depth=3
	cmpl	$0, test(%rip)
	jne	.LBB58_57
# BB#56:                                # %if.then202
                                        #   in Loop: Header=BB58_50 Depth=3
	movl	-72(%rbp), %edi
	movl	-12(%rbp), %edx
	movl	$outbuf, %esi
	callq	write_buf
	movslq	-12(%rbp), %rax
	addq	%rax, bytes_out(%rip)
.LBB58_57:                              # %if.end205
                                        #   in Loop: Header=BB58_50 Depth=3
	movl	$0, -12(%rbp)
.LBB58_58:                              # %do.cond
                                        #   in Loop: Header=BB58_50 Depth=3
	movslq	-28(%rbp), %rax
	addq	%rax, -40(%rbp)
	movl	-40(%rbp), %eax
	movl	$d_buf+65534, %ecx
	subl	%eax, %ecx
	movl	%ecx, -28(%rbp)
	testl	%ecx, %ecx
	jg	.LBB58_50
	jmp	.LBB58_60
.LBB58_64:                              # %do.end233
	cmpl	$0, test(%rip)
	jne	.LBB58_67
# BB#65:                                # %land.lhs.true235
	cmpl	$0, -12(%rbp)
	jle	.LBB58_67
# BB#66:                                # %if.then238
	movl	-72(%rbp), %edi
	movl	-12(%rbp), %edx
	movl	$outbuf, %esi
	callq	write_buf
	movslq	-12(%rbp), %rax
	addq	%rax, bytes_out(%rip)
.LBB58_67:                              # %if.end241
	movl	$0, -100(%rbp)
.LBB58_68:                              # %return
	movl	-100(%rbp), %eax
	addq	$184, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end58:
	.size	unlzw, .Lfunc_end58-unlzw
	.cfi_endproc

	.globl	read_error
	.p2align	4, 0x90
	.type	read_error,@function
read_error:                             # @read_error
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi191:
	.cfi_def_cfa_offset 16
.Lcfi192:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi193:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi194:
	.cfi_offset %rbx, -24
	callq	__errno_location
	movl	(%rax), %eax
	movl	%eax, -12(%rbp)
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.75, %esi
	xorl	%eax, %eax
	callq	fprintf
	cmpl	$0, -12(%rbp)
	je	.LBB59_2
# BB#1:                                 # %if.then
	movl	-12(%rbp), %ebx
	callq	__errno_location
	movl	%ebx, (%rax)
	movl	$ifname, %edi
	callq	perror
	jmp	.LBB59_3
.LBB59_2:                               # %if.else
	movq	stderr(%rip), %rdi
	movl	$.L.str.76, %esi
	movl	$ifname, %edx
	xorl	%eax, %eax
	callq	fprintf
.LBB59_3:                               # %if.end
	callq	abort_gzip
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end59:
	.size	read_error, .Lfunc_end59-read_error
	.cfi_endproc

	.globl	unpack
	.p2align	4, 0x90
	.type	unpack,@function
unpack:                                 # @unpack
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi195:
	.cfi_def_cfa_offset 16
.Lcfi196:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi197:
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movl	%edi, -44(%rbp)
	movl	%esi, -40(%rbp)
	movl	-44(%rbp), %eax
	movl	%eax, ifd(%rip)
	movl	-40(%rbp), %eax
	movl	%eax, ofd(%rip)
	callq	read_tree
	callq	build_tree
	movl	$0, valid(%rip)
	movq	$0, bitbuf(%rip)
	movb	peek_bits(%rip), %cl
	movl	$1, %eax
	shll	%cl, %eax
	decl	%eax
	movl	%eax, -20(%rbp)
	movslq	max_len(%rip), %rax
	movl	leaves(,%rax,4), %eax
	decl	%eax
	movl	%eax, -36(%rbp)
	jmp	.LBB60_1
.LBB60_16:                              # %if.end
                                        #   in Loop: Header=BB60_1 Depth=1
	movl	-8(%rbp), %eax
	cmpl	-36(%rbp), %eax
	jne	.LBB60_18
# BB#17:                                # %land.lhs.true
                                        #   in Loop: Header=BB60_1 Depth=1
	movl	-4(%rbp), %eax
	cmpl	max_len(%rip), %eax
	je	.LBB60_21
.LBB60_18:                              # %if.end55
                                        #   in Loop: Header=BB60_1 Depth=1
	movl	-8(%rbp), %eax
	movslq	-4(%rbp), %rcx
	addl	lit_base(,%rcx,4), %eax
	movb	literal(%rax), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, window(%rcx)
	cmpl	$32768, outcnt(%rip)    # imm = 0x8000
	jne	.LBB60_20
# BB#19:                                # %if.then66
                                        #   in Loop: Header=BB60_1 Depth=1
	callq	flush_window
.LBB60_20:                              # %if.end67
                                        #   in Loop: Header=BB60_1 Depth=1
	movl	-4(%rbp), %eax
	subl	%eax, valid(%rip)
	jmp	.LBB60_1
	.p2align	4, 0x90
.LBB60_5:                               # %cond.end
                                        #   in Loop: Header=BB60_1 Depth=1
	movl	%eax, -12(%rbp)
	movslq	-12(%rbp), %rax
	orq	-56(%rbp), %rax
	movq	%rax, bitbuf(%rip)
	addl	$8, valid(%rip)
.LBB60_1:                               # %while.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB60_9 Depth 2
                                        #       Child Loop BB60_10 Depth 3
	movl	valid(%rip), %eax
	cmpl	peek_bits(%rip), %eax
	jge	.LBB60_6
# BB#2:                                 # %while.body
                                        #   in Loop: Header=BB60_1 Depth=1
	movq	bitbuf(%rip), %rax
	shlq	$8, %rax
	movq	%rax, -56(%rbp)
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB60_4
# BB#3:                                 # %cond.true
                                        #   in Loop: Header=BB60_1 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -68(%rbp)
	jmp	.LBB60_5
	.p2align	4, 0x90
.LBB60_4:                               # %cond.false
                                        #   in Loop: Header=BB60_1 Depth=1
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -72(%rbp)
	jmp	.LBB60_5
.LBB60_6:                               # %while.end
                                        #   in Loop: Header=BB60_1 Depth=1
	movq	bitbuf(%rip), %rax
	movl	valid(%rip), %ecx
	subl	peek_bits(%rip), %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrq	%cl, %rax
	andl	-20(%rbp), %eax
	movl	%eax, -8(%rbp)
	movl	-8(%rbp), %eax
	movzbl	outbuf(%rax), %eax
	movl	%eax, -4(%rbp)
	testl	%eax, %eax
	jle	.LBB60_8
# BB#7:                                 # %if.then
                                        #   in Loop: Header=BB60_1 Depth=1
	movl	peek_bits(%rip), %ecx
	subl	-4(%rbp), %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, -8(%rbp)
	jmp	.LBB60_16
.LBB60_8:                               # %if.else
                                        #   in Loop: Header=BB60_1 Depth=1
	movl	-20(%rbp), %eax
	movq	%rax, -32(%rbp)
	movl	peek_bits(%rip), %eax
	movl	%eax, -4(%rbp)
	.p2align	4, 0x90
.LBB60_9:                               # %do.body
                                        #   Parent Loop BB60_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB60_10 Depth 3
	incl	-4(%rbp)
	movq	-32(%rbp), %rax
	leaq	1(%rax,%rax), %rax
	movq	%rax, -32(%rbp)
	jmp	.LBB60_10
	.p2align	4, 0x90
.LBB60_14:                              # %cond.end35
                                        #   in Loop: Header=BB60_10 Depth=3
	movl	%eax, -16(%rbp)
	movslq	-16(%rbp), %rax
	orq	-64(%rbp), %rax
	movq	%rax, bitbuf(%rip)
	addl	$8, valid(%rip)
.LBB60_10:                              # %while.cond21
                                        #   Parent Loop BB60_1 Depth=1
                                        #     Parent Loop BB60_9 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	valid(%rip), %eax
	cmpl	-4(%rbp), %eax
	jge	.LBB60_15
# BB#11:                                # %while.body24
                                        #   in Loop: Header=BB60_10 Depth=3
	movq	bitbuf(%rip), %rax
	shlq	$8, %rax
	movq	%rax, -64(%rbp)
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB60_13
# BB#12:                                # %cond.true28
                                        #   in Loop: Header=BB60_10 Depth=3
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -76(%rbp)
	jmp	.LBB60_14
	.p2align	4, 0x90
.LBB60_13:                              # %cond.false33
                                        #   in Loop: Header=BB60_10 Depth=3
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -80(%rbp)
	jmp	.LBB60_14
	.p2align	4, 0x90
.LBB60_15:                              # %do.cond
                                        #   in Loop: Header=BB60_9 Depth=2
	movq	bitbuf(%rip), %rax
	movl	valid(%rip), %ecx
	subl	-4(%rbp), %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrq	%cl, %rax
	andl	-32(%rbp), %eax
	movl	%eax, -8(%rbp)
	movslq	-4(%rbp), %rcx
	cmpl	parents(,%rcx,4), %eax
	jb	.LBB60_9
	jmp	.LBB60_16
.LBB60_21:                              # %for.end
	callq	flush_window
	movl	bytes_out(%rip), %eax
	cmpq	%rax, orig_len(%rip)
	je	.LBB60_23
# BB#22:                                # %if.then72
	movl	$.L.str.58, %edi
	callq	error
.LBB60_23:                              # %if.end73
	xorl	%eax, %eax
	addq	$80, %rsp
	popq	%rbp
	retq
.Lfunc_end60:
	.size	unpack, .Lfunc_end60-unpack
	.cfi_endproc

	.p2align	4, 0x90
	.type	read_tree,@function
read_tree:                              # @read_tree
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
	subq	$80, %rsp
	movq	$0, orig_len(%rip)
	movl	$1, -8(%rbp)
	cmpl	$4, -8(%rbp)
	jle	.LBB61_2
	jmp	.LBB61_6
	.p2align	4, 0x90
.LBB61_5:                               # %for.inc
                                        #   in Loop: Header=BB61_2 Depth=1
	movl	%eax, -16(%rbp)
	movslq	-16(%rbp), %rax
	orq	-40(%rbp), %rax
	movq	%rax, orig_len(%rip)
	incl	-8(%rbp)
	cmpl	$4, -8(%rbp)
	jg	.LBB61_6
.LBB61_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movq	orig_len(%rip), %rax
	shlq	$8, %rax
	movq	%rax, -40(%rbp)
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB61_4
# BB#3:                                 # %cond.true
                                        #   in Loop: Header=BB61_2 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -44(%rbp)
	jmp	.LBB61_5
	.p2align	4, 0x90
.LBB61_4:                               # %cond.false
                                        #   in Loop: Header=BB61_2 Depth=1
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -48(%rbp)
	jmp	.LBB61_5
.LBB61_6:                               # %for.end
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB61_8
# BB#7:                                 # %cond.true6
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -52(%rbp)
	jmp	.LBB61_9
.LBB61_8:                               # %cond.false11
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -56(%rbp)
.LBB61_9:                               # %cond.end13
	movl	%eax, -20(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, max_len(%rip)
	cmpl	$26, %eax
	jl	.LBB61_11
# BB#10:                                # %if.then
	movl	$.L.str.198, %edi
	callq	error
.LBB61_11:                              # %if.end
	movl	$0, -8(%rbp)
	movl	$1, -4(%rbp)
	jmp	.LBB61_12
	.p2align	4, 0x90
.LBB61_16:                              # %for.inc36
                                        #   in Loop: Header=BB61_12 Depth=1
	movl	%eax, -24(%rbp)
	movl	-24(%rbp), %eax
	movslq	-4(%rbp), %rcx
	movl	%eax, leaves(,%rcx,4)
	movslq	-4(%rbp), %rax
	movl	leaves(,%rax,4), %eax
	addl	%eax, -8(%rbp)
	incl	-4(%rbp)
.LBB61_12:                              # %for.cond17
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	max_len(%rip), %eax
	jg	.LBB61_17
# BB#13:                                # %for.body20
                                        #   in Loop: Header=BB61_12 Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB61_15
# BB#14:                                # %cond.true23
                                        #   in Loop: Header=BB61_12 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -60(%rbp)
	jmp	.LBB61_16
	.p2align	4, 0x90
.LBB61_15:                              # %cond.false28
                                        #   in Loop: Header=BB61_12 Depth=1
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -64(%rbp)
	jmp	.LBB61_16
.LBB61_17:                              # %for.end38
	cmpl	$257, -8(%rbp)          # imm = 0x101
	jl	.LBB61_19
# BB#18:                                # %if.then41
	movl	$.L.str.199, %edi
	callq	error
.LBB61_19:                              # %if.end42
	movslq	max_len(%rip), %rax
	incl	leaves(,%rax,4)
	movl	$0, -12(%rbp)
	movl	$1, -4(%rbp)
	jmp	.LBB61_20
	.p2align	4, 0x90
.LBB61_27:                              # %for.inc75
                                        #   in Loop: Header=BB61_20 Depth=1
	incl	-4(%rbp)
.LBB61_20:                              # %for.cond46
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB61_23 Depth 2
	movl	-4(%rbp), %eax
	cmpl	max_len(%rip), %eax
	jg	.LBB61_28
# BB#21:                                # %for.body49
                                        #   in Loop: Header=BB61_20 Depth=1
	movl	-12(%rbp), %eax
	movslq	-4(%rbp), %rcx
	movl	%eax, lit_base(,%rcx,4)
	movslq	-4(%rbp), %rax
	movl	leaves(,%rax,4), %eax
	movl	%eax, -8(%rbp)
	cmpl	$0, -8(%rbp)
	jg	.LBB61_23
	jmp	.LBB61_27
	.p2align	4, 0x90
.LBB61_26:                              # %for.inc73
                                        #   in Loop: Header=BB61_23 Depth=2
	movl	%eax, -28(%rbp)
	movzbl	-28(%rbp), %eax
	movslq	-12(%rbp), %rcx
	leal	1(%rcx), %edx
	movl	%edx, -12(%rbp)
	movb	%al, literal(%rcx)
	decl	-8(%rbp)
	cmpl	$0, -8(%rbp)
	jle	.LBB61_27
.LBB61_23:                              # %for.body57
                                        #   Parent Loop BB61_20 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB61_25
# BB#24:                                # %cond.true60
                                        #   in Loop: Header=BB61_23 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -68(%rbp)
	jmp	.LBB61_26
	.p2align	4, 0x90
.LBB61_25:                              # %cond.false65
                                        #   in Loop: Header=BB61_23 Depth=2
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -72(%rbp)
	jmp	.LBB61_26
.LBB61_28:                              # %for.end77
	movslq	max_len(%rip), %rax
	incl	leaves(,%rax,4)
	addq	$80, %rsp
	popq	%rbp
	retq
.Lfunc_end61:
	.size	read_tree, .Lfunc_end61-read_tree
	.cfi_endproc

	.p2align	4, 0x90
	.type	build_tree,@function
build_tree:                             # @build_tree
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi201:
	.cfi_def_cfa_offset 16
.Lcfi202:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi203:
	.cfi_def_cfa_register %rbp
	movl	$0, -8(%rbp)
	movl	max_len(%rip), %eax
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	jle	.LBB62_3
	.p2align	4, 0x90
.LBB62_2:                               # %for.inc
                                        # =>This Inner Loop Header: Depth=1
	movl	-8(%rbp), %eax
	sarl	%eax
	movl	%eax, -8(%rbp)
	movslq	-4(%rbp), %rcx
	movl	%eax, parents(,%rcx,4)
	movl	-8(%rbp), %eax
	movslq	-4(%rbp), %rcx
	subl	%eax, lit_base(,%rcx,4)
	movslq	-4(%rbp), %rax
	movl	leaves(,%rax,4), %eax
	addl	%eax, -8(%rbp)
	decl	-4(%rbp)
	cmpl	$0, -4(%rbp)
	jg	.LBB62_2
.LBB62_3:                               # %for.end
	cmpl	$12, max_len(%rip)
	jg	.LBB62_5
# BB#4:                                 # %cond.true
	movl	max_len(%rip), %eax
	movl	%eax, -28(%rbp)
	movl	%eax, -20(%rbp)
	jmp	.LBB62_6
.LBB62_5:                               # %cond.false
	movl	$12, -20(%rbp)
.LBB62_6:                               # %cond.end
	movl	-20(%rbp), %eax
	movl	%eax, peek_bits(%rip)
	movb	peek_bits(%rip), %cl
	movl	$1, %eax
	shll	%cl, %eax
	cltq
	leaq	outbuf(%rax), %rax
	movq	%rax, -16(%rbp)
	movl	$1, -4(%rbp)
	jmp	.LBB62_7
	.p2align	4, 0x90
.LBB62_11:                              # %for.inc16
                                        #   in Loop: Header=BB62_7 Depth=1
	incl	-4(%rbp)
.LBB62_7:                               # %for.cond8
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB62_9 Depth 2
	movl	-4(%rbp), %eax
	cmpl	peek_bits(%rip), %eax
	jg	.LBB62_12
# BB#8:                                 # %for.body10
                                        #   in Loop: Header=BB62_7 Depth=1
	movslq	-4(%rbp), %rax
	movl	leaves(,%rax,4), %edx
	movl	peek_bits(%rip), %ecx
	subl	%eax, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shll	%cl, %edx
	movl	%edx, -24(%rbp)
	jmp	.LBB62_9
	.p2align	4, 0x90
.LBB62_10:                              # %while.body
                                        #   in Loop: Header=BB62_9 Depth=2
	movzbl	-4(%rbp), %eax
	movq	-16(%rbp), %rcx
	leaq	-1(%rcx), %rdx
	movq	%rdx, -16(%rbp)
	movb	%al, -1(%rcx)
.LBB62_9:                               # %while.cond
                                        #   Parent Loop BB62_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-24(%rbp), %eax
	leal	-1(%rax), %ecx
	movl	%ecx, -24(%rbp)
	testl	%eax, %eax
	jne	.LBB62_10
	jmp	.LBB62_11
.LBB62_12:                              # %for.end17
	movl	$outbuf, %eax
	cmpq	%rax, -16(%rbp)
	jbe	.LBB62_15
	.p2align	4, 0x90
.LBB62_14:                              # %while.body21
                                        # =>This Inner Loop Header: Depth=1
	movq	-16(%rbp), %rcx
	leaq	-1(%rcx), %rdx
	movq	%rdx, -16(%rbp)
	movb	$0, -1(%rcx)
	cmpq	%rax, -16(%rbp)
	ja	.LBB62_14
.LBB62_15:                              # %while.end23
	popq	%rbp
	retq
.Lfunc_end62:
	.size	build_tree, .Lfunc_end62-build_tree
	.cfi_endproc

	.globl	check_zipfile
	.p2align	4, 0x90
	.type	check_zipfile,@function
check_zipfile:                          # @check_zipfile
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi204:
	.cfi_def_cfa_offset 16
.Lcfi205:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi206:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movl	inptr(%rip), %eax
	leaq	inbuf(%rax), %rax
	movq	%rax, -16(%rbp)
	movl	-20(%rbp), %eax
	movl	%eax, ifd(%rip)
	movq	-16(%rbp), %rax
	movzbl	26(%rax), %ecx
	movzbl	27(%rax), %edx
	shll	$8, %edx
	orl	%ecx, %edx
	movzbl	28(%rax), %ecx
	movzbl	29(%rax), %eax
	shll	$8, %eax
	orl	%ecx, %eax
	addl	%edx, %eax
	movl	inptr(%rip), %ecx
	leal	30(%rcx,%rax), %eax
	movl	%eax, inptr(%rip)
	cmpl	insize(%rip), %eax
	ja	.LBB63_2
# BB#1:                                 # %lor.lhs.false
	movq	-16(%rbp), %rax
	movzbl	(%rax), %ecx
	movzbl	1(%rax), %edx
	shll	$8, %edx
	orl	%ecx, %edx
	movzbl	2(%rax), %ecx
	movzbl	3(%rax), %eax
	shll	$8, %eax
	orl	%ecx, %eax
	shlq	$16, %rax
	orq	%rdx, %rax
	cmpq	$67324752, %rax         # imm = 0x4034B50
	je	.LBB63_4
.LBB63_2:                               # %if.then
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.59, %esi
.LBB63_3:                               # %return
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, exit_code(%rip)
	movl	$1, -4(%rbp)
.LBB63_10:                              # %return
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	retq
.LBB63_4:                               # %if.end
	movq	-16(%rbp), %rax
	movzbl	8(%rax), %eax
	testl	%eax, %eax
	movl	%eax, method(%rip)
	je	.LBB63_7
# BB#5:                                 # %land.lhs.true
	cmpl	$8, method(%rip)
	je	.LBB63_7
# BB#6:                                 # %if.then50
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.60, %esi
	jmp	.LBB63_3
.LBB63_7:                               # %if.end52
	movq	-16(%rbp), %rax
	movzbl	6(%rax), %eax
	andl	$1, %eax
	movl	%eax, decrypt(%rip)
	je	.LBB63_9
# BB#8:                                 # %if.then57
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.61, %esi
	jmp	.LBB63_3
.LBB63_9:                               # %if.end59
	movq	-16(%rbp), %rax
	movzbl	6(%rax), %eax
	andl	$8, %eax
	shrl	$3, %eax
	movl	%eax, ext_header(%rip)
	movl	$1, pkzip(%rip)
	movl	$0, -4(%rbp)
	jmp	.LBB63_10
.Lfunc_end63:
	.size	check_zipfile, .Lfunc_end63-check_zipfile
	.cfi_endproc

	.globl	unzip
	.p2align	4, 0x90
	.type	unzip,@function
unzip:                                  # @unzip
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi207:
	.cfi_def_cfa_offset 16
.Lcfi208:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi209:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$120, %rsp
.Lcfi210:
	.cfi_offset %rbx, -24
	movl	%edi, -92(%rbp)
	movl	%esi, -88(%rbp)
	movq	$0, -72(%rbp)
	movq	$0, -64(%rbp)
	movl	$0, -16(%rbp)
	movl	-92(%rbp), %eax
	movl	%eax, ifd(%rip)
	movl	-88(%rbp), %eax
	movl	%eax, ofd(%rip)
	xorl	%edi, %edi
	xorl	%esi, %esi
	callq	updcrc
	cmpl	$0, pkzip(%rip)
	je	.LBB64_3
# BB#1:                                 # %land.lhs.true
	cmpl	$0, ext_header(%rip)
	jne	.LBB64_3
# BB#2:                                 # %if.then
	movzbl	inbuf+14(%rip), %eax
	movzbl	inbuf+15(%rip), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	inbuf+16(%rip), %eax
	movzbl	inbuf+17(%rip), %edx
	shll	$8, %edx
	orl	%eax, %edx
	shlq	$16, %rdx
	orq	%rcx, %rdx
	movq	%rdx, -72(%rbp)
	movzbl	inbuf+22(%rip), %eax
	movzbl	inbuf+23(%rip), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	inbuf+24(%rip), %eax
	movzbl	inbuf+25(%rip), %edx
	shll	$8, %edx
	orl	%eax, %edx
	shlq	$16, %rdx
	orq	%rcx, %rdx
	movq	%rdx, -64(%rbp)
.LBB64_3:                               # %if.end
	cmpl	$8, method(%rip)
	jne	.LBB64_8
# BB#4:                                 # %if.then32
	callq	inflate
	movl	%eax, -84(%rbp)
	cmpl	$3, %eax
	jne	.LBB64_6
# BB#5:                                 # %if.then36
	movl	$.L.str.62, %edi
	jmp	.LBB64_20
.LBB64_8:                               # %if.else42
	cmpl	$0, pkzip(%rip)
	je	.LBB64_19
# BB#9:                                 # %land.lhs.true44
	cmpl	$0, method(%rip)
	je	.LBB64_10
.LBB64_19:                              # %if.else118
	movl	$.L.str.66, %edi
	jmp	.LBB64_20
.LBB64_6:                               # %if.else
	cmpl	$0, -84(%rbp)
	je	.LBB64_21
# BB#7:                                 # %if.then39
	movl	$.L.str.63, %edi
.LBB64_20:                              # %if.end120
	callq	error
.LBB64_21:                              # %if.end120
	cmpl	$0, pkzip(%rip)
	je	.LBB64_22
.LBB64_29:                              # %if.else192
	cmpl	$0, ext_header(%rip)
	je	.LBB64_38
# BB#30:                                # %if.then194
	movl	$0, -12(%rbp)
	cmpl	$15, -12(%rbp)
	jle	.LBB64_32
	jmp	.LBB64_36
	.p2align	4, 0x90
.LBB64_35:                              # %for.inc213
                                        #   in Loop: Header=BB64_32 Depth=1
	movl	%eax, -48(%rbp)
	movzbl	-48(%rbp), %eax
	movslq	-12(%rbp), %rcx
	movb	%al, -32(%rbp,%rcx)
	incl	-12(%rbp)
	cmpl	$15, -12(%rbp)
	jg	.LBB64_36
.LBB64_32:                              # %for.body198
                                        # =>This Inner Loop Header: Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB64_34
# BB#33:                                # %cond.true201
                                        #   in Loop: Header=BB64_32 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -112(%rbp)
	jmp	.LBB64_35
	.p2align	4, 0x90
.LBB64_34:                              # %cond.false206
                                        #   in Loop: Header=BB64_32 Depth=1
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -116(%rbp)
	jmp	.LBB64_35
.LBB64_36:                              # %for.end215
	movzbl	-28(%rbp), %eax
	movzbl	-27(%rbp), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	-26(%rbp), %eax
	movzbl	-25(%rbp), %edx
	shll	$8, %edx
	orl	%eax, %edx
	shlq	$16, %rdx
	orq	%rcx, %rdx
	movq	%rdx, -72(%rbp)
	movzbl	-20(%rbp), %eax
	movzbl	-19(%rbp), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	-18(%rbp), %eax
	movzbl	-17(%rbp), %edx
	jmp	.LBB64_37
.LBB64_10:                              # %if.then47
	movzbl	inbuf+22(%rip), %eax
	movzbl	inbuf+23(%rip), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	inbuf+24(%rip), %edx
	movzbl	inbuf+25(%rip), %eax
	shll	$8, %eax
	orl	%edx, %eax
	shlq	$16, %rax
	orq	%rcx, %rax
	movq	%rax, -80(%rbp)
	movzbl	inbuf+18(%rip), %ecx
	movzbl	inbuf+19(%rip), %edx
	shll	$8, %edx
	orl	%ecx, %edx
	movzbl	inbuf+20(%rip), %ecx
	movzbl	inbuf+21(%rip), %esi
	shll	$8, %esi
	orl	%ecx, %esi
	shlq	$16, %rsi
	orq	%rdx, %rsi
	movl	decrypt(%rip), %ecx
	testl	%ecx, %ecx
	movl	$12, %edx
	cmovel	%ecx, %edx
	subq	%rdx, %rsi
	cmpq	%rsi, %rax
	je	.LBB64_12
# BB#11:                                # %if.then85
	movq	stderr(%rip), %rdi
	movq	-80(%rbp), %rdx
	movzbl	inbuf+18(%rip), %eax
	movzbl	inbuf+19(%rip), %esi
	shll	$8, %esi
	orl	%eax, %esi
	movzbl	inbuf+20(%rip), %eax
	movzbl	inbuf+21(%rip), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	shlq	$16, %rcx
	orq	%rsi, %rcx
	movl	$.L.str.64, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	$.L.str.65, %edi
	callq	error
	jmp	.LBB64_12
	.p2align	4, 0x90
.LBB64_17:                              # %if.then116
                                        #   in Loop: Header=BB64_12 Depth=1
	callq	flush_window
.LBB64_12:                              # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	-80(%rbp), %rax
	leaq	-1(%rax), %rcx
	movq	%rcx, -80(%rbp)
	testq	%rax, %rax
	je	.LBB64_18
# BB#13:                                # %while.body
                                        #   in Loop: Header=BB64_12 Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB64_15
# BB#14:                                # %cond.true
                                        #   in Loop: Header=BB64_12 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -96(%rbp)
	jmp	.LBB64_16
	.p2align	4, 0x90
.LBB64_15:                              # %cond.false
                                        #   in Loop: Header=BB64_12 Depth=1
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -100(%rbp)
.LBB64_16:                              # %cond.end
                                        #   in Loop: Header=BB64_12 Depth=1
	movl	%eax, -40(%rbp)
	movzbl	-40(%rbp), %eax
	movb	%al, -33(%rbp)
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, window(%rcx)
	cmpl	$32768, outcnt(%rip)    # imm = 0x8000
	jne	.LBB64_12
	jmp	.LBB64_17
.LBB64_18:                              # %while.end
	callq	flush_window
	cmpl	$0, pkzip(%rip)
	jne	.LBB64_29
.LBB64_22:                              # %if.then122
	movl	$0, -12(%rbp)
	cmpl	$7, -12(%rbp)
	jle	.LBB64_24
	jmp	.LBB64_28
	.p2align	4, 0x90
.LBB64_27:                              # %for.inc
                                        #   in Loop: Header=BB64_24 Depth=1
	movl	%eax, -44(%rbp)
	movzbl	-44(%rbp), %eax
	movslq	-12(%rbp), %rcx
	movb	%al, -32(%rbp,%rcx)
	incl	-12(%rbp)
	cmpl	$7, -12(%rbp)
	jg	.LBB64_28
.LBB64_24:                              # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB64_26
# BB#25:                                # %cond.true127
                                        #   in Loop: Header=BB64_24 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -104(%rbp)
	jmp	.LBB64_27
	.p2align	4, 0x90
.LBB64_26:                              # %cond.false132
                                        #   in Loop: Header=BB64_24 Depth=1
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -108(%rbp)
	jmp	.LBB64_27
.LBB64_28:                              # %for.end
	movzbl	-32(%rbp), %eax
	movzbl	-31(%rbp), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	-30(%rbp), %eax
	movzbl	-29(%rbp), %edx
	shll	$8, %edx
	orl	%eax, %edx
	shlq	$16, %rdx
	orq	%rcx, %rdx
	movq	%rdx, -72(%rbp)
	movzbl	-28(%rbp), %eax
	movzbl	-27(%rbp), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	-26(%rbp), %eax
	movzbl	-25(%rbp), %edx
.LBB64_37:                              # %if.end277
	shll	$8, %edx
	orl	%eax, %edx
	shlq	$16, %rdx
	orq	%rcx, %rdx
	movq	%rdx, -64(%rbp)
.LBB64_38:                              # %if.end277
	movq	-72(%rbp), %rbx
	movl	$outbuf, %edi
	xorl	%esi, %esi
	callq	updcrc
	cmpq	%rax, %rbx
	je	.LBB64_40
# BB#39:                                # %if.then281
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.67, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, -16(%rbp)
.LBB64_40:                              # %if.end283
	movl	bytes_out(%rip), %eax
	cmpq	%rax, -64(%rbp)
	je	.LBB64_42
# BB#41:                                # %if.then286
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.68, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, -16(%rbp)
.LBB64_42:                              # %if.end288
	cmpl	$0, pkzip(%rip)
	je	.LBB64_51
# BB#43:                                # %land.lhs.true290
	movl	inptr(%rip), %eax
	addl	$4, %eax
	cmpl	insize(%rip), %eax
	jae	.LBB64_51
# BB#44:                                # %land.lhs.true293
	movl	inptr(%rip), %eax
	movzbl	inbuf(%rax), %ecx
	movzbl	inbuf+1(%rax), %edx
	shll	$8, %edx
	orl	%ecx, %edx
	movzbl	inbuf+2(%rax), %ecx
	movzbl	inbuf+3(%rax), %eax
	shll	$8, %eax
	orl	%ecx, %eax
	shlq	$16, %rax
	orq	%rdx, %rax
	cmpq	$67324752, %rax         # imm = 0x4034B50
	jne	.LBB64_51
# BB#45:                                # %if.then325
	cmpl	$0, to_stdout(%rip)
	je	.LBB64_50
# BB#46:                                # %if.then327
	cmpl	$0, quiet(%rip)
	jne	.LBB64_48
# BB#47:                                # %if.then329
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.69, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB64_48:                              # %if.end331
	cmpl	$0, exit_code(%rip)
	jne	.LBB64_51
# BB#49:                                # %if.then334
	movl	$2, exit_code(%rip)
	jmp	.LBB64_51
.LBB64_50:                              # %if.else336
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.70, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, -16(%rbp)
.LBB64_51:                              # %if.end339
	movl	$0, pkzip(%rip)
	movl	$0, ext_header(%rip)
	cmpl	$0, -16(%rbp)
	je	.LBB64_52
# BB#53:                                # %if.end343
	movl	$1, exit_code(%rip)
	cmpl	$0, test(%rip)
	jne	.LBB64_55
# BB#54:                                # %if.then345
	callq	abort_gzip
.LBB64_55:                              # %if.end346
	movl	-16(%rbp), %eax
	movl	%eax, -52(%rbp)
	jmp	.LBB64_56
.LBB64_52:                              # %if.then342
	movl	$0, -52(%rbp)
.LBB64_56:                              # %return
	movl	-52(%rbp), %eax
	addq	$120, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end64:
	.size	unzip, .Lfunc_end64-unzip
	.cfi_endproc

	.globl	updcrc
	.p2align	4, 0x90
	.type	updcrc,@function
updcrc:                                 # @updcrc
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
	movl	$4294967295, %eax       # imm = 0xFFFFFFFF
	movq	%rdi, -24(%rbp)
	movl	%esi, -12(%rbp)
	cmpq	$0, -24(%rbp)
	je	.LBB65_1
# BB#2:                                 # %if.else
	movq	updcrc.crc(%rip), %rcx
	movq	%rcx, -8(%rbp)
	cmpl	$0, -12(%rbp)
	je	.LBB65_4
	.p2align	4, 0x90
.LBB65_3:                               # %do.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	-8(%rbp), %ecx
	movq	-24(%rbp), %rdx
	leaq	1(%rdx), %rsi
	movq	%rsi, -24(%rbp)
	movzbl	(%rdx), %edx
	xorl	%ecx, %edx
	movzbl	%dl, %ecx
	movq	-8(%rbp), %rdx
	shrq	$8, %rdx
	xorq	crc_32_tab(,%rcx,8), %rdx
	movq	%rdx, -8(%rbp)
	decl	-12(%rbp)
	jne	.LBB65_3
	jmp	.LBB65_4
.LBB65_1:                               # %if.then
	movq	%rax, -8(%rbp)
.LBB65_4:                               # %if.end5
	movq	-8(%rbp), %rcx
	movq	%rcx, updcrc.crc(%rip)
	xorq	-8(%rbp), %rax
	popq	%rbp
	retq
.Lfunc_end65:
	.size	updcrc, .Lfunc_end65-updcrc
	.cfi_endproc

	.globl	copy
	.p2align	4, 0x90
	.type	copy,@function
copy:                                   # @copy
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
	subq	$16, %rsp
	movl	%edi, -12(%rbp)
	movl	%esi, -8(%rbp)
	callq	__errno_location
	movl	$0, (%rax)
	cmpl	$0, insize(%rip)
	jne	.LBB66_3
	jmp	.LBB66_2
	.p2align	4, 0x90
.LBB66_5:                               # %while.body
	movl	-8(%rbp), %edi
	movl	insize(%rip), %edx
	movl	$inbuf, %esi
	callq	write_buf
	movl	insize(%rip), %eax
	addq	%rax, bytes_out(%rip)
	movl	-12(%rbp), %edi
	movl	$inbuf, %esi
	movl	$32768, %edx            # imm = 0x8000
	callq	read
	movl	%eax, insize(%rip)
	cmpl	$0, insize(%rip)
	je	.LBB66_2
.LBB66_3:                               # %land.rhs
	cmpl	$-1, insize(%rip)
	setne	-2(%rbp)
	setne	-1(%rbp)
	cmpb	$1, -1(%rbp)
	je	.LBB66_5
	jmp	.LBB66_6
	.p2align	4, 0x90
.LBB66_2:                               # %while.cond.land.end_crit_edge
	movb	$0, -1(%rbp)
	cmpb	$1, -1(%rbp)
	je	.LBB66_5
.LBB66_6:                               # %while.end
	cmpl	$-1, insize(%rip)
	jne	.LBB66_8
# BB#7:                                 # %if.then
	callq	read_error
.LBB66_8:                               # %if.end
	movq	bytes_out(%rip), %rax
	movq	%rax, bytes_in(%rip)
	xorl	%eax, %eax
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end66:
	.size	copy, .Lfunc_end66-copy
	.cfi_endproc

	.globl	clear_bufs
	.p2align	4, 0x90
	.type	clear_bufs,@function
clear_bufs:                             # @clear_bufs
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi217:
	.cfi_def_cfa_offset 16
.Lcfi218:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi219:
	.cfi_def_cfa_register %rbp
	movl	$0, outcnt(%rip)
	movl	$0, inptr(%rip)
	movl	$0, insize(%rip)
	movq	$0, bytes_out(%rip)
	movq	$0, bytes_in(%rip)
	popq	%rbp
	retq
.Lfunc_end67:
	.size	clear_bufs, .Lfunc_end67-clear_bufs
	.cfi_endproc

	.globl	write_error
	.p2align	4, 0x90
	.type	write_error,@function
write_error:                            # @write_error
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
	pushq	%rax
.Lcfi223:
	.cfi_offset %rbx, -24
	callq	__errno_location
	movl	(%rax), %eax
	movl	%eax, -12(%rbp)
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.75, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	-12(%rbp), %ebx
	callq	__errno_location
	movl	%ebx, (%rax)
	movl	$ofname, %edi
	callq	perror
	callq	abort_gzip
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end68:
	.size	write_error, .Lfunc_end68-write_error
	.cfi_endproc

	.globl	strlwr
	.p2align	4, 0x90
	.type	strlwr,@function
strlwr:                                 # @strlwr
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
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rdi, -8(%rbp)
	jmp	.LBB69_1
	.p2align	4, 0x90
.LBB69_5:                               # %for.inc
                                        #   in Loop: Header=BB69_1 Depth=1
	movl	%eax, -12(%rbp)
	movzbl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	movb	%al, (%rcx)
	incq	-8(%rbp)
.LBB69_1:                               # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	cmpb	$0, (%rax)
	je	.LBB69_6
# BB#2:                                 # %for.body
                                        #   in Loop: Header=BB69_1 Depth=1
	callq	__ctype_b_loc
	movq	(%rax), %rax
	movq	-8(%rbp), %rcx
	movzbl	(%rcx), %ecx
	movzwl	(%rax,%rcx,2), %eax
	testb	$1, %ah
	je	.LBB69_4
# BB#3:                                 # %cond.true
                                        #   in Loop: Header=BB69_1 Depth=1
	movq	-8(%rbp), %rax
	movzbl	(%rax), %edi
	callq	tolower
	movl	%eax, -28(%rbp)
	jmp	.LBB69_5
	.p2align	4, 0x90
.LBB69_4:                               # %cond.false
                                        #   in Loop: Header=BB69_1 Depth=1
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	movl	%eax, -32(%rbp)
	jmp	.LBB69_5
.LBB69_6:                               # %for.end
	movq	-24(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	retq
.Lfunc_end69:
	.size	strlwr, .Lfunc_end69-strlwr
	.cfi_endproc

	.globl	xunlink
	.p2align	4, 0x90
	.type	xunlink,@function
xunlink:                                # @xunlink
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
	subq	$16, %rsp
	movq	%rdi, -16(%rbp)
	callq	unlink
	movl	%eax, -4(%rbp)
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end70:
	.size	xunlink, .Lfunc_end70-xunlink
	.cfi_endproc

	.globl	make_simple_name
	.p2align	4, 0x90
	.type	make_simple_name,@function
make_simple_name:                       # @make_simple_name
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
	subq	$16, %rsp
	movq	%rdi, -16(%rbp)
	movl	$46, %esi
	callq	strrchr
	movq	%rax, -8(%rbp)
	testq	%rax, %rax
	je	.LBB71_6
# BB#1:                                 # %if.end
	movq	-8(%rbp), %rax
	cmpq	-16(%rbp), %rax
	jne	.LBB71_3
# BB#2:                                 # %if.then2
	incq	-8(%rbp)
	.p2align	4, 0x90
.LBB71_3:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rbp), %rax
	leaq	-1(%rax), %rcx
	movq	%rcx, -8(%rbp)
	cmpb	$46, -1(%rax)
	jne	.LBB71_5
# BB#4:                                 # %if.then7
                                        #   in Loop: Header=BB71_3 Depth=1
	movq	-8(%rbp), %rax
	movb	$95, (%rax)
.LBB71_5:                               # %do.cond
                                        #   in Loop: Header=BB71_3 Depth=1
	movq	-8(%rbp), %rax
	cmpq	-16(%rbp), %rax
	jne	.LBB71_3
.LBB71_6:                               # %do.end
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end71:
	.size	make_simple_name, .Lfunc_end71-make_simple_name
	.cfi_endproc

	.globl	xmalloc
	.p2align	4, 0x90
	.type	xmalloc,@function
xmalloc:                                # @xmalloc
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
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movl	-4(%rbp), %edi
	callq	malloc
	movq	%rax, -16(%rbp)
	testq	%rax, %rax
	jne	.LBB72_2
# BB#1:                                 # %if.then
	movl	$.L.str.62, %edi
	callq	error
.LBB72_2:                               # %if.end
	movq	-16(%rbp), %rax
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end72:
	.size	xmalloc, .Lfunc_end72-xmalloc
	.cfi_endproc

	.globl	warning
	.p2align	4, 0x90
	.type	warning,@function
warning:                                # @warning
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
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	cmpl	$0, quiet(%rip)
	jne	.LBB73_2
# BB#1:                                 # %if.then
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movq	-8(%rbp), %r8
	movl	$.L.str.74, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB73_2:                               # %if.end
	cmpl	$0, exit_code(%rip)
	jne	.LBB73_4
# BB#3:                                 # %if.then1
	movl	$2, exit_code(%rip)
.LBB73_4:                               # %if.end2
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end73:
	.size	warning, .Lfunc_end73-warning
	.cfi_endproc

	.section	.rodata.cst8,"aM",@progbits,8
	.p2align	3
.LCPI74_0:
	.quad	4636737291354636288     # double 100
	.text
	.globl	display_ratio
	.p2align	4, 0x90
	.type	display_ratio,@function
display_ratio:                          # @display_ratio
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
	subq	$48, %rsp
	movq	%rdi, -32(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -48(%rbp)
	movq	%rdx, -24(%rbp)
	cmpq	$0, -16(%rbp)
	je	.LBB74_1
# BB#2:                                 # %cond.false
	cvtsi2sdq	-32(%rbp), %xmm0
	mulsd	.LCPI74_0(%rip), %xmm0
	cvtsi2sdq	-16(%rbp), %xmm1
	divsd	%xmm1, %xmm0
	movsd	%xmm0, -40(%rbp)
	movsd	%xmm0, -8(%rbp)
	jmp	.LBB74_3
.LBB74_1:                               # %cond.true
	movq	$0, -8(%rbp)
.LBB74_3:                               # %cond.end
	movsd	-8(%rbp), %xmm0         # xmm0 = mem[0],zero
	movq	-24(%rbp), %rdi
	movl	$.L.str.77, %esi
	movb	$1, %al
	callq	fprintf
	addq	$48, %rsp
	popq	%rbp
	retq
.Lfunc_end74:
	.size	display_ratio, .Lfunc_end74-display_ratio
	.cfi_endproc

	.globl	fprint_off
	.p2align	4, 0x90
	.type	fprint_off,@function
fprint_off:                             # @fprint_off
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
	pushq	%rbx
	subq	$104, %rsp
.Lcfi245:
	.cfi_offset %rbx, -24
	movq	%rdi, -40(%rbp)
	movq	%rsi, -24(%rbp)
	movl	%edx, -28(%rbp)
	leaq	-48(%rbp), %rbx
	movq	%rbx, -16(%rbp)
	cmpq	$0, -24(%rbp)
	js	.LBB75_1
# BB#4:                                 # %if.else
	movabsq	$7378697629483820647, %rcx # imm = 0x6666666666666667
	.p2align	4, 0x90
.LBB75_5:                               # %do.cond8
                                        # =>This Inner Loop Header: Depth=1
	movq	-24(%rbp), %rsi
	movq	%rsi, %rax
	imulq	%rcx
	movq	%rdx, %rax
	shrq	$63, %rax
	shrq	$2, %rdx
	addl	%eax, %edx
	addl	%edx, %edx
	leal	(%rdx,%rdx,4), %eax
	subl	%eax, %esi
	addl	$48, %esi
	movq	-16(%rbp), %rax
	leaq	-1(%rax), %rdx
	movq	%rdx, -16(%rbp)
	movb	%sil, -1(%rax)
	movq	%rcx, %rax
	imulq	-24(%rbp)
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$2, %rdx
	addq	%rax, %rdx
	movq	%rdx, -24(%rbp)
	jne	.LBB75_5
	jmp	.LBB75_6
.LBB75_1:                               # %if.then
	movabsq	$7378697629483820647, %rcx # imm = 0x6666666666666667
	.p2align	4, 0x90
.LBB75_2:                               # %do.cond
                                        # =>This Inner Loop Header: Depth=1
	movq	-24(%rbp), %rsi
	movq	%rsi, %rax
	imulq	%rcx
	movq	%rdx, %rax
	shrq	$63, %rax
	shrq	$2, %rdx
	addl	%eax, %edx
	addl	%edx, %edx
	leal	(%rdx,%rdx,4), %eax
	subl	%eax, %esi
	movl	$48, %eax
	subl	%esi, %eax
	movq	-16(%rbp), %rdx
	leaq	-1(%rdx), %rsi
	movq	%rsi, -16(%rbp)
	movb	%al, -1(%rdx)
	movq	%rcx, %rax
	imulq	-24(%rbp)
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$2, %rdx
	addq	%rax, %rdx
	movq	%rdx, -24(%rbp)
	jne	.LBB75_2
# BB#3:                                 # %do.end
	movq	-16(%rbp), %rax
	leaq	-1(%rax), %rcx
	movq	%rcx, -16(%rbp)
	movb	$45, -1(%rax)
.LBB75_6:                               # %if.end
	leaq	-112(%rbp), %rax
	addl	$64, %eax
	subl	-16(%rbp), %eax
	subl	%eax, -28(%rbp)
	jmp	.LBB75_7
	.p2align	4, 0x90
.LBB75_8:                               # %while.body
                                        #   in Loop: Header=BB75_7 Depth=1
	movq	-40(%rbp), %rsi
	movl	$32, %edi
	callq	_IO_putc
.LBB75_7:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	leal	-1(%rax), %ecx
	movl	%ecx, -28(%rbp)
	testl	%eax, %eax
	jg	.LBB75_8
	jmp	.LBB75_9
	.p2align	4, 0x90
.LBB75_10:                              # %for.inc
                                        #   in Loop: Header=BB75_9 Depth=1
	movq	-16(%rbp), %rax
	movsbl	(%rax), %edi
	movq	-40(%rbp), %rsi
	callq	_IO_putc
	incq	-16(%rbp)
.LBB75_9:                               # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpq	%rbx, -16(%rbp)
	jb	.LBB75_10
# BB#11:                                # %for.end
	addq	$104, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end75:
	.size	fprint_off, .Lfunc_end75-fprint_off
	.cfi_endproc

	.globl	yesno
	.p2align	4, 0x90
	.type	yesno,@function
yesno:                                  # @yesno
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi246:
	.cfi_def_cfa_offset 16
.Lcfi247:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi248:
	.cfi_def_cfa_register %rbp
	subq	$144, %rsp
	movl	$0, -8(%rbp)
	jmp	.LBB76_1
	.p2align	4, 0x90
.LBB76_9:                               # %if.then
                                        #   in Loop: Header=BB76_1 Depth=1
	movzbl	-12(%rbp), %eax
	movslq	-8(%rbp), %rcx
	leal	1(%rcx), %edx
	movl	%edx, -8(%rbp)
	movb	%al, -144(%rbp,%rcx)
.LBB76_1:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	callq	getchar
	movl	%eax, -12(%rbp)
	cmpl	$-1, %eax
	je	.LBB76_2
# BB#3:                                 # %land.rhs
                                        #   in Loop: Header=BB76_1 Depth=1
	cmpl	$10, -12(%rbp)
	setne	-13(%rbp)
	setne	-1(%rbp)
	cmpb	$1, -1(%rbp)
	je	.LBB76_5
	jmp	.LBB76_10
	.p2align	4, 0x90
.LBB76_2:                               # %while.cond.land.end_crit_edge
                                        #   in Loop: Header=BB76_1 Depth=1
	movb	$0, -1(%rbp)
	cmpb	$1, -1(%rbp)
	jne	.LBB76_10
.LBB76_5:                               # %while.body
                                        #   in Loop: Header=BB76_1 Depth=1
	cmpl	$0, -8(%rbp)
	jle	.LBB76_7
# BB#6:                                 # %land.lhs.true
                                        #   in Loop: Header=BB76_1 Depth=1
	cmpl	$127, -8(%rbp)
	jl	.LBB76_9
.LBB76_7:                               # %lor.lhs.false
                                        #   in Loop: Header=BB76_1 Depth=1
	cmpl	$0, -8(%rbp)
	jne	.LBB76_1
# BB#8:                                 # %land.lhs.true5
                                        #   in Loop: Header=BB76_1 Depth=1
	callq	__ctype_b_loc
	movq	(%rax), %rax
	movslq	-12(%rbp), %rcx
	movzwl	(%rax,%rcx,2), %eax
	testb	$32, %ah
	jne	.LBB76_1
	jmp	.LBB76_9
.LBB76_10:                              # %while.end
	movslq	-8(%rbp), %rax
	movb	$0, -144(%rbp,%rax)
	leaq	-144(%rbp), %rdi
	callq	rpmatch
	xorl	%ecx, %ecx
	cmpl	$1, %eax
	sete	%cl
	movl	%ecx, %eax
	addq	$144, %rsp
	popq	%rbp
	retq
.Lfunc_end76:
	.size	yesno, .Lfunc_end76-yesno
	.cfi_endproc

	.globl	rpmatch
	.p2align	4, 0x90
	.type	rpmatch,@function
rpmatch:                                # @rpmatch
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi249:
	.cfi_def_cfa_offset 16
.Lcfi250:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi251:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	cmpb	$121, (%rdi)
	je	.LBB77_2
# BB#1:                                 # %lor.lhs.false
	movq	-16(%rbp), %rax
	cmpb	$89, (%rax)
	jne	.LBB77_3
.LBB77_2:                               # %cond.true
	movl	$1, -8(%rbp)
	jmp	.LBB77_7
.LBB77_3:                               # %cond.false
	movq	-16(%rbp), %rax
	cmpb	$110, (%rax)
	jne	.LBB77_5
# BB#4:                                 # %cond.false.lor.end_crit_edge
	movb	$1, -1(%rbp)
	jmp	.LBB77_6
.LBB77_5:                               # %lor.rhs
	movq	-16(%rbp), %rax
	cmpb	$78, (%rax)
	sete	-2(%rbp)
	sete	-1(%rbp)
.LBB77_6:                               # %lor.end
	movzbl	-1(%rbp), %eax
	decl	%eax
	movl	%eax, -20(%rbp)
	movl	%eax, -8(%rbp)
.LBB77_7:                               # %cond.end
	movl	-8(%rbp), %eax
	popq	%rbp
	retq
.Lfunc_end77:
	.size	rpmatch, .Lfunc_end77-rpmatch
	.cfi_endproc

	.globl	getopt_long_only
	.p2align	4, 0x90
	.type	getopt_long_only,@function
getopt_long_only:                       # @getopt_long_only
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
	subq	$48, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -16(%rbp)
	movq	%r8, -40(%rbp)
	movl	-4(%rbp), %edi
	movq	-32(%rbp), %rsi
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rcx
	movl	$1, %r9d
	callq	_getopt_internal
	addq	$48, %rsp
	popq	%rbp
	retq
.Lfunc_end78:
	.size	getopt_long_only, .Lfunc_end78-getopt_long_only
	.cfi_endproc

	.p2align	4, 0x90
	.type	progerror,@function
progerror:                              # @progerror
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi255:
	.cfi_def_cfa_offset 16
.Lcfi256:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi257:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$24, %rsp
.Lcfi258:
	.cfi_offset %rbx, -24
	movq	%rdi, -24(%rbp)
	callq	__errno_location
	movl	(%rax), %eax
	movl	%eax, -12(%rbp)
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.133, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	-12(%rbp), %ebx
	callq	__errno_location
	movl	%ebx, (%rax)
	movq	-24(%rbp), %rdi
	callq	perror
	movl	$1, exit_code(%rip)
	addq	$24, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end79:
	.size	progerror, .Lfunc_end79-progerror
	.cfi_endproc

	.p2align	4, 0x90
	.type	get_method,@function
get_method:                             # @get_method
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi259:
	.cfi_def_cfa_offset 16
.Lcfi260:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi261:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$312, %rsp              # imm = 0x138
.Lcfi262:
	.cfi_offset %rbx, -24
	movl	%edi, -140(%rbp)
	cmpl	$0, force(%rip)
	je	.LBB80_4
# BB#1:                                 # %land.lhs.true
	cmpl	$0, to_stdout(%rip)
	je	.LBB80_4
# BB#2:                                 # %if.then
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_11
# BB#3:                                 # %cond.true
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -144(%rbp)
	jmp	.LBB80_12
.LBB80_4:                               # %if.else
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_6
# BB#5:                                 # %cond.true19
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -160(%rbp)
	jmp	.LBB80_7
.LBB80_6:                               # %cond.false24
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -164(%rbp)
.LBB80_7:                               # %cond.end26
	movl	%eax, -52(%rbp)
	movb	-52(%rbp), %al
	movb	%al, -11(%rbp)
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_9
# BB#8:                                 # %cond.true32
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -168(%rbp)
	jmp	.LBB80_10
.LBB80_9:                               # %cond.false37
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -172(%rbp)
.LBB80_10:                              # %cond.end39
	movl	%eax, -56(%rbp)
	movb	-56(%rbp), %al
	movb	%al, -10(%rbp)
	movl	$0, -28(%rbp)
	jmp	.LBB80_16
.LBB80_11:                              # %cond.false
	movl	$1, %edi
	callq	fill_inbuf
	movl	%eax, -148(%rbp)
.LBB80_12:                              # %cond.end
	movl	%eax, -44(%rbp)
	movb	-44(%rbp), %al
	movb	%al, -11(%rbp)
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_14
# BB#13:                                # %cond.true6
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -152(%rbp)
	jmp	.LBB80_15
.LBB80_14:                              # %cond.false11
	movl	$1, %edi
	callq	fill_inbuf
	movl	%eax, -156(%rbp)
.LBB80_15:                              # %cond.end13
	movl	%eax, -48(%rbp)
	movl	-48(%rbp), %eax
	movl	%eax, -28(%rbp)
	movb	-28(%rbp), %al
	movb	%al, -10(%rbp)
.LBB80_16:                              # %if.end
	movl	$-1, method(%rip)
	incl	part_nb(%rip)
	movq	$0, header_bytes(%rip)
	movl	$0, last_member(%rip)
	movzwl	-11(%rbp), %eax
	cmpl	$35615, %eax            # imm = 0x8B1F
	je	.LBB80_28
# BB#17:                                # %lor.lhs.false
	movzwl	-11(%rbp), %eax
	cmpl	$40479, %eax            # imm = 0x9E1F
	je	.LBB80_28
# BB#18:                                # %if.else358
	movzwl	-11(%rbp), %eax
	cmpl	$19280, %eax            # imm = 0x4B50
	jne	.LBB80_21
# BB#19:                                # %land.lhs.true363
	cmpl	$2, inptr(%rip)
	jne	.LBB80_21
# BB#20:                                # %land.lhs.true366
	cmpl	$67324752, inbuf(%rip)  # imm = 0x4034B50
	je	.LBB80_74
.LBB80_21:                              # %if.else376
	movzwl	-11(%rbp), %eax
	cmpl	$7711, %eax             # imm = 0x1E1F
	je	.LBB80_41
# BB#22:                                # %if.else382
	movzwl	-11(%rbp), %eax
	cmpl	$40223, %eax            # imm = 0x9D1F
	je	.LBB80_45
# BB#23:                                # %if.else388
	movzwl	-11(%rbp), %eax
	cmpl	$40991, %eax            # imm = 0xA01F
	je	.LBB80_48
# BB#24:                                # %if.else394
	cmpl	$0, force(%rip)
	je	.LBB80_50
# BB#25:                                # %land.lhs.true396
	cmpl	$0, to_stdout(%rip)
	je	.LBB80_50
# BB#26:                                # %land.lhs.true398
	cmpl	$0, list(%rip)
	jne	.LBB80_50
# BB#27:                                # %if.then400
	movl	$0, method(%rip)
	movq	$copy, work(%rip)
	movl	$0, inptr(%rip)
	jmp	.LBB80_49
.LBB80_28:                              # %if.then51
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_30
# BB#29:                                # %cond.true54
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -176(%rbp)
	jmp	.LBB80_31
.LBB80_30:                              # %cond.false59
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -180(%rbp)
.LBB80_31:                              # %cond.end61
	movl	%eax, -60(%rbp)
	movl	-60(%rbp), %eax
	movl	%eax, method(%rip)
	cmpl	$8, %eax
	je	.LBB80_33
# BB#32:                                # %if.then65
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	method(%rip), %r8d
	movl	$.L.str.135, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB80_111
.LBB80_33:                              # %if.end67
	movq	$unzip, work(%rip)
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_35
# BB#34:                                # %cond.true70
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -184(%rbp)
	jmp	.LBB80_36
.LBB80_35:                              # %cond.false75
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -188(%rbp)
.LBB80_36:                              # %cond.end77
	movl	%eax, -64(%rbp)
	movb	-64(%rbp), %al
	movb	%al, -9(%rbp)
	movzbl	-9(%rbp), %eax
	testb	$32, %al
	je	.LBB80_38
# BB#37:                                # %if.then83
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.136, %esi
	jmp	.LBB80_110
.LBB80_38:                              # %if.end85
	movzbl	-9(%rbp), %eax
	testb	$2, %al
	je	.LBB80_42
# BB#39:                                # %if.then90
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.137, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, exit_code(%rip)
	cmpl	$1, force(%rip)
	jle	.LBB80_112
.LBB80_42:                              # %if.end96
	movzbl	-9(%rbp), %eax
	testb	$-64, %al
	je	.LBB80_46
# BB#43:                                # %if.then101
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movzbl	-9(%rbp), %r8d
	movl	$.L.str.138, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, exit_code(%rip)
	cmpl	$1, force(%rip)
	jle	.LBB80_112
.LBB80_46:                              # %if.end108
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_52
# BB#47:                                # %cond.true111
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -192(%rbp)
	jmp	.LBB80_53
.LBB80_41:                              # %if.then381
	movq	$unpack, work(%rip)
	movl	$2, method(%rip)
	cmpl	$0, method(%rip)
	jns	.LBB80_51
	jmp	.LBB80_108
.LBB80_45:                              # %if.then387
	movq	$unlzw, work(%rip)
	movl	$1, method(%rip)
	jmp	.LBB80_49
.LBB80_48:                              # %if.then393
	movq	$unlzh, work(%rip)
	movl	$3, method(%rip)
.LBB80_49:                              # %if.end406
	movl	$1, last_member(%rip)
.LBB80_50:                              # %if.end406
	cmpl	$0, method(%rip)
	js	.LBB80_108
.LBB80_51:                              # %if.then409
	movl	method(%rip), %eax
	movl	%eax, -16(%rbp)
	jmp	.LBB80_113
.LBB80_52:                              # %cond.false116
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -196(%rbp)
.LBB80_53:                              # %cond.end118
	movl	%eax, -68(%rbp)
	movslq	-68(%rbp), %rax
	movq	%rax, -40(%rbp)
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_55
# BB#54:                                # %cond.true123
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -200(%rbp)
	jmp	.LBB80_56
.LBB80_55:                              # %cond.false128
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -204(%rbp)
.LBB80_56:                              # %cond.end130
	movl	%eax, -72(%rbp)
	movslq	-72(%rbp), %rax
	shlq	$8, %rax
	orq	%rax, -40(%rbp)
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_58
# BB#57:                                # %cond.true135
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -208(%rbp)
	jmp	.LBB80_59
.LBB80_58:                              # %cond.false140
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -212(%rbp)
.LBB80_59:                              # %cond.end142
	movl	%eax, -76(%rbp)
	movslq	-76(%rbp), %rax
	shlq	$16, %rax
	orq	%rax, -40(%rbp)
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_61
# BB#60:                                # %cond.true149
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -216(%rbp)
	jmp	.LBB80_62
.LBB80_61:                              # %cond.false154
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -220(%rbp)
.LBB80_62:                              # %cond.end156
	movl	%eax, -80(%rbp)
	movslq	-80(%rbp), %rax
	shlq	$24, %rax
	orq	-40(%rbp), %rax
	movq	%rax, -40(%rbp)
	je	.LBB80_65
# BB#63:                                # %land.lhs.true163
	cmpl	$0, no_time(%rip)
	jne	.LBB80_65
# BB#64:                                # %if.then165
	movq	-40(%rbp), %rax
	movq	%rax, time_stamp(%rip)
.LBB80_65:                              # %if.end166
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_67
# BB#66:                                # %cond.true169
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -224(%rbp)
	jmp	.LBB80_68
.LBB80_67:                              # %cond.false174
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -228(%rbp)
.LBB80_68:                              # %cond.end176
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_70
# BB#69:                                # %cond.true180
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -232(%rbp)
	jmp	.LBB80_71
.LBB80_70:                              # %cond.false185
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -236(%rbp)
.LBB80_71:                              # %cond.end187
	movzbl	-9(%rbp), %eax
	testb	$2, %al
	je	.LBB80_82
# BB#72:                                # %if.then193
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_76
# BB#73:                                # %cond.true196
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -240(%rbp)
	jmp	.LBB80_77
.LBB80_74:                              # %if.then370
	movl	$0, inptr(%rip)
	movq	$unzip, work(%rip)
	movl	-140(%rbp), %edi
	callq	check_zipfile
	testl	%eax, %eax
	jne	.LBB80_112
	jmp	.LBB80_49
.LBB80_76:                              # %cond.false201
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -244(%rbp)
.LBB80_77:                              # %cond.end203
	movl	%eax, -84(%rbp)
	movl	-84(%rbp), %eax
	movl	%eax, -116(%rbp)
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_79
# BB#78:                                # %cond.true207
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -248(%rbp)
	jmp	.LBB80_80
.LBB80_79:                              # %cond.false212
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -252(%rbp)
.LBB80_80:                              # %cond.end214
	movl	%eax, -88(%rbp)
	movl	-88(%rbp), %eax
	shll	$8, %eax
	orl	%eax, -116(%rbp)
	cmpl	$0, verbose(%rip)
	je	.LBB80_82
# BB#81:                                # %if.then219
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	-116(%rbp), %r8d
	movl	$.L.str.139, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB80_82:                              # %if.end222
	movzbl	-9(%rbp), %eax
	testb	$4, %al
	je	.LBB80_95
# BB#83:                                # %if.then227
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_85
# BB#84:                                # %cond.true230
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -256(%rbp)
	jmp	.LBB80_86
.LBB80_85:                              # %cond.false235
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -260(%rbp)
.LBB80_86:                              # %cond.end237
	movl	%eax, -92(%rbp)
	movl	-92(%rbp), %eax
	movl	%eax, -20(%rbp)
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_88
# BB#87:                                # %cond.true241
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -264(%rbp)
	jmp	.LBB80_89
.LBB80_88:                              # %cond.false246
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -268(%rbp)
.LBB80_89:                              # %cond.end248
	movl	%eax, -96(%rbp)
	movl	-96(%rbp), %eax
	shll	$8, %eax
	orl	%eax, -20(%rbp)
	cmpl	$0, verbose(%rip)
	je	.LBB80_92
# BB#90:                                # %if.then253
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	-20(%rbp), %r8d
	movl	$.L.str.140, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB80_92
	.p2align	4, 0x90
.LBB80_91:                              # %cond.false264
                                        #   in Loop: Header=BB80_92 Depth=1
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -276(%rbp)
.LBB80_92:                              # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	-20(%rbp), %eax
	leal	-1(%rax), %ecx
	movl	%ecx, -20(%rbp)
	testl	%eax, %eax
	je	.LBB80_95
# BB#93:                                # %while.body
                                        #   in Loop: Header=BB80_92 Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_91
# BB#94:                                # %cond.true259
                                        #   in Loop: Header=BB80_92 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -272(%rbp)
	jmp	.LBB80_92
.LBB80_95:                              # %if.end268
	movzbl	-9(%rbp), %eax
	testb	$8, %al
	je	.LBB80_101
# BB#96:                                # %if.then273
	cmpl	$0, no_name(%rip)
	je	.LBB80_133
	.p2align	4, 0x90
.LBB80_97:                              # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_99
# BB#98:                                # %cond.true285
                                        #   in Loop: Header=BB80_97 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -280(%rbp)
	jmp	.LBB80_100
	.p2align	4, 0x90
.LBB80_99:                              # %cond.false290
                                        #   in Loop: Header=BB80_97 Depth=1
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -284(%rbp)
.LBB80_100:                             # %do.cond
                                        #   in Loop: Header=BB80_97 Depth=1
	movl	%eax, -100(%rbp)
	movzbl	-100(%rbp), %eax
	movb	%al, -29(%rbp)
	testb	%al, %al
	jne	.LBB80_97
.LBB80_101:                             # %if.end330
	movzbl	-9(%rbp), %eax
	testb	$16, %al
	je	.LBB80_106
	.p2align	4, 0x90
.LBB80_102:                             # %while.cond336
                                        # =>This Inner Loop Header: Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_104
# BB#103:                               # %cond.true339
                                        #   in Loop: Header=BB80_102 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -296(%rbp)
	jmp	.LBB80_105
	.p2align	4, 0x90
.LBB80_104:                             # %cond.false344
                                        #   in Loop: Header=BB80_102 Depth=1
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -300(%rbp)
.LBB80_105:                             # %cond.end346
                                        #   in Loop: Header=BB80_102 Depth=1
	movl	%eax, -108(%rbp)
	cmpl	$0, -108(%rbp)
	jne	.LBB80_102
.LBB80_106:                             # %if.end352
	cmpl	$1, part_nb(%rip)
	jne	.LBB80_50
# BB#107:                               # %if.then355
	movl	inptr(%rip), %eax
	addq	$16, %rax
	movq	%rax, header_bytes(%rip)
	cmpl	$0, method(%rip)
	jns	.LBB80_51
.LBB80_108:                             # %if.end410
	cmpl	$1, part_nb(%rip)
	jne	.LBB80_114
# BB#109:                               # %if.then413
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.146, %esi
.LBB80_110:                             # %return
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB80_111:                             # %return
	movl	$1, exit_code(%rip)
.LBB80_112:                             # %return
	movl	$-1, -16(%rbp)
.LBB80_113:                             # %return
	movl	-16(%rbp), %eax
	addq	$312, %rsp              # imm = 0x138
	popq	%rbx
	popq	%rbp
	retq
.LBB80_114:                             # %if.else415
	cmpb	$0, -11(%rbp)
	jne	.LBB80_122
# BB#115:                               # %if.then420
	movl	-28(%rbp), %eax
	jmp	.LBB80_117
	.p2align	4, 0x90
.LBB80_116:                             # %cond.end433
                                        #   in Loop: Header=BB80_117 Depth=1
	movl	%eax, -112(%rbp)
	movl	-112(%rbp), %eax
.LBB80_117:                             # %for.cond421
                                        # =>This Inner Loop Header: Depth=1
	movl	%eax, -24(%rbp)
	cmpl	$0, -24(%rbp)
	jne	.LBB80_121
# BB#118:                               # %for.inc
                                        #   in Loop: Header=BB80_117 Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_120
# BB#119:                               # %cond.true426
                                        #   in Loop: Header=BB80_117 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -304(%rbp)
	jmp	.LBB80_116
	.p2align	4, 0x90
.LBB80_120:                             # %cond.false431
                                        #   in Loop: Header=BB80_117 Depth=1
	movl	$1, %edi
	callq	fill_inbuf
	movl	%eax, -308(%rbp)
	jmp	.LBB80_116
.LBB80_121:                             # %for.end435
	cmpl	$-1, -24(%rbp)
	je	.LBB80_127
.LBB80_122:                             # %if.end451
	cmpl	$0, quiet(%rip)
	jne	.LBB80_124
# BB#123:                               # %if.then453
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.148, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB80_124:                             # %if.end455
	cmpl	$0, exit_code(%rip)
	jne	.LBB80_126
# BB#125:                               # %if.then458
	movl	$2, exit_code(%rip)
.LBB80_126:                             # %if.end459
	movl	$-2, -16(%rbp)
	jmp	.LBB80_113
.LBB80_127:                             # %if.then438
	cmpl	$0, verbose(%rip)
	je	.LBB80_132
# BB#128:                               # %if.then440
	cmpl	$0, quiet(%rip)
	jne	.LBB80_130
# BB#129:                               # %if.then442
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.147, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB80_130:                             # %if.end444
	cmpl	$0, exit_code(%rip)
	jne	.LBB80_132
# BB#131:                               # %if.then447
	movl	$2, exit_code(%rip)
.LBB80_132:                             # %if.end449
	movl	$-3, -16(%rbp)
	jmp	.LBB80_113
.LBB80_133:                             # %lor.lhs.false275
	cmpl	$0, to_stdout(%rip)
	je	.LBB80_135
# BB#134:                               # %land.lhs.true277
	cmpl	$0, list(%rip)
	je	.LBB80_97
.LBB80_135:                             # %lor.lhs.false279
	cmpl	$2, part_nb(%rip)
	jge	.LBB80_97
# BB#136:                               # %if.else298
	movl	$ofname, %edi
	callq	base_name
	movq	%rax, -128(%rbp)
	movq	%rax, -136(%rbp)
	movl	$ofname+1024, %ebx
	jmp	.LBB80_138
.LBB80_137:                             # %if.then319
                                        #   in Loop: Header=BB80_138 Depth=1
	movl	$.L.str.141, %edi
	callq	error
.LBB80_138:                             # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_140
# BB#139:                               # %cond.true302
                                        #   in Loop: Header=BB80_138 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -288(%rbp)
	jmp	.LBB80_141
.LBB80_140:                             # %cond.false307
                                        #   in Loop: Header=BB80_138 Depth=1
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, -292(%rbp)
.LBB80_141:                             # %cond.end309
                                        #   in Loop: Header=BB80_138 Depth=1
	movl	%eax, -104(%rbp)
	movzbl	-104(%rbp), %eax
	movq	-128(%rbp), %rcx
	movb	%al, (%rcx)
	movq	-128(%rbp), %rax
	leaq	1(%rax), %rcx
	movq	%rcx, -128(%rbp)
	cmpb	$0, (%rax)
	je	.LBB80_143
# BB#142:                               # %if.end316
                                        #   in Loop: Header=BB80_138 Depth=1
	cmpq	%rbx, -128(%rbp)
	jb	.LBB80_138
	jmp	.LBB80_137
.LBB80_143:                             # %for.end
	movq	-136(%rbp), %rdi
	callq	base_name
	movq	%rax, -320(%rbp)
	movq	-136(%rbp), %rdi
	movq	%rax, %rsi
	callq	strcpy
	cmpl	$0, list(%rip)
	jne	.LBB80_101
# BB#144:                               # %if.then324
	cmpq	$0, -136(%rbp)
	je	.LBB80_101
# BB#145:                               # %if.then326
	movl	$0, list(%rip)
	jmp	.LBB80_101
.Lfunc_end80:
	.size	get_method, .Lfunc_end80-get_method
	.cfi_endproc

	.p2align	4, 0x90
	.type	input_eof,@function
input_eof:                              # @input_eof
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
	cmpl	$0, decompress(%rip)
	je	.LBB81_2
# BB#1:                                 # %lor.lhs.false
	cmpl	$0, last_member(%rip)
	je	.LBB81_4
.LBB81_2:                               # %if.then
	movl	$1, -4(%rbp)
.LBB81_3:                               # %return
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	retq
.LBB81_4:                               # %if.end
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jne	.LBB81_8
# BB#5:                                 # %if.then2
	cmpl	$32768, insize(%rip)    # imm = 0x8000
	jne	.LBB81_2
# BB#6:                                 # %lor.lhs.false4
	movl	$1, %edi
	callq	fill_inbuf
	cmpl	$-1, %eax
	je	.LBB81_2
# BB#7:                                 # %if.end7
	movl	$0, inptr(%rip)
.LBB81_8:                               # %if.end8
	movl	$0, -4(%rbp)
	jmp	.LBB81_3
.Lfunc_end81:
	.size	input_eof, .Lfunc_end81-input_eof
	.cfi_endproc

	.p2align	4, 0x90
	.type	get_istat,@function
get_istat:                              # @get_istat
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
	pushq	%rbx
	subq	$72, %rsp
.Lcfi269:
	.cfi_offset %rbx, -24
	movq	%rdi, -24(%rbp)
	movq	%rsi, -64(%rbp)
	movl	$0, -28(%rbp)
	movq	$get_istat.suffixes, -40(%rbp)
	movq	z_suffix(%rip), %rax
	movq	%rax, get_istat.suffixes(%rip)
	movq	-24(%rbp), %rdi
	callq	strlen
	cmpq	$1022, %rax             # imm = 0x3FE
	jbe	.LBB82_1
.LBB82_16:                              # %name_too_long
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movq	-24(%rbp), %rcx
	movl	$.L.str.160, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, exit_code(%rip)
	jmp	.LBB82_17
.LBB82_1:                               # %if.end
	movq	-24(%rbp), %rsi
	movl	$ifname, %edi
	callq	strcpy
	movq	-64(%rbp), %rsi
	movl	$ifname, %edi
	callq	do_stat
	testl	%eax, %eax
	je	.LBB82_2
# BB#3:                                 # %if.end5
	cmpl	$0, decompress(%rip)
	je	.LBB82_5
# BB#4:                                 # %lor.lhs.false
	callq	__errno_location
	cmpl	$2, (%rax)
	jne	.LBB82_5
# BB#6:                                 # %if.end9
	movl	$ifname, %edi
	callq	get_suffix
	movq	%rax, -48(%rbp)
	testq	%rax, %rax
	je	.LBB82_7
.LBB82_5:                               # %if.then8
	movl	$ifname, %edi
	callq	progerror
.LBB82_17:                              # %return
	movl	$1, -12(%rbp)
.LBB82_18:                              # %return
	movl	-12(%rbp), %eax
	addq	$72, %rsp
	popq	%rbx
	popq	%rbp
	retq
.LBB82_2:                               # %if.then4
	movl	$0, -12(%rbp)
	jmp	.LBB82_18
.LBB82_7:                               # %if.end13
	movl	$ifname, %edi
	callq	strlen
	movl	%eax, -52(%rbp)
	movq	z_suffix(%rip), %rdi
	movl	$.L.str.44, %esi
	callq	strcmp
	testl	%eax, %eax
	jne	.LBB82_9
# BB#8:                                 # %if.then18
	addq	$8, -40(%rbp)
	.p2align	4, 0x90
.LBB82_9:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -48(%rbp)
	movq	%rax, -72(%rbp)
	movq	-24(%rbp), %rsi
	movl	$ifname, %edi
	callq	strcpy
	movslq	-52(%rbp), %rbx
	movq	-48(%rbp), %rdi
	callq	strlen
	addq	%rbx, %rax
	cmpq	$1023, %rax             # imm = 0x3FF
	ja	.LBB82_16
# BB#10:                                # %if.end26
                                        #   in Loop: Header=BB82_9 Depth=1
	movq	-48(%rbp), %rsi
	movl	$ifname, %edi
	callq	strcat
	movq	-64(%rbp), %rsi
	movl	$ifname, %edi
	callq	do_stat
	testl	%eax, %eax
	je	.LBB82_11
# BB#12:                                # %if.end32
                                        #   in Loop: Header=BB82_9 Depth=1
	movq	-72(%rbp), %rdi
	movq	z_suffix(%rip), %rsi
	callq	strcmp
	testl	%eax, %eax
	jne	.LBB82_14
# BB#13:                                # %if.then36
                                        #   in Loop: Header=BB82_9 Depth=1
	callq	__errno_location
	movl	(%rax), %eax
	movl	%eax, -28(%rbp)
.LBB82_14:                              # %do.cond
                                        #   in Loop: Header=BB82_9 Depth=1
	movq	-40(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	%rcx, -40(%rbp)
	cmpq	$0, 8(%rax)
	jne	.LBB82_9
# BB#15:                                # %do.end
	movq	-24(%rbp), %rsi
	movl	$ifname, %edi
	callq	strcpy
	movq	z_suffix(%rip), %rsi
	movl	$ifname, %edi
	callq	strcat
	movl	-28(%rbp), %ebx
	callq	__errno_location
	movl	%ebx, (%rax)
	jmp	.LBB82_5
.LBB82_11:                              # %if.then31
	movl	$0, -12(%rbp)
	jmp	.LBB82_18
.Lfunc_end82:
	.size	get_istat, .Lfunc_end82-get_istat
	.cfi_endproc

	.p2align	4, 0x90
	.type	treat_dir,@function
treat_dir:                              # @treat_dir
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
	pushq	%r14
	pushq	%rbx
	subq	$1056, %rsp             # imm = 0x420
.Lcfi273:
	.cfi_offset %rbx, -32
.Lcfi274:
	.cfi_offset %r14, -24
	movq	%rdi, -32(%rbp)
	callq	opendir
	movq	%rax, -48(%rbp)
	testq	%rax, %rax
	je	.LBB83_13
# BB#1:                                 # %if.end
	leaq	-1072(%rbp), %r14
	jmp	.LBB83_2
.LBB83_9:                               # %if.else
                                        #   in Loop: Header=BB83_2 Depth=1
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movq	-32(%rbp), %rcx
	movq	-40(%rbp), %r8
	addq	$19, %r8
	movl	$.L.str.168, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, exit_code(%rip)
	.p2align	4, 0x90
.LBB83_2:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	callq	__errno_location
	movl	$0, (%rax)
	movq	-48(%rbp), %rdi
	callq	readdir
	movq	%rax, -40(%rbp)
	testq	%rax, %rax
	je	.LBB83_10
# BB#3:                                 # %while.body
                                        #   in Loop: Header=BB83_2 Depth=1
	movq	-40(%rbp), %rdi
	addq	$19, %rdi
	movl	$.L.str.166, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB83_2
# BB#4:                                 # %lor.lhs.false
                                        #   in Loop: Header=BB83_2 Depth=1
	movq	-40(%rbp), %rdi
	addq	$19, %rdi
	movl	$.L.str.167, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB83_2
# BB#5:                                 # %if.end11
                                        #   in Loop: Header=BB83_2 Depth=1
	movq	-32(%rbp), %rdi
	callq	strlen
	movl	%eax, -20(%rbp)
	movslq	-20(%rbp), %rbx
	movq	-40(%rbp), %rdi
	addq	$19, %rdi
	callq	strlen
	leaq	1(%rbx,%rax), %rax
	cmpq	$1022, %rax             # imm = 0x3FE
	ja	.LBB83_9
# BB#6:                                 # %if.then20
                                        #   in Loop: Header=BB83_2 Depth=1
	movq	-32(%rbp), %rsi
	movq	%r14, %rdi
	callq	strcpy
	cmpl	$0, -20(%rbp)
	je	.LBB83_8
# BB#7:                                 # %if.then25
                                        #   in Loop: Header=BB83_2 Depth=1
	movslq	-20(%rbp), %rax
	leal	1(%rax), %ecx
	movl	%ecx, -20(%rbp)
	movb	$47, -1072(%rbp,%rax)
.LBB83_8:                               # %if.end26
                                        #   in Loop: Header=BB83_2 Depth=1
	movslq	-20(%rbp), %rax
	leaq	-1072(%rbp,%rax), %rdi
	movq	-40(%rbp), %rsi
	addq	$19, %rsi
	callq	strcpy
	movq	%r14, %rdi
	callq	treat_file
	jmp	.LBB83_2
.LBB83_10:                              # %while.end
	callq	__errno_location
	cmpl	$0, (%rax)
	je	.LBB83_12
# BB#11:                                # %if.then39
	movq	-32(%rbp), %rdi
	callq	progerror
.LBB83_12:                              # %if.end40
	movq	-48(%rbp), %rdi
	callq	closedir
	testl	%eax, %eax
	je	.LBB83_14
.LBB83_13:                              # %if.then44
	movq	-32(%rbp), %rdi
	callq	progerror
.LBB83_14:                              # %if.end45
	addq	$1056, %rsp             # imm = 0x420
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end83:
	.size	treat_dir, .Lfunc_end83-treat_dir
	.cfi_endproc

	.p2align	4, 0x90
	.type	reset_times,@function
reset_times:                            # @reset_times
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
	pushq	%rbx
	subq	$40, %rsp
.Lcfi278:
	.cfi_offset %rbx, -24
	movq	%rdi, -32(%rbp)
	movq	%rsi, -24(%rbp)
	movq	72(%rsi), %rax
	movq	%rax, -48(%rbp)
	movq	-24(%rbp), %rax
	movq	88(%rax), %rax
	movq	%rax, -40(%rbp)
	movq	-32(%rbp), %rdi
	leaq	-48(%rbp), %rsi
	callq	utime
	testl	%eax, %eax
	je	.LBB84_8
# BB#1:                                 # %land.lhs.true
	movq	-24(%rbp), %rax
	movl	$61440, %ecx            # imm = 0xF000
	andl	24(%rax), %ecx
	cmpl	$16384, %ecx            # imm = 0x4000
	je	.LBB84_8
# BB#2:                                 # %if.then
	callq	__errno_location
	movl	(%rax), %eax
	movl	%eax, -12(%rbp)
	cmpl	$0, quiet(%rip)
	jne	.LBB84_4
# BB#3:                                 # %if.then4
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.133, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB84_4:                               # %if.end
	cmpl	$0, exit_code(%rip)
	jne	.LBB84_6
# BB#5:                                 # %if.then7
	movl	$2, exit_code(%rip)
.LBB84_6:                               # %if.end8
	cmpl	$0, quiet(%rip)
	jne	.LBB84_8
# BB#7:                                 # %if.then10
	movl	-12(%rbp), %ebx
	callq	__errno_location
	movl	%ebx, (%rax)
	movl	$ofname, %edi
	callq	perror
.LBB84_8:                               # %if.end13
	addq	$40, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end84:
	.size	reset_times, .Lfunc_end84-reset_times
	.cfi_endproc

	.p2align	4, 0x90
	.type	make_ofname,@function
make_ofname:                            # @make_ofname
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
	subq	$16, %rsp
	movl	$ofname, %edi
	movl	$ifname, %esi
	callq	strcpy
	movl	$ofname, %edi
	callq	get_suffix
	movq	%rax, -16(%rbp)
	cmpl	$0, decompress(%rip)
	je	.LBB85_15
# BB#1:                                 # %if.then
	cmpq	$0, -16(%rbp)
	je	.LBB85_2
# BB#11:                                # %if.end21
	movq	-16(%rbp), %rdi
	callq	strlwr
	movq	-16(%rbp), %rdi
	movl	$.L.str.162, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB85_13
# BB#12:                                # %lor.lhs.false25
	movq	-16(%rbp), %rdi
	movl	$.L.str.161, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB85_13
# BB#14:                                # %if.else
	movq	-16(%rbp), %rax
	movb	$0, (%rax)
	movl	$0, -4(%rbp)
	jmp	.LBB85_28
.LBB85_15:                              # %if.else31
	cmpq	$0, -16(%rbp)
	je	.LBB85_20
# BB#16:                                # %if.then33
	cmpl	$0, verbose(%rip)
	je	.LBB85_17
.LBB85_19:                              # %if.then39
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movq	-16(%rbp), %r8
	movl	$.L.str.171, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB85_27
.LBB85_13:                              # %if.then28
	movq	-16(%rbp), %rdi
	movl	$.L.str.170, %esi
	callq	strcpy
	movl	$0, -4(%rbp)
	jmp	.LBB85_28
.LBB85_2:                               # %if.then2
	cmpl	$0, recursive(%rip)
	je	.LBB85_3
.LBB85_6:                               # %if.end
	cmpl	$0, verbose(%rip)
	je	.LBB85_7
.LBB85_9:                               # %if.then12
	cmpl	$0, quiet(%rip)
	jne	.LBB85_25
# BB#10:                                # %if.then14
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.169, %esi
	jmp	.LBB85_24
.LBB85_20:                              # %if.else42
	movl	$0, save_orig_name(%rip)
	movl	$ofname, %edi
	callq	strlen
	addq	z_len(%rip), %rax
	cmpq	$1023, %rax             # imm = 0x3FF
	jbe	.LBB85_21
# BB#22:                                # %name_too_long
	cmpl	$0, quiet(%rip)
	jne	.LBB85_25
# BB#23:                                # %if.then51
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.160, %esi
.LBB85_24:                              # %if.end53
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB85_25:                              # %if.end53
	cmpl	$0, exit_code(%rip)
	jne	.LBB85_27
# BB#26:                                # %if.then55
	movl	$2, exit_code(%rip)
	jmp	.LBB85_27
.LBB85_17:                              # %lor.lhs.false35
	cmpl	$0, recursive(%rip)
	jne	.LBB85_27
# BB#18:                                # %land.lhs.true37
	cmpl	$0, quiet(%rip)
	jne	.LBB85_27
	jmp	.LBB85_19
.LBB85_3:                               # %land.lhs.true
	cmpl	$0, list(%rip)
	jne	.LBB85_5
# BB#4:                                 # %lor.lhs.false
	cmpl	$0, test(%rip)
	je	.LBB85_6
.LBB85_5:                               # %if.then6
	movl	$0, -4(%rbp)
	jmp	.LBB85_28
.LBB85_21:                              # %if.end46
	movq	z_suffix(%rip), %rsi
	movl	$ofname, %edi
	callq	strcat
	movl	$0, -4(%rbp)
	jmp	.LBB85_28
.LBB85_7:                               # %lor.lhs.false8
	cmpl	$0, recursive(%rip)
	jne	.LBB85_27
# BB#8:                                 # %land.lhs.true10
	cmpl	$0, quiet(%rip)
	je	.LBB85_9
.LBB85_27:                              # %if.end56
	movl	$2, -4(%rbp)
.LBB85_28:                              # %return
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end85:
	.size	make_ofname, .Lfunc_end85-make_ofname
	.cfi_endproc

	.p2align	4, 0x90
	.type	create_outfile,@function
create_outfile:                         # @create_outfile
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi282:
	.cfi_def_cfa_offset 16
.Lcfi283:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi284:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$152, %rsp
.Lcfi285:
	.cfi_offset %rbx, -24
	movl	$193, -16(%rbp)
	cmpl	$0, ascii(%rip)
	je	.LBB86_2
# BB#1:                                 # %land.lhs.true
	cmpl	$0, decompress(%rip)
.LBB86_2:                               # %if.end
	leaq	-160(%rbp), %rbx
	jmp	.LBB86_4
	.p2align	4, 0x90
.LBB86_3:                               # %if.end30
                                        #   in Loop: Header=BB86_4 Depth=1
	movl	ofd(%rip), %edi
	callq	close
	movl	$ofname, %edi
	callq	xunlink
	movl	$ofname, %edi
	callq	shorten_name
.LBB86_4:                               # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	callq	check_ofname
	testl	%eax, %eax
	jne	.LBB86_15
# BB#5:                                 # %if.end4
                                        #   in Loop: Header=BB86_4 Depth=1
	movl	$1, remove_ofname(%rip)
	movl	-16(%rbp), %esi
	movl	$ofname, %edi
	movl	$384, %edx              # imm = 0x180
	xorl	%eax, %eax
	callq	open
	movl	%eax, ofd(%rip)
	cmpl	$-1, %eax
	je	.LBB86_14
# BB#6:                                 # %if.end9
                                        #   in Loop: Header=BB86_4 Depth=1
	movl	ofd(%rip), %edi
	movq	%rbx, %rsi
	callq	fstat
	movl	$ofname, %edi
	testl	%eax, %eax
	jne	.LBB86_16
# BB#7:                                 # %if.end16
                                        #   in Loop: Header=BB86_4 Depth=1
	movq	%rbx, %rsi
	callq	name_too_long
	testl	%eax, %eax
	je	.LBB86_13
# BB#8:                                 # %if.end20
                                        #   in Loop: Header=BB86_4 Depth=1
	cmpl	$0, decompress(%rip)
	je	.LBB86_3
# BB#9:                                 # %if.then22
	cmpl	$0, quiet(%rip)
	jne	.LBB86_11
# BB#10:                                # %if.then24
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.172, %esi
	movl	$ofname, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB86_11:                              # %if.end26
	cmpl	$0, exit_code(%rip)
	jne	.LBB86_13
# BB#12:                                # %if.then28
	movl	$2, exit_code(%rip)
.LBB86_13:                              # %if.end29
	movl	$0, -12(%rbp)
	jmp	.LBB86_18
.LBB86_14:                              # %if.then7
	movl	$ofname, %edi
	callq	progerror
.LBB86_15:                              # %if.then2
	movl	ifd(%rip), %edi
	callq	close
	jmp	.LBB86_17
.LBB86_16:                              # %if.then12
	callq	progerror
	movl	ifd(%rip), %edi
	callq	close
	movl	ofd(%rip), %edi
	callq	close
	movl	$ofname, %edi
	callq	xunlink
.LBB86_17:                              # %return
	movl	$1, -12(%rbp)
.LBB86_18:                              # %return
	movl	-12(%rbp), %eax
	addq	$152, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end86:
	.size	create_outfile, .Lfunc_end86-create_outfile
	.cfi_endproc

	.p2align	4, 0x90
	.type	copy_stat,@function
copy_stat:                              # @copy_stat
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
	pushq	%rbx
	subq	$24, %rsp
.Lcfi289:
	.cfi_offset %rbx, -24
	movq	%rdi, -16(%rbp)
	cmpl	$0, decompress(%rip)
	je	.LBB87_5
# BB#1:                                 # %land.lhs.true
	cmpq	$0, time_stamp(%rip)
	je	.LBB87_5
# BB#2:                                 # %land.lhs.true1
	movq	-16(%rbp), %rax
	movq	88(%rax), %rax
	cmpq	time_stamp(%rip), %rax
	je	.LBB87_5
# BB#3:                                 # %if.then
	movq	time_stamp(%rip), %rax
	movq	-16(%rbp), %rcx
	movq	%rax, 88(%rcx)
	cmpl	$2, verbose(%rip)
	jl	.LBB87_5
# BB#4:                                 # %if.then6
	movq	stderr(%rip), %rdi
	movl	$.L.str.181, %esi
	movl	$ofname, %edx
	xorl	%eax, %eax
	callq	fprintf
.LBB87_5:                               # %if.end7
	movq	-16(%rbp), %rsi
	movl	$ofname, %edi
	callq	reset_times
	movl	ofd(%rip), %edi
	movq	-16(%rbp), %rax
	movl	$4095, %esi             # imm = 0xFFF
	andl	24(%rax), %esi
	callq	fchmod
	testl	%eax, %eax
	je	.LBB87_12
# BB#6:                                 # %if.then10
	callq	__errno_location
	movl	(%rax), %eax
	movl	%eax, -24(%rbp)
	cmpl	$0, quiet(%rip)
	jne	.LBB87_8
# BB#7:                                 # %if.then13
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.133, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB87_8:                               # %if.end15
	cmpl	$0, exit_code(%rip)
	jne	.LBB87_10
# BB#9:                                 # %if.then17
	movl	$2, exit_code(%rip)
.LBB87_10:                              # %if.end18
	cmpl	$0, quiet(%rip)
	jne	.LBB87_12
# BB#11:                                # %if.then20
	movl	-24(%rbp), %ebx
	callq	__errno_location
	movl	%ebx, (%rax)
	movl	$ofname, %edi
	callq	perror
.LBB87_12:                              # %if.end23
	movl	ofd(%rip), %edi
	movq	-16(%rbp), %rax
	movl	28(%rax), %esi
	movl	32(%rax), %edx
	callq	fchown
	movl	$0, remove_ofname(%rip)
	movl	$ifname, %edi
	callq	xunlink
	testl	%eax, %eax
	je	.LBB87_19
# BB#13:                                # %if.then27
	callq	__errno_location
	movl	(%rax), %eax
	movl	%eax, -20(%rbp)
	cmpl	$0, quiet(%rip)
	jne	.LBB87_15
# BB#14:                                # %if.then31
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.133, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB87_15:                              # %if.end33
	cmpl	$0, exit_code(%rip)
	jne	.LBB87_17
# BB#16:                                # %if.then35
	movl	$2, exit_code(%rip)
.LBB87_17:                              # %if.end36
	cmpl	$0, quiet(%rip)
	jne	.LBB87_19
# BB#18:                                # %if.then38
	movl	-20(%rbp), %ebx
	callq	__errno_location
	movl	%ebx, (%rax)
	movl	$ifname, %edi
	callq	perror
.LBB87_19:                              # %if.end41
	addq	$24, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end87:
	.size	copy_stat, .Lfunc_end87-copy_stat
	.cfi_endproc

	.p2align	4, 0x90
	.type	do_stat,@function
do_stat:                                # @do_stat
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
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -16(%rbp)
	callq	__errno_location
	movl	$0, (%rax)
	cmpl	$0, to_stdout(%rip)
	jne	.LBB88_3
# BB#1:                                 # %land.lhs.true
	cmpl	$0, force(%rip)
	je	.LBB88_2
.LBB88_3:                               # %if.end
	movq	-24(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	stat
.LBB88_4:                               # %return
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	addq	$32, %rsp
	popq	%rbp
	retq
.LBB88_2:                               # %if.then
	movq	-24(%rbp), %rdi
	movq	-16(%rbp), %rsi
	callq	lstat
	jmp	.LBB88_4
.Lfunc_end88:
	.size	do_stat, .Lfunc_end88-do_stat
	.cfi_endproc

	.p2align	4, 0x90
	.type	get_suffix,@function
get_suffix:                             # @get_suffix
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
	pushq	%rbx
	subq	$88, %rsp
.Lcfi296:
	.cfi_offset %rbx, -24
	movq	%rdi, -40(%rbp)
	movq	$get_suffix.known_suffixes, -24(%rbp)
	movq	z_suffix(%rip), %rax
	movq	%rax, get_suffix.known_suffixes(%rip)
	movq	z_suffix(%rip), %rdi
	movl	$.L.str.165, %esi
	callq	strcmp
	testl	%eax, %eax
	jne	.LBB89_2
# BB#1:                                 # %if.then
	addq	$8, -24(%rbp)
.LBB89_2:                               # %if.end
	movq	-40(%rbp), %rdi
	callq	strlen
	movl	%eax, -28(%rbp)
	cmpl	$32, %eax
	jg	.LBB89_4
# BB#3:                                 # %if.then4
	movq	-40(%rbp), %rsi
	jmp	.LBB89_5
.LBB89_4:                               # %if.else
	movq	-40(%rbp), %rax
	movslq	-28(%rbp), %rcx
	leaq	-32(%rax,%rcx), %rsi
.LBB89_5:                               # %if.end10
	leaq	-96(%rbp), %rdi
	callq	strcpy
	leaq	-96(%rbp), %rbx
	movq	%rbx, %rdi
	callq	strlwr
	movq	%rbx, %rdi
	callq	strlen
	movl	%eax, -16(%rbp)
	.p2align	4, 0x90
.LBB89_6:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movq	-24(%rbp), %rax
	movq	(%rax), %rdi
	callq	strlen
	movl	%eax, -12(%rbp)
	cmpl	%eax, -16(%rbp)
	jle	.LBB89_10
# BB#7:                                 # %land.lhs.true
                                        #   in Loop: Header=BB89_6 Depth=1
	movslq	-16(%rbp), %rax
	movslq	-12(%rbp), %rcx
	subq	%rcx, %rax
	cmpb	$47, -97(%rbp,%rax)
	je	.LBB89_10
# BB#8:                                 # %land.lhs.true24
                                        #   in Loop: Header=BB89_6 Depth=1
	movslq	-16(%rbp), %rax
	leaq	-96(%rbp,%rax), %rdi
	movslq	-12(%rbp), %rax
	subq	%rax, %rdi
	movq	-24(%rbp), %rax
	movq	(%rax), %rsi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB89_9
.LBB89_10:                              # %do.cond
                                        #   in Loop: Header=BB89_6 Depth=1
	movq	-24(%rbp), %rax
	leaq	8(%rax), %rcx
	movq	%rcx, -24(%rbp)
	cmpq	$0, 8(%rax)
	jne	.LBB89_6
# BB#11:                                # %do.end
	movq	$0, -48(%rbp)
	jmp	.LBB89_12
.LBB89_9:                               # %if.then33
	movslq	-28(%rbp), %rax
	addq	-40(%rbp), %rax
	movslq	-12(%rbp), %rcx
	subq	%rcx, %rax
	movq	%rax, -48(%rbp)
.LBB89_12:                              # %return
	movq	-48(%rbp), %rax
	addq	$88, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end89:
	.size	get_suffix, .Lfunc_end89-get_suffix
	.cfi_endproc

	.p2align	4, 0x90
	.type	check_ofname,@function
check_ofname:                           # @check_ofname
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi297:
	.cfi_def_cfa_offset 16
.Lcfi298:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi299:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$152, %rsp
.Lcfi300:
	.cfi_offset %rbx, -24
	callq	__errno_location
	movl	$0, (%rax)
	leaq	-160(%rbp), %rbx
	jmp	.LBB90_2
	.p2align	4, 0x90
.LBB90_1:                               # %if.end
                                        #   in Loop: Header=BB90_2 Depth=1
	movl	$ofname, %edi
	callq	shorten_name
.LBB90_2:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	$ofname, %edi
	movq	%rbx, %rsi
	callq	lstat
	testl	%eax, %eax
	je	.LBB90_5
# BB#3:                                 # %while.body
                                        #   in Loop: Header=BB90_2 Depth=1
	callq	__errno_location
	cmpl	$36, (%rax)
	je	.LBB90_1
.LBB90_4:                               # %if.end47
	movl	$0, -12(%rbp)
	jmp	.LBB90_21
.LBB90_5:                               # %while.end
	cmpl	$0, decompress(%rip)
	je	.LBB90_9
.LBB90_6:                               # %if.end11
	leaq	-160(%rbp), %rsi
	movl	$istat, %edi
	callq	same_file
	testl	%eax, %eax
	je	.LBB90_11
# BB#7:                                 # %if.then14
	movl	$ifname, %edi
	movl	$ofname, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB90_18
# BB#8:                                 # %if.else
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.174, %esi
	movl	$ifname, %ecx
	movl	$ofname, %r8d
	jmp	.LBB90_19
.LBB90_9:                               # %land.lhs.true
	leaq	-160(%rbp), %rsi
	movl	$ofname, %edi
	callq	name_too_long
	testl	%eax, %eax
	je	.LBB90_6
# BB#10:                                # %if.then6
	movl	$ofname, %edi
	callq	shorten_name
	leaq	-160(%rbp), %rsi
	movl	$ofname, %edi
	callq	lstat
	testl	%eax, %eax
	jne	.LBB90_4
	jmp	.LBB90_6
.LBB90_11:                              # %if.end22
	cmpl	$0, force(%rip)
	jne	.LBB90_16
# BB#12:                                # %if.then24
	movl	$0, -16(%rbp)
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.175, %esi
	movl	$ofname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	cmpl	$0, foreground(%rip)
	je	.LBB90_15
# BB#13:                                # %land.lhs.true27
	movq	stdin(%rip), %rdi
	callq	fileno
	movl	%eax, %edi
	callq	isatty
	testl	%eax, %eax
	je	.LBB90_15
# BB#14:                                # %if.then31
	movq	stderr(%rip), %rdi
	movl	$.L.str.176, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	stderr(%rip), %rdi
	callq	fflush
	callq	yesno
	movl	%eax, -16(%rbp)
.LBB90_15:                              # %if.end35
	cmpl	$0, -16(%rbp)
	je	.LBB90_22
.LBB90_16:                              # %if.end43
	movl	$ofname, %edi
	callq	xunlink
	testl	%eax, %eax
	je	.LBB90_4
# BB#17:                                # %if.then46
	movl	$ofname, %edi
	callq	progerror
	jmp	.LBB90_20
.LBB90_18:                              # %if.then17
	movq	stderr(%rip), %rdi
	cmpl	$0, decompress(%rip)
	movq	progname(%rip), %rdx
	movl	$.L.str.128, %eax
	movl	$.L.str.8, %r8d
	cmovneq	%rax, %r8
	movl	$.L.str.173, %esi
	movl	$ifname, %ecx
.LBB90_19:                              # %if.end21
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, exit_code(%rip)
.LBB90_20:                              # %return
	movl	$1, -12(%rbp)
.LBB90_21:                              # %return
	movl	-12(%rbp), %eax
	addq	$152, %rsp
	popq	%rbx
	popq	%rbp
	retq
.LBB90_22:                              # %if.then37
	movq	stderr(%rip), %rdi
	movl	$.L.str.177, %esi
	xorl	%eax, %eax
	callq	fprintf
	cmpl	$0, exit_code(%rip)
	jne	.LBB90_20
# BB#23:                                # %if.then40
	movl	$2, exit_code(%rip)
	jmp	.LBB90_20
.Lfunc_end90:
	.size	check_ofname, .Lfunc_end90-check_ofname
	.cfi_endproc

	.p2align	4, 0x90
	.type	name_too_long,@function
name_too_long:                          # @name_too_long
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
	pushq	%rbx
	subq	$184, %rsp
.Lcfi304:
	.cfi_offset %rbx, -24
	movq	%rdi, -32(%rbp)
	movq	%rsi, -48(%rbp)
	movq	-32(%rbp), %rdi
	callq	strlen
	movl	%eax, -16(%rbp)
	movq	-32(%rbp), %rax
	movslq	-16(%rbp), %rcx
	movb	-1(%rax,%rcx), %al
	movb	%al, -10(%rbp)
	movq	-48(%rbp), %rsi
	leaq	-192(%rbp), %rbx
	movl	$144, %edx
	movq	%rbx, %rdi
	callq	memcpy
	movq	-32(%rbp), %rax
	movslq	-16(%rbp), %rcx
	movb	$0, -1(%rax,%rcx)
	movq	-32(%rbp), %rdi
	movq	%rbx, %rsi
	callq	lstat
	testl	%eax, %eax
	je	.LBB91_2
# BB#1:                                 # %entry.land.end_crit_edge
	movb	$0, -9(%rbp)
	jmp	.LBB91_3
.LBB91_2:                               # %land.rhs
	movq	-48(%rbp), %rdi
	leaq	-192(%rbp), %rsi
	callq	same_file
	testl	%eax, %eax
	setne	-17(%rbp)
	setne	-9(%rbp)
.LBB91_3:                               # %land.end
	movzbl	-9(%rbp), %eax
	movl	%eax, -36(%rbp)
	movb	-10(%rbp), %al
	movq	-32(%rbp), %rcx
	movslq	-16(%rbp), %rdx
	movb	%al, -1(%rcx,%rdx)
	movl	-36(%rbp), %eax
	addq	$184, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end91:
	.size	name_too_long, .Lfunc_end91-name_too_long
	.cfi_endproc

	.p2align	4, 0x90
	.type	shorten_name,@function
shorten_name:                           # @shorten_name
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi305:
	.cfi_def_cfa_offset 16
.Lcfi306:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi307:
	.cfi_def_cfa_register %rbp
	subq	$80, %rsp
	movq	%rdi, -40(%rbp)
	movq	$0, -24(%rbp)
	movl	$3, -44(%rbp)
	movq	-40(%rbp), %rdi
	callq	strlen
	movl	%eax, -28(%rbp)
	cmpl	$0, decompress(%rip)
	je	.LBB92_4
# BB#1:                                 # %if.then
	cmpl	$1, -28(%rbp)
	jg	.LBB92_3
# BB#2:                                 # %if.then2
	movl	$.L.str.178, %edi
	callq	error
.LBB92_3:                               # %if.end
	movq	-40(%rbp), %rax
	movslq	-28(%rbp), %rcx
	movb	$0, -1(%rax,%rcx)
	jmp	.LBB92_30
.LBB92_4:                               # %if.end3
	movq	-40(%rbp), %rdi
	callq	get_suffix
	movq	%rax, -16(%rbp)
	testq	%rax, %rax
	jne	.LBB92_6
# BB#5:                                 # %if.then7
	movl	$.L.str.179, %edi
	callq	error
.LBB92_6:                               # %if.end8
	movq	-16(%rbp), %rax
	movb	$0, (%rax)
	movl	$1, save_orig_name(%rip)
	cmpl	$5, -28(%rbp)
	jl	.LBB92_9
# BB#7:                                 # %land.lhs.true
	movq	-16(%rbp), %rdi
	addq	$-4, %rdi
	movl	$.L.str.170, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB92_8
	.p2align	4, 0x90
.LBB92_9:                               # %do.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB92_13 Depth 2
	movq	-40(%rbp), %rdi
	movl	$47, %esi
	callq	strrchr
	movq	%rax, -16(%rbp)
	testq	%rax, %rax
	je	.LBB92_11
# BB#10:                                # %cond.true
                                        #   in Loop: Header=BB92_9 Depth=1
	movq	-16(%rbp), %rax
	incq	%rax
	movq	%rax, -64(%rbp)
	jmp	.LBB92_12
	.p2align	4, 0x90
.LBB92_11:                              # %cond.false
                                        #   in Loop: Header=BB92_9 Depth=1
	movq	-40(%rbp), %rax
	movq	%rax, -72(%rbp)
.LBB92_12:                              # %cond.end
                                        #   in Loop: Header=BB92_9 Depth=1
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, -16(%rbp)
	jmp	.LBB92_13
	.p2align	4, 0x90
.LBB92_17:                              # %if.then31
                                        #   in Loop: Header=BB92_13 Depth=2
	incq	-16(%rbp)
.LBB92_13:                              # %while.cond
                                        #   Parent Loop BB92_9 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-16(%rbp), %rax
	cmpb	$0, (%rax)
	je	.LBB92_18
# BB#14:                                # %while.body
                                        #   in Loop: Header=BB92_13 Depth=2
	movq	-16(%rbp), %rdi
	movl	$.L.str.166, %esi
	callq	strcspn
	movl	%eax, -48(%rbp)
	movslq	-48(%rbp), %rax
	addq	%rax, -16(%rbp)
	movl	-48(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jle	.LBB92_16
# BB#15:                                # %if.then27
                                        #   in Loop: Header=BB92_13 Depth=2
	movq	-16(%rbp), %rax
	decq	%rax
	movq	%rax, -24(%rbp)
.LBB92_16:                              # %if.end29
                                        #   in Loop: Header=BB92_13 Depth=2
	movq	-16(%rbp), %rax
	cmpb	$0, (%rax)
	je	.LBB92_13
	jmp	.LBB92_17
	.p2align	4, 0x90
.LBB92_18:                              # %do.cond
                                        #   in Loop: Header=BB92_9 Depth=1
	cmpq	$0, -24(%rbp)
	je	.LBB92_20
# BB#19:                                # %do.cond.land.end_crit_edge
                                        #   in Loop: Header=BB92_9 Depth=1
	movb	$0, -1(%rbp)
	jmp	.LBB92_21
	.p2align	4, 0x90
.LBB92_20:                              # %land.rhs
                                        #   in Loop: Header=BB92_9 Depth=1
	decl	-44(%rbp)
	setne	-29(%rbp)
	setne	-1(%rbp)
.LBB92_21:                              # %land.end
                                        #   in Loop: Header=BB92_9 Depth=1
	movb	-1(%rbp), %al
	testb	%al, %al
	jne	.LBB92_9
# BB#22:                                # %do.end
	cmpq	$0, -24(%rbp)
	je	.LBB92_24
	.p2align	4, 0x90
.LBB92_23:                              # %do.cond43
                                        # =>This Inner Loop Header: Depth=1
	movq	-24(%rbp), %rax
	movzbl	1(%rax), %ecx
	movb	%cl, (%rax)
	movq	-24(%rbp), %rax
	leaq	1(%rax), %rcx
	movq	%rcx, -24(%rbp)
	cmpb	$0, (%rax)
	jne	.LBB92_23
.LBB92_27:                              # %if.then58
	decq	-24(%rbp)
	jmp	.LBB92_28
.LBB92_24:                              # %if.else
	movq	-40(%rbp), %rdi
	movsbl	.L.str.166(%rip), %esi
	callq	strrchr
	movq	%rax, -24(%rbp)
	testq	%rax, %rax
	jne	.LBB92_26
# BB#25:                                # %if.then52
	movl	$.L.str.180, %edi
	callq	error
.LBB92_26:                              # %if.end53
	movq	-24(%rbp), %rax
	cmpb	$0, 1(%rax)
	je	.LBB92_27
.LBB92_28:                              # %if.end61
	movq	-24(%rbp), %rdi
	movq	z_suffix(%rip), %rsi
.LBB92_29:                              # %return
	callq	strcpy
.LBB92_30:                              # %return
	addq	$80, %rsp
	popq	%rbp
	retq
.LBB92_8:                               # %if.then14
	movq	-16(%rbp), %rdi
	addq	$-4, %rdi
	movl	$.L.str.162, %esi
	jmp	.LBB92_29
.Lfunc_end92:
	.size	shorten_name, .Lfunc_end92-shorten_name
	.cfi_endproc

	.p2align	4, 0x90
	.type	same_file,@function
same_file:                              # @same_file
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi308:
	.cfi_def_cfa_offset 16
.Lcfi309:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi310:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	cmpq	8(%rsi), %rax
	jne	.LBB93_1
# BB#2:                                 # %land.rhs
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	movq	-24(%rbp), %rcx
	cmpq	(%rcx), %rax
	sete	-2(%rbp)
	sete	-1(%rbp)
	jmp	.LBB93_3
.LBB93_1:                               # %entry.land.end_crit_edge
	movb	$0, -1(%rbp)
.LBB93_3:                               # %land.end
	movzbl	-1(%rbp), %eax
	popq	%rbp
	retq
.Lfunc_end93:
	.size	same_file, .Lfunc_end93-same_file
	.cfi_endproc

	.p2align	4, 0x90
	.type	do_remove,@function
do_remove:                              # @do_remove
	.cfi_startproc
# BB#0:                                 # %entry
	cmpl	$0, remove_ofname(%rip)
	je	.LBB94_2
# BB#1:                                 # %if.then
	pushq	%rbp
.Lcfi311:
	.cfi_def_cfa_offset 16
.Lcfi312:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi313:
	.cfi_def_cfa_register %rbp
	movl	ofd(%rip), %edi
	callq	close
	movl	$ofname, %edi
	callq	xunlink
	popq	%rbp
.LBB94_2:                               # %if.end
	retq
.Lfunc_end94:
	.size	do_remove, .Lfunc_end94-do_remove
	.cfi_endproc

	.p2align	4, 0x90
	.type	pqdownheap,@function
pqdownheap:                             # @pqdownheap
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi314:
	.cfi_def_cfa_offset 16
.Lcfi315:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi316:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -24(%rbp)
	movl	%esi, -8(%rbp)
	movslq	-8(%rbp), %rax
	movl	heap(,%rax,4), %eax
	movl	%eax, -12(%rbp)
	movl	-8(%rbp), %eax
	addl	%eax, %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB95_1
	.p2align	4, 0x90
.LBB95_10:                              # %if.end87
                                        #   in Loop: Header=BB95_1 Depth=1
	movslq	-4(%rbp), %rax
	movl	heap(,%rax,4), %eax
	movslq	-8(%rbp), %rcx
	movl	%eax, heap(,%rcx,4)
	movl	-4(%rbp), %eax
	movl	%eax, -8(%rbp)
	shll	-4(%rbp)
.LBB95_1:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	heap_len(%rip), %eax
	jg	.LBB95_11
# BB#2:                                 # %while.body
                                        #   in Loop: Header=BB95_1 Depth=1
	movl	-4(%rbp), %eax
	cmpl	heap_len(%rip), %eax
	jge	.LBB95_7
# BB#3:                                 # %land.lhs.true
                                        #   in Loop: Header=BB95_1 Depth=1
	movq	-24(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movslq	heap+4(,%rcx,4), %rdx
	movzwl	(%rax,%rdx,4), %edx
	movslq	heap(,%rcx,4), %rcx
	movzwl	(%rax,%rcx,4), %eax
	cmpl	%eax, %edx
	jge	.LBB95_4
.LBB95_6:                               # %if.then
                                        #   in Loop: Header=BB95_1 Depth=1
	incl	-4(%rbp)
	jmp	.LBB95_7
	.p2align	4, 0x90
.LBB95_4:                               # %lor.lhs.false
                                        #   in Loop: Header=BB95_1 Depth=1
	movq	-24(%rbp), %rax
	movslq	-4(%rbp), %rcx
	movslq	heap+4(,%rcx,4), %rdx
	movzwl	(%rax,%rdx,4), %edx
	movslq	heap(,%rcx,4), %rcx
	movzwl	(%rax,%rcx,4), %eax
	cmpl	%eax, %edx
	jne	.LBB95_7
# BB#5:                                 # %land.lhs.true32
                                        #   in Loop: Header=BB95_1 Depth=1
	movslq	-4(%rbp), %rax
	movslq	heap+4(,%rax,4), %rcx
	movzbl	depth(%rcx), %ecx
	movslq	heap(,%rax,4), %rax
	movzbl	depth(%rax), %eax
	cmpl	%eax, %ecx
	jle	.LBB95_6
	.p2align	4, 0x90
.LBB95_7:                               # %if.end
                                        #   in Loop: Header=BB95_1 Depth=1
	movq	-24(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movzwl	(%rax,%rcx,4), %ecx
	movslq	-4(%rbp), %rdx
	movslq	heap(,%rdx,4), %rdx
	movzwl	(%rax,%rdx,4), %eax
	cmpl	%eax, %ecx
	jl	.LBB95_11
# BB#8:                                 # %lor.lhs.false60
                                        #   in Loop: Header=BB95_1 Depth=1
	movq	-24(%rbp), %rax
	movslq	-12(%rbp), %rcx
	movzwl	(%rax,%rcx,4), %ecx
	movslq	-4(%rbp), %rdx
	movslq	heap(,%rdx,4), %rdx
	movzwl	(%rax,%rdx,4), %eax
	cmpl	%eax, %ecx
	jne	.LBB95_10
# BB#9:                                 # %land.lhs.true75
                                        #   in Loop: Header=BB95_1 Depth=1
	movslq	-12(%rbp), %rax
	movzbl	depth(%rax), %eax
	movslq	-4(%rbp), %rcx
	movslq	heap(,%rcx,4), %rcx
	movzbl	depth(%rcx), %ecx
	cmpl	%ecx, %eax
	jg	.LBB95_10
.LBB95_11:                              # %while.end
	movl	-12(%rbp), %eax
	movslq	-8(%rbp), %rcx
	movl	%eax, heap(,%rcx,4)
	popq	%rbp
	retq
.Lfunc_end95:
	.size	pqdownheap, .Lfunc_end95-pqdownheap
	.cfi_endproc

	.p2align	4, 0x90
	.type	gen_bitlen,@function
gen_bitlen:                             # @gen_bitlen
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi317:
	.cfi_def_cfa_offset 16
.Lcfi318:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi319:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -48(%rbp)
	movq	(%rdi), %rax
	movq	%rax, -32(%rbp)
	movq	-48(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -72(%rbp)
	movq	-48(%rbp), %rax
	movl	24(%rax), %eax
	movl	%eax, -56(%rbp)
	movq	-48(%rbp), %rax
	movl	36(%rax), %eax
	movl	%eax, -52(%rbp)
	movq	-48(%rbp), %rax
	movl	32(%rax), %eax
	movl	%eax, -16(%rbp)
	movq	-48(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -64(%rbp)
	movl	$0, -24(%rbp)
	movl	$0, -4(%rbp)
	cmpl	$15, -4(%rbp)
	jg	.LBB96_3
	.p2align	4, 0x90
.LBB96_2:                               # %for.inc
                                        # =>This Inner Loop Header: Depth=1
	movslq	-4(%rbp), %rax
	movw	$0, bl_count(%rax,%rax)
	incl	-4(%rbp)
	cmpl	$15, -4(%rbp)
	jle	.LBB96_2
.LBB96_3:                               # %for.end
	movq	-32(%rbp), %rax
	movslq	heap_max(%rip), %rcx
	movslq	heap(,%rcx,4), %rcx
	movw	$0, 2(%rax,%rcx,4)
	movl	heap_max(%rip), %eax
	incl	%eax
	movl	%eax, -12(%rbp)
	cmpl	$572, -12(%rbp)         # imm = 0x23C
	jle	.LBB96_5
	jmp	.LBB96_13
	.p2align	4, 0x90
.LBB96_12:                              # %for.inc59
                                        #   in Loop: Header=BB96_5 Depth=1
	incl	-12(%rbp)
	cmpl	$572, -12(%rbp)         # imm = 0x23C
	jg	.LBB96_13
.LBB96_5:                               # %for.body9
                                        # =>This Inner Loop Header: Depth=1
	movslq	-12(%rbp), %rax
	movl	heap(,%rax,4), %eax
	movl	%eax, -8(%rbp)
	movq	-32(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	2(%rax,%rcx,4), %ecx
	movzwl	2(%rax,%rcx,4), %eax
	incl	%eax
	movl	%eax, -4(%rbp)
	cmpl	-16(%rbp), %eax
	jle	.LBB96_7
# BB#6:                                 # %if.then
                                        #   in Loop: Header=BB96_5 Depth=1
	movl	-16(%rbp), %eax
	movl	%eax, -4(%rbp)
	incl	-24(%rbp)
.LBB96_7:                               # %if.end
                                        #   in Loop: Header=BB96_5 Depth=1
	movzwl	-4(%rbp), %eax
	movq	-32(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movw	%ax, 2(%rcx,%rdx,4)
	movl	-8(%rbp), %eax
	cmpl	-52(%rbp), %eax
	jg	.LBB96_12
# BB#8:                                 # %if.end31
                                        #   in Loop: Header=BB96_5 Depth=1
	movslq	-4(%rbp), %rax
	incw	bl_count(%rax,%rax)
	movl	$0, -36(%rbp)
	movl	-8(%rbp), %eax
	cmpl	-56(%rbp), %eax
	jl	.LBB96_10
# BB#9:                                 # %if.then37
                                        #   in Loop: Header=BB96_5 Depth=1
	movq	-72(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movslq	-56(%rbp), %rdx
	subq	%rdx, %rcx
	movl	(%rax,%rcx,4), %eax
	movl	%eax, -36(%rbp)
.LBB96_10:                              # %if.end40
                                        #   in Loop: Header=BB96_5 Depth=1
	movq	-32(%rbp), %rax
	movslq	-8(%rbp), %rcx
	movzwl	(%rax,%rcx,4), %eax
	movw	%ax, -18(%rbp)
	movzwl	-18(%rbp), %eax
	movslq	-4(%rbp), %rcx
	movslq	-36(%rbp), %rdx
	addq	%rcx, %rdx
	imulq	%rax, %rdx
	addq	%rdx, opt_len(%rip)
	cmpq	$0, -64(%rbp)
	je	.LBB96_12
# BB#11:                                # %if.then47
                                        #   in Loop: Header=BB96_5 Depth=1
	movzwl	-18(%rbp), %eax
	movq	-64(%rbp), %rcx
	movslq	-8(%rbp), %rdx
	movzwl	2(%rcx,%rdx,4), %ecx
	movslq	-36(%rbp), %rdx
	addq	%rcx, %rdx
	imulq	%rax, %rdx
	addq	%rdx, static_len(%rip)
	jmp	.LBB96_12
.LBB96_13:                              # %for.end61
	cmpl	$0, -24(%rbp)
	je	.LBB96_27
	.p2align	4, 0x90
.LBB96_14:                              # %do.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB96_15 Depth 2
	movl	-16(%rbp), %eax
	decl	%eax
	movl	%eax, -4(%rbp)
	jmp	.LBB96_15
	.p2align	4, 0x90
.LBB96_16:                              # %while.body
                                        #   in Loop: Header=BB96_15 Depth=2
	decl	-4(%rbp)
.LBB96_15:                              # %while.cond
                                        #   Parent Loop BB96_14 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	-4(%rbp), %rax
	cmpw	$0, bl_count(%rax,%rax)
	je	.LBB96_16
# BB#17:                                # %do.cond
                                        #   in Loop: Header=BB96_14 Depth=1
	movslq	-4(%rbp), %rax
	decw	bl_count(%rax,%rax)
	movslq	-4(%rbp), %rax
	movzwl	bl_count+2(%rax,%rax), %ecx
	addl	$2, %ecx
	movw	%cx, bl_count+2(%rax,%rax)
	movslq	-16(%rbp), %rax
	decw	bl_count(%rax,%rax)
	movl	-24(%rbp), %eax
	addl	$-2, %eax
	movl	%eax, -24(%rbp)
	testl	%eax, %eax
	jg	.LBB96_14
# BB#18:                                # %do.end
	movl	-16(%rbp), %eax
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	jne	.LBB96_20
	jmp	.LBB96_27
	.p2align	4, 0x90
.LBB96_26:                              # %for.inc135
                                        #   in Loop: Header=BB96_20 Depth=1
	decl	-4(%rbp)
	cmpl	$0, -4(%rbp)
	je	.LBB96_27
.LBB96_20:                              # %for.body90
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB96_22 Depth 2
	movslq	-4(%rbp), %rax
	movzwl	bl_count(%rax,%rax), %eax
	movl	%eax, -8(%rbp)
	cmpl	$0, -8(%rbp)
	jne	.LBB96_22
	jmp	.LBB96_26
	.p2align	4, 0x90
.LBB96_25:                              # %if.end132
                                        #   in Loop: Header=BB96_22 Depth=2
	decl	-8(%rbp)
.LBB96_21:                              # %while.cond94
                                        #   in Loop: Header=BB96_22 Depth=2
	cmpl	$0, -8(%rbp)
	je	.LBB96_26
.LBB96_22:                              # %while.body97
                                        #   Parent Loop BB96_20 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	-12(%rbp), %rax
	leaq	-1(%rax), %rcx
	movl	%ecx, -12(%rbp)
	movl	heap-4(,%rax,4), %eax
	movl	%eax, -40(%rbp)
	cmpl	-52(%rbp), %eax
	jg	.LBB96_21
# BB#23:                                # %if.end104
                                        #   in Loop: Header=BB96_22 Depth=2
	movq	-32(%rbp), %rax
	movslq	-40(%rbp), %rcx
	movzwl	2(%rax,%rcx,4), %eax
	cmpl	-4(%rbp), %eax
	je	.LBB96_25
# BB#24:                                # %if.then112
                                        #   in Loop: Header=BB96_22 Depth=2
	movslq	-4(%rbp), %rax
	movq	-32(%rbp), %rcx
	movslq	-40(%rbp), %rdx
	movzwl	2(%rcx,%rdx,4), %esi
	subq	%rsi, %rax
	movzwl	(%rcx,%rdx,4), %ecx
	imulq	%rax, %rcx
	addq	%rcx, opt_len(%rip)
	movzwl	-4(%rbp), %eax
	movq	-32(%rbp), %rcx
	movslq	-40(%rbp), %rdx
	movw	%ax, 2(%rcx,%rdx,4)
	jmp	.LBB96_25
.LBB96_27:                              # %for.end137
	popq	%rbp
	retq
.Lfunc_end96:
	.size	gen_bitlen, .Lfunc_end96-gen_bitlen
	.cfi_endproc

	.p2align	4, 0x90
	.type	scan_tree,@function
scan_tree:                              # @scan_tree
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
	movq	%rdi, -40(%rbp)
	movl	%esi, -32(%rbp)
	movl	$-1, -28(%rbp)
	movq	-40(%rbp), %rax
	movzwl	2(%rax), %eax
	movl	%eax, -12(%rbp)
	movl	$0, -8(%rbp)
	movl	$7, -20(%rbp)
	movl	$4, -16(%rbp)
	cmpl	$0, -12(%rbp)
	jne	.LBB97_2
# BB#1:                                 # %if.then
	movl	$138, -20(%rbp)
	movl	$3, -16(%rbp)
.LBB97_2:                               # %if.end
	movq	-40(%rbp), %rax
	movslq	-32(%rbp), %rcx
	movw	$-1, 6(%rax,%rcx,4)
	movl	$0, -24(%rbp)
	jmp	.LBB97_3
	.p2align	4, 0x90
.LBB97_20:                              # %for.inc
                                        #   in Loop: Header=BB97_3 Depth=1
	incl	-24(%rbp)
.LBB97_3:                               # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	-24(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jg	.LBB97_21
# BB#4:                                 # %for.body
                                        #   in Loop: Header=BB97_3 Depth=1
	movl	-12(%rbp), %eax
	movl	%eax, -4(%rbp)
	movq	-40(%rbp), %rax
	movslq	-24(%rbp), %rcx
	movzwl	6(%rax,%rcx,4), %eax
	movl	%eax, -12(%rbp)
	movl	-8(%rbp), %eax
	incl	%eax
	movl	%eax, -8(%rbp)
	cmpl	-20(%rbp), %eax
	jge	.LBB97_6
# BB#5:                                 # %land.lhs.true
                                        #   in Loop: Header=BB97_3 Depth=1
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	je	.LBB97_20
.LBB97_6:                               # %if.else
                                        #   in Loop: Header=BB97_3 Depth=1
	movl	-8(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB97_8
# BB#7:                                 # %if.then20
                                        #   in Loop: Header=BB97_3 Depth=1
	movslq	-4(%rbp), %rax
	movl	bl_tree(,%rax,4), %ecx
	addl	-8(%rbp), %ecx
	movw	%cx, bl_tree(,%rax,4)
	jmp	.LBB97_15
	.p2align	4, 0x90
.LBB97_8:                               # %if.else26
                                        #   in Loop: Header=BB97_3 Depth=1
	cmpl	$0, -4(%rbp)
	je	.LBB97_12
# BB#9:                                 # %if.then29
                                        #   in Loop: Header=BB97_3 Depth=1
	movl	-4(%rbp), %eax
	cmpl	-28(%rbp), %eax
	je	.LBB97_11
# BB#10:                                # %if.then32
                                        #   in Loop: Header=BB97_3 Depth=1
	movslq	-4(%rbp), %rax
	incw	bl_tree(,%rax,4)
.LBB97_11:                              # %if.end38
                                        #   in Loop: Header=BB97_3 Depth=1
	incw	bl_tree+64(%rip)
	jmp	.LBB97_15
.LBB97_12:                              # %if.else40
                                        #   in Loop: Header=BB97_3 Depth=1
	cmpl	$10, -8(%rbp)
	jg	.LBB97_14
# BB#13:                                # %if.then43
                                        #   in Loop: Header=BB97_3 Depth=1
	incw	bl_tree+68(%rip)
	jmp	.LBB97_15
.LBB97_14:                              # %if.else45
                                        #   in Loop: Header=BB97_3 Depth=1
	incw	bl_tree+72(%rip)
	.p2align	4, 0x90
.LBB97_15:                              # %if.end50
                                        #   in Loop: Header=BB97_3 Depth=1
	movl	$0, -8(%rbp)
	movl	-4(%rbp), %eax
	movl	%eax, -28(%rbp)
	cmpl	$0, -12(%rbp)
	je	.LBB97_16
# BB#17:                                # %if.else54
                                        #   in Loop: Header=BB97_3 Depth=1
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jne	.LBB97_19
# BB#18:                                # %if.then57
                                        #   in Loop: Header=BB97_3 Depth=1
	movl	$6, -20(%rbp)
	movl	$3, -16(%rbp)
	incl	-24(%rbp)
	jmp	.LBB97_3
	.p2align	4, 0x90
.LBB97_16:                              # %if.then53
                                        #   in Loop: Header=BB97_3 Depth=1
	movl	$138, -20(%rbp)
	movl	$3, -16(%rbp)
	incl	-24(%rbp)
	jmp	.LBB97_3
	.p2align	4, 0x90
.LBB97_19:                              # %if.else58
                                        #   in Loop: Header=BB97_3 Depth=1
	movl	$7, -20(%rbp)
	movl	$4, -16(%rbp)
	jmp	.LBB97_20
.LBB97_21:                              # %for.end
	popq	%rbp
	retq
.Lfunc_end97:
	.size	scan_tree, .Lfunc_end97-scan_tree
	.cfi_endproc

	.p2align	4, 0x90
	.type	send_tree,@function
send_tree:                              # @send_tree
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
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movl	%esi, -32(%rbp)
	movl	$-1, -28(%rbp)
	movq	-40(%rbp), %rax
	movzwl	2(%rax), %eax
	movl	%eax, -12(%rbp)
	movl	$0, -4(%rbp)
	movl	$7, -20(%rbp)
	movl	$4, -16(%rbp)
	cmpl	$0, -12(%rbp)
	jne	.LBB98_2
# BB#1:                                 # %if.then
	movl	$138, -20(%rbp)
	movl	$3, -16(%rbp)
.LBB98_2:                               # %if.end
	movl	$0, -24(%rbp)
	jmp	.LBB98_3
	.p2align	4, 0x90
.LBB98_21:                              # %for.inc
                                        #   in Loop: Header=BB98_3 Depth=1
	incl	-24(%rbp)
.LBB98_3:                               # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB98_7 Depth 2
	movl	-24(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jg	.LBB98_22
# BB#4:                                 # %for.body
                                        #   in Loop: Header=BB98_3 Depth=1
	movl	-12(%rbp), %eax
	movl	%eax, -8(%rbp)
	movq	-40(%rbp), %rax
	movslq	-24(%rbp), %rcx
	movzwl	6(%rax,%rcx,4), %eax
	movl	%eax, -12(%rbp)
	movl	-4(%rbp), %eax
	incl	%eax
	movl	%eax, -4(%rbp)
	cmpl	-20(%rbp), %eax
	jge	.LBB98_6
# BB#5:                                 # %land.lhs.true
                                        #   in Loop: Header=BB98_3 Depth=1
	movl	-8(%rbp), %eax
	cmpl	-12(%rbp), %eax
	je	.LBB98_21
.LBB98_6:                               # %if.else
                                        #   in Loop: Header=BB98_3 Depth=1
	movl	-4(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB98_8
	.p2align	4, 0x90
.LBB98_7:                               # %do.cond
                                        #   Parent Loop BB98_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	-8(%rbp), %rax
	movzwl	bl_tree(,%rax,4), %edi
	movzwl	bl_tree+2(,%rax,4), %esi
	callq	send_bits
	decl	-4(%rbp)
	jne	.LBB98_7
	jmp	.LBB98_16
	.p2align	4, 0x90
.LBB98_8:                               # %if.else26
                                        #   in Loop: Header=BB98_3 Depth=1
	cmpl	$0, -8(%rbp)
	je	.LBB98_12
# BB#9:                                 # %if.then29
                                        #   in Loop: Header=BB98_3 Depth=1
	movl	-8(%rbp), %eax
	cmpl	-28(%rbp), %eax
	je	.LBB98_11
# BB#10:                                # %if.then32
                                        #   in Loop: Header=BB98_3 Depth=1
	movslq	-8(%rbp), %rax
	movzwl	bl_tree(,%rax,4), %edi
	movzwl	bl_tree+2(,%rax,4), %esi
	callq	send_bits
	decl	-4(%rbp)
.LBB98_11:                              # %if.end44
                                        #   in Loop: Header=BB98_3 Depth=1
	movzwl	bl_tree+64(%rip), %edi
	movzwl	bl_tree+66(%rip), %esi
	callq	send_bits
	movl	-4(%rbp), %edi
	addl	$-3, %edi
	movl	$2, %esi
	jmp	.LBB98_15
.LBB98_12:                              # %if.else47
                                        #   in Loop: Header=BB98_3 Depth=1
	cmpl	$10, -4(%rbp)
	jg	.LBB98_14
# BB#13:                                # %if.then50
                                        #   in Loop: Header=BB98_3 Depth=1
	movzwl	bl_tree+68(%rip), %edi
	movzwl	bl_tree+70(%rip), %esi
	callq	send_bits
	movl	-4(%rbp), %edi
	addl	$-3, %edi
	movl	$3, %esi
	jmp	.LBB98_15
.LBB98_14:                              # %if.else54
                                        #   in Loop: Header=BB98_3 Depth=1
	movzwl	bl_tree+72(%rip), %edi
	movzwl	bl_tree+74(%rip), %esi
	callq	send_bits
	movl	-4(%rbp), %edi
	addl	$-11, %edi
	movl	$7, %esi
	.p2align	4, 0x90
.LBB98_15:                              # %if.end61
                                        #   in Loop: Header=BB98_3 Depth=1
	callq	send_bits
.LBB98_16:                              # %if.end61
                                        #   in Loop: Header=BB98_3 Depth=1
	movl	$0, -4(%rbp)
	movl	-8(%rbp), %eax
	movl	%eax, -28(%rbp)
	cmpl	$0, -12(%rbp)
	je	.LBB98_17
# BB#18:                                # %if.else65
                                        #   in Loop: Header=BB98_3 Depth=1
	movl	-8(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jne	.LBB98_20
# BB#19:                                # %if.then68
                                        #   in Loop: Header=BB98_3 Depth=1
	movl	$6, -20(%rbp)
	movl	$3, -16(%rbp)
	incl	-24(%rbp)
	jmp	.LBB98_3
	.p2align	4, 0x90
.LBB98_17:                              # %if.then64
                                        #   in Loop: Header=BB98_3 Depth=1
	movl	$138, -20(%rbp)
	movl	$3, -16(%rbp)
	incl	-24(%rbp)
	jmp	.LBB98_3
	.p2align	4, 0x90
.LBB98_20:                              # %if.else69
                                        #   in Loop: Header=BB98_3 Depth=1
	movl	$7, -20(%rbp)
	movl	$4, -16(%rbp)
	jmp	.LBB98_21
.LBB98_22:                              # %for.end
	addq	$48, %rsp
	popq	%rbp
	retq
.Lfunc_end98:
	.size	send_tree, .Lfunc_end98-send_tree
	.cfi_endproc

	.p2align	4, 0x90
	.type	huf_decode_start,@function
huf_decode_start:                       # @huf_decode_start
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
	callq	init_getbits
	movl	$0, blocksize(%rip)
	popq	%rbp
	retq
.Lfunc_end99:
	.size	huf_decode_start, .Lfunc_end99-huf_decode_start
	.cfi_endproc

	.p2align	4, 0x90
	.type	init_getbits,@function
init_getbits:                           # @init_getbits
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
	movw	$0, io_bitbuf(%rip)
	movl	$0, subbitbuf(%rip)
	movl	$0, bitcount(%rip)
	movl	$16, %edi
	callq	fillbuf
	popq	%rbp
	retq
.Lfunc_end100:
	.size	init_getbits, .Lfunc_end100-init_getbits
	.cfi_endproc

	.p2align	4, 0x90
	.type	fillbuf,@function
fillbuf:                                # @fillbuf
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi332:
	.cfi_def_cfa_offset 16
.Lcfi333:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi334:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movb	-4(%rbp), %cl
	movzwl	io_bitbuf(%rip), %eax
	shll	%cl, %eax
	movw	%ax, io_bitbuf(%rip)
	jmp	.LBB101_1
	.p2align	4, 0x90
.LBB101_7:                              # %if.end
                                        #   in Loop: Header=BB101_1 Depth=1
	movl	$8, bitcount(%rip)
.LBB101_1:                              # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	bitcount(%rip), %eax
	jle	.LBB101_8
# BB#2:                                 # %while.body
                                        #   in Loop: Header=BB101_1 Depth=1
	movl	subbitbuf(%rip), %eax
	movl	-4(%rbp), %ecx
	subl	bitcount(%rip), %ecx
	movl	%ecx, -4(%rbp)
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shll	%cl, %eax
	movzwl	io_bitbuf(%rip), %ecx
	orl	%eax, %ecx
	movw	%cx, io_bitbuf(%rip)
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB101_4
# BB#3:                                 # %cond.true
                                        #   in Loop: Header=BB101_1 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, -12(%rbp)
	jmp	.LBB101_5
	.p2align	4, 0x90
.LBB101_4:                              # %cond.false
                                        #   in Loop: Header=BB101_1 Depth=1
	movl	$1, %edi
	callq	fill_inbuf
	movl	%eax, -16(%rbp)
.LBB101_5:                              # %cond.end
                                        #   in Loop: Header=BB101_1 Depth=1
	movl	%eax, -8(%rbp)
	movl	-8(%rbp), %eax
	movl	%eax, subbitbuf(%rip)
	cmpl	$-1, %eax
	jne	.LBB101_7
# BB#6:                                 # %if.then
                                        #   in Loop: Header=BB101_1 Depth=1
	movl	$0, subbitbuf(%rip)
	jmp	.LBB101_7
.LBB101_8:                              # %while.end
	movl	subbitbuf(%rip), %eax
	movl	bitcount(%rip), %ecx
	subl	-4(%rbp), %ecx
	movl	%ecx, bitcount(%rip)
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzwl	io_bitbuf(%rip), %ecx
	orl	%eax, %ecx
	movw	%cx, io_bitbuf(%rip)
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end101:
	.size	fillbuf, .Lfunc_end101-fillbuf
	.cfi_endproc

	.p2align	4, 0x90
	.type	decode_c,@function
decode_c:                               # @decode_c
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi335:
	.cfi_def_cfa_offset 16
.Lcfi336:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi337:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	cmpl	$0, blocksize(%rip)
	jne	.LBB102_4
# BB#1:                                 # %if.then
	movl	$16, %edi
	callq	getbits
	movl	%eax, blocksize(%rip)
	testl	%eax, %eax
	je	.LBB102_2
# BB#3:                                 # %if.end
	movl	$19, %edi
	movl	$5, %esi
	movl	$3, %edx
	callq	read_pt_len
	callq	read_c_len
	movl	$14, %edi
	movl	$4, %esi
	movl	$-1, %edx
	callq	read_pt_len
.LBB102_4:                              # %if.end3
	decl	blocksize(%rip)
	movzwl	io_bitbuf(%rip), %eax
	shrq	$4, %rax
	movzwl	d_buf(%rax,%rax), %eax
	cmpl	$510, %eax              # imm = 0x1FE
	movl	%eax, -4(%rbp)
	jb	.LBB102_10
# BB#5:                                 # %if.then7
	movl	$8, -8(%rbp)
	.p2align	4, 0x90
.LBB102_6:                              # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movzwl	io_bitbuf(%rip), %eax
	testl	-8(%rbp), %eax
	je	.LBB102_8
# BB#7:                                 # %if.then9
                                        #   in Loop: Header=BB102_6 Depth=1
	movl	-4(%rbp), %eax
	movzwl	prev+65536(%rax,%rax), %eax
	jmp	.LBB102_9
	.p2align	4, 0x90
.LBB102_8:                              # %if.else
                                        #   in Loop: Header=BB102_6 Depth=1
	movl	-4(%rbp), %eax
	movzwl	prev(%rax,%rax), %eax
.LBB102_9:                              # %do.cond
                                        #   in Loop: Header=BB102_6 Depth=1
	movl	%eax, -4(%rbp)
	shrl	-8(%rbp)
	cmpl	$509, -4(%rbp)          # imm = 0x1FD
	ja	.LBB102_6
.LBB102_10:                             # %if.end20
	movl	-4(%rbp), %eax
	movzbl	outbuf(%rax), %edi
	callq	fillbuf
	movl	-4(%rbp), %eax
	movl	%eax, -12(%rbp)
.LBB102_11:                             # %return
	movl	-12(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	retq
.LBB102_2:                              # %if.then2
	movl	$510, -12(%rbp)         # imm = 0x1FE
	jmp	.LBB102_11
.Lfunc_end102:
	.size	decode_c, .Lfunc_end102-decode_c
	.cfi_endproc

	.p2align	4, 0x90
	.type	decode_p,@function
decode_p:                               # @decode_p
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi338:
	.cfi_def_cfa_offset 16
.Lcfi339:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi340:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi341:
	.cfi_offset %rbx, -24
	movzwl	io_bitbuf(%rip), %eax
	movzbl	%ah, %eax  # NOREX
	movzwl	pt_table(%rax,%rax), %eax
	cmpl	$14, %eax
	movl	%eax, -12(%rbp)
	jb	.LBB103_6
# BB#1:                                 # %if.then
	movl	$128, -16(%rbp)
	.p2align	4, 0x90
.LBB103_2:                              # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movzwl	io_bitbuf(%rip), %eax
	testl	-16(%rbp), %eax
	je	.LBB103_4
# BB#3:                                 # %if.then4
                                        #   in Loop: Header=BB103_2 Depth=1
	movl	-12(%rbp), %eax
	movzwl	prev+65536(%rax,%rax), %eax
	jmp	.LBB103_5
	.p2align	4, 0x90
.LBB103_4:                              # %if.else
                                        #   in Loop: Header=BB103_2 Depth=1
	movl	-12(%rbp), %eax
	movzwl	prev(%rax,%rax), %eax
.LBB103_5:                              # %do.cond
                                        #   in Loop: Header=BB103_2 Depth=1
	movl	%eax, -12(%rbp)
	shrl	-16(%rbp)
	cmpl	$13, -12(%rbp)
	ja	.LBB103_2
.LBB103_6:                              # %if.end14
	movl	-12(%rbp), %eax
	movzbl	pt_len(%rax), %edi
	callq	fillbuf
	cmpl	$0, -12(%rbp)
	je	.LBB103_8
# BB#7:                                 # %if.then20
	movl	-12(%rbp), %edi
	decl	%edi
	movl	$1, %ebx
	movl	%edi, %ecx
	shll	%cl, %ebx
	callq	getbits
	addl	%ebx, %eax
	movl	%eax, -12(%rbp)
.LBB103_8:                              # %if.end22
	movl	-12(%rbp), %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end103:
	.size	decode_p, .Lfunc_end103-decode_p
	.cfi_endproc

	.p2align	4, 0x90
	.type	getbits,@function
getbits:                                # @getbits
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
	subq	$16, %rsp
	movl	%edi, -8(%rbp)
	movzwl	io_bitbuf(%rip), %eax
	movl	$16, %ecx
	subl	%edi, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movl	%eax, -4(%rbp)
	movl	-8(%rbp), %edi
	callq	fillbuf
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end104:
	.size	getbits, .Lfunc_end104-getbits
	.cfi_endproc

	.p2align	4, 0x90
	.type	read_pt_len,@function
read_pt_len:                            # @read_pt_len
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
	subq	$48, %rsp
	movl	%edi, -12(%rbp)
	movl	%esi, -24(%rbp)
	movl	%edx, -32(%rbp)
	movl	-24(%rbp), %edi
	callq	getbits
	movl	%eax, -28(%rbp)
	testl	%eax, %eax
	je	.LBB105_1
# BB#7:                                 # %if.else
	movl	$0, -4(%rbp)
	jmp	.LBB105_8
	.p2align	4, 0x90
.LBB105_9:                              # %while.body
                                        #   in Loop: Header=BB105_8 Depth=1
	movzwl	io_bitbuf(%rip), %eax
	shrl	$13, %eax
	movl	%eax, -8(%rbp)
	cmpl	$7, %eax
	jne	.LBB105_13
# BB#10:                                # %if.then16
                                        #   in Loop: Header=BB105_8 Depth=1
	movl	$4096, -20(%rbp)        # imm = 0x1000
	jmp	.LBB105_11
	.p2align	4, 0x90
.LBB105_12:                             # %while.body19
                                        #   in Loop: Header=BB105_11 Depth=2
	shrl	-20(%rbp)
	incl	-8(%rbp)
.LBB105_11:                             # %while.cond17
                                        #   Parent Loop BB105_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzwl	io_bitbuf(%rip), %eax
	testl	-20(%rbp), %eax
	jne	.LBB105_12
.LBB105_13:                             # %if.end
                                        #   in Loop: Header=BB105_8 Depth=1
	cmpl	$6, -8(%rbp)
	jg	.LBB105_15
# BB#14:                                # %cond.true
                                        #   in Loop: Header=BB105_8 Depth=1
	movl	$3, -16(%rbp)
	jmp	.LBB105_16
	.p2align	4, 0x90
.LBB105_15:                             # %cond.false
                                        #   in Loop: Header=BB105_8 Depth=1
	movl	-8(%rbp), %eax
	addl	$-3, %eax
	movl	%eax, -36(%rbp)
	movl	%eax, -16(%rbp)
.LBB105_16:                             # %cond.end
                                        #   in Loop: Header=BB105_8 Depth=1
	movl	-16(%rbp), %edi
	callq	fillbuf
	movb	-8(%rbp), %al
	movslq	-4(%rbp), %rcx
	leal	1(%rcx), %edx
	movl	%edx, -4(%rbp)
	movb	%al, pt_len(%rcx)
	movl	-4(%rbp), %eax
	cmpl	-32(%rbp), %eax
	jne	.LBB105_8
# BB#17:                                # %if.then30
                                        #   in Loop: Header=BB105_8 Depth=1
	movl	$2, %edi
	callq	getbits
	movl	%eax, -8(%rbp)
	decl	-8(%rbp)
	js	.LBB105_8
	.p2align	4, 0x90
.LBB105_19:                             # %while.body35
                                        #   Parent Loop BB105_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	-4(%rbp), %rax
	leal	1(%rax), %ecx
	movl	%ecx, -4(%rbp)
	movb	$0, pt_len(%rax)
	decl	-8(%rbp)
	jns	.LBB105_19
.LBB105_8:                              # %while.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB105_11 Depth 2
                                        #     Child Loop BB105_19 Depth 2
	movl	-4(%rbp), %eax
	cmpl	-28(%rbp), %eax
	jl	.LBB105_9
	jmp	.LBB105_20
	.p2align	4, 0x90
.LBB105_21:                             # %while.body45
                                        #   in Loop: Header=BB105_20 Depth=1
	movslq	-4(%rbp), %rax
	leal	1(%rax), %ecx
	movl	%ecx, -4(%rbp)
	movb	$0, pt_len(%rax)
.LBB105_20:                             # %while.cond42
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jl	.LBB105_21
# BB#22:                                # %while.end49
	movl	-12(%rbp), %edi
	movl	$pt_len, %esi
	movl	$8, %edx
	movl	$pt_table, %ecx
	callq	make_table
	jmp	.LBB105_23
.LBB105_1:                              # %if.then
	movl	-24(%rbp), %edi
	callq	getbits
	movl	%eax, -8(%rbp)
	movl	$0, -4(%rbp)
	jmp	.LBB105_2
	.p2align	4, 0x90
.LBB105_3:                              # %for.inc
                                        #   in Loop: Header=BB105_2 Depth=1
	movslq	-4(%rbp), %rax
	movb	$0, pt_len(%rax)
	incl	-4(%rbp)
.LBB105_2:                              # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-12(%rbp), %eax
	jl	.LBB105_3
# BB#4:                                 # %for.end
	movl	$0, -4(%rbp)
	cmpl	$255, -4(%rbp)
	jg	.LBB105_23
	.p2align	4, 0x90
.LBB105_6:                              # %for.inc8
                                        # =>This Inner Loop Header: Depth=1
	movzwl	-8(%rbp), %eax
	movslq	-4(%rbp), %rcx
	movw	%ax, pt_table(%rcx,%rcx)
	incl	-4(%rbp)
	cmpl	$255, -4(%rbp)
	jle	.LBB105_6
.LBB105_23:                             # %if.end50
	addq	$48, %rsp
	popq	%rbp
	retq
.Lfunc_end105:
	.size	read_pt_len, .Lfunc_end105-read_pt_len
	.cfi_endproc

	.p2align	4, 0x90
	.type	read_c_len,@function
read_c_len:                             # @read_c_len
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
	subq	$16, %rsp
	movl	$9, %edi
	callq	getbits
	movl	%eax, -16(%rbp)
	testl	%eax, %eax
	je	.LBB106_1
# BB#7:                                 # %if.else
	movl	$0, -8(%rbp)
	jmp	.LBB106_8
	.p2align	4, 0x90
.LBB106_15:                             # %if.end32
                                        #   in Loop: Header=BB106_8 Depth=1
	movslq	-4(%rbp), %rax
	movzbl	pt_len(%rax), %edi
	callq	fillbuf
	cmpl	$2, -4(%rbp)
	jg	.LBB106_24
# BB#16:                                # %if.then38
                                        #   in Loop: Header=BB106_8 Depth=1
	cmpl	$0, -4(%rbp)
	je	.LBB106_17
# BB#18:                                # %if.else42
                                        #   in Loop: Header=BB106_8 Depth=1
	cmpl	$1, -4(%rbp)
	jne	.LBB106_20
# BB#19:                                # %if.then45
                                        #   in Loop: Header=BB106_8 Depth=1
	movl	$4, %edi
	callq	getbits
	addl	$3, %eax
	jmp	.LBB106_21
.LBB106_17:                             # %if.then41
                                        #   in Loop: Header=BB106_8 Depth=1
	movl	$1, -4(%rbp)
	decl	-4(%rbp)
	jns	.LBB106_23
	jmp	.LBB106_8
.LBB106_20:                             # %if.else47
                                        #   in Loop: Header=BB106_8 Depth=1
	movl	$9, %edi
	callq	getbits
	addl	$20, %eax
.LBB106_21:                             # %if.end51
                                        #   in Loop: Header=BB106_8 Depth=1
	movl	%eax, -4(%rbp)
	decl	-4(%rbp)
	js	.LBB106_8
	.p2align	4, 0x90
.LBB106_23:                             # %while.body55
                                        #   Parent Loop BB106_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	-8(%rbp), %rax
	leal	1(%rax), %ecx
	movl	%ecx, -8(%rbp)
	movb	$0, outbuf(%rax)
	decl	-4(%rbp)
	jns	.LBB106_23
	jmp	.LBB106_8
	.p2align	4, 0x90
.LBB106_24:                             # %if.else59
                                        #   in Loop: Header=BB106_8 Depth=1
	movl	-4(%rbp), %eax
	addl	$-2, %eax
	movslq	-8(%rbp), %rcx
	leal	1(%rcx), %edx
	movl	%edx, -8(%rbp)
	movb	%al, outbuf(%rcx)
.LBB106_8:                              # %while.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB106_11 Depth 2
                                        #     Child Loop BB106_23 Depth 2
	movl	-8(%rbp), %eax
	cmpl	-16(%rbp), %eax
	jge	.LBB106_25
# BB#9:                                 # %while.body
                                        #   in Loop: Header=BB106_8 Depth=1
	movzwl	io_bitbuf(%rip), %eax
	movzbl	%ah, %eax  # NOREX
	movzwl	pt_table(%rax,%rax), %eax
	movl	%eax, -4(%rbp)
	cmpl	$19, %eax
	jl	.LBB106_15
# BB#10:                                # %if.then19
                                        #   in Loop: Header=BB106_8 Depth=1
	movl	$128, -12(%rbp)
	.p2align	4, 0x90
.LBB106_11:                             # %do.body
                                        #   Parent Loop BB106_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzwl	io_bitbuf(%rip), %eax
	testl	-12(%rbp), %eax
	je	.LBB106_13
# BB#12:                                # %if.then21
                                        #   in Loop: Header=BB106_11 Depth=2
	movslq	-4(%rbp), %rax
	movzwl	prev+65536(%rax,%rax), %eax
	jmp	.LBB106_14
	.p2align	4, 0x90
.LBB106_13:                             # %if.else25
                                        #   in Loop: Header=BB106_11 Depth=2
	movslq	-4(%rbp), %rax
	movzwl	prev(%rax,%rax), %eax
.LBB106_14:                             # %do.cond
                                        #   in Loop: Header=BB106_11 Depth=2
	movl	%eax, -4(%rbp)
	shrl	-12(%rbp)
	cmpl	$18, -4(%rbp)
	jg	.LBB106_11
	jmp	.LBB106_15
	.p2align	4, 0x90
.LBB106_26:                             # %while.body69
                                        #   in Loop: Header=BB106_25 Depth=1
	movslq	-8(%rbp), %rax
	leal	1(%rax), %ecx
	movl	%ecx, -8(%rbp)
	movb	$0, outbuf(%rax)
.LBB106_25:                             # %while.cond66
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$509, -8(%rbp)          # imm = 0x1FD
	jle	.LBB106_26
# BB#27:                                # %while.end73
	movl	$510, %edi              # imm = 0x1FE
	movl	$outbuf, %esi
	movl	$12, %edx
	movl	$d_buf, %ecx
	callq	make_table
	jmp	.LBB106_28
.LBB106_1:                              # %if.then
	movl	$9, %edi
	callq	getbits
	movl	%eax, -4(%rbp)
	movl	$0, -8(%rbp)
	cmpl	$509, -8(%rbp)          # imm = 0x1FD
	jg	.LBB106_4
	.p2align	4, 0x90
.LBB106_3:                              # %for.inc
                                        # =>This Inner Loop Header: Depth=1
	movslq	-8(%rbp), %rax
	movb	$0, outbuf(%rax)
	incl	-8(%rbp)
	cmpl	$509, -8(%rbp)          # imm = 0x1FD
	jle	.LBB106_3
.LBB106_4:                              # %for.end
	movl	$0, -8(%rbp)
	cmpl	$4095, -8(%rbp)         # imm = 0xFFF
	jg	.LBB106_28
	.p2align	4, 0x90
.LBB106_6:                              # %for.inc8
                                        # =>This Inner Loop Header: Depth=1
	movzwl	-4(%rbp), %eax
	movslq	-8(%rbp), %rcx
	movw	%ax, d_buf(%rcx,%rcx)
	incl	-8(%rbp)
	cmpl	$4095, -8(%rbp)         # imm = 0xFFF
	jle	.LBB106_6
.LBB106_28:                             # %if.end74
	addq	$16, %rsp
	popq	%rbp
	retq
.Lfunc_end106:
	.size	read_c_len, .Lfunc_end106-read_c_len
	.cfi_endproc

	.p2align	4, 0x90
	.type	make_table,@function
make_table:                             # @make_table
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi351:
	.cfi_def_cfa_offset 16
.Lcfi352:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi353:
	.cfi_def_cfa_register %rbp
	subq	$208, %rsp
	movl	%edi, -40(%rbp)
	movq	%rsi, -72(%rbp)
	movl	%edx, -8(%rbp)
	movq	%rcx, -56(%rbp)
	movl	$1, -4(%rbp)
	cmpl	$16, -4(%rbp)
	ja	.LBB107_3
	.p2align	4, 0x90
.LBB107_2:                              # %for.inc
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	movw	$0, -208(%rbp,%rax,2)
	incl	-4(%rbp)
	cmpl	$16, -4(%rbp)
	jbe	.LBB107_2
.LBB107_3:                              # %for.end
	movl	$0, -4(%rbp)
	jmp	.LBB107_4
	.p2align	4, 0x90
.LBB107_5:                              # %for.inc9
                                        #   in Loop: Header=BB107_4 Depth=1
	movq	-72(%rbp), %rax
	movl	-4(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	incw	-208(%rbp,%rax,2)
	incl	-4(%rbp)
.LBB107_4:                              # %for.cond1
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jb	.LBB107_5
# BB#6:                                 # %for.end11
	movw	$0, -110(%rbp)
	movl	$1, -4(%rbp)
	cmpl	$16, -4(%rbp)
	ja	.LBB107_9
	.p2align	4, 0x90
.LBB107_8:                              # %for.inc25
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	movzwl	-112(%rbp,%rax,2), %edx
	movzwl	-208(%rbp,%rax,2), %esi
	movl	$16, %ecx
	subl	%eax, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shll	%cl, %esi
	addl	%edx, %esi
	leal	1(%rax), %eax
	movw	%si, -112(%rbp,%rax,2)
	incl	-4(%rbp)
	cmpl	$16, -4(%rbp)
	jbe	.LBB107_8
.LBB107_9:                              # %for.end27
	cmpw	$0, -78(%rbp)
	je	.LBB107_11
# BB#10:                                # %if.then
	movl	$.L.str.197, %edi
	callq	error
.LBB107_11:                             # %if.end
	movl	$16, %eax
	subl	-8(%rbp), %eax
	movl	%eax, -36(%rbp)
	movl	$1, -4(%rbp)
	jmp	.LBB107_12
	.p2align	4, 0x90
.LBB107_13:                             # %for.inc46
                                        #   in Loop: Header=BB107_12 Depth=1
	movzbl	-36(%rbp), %ecx
	movl	-4(%rbp), %eax
	movzwl	-112(%rbp,%rax,2), %edx
	shrl	%cl, %edx
	movw	%dx, -112(%rbp,%rax,2)
	movl	-8(%rbp), %ecx
	movl	-4(%rbp), %eax
	subl	%eax, %ecx
	movl	$1, %edx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shll	%cl, %edx
	movw	%dx, -160(%rbp,%rax,2)
	incl	-4(%rbp)
.LBB107_12:                             # %for.cond33
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-8(%rbp), %eax
	jbe	.LBB107_13
	jmp	.LBB107_14
	.p2align	4, 0x90
.LBB107_15:                             # %while.body
                                        #   in Loop: Header=BB107_14 Depth=1
	movl	-4(%rbp), %eax
	movl	$16, %ecx
	subl	%eax, %ecx
	movl	$1, %edx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shll	%cl, %edx
	movw	%dx, -160(%rbp,%rax,2)
	incl	-4(%rbp)
.LBB107_14:                             # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$16, -4(%rbp)
	jbe	.LBB107_15
# BB#16:                                # %while.end
	movslq	-8(%rbp), %rax
	movzwl	-110(%rbp,%rax,2), %eax
	movb	-36(%rbp), %cl
	shrl	%cl, %eax
	movl	%eax, -4(%rbp)
	testl	%eax, %eax
	je	.LBB107_20
# BB#17:                                # %if.then64
	movb	-8(%rbp), %cl
	movl	$1, %eax
	shll	%cl, %eax
	movl	%eax, -24(%rbp)
	jmp	.LBB107_18
	.p2align	4, 0x90
.LBB107_19:                             # %while.body69
                                        #   in Loop: Header=BB107_18 Depth=1
	movq	-56(%rbp), %rax
	movl	-4(%rbp), %ecx
	leal	1(%rcx), %edx
	movl	%edx, -4(%rbp)
	movw	$0, (%rax,%rcx,2)
.LBB107_18:                             # %while.cond66
                                        # =>This Inner Loop Header: Depth=1
	movl	-4(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jne	.LBB107_19
.LBB107_20:                             # %if.end74
	movl	-40(%rbp), %eax
	movl	%eax, -20(%rbp)
	movl	$15, %ecx
	subl	-8(%rbp), %ecx
	movl	$1, %eax
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shll	%cl, %eax
	movl	%eax, -60(%rbp)
	movl	$0, -16(%rbp)
	jmp	.LBB107_21
	.p2align	4, 0x90
.LBB107_37:                             # %for.inc148
                                        #   in Loop: Header=BB107_21 Depth=1
	incl	-16(%rbp)
.LBB107_21:                             # %for.cond77
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB107_29 Depth 2
                                        #     Child Loop BB107_25 Depth 2
	movl	-16(%rbp), %eax
	cmpl	-40(%rbp), %eax
	jae	.LBB107_38
# BB#22:                                # %for.body80
                                        #   in Loop: Header=BB107_21 Depth=1
	movq	-72(%rbp), %rax
	movl	-16(%rbp), %ecx
	movzbl	(%rax,%rcx), %eax
	testl	%eax, %eax
	movl	%eax, -12(%rbp)
	je	.LBB107_37
# BB#23:                                # %if.end87
                                        #   in Loop: Header=BB107_21 Depth=1
	movl	-12(%rbp), %eax
	movzwl	-112(%rbp,%rax,2), %ecx
	movzwl	-160(%rbp,%rax,2), %eax
	addl	%ecx, %eax
	movl	%eax, -44(%rbp)
	movl	-12(%rbp), %eax
	cmpl	-8(%rbp), %eax
	ja	.LBB107_27
# BB#24:                                # %if.then97
                                        #   in Loop: Header=BB107_21 Depth=1
	movl	-12(%rbp), %eax
	movzwl	-112(%rbp,%rax,2), %eax
	movl	%eax, -4(%rbp)
	jmp	.LBB107_25
	.p2align	4, 0x90
.LBB107_26:                             # %for.inc108
                                        #   in Loop: Header=BB107_25 Depth=2
	movzwl	-16(%rbp), %eax
	movq	-56(%rbp), %rcx
	movl	-4(%rbp), %edx
	movw	%ax, (%rcx,%rdx,2)
	incl	-4(%rbp)
.LBB107_25:                             # %for.cond101
                                        #   Parent Loop BB107_21 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-4(%rbp), %eax
	cmpl	-44(%rbp), %eax
	jb	.LBB107_26
	jmp	.LBB107_36
	.p2align	4, 0x90
.LBB107_27:                             # %if.else
                                        #   in Loop: Header=BB107_21 Depth=1
	movl	-12(%rbp), %eax
	movzwl	-112(%rbp,%rax,2), %eax
	movl	%eax, -24(%rbp)
	movb	-36(%rbp), %cl
	shrl	%cl, %eax
	addq	%rax, %rax
	addq	-56(%rbp), %rax
	movq	%rax, -32(%rbp)
	movl	-12(%rbp), %eax
	subl	-8(%rbp), %eax
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	jne	.LBB107_29
	jmp	.LBB107_35
	.p2align	4, 0x90
.LBB107_34:                             # %if.end140
                                        #   in Loop: Header=BB107_29 Depth=2
	movq	%rax, -32(%rbp)
	shll	-24(%rbp)
	decl	-4(%rbp)
	cmpl	$0, -4(%rbp)
	je	.LBB107_35
.LBB107_29:                             # %while.body121
                                        #   Parent Loop BB107_21 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	-32(%rbp), %rax
	cmpw	$0, (%rax)
	jne	.LBB107_31
# BB#30:                                # %if.then125
                                        #   in Loop: Header=BB107_29 Depth=2
	movl	-20(%rbp), %eax
	movw	$0, prev(%rax,%rax)
	movl	-20(%rbp), %eax
	movw	$0, prev+65536(%rax,%rax)
	movl	-20(%rbp), %eax
	leal	1(%rax), %ecx
	movl	%ecx, -20(%rbp)
	movq	-32(%rbp), %rcx
	movw	%ax, (%rcx)
.LBB107_31:                             # %if.end132
                                        #   in Loop: Header=BB107_29 Depth=2
	movl	-24(%rbp), %eax
	testl	-60(%rbp), %eax
	je	.LBB107_33
# BB#32:                                # %if.then134
                                        #   in Loop: Header=BB107_29 Depth=2
	movq	-32(%rbp), %rax
	movzwl	(%rax), %eax
	leaq	prev+65536(%rax,%rax), %rax
	jmp	.LBB107_34
	.p2align	4, 0x90
.LBB107_33:                             # %if.else137
                                        #   in Loop: Header=BB107_29 Depth=2
	movq	-32(%rbp), %rax
	movzwl	(%rax), %eax
	leaq	prev(%rax,%rax), %rax
	jmp	.LBB107_34
	.p2align	4, 0x90
.LBB107_35:                             # %while.end142
                                        #   in Loop: Header=BB107_21 Depth=1
	movzwl	-16(%rbp), %eax
	movq	-32(%rbp), %rcx
	movw	%ax, (%rcx)
.LBB107_36:                             # %if.end144
                                        #   in Loop: Header=BB107_21 Depth=1
	movzwl	-44(%rbp), %eax
	movl	-12(%rbp), %ecx
	movw	%ax, -112(%rbp,%rcx,2)
	jmp	.LBB107_37
.LBB107_38:                             # %for.end150
	addq	$208, %rsp
	popq	%rbp
	retq
.Lfunc_end107:
	.size	make_table, .Lfunc_end107-make_table
	.cfi_endproc

	.type	zfile,@object           # @zfile
	.local	zfile
	.comm	zfile,4,4
	.type	bi_buf,@object          # @bi_buf
	.local	bi_buf
	.comm	bi_buf,2,2
	.type	bi_valid,@object        # @bi_valid
	.local	bi_valid
	.comm	bi_valid,4,4
	.type	read_buf,@object        # @read_buf
	.comm	read_buf,8,8
	.type	outcnt,@object          # @outcnt
	.comm	outcnt,4,4
	.type	window_size,@object     # @window_size
	.data
	.globl	window_size
	.p2align	3
window_size:
	.quad	65536                   # 0x10000
	.size	window_size, 8

	.type	.L.str,@object          # @.str
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str:
	.asciz	"bad pack level"
	.size	.L.str, 15

	.type	compr_level,@object     # @compr_level
	.local	compr_level
	.comm	compr_level,4,4
	.type	rsync_chunk_end,@object # @rsync_chunk_end
	.local	rsync_chunk_end
	.comm	rsync_chunk_end,8,8
	.type	rsync_sum,@object       # @rsync_sum
	.local	rsync_sum
	.comm	rsync_sum,8,8
	.type	configuration_table,@object # @configuration_table
	.data
	.p2align	4
configuration_table:
	.zero	8
	.short	4                       # 0x4
	.short	4                       # 0x4
	.short	8                       # 0x8
	.short	4                       # 0x4
	.short	4                       # 0x4
	.short	5                       # 0x5
	.short	16                      # 0x10
	.short	8                       # 0x8
	.short	4                       # 0x4
	.short	6                       # 0x6
	.short	32                      # 0x20
	.short	32                      # 0x20
	.short	4                       # 0x4
	.short	4                       # 0x4
	.short	16                      # 0x10
	.short	16                      # 0x10
	.short	8                       # 0x8
	.short	16                      # 0x10
	.short	32                      # 0x20
	.short	32                      # 0x20
	.short	8                       # 0x8
	.short	16                      # 0x10
	.short	128                     # 0x80
	.short	128                     # 0x80
	.short	8                       # 0x8
	.short	32                      # 0x20
	.short	128                     # 0x80
	.short	256                     # 0x100
	.short	32                      # 0x20
	.short	128                     # 0x80
	.short	258                     # 0x102
	.short	1024                    # 0x400
	.short	32                      # 0x20
	.short	258                     # 0x102
	.short	258                     # 0x102
	.short	4096                    # 0x1000
	.size	configuration_table, 80

	.type	max_lazy_match,@object  # @max_lazy_match
	.local	max_lazy_match
	.comm	max_lazy_match,4,4
	.type	good_match,@object      # @good_match
	.comm	good_match,4,4
	.type	nice_match,@object      # @nice_match
	.comm	nice_match,4,4
	.type	max_chain_length,@object # @max_chain_length
	.comm	max_chain_length,4,4
	.type	strstart,@object        # @strstart
	.comm	strstart,4,4
	.type	block_start,@object     # @block_start
	.comm	block_start,8,8
	.type	lookahead,@object       # @lookahead
	.local	lookahead
	.comm	lookahead,4,4
	.type	eofile,@object          # @eofile
	.local	eofile
	.comm	eofile,4,4
	.type	ins_h,@object           # @ins_h
	.local	ins_h
	.comm	ins_h,4,4
	.type	prev_length,@object     # @prev_length
	.comm	prev_length,4,4
	.type	match_start,@object     # @match_start
	.comm	match_start,4,4
	.type	rsync,@object           # @rsync
	.bss
	.globl	rsync
	.p2align	2
rsync:
	.long	0                       # 0x0
	.size	rsync, 4

	.type	optind,@object          # @optind
	.data
	.globl	optind
	.p2align	2
optind:
	.long	1                       # 0x1
	.size	optind, 4

	.type	opterr,@object          # @opterr
	.globl	opterr
	.p2align	2
opterr:
	.long	1                       # 0x1
	.size	opterr, 4

	.type	optopt,@object          # @optopt
	.globl	optopt
	.p2align	2
optopt:
	.long	63                      # 0x3f
	.size	optopt, 4

	.type	optarg,@object          # @optarg
	.comm	optarg,8,8
	.type	__getopt_initialized,@object # @__getopt_initialized
	.comm	__getopt_initialized,4,4
	.type	nextchar,@object        # @nextchar
	.local	nextchar
	.comm	nextchar,8,8
	.type	last_nonopt,@object     # @last_nonopt
	.local	last_nonopt
	.comm	last_nonopt,4,4
	.type	first_nonopt,@object    # @first_nonopt
	.local	first_nonopt
	.comm	first_nonopt,4,4
	.type	ordering,@object        # @ordering
	.local	ordering
	.comm	ordering,4,4
	.type	.L.str.1,@object        # @.str.1
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.1:
	.asciz	"--"
	.size	.L.str.1, 3

	.type	.L.str.2,@object        # @.str.2
.L.str.2:
	.asciz	"%s: option `%s' is ambiguous\n"
	.size	.L.str.2, 30

	.type	.L.str.3,@object        # @.str.3
.L.str.3:
	.asciz	"%s: option `--%s' doesn't allow an argument\n"
	.size	.L.str.3, 45

	.type	.L.str.4,@object        # @.str.4
.L.str.4:
	.asciz	"%s: option `%c%s' doesn't allow an argument\n"
	.size	.L.str.4, 45

	.type	.L.str.5,@object        # @.str.5
.L.str.5:
	.asciz	"%s: option `%s' requires an argument\n"
	.size	.L.str.5, 38

	.type	.L.str.6,@object        # @.str.6
.L.str.6:
	.asciz	"%s: unrecognized option `--%s'\n"
	.size	.L.str.6, 32

	.type	.L.str.7,@object        # @.str.7
.L.str.7:
	.asciz	"%s: unrecognized option `%c%s'\n"
	.size	.L.str.7, 32

	.type	.L.str.8,@object        # @.str.8
.L.str.8:
	.zero	1
	.size	.L.str.8, 1

	.type	posixly_correct,@object # @posixly_correct
	.local	posixly_correct
	.comm	posixly_correct,8,8
	.type	.L.str.9,@object        # @.str.9
.L.str.9:
	.asciz	"%s: illegal option -- %c\n"
	.size	.L.str.9, 26

	.type	.L.str.10,@object       # @.str.10
.L.str.10:
	.asciz	"%s: invalid option -- %c\n"
	.size	.L.str.10, 26

	.type	.L.str.11,@object       # @.str.11
.L.str.11:
	.asciz	"%s: option requires an argument -- %c\n"
	.size	.L.str.11, 39

	.type	.L.str.12,@object       # @.str.12
.L.str.12:
	.asciz	"%s: option `-W %s' is ambiguous\n"
	.size	.L.str.12, 33

	.type	.L.str.13,@object       # @.str.13
.L.str.13:
	.asciz	"%s: option `-W %s' doesn't allow an argument\n"
	.size	.L.str.13, 46

	.type	ascii,@object           # @ascii
	.bss
	.globl	ascii
	.p2align	2
ascii:
	.long	0                       # 0x0
	.size	ascii, 4

	.type	to_stdout,@object       # @to_stdout
	.globl	to_stdout
	.p2align	2
to_stdout:
	.long	0                       # 0x0
	.size	to_stdout, 4

	.type	decompress,@object      # @decompress
	.globl	decompress
	.p2align	2
decompress:
	.long	0                       # 0x0
	.size	decompress, 4

	.type	force,@object           # @force
	.globl	force
	.p2align	2
force:
	.long	0                       # 0x0
	.size	force, 4

	.type	no_name,@object         # @no_name
	.data
	.globl	no_name
	.p2align	2
no_name:
	.long	4294967295              # 0xffffffff
	.size	no_name, 4

	.type	no_time,@object         # @no_time
	.globl	no_time
	.p2align	2
no_time:
	.long	4294967295              # 0xffffffff
	.size	no_time, 4

	.type	recursive,@object       # @recursive
	.bss
	.globl	recursive
	.p2align	2
recursive:
	.long	0                       # 0x0
	.size	recursive, 4

	.type	list,@object            # @list
	.globl	list
	.p2align	2
list:
	.long	0                       # 0x0
	.size	list, 4

	.type	verbose,@object         # @verbose
	.globl	verbose
	.p2align	2
verbose:
	.long	0                       # 0x0
	.size	verbose, 4

	.type	quiet,@object           # @quiet
	.globl	quiet
	.p2align	2
quiet:
	.long	0                       # 0x0
	.size	quiet, 4

	.type	do_lzw,@object          # @do_lzw
	.globl	do_lzw
	.p2align	2
do_lzw:
	.long	0                       # 0x0
	.size	do_lzw, 4

	.type	test,@object            # @test
	.globl	test
	.p2align	2
test:
	.long	0                       # 0x0
	.size	test, 4

	.type	maxbits,@object         # @maxbits
	.data
	.globl	maxbits
	.p2align	2
maxbits:
	.long	16                      # 0x10
	.size	maxbits, 4

	.type	method,@object          # @method
	.globl	method
	.p2align	2
method:
	.long	8                       # 0x8
	.size	method, 4

	.type	level,@object           # @level
	.globl	level
	.p2align	2
level:
	.long	6                       # 0x6
	.size	level, 4

	.type	exit_code,@object       # @exit_code
	.bss
	.globl	exit_code
	.p2align	2
exit_code:
	.long	0                       # 0x0
	.size	exit_code, 4

	.type	args,@object            # @args
	.globl	args
	.p2align	3
args:
	.quad	0
	.size	args, 8

	.type	remove_ofname,@object   # @remove_ofname
	.globl	remove_ofname
	.p2align	2
remove_ofname:
	.long	0                       # 0x0
	.size	remove_ofname, 4

	.type	.L.str.14,@object       # @.str.14
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.14:
	.asciz	"ascii"
	.size	.L.str.14, 6

	.type	.L.str.15,@object       # @.str.15
.L.str.15:
	.asciz	"to-stdout"
	.size	.L.str.15, 10

	.type	.L.str.16,@object       # @.str.16
.L.str.16:
	.asciz	"stdout"
	.size	.L.str.16, 7

	.type	.L.str.17,@object       # @.str.17
.L.str.17:
	.asciz	"decompress"
	.size	.L.str.17, 11

	.type	.L.str.18,@object       # @.str.18
.L.str.18:
	.asciz	"uncompress"
	.size	.L.str.18, 11

	.type	.L.str.19,@object       # @.str.19
.L.str.19:
	.asciz	"force"
	.size	.L.str.19, 6

	.type	.L.str.20,@object       # @.str.20
.L.str.20:
	.asciz	"help"
	.size	.L.str.20, 5

	.type	.L.str.21,@object       # @.str.21
.L.str.21:
	.asciz	"list"
	.size	.L.str.21, 5

	.type	.L.str.22,@object       # @.str.22
.L.str.22:
	.asciz	"license"
	.size	.L.str.22, 8

	.type	.L.str.23,@object       # @.str.23
.L.str.23:
	.asciz	"no-name"
	.size	.L.str.23, 8

	.type	.L.str.24,@object       # @.str.24
.L.str.24:
	.asciz	"name"
	.size	.L.str.24, 5

	.type	.L.str.25,@object       # @.str.25
.L.str.25:
	.asciz	"quiet"
	.size	.L.str.25, 6

	.type	.L.str.26,@object       # @.str.26
.L.str.26:
	.asciz	"silent"
	.size	.L.str.26, 7

	.type	.L.str.27,@object       # @.str.27
.L.str.27:
	.asciz	"recursive"
	.size	.L.str.27, 10

	.type	.L.str.28,@object       # @.str.28
.L.str.28:
	.asciz	"suffix"
	.size	.L.str.28, 7

	.type	.L.str.29,@object       # @.str.29
.L.str.29:
	.asciz	"test"
	.size	.L.str.29, 5

	.type	.L.str.30,@object       # @.str.30
.L.str.30:
	.asciz	"no-time"
	.size	.L.str.30, 8

	.type	.L.str.31,@object       # @.str.31
.L.str.31:
	.asciz	"verbose"
	.size	.L.str.31, 8

	.type	.L.str.32,@object       # @.str.32
.L.str.32:
	.asciz	"version"
	.size	.L.str.32, 8

	.type	.L.str.33,@object       # @.str.33
.L.str.33:
	.asciz	"fast"
	.size	.L.str.33, 5

	.type	.L.str.34,@object       # @.str.34
.L.str.34:
	.asciz	"best"
	.size	.L.str.34, 5

	.type	.L.str.35,@object       # @.str.35
.L.str.35:
	.asciz	"lzw"
	.size	.L.str.35, 4

	.type	.L.str.36,@object       # @.str.36
.L.str.36:
	.asciz	"bits"
	.size	.L.str.36, 5

	.type	.L.str.37,@object       # @.str.37
.L.str.37:
	.asciz	"rsyncable"
	.size	.L.str.37, 10

	.type	longopts,@object        # @longopts
	.data
	.globl	longopts
	.p2align	4
longopts:
	.quad	.L.str.14
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	97                      # 0x61
	.zero	4
	.quad	.L.str.15
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	99                      # 0x63
	.zero	4
	.quad	.L.str.16
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	99                      # 0x63
	.zero	4
	.quad	.L.str.17
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	100                     # 0x64
	.zero	4
	.quad	.L.str.18
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	100                     # 0x64
	.zero	4
	.quad	.L.str.19
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	102                     # 0x66
	.zero	4
	.quad	.L.str.20
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	104                     # 0x68
	.zero	4
	.quad	.L.str.21
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	108                     # 0x6c
	.zero	4
	.quad	.L.str.22
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	76                      # 0x4c
	.zero	4
	.quad	.L.str.23
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	110                     # 0x6e
	.zero	4
	.quad	.L.str.24
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	78                      # 0x4e
	.zero	4
	.quad	.L.str.25
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	113                     # 0x71
	.zero	4
	.quad	.L.str.26
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	113                     # 0x71
	.zero	4
	.quad	.L.str.27
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	114                     # 0x72
	.zero	4
	.quad	.L.str.28
	.long	1                       # 0x1
	.zero	4
	.quad	0
	.long	83                      # 0x53
	.zero	4
	.quad	.L.str.29
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	116                     # 0x74
	.zero	4
	.quad	.L.str.30
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	84                      # 0x54
	.zero	4
	.quad	.L.str.31
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	118                     # 0x76
	.zero	4
	.quad	.L.str.32
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	86                      # 0x56
	.zero	4
	.quad	.L.str.33
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	49                      # 0x31
	.zero	4
	.quad	.L.str.34
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	57                      # 0x39
	.zero	4
	.quad	.L.str.35
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	90                      # 0x5a
	.zero	4
	.quad	.L.str.36
	.long	1                       # 0x1
	.zero	4
	.quad	0
	.long	98                      # 0x62
	.zero	4
	.quad	.L.str.37
	.long	0                       # 0x0
	.zero	4
	.quad	0
	.long	82                      # 0x52
	.zero	4
	.zero	32
	.size	longopts, 800

	.type	work,@object            # @work
	.globl	work
	.p2align	3
work:
	.quad	zip
	.size	work, 8

	.type	progname,@object        # @progname
	.comm	progname,8,8
	.type	.L.str.38,@object       # @.str.38
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.38:
	.asciz	".exe"
	.size	.L.str.38, 5

	.type	.L.str.39,@object       # @.str.39
.L.str.39:
	.asciz	"GZIP"
	.size	.L.str.39, 5

	.type	env,@object             # @env
	.comm	env,8,8
	.type	foreground,@object      # @foreground
	.comm	foreground,4,4
	.type	.L.str.40,@object       # @.str.40
.L.str.40:
	.asciz	"un"
	.size	.L.str.40, 3

	.type	.L.str.41,@object       # @.str.41
.L.str.41:
	.asciz	"gun"
	.size	.L.str.41, 4

	.type	.L.str.42,@object       # @.str.42
.L.str.42:
	.asciz	"cat"
	.size	.L.str.42, 4

	.type	.L.str.43,@object       # @.str.43
.L.str.43:
	.asciz	"gzcat"
	.size	.L.str.43, 6

	.type	.L.str.44,@object       # @.str.44
.L.str.44:
	.asciz	".gz"
	.size	.L.str.44, 4

	.type	z_suffix,@object        # @z_suffix
	.comm	z_suffix,8,8
	.type	z_len,@object           # @z_len
	.comm	z_len,8,8
	.type	.L.str.45,@object       # @.str.45
.L.str.45:
	.asciz	"ab:cdfhH?lLmMnNqrS:tvVZ123456789"
	.size	.L.str.45, 33

	.type	.L.str.46,@object       # @.str.46
.L.str.46:
	.asciz	"%s: -b operand is not an integer\n"
	.size	.L.str.46, 34

	.type	.L.str.47,@object       # @.str.47
.L.str.47:
	.asciz	"%s: -Z not supported in this version\n"
	.size	.L.str.47, 38

	.type	.L.str.48,@object       # @.str.48
.L.str.48:
	.asciz	"%s: option --ascii ignored on this system\n"
	.size	.L.str.48, 43

	.type	.L.str.49,@object       # @.str.49
.L.str.49:
	.asciz	"%s: incorrect suffix '%s'\n"
	.size	.L.str.49, 27

	.type	mask_bits,@object       # @mask_bits
	.data
	.globl	mask_bits
	.p2align	4
mask_bits:
	.short	0                       # 0x0
	.short	1                       # 0x1
	.short	3                       # 0x3
	.short	7                       # 0x7
	.short	15                      # 0xf
	.short	31                      # 0x1f
	.short	63                      # 0x3f
	.short	127                     # 0x7f
	.short	255                     # 0xff
	.short	511                     # 0x1ff
	.short	1023                    # 0x3ff
	.short	2047                    # 0x7ff
	.short	4095                    # 0xfff
	.short	8191                    # 0x1fff
	.short	16383                   # 0x3fff
	.short	32767                   # 0x7fff
	.short	65535                   # 0xffff
	.size	mask_bits, 34

	.type	lbits,@object           # @lbits
	.globl	lbits
	.p2align	2
lbits:
	.long	9                       # 0x9
	.size	lbits, 4

	.type	dbits,@object           # @dbits
	.globl	dbits
	.p2align	2
dbits:
	.long	6                       # 0x6
	.size	dbits, 4

	.type	hufts,@object           # @hufts
	.comm	hufts,4,4
	.type	bb,@object              # @bb
	.comm	bb,8,8
	.type	bk,@object              # @bk
	.comm	bk,4,4
	.type	inptr,@object           # @inptr
	.comm	inptr,4,4
	.type	insize,@object          # @insize
	.comm	insize,4,4
	.type	inbuf,@object           # @inbuf
	.comm	inbuf,32832,16
	.type	cplens,@object          # @cplens
	.p2align	4
cplens:
	.short	3                       # 0x3
	.short	4                       # 0x4
	.short	5                       # 0x5
	.short	6                       # 0x6
	.short	7                       # 0x7
	.short	8                       # 0x8
	.short	9                       # 0x9
	.short	10                      # 0xa
	.short	11                      # 0xb
	.short	13                      # 0xd
	.short	15                      # 0xf
	.short	17                      # 0x11
	.short	19                      # 0x13
	.short	23                      # 0x17
	.short	27                      # 0x1b
	.short	31                      # 0x1f
	.short	35                      # 0x23
	.short	43                      # 0x2b
	.short	51                      # 0x33
	.short	59                      # 0x3b
	.short	67                      # 0x43
	.short	83                      # 0x53
	.short	99                      # 0x63
	.short	115                     # 0x73
	.short	131                     # 0x83
	.short	163                     # 0xa3
	.short	195                     # 0xc3
	.short	227                     # 0xe3
	.short	258                     # 0x102
	.short	0                       # 0x0
	.short	0                       # 0x0
	.size	cplens, 62

	.type	cplext,@object          # @cplext
	.p2align	4
cplext:
	.short	0                       # 0x0
	.short	0                       # 0x0
	.short	0                       # 0x0
	.short	0                       # 0x0
	.short	0                       # 0x0
	.short	0                       # 0x0
	.short	0                       # 0x0
	.short	0                       # 0x0
	.short	1                       # 0x1
	.short	1                       # 0x1
	.short	1                       # 0x1
	.short	1                       # 0x1
	.short	2                       # 0x2
	.short	2                       # 0x2
	.short	2                       # 0x2
	.short	2                       # 0x2
	.short	3                       # 0x3
	.short	3                       # 0x3
	.short	3                       # 0x3
	.short	3                       # 0x3
	.short	4                       # 0x4
	.short	4                       # 0x4
	.short	4                       # 0x4
	.short	4                       # 0x4
	.short	5                       # 0x5
	.short	5                       # 0x5
	.short	5                       # 0x5
	.short	5                       # 0x5
	.short	0                       # 0x0
	.short	99                      # 0x63
	.short	99                      # 0x63
	.size	cplext, 62

	.type	cpdist,@object          # @cpdist
	.p2align	4
cpdist:
	.short	1                       # 0x1
	.short	2                       # 0x2
	.short	3                       # 0x3
	.short	4                       # 0x4
	.short	5                       # 0x5
	.short	7                       # 0x7
	.short	9                       # 0x9
	.short	13                      # 0xd
	.short	17                      # 0x11
	.short	25                      # 0x19
	.short	33                      # 0x21
	.short	49                      # 0x31
	.short	65                      # 0x41
	.short	97                      # 0x61
	.short	129                     # 0x81
	.short	193                     # 0xc1
	.short	257                     # 0x101
	.short	385                     # 0x181
	.short	513                     # 0x201
	.short	769                     # 0x301
	.short	1025                    # 0x401
	.short	1537                    # 0x601
	.short	2049                    # 0x801
	.short	3073                    # 0xc01
	.short	4097                    # 0x1001
	.short	6145                    # 0x1801
	.short	8193                    # 0x2001
	.short	12289                   # 0x3001
	.short	16385                   # 0x4001
	.short	24577                   # 0x6001
	.size	cpdist, 60

	.type	cpdext,@object          # @cpdext
	.p2align	4
cpdext:
	.short	0                       # 0x0
	.short	0                       # 0x0
	.short	0                       # 0x0
	.short	0                       # 0x0
	.short	1                       # 0x1
	.short	1                       # 0x1
	.short	2                       # 0x2
	.short	2                       # 0x2
	.short	3                       # 0x3
	.short	3                       # 0x3
	.short	4                       # 0x4
	.short	4                       # 0x4
	.short	5                       # 0x5
	.short	5                       # 0x5
	.short	6                       # 0x6
	.short	6                       # 0x6
	.short	7                       # 0x7
	.short	7                       # 0x7
	.short	8                       # 0x8
	.short	8                       # 0x8
	.short	9                       # 0x9
	.short	9                       # 0x9
	.short	10                      # 0xa
	.short	10                      # 0xa
	.short	11                      # 0xb
	.short	11                      # 0xb
	.short	12                      # 0xc
	.short	12                      # 0xc
	.short	13                      # 0xd
	.short	13                      # 0xd
	.size	cpdext, 60

	.type	border,@object          # @border
	.p2align	4
border:
	.long	16                      # 0x10
	.long	17                      # 0x11
	.long	18                      # 0x12
	.long	0                       # 0x0
	.long	8                       # 0x8
	.long	7                       # 0x7
	.long	9                       # 0x9
	.long	6                       # 0x6
	.long	10                      # 0xa
	.long	5                       # 0x5
	.long	11                      # 0xb
	.long	4                       # 0x4
	.long	12                      # 0xc
	.long	3                       # 0x3
	.long	13                      # 0xd
	.long	2                       # 0x2
	.long	14                      # 0xe
	.long	1                       # 0x1
	.long	15                      # 0xf
	.size	border, 76

	.type	.L.str.50,@object       # @.str.50
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.50:
	.asciz	" incomplete literal tree\n"
	.size	.L.str.50, 26

	.type	.L.str.51,@object       # @.str.51
.L.str.51:
	.asciz	" incomplete distance tree\n"
	.size	.L.str.51, 27

	.type	msg_done,@object        # @msg_done
	.local	msg_done
	.comm	msg_done,4,4
	.type	.L.str.52,@object       # @.str.52
.L.str.52:
	.asciz	"output in compress .Z format not supported\n"
	.size	.L.str.52, 44

	.type	file_type,@object       # @file_type
	.comm	file_type,8,8
	.type	file_method,@object     # @file_method
	.comm	file_method,8,8
	.type	input_len,@object       # @input_len
	.local	input_len
	.comm	input_len,8,8
	.type	compressed_len,@object  # @compressed_len
	.local	compressed_len
	.comm	compressed_len,8,8
	.type	static_dtree,@object    # @static_dtree
	.local	static_dtree
	.comm	static_dtree,120,16
	.type	base_length,@object     # @base_length
	.local	base_length
	.comm	base_length,116,16
	.type	extra_lbits,@object     # @extra_lbits
	.data
	.p2align	4
extra_lbits:
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	1                       # 0x1
	.long	1                       # 0x1
	.long	1                       # 0x1
	.long	1                       # 0x1
	.long	2                       # 0x2
	.long	2                       # 0x2
	.long	2                       # 0x2
	.long	2                       # 0x2
	.long	3                       # 0x3
	.long	3                       # 0x3
	.long	3                       # 0x3
	.long	3                       # 0x3
	.long	4                       # 0x4
	.long	4                       # 0x4
	.long	4                       # 0x4
	.long	4                       # 0x4
	.long	5                       # 0x5
	.long	5                       # 0x5
	.long	5                       # 0x5
	.long	5                       # 0x5
	.long	0                       # 0x0
	.size	extra_lbits, 116

	.type	length_code,@object     # @length_code
	.local	length_code
	.comm	length_code,256,16
	.type	base_dist,@object       # @base_dist
	.local	base_dist
	.comm	base_dist,120,16
	.type	extra_dbits,@object     # @extra_dbits
	.p2align	4
extra_dbits:
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	1                       # 0x1
	.long	1                       # 0x1
	.long	2                       # 0x2
	.long	2                       # 0x2
	.long	3                       # 0x3
	.long	3                       # 0x3
	.long	4                       # 0x4
	.long	4                       # 0x4
	.long	5                       # 0x5
	.long	5                       # 0x5
	.long	6                       # 0x6
	.long	6                       # 0x6
	.long	7                       # 0x7
	.long	7                       # 0x7
	.long	8                       # 0x8
	.long	8                       # 0x8
	.long	9                       # 0x9
	.long	9                       # 0x9
	.long	10                      # 0xa
	.long	10                      # 0xa
	.long	11                      # 0xb
	.long	11                      # 0xb
	.long	12                      # 0xc
	.long	12                      # 0xc
	.long	13                      # 0xd
	.long	13                      # 0xd
	.size	extra_dbits, 120

	.type	dist_code,@object       # @dist_code
	.local	dist_code
	.comm	dist_code,512,16
	.type	bl_count,@object        # @bl_count
	.local	bl_count
	.comm	bl_count,32,16
	.type	static_ltree,@object    # @static_ltree
	.local	static_ltree
	.comm	static_ltree,1152,16
	.type	flags,@object           # @flags
	.local	flags
	.comm	flags,1,1
	.type	flag_buf,@object        # @flag_buf
	.local	flag_buf
	.comm	flag_buf,4096,16
	.type	last_flags,@object      # @last_flags
	.local	last_flags
	.comm	last_flags,4,4
	.type	l_desc,@object          # @l_desc
	.p2align	3
l_desc:
	.quad	dyn_ltree
	.quad	static_ltree
	.quad	extra_lbits
	.long	257                     # 0x101
	.long	286                     # 0x11e
	.long	15                      # 0xf
	.long	0                       # 0x0
	.size	l_desc, 40

	.type	d_desc,@object          # @d_desc
	.p2align	3
d_desc:
	.quad	dyn_dtree
	.quad	static_dtree
	.quad	extra_dbits
	.long	0                       # 0x0
	.long	30                      # 0x1e
	.long	15                      # 0xf
	.long	0                       # 0x0
	.size	d_desc, 40

	.type	opt_len,@object         # @opt_len
	.local	opt_len
	.comm	opt_len,8,8
	.type	static_len,@object      # @static_len
	.local	static_len
	.comm	static_len,8,8
	.type	.L.str.53,@object       # @.str.53
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.53:
	.asciz	"block vanished"
	.size	.L.str.53, 15

	.type	dyn_ltree,@object       # @dyn_ltree
	.local	dyn_ltree
	.comm	dyn_ltree,2292,16
	.type	dyn_dtree,@object       # @dyn_dtree
	.local	dyn_dtree
	.comm	dyn_dtree,244,16
	.type	last_lit,@object        # @last_lit
	.local	last_lit
	.comm	last_lit,4,4
	.type	d_buf,@object           # @d_buf
	.comm	d_buf,65536,16
	.type	last_dist,@object       # @last_dist
	.local	last_dist
	.comm	last_dist,4,4
	.type	flag_bit,@object        # @flag_bit
	.local	flag_bit
	.comm	flag_bit,1,1
	.type	ifd,@object             # @ifd
	.comm	ifd,4,4
	.type	ofd,@object             # @ofd
	.comm	ofd,4,4
	.type	done,@object            # @done
	.local	done
	.comm	done,4,4
	.type	block_mode,@object      # @block_mode
	.data
	.globl	block_mode
	.p2align	2
block_mode:
	.long	128                     # 0x80
	.size	block_mode, 4

	.type	.L.str.54,@object       # @.str.54
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.54:
	.asciz	"\n%s: %s: warning, unknown flags 0x%x\n"
	.size	.L.str.54, 38

	.type	ifname,@object          # @ifname
	.comm	ifname,1024,16
	.type	.L.str.55,@object       # @.str.55
.L.str.55:
	.asciz	"\n%s: %s: compressed with %d bits, can only handle %d bits\n"
	.size	.L.str.55, 59

	.type	bytes_in,@object        # @bytes_in
	.comm	bytes_in,8,8
	.type	.L.str.56,@object       # @.str.56
.L.str.56:
	.asciz	"corrupt input."
	.size	.L.str.56, 15

	.type	bytes_out,@object       # @bytes_out
	.comm	bytes_out,8,8
	.type	.L.str.57,@object       # @.str.57
.L.str.57:
	.asciz	"corrupt input. Use zcat to recover some data."
	.size	.L.str.57, 46

	.type	valid,@object           # @valid
	.local	valid
	.comm	valid,4,4
	.type	bitbuf,@object          # @bitbuf
	.local	bitbuf
	.comm	bitbuf,8,8
	.type	peek_bits,@object       # @peek_bits
	.local	peek_bits
	.comm	peek_bits,4,4
	.type	leaves,@object          # @leaves
	.local	leaves
	.comm	leaves,104,16
	.type	max_len,@object         # @max_len
	.local	max_len
	.comm	max_len,4,4
	.type	parents,@object         # @parents
	.local	parents
	.comm	parents,104,16
	.type	literal,@object         # @literal
	.local	literal
	.comm	literal,256,16
	.type	lit_base,@object        # @lit_base
	.local	lit_base
	.comm	lit_base,104,16
	.type	orig_len,@object        # @orig_len
	.local	orig_len
	.comm	orig_len,8,8
	.type	.L.str.58,@object       # @.str.58
.L.str.58:
	.asciz	"invalid compressed data--length error"
	.size	.L.str.58, 38

	.type	pkzip,@object           # @pkzip
	.bss
	.globl	pkzip
	.p2align	2
pkzip:
	.long	0                       # 0x0
	.size	pkzip, 4

	.type	ext_header,@object      # @ext_header
	.globl	ext_header
	.p2align	2
ext_header:
	.long	0                       # 0x0
	.size	ext_header, 4

	.type	.L.str.59,@object       # @.str.59
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.59:
	.asciz	"\n%s: %s: not a valid zip file\n"
	.size	.L.str.59, 31

	.type	.L.str.60,@object       # @.str.60
.L.str.60:
	.asciz	"\n%s: %s: first entry not deflated or stored -- use unzip\n"
	.size	.L.str.60, 58

	.type	decrypt,@object         # @decrypt
	.comm	decrypt,4,4
	.type	.L.str.61,@object       # @.str.61
.L.str.61:
	.asciz	"\n%s: %s: encrypted file -- use unzip\n"
	.size	.L.str.61, 38

	.type	.L.str.62,@object       # @.str.62
.L.str.62:
	.asciz	"out of memory"
	.size	.L.str.62, 14

	.type	.L.str.63,@object       # @.str.63
.L.str.63:
	.asciz	"invalid compressed data--format violated"
	.size	.L.str.63, 41

	.type	.L.str.64,@object       # @.str.64
.L.str.64:
	.asciz	"len %ld, siz %ld\n"
	.size	.L.str.64, 18

	.type	.L.str.65,@object       # @.str.65
.L.str.65:
	.asciz	"invalid compressed data--length mismatch"
	.size	.L.str.65, 41

	.type	.L.str.66,@object       # @.str.66
.L.str.66:
	.asciz	"internal error, invalid method"
	.size	.L.str.66, 31

	.type	.L.str.67,@object       # @.str.67
.L.str.67:
	.asciz	"\n%s: %s: invalid compressed data--crc error\n"
	.size	.L.str.67, 45

	.type	.L.str.68,@object       # @.str.68
.L.str.68:
	.asciz	"\n%s: %s: invalid compressed data--length error\n"
	.size	.L.str.68, 48

	.type	.L.str.69,@object       # @.str.69
.L.str.69:
	.asciz	"%s: %s has more than one entry--rest ignored\n"
	.size	.L.str.69, 46

	.type	.L.str.70,@object       # @.str.70
.L.str.70:
	.asciz	"%s: %s has more than one entry -- unchanged\n"
	.size	.L.str.70, 45

	.type	updcrc.crc,@object      # @updcrc.crc
	.data
	.p2align	3
updcrc.crc:
	.quad	4294967295              # 0xffffffff
	.size	updcrc.crc, 8

	.type	.L.str.71,@object       # @.str.71
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.71:
	.asciz	" \t"
	.size	.L.str.71, 3

	.type	.L.str.72,@object       # @.str.72
.L.str.72:
	.asciz	"argc<=0"
	.size	.L.str.72, 8

	.type	.L.str.73,@object       # @.str.73
.L.str.73:
	.asciz	"\n%s: %s: %s\n"
	.size	.L.str.73, 13

	.type	.L.str.74,@object       # @.str.74
.L.str.74:
	.asciz	"%s: %s: warning: %s\n"
	.size	.L.str.74, 21

	.type	.L.str.75,@object       # @.str.75
.L.str.75:
	.asciz	"\n%s: "
	.size	.L.str.75, 6

	.type	.L.str.76,@object       # @.str.76
.L.str.76:
	.asciz	"%s: unexpected end of file\n"
	.size	.L.str.76, 28

	.type	ofname,@object          # @ofname
	.comm	ofname,1024,16
	.type	.L.str.77,@object       # @.str.77
.L.str.77:
	.asciz	"%5.1f%%"
	.size	.L.str.77, 8

	.type	crc_32_tab,@object      # @crc_32_tab
	.data
	.globl	crc_32_tab
	.p2align	4
crc_32_tab:
	.quad	0                       # 0x0
	.quad	1996959894              # 0x77073096
	.quad	3993919788              # 0xee0e612c
	.quad	2567524794              # 0x990951ba
	.quad	124634137               # 0x76dc419
	.quad	1886057615              # 0x706af48f
	.quad	3915621685              # 0xe963a535
	.quad	2657392035              # 0x9e6495a3
	.quad	249268274               # 0xedb8832
	.quad	2044508324              # 0x79dcb8a4
	.quad	3772115230              # 0xe0d5e91e
	.quad	2547177864              # 0x97d2d988
	.quad	162941995               # 0x9b64c2b
	.quad	2125561021              # 0x7eb17cbd
	.quad	3887607047              # 0xe7b82d07
	.quad	2428444049              # 0x90bf1d91
	.quad	498536548               # 0x1db71064
	.quad	1789927666              # 0x6ab020f2
	.quad	4089016648              # 0xf3b97148
	.quad	2227061214              # 0x84be41de
	.quad	450548861               # 0x1adad47d
	.quad	1843258603              # 0x6ddde4eb
	.quad	4107580753              # 0xf4d4b551
	.quad	2211677639              # 0x83d385c7
	.quad	325883990               # 0x136c9856
	.quad	1684777152              # 0x646ba8c0
	.quad	4251122042              # 0xfd62f97a
	.quad	2321926636              # 0x8a65c9ec
	.quad	335633487               # 0x14015c4f
	.quad	1661365465              # 0x63066cd9
	.quad	4195302755              # 0xfa0f3d63
	.quad	2366115317              # 0x8d080df5
	.quad	997073096               # 0x3b6e20c8
	.quad	1281953886              # 0x4c69105e
	.quad	3579855332              # 0xd56041e4
	.quad	2724688242              # 0xa2677172
	.quad	1006888145              # 0x3c03e4d1
	.quad	1258607687              # 0x4b04d447
	.quad	3524101629              # 0xd20d85fd
	.quad	2768942443              # 0xa50ab56b
	.quad	901097722               # 0x35b5a8fa
	.quad	1119000684              # 0x42b2986c
	.quad	3686517206              # 0xdbbbc9d6
	.quad	2898065728              # 0xacbcf940
	.quad	853044451               # 0x32d86ce3
	.quad	1172266101              # 0x45df5c75
	.quad	3705015759              # 0xdcd60dcf
	.quad	2882616665              # 0xabd13d59
	.quad	651767980               # 0x26d930ac
	.quad	1373503546              # 0x51de003a
	.quad	3369554304              # 0xc8d75180
	.quad	3218104598              # 0xbfd06116
	.quad	565507253               # 0x21b4f4b5
	.quad	1454621731              # 0x56b3c423
	.quad	3485111705              # 0xcfba9599
	.quad	3099436303              # 0xb8bda50f
	.quad	671266974               # 0x2802b89e
	.quad	1594198024              # 0x5f058808
	.quad	3322730930              # 0xc60cd9b2
	.quad	2970347812              # 0xb10be924
	.quad	795835527               # 0x2f6f7c87
	.quad	1483230225              # 0x58684c11
	.quad	3244367275              # 0xc1611dab
	.quad	3060149565              # 0xb6662d3d
	.quad	1994146192              # 0x76dc4190
	.quad	31158534                # 0x1db7106
	.quad	2563907772              # 0x98d220bc
	.quad	4023717930              # 0xefd5102a
	.quad	1907459465              # 0x71b18589
	.quad	112637215               # 0x6b6b51f
	.quad	2680153253              # 0x9fbfe4a5
	.quad	3904427059              # 0xe8b8d433
	.quad	2013776290              # 0x7807c9a2
	.quad	251722036               # 0xf00f934
	.quad	2517215374              # 0x9609a88e
	.quad	3775830040              # 0xe10e9818
	.quad	2137656763              # 0x7f6a0dbb
	.quad	141376813               # 0x86d3d2d
	.quad	2439277719              # 0x91646c97
	.quad	3865271297              # 0xe6635c01
	.quad	1802195444              # 0x6b6b51f4
	.quad	476864866               # 0x1c6c6162
	.quad	2238001368              # 0x856530d8
	.quad	4066508878              # 0xf262004e
	.quad	1812370925              # 0x6c0695ed
	.quad	453092731               # 0x1b01a57b
	.quad	2181625025              # 0x8208f4c1
	.quad	4111451223              # 0xf50fc457
	.quad	1706088902              # 0x65b0d9c6
	.quad	314042704               # 0x12b7e950
	.quad	2344532202              # 0x8bbeb8ea
	.quad	4240017532              # 0xfcb9887c
	.quad	1658658271              # 0x62dd1ddf
	.quad	366619977               # 0x15da2d49
	.quad	2362670323              # 0x8cd37cf3
	.quad	4224994405              # 0xfbd44c65
	.quad	1303535960              # 0x4db26158
	.quad	984961486               # 0x3ab551ce
	.quad	2747007092              # 0xa3bc0074
	.quad	3569037538              # 0xd4bb30e2
	.quad	1256170817              # 0x4adfa541
	.quad	1037604311              # 0x3dd895d7
	.quad	2765210733              # 0xa4d1c46d
	.quad	3554079995              # 0xd3d6f4fb
	.quad	1131014506              # 0x4369e96a
	.quad	879679996               # 0x346ed9fc
	.quad	2909243462              # 0xad678846
	.quad	3663771856              # 0xda60b8d0
	.quad	1141124467              # 0x44042d73
	.quad	855842277               # 0x33031de5
	.quad	2852801631              # 0xaa0a4c5f
	.quad	3708648649              # 0xdd0d7cc9
	.quad	1342533948              # 0x5005713c
	.quad	654459306               # 0x270241aa
	.quad	3188396048              # 0xbe0b1010
	.quad	3373015174              # 0xc90c2086
	.quad	1466479909              # 0x5768b525
	.quad	544179635               # 0x206f85b3
	.quad	3110523913              # 0xb966d409
	.quad	3462522015              # 0xce61e49f
	.quad	1591671054              # 0x5edef90e
	.quad	702138776               # 0x29d9c998
	.quad	2966460450              # 0xb0d09822
	.quad	3352799412              # 0xc7d7a8b4
	.quad	1504918807              # 0x59b33d17
	.quad	783551873               # 0x2eb40d81
	.quad	3082640443              # 0xb7bd5c3b
	.quad	3233442989              # 0xc0ba6cad
	.quad	3988292384              # 0xedb88320
	.quad	2596254646              # 0x9abfb3b6
	.quad	62317068                # 0x3b6e20c
	.quad	1957810842              # 0x74b1d29a
	.quad	3939845945              # 0xead54739
	.quad	2647816111              # 0x9dd277af
	.quad	81470997                # 0x4db2615
	.quad	1943803523              # 0x73dc1683
	.quad	3814918930              # 0xe3630b12
	.quad	2489596804              # 0x94643b84
	.quad	225274430               # 0xd6d6a3e
	.quad	2053790376              # 0x7a6a5aa8
	.quad	3826175755              # 0xe40ecf0b
	.quad	2466906013              # 0x9309ff9d
	.quad	167816743               # 0xa00ae27
	.quad	2097651377              # 0x7d079eb1
	.quad	4027552580              # 0xf00f9344
	.quad	2265490386              # 0x8708a3d2
	.quad	503444072               # 0x1e01f268
	.quad	1762050814              # 0x6906c2fe
	.quad	4150417245              # 0xf762575d
	.quad	2154129355              # 0x806567cb
	.quad	426522225               # 0x196c3671
	.quad	1852507879              # 0x6e6b06e7
	.quad	4275313526              # 0xfed41b76
	.quad	2312317920              # 0x89d32be0
	.quad	282753626               # 0x10da7a5a
	.quad	1742555852              # 0x67dd4acc
	.quad	4189708143              # 0xf9b9df6f
	.quad	2394877945              # 0x8ebeeff9
	.quad	397917763               # 0x17b7be43
	.quad	1622183637              # 0x60b08ed5
	.quad	3604390888              # 0xd6d6a3e8
	.quad	2714866558              # 0xa1d1937e
	.quad	953729732               # 0x38d8c2c4
	.quad	1340076626              # 0x4fdff252
	.quad	3518719985              # 0xd1bb67f1
	.quad	2797360999              # 0xa6bc5767
	.quad	1068828381              # 0x3fb506dd
	.quad	1219638859              # 0x48b2364b
	.quad	3624741850              # 0xd80d2bda
	.quad	2936675148              # 0xaf0a1b4c
	.quad	906185462               # 0x36034af6
	.quad	1090812512              # 0x41047a60
	.quad	3747672003              # 0xdf60efc3
	.quad	2825379669              # 0xa867df55
	.quad	829329135               # 0x316e8eef
	.quad	1181335161              # 0x4669be79
	.quad	3412177804              # 0xcb61b38c
	.quad	3160834842              # 0xbc66831a
	.quad	628085408               # 0x256fd2a0
	.quad	1382605366              # 0x5268e236
	.quad	3423369109              # 0xcc0c7795
	.quad	3138078467              # 0xbb0b4703
	.quad	570562233               # 0x220216b9
	.quad	1426400815              # 0x5505262f
	.quad	3317316542              # 0xc5ba3bbe
	.quad	2998733608              # 0xb2bd0b28
	.quad	733239954               # 0x2bb45a92
	.quad	1555261956              # 0x5cb36a04
	.quad	3268935591              # 0xc2d7ffa7
	.quad	3050360625              # 0xb5d0cf31
	.quad	752459403               # 0x2cd99e8b
	.quad	1541320221              # 0x5bdeae1d
	.quad	2607071920              # 0x9b64c2b0
	.quad	3965973030              # 0xec63f226
	.quad	1969922972              # 0x756aa39c
	.quad	40735498                # 0x26d930a
	.quad	2617837225              # 0x9c0906a9
	.quad	3943577151              # 0xeb0e363f
	.quad	1913087877              # 0x72076785
	.quad	83908371                # 0x5005713
	.quad	2512341634              # 0x95bf4a82
	.quad	3803740692              # 0xe2b87a14
	.quad	2075208622              # 0x7bb12bae
	.quad	213261112               # 0xcb61b38
	.quad	2463272603              # 0x92d28e9b
	.quad	3855990285              # 0xe5d5be0d
	.quad	2094854071              # 0x7cdcefb7
	.quad	198958881               # 0xbdbdf21
	.quad	2262029012              # 0x86d3d2d4
	.quad	4057260610              # 0xf1d4e242
	.quad	1759359992              # 0x68ddb3f8
	.quad	534414190               # 0x1fda836e
	.quad	2176718541              # 0x81be16cd
	.quad	4139329115              # 0xf6b9265b
	.quad	1873836001              # 0x6fb077e1
	.quad	414664567               # 0x18b74777
	.quad	2282248934              # 0x88085ae6
	.quad	4279200368              # 0xff0f6a70
	.quad	1711684554              # 0x66063bca
	.quad	285281116               # 0x11010b5c
	.quad	2405801727              # 0x8f659eff
	.quad	4167216745              # 0xf862ae69
	.quad	1634467795              # 0x616bffd3
	.quad	376229701               # 0x166ccf45
	.quad	2685067896              # 0xa00ae278
	.quad	3608007406              # 0xd70dd2ee
	.quad	1308918612              # 0x4e048354
	.quad	956543938               # 0x3903b3c2
	.quad	2808555105              # 0xa7672661
	.quad	3495958263              # 0xd06016f7
	.quad	1231636301              # 0x4969474d
	.quad	1047427035              # 0x3e6e77db
	.quad	2932959818              # 0xaed16a4a
	.quad	3654703836              # 0xd9d65adc
	.quad	1088359270              # 0x40df0b66
	.quad	936918000               # 0x37d83bf0
	.quad	2847714899              # 0xa9bcae53
	.quad	3736837829              # 0xdebb9ec5
	.quad	1202900863              # 0x47b2cf7f
	.quad	817233897               # 0x30b5ffe9
	.quad	3183342108              # 0xbdbdf21c
	.quad	3401237130              # 0xcabac28a
	.quad	1404277552              # 0x53b39330
	.quad	615818150               # 0x24b4a3a6
	.quad	3134207493              # 0xbad03605
	.quad	3453421203              # 0xcdd70693
	.quad	1423857449              # 0x54de5729
	.quad	601450431               # 0x23d967bf
	.quad	3009837614              # 0xb3667a2e
	.quad	3294710456              # 0xc4614ab8
	.quad	1567103746              # 0x5d681b02
	.quad	711928724               # 0x2a6f2b94
	.quad	3020668471              # 0xb40bbe37
	.quad	3272380065              # 0xc30c8ea1
	.quad	1510334235              # 0x5a05df1b
	.quad	755167117               # 0x2d02ef8d
	.size	crc_32_tab, 2048

	.type	.L.str.79,@object       # @.str.79
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.79:
	.asciz	"\037\213"
	.size	.L.str.79, 3

	.type	save_orig_name,@object  # @save_orig_name
	.comm	save_orig_name,4,4
	.type	time_stamp,@object      # @time_stamp
	.comm	time_stamp,8,8
	.type	crc,@object             # @crc
	.local	crc
	.comm	crc,8,8
	.type	header_bytes,@object    # @header_bytes
	.comm	header_bytes,8,8
	.type	outbuf,@object          # @outbuf
	.comm	outbuf,18432,16
	.type	window,@object          # @window
	.comm	window,65536,16
	.type	prev,@object            # @prev
	.comm	prev,131072,16
	.type	last_member,@object     # @last_member
	.comm	last_member,4,4
	.type	part_nb,@object         # @part_nb
	.comm	part_nb,4,4
	.type	ifile_size,@object      # @ifile_size
	.comm	ifile_size,8,8
	.type	total_in,@object        # @total_in
	.comm	total_in,8,8
	.type	total_out,@object       # @total_out
	.comm	total_out,8,8
	.type	istat,@object           # @istat
	.comm	istat,144,8
	.type	key,@object             # @key
	.comm	key,8,8
	.type	.L.str.83,@object       # @.str.83
.L.str.83:
	.asciz	"POSIXLY_CORRECT"
	.size	.L.str.83, 16

	.type	.L.str.84,@object       # @.str.84
.L.str.84:
	.asciz	"usage: %s [-%scdfhlLnN%stvV19] [-S suffix] [file ...]\n"
	.size	.L.str.84, 55

	.type	.L.str.85,@object       # @.str.85
.L.str.85:
	.asciz	"r"
	.size	.L.str.85, 2

	.type	help.help_msg,@object   # @help.help_msg
	.data
	.p2align	4
help.help_msg:
	.quad	.L.str.86
	.quad	.L.str.87
	.quad	.L.str.88
	.quad	.L.str.89
	.quad	.L.str.90
	.quad	.L.str.91
	.quad	.L.str.92
	.quad	.L.str.93
	.quad	.L.str.94
	.quad	.L.str.95
	.quad	.L.str.96
	.quad	.L.str.97
	.quad	.L.str.98
	.quad	.L.str.99
	.quad	.L.str.100
	.quad	.L.str.101
	.quad	.L.str.102
	.quad	.L.str.103
	.quad	.L.str.104
	.quad	0
	.size	help.help_msg, 160

	.type	.L.str.86,@object       # @.str.86
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.86:
	.asciz	" -c --stdout      write on standard output, keep original files unchanged"
	.size	.L.str.86, 74

	.type	.L.str.87,@object       # @.str.87
.L.str.87:
	.asciz	" -d --decompress  decompress"
	.size	.L.str.87, 29

	.type	.L.str.88,@object       # @.str.88
.L.str.88:
	.asciz	" -f --force       force overwrite of output file and compress links"
	.size	.L.str.88, 68

	.type	.L.str.89,@object       # @.str.89
.L.str.89:
	.asciz	" -h --help        give this help"
	.size	.L.str.89, 33

	.type	.L.str.90,@object       # @.str.90
.L.str.90:
	.asciz	" -l --list        list compressed file contents"
	.size	.L.str.90, 48

	.type	.L.str.91,@object       # @.str.91
.L.str.91:
	.asciz	" -L --license     display software license"
	.size	.L.str.91, 43

	.type	.L.str.92,@object       # @.str.92
.L.str.92:
	.asciz	" -n --no-name     do not save or restore the original name and time stamp"
	.size	.L.str.92, 74

	.type	.L.str.93,@object       # @.str.93
.L.str.93:
	.asciz	" -N --name        save or restore the original name and time stamp"
	.size	.L.str.93, 67

	.type	.L.str.94,@object       # @.str.94
.L.str.94:
	.asciz	" -q --quiet       suppress all warnings"
	.size	.L.str.94, 40

	.type	.L.str.95,@object       # @.str.95
.L.str.95:
	.asciz	" -r --recursive   operate recursively on directories"
	.size	.L.str.95, 53

	.type	.L.str.96,@object       # @.str.96
.L.str.96:
	.asciz	" -S .suf  --suffix .suf     use suffix .suf on compressed files"
	.size	.L.str.96, 64

	.type	.L.str.97,@object       # @.str.97
.L.str.97:
	.asciz	" -t --test        test compressed file integrity"
	.size	.L.str.97, 49

	.type	.L.str.98,@object       # @.str.98
.L.str.98:
	.asciz	" -v --verbose     verbose mode"
	.size	.L.str.98, 31

	.type	.L.str.99,@object       # @.str.99
.L.str.99:
	.asciz	" -V --version     display version number"
	.size	.L.str.99, 41

	.type	.L.str.100,@object      # @.str.100
.L.str.100:
	.asciz	" -1 --fast        compress faster"
	.size	.L.str.100, 34

	.type	.L.str.101,@object      # @.str.101
.L.str.101:
	.asciz	" -9 --best        compress better"
	.size	.L.str.101, 34

	.type	.L.str.102,@object      # @.str.102
.L.str.102:
	.asciz	"    --rsyncable   Make rsync-friendly archive"
	.size	.L.str.102, 46

	.type	.L.str.103,@object      # @.str.103
.L.str.103:
	.asciz	" file...          files to (de)compress. If none given, use standard input."
	.size	.L.str.103, 76

	.type	.L.str.104,@object      # @.str.104
.L.str.104:
	.asciz	"Report bugs to <bug-gzip@gnu.org>."
	.size	.L.str.104, 35

	.type	.L.str.105,@object      # @.str.105
.L.str.105:
	.asciz	"%s %s\n(%s)\n"
	.size	.L.str.105, 12

	.type	.L.str.106,@object      # @.str.106
.L.str.106:
	.asciz	"1.3.5"
	.size	.L.str.106, 6

	.type	.L.str.107,@object      # @.str.107
.L.str.107:
	.asciz	"2002-09-30"
	.size	.L.str.107, 11

	.type	.L.str.108,@object      # @.str.108
.L.str.108:
	.asciz	"%s\n"
	.size	.L.str.108, 4

	.type	license_msg,@object     # @license_msg
	.data
	.p2align	4
license_msg:
	.quad	.L.str.109
	.quad	.L.str.110
	.quad	.L.str.111
	.quad	.L.str.112
	.quad	.L.str.113
	.quad	.L.str.114
	.quad	0
	.size	license_msg, 56

	.type	.L.str.109,@object      # @.str.109
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.109:
	.asciz	"Copyright 2002 Free Software Foundation"
	.size	.L.str.109, 40

	.type	.L.str.110,@object      # @.str.110
.L.str.110:
	.asciz	"Copyright 1992-1993 Jean-loup Gailly"
	.size	.L.str.110, 37

	.type	.L.str.111,@object      # @.str.111
.L.str.111:
	.asciz	"This program comes with ABSOLUTELY NO WARRANTY."
	.size	.L.str.111, 48

	.type	.L.str.112,@object      # @.str.112
.L.str.112:
	.asciz	"You may redistribute copies of this program"
	.size	.L.str.112, 44

	.type	.L.str.113,@object      # @.str.113
.L.str.113:
	.asciz	"under the terms of the GNU General Public License."
	.size	.L.str.113, 51

	.type	.L.str.114,@object      # @.str.114
.L.str.114:
	.asciz	"For more information about these matters, see the file named COPYING."
	.size	.L.str.114, 70

	.type	.L.str.115,@object      # @.str.115
.L.str.115:
	.asciz	"Compilation options:\n%s %s "
	.size	.L.str.115, 28

	.type	.L.str.116,@object      # @.str.116
.L.str.116:
	.asciz	"DIRENT"
	.size	.L.str.116, 7

	.type	.L.str.117,@object      # @.str.117
.L.str.117:
	.asciz	"UTIME"
	.size	.L.str.117, 6

	.type	.L.str.118,@object      # @.str.118
.L.str.118:
	.asciz	"STDC_HEADERS "
	.size	.L.str.118, 14

	.type	.L.str.119,@object      # @.str.119
.L.str.119:
	.asciz	"HAVE_UNISTD_H "
	.size	.L.str.119, 15

	.type	.L.str.120,@object      # @.str.120
.L.str.120:
	.asciz	"HAVE_MEMORY_H "
	.size	.L.str.120, 15

	.type	.L.str.121,@object      # @.str.121
.L.str.121:
	.asciz	"HAVE_STRING_H "
	.size	.L.str.121, 15

	.type	.L.str.122,@object      # @.str.122
.L.str.122:
	.asciz	"HAVE_LSTAT "
	.size	.L.str.122, 12

	.type	.L.str.123,@object      # @.str.123
.L.str.123:
	.asciz	"\n"
	.size	.L.str.123, 2

	.type	.L.str.124,@object      # @.str.124
.L.str.124:
	.asciz	"Written by Jean-loup Gailly.\n"
	.size	.L.str.124, 30

	.type	.L.str.125,@object      # @.str.125
.L.str.125:
	.asciz	"%s: compressed data not %s a terminal. Use -f to force %scompression.\n"
	.size	.L.str.125, 71

	.type	.L.str.126,@object      # @.str.126
.L.str.126:
	.asciz	"read from"
	.size	.L.str.126, 10

	.type	.L.str.127,@object      # @.str.127
.L.str.127:
	.asciz	"written to"
	.size	.L.str.127, 11

	.type	.L.str.128,@object      # @.str.128
.L.str.128:
	.asciz	"de"
	.size	.L.str.128, 3

	.type	.L.str.129,@object      # @.str.129
.L.str.129:
	.asciz	"For help, type: %s -h\n"
	.size	.L.str.129, 23

	.type	.L.str.130,@object      # @.str.130
.L.str.130:
	.asciz	"stdin"
	.size	.L.str.130, 6

	.type	.L.str.131,@object      # @.str.131
.L.str.131:
	.asciz	"standard input"
	.size	.L.str.131, 15

	.type	.L.str.132,@object      # @.str.132
.L.str.132:
	.asciz	" OK\n"
	.size	.L.str.132, 5

	.type	.L.str.133,@object      # @.str.133
.L.str.133:
	.asciz	"%s: "
	.size	.L.str.133, 5

	.type	.L.str.134,@object      # @.str.134
.L.str.134:
	.asciz	"\037\236"
	.size	.L.str.134, 3

	.type	.L.str.135,@object      # @.str.135
.L.str.135:
	.asciz	"%s: %s: unknown method %d -- not supported\n"
	.size	.L.str.135, 44

	.type	.L.str.136,@object      # @.str.136
.L.str.136:
	.asciz	"%s: %s is encrypted -- not supported\n"
	.size	.L.str.136, 38

	.type	.L.str.137,@object      # @.str.137
.L.str.137:
	.asciz	"%s: %s is a a multi-part gzip file -- not supported\n"
	.size	.L.str.137, 53

	.type	.L.str.138,@object      # @.str.138
.L.str.138:
	.asciz	"%s: %s has flags 0x%x -- not supported\n"
	.size	.L.str.138, 40

	.type	.L.str.139,@object      # @.str.139
.L.str.139:
	.asciz	"%s: %s: part number %u\n"
	.size	.L.str.139, 24

	.type	.L.str.140,@object      # @.str.140
.L.str.140:
	.asciz	"%s: %s: extra field of %u bytes ignored\n"
	.size	.L.str.140, 41

	.type	.L.str.141,@object      # @.str.141
.L.str.141:
	.asciz	"corrupted input -- file name too large"
	.size	.L.str.141, 39

	.type	.L.str.142,@object      # @.str.142
.L.str.142:
	.asciz	"PK\003\004"
	.size	.L.str.142, 5

	.type	.L.str.143,@object      # @.str.143
.L.str.143:
	.asciz	"\037\036"
	.size	.L.str.143, 3

	.type	.L.str.144,@object      # @.str.144
.L.str.144:
	.asciz	"\037\235"
	.size	.L.str.144, 3

	.type	.L.str.145,@object      # @.str.145
.L.str.145:
	.asciz	"\037\240"
	.size	.L.str.145, 3

	.type	.L.str.146,@object      # @.str.146
.L.str.146:
	.asciz	"\n%s: %s: not in gzip format\n"
	.size	.L.str.146, 29

	.type	.L.str.147,@object      # @.str.147
.L.str.147:
	.asciz	"\n%s: %s: decompression OK, trailing zero bytes ignored\n"
	.size	.L.str.147, 56

	.type	.L.str.148,@object      # @.str.148
.L.str.148:
	.asciz	"\n%s: %s: decompression OK, trailing garbage ignored\n"
	.size	.L.str.148, 53

	.type	.L.str.149,@object      # @.str.149
.L.str.149:
	.asciz	"-"
	.size	.L.str.149, 2

	.type	.L.str.150,@object      # @.str.150
.L.str.150:
	.asciz	"%s: %s is a directory -- ignored\n"
	.size	.L.str.150, 34

	.type	.L.str.151,@object      # @.str.151
.L.str.151:
	.asciz	"%s: %s is not a directory or a regular file - ignored\n"
	.size	.L.str.151, 55

	.type	.L.str.152,@object      # @.str.152
.L.str.152:
	.asciz	"%s: %s has %lu other link%c -- unchanged\n"
	.size	.L.str.152, 42

	.type	.L.str.153,@object      # @.str.153
.L.str.153:
	.asciz	"%s: %s compressed to %s\n"
	.size	.L.str.153, 25

	.type	.L.str.154,@object      # @.str.154
.L.str.154:
	.asciz	"%s:\t"
	.size	.L.str.154, 5

	.type	.L.str.155,@object      # @.str.155
.L.str.155:
	.asciz	" OK"
	.size	.L.str.155, 4

	.type	.L.str.156,@object      # @.str.156
.L.str.156:
	.asciz	" -- replaced with %s"
	.size	.L.str.156, 21

	.type	get_istat.suffixes,@object # @get_istat.suffixes
	.data
	.p2align	4
get_istat.suffixes:
	.quad	0
	.quad	.L.str.44
	.quad	.L.str.157
	.quad	.L.str.158
	.quad	.L.str.159
	.quad	0
	.size	get_istat.suffixes, 48

	.type	.L.str.157,@object      # @.str.157
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.157:
	.asciz	".z"
	.size	.L.str.157, 3

	.type	.L.str.158,@object      # @.str.158
.L.str.158:
	.asciz	"-z"
	.size	.L.str.158, 3

	.type	.L.str.159,@object      # @.str.159
.L.str.159:
	.asciz	".Z"
	.size	.L.str.159, 3

	.type	.L.str.160,@object      # @.str.160
.L.str.160:
	.asciz	"%s: %s: file name too long\n"
	.size	.L.str.160, 28

	.type	get_suffix.known_suffixes,@object # @get_suffix.known_suffixes
	.data
	.p2align	4
get_suffix.known_suffixes:
	.quad	0
	.quad	.L.str.44
	.quad	.L.str.157
	.quad	.L.str.161
	.quad	.L.str.162
	.quad	.L.str.163
	.quad	.L.str.158
	.quad	.L.str.164
	.quad	0
	.size	get_suffix.known_suffixes, 72

	.type	.L.str.161,@object      # @.str.161
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.161:
	.asciz	".taz"
	.size	.L.str.161, 5

	.type	.L.str.162,@object      # @.str.162
.L.str.162:
	.asciz	".tgz"
	.size	.L.str.162, 5

	.type	.L.str.163,@object      # @.str.163
.L.str.163:
	.asciz	"-gz"
	.size	.L.str.163, 4

	.type	.L.str.164,@object      # @.str.164
.L.str.164:
	.asciz	"_z"
	.size	.L.str.164, 3

	.type	.L.str.165,@object      # @.str.165
.L.str.165:
	.asciz	"z"
	.size	.L.str.165, 2

	.type	.L.str.166,@object      # @.str.166
.L.str.166:
	.asciz	"."
	.size	.L.str.166, 2

	.type	.L.str.167,@object      # @.str.167
.L.str.167:
	.asciz	".."
	.size	.L.str.167, 3

	.type	.L.str.168,@object      # @.str.168
.L.str.168:
	.asciz	"%s: %s/%s: pathname too long\n"
	.size	.L.str.168, 30

	.type	.L.str.169,@object      # @.str.169
.L.str.169:
	.asciz	"%s: %s: unknown suffix -- ignored\n"
	.size	.L.str.169, 35

	.type	.L.str.170,@object      # @.str.170
.L.str.170:
	.asciz	".tar"
	.size	.L.str.170, 5

	.type	.L.str.171,@object      # @.str.171
.L.str.171:
	.asciz	"%s: %s already has %s suffix -- unchanged\n"
	.size	.L.str.171, 43

	.type	.L.str.172,@object      # @.str.172
.L.str.172:
	.asciz	"%s: %s: warning, name truncated\n"
	.size	.L.str.172, 33

	.type	.L.str.173,@object      # @.str.173
.L.str.173:
	.asciz	"%s: %s: cannot %scompress onto itself\n"
	.size	.L.str.173, 39

	.type	.L.str.174,@object      # @.str.174
.L.str.174:
	.asciz	"%s: %s and %s are the same file\n"
	.size	.L.str.174, 33

	.type	.L.str.175,@object      # @.str.175
.L.str.175:
	.asciz	"%s: %s already exists;"
	.size	.L.str.175, 23

	.type	.L.str.176,@object      # @.str.176
.L.str.176:
	.asciz	" do you wish to overwrite (y or n)? "
	.size	.L.str.176, 37

	.type	.L.str.177,@object      # @.str.177
.L.str.177:
	.asciz	"\tnot overwritten\n"
	.size	.L.str.177, 18

	.type	.L.str.178,@object      # @.str.178
.L.str.178:
	.asciz	"name too short"
	.size	.L.str.178, 15

	.type	.L.str.179,@object      # @.str.179
.L.str.179:
	.asciz	"can't recover suffix\n"
	.size	.L.str.179, 22

	.type	.L.str.180,@object      # @.str.180
.L.str.180:
	.asciz	"internal error in shorten_name"
	.size	.L.str.180, 31

	.type	.L.str.181,@object      # @.str.181
.L.str.181:
	.asciz	"%s: time stamp restored\n"
	.size	.L.str.181, 25

	.type	do_list.first_time,@object # @do_list.first_time
	.data
	.p2align	2
do_list.first_time:
	.long	1                       # 0x1
	.size	do_list.first_time, 4

	.type	do_list.methods,@object # @do_list.methods
	.p2align	4
do_list.methods:
	.quad	.L.str.182
	.quad	.L.str.183
	.quad	.L.str.184
	.quad	.L.str.185
	.quad	.L.str.8
	.quad	.L.str.8
	.quad	.L.str.8
	.quad	.L.str.8
	.quad	.L.str.186
	.size	do_list.methods, 72

	.type	.L.str.182,@object      # @.str.182
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.182:
	.asciz	"store"
	.size	.L.str.182, 6

	.type	.L.str.183,@object      # @.str.183
.L.str.183:
	.asciz	"compr"
	.size	.L.str.183, 6

	.type	.L.str.184,@object      # @.str.184
.L.str.184:
	.asciz	"pack "
	.size	.L.str.184, 6

	.type	.L.str.185,@object      # @.str.185
.L.str.185:
	.asciz	"lzh  "
	.size	.L.str.185, 6

	.type	.L.str.186,@object      # @.str.186
.L.str.186:
	.asciz	"defla"
	.size	.L.str.186, 6

	.type	.L.str.187,@object      # @.str.187
.L.str.187:
	.asciz	"method  crc     date  time  "
	.size	.L.str.187, 29

	.type	.L.str.188,@object      # @.str.188
.L.str.188:
	.asciz	"%*.*s %*.*s  ratio uncompressed_name\n"
	.size	.L.str.188, 38

	.type	.L.str.189,@object      # @.str.189
.L.str.189:
	.asciz	"compressed"
	.size	.L.str.189, 11

	.type	.L.str.190,@object      # @.str.190
.L.str.190:
	.asciz	"uncompressed"
	.size	.L.str.190, 13

	.type	.L.str.191,@object      # @.str.191
.L.str.191:
	.asciz	"                            "
	.size	.L.str.191, 29

	.type	.L.str.192,@object      # @.str.192
.L.str.192:
	.asciz	" "
	.size	.L.str.192, 2

	.type	.L.str.193,@object      # @.str.193
.L.str.193:
	.asciz	" (totals)\n"
	.size	.L.str.193, 11

	.type	.L.str.194,@object      # @.str.194
.L.str.194:
	.asciz	"%5s %08lx %11s "
	.size	.L.str.194, 16

	.type	.L.str.195,@object      # @.str.195
.L.str.195:
	.asciz	" %s\n"
	.size	.L.str.195, 5

	.type	do_exit.in_exit,@object # @do_exit.in_exit
	.local	do_exit.in_exit
	.comm	do_exit.in_exit,4,4
	.type	bl_tree,@object         # @bl_tree
	.local	bl_tree
	.comm	bl_tree,156,16
	.type	heap_len,@object        # @heap_len
	.local	heap_len
	.comm	heap_len,4,4
	.type	heap_max,@object        # @heap_max
	.local	heap_max
	.comm	heap_max,4,4
	.type	heap,@object            # @heap
	.local	heap
	.comm	heap,2292,16
	.type	depth,@object           # @depth
	.local	depth
	.comm	depth,573,16
	.type	bl_desc,@object         # @bl_desc
	.data
	.p2align	3
bl_desc:
	.quad	bl_tree
	.quad	0
	.quad	extra_blbits
	.long	0                       # 0x0
	.long	19                      # 0x13
	.long	7                       # 0x7
	.long	0                       # 0x0
	.size	bl_desc, 40

	.type	bl_order,@object        # @bl_order
	.p2align	4
bl_order:
	.ascii	"\020\021\022\000\b\007\t\006\n\005\013\004\f\003\r\002\016\001\017"
	.size	bl_order, 19

	.type	extra_blbits,@object    # @extra_blbits
	.p2align	4
extra_blbits:
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	0                       # 0x0
	.long	2                       # 0x2
	.long	3                       # 0x3
	.long	7                       # 0x7
	.size	extra_blbits, 76

	.type	.L.str.196,@object      # @.str.196
	.section	.rodata.str1.1,"aMS",@progbits,1
.L.str.196:
	.asciz	"-l used on binary file"
	.size	.L.str.196, 23

	.type	j,@object               # @j
	.local	j
	.comm	j,4,4
	.type	blocksize,@object       # @blocksize
	.local	blocksize
	.comm	blocksize,4,4
	.type	io_bitbuf,@object       # @io_bitbuf
	.local	io_bitbuf
	.comm	io_bitbuf,2,2
	.type	subbitbuf,@object       # @subbitbuf
	.local	subbitbuf
	.comm	subbitbuf,4,4
	.type	bitcount,@object        # @bitcount
	.local	bitcount
	.comm	bitcount,4,4
	.type	decode.i,@object        # @decode.i
	.local	decode.i
	.comm	decode.i,4,4
	.type	pt_len,@object          # @pt_len
	.local	pt_len
	.comm	pt_len,19,16
	.type	pt_table,@object        # @pt_table
	.local	pt_table
	.comm	pt_table,512,16
	.type	.L.str.197,@object      # @.str.197
.L.str.197:
	.asciz	"Bad table\n"
	.size	.L.str.197, 11

	.type	.L.str.198,@object      # @.str.198
.L.str.198:
	.asciz	"invalid compressed data -- Huffman code > 32 bits"
	.size	.L.str.198, 50

	.type	.L.str.199,@object      # @.str.199
.L.str.199:
	.asciz	"too many leaves in Huffman tree"
	.size	.L.str.199, 32


	.ident	"clang version 4.0.1 (tags/RELEASE_401/final 324005)"
	.section	".note.GNU-stack","",@progbits
