	.text
	.file	"gzip.opt.bc"
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
	pushq	%r14
	pushq	%rbx
.Lcfi6:
	.cfi_offset %rbx, -32
.Lcfi7:
	.cfi_offset %r14, -24
	movq	%rdi, %r14
	movl	ifd(%rip), %edi
	movl	%esi, %edx
	movq	%r14, %rsi
	callq	read
	movq	%rax, %rbx
	testl	%ebx, %ebx
	je	.LBB1_4
# BB#1:                                 # %entry
	cmpl	$-1, %ebx
	jne	.LBB1_3
# BB#2:                                 # %if.then5
	callq	read_error
	movl	$-1, %ebx
	jmp	.LBB1_4
.LBB1_3:                                # %if.end6
	movq	%r14, %rdi
	movl	%ebx, %esi
	callq	updcrc
	movq	%rax, crc(%rip)
	movl	%ebx, %eax
	addq	%rax, bytes_in(%rip)
.LBB1_4:                                # %return
	movl	%ebx, %eax
	popq	%rbx
	popq	%r14
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
.Lcfi8:
	.cfi_def_cfa_offset 16
.Lcfi9:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi10:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi11:
	.cfi_offset %rbx, -32
.Lcfi12:
	.cfi_offset %r14, -24
	movl	%esi, %ebx
	movl	%edi, %r14d
	movl	bi_valid(%rip), %ecx
	movl	$16, %eax
	subl	%ebx, %eax
	movl	%r14d, %edx
	shll	%cl, %edx
	movzwl	bi_buf(%rip), %esi
	orl	%edx, %esi
	movw	%si, bi_buf(%rip)
	cmpl	%eax, %ecx
	jle	.LBB2_8
# BB#1:                                 # %if.then
	movl	outcnt(%rip), %eax
	movb	bi_buf(%rip), %cl
	leal	1(%rax), %edx
	movl	%edx, outcnt(%rip)
	cmpq	$16381, %rax            # imm = 0x3FFD
	movb	%cl, outbuf(%rax)
	ja	.LBB2_3
# BB#2:                                 # %if.then4
	movb	bi_buf+1(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	jmp	.LBB2_7
.LBB2_8:                                # %if.else42
	addl	bi_valid(%rip), %ebx
	jmp	.LBB2_9
.LBB2_3:                                # %if.else
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
	movzwl	%r14w, %eax
	movl	$16, %ecx
	subl	bi_valid(%rip), %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movw	%ax, bi_buf(%rip)
	movl	bi_valid(%rip), %eax
	leal	-16(%rax,%rbx), %ebx
.LBB2_9:                                # %if.end48
	movl	%ebx, bi_valid(%rip)
	popq	%rbx
	popq	%r14
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
.Lcfi13:
	.cfi_def_cfa_offset 16
.Lcfi14:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi15:
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
.Lcfi16:
	.cfi_def_cfa_offset 16
.Lcfi17:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi18:
	.cfi_def_cfa_register %rbp
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB4_1:                                # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movl	%edi, %ecx
	andl	$1, %ecx
	orl	%ecx, %eax
	shrl	%edi
	addl	%eax, %eax
	decl	%esi
	jg	.LBB4_1
# BB#2:                                 # %do.end
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
.Lcfi19:
	.cfi_def_cfa_offset 16
.Lcfi20:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi21:
	.cfi_def_cfa_register %rbp
	cmpl	$9, bi_valid(%rip)
	jl	.LBB5_6
# BB#1:                                 # %if.then
	movl	outcnt(%rip), %eax
	movb	bi_buf(%rip), %cl
	leal	1(%rax), %edx
	movl	%edx, outcnt(%rip)
	cmpq	$16381, %rax            # imm = 0x3FFD
	movb	%cl, outbuf(%rax)
	ja	.LBB5_3
# BB#2:                                 # %if.then2
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
.Lcfi22:
	.cfi_def_cfa_offset 16
.Lcfi23:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi24:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
.Lcfi25:
	.cfi_offset %rbx, -40
.Lcfi26:
	.cfi_offset %r14, -32
.Lcfi27:
	.cfi_offset %r15, -24
	movl	%edx, %r14d
	movl	%esi, %ebx
	movq	%rdi, %r15
	callq	bi_windup
	testl	%r14d, %r14d
	je	.LBB6_14
# BB#1:                                 # %if.then
	movl	outcnt(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, outcnt(%rip)
	cmpq	$16381, %rax            # imm = 0x3FFD
	movb	%bl, outbuf(%rax)
	ja	.LBB6_3
# BB#2:                                 # %if.then1
	movl	outcnt(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, outcnt(%rip)
	movb	%bh, outbuf(%rax)  # NOREX
	jmp	.LBB6_7
.LBB6_3:                                # %if.else
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB6_5
# BB#4:                                 # %if.then19
	callq	flush_outbuf
.LBB6_5:                                # %if.end
	movl	outcnt(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, outcnt(%rip)
	movb	%bh, outbuf(%rax)  # NOREX
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB6_7
# BB#6:                                 # %if.then29
	callq	flush_outbuf
.LBB6_7:                                # %if.end31
	movl	outcnt(%rip), %eax
	movl	%ebx, %edx
	notl	%edx
	leal	1(%rax), %ecx
	movl	%ecx, outcnt(%rip)
	cmpq	$16381, %rax            # imm = 0x3FFD
	movb	%dl, outbuf(%rax)
	ja	.LBB6_9
# BB#8:                                 # %if.then34
	movl	outcnt(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, outcnt(%rip)
	movb	%dh, outbuf(%rax)  # NOREX
	testl	%ebx, %ebx
	jne	.LBB6_15
	jmp	.LBB6_16
.LBB6_9:                                # %if.else50
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB6_11
# BB#10:                                # %if.then61
	movl	%edx, %r14d
	callq	flush_outbuf
	movl	%r14d, %edx
.LBB6_11:                               # %if.end62
	movl	outcnt(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, outcnt(%rip)
	movb	%dh, outbuf(%rax)  # NOREX
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB6_14
.LBB6_13:                               # %if.then73
	callq	flush_outbuf
.LBB6_14:                               # %while.cond
	testl	%ebx, %ebx
	je	.LBB6_16
.LBB6_15:                               # %while.body
	decl	%ebx
	movb	(%r15), %al
	incq	%r15
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	je	.LBB6_13
	jmp	.LBB6_14
.LBB6_16:                               # %while.end
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
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
.Lcfi28:
	.cfi_def_cfa_offset 16
.Lcfi29:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi30:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi31:
	.cfi_offset %rbx, -32
.Lcfi32:
	.cfi_offset %r14, -24
	movq	%rsi, %r14
	movl	%edi, %ebx
	testl	%ebx, %ebx
	jle	.LBB7_2
# BB#1:                                 # %entry
	cmpl	$10, %ebx
	jl	.LBB7_3
.LBB7_2:                                # %if.then
	movl	$.L.str, %edi
	callq	error
.LBB7_3:                                # %if.end
	movl	%ebx, compr_level(%rip)
	movl	$prev+65536, %edi
	xorl	%esi, %esi
	movl	$65536, %edx            # imm = 0x10000
	callq	memset
	movl	$4294967295, %eax       # imm = 0xFFFFFFFF
	movq	%rax, rsync_chunk_end(%rip)
	movq	$0, rsync_sum(%rip)
	movslq	%ebx, %rax
	movzwl	configuration_table+2(,%rax,8), %ecx
	movl	%ecx, max_lazy_match(%rip)
	movzwl	configuration_table(,%rax,8), %ecx
	movl	%ecx, good_match(%rip)
	movzwl	configuration_table+4(,%rax,8), %ecx
	movl	%ecx, nice_match(%rip)
	movzwl	configuration_table+6(,%rax,8), %eax
	movl	%eax, max_chain_length(%rip)
	cmpl	$9, %ebx
	je	.LBB7_4
# BB#5:                                 # %if.end
	cmpl	$1, %ebx
	jne	.LBB7_8
# BB#6:                                 # %if.then13
	movl	$4, %eax
	jmp	.LBB7_7
.LBB7_4:
	movl	$2, %eax
.LBB7_7:                                # %if.end23.sink.split
	movzwl	(%r14), %ecx
	orl	%eax, %ecx
	movw	%cx, (%r14)
.LBB7_8:                                # %if.end23
	movl	$0, strstart(%rip)
	movq	$0, block_start(%rip)
	movl	$window, %edi
	movl	$65536, %esi            # imm = 0x10000
	callq	*read_buf(%rip)
	movl	%eax, lookahead(%rip)
	testl	%eax, %eax
	je	.LBB7_10
# BB#9:                                 # %if.end23
	cmpl	$-1, %eax
	je	.LBB7_10
# BB#12:                                # %if.end30
	movl	$0, eofile(%rip)
	cmpl	$261, lookahead(%rip)   # imm = 0x105
	jbe	.LBB7_14
	jmp	.LBB7_16
	.p2align	4, 0x90
.LBB7_15:                               # %while.body
                                        #   in Loop: Header=BB7_14 Depth=1
	callq	fill_window
	cmpl	$261, lookahead(%rip)   # imm = 0x105
	ja	.LBB7_16
.LBB7_14:                               # %land.rhs
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$0, eofile(%rip)
	je	.LBB7_15
.LBB7_16:                               # %while.end
	movl	$0, ins_h(%rip)
	xorl	%eax, %eax
	cmpl	$1, %eax
	ja	.LBB7_11
	.p2align	4, 0x90
.LBB7_18:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	ins_h(%rip), %ecx
	shll	$5, %ecx
	movzbl	window(%rax), %edx
	xorl	%ecx, %edx
	andl	$32767, %edx            # imm = 0x7FFF
	movl	%edx, ins_h(%rip)
	incq	%rax
	cmpl	$1, %eax
	jbe	.LBB7_18
	jmp	.LBB7_11
.LBB7_10:                               # %if.then29
	movl	$1, eofile(%rip)
	movl	$0, lookahead(%rip)
.LBB7_11:                               # %for.end
	popq	%rbx
	popq	%r14
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
.Lcfi33:
	.cfi_def_cfa_offset 16
.Lcfi34:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi35:
	.cfi_def_cfa_register %rbp
	movq	%rdi, %r8
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.73, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	callq	abort_gzip
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
.Lcfi36:
	.cfi_def_cfa_offset 16
.Lcfi37:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi38:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi39:
	.cfi_offset %rbx, -24
	movl	window_size(%rip), %ebx
	subl	lookahead(%rip), %ebx
	subl	strstart(%rip), %ebx
	cmpl	$-1, %ebx
	je	.LBB9_1
# BB#2:                                 # %if.else
	cmpl	$65274, strstart(%rip)  # imm = 0xFEFA
	jb	.LBB9_11
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
	xorl	%eax, %eax
	cmpl	$32768, %eax            # imm = 0x8000
	jae	.LBB9_7
	.p2align	4, 0x90
.LBB9_16:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movzwl	prev+65536(%rax,%rax), %ecx
	movl	%ecx, %edx
	addl	$-32768, %edx           # imm = 0x8000
	sarw	$15, %cx
	andl	%edx, %ecx
	movw	%cx, prev+65536(%rax,%rax)
	incq	%rax
	cmpl	$32768, %eax            # imm = 0x8000
	jb	.LBB9_16
.LBB9_7:                                # %for.cond24.preheader
	xorl	%eax, %eax
	cmpl	$32767, %eax            # imm = 0x7FFF
	ja	.LBB9_10
	.p2align	4, 0x90
.LBB9_9:                                # %for.body27
                                        # =>This Inner Loop Header: Depth=1
	movzwl	prev(%rax,%rax), %ecx
	movl	%ecx, %edx
	addl	$-32768, %edx           # imm = 0x8000
	sarw	$15, %cx
	andl	%edx, %ecx
	movw	%cx, prev(%rax,%rax)
	incq	%rax
	cmpl	$32767, %eax            # imm = 0x7FFF
	jbe	.LBB9_9
.LBB9_10:                               # %for.end43
	addl	$32768, %ebx            # imm = 0x8000
	cmpl	$0, eofile(%rip)
	jne	.LBB9_15
	jmp	.LBB9_12
.LBB9_1:                                # %if.then
	decl	%ebx
.LBB9_11:                               # %if.end45
	cmpl	$0, eofile(%rip)
	jne	.LBB9_15
.LBB9_12:                               # %if.then46
	movl	strstart(%rip), %eax
	movl	lookahead(%rip), %ecx
	leaq	window(%rax,%rcx), %rdi
	movl	%ebx, %esi
	callq	*read_buf(%rip)
                                        # kill: %EAX<def> %EAX<kill> %RAX<def>
	leal	1(%rax), %ecx
	cmpl	$1, %ecx
	ja	.LBB9_14
# BB#13:                                # %if.then53
	movl	$1, eofile(%rip)
	jmp	.LBB9_15
.LBB9_14:                               # %if.else54
	addl	%eax, lookahead(%rip)
.LBB9_15:                               # %if.end57
	addq	$8, %rsp
	popq	%rbx
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
.Lcfi40:
	.cfi_def_cfa_offset 16
.Lcfi41:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi42:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
.Lcfi43:
	.cfi_offset %rbx, -40
.Lcfi44:
	.cfi_offset %r14, -32
.Lcfi45:
	.cfi_offset %r15, -24
                                        # kill: %EDI<def> %EDI<kill> %RDI<def>
	movl	max_chain_length(%rip), %eax
	movl	strstart(%rip), %edx
	leal	-32506(%rdx), %ebx
	xorl	%r10d, %r10d
	cmpq	$32506, %rdx            # imm = 0x7EFA
	leaq	window(%rdx), %rsi
	movslq	prev_length(%rip), %r14
	cmoval	%ebx, %r10d
	leaq	window+258(%rdx), %r8
	movb	window-1(%rdx,%r14), %r9b
	movb	window(%rdx,%r14), %r11b
	movl	%eax, %r15d
	shrl	$2, %r15d
	cmpl	good_match(%rip), %r14d
	cmovbl	%eax, %r15d
	.p2align	4, 0x90
.LBB10_1:                               # %do.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB10_10 Depth 2
	movl	%edi, %eax
	movslq	%r14d, %rbx
	movzbl	window(%rax,%rbx), %ecx
	movzbl	%r11b, %edx
	cmpl	%edx, %ecx
	jne	.LBB10_28
# BB#3:                                 # %lor.lhs.false
                                        #   in Loop: Header=BB10_1 Depth=1
	leaq	window(%rax), %rax
	movzbl	-1(%rax,%rbx), %ecx
	movzbl	%r9b, %edx
	cmpl	%edx, %ecx
	jne	.LBB10_28
# BB#5:                                 # %lor.lhs.false22
                                        #   in Loop: Header=BB10_1 Depth=1
	movzbl	(%rax), %ecx
	movzbl	(%rsi), %edx
	cmpl	%edx, %ecx
	jne	.LBB10_28
# BB#7:                                 # %lor.lhs.false27
                                        #   in Loop: Header=BB10_1 Depth=1
	movzbl	1(%rax), %ecx
	movzbl	1(%rsi), %edx
	cmpl	%edx, %ecx
	jne	.LBB10_28
# BB#9:                                 # %if.end34
                                        #   in Loop: Header=BB10_1 Depth=1
	incq	%rax
	addq	$2, %rsi
	incq	%rax
	.p2align	4, 0x90
.LBB10_10:                              # %do.body37
                                        #   Parent Loop BB10_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	1(%rsi), %ecx
	incq	%rsi
	movzbl	1(%rax), %edx
	incq	%rax
	cmpl	%edx, %ecx
	jne	.LBB10_18
# BB#11:                                # %land.lhs.true
                                        #   in Loop: Header=BB10_10 Depth=2
	movzbl	1(%rsi), %ecx
	incq	%rsi
	movzbl	1(%rax), %edx
	incq	%rax
	cmpl	%edx, %ecx
	jne	.LBB10_19
# BB#12:                                # %land.lhs.true50
                                        #   in Loop: Header=BB10_10 Depth=2
	movzbl	1(%rsi), %ecx
	incq	%rsi
	movzbl	1(%rax), %edx
	incq	%rax
	cmpl	%edx, %ecx
	jne	.LBB10_20
# BB#13:                                # %land.lhs.true57
                                        #   in Loop: Header=BB10_10 Depth=2
	movzbl	1(%rsi), %ecx
	incq	%rsi
	movzbl	1(%rax), %edx
	incq	%rax
	cmpl	%edx, %ecx
	jne	.LBB10_21
# BB#14:                                # %land.lhs.true64
                                        #   in Loop: Header=BB10_10 Depth=2
	movzbl	1(%rsi), %ecx
	incq	%rsi
	movzbl	1(%rax), %edx
	incq	%rax
	cmpl	%edx, %ecx
	jne	.LBB10_22
# BB#15:                                # %land.lhs.true71
                                        #   in Loop: Header=BB10_10 Depth=2
	movzbl	1(%rsi), %ecx
	incq	%rsi
	movzbl	1(%rax), %edx
	incq	%rax
	cmpl	%edx, %ecx
	jne	.LBB10_23
# BB#16:                                # %land.lhs.true78
                                        #   in Loop: Header=BB10_10 Depth=2
	movzbl	1(%rsi), %ecx
	incq	%rsi
	movzbl	1(%rax), %edx
	incq	%rax
	cmpl	%edx, %ecx
	jne	.LBB10_24
# BB#17:                                # %land.lhs.true85
                                        #   in Loop: Header=BB10_10 Depth=2
	movzbl	1(%rsi), %ecx
	incq	%rsi
	movzbl	1(%rax), %edx
	incq	%rax
	cmpl	%edx, %ecx
	sete	%cl
	cmpq	%r8, %rsi
	sbbb	%bl, %bl
	andb	%cl, %bl
	testb	%bl, %bl
	jne	.LBB10_10
	jmp	.LBB10_25
	.p2align	4, 0x90
.LBB10_18:                              #   in Loop: Header=BB10_10 Depth=2
	xorl	%ebx, %ebx
	testb	%bl, %bl
	jne	.LBB10_10
	jmp	.LBB10_25
	.p2align	4, 0x90
.LBB10_19:                              #   in Loop: Header=BB10_10 Depth=2
	xorl	%ebx, %ebx
	testb	%bl, %bl
	jne	.LBB10_10
	jmp	.LBB10_25
.LBB10_20:                              #   in Loop: Header=BB10_10 Depth=2
	xorl	%ebx, %ebx
	testb	%bl, %bl
	jne	.LBB10_10
	jmp	.LBB10_25
.LBB10_21:                              #   in Loop: Header=BB10_10 Depth=2
	xorl	%ebx, %ebx
	testb	%bl, %bl
	jne	.LBB10_10
	jmp	.LBB10_25
.LBB10_22:                              #   in Loop: Header=BB10_10 Depth=2
	xorl	%ebx, %ebx
	testb	%bl, %bl
	jne	.LBB10_10
	jmp	.LBB10_25
.LBB10_23:                              #   in Loop: Header=BB10_10 Depth=2
	xorl	%ebx, %ebx
	testb	%bl, %bl
	jne	.LBB10_10
	jmp	.LBB10_25
.LBB10_24:                              #   in Loop: Header=BB10_10 Depth=2
	xorl	%ebx, %ebx
	testb	%bl, %bl
	jne	.LBB10_10
.LBB10_25:                              # %do.end
                                        #   in Loop: Header=BB10_1 Depth=1
	movl	%r8d, %eax
	subl	%esi, %eax
	movslq	%eax, %rcx
	movl	$258, %eax              # imm = 0x102
	subq	%rcx, %rax
	leaq	-258(%r8), %rsi
	cmpl	%r14d, %eax
	jle	.LBB10_28
# BB#26:                                # %if.then99
                                        #   in Loop: Header=BB10_1 Depth=1
	movl	%edi, match_start(%rip)
	cmpl	nice_match(%rip), %eax
	jge	.LBB10_30
# BB#27:                                # %if.end103
                                        #   in Loop: Header=BB10_1 Depth=1
	movslq	%eax, %rcx
	movb	-1(%rsi,%rcx), %r9b
	movb	(%rsi,%rax), %r11b
	jmp	.LBB10_29
	.p2align	4, 0x90
.LBB10_28:                              #   in Loop: Header=BB10_1 Depth=1
	movl	%r14d, %eax
.LBB10_29:                              # %do.cond110
                                        #   in Loop: Header=BB10_1 Depth=1
	andl	$32767, %edi            # imm = 0x7FFF
	movzwl	prev(%rdi,%rdi), %edi
	movl	%r15d, %ecx
	decl	%ecx
	setne	%dl
	cmpl	%r10d, %edi
	seta	%bl
	cmoval	%ecx, %r15d
	testb	%dl, %bl
	movl	%eax, %r14d
	jne	.LBB10_1
.LBB10_30:                              # %do.end120
                                        # kill: %EAX<def> %EAX<kill> %RAX<kill>
	popq	%rbx
	popq	%r14
	popq	%r15
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
.Lcfi46:
	.cfi_def_cfa_offset 16
.Lcfi47:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi48:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
.Lcfi49:
	.cfi_offset %rbx, -56
.Lcfi50:
	.cfi_offset %r12, -48
.Lcfi51:
	.cfi_offset %r13, -40
.Lcfi52:
	.cfi_offset %r14, -32
.Lcfi53:
	.cfi_offset %r15, -24
	cmpl	$4, compr_level(%rip)
	jge	.LBB11_1
# BB#43:                                # %if.then
	callq	deflate_fast
	jmp	.LBB11_42
.LBB11_1:                               # %while.cond.preheader
	movl	$2, %ebx
	movl	$4294967295, %r12d      # imm = 0xFFFFFFFF
	xorl	%r13d, %r13d
                                        # implicit-def: %R14D
	jmp	.LBB11_2
	.p2align	4, 0x90
.LBB11_3:                               # %while.body
                                        #   in Loop: Header=BB11_2 Depth=1
	movl	ins_h(%rip), %eax
	shll	$5, %eax
	movl	strstart(%rip), %ecx
	addl	$2, %ecx
	movzbl	window(%rcx), %ecx
	xorl	%eax, %ecx
	andl	$32767, %ecx            # imm = 0x7FFF
	movl	%ecx, ins_h(%rip)
	movl	ins_h(%rip), %eax
	movzwl	prev+65536(%rax,%rax), %edi
	movl	strstart(%rip), %eax
	andl	$32767, %eax            # imm = 0x7FFF
	testl	%edi, %edi
	movw	%di, prev(%rax,%rax)
	movzwl	strstart(%rip), %eax
	movl	ins_h(%rip), %ecx
	movw	%ax, prev+65536(%rcx,%rcx)
	movl	%ebx, prev_length(%rip)
	movl	match_start(%rip), %r15d
	movl	$2, %ebx
	je	.LBB11_9
# BB#4:                                 # %land.lhs.true
                                        #   in Loop: Header=BB11_2 Depth=1
	movl	prev_length(%rip), %eax
	cmpl	max_lazy_match(%rip), %eax
	jae	.LBB11_9
# BB#5:                                 # %land.lhs.true16
                                        #   in Loop: Header=BB11_2 Depth=1
	movl	strstart(%rip), %eax
	subl	%edi, %eax
	cmpl	$32506, %eax            # imm = 0x7EFA
	ja	.LBB11_9
# BB#6:                                 # %land.lhs.true20
                                        #   in Loop: Header=BB11_2 Depth=1
	movl	strstart(%rip), %eax
	movq	window_size(%rip), %rcx
	movq	$-262, %rdx             # imm = 0xFEFA
	addq	%rdx, %rcx
	cmpq	%rcx, %rax
	ja	.LBB11_9
# BB#7:                                 # %if.then25
                                        #   in Loop: Header=BB11_2 Depth=1
	callq	longest_match
	movl	%eax, %ebx
	movl	lookahead(%rip), %eax
	cmpl	%eax, %ebx
	cmoval	%eax, %ebx
	cmpl	$3, %ebx
	jne	.LBB11_9
# BB#8:                                 # %land.lhs.true33
                                        #   in Loop: Header=BB11_2 Depth=1
	movl	strstart(%rip), %eax
	subl	match_start(%rip), %eax
	leal	-1(%rbx), %ecx
	cmpl	$4096, %eax             # imm = 0x1000
	cmoval	%ecx, %ebx
	.p2align	4, 0x90
.LBB11_9:                               # %if.end39
                                        #   in Loop: Header=BB11_2 Depth=1
	movl	prev_length(%rip), %eax
	cmpl	$3, %eax
	jb	.LBB11_20
# BB#10:                                # %if.end39
                                        #   in Loop: Header=BB11_2 Depth=1
	cmpl	%eax, %ebx
	ja	.LBB11_20
# BB#11:                                # %if.then45
                                        #   in Loop: Header=BB11_2 Depth=1
	movl	strstart(%rip), %edi
	decl	%edi
	subl	%r15d, %edi
	movl	prev_length(%rip), %esi
	addl	$-3, %esi
	callq	ct_tally
	movl	%eax, %r14d
	movl	prev_length(%rip), %eax
	decl	%eax
	subl	%eax, lookahead(%rip)
	addl	$-2, prev_length(%rip)
	cmpl	$0, rsync(%rip)
	je	.LBB11_13
# BB#12:                                # %if.then53
                                        #   in Loop: Header=BB11_2 Depth=1
	movl	strstart(%rip), %edi
	movl	prev_length(%rip), %esi
	incl	%esi
	callq	rsync_roll
	.p2align	4, 0x90
.LBB11_13:                              # %do.body56
                                        #   Parent Loop BB11_2 Depth=1
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
	movl	strstart(%rip), %ecx
	andl	$32767, %ecx            # imm = 0x7FFF
	movw	%ax, prev(%rcx,%rcx)
	movzwl	strstart(%rip), %eax
	movl	ins_h(%rip), %ecx
	movw	%ax, prev+65536(%rcx,%rcx)
	decl	prev_length(%rip)
	jne	.LBB11_13
# BB#14:                                # %do.end78
                                        #   in Loop: Header=BB11_2 Depth=1
	incl	strstart(%rip)
	cmpl	$0, rsync(%rip)
	je	.LBB11_17
# BB#15:                                # %land.lhs.true81
                                        #   in Loop: Header=BB11_2 Depth=1
	movl	strstart(%rip), %eax
	cmpq	rsync_chunk_end(%rip), %rax
	jbe	.LBB11_17
# BB#16:                                # %if.then85
                                        #   in Loop: Header=BB11_2 Depth=1
	movq	%r12, rsync_chunk_end(%rip)
	movl	$2, %r14d
.LBB11_17:                              # %if.end86
                                        #   in Loop: Header=BB11_2 Depth=1
	movl	$2, %ebx
	testl	%r14d, %r14d
	je	.LBB11_18
# BB#19:                                # %if.then88
                                        #   in Loop: Header=BB11_2 Depth=1
	movq	block_start(%rip), %rax
	xorl	%r13d, %r13d
	testq	%rax, %rax
	movl	%eax, %ecx
	leaq	window(%rcx), %rdi
	cmovsq	%r13, %rdi
	movl	strstart(%rip), %esi
	subq	%rax, %rsi
	leal	-1(%r14), %edx
	xorl	%ecx, %ecx
	callq	flush_block
	movl	strstart(%rip), %eax
	movq	%rax, block_start(%rip)
	cmpl	$261, lookahead(%rip)   # imm = 0x105
	jbe	.LBB11_37
	jmp	.LBB11_2
	.p2align	4, 0x90
.LBB11_20:                              # %if.else
                                        #   in Loop: Header=BB11_2 Depth=1
	testl	%r13d, %r13d
	je	.LBB11_28
# BB#21:                                # %if.then101
                                        #   in Loop: Header=BB11_2 Depth=1
	movl	strstart(%rip), %eax
	decl	%eax
	movzbl	window(%rax), %esi
	xorl	%edi, %edi
	callq	ct_tally
	movl	%eax, %r14d
	cmpl	$0, rsync(%rip)
	je	.LBB11_24
# BB#22:                                # %land.lhs.true108
                                        #   in Loop: Header=BB11_2 Depth=1
	movl	strstart(%rip), %eax
	cmpq	rsync_chunk_end(%rip), %rax
	jbe	.LBB11_24
# BB#23:                                # %if.then112
                                        #   in Loop: Header=BB11_2 Depth=1
	movq	%r12, rsync_chunk_end(%rip)
	movl	$2, %r14d
.LBB11_24:                              # %if.end113
                                        #   in Loop: Header=BB11_2 Depth=1
	testl	%r14d, %r14d
	je	.LBB11_26
# BB#25:                                # %if.then115
                                        #   in Loop: Header=BB11_2 Depth=1
	movq	block_start(%rip), %rax
	testq	%rax, %rax
	movl	%eax, %ecx
	leaq	window(%rcx), %rdi
	movl	$0, %ecx
	cmovsq	%rcx, %rdi
	movl	strstart(%rip), %esi
	subq	%rax, %rsi
	leal	-1(%r14), %edx
	xorl	%ecx, %ecx
	callq	flush_block
	movl	strstart(%rip), %eax
	movq	%rax, block_start(%rip)
.LBB11_26:                              # %do.body131
                                        #   in Loop: Header=BB11_2 Depth=1
	cmpl	$0, rsync(%rip)
	je	.LBB11_35
# BB#27:                                # %if.then133
                                        #   in Loop: Header=BB11_2 Depth=1
	movl	strstart(%rip), %edi
	jmp	.LBB11_34
.LBB11_18:                              #   in Loop: Header=BB11_2 Depth=1
	xorl	%r13d, %r13d
	cmpl	$261, lookahead(%rip)   # imm = 0x105
	jbe	.LBB11_37
	jmp	.LBB11_2
.LBB11_28:                              # %if.else139
                                        #   in Loop: Header=BB11_2 Depth=1
	cmpl	$0, rsync(%rip)
	je	.LBB11_31
# BB#29:                                # %land.lhs.true141
                                        #   in Loop: Header=BB11_2 Depth=1
	movl	strstart(%rip), %eax
	cmpq	rsync_chunk_end(%rip), %rax
	jbe	.LBB11_31
# BB#30:                                # %if.then145
                                        #   in Loop: Header=BB11_2 Depth=1
	movq	%r12, rsync_chunk_end(%rip)
	movq	block_start(%rip), %rax
	testq	%rax, %rax
	movl	%eax, %ecx
	leaq	window(%rcx), %rdi
	movl	$0, %ecx
	cmovsq	%rcx, %rdi
	movl	strstart(%rip), %esi
	subq	%rax, %rsi
	movl	$1, %edx
	xorl	%ecx, %ecx
	callq	flush_block
	movl	strstart(%rip), %eax
	movq	%rax, block_start(%rip)
	movl	$2, %r14d
.LBB11_31:                              # %do.body161
                                        #   in Loop: Header=BB11_2 Depth=1
	cmpl	$0, rsync(%rip)
	je	.LBB11_32
# BB#33:                                # %if.then163
                                        #   in Loop: Header=BB11_2 Depth=1
	movl	strstart(%rip), %edi
	movl	$1, %r13d
.LBB11_34:                              # %if.end169
                                        #   in Loop: Header=BB11_2 Depth=1
	movl	$1, %esi
	callq	rsync_roll
.LBB11_35:                              # %if.end169
                                        #   in Loop: Header=BB11_2 Depth=1
	incl	strstart(%rip)
	decl	lookahead(%rip)
	cmpl	$261, lookahead(%rip)   # imm = 0x105
	jbe	.LBB11_37
	jmp	.LBB11_2
	.p2align	4, 0x90
.LBB11_38:                              # %while.body175
                                        #   in Loop: Header=BB11_37 Depth=2
	callq	fill_window
	cmpl	$261, lookahead(%rip)   # imm = 0x105
	ja	.LBB11_2
.LBB11_37:                              # %land.rhs
                                        #   Parent Loop BB11_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	$0, eofile(%rip)
	je	.LBB11_38
	jmp	.LBB11_2
.LBB11_32:                              #   in Loop: Header=BB11_2 Depth=1
	movl	$1, %r13d
	jmp	.LBB11_35
	.p2align	4, 0x90
.LBB11_2:                               # %while.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB11_13 Depth 2
                                        #     Child Loop BB11_37 Depth 2
	cmpl	$0, lookahead(%rip)
	jne	.LBB11_3
# BB#39:                                # %while.end176
	testl	%r13d, %r13d
	je	.LBB11_41
# BB#40:                                # %if.then178
	movl	strstart(%rip), %eax
	decl	%eax
	movzbl	window(%rax), %esi
	xorl	%edi, %edi
	callq	ct_tally
.LBB11_41:                              # %if.end184
	movq	block_start(%rip), %rax
	xorl	%edi, %edi
	testq	%rax, %rax
	movl	%eax, %ecx
	leaq	window(%rcx), %rcx
	cmovnsq	%rcx, %rdi
	movl	strstart(%rip), %esi
	subq	%rax, %rsi
	decl	%r14d
	movl	$1, %ecx
	movl	%r14d, %edx
	callq	flush_block
.LBB11_42:                              # %return
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
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
.Lcfi54:
	.cfi_def_cfa_offset 16
.Lcfi55:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi56:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
.Lcfi57:
	.cfi_offset %rbx, -56
.Lcfi58:
	.cfi_offset %r12, -48
.Lcfi59:
	.cfi_offset %r13, -40
.Lcfi60:
	.cfi_offset %r14, -32
.Lcfi61:
	.cfi_offset %r15, -24
	movl	$2, prev_length(%rip)
	xorl	%r15d, %r15d
	movq	$-262, %r12             # imm = 0xFEFA
	movl	$4294967295, %r13d      # imm = 0xFFFFFFFF
	xorl	%ebx, %ebx
                                        # implicit-def: %R14D
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
	movzwl	prev+65536(%rax,%rax), %edi
	movl	strstart(%rip), %eax
	andl	$32767, %eax            # imm = 0x7FFF
	testl	%edi, %edi
	movw	%di, prev(%rax,%rax)
	movzwl	strstart(%rip), %eax
	movl	ins_h(%rip), %ecx
	movw	%ax, prev+65536(%rcx,%rcx)
	je	.LBB12_6
# BB#3:                                 # %land.lhs.true
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	strstart(%rip), %eax
	subl	%edi, %eax
	cmpl	$32506, %eax            # imm = 0x7EFA
	ja	.LBB12_6
# BB#4:                                 # %land.lhs.true16
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	strstart(%rip), %eax
	movq	window_size(%rip), %rcx
	addq	%r12, %rcx
	cmpq	%rcx, %rax
	ja	.LBB12_6
# BB#5:                                 # %if.then
                                        #   in Loop: Header=BB12_1 Depth=1
	callq	longest_match
	movl	%eax, %ebx
	movl	lookahead(%rip), %eax
	cmpl	%eax, %ebx
	cmoval	%eax, %ebx
	.p2align	4, 0x90
.LBB12_6:                               # %if.end24
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	strstart(%rip), %edi
	cmpl	$3, %ebx
	jb	.LBB12_13
# BB#7:                                 # %if.then27
                                        #   in Loop: Header=BB12_1 Depth=1
	subl	match_start(%rip), %edi
	leal	-3(%rbx), %esi
                                        # kill: %EDI<def> %EDI<kill> %RDI<kill>
	callq	ct_tally
	movl	%eax, %r14d
	subl	%ebx, lookahead(%rip)
	cmpl	$0, rsync(%rip)
	je	.LBB12_9
# BB#8:                                 # %if.then32
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	strstart(%rip), %edi
	movl	%ebx, %esi
	callq	rsync_roll
.LBB12_9:                               # %do.end
                                        #   in Loop: Header=BB12_1 Depth=1
	cmpl	max_lazy_match(%rip), %ebx
	ja	.LBB12_12
# BB#10:                                # %if.then36
                                        #   in Loop: Header=BB12_1 Depth=1
	decl	%ebx
	.p2align	4, 0x90
.LBB12_11:                              # %do.body37
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
	movl	strstart(%rip), %ecx
	andl	$32767, %ecx            # imm = 0x7FFF
	movw	%ax, prev(%rcx,%rcx)
	movzwl	strstart(%rip), %eax
	movl	ins_h(%rip), %ecx
	movw	%ax, prev+65536(%rcx,%rcx)
	decl	%ebx
	jne	.LBB12_11
	jmp	.LBB12_16
	.p2align	4, 0x90
.LBB12_13:                              # %if.else73
                                        #   in Loop: Header=BB12_1 Depth=1
	movzbl	window(%rdi), %esi
	xorl	%edi, %edi
	callq	ct_tally
	movl	%eax, %r14d
	cmpl	$0, rsync(%rip)
	je	.LBB12_15
# BB#14:                                # %if.then80
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	strstart(%rip), %edi
	movl	$1, %esi
	callq	rsync_roll
.LBB12_15:                              # %do.end83
                                        #   in Loop: Header=BB12_1 Depth=1
	decl	lookahead(%rip)
.LBB12_16:                              # %if.end86
                                        #   in Loop: Header=BB12_1 Depth=1
	incl	strstart(%rip)
	cmpl	$0, rsync(%rip)
	jne	.LBB12_18
	jmp	.LBB12_20
	.p2align	4, 0x90
.LBB12_12:                              # %if.else
                                        #   in Loop: Header=BB12_1 Depth=1
	addl	%ebx, strstart(%rip)
	movl	strstart(%rip), %eax
	movzbl	window(%rax), %eax
	movl	%eax, ins_h(%rip)
	shll	$5, %eax
	movl	strstart(%rip), %ecx
	incl	%ecx
	movzbl	window(%rcx), %ecx
	xorl	%eax, %ecx
	movl	%ecx, ins_h(%rip)
	xorl	%ebx, %ebx
	cmpl	$0, rsync(%rip)
	je	.LBB12_20
.LBB12_18:                              # %land.lhs.true88
                                        #   in Loop: Header=BB12_1 Depth=1
	movl	strstart(%rip), %eax
	cmpq	rsync_chunk_end(%rip), %rax
	jbe	.LBB12_20
# BB#19:                                # %if.then92
                                        #   in Loop: Header=BB12_1 Depth=1
	movq	%r13, rsync_chunk_end(%rip)
	movl	$2, %r14d
.LBB12_20:                              # %if.end93
                                        #   in Loop: Header=BB12_1 Depth=1
	testl	%r14d, %r14d
	je	.LBB12_22
# BB#21:                                # %if.then95
                                        #   in Loop: Header=BB12_1 Depth=1
	movq	block_start(%rip), %rax
	testq	%rax, %rax
	movl	%eax, %ecx
	leaq	window(%rcx), %rdi
	cmovsq	%r15, %rdi
	movl	strstart(%rip), %esi
	subq	%rax, %rsi
	leal	-1(%r14), %edx
	xorl	%ecx, %ecx
	callq	flush_block
	movl	strstart(%rip), %eax
	movq	%rax, block_start(%rip)
	cmpl	$261, lookahead(%rip)   # imm = 0x105
	jbe	.LBB12_23
	jmp	.LBB12_1
	.p2align	4, 0x90
.LBB12_24:                              # %while.body111
                                        #   in Loop: Header=BB12_1 Depth=1
	callq	fill_window
.LBB12_22:                              # %while.cond107
                                        #   in Loop: Header=BB12_1 Depth=1
	cmpl	$261, lookahead(%rip)   # imm = 0x105
	ja	.LBB12_1
.LBB12_23:                              # %land.rhs
                                        #   in Loop: Header=BB12_1 Depth=1
	cmpl	$0, eofile(%rip)
	je	.LBB12_24
.LBB12_1:                               # %while.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB12_11 Depth 2
	cmpl	$0, lookahead(%rip)
	jne	.LBB12_2
# BB#25:                                # %while.end112
	movq	block_start(%rip), %rax
	xorl	%edi, %edi
	testq	%rax, %rax
	movl	%eax, %ecx
	leaq	window(%rcx), %rcx
	cmovnsq	%rcx, %rdi
	movl	strstart(%rip), %esi
	subq	%rax, %rsi
	decl	%r14d
	movl	$1, %ecx
	movl	%r14d, %edx
	callq	flush_block
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
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
.Lcfi62:
	.cfi_def_cfa_offset 16
.Lcfi63:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi64:
	.cfi_def_cfa_register %rbp
	movl	last_lit(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, last_lit(%rip)
	movb	%sil, inbuf(%rax)
	testl	%edi, %edi
	je	.LBB13_1
# BB#2:                                 # %if.else
	decl	%edi
	movslq	%esi, %rax
	movzbl	length_code(%rax), %eax
	incw	dyn_ltree+1028(,%rax,4)
	movl	%edi, %eax
	sarl	$7, %eax
	addl	$256, %eax              # imm = 0x100
	cmpl	$256, %edi              # imm = 0x100
	cmovll	%edi, %eax
	cltq
	movzbl	dist_code(%rax), %eax
	incw	dyn_dtree(,%rax,4)
	movl	last_dist(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, last_dist(%rip)
	movw	%di, d_buf(%rax,%rax)
	movzbl	flag_bit(%rip), %eax
	movzbl	flags(%rip), %ecx
	orl	%eax, %ecx
	movb	%cl, flags(%rip)
	jmp	.LBB13_3
.LBB13_1:                               # %if.then
	movslq	%esi, %rax
	incw	dyn_ltree(,%rax,4)
.LBB13_3:                               # %if.end
	shlb	flag_bit(%rip)
	testb	$7, last_lit(%rip)
	jne	.LBB13_5
# BB#4:                                 # %if.then39
	movb	flags(%rip), %al
	movl	last_flags(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, last_flags(%rip)
	movb	%al, flag_buf(%rcx)
	movb	$0, flags(%rip)
	movb	$1, flag_bit(%rip)
.LBB13_5:                               # %if.end43
	cmpl	$3, level(%rip)
	jl	.LBB13_12
# BB#6:                                 # %land.lhs.true
	movzwl	last_lit(%rip), %eax
	testw	$4095, %ax              # imm = 0xFFF
	je	.LBB13_7
.LBB13_12:                              # %if.end75
	cmpl	$32767, last_lit(%rip)  # imm = 0x7FFF
	sete	%al
	cmpl	$32768, last_dist(%rip) # imm = 0x8000
	sete	%cl
	orb	%al, %cl
	movzbl	%cl, %eax
.LBB13_13:                              # %return
	popq	%rbp
	retq
.LBB13_7:                               # %if.then49
	movl	last_lit(%rip), %ecx
	shlq	$3, %rcx
	movl	strstart(%rip), %edx
	subq	block_start(%rip), %rdx
	xorl	%eax, %eax
	cmpl	$29, %eax
	jg	.LBB13_10
	.p2align	4, 0x90
.LBB13_9:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movzwl	dyn_dtree(,%rax,4), %esi
	movslq	extra_dbits(,%rax,4), %rdi
	addq	$5, %rdi
	imulq	%rsi, %rdi
	addq	%rdi, %rcx
	incq	%rax
	cmpl	$29, %eax
	jle	.LBB13_9
.LBB13_10:                              # %for.end
	movl	last_lit(%rip), %eax
	shrl	%eax
	cmpl	%eax, last_dist(%rip)
	jae	.LBB13_12
# BB#11:                                # %for.end
	shrq	$3, %rcx
	shrq	%rdx
	movl	$1, %eax
	cmpq	%rdx, %rcx
	jb	.LBB13_13
	jmp	.LBB13_12
.Lfunc_end13:
	.size	ct_tally, .Lfunc_end13-ct_tally
	.cfi_endproc

	.p2align	4, 0x90
	.type	rsync_roll,@function
rsync_roll:                             # @rsync_roll
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
                                        # kill: %ESI<def> %ESI<kill> %RSI<def>
	cmpl	$4095, %edi             # imm = 0xFFF
	ja	.LBB14_6
# BB#1:                                 # %for.cond.preheader
	movl	%edi, %eax
	movl	%esi, %ecx
	cmpl	$4095, %eax             # imm = 0xFFF
	jbe	.LBB14_3
	jmp	.LBB14_5
	.p2align	4, 0x90
.LBB14_4:                               # %if.end
                                        #   in Loop: Header=BB14_3 Depth=1
	movzbl	window(%rax), %edx
	addq	%rdx, rsync_sum(%rip)
	incq	%rax
	decl	%ecx
	cmpl	$4095, %eax             # imm = 0xFFF
	ja	.LBB14_5
.LBB14_3:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	testl	%ecx, %ecx
	jne	.LBB14_4
	jmp	.LBB14_12
.LBB14_5:                               # %for.end
	movl	$4096, %eax             # imm = 0x1000
	subl	%edi, %eax
	subl	%eax, %esi
	movl	$4096, %edi             # imm = 0x1000
.LBB14_6:                               # %if.end6
	movl	%edi, %eax
	movl	$4294967295, %r8d       # imm = 0xFFFFFFFF
	movq	%rax, %rdx
	jmp	.LBB14_7
	.p2align	4, 0x90
.LBB14_11:                              # %for.inc28
                                        #   in Loop: Header=BB14_7 Depth=1
	incq	%rdx
.LBB14_7:                               # %for.cond7
                                        # =>This Inner Loop Header: Depth=1
	leal	(%rax,%rsi), %edi
	cmpl	%edi, %edx
	jae	.LBB14_12
# BB#8:                                 # %for.body11
                                        #   in Loop: Header=BB14_7 Depth=1
	movzbl	window(%rdx), %edi
	addq	rsync_sum(%rip), %rdi
	movq	%rdi, rsync_sum(%rip)
	leal	-4096(%rdx), %ecx
	movzbl	window(%rcx), %ecx
	subq	%rcx, %rdi
	movq	%rdi, rsync_sum(%rip)
	cmpq	%r8, rsync_chunk_end(%rip)
	jne	.LBB14_11
# BB#9:                                 # %land.lhs.true
                                        #   in Loop: Header=BB14_7 Depth=1
	movzwl	rsync_sum(%rip), %ecx
	testw	$4095, %cx              # imm = 0xFFF
	jne	.LBB14_11
# BB#10:                                # %if.then25
                                        #   in Loop: Header=BB14_7 Depth=1
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
.Lcfi68:
	.cfi_def_cfa_offset 16
.Lcfi69:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi70:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
.Lcfi71:
	.cfi_offset %rbx, -56
.Lcfi72:
	.cfi_offset %r12, -48
.Lcfi73:
	.cfi_offset %r13, -40
.Lcfi74:
	.cfi_offset %r14, -32
.Lcfi75:
	.cfi_offset %r15, -24
	movl	%ecx, %r12d
	movl	%edx, %r15d
	movq	%rsi, %rbx
	movq	%rdi, %r14
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
	movl	%eax, %r13d
	movq	opt_len(%rip), %rax
	addq	$10, %rax
	shrq	$3, %rax
	movq	static_len(%rip), %rcx
	addq	$10, %rcx
	shrq	$3, %rcx
	addq	%rbx, input_len(%rip)
	cmpq	%rax, %rcx
	cmovbeq	%rcx, %rax
	leaq	4(%rbx), %rdx
	cmpq	%rax, %rdx
	ja	.LBB15_5
# BB#3:                                 # %if.end
	testq	%r14, %r14
	je	.LBB15_5
# BB#4:                                 # %if.then29
	movl	$3, %esi
	movl	%r12d, %edi
	callq	send_bits
	movq	compressed_len(%rip), %rax
	addq	$10, %rax
	andq	$-8, %rax
	movq	%rax, compressed_len(%rip)
	leaq	32(%rax,%rbx,8), %rax
	movq	%rax, compressed_len(%rip)
	movl	$1, %edx
	movq	%r14, %rdi
	movl	%ebx, %esi
	callq	copy_block
	jmp	.LBB15_9
.LBB15_5:                               # %if.else37
	cmpq	%rax, %rcx
	jne	.LBB15_7
# BB#6:                                 # %if.then40
	leal	2(%r12), %edi
	movl	$3, %esi
	callq	send_bits
	movl	$static_ltree, %edi
	movl	$static_dtree, %esi
	callq	compress_block
	movl	$static_len, %eax
	jmp	.LBB15_8
.LBB15_7:                               # %if.else44
	leal	4(%r12), %edi
	movl	$3, %esi
	callq	send_bits
	movl	l_desc+36(%rip), %edi
	incl	%edi
	movl	d_desc+36(%rip), %esi
	incl	%esi
	incl	%r13d
	movl	%r13d, %edx
	callq	send_all_trees
	movl	$dyn_ltree, %edi
	movl	$dyn_dtree, %esi
	callq	compress_block
	movl	$opt_len, %eax
.LBB15_8:                               # %if.end51
	movq	(%rax), %rax
	movq	compressed_len(%rip), %rcx
	leaq	3(%rcx,%rax), %rax
	movq	%rax, compressed_len(%rip)
.LBB15_9:                               # %if.end53
	callq	init_block
	testl	%r12d, %r12d
	je	.LBB15_11
# BB#10:                                # %if.then55
	callq	bi_windup
	addq	$7, compressed_len(%rip)
	jmp	.LBB15_14
.LBB15_11:                              # %if.else57
	testl	%r15d, %r15d
	je	.LBB15_14
# BB#12:                                # %land.lhs.true59
	movq	compressed_len(%rip), %rax
	movq	%rax, %rcx
	sarq	$63, %rcx
	shrq	$61, %rcx
	addq	%rax, %rcx
	andq	$-8, %rcx
	cmpq	%rcx, %rax
	je	.LBB15_14
# BB#13:                                # %if.then62
	movl	$3, %esi
	movl	%r12d, %edi
	callq	send_bits
	movq	compressed_len(%rip), %rax
	addq	$10, %rax
	andq	$-8, %rax
	movq	%rax, compressed_len(%rip)
	xorl	%esi, %esi
	movl	$1, %edx
	movq	%r14, %rdi
	callq	copy_block
.LBB15_14:                              # %if.end68
	movq	compressed_len(%rip), %rax
	sarq	$3, %rax
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
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
.Lcfi76:
	.cfi_def_cfa_offset 16
.Lcfi77:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi78:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$72, %rsp
.Lcfi79:
	.cfi_offset %rbx, -56
.Lcfi80:
	.cfi_offset %r12, -48
.Lcfi81:
	.cfi_offset %r13, -40
.Lcfi82:
	.cfi_offset %r14, -32
.Lcfi83:
	.cfi_offset %r15, -24
	movq	%rdx, %r13
	xorl	%eax, %eax
	cmpb	$58, (%r13)
	movl	%r9d, -48(%rbp)         # 4-byte Spill
	movq	%r8, %rbx
	movq	%rcx, -56(%rbp)         # 8-byte Spill
	movq	%rsi, %r15
	movl	%edi, %r12d
	cmovnel	opterr(%rip), %eax
	movl	%eax, -44(%rbp)         # 4-byte Spill
	movl	$-1, %r14d
	testl	%r12d, %r12d
	jle	.LBB16_123
# BB#1:                                 # %if.end5
	movq	$0, optarg(%rip)
	cmpl	$0, optind(%rip)
	je	.LBB16_3
# BB#2:                                 # %if.end5
	movl	__getopt_initialized(%rip), %eax
	testl	%eax, %eax
	jne	.LBB16_6
.LBB16_3:                               # %if.then8
	cmpl	$0, optind(%rip)
	jne	.LBB16_5
# BB#4:                                 # %if.then11
	movl	$1, optind(%rip)
.LBB16_5:                               # %if.end12
	movl	%r12d, %edi
	movq	%r15, %rsi
	movq	%r13, %rdx
	callq	_getopt_initialize
	movq	%rax, %r13
	movl	$1, __getopt_initialized(%rip)
.LBB16_6:                               # %if.end13
	cmpq	$0, nextchar(%rip)
	je	.LBB16_26
# BB#7:                                 # %lor.lhs.false16
	movq	nextchar(%rip), %rax
	cmpb	$0, (%rax)
	je	.LBB16_26
.LBB16_8:                               # %if.end121
	movq	%rbx, -112(%rbp)        # 8-byte Spill
	cmpq	$0, -56(%rbp)           # 8-byte Folded Reload
	movl	%r12d, -60(%rbp)        # 4-byte Spill
	je	.LBB16_81
# BB#9:                                 # %land.lhs.true124
	movslq	optind(%rip), %rax
	movq	(%r15,%rax,8), %rax
	cmpb	$45, 1(%rax)
	je	.LBB16_12
# BB#10:                                # %lor.lhs.false131
	cmpl	$0, -48(%rbp)           # 4-byte Folded Reload
	je	.LBB16_81
# BB#11:                                # %land.lhs.true133
	movslq	optind(%rip), %rax
	movq	(%r15,%rax,8), %rax
	cmpb	$0, 2(%rax)
	je	.LBB16_80
.LBB16_12:                              # %if.then146
	movq	nextchar(%rip), %rbx
	cmpb	$0, (%rbx)
	je	.LBB16_15
	.p2align	4, 0x90
.LBB16_14:                              # %land.rhs149
                                        # =>This Inner Loop Header: Depth=1
	cmpb	$61, (%rbx)
	je	.LBB16_15
# BB#13:                                # %for.inc
                                        #   in Loop: Header=BB16_14 Depth=1
	incq	%rbx
	cmpb	$0, (%rbx)
	jne	.LBB16_14
.LBB16_15:                              # %for.cond155.preheader
	movq	%r13, -96(%rbp)         # 8-byte Spill
	movq	%r15, -72(%rbp)         # 8-byte Spill
	movl	$-1, -84(%rbp)          # 4-byte Folded Spill
	xorl	%eax, %eax
	movq	%rax, -104(%rbp)        # 8-byte Spill
	xorl	%r14d, %r14d
	movl	$0, -80(%rbp)           # 4-byte Folded Spill
	xorl	%r13d, %r13d
	movq	-56(%rbp), %r15         # 8-byte Reload
	cmpq	$0, (%r15)
	je	.LBB16_48
	.p2align	4, 0x90
.LBB16_17:                              # %for.body157
                                        # =>This Inner Loop Header: Depth=1
	movq	(%r15), %rdi
	movq	nextchar(%rip), %rsi
	movq	%rbx, %rdx
	subq	%rsi, %rdx
	callq	strncmp
	testl	%eax, %eax
	jne	.LBB16_16
# BB#18:                                # %if.then161
                                        #   in Loop: Header=BB16_17 Depth=1
	movl	nextchar(%rip), %eax
	movl	%ebx, %r12d
	subl	%eax, %r12d
	movq	(%r15), %rdi
	callq	strlen
	cmpl	%eax, %r12d
	je	.LBB16_61
# BB#19:                                # %if.else172
                                        #   in Loop: Header=BB16_17 Depth=1
	testq	%r13, %r13
	movl	-60(%rbp), %r12d        # 4-byte Reload
	je	.LBB16_25
# BB#20:                                # %if.else176
                                        #   in Loop: Header=BB16_17 Depth=1
	cmpl	$0, -48(%rbp)           # 4-byte Folded Reload
	jne	.LBB16_24
# BB#21:                                # %lor.lhs.false178
                                        #   in Loop: Header=BB16_17 Depth=1
	movl	8(%r13), %eax
	cmpl	8(%r15), %eax
	jne	.LBB16_24
# BB#22:                                # %lor.lhs.false182
                                        #   in Loop: Header=BB16_17 Depth=1
	movq	16(%r13), %rax
	cmpq	16(%r15), %rax
	jne	.LBB16_24
# BB#23:                                # %lor.lhs.false186
                                        #   in Loop: Header=BB16_17 Depth=1
	movl	24(%r13), %eax
	cmpl	24(%r15), %eax
	je	.LBB16_16
	.p2align	4, 0x90
.LBB16_24:                              # %if.then190
                                        #   in Loop: Header=BB16_17 Depth=1
	movl	$1, -80(%rbp)           # 4-byte Folded Spill
	jmp	.LBB16_16
.LBB16_25:                              #   in Loop: Header=BB16_17 Depth=1
	movl	%r14d, -84(%rbp)        # 4-byte Spill
	movq	%r15, %r13
	.p2align	4, 0x90
.LBB16_16:                              # %for.inc195
                                        #   in Loop: Header=BB16_17 Depth=1
	addq	$32, %r15
	incl	%r14d
	cmpq	$0, (%r15)
	jne	.LBB16_17
.LBB16_48:
	movl	-84(%rbp), %r14d        # 4-byte Reload
	movq	%r13, %r15
	jmp	.LBB16_62
.LBB16_26:                              # %if.then20
	movl	last_nonopt(%rip), %eax
	cmpl	optind(%rip), %eax
	jle	.LBB16_28
# BB#27:                                # %if.then23
	movl	optind(%rip), %eax
	movl	%eax, last_nonopt(%rip)
.LBB16_28:                              # %if.end24
	movl	first_nonopt(%rip), %eax
	cmpl	optind(%rip), %eax
	jle	.LBB16_30
# BB#29:                                # %if.then27
	movl	optind(%rip), %eax
	movl	%eax, first_nonopt(%rip)
.LBB16_30:                              # %if.end28
	cmpl	$1, ordering(%rip)
	jne	.LBB16_43
# BB#31:                                # %if.then31
	movl	first_nonopt(%rip), %eax
	cmpl	last_nonopt(%rip), %eax
	je	.LBB16_34
# BB#32:                                # %land.lhs.true
	movl	last_nonopt(%rip), %eax
	cmpl	optind(%rip), %eax
	je	.LBB16_34
# BB#33:                                # %if.then36
	movq	%r15, %rdi
	callq	exchange
	cmpl	%r12d, optind(%rip)
	jl	.LBB16_38
	jmp	.LBB16_40
.LBB16_34:                              # %if.else
	movl	last_nonopt(%rip), %eax
	cmpl	optind(%rip), %eax
	je	.LBB16_37
# BB#35:                                # %if.then39
	movl	optind(%rip), %eax
	movl	%eax, first_nonopt(%rip)
	cmpl	%r12d, optind(%rip)
	jl	.LBB16_38
	jmp	.LBB16_40
	.p2align	4, 0x90
.LBB16_36:                              # %while.body
	incl	%ecx
	movl	%ecx, optind(%rip)
.LBB16_37:                              # %while.cond
	cmpl	%r12d, optind(%rip)
	jge	.LBB16_40
.LBB16_38:                              # %land.rhs
	movslq	optind(%rip), %rax
	movq	(%r15,%rax,8), %rcx
	movb	$1, %al
	cmpb	$45, (%rcx)
	jne	.LBB16_41
# BB#39:                                # %lor.rhs
	movslq	optind(%rip), %rax
	movq	(%r15,%rax,8), %rax
	cmpb	$0, 1(%rax)
	sete	%al
	jmp	.LBB16_41
	.p2align	4, 0x90
.LBB16_40:
	xorl	%eax, %eax
.LBB16_41:                              # %land.end
	movl	optind(%rip), %ecx
	testb	%al, %al
	jne	.LBB16_36
# BB#42:                                # %while.end
	movl	%ecx, last_nonopt(%rip)
.LBB16_43:                              # %if.end55
	cmpl	%r12d, optind(%rip)
	je	.LBB16_52
# BB#44:                                # %land.lhs.true58
	movslq	optind(%rip), %rax
	movq	(%r15,%rax,8), %rdi
	movl	$.L.str.1, %esi
	callq	strcmp
	testl	%eax, %eax
	jne	.LBB16_52
# BB#45:                                # %if.then63
	incl	optind(%rip)
	movl	first_nonopt(%rip), %eax
	cmpl	last_nonopt(%rip), %eax
	je	.LBB16_49
# BB#46:                                # %land.lhs.true67
	movl	last_nonopt(%rip), %eax
	cmpl	optind(%rip), %eax
	je	.LBB16_49
# BB#47:                                # %if.then70
	movq	%r15, %rdi
	callq	exchange
	jmp	.LBB16_51
.LBB16_49:                              # %if.else71
	movl	first_nonopt(%rip), %eax
	cmpl	last_nonopt(%rip), %eax
	jne	.LBB16_51
# BB#50:                                # %if.then74
	movl	optind(%rip), %eax
	movl	%eax, first_nonopt(%rip)
.LBB16_51:                              # %if.end76
	movl	%r12d, last_nonopt(%rip)
	movl	%r12d, optind(%rip)
.LBB16_52:                              # %if.end77
	cmpl	%r12d, optind(%rip)
	jne	.LBB16_55
# BB#53:                                # %if.then80
	movl	first_nonopt(%rip), %eax
	cmpl	last_nonopt(%rip), %eax
	je	.LBB16_123
# BB#54:                                # %if.then83
	movl	first_nonopt(%rip), %eax
	movl	%eax, optind(%rip)
	jmp	.LBB16_123
.LBB16_55:                              # %if.end85
	movslq	optind(%rip), %rax
	movq	(%r15,%rax,8), %rax
	cmpb	$45, (%rax)
	jne	.LBB16_59
# BB#56:                                # %lor.lhs.false92
	movslq	optind(%rip), %rax
	movq	(%r15,%rax,8), %rax
	cmpb	$0, 1(%rax)
	je	.LBB16_59
# BB#57:                                # %if.end107
	movslq	optind(%rip), %rax
	movq	(%r15,%rax,8), %rax
	incq	%rax
	cmpq	$0, -56(%rbp)           # 8-byte Folded Reload
	je	.LBB16_78
# BB#58:                                # %land.rhs112
	movslq	optind(%rip), %rcx
	movq	(%r15,%rcx,8), %rcx
	cmpb	$45, 1(%rcx)
	sete	%cl
	jmp	.LBB16_79
.LBB16_59:                              # %if.then99
	cmpl	$0, ordering(%rip)
	je	.LBB16_123
# BB#60:                                # %if.end103
	movslq	optind(%rip), %rax
	leal	1(%rax), %ecx
	movl	%ecx, optind(%rip)
	movq	(%r15,%rax,8), %rax
	movq	%rax, optarg(%rip)
	movl	$1, %r14d
	jmp	.LBB16_123
.LBB16_61:
	movl	$1, %eax
	movq	%rax, -104(%rbp)        # 8-byte Spill
	movl	-60(%rbp), %r12d        # 4-byte Reload
.LBB16_62:                              # %for.end198
	cmpl	$0, -80(%rbp)           # 4-byte Folded Reload
	movq	-96(%rbp), %r13         # 8-byte Reload
	je	.LBB16_67
# BB#63:                                # %for.end198
	cmpl	$0, -104(%rbp)          # 4-byte Folded Reload
	jne	.LBB16_67
# BB#64:                                # %if.then202
	cmpl	$0, -44(%rbp)           # 4-byte Folded Reload
	je	.LBB16_66
# BB#65:                                # %if.then204
	movq	stderr(%rip), %rdi
	movq	-72(%rbp), %rcx         # 8-byte Reload
	movq	(%rcx), %rdx
	movslq	optind(%rip), %rax
	movq	(%rcx,%rax,8), %rcx
	movl	$.L.str.2, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB16_66:                              # %if.end209
	movq	nextchar(%rip), %rdi
	callq	strlen
	addq	%rax, nextchar(%rip)
	jmp	.LBB16_121
.LBB16_67:                              # %if.end213
	testq	%r15, %r15
	je	.LBB16_72
# BB#68:                                # %if.then216
	incl	optind(%rip)
	movl	8(%r15), %eax
	cmpb	$0, (%rbx)
	je	.LBB16_99
# BB#69:                                # %if.then219
	testl	%eax, %eax
	je	.LBB16_110
# BB#70:                                # %if.then222
	incq	%rbx
.LBB16_71:                              # %if.end281.sink.split
	movq	%rbx, optarg(%rip)
	jmp	.LBB16_102
.LBB16_72:                              # %if.end295
	cmpl	$0, -48(%rbp)           # 4-byte Folded Reload
	movq	-72(%rbp), %r15         # 8-byte Reload
	je	.LBB16_75
# BB#73:                                # %lor.lhs.false297
	movslq	optind(%rip), %rax
	movq	(%r15,%rax,8), %rax
	cmpb	$45, 1(%rax)
	je	.LBB16_75
# BB#74:                                # %lor.lhs.false304
	movq	nextchar(%rip), %rax
	movsbl	(%rax), %esi
	movq	%r13, %rdi
	callq	strchr
	testq	%rax, %rax
	jne	.LBB16_81
.LBB16_75:                              # %if.then309
	cmpl	$0, -44(%rbp)           # 4-byte Folded Reload
	je	.LBB16_120
# BB#76:                                # %if.then311
	movslq	optind(%rip), %rax
	movq	(%r15,%rax,8), %rax
	movq	stderr(%rip), %rdi
	movq	(%r15), %rdx
	cmpb	$45, 1(%rax)
	jne	.LBB16_119
# BB#77:                                # %if.then318
	movq	nextchar(%rip), %rcx
	movl	$.L.str.6, %esi
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB16_120
.LBB16_78:
	xorl	%ecx, %ecx
.LBB16_79:                              # %land.end119
	movzbl	%cl, %ecx
	addq	%rcx, %rax
	movq	%rax, nextchar(%rip)
	jmp	.LBB16_8
.LBB16_80:                              # %lor.lhs.false139
	movslq	optind(%rip), %rax
	movq	(%r15,%rax,8), %rax
	movsbl	1(%rax), %esi
	movq	%r13, %rdi
	callq	strchr
	testq	%rax, %rax
	je	.LBB16_12
.LBB16_81:                              # %if.end332
	movq	nextchar(%rip), %rax
	leaq	1(%rax), %rcx
	movq	%rcx, nextchar(%rip)
	movb	(%rax), %bl
	movsbl	%bl, %r14d
	movq	%r13, %rdi
	movl	%r14d, %esi
	callq	strchr
	movq	nextchar(%rip), %rcx
	cmpb	$0, (%rcx)
	jne	.LBB16_83
# BB#82:                                # %if.then339
	incl	optind(%rip)
.LBB16_83:                              # %if.end341
	testq	%rax, %rax
	je	.LBB16_89
# BB#84:                                # %if.end341
	cmpl	$58, %r14d
	je	.LBB16_89
# BB#85:                                # %if.end363
	cmpb	$87, (%rax)
	jne	.LBB16_92
# BB#86:                                # %land.lhs.true368
	cmpb	$59, 1(%rax)
	jne	.LBB16_92
# BB#87:                                # %if.then373
	movq	nextchar(%rip), %rax
	cmpb	$0, (%rax)
	je	.LBB16_113
# BB#88:                                # %if.then384
	movq	nextchar(%rip), %rax
	movq	%rax, optarg(%rip)
	incl	optind(%rip)
	movq	-56(%rbp), %rbx         # 8-byte Reload
	jmp	.LBB16_134
.LBB16_89:                              # %if.then348
	cmpl	$0, -44(%rbp)           # 4-byte Folded Reload
	je	.LBB16_98
# BB#90:                                # %if.then350
	movq	stderr(%rip), %rdi
	movq	(%r15), %rdx
	cmpq	$0, posixly_correct(%rip)
	je	.LBB16_96
# BB#91:                                # %if.then352
	movl	$.L.str.9, %esi
	jmp	.LBB16_97
.LBB16_92:                              # %if.end535
	cmpb	$58, 1(%rax)
	jne	.LBB16_109
# BB#93:                                # %if.then540
	movq	nextchar(%rip), %rcx
	movsbl	(%rcx), %ecx
	cmpb	$58, 2(%rax)
	jne	.LBB16_106
# BB#94:                                # %if.then545
	testl	%ecx, %ecx
	jne	.LBB16_107
# BB#95:                                # %if.else551
	movq	$0, optarg(%rip)
	jmp	.LBB16_108
.LBB16_96:                              # %if.else356
	movl	$.L.str.10, %esi
.LBB16_97:                              # %if.end361
	xorl	%eax, %eax
	movl	%r14d, %ecx
	callq	fprintf
.LBB16_98:                              # %if.end361
	movl	%r14d, optopt(%rip)
	jmp	.LBB16_122
.LBB16_99:                              # %if.else252
	cmpl	$1, %eax
	jne	.LBB16_102
# BB#100:                               # %if.then256
	cmpl	%r12d, optind(%rip)
	jge	.LBB16_129
# BB#101:                               # %if.then259
	movslq	optind(%rip), %rax
	leal	1(%rax), %ecx
	movl	%ecx, optind(%rip)
	movq	-72(%rbp), %rcx         # 8-byte Reload
	movq	(%rcx,%rax,8), %rbx
	jmp	.LBB16_71
.LBB16_102:                             # %if.end281
	movq	nextchar(%rip), %rdi
	callq	strlen
	addq	%rax, nextchar(%rip)
	movq	-112(%rbp), %rax        # 8-byte Reload
	testq	%rax, %rax
	je	.LBB16_104
# BB#103:                               # %if.then286
	movl	%r14d, (%rax)
.LBB16_104:                             # %if.end287
	movl	24(%r15), %r14d
	cmpq	$0, 16(%r15)
	je	.LBB16_123
# BB#105:                               # %if.then290
	movq	16(%r15), %rax
	movl	%r14d, (%rax)
	xorl	%r14d, %r14d
	jmp	.LBB16_123
.LBB16_106:                             # %if.else553
	testl	%ecx, %ecx
	je	.LBB16_124
.LBB16_107:                             # %if.then549
	movq	nextchar(%rip), %rax
	movq	%rax, optarg(%rip)
	incl	optind(%rip)
.LBB16_108:                             # %if.end583
	movq	$0, nextchar(%rip)
.LBB16_109:                             # %if.end584
	movsbl	%bl, %r14d
	jmp	.LBB16_123
.LBB16_110:                             # %if.else224
	cmpl	$0, -44(%rbp)           # 4-byte Folded Reload
	je	.LBB16_155
# BB#111:                               # %if.then226
	movslq	optind(%rip), %rax
	movq	-72(%rbp), %rcx         # 8-byte Reload
	movq	-8(%rcx,%rax,8), %rax
	movq	stderr(%rip), %rdi
	movq	(%rcx), %rdx
	cmpb	$45, 1(%rax)
	jne	.LBB16_154
# BB#112:                               # %if.then233
	movq	(%r15), %rcx
	movl	$.L.str.3, %esi
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB16_155
.LBB16_113:                             # %if.else386
	cmpl	%r12d, optind(%rip)
	movq	-56(%rbp), %rbx         # 8-byte Reload
	jne	.LBB16_133
# BB#114:                               # %if.then389
	cmpl	$0, -44(%rbp)           # 4-byte Folded Reload
	je	.LBB16_116
# BB#115:                               # %if.then391
	movq	stderr(%rip), %rdi
	movq	(%r15), %rdx
	movl	$.L.str.11, %esi
	xorl	%eax, %eax
	movl	%r14d, %ecx
	callq	fprintf
.LBB16_116:                             # %if.end395
	movl	%r14d, optopt(%rip)
	movb	(%r13), %al
	cmpb	$58, %al
	je	.LBB16_118
# BB#117:                               # %if.end395
	movb	$63, %al
.LBB16_118:                             # %if.end395
	movzbl	%al, %r14d
	jmp	.LBB16_123
.LBB16_119:                             # %if.else321
	movslq	optind(%rip), %rax
	movq	(%r15,%rax,8), %rax
	movsbl	(%rax), %ecx
	movq	nextchar(%rip), %r8
	movl	$.L.str.7, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB16_120:                             # %if.end329
	movq	$.L.str.8, nextchar(%rip)
.LBB16_121:                             # %return
	incl	optind(%rip)
	movl	$0, optopt(%rip)
.LBB16_122:                             # %return
	movl	$63, %r14d
.LBB16_123:                             # %return
	movl	%r14d, %eax
	addq	$72, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB16_124:                             # %if.else559
	cmpl	%r12d, optind(%rip)
	jne	.LBB16_157
# BB#125:                               # %if.then562
	cmpl	$0, -44(%rbp)           # 4-byte Folded Reload
	je	.LBB16_127
# BB#126:                               # %if.then564
	movq	stderr(%rip), %rdi
	movq	(%r15), %rdx
	movl	$.L.str.11, %esi
	xorl	%eax, %eax
	movl	%r14d, %ecx
	callq	fprintf
.LBB16_127:                             # %if.end568
	movl	%r14d, optopt(%rip)
	movb	(%r13), %bl
	cmpb	$58, %bl
	je	.LBB16_108
# BB#128:                               # %if.end568
	movb	$63, %bl
	jmp	.LBB16_108
.LBB16_129:                             # %if.else263
	cmpl	$0, -44(%rbp)           # 4-byte Folded Reload
	je	.LBB16_131
# BB#130:                               # %if.then265
	movq	stderr(%rip), %rdi
	movq	-72(%rbp), %rcx         # 8-byte Reload
	movq	(%rcx), %rdx
	movslq	optind(%rip), %rax
	movq	-8(%rcx,%rax,8), %rcx
	movl	$.L.str.5, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB16_131:                             # %if.end271
	movq	nextchar(%rip), %rdi
	callq	strlen
	addq	%rax, nextchar(%rip)
	movl	24(%r15), %eax
	movl	%eax, optopt(%rip)
	xorl	%eax, %eax
	cmpb	$58, (%r13)
.LBB16_132:                             # %return
	setne	%al
	leal	58(%rax,%rax,4), %r14d
	jmp	.LBB16_123
.LBB16_133:                             # %if.else405
	movslq	optind(%rip), %rax
	leal	1(%rax), %ecx
	movl	%ecx, optind(%rip)
	movq	(%r15,%rax,8), %rax
	movq	%rax, optarg(%rip)
.LBB16_134:                             # %if.end410
	movq	optarg(%rip), %r14
	movq	%r14, nextchar(%rip)
	cmpb	$0, (%r14)
	je	.LBB16_137
	.p2align	4, 0x90
.LBB16_136:                             # %land.rhs414
                                        # =>This Inner Loop Header: Depth=1
	cmpb	$61, (%r14)
	je	.LBB16_137
# BB#135:                               # %for.inc421
                                        #   in Loop: Header=BB16_136 Depth=1
	incq	%r14
	cmpb	$0, (%r14)
	jne	.LBB16_136
.LBB16_137:                             # %for.cond424.preheader
	movq	%r13, -96(%rbp)         # 8-byte Spill
	movq	%r15, -72(%rbp)         # 8-byte Spill
	xorl	%eax, %eax
	movq	%rax, -80(%rbp)         # 8-byte Spill
	xorl	%r15d, %r15d
	movl	$0, -48(%rbp)           # 4-byte Folded Spill
	movl	$0, -56(%rbp)           # 4-byte Folded Spill
	xorl	%r13d, %r13d
	cmpq	$0, (%rbx)
	je	.LBB16_142
	.p2align	4, 0x90
.LBB16_139:                             # %for.body427
                                        # =>This Inner Loop Header: Depth=1
	movq	(%rbx), %rdi
	movq	nextchar(%rip), %rsi
	movq	%r14, %rdx
	subq	%rsi, %rdx
	callq	strncmp
	testl	%eax, %eax
	jne	.LBB16_138
# BB#140:                               # %if.then434
                                        #   in Loop: Header=BB16_139 Depth=1
	movl	nextchar(%rip), %eax
	movl	%r14d, %r12d
	subl	%eax, %r12d
	movq	(%rbx), %rdi
	callq	strlen
	cmpq	%rax, %r12
	je	.LBB16_143
# BB#141:                               # %if.else445
                                        #   in Loop: Header=BB16_139 Depth=1
	testq	%r15, %r15
	cmoveq	%rbx, %r15
	movl	-48(%rbp), %eax         # 4-byte Reload
	movl	$1, %ecx
	cmovnel	%ecx, %eax
	movl	%eax, -48(%rbp)         # 4-byte Spill
	movl	-56(%rbp), %eax         # 4-byte Reload
	cmovel	%r13d, %eax
	movl	%eax, -56(%rbp)         # 4-byte Spill
	movl	-60(%rbp), %r12d        # 4-byte Reload
.LBB16_138:                             # %for.inc453
                                        #   in Loop: Header=BB16_139 Depth=1
	addq	$32, %rbx
	incl	%r13d
	cmpq	$0, (%rbx)
	jne	.LBB16_139
.LBB16_142:
	movl	-56(%rbp), %r13d        # 4-byte Reload
	jmp	.LBB16_144
.LBB16_143:
	movq	%rbx, %r15
	movl	$1, %eax
	movq	%rax, -80(%rbp)         # 8-byte Spill
	movl	-60(%rbp), %r12d        # 4-byte Reload
.LBB16_144:                             # %for.end456
	cmpl	$0, -48(%rbp)           # 4-byte Folded Reload
	movq	-72(%rbp), %rsi         # 8-byte Reload
	movq	-96(%rbp), %rbx         # 8-byte Reload
	je	.LBB16_149
# BB#145:                               # %for.end456
	cmpl	$0, -80(%rbp)           # 4-byte Folded Reload
	jne	.LBB16_149
# BB#146:                               # %if.then460
	cmpl	$0, -44(%rbp)           # 4-byte Folded Reload
	je	.LBB16_148
# BB#147:                               # %if.then462
	movq	stderr(%rip), %rdi
	movq	(%rsi), %rdx
	movslq	optind(%rip), %rax
	movq	(%rsi,%rax,8), %rcx
	movl	$.L.str.12, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB16_148:                             # %if.end467
	movq	nextchar(%rip), %rdi
	callq	strlen
	addq	%rax, nextchar(%rip)
	incl	optind(%rip)
	jmp	.LBB16_122
.LBB16_149:                             # %if.end471
	movq	%r15, %rax
	testq	%rax, %rax
	je	.LBB16_156
# BB#150:                               # %if.then474
	movl	8(%rax), %eax
	cmpb	$0, (%r14)
	je	.LBB16_158
# BB#151:                               # %if.then476
	testl	%eax, %eax
	je	.LBB16_163
# BB#152:                               # %if.then479
	incq	%r14
.LBB16_153:                             # %if.end520.sink.split
	movq	%r14, optarg(%rip)
	jmp	.LBB16_161
.LBB16_154:                             # %if.else237
	movslq	optind(%rip), %rax
	movq	-8(%rcx,%rax,8), %rax
	movsbl	(%rax), %ecx
	movq	(%r15), %r8
	movl	$.L.str.4, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB16_155:                             # %if.end247
	movq	nextchar(%rip), %rdi
	callq	strlen
	addq	%rax, nextchar(%rip)
	movl	24(%r15), %eax
	movl	%eax, optopt(%rip)
	jmp	.LBB16_122
.LBB16_156:                             # %if.end534
	movq	$0, nextchar(%rip)
	movl	$87, %r14d
	jmp	.LBB16_123
.LBB16_157:                             # %if.else577
	movslq	optind(%rip), %rax
	leal	1(%rax), %ecx
	movl	%ecx, optind(%rip)
	movq	(%r15,%rax,8), %rax
	movq	%rax, optarg(%rip)
	jmp	.LBB16_108
.LBB16_158:                             # %if.else491
	cmpl	$1, %eax
	jne	.LBB16_161
# BB#159:                               # %if.then495
	cmpl	%r12d, optind(%rip)
	jge	.LBB16_166
# BB#160:                               # %if.then498
	movslq	optind(%rip), %rax
	leal	1(%rax), %ecx
	movl	%ecx, optind(%rip)
	movq	(%rsi,%rax,8), %r14
	jmp	.LBB16_153
.LBB16_161:                             # %if.end520
	movq	nextchar(%rip), %rdi
	callq	strlen
	addq	%rax, nextchar(%rip)
	movq	-112(%rbp), %rax        # 8-byte Reload
	testq	%rax, %rax
	je	.LBB16_104
# BB#162:                               # %if.then525
	movl	%r13d, (%rax)
	jmp	.LBB16_104
.LBB16_163:                             # %if.else481
	cmpl	$0, -44(%rbp)           # 4-byte Folded Reload
	je	.LBB16_165
# BB#164:                               # %if.then483
	movq	stderr(%rip), %rdi
	movq	(%rsi), %rdx
	movq	(%r15), %rcx
	movl	$.L.str.13, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB16_165:                             # %if.end487
	movq	nextchar(%rip), %rdi
	callq	strlen
	addq	%rax, nextchar(%rip)
	jmp	.LBB16_122
.LBB16_166:                             # %if.else502
	cmpl	$0, -44(%rbp)           # 4-byte Folded Reload
	je	.LBB16_168
# BB#167:                               # %if.then504
	movq	stderr(%rip), %rdi
	movq	(%rsi), %rdx
	movslq	optind(%rip), %rax
	movq	-8(%rsi,%rax,8), %rcx
	movl	$.L.str.5, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB16_168:                             # %if.end510
	movq	nextchar(%rip), %rdi
	callq	strlen
	addq	%rax, nextchar(%rip)
	xorl	%eax, %eax
	cmpb	$58, (%rbx)
	jmp	.LBB16_132
.Lfunc_end16:
	.size	_getopt_internal, .Lfunc_end16-_getopt_internal
	.cfi_endproc

	.p2align	4, 0x90
	.type	_getopt_initialize,@function
_getopt_initialize:                     # @_getopt_initialize
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi84:
	.cfi_def_cfa_offset 16
.Lcfi85:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi86:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi87:
	.cfi_offset %rbx, -24
	movq	%rdx, %rbx
	movl	optind(%rip), %eax
	movl	%eax, last_nonopt(%rip)
	movl	%eax, first_nonopt(%rip)
	movq	$0, nextchar(%rip)
	movl	$.L.str.83, %edi
	callq	getenv
	movq	%rax, posixly_correct(%rip)
	cmpb	$45, (%rbx)
	jne	.LBB17_2
# BB#1:                                 # %if.then
	movl	$2, ordering(%rip)
	incq	%rbx
	jmp	.LBB17_5
.LBB17_2:                               # %if.else
	cmpb	$43, (%rbx)
	jne	.LBB17_4
# BB#3:                                 # %if.then6
	movl	$0, ordering(%rip)
	incq	%rbx
	jmp	.LBB17_5
.LBB17_4:                               # %if.else8
	xorl	%eax, %eax
	cmpq	$0, posixly_correct(%rip)
	sete	%al
	movl	%eax, ordering(%rip)
.LBB17_5:                               # %if.end14
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
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
.Lcfi88:
	.cfi_def_cfa_offset 16
.Lcfi89:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi90:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
.Lcfi91:
	.cfi_offset %rbx, -56
.Lcfi92:
	.cfi_offset %r12, -48
.Lcfi93:
	.cfi_offset %r13, -40
.Lcfi94:
	.cfi_offset %r14, -32
.Lcfi95:
	.cfi_offset %r15, -24
	movl	first_nonopt(%rip), %r12d
	movl	last_nonopt(%rip), %r15d
	movl	optind(%rip), %r9d
	movl	%r15d, %r8d
	negl	%r8d
	jmp	.LBB18_1
	.p2align	4, 0x90
.LBB18_7:                               # %for.end
                                        #   in Loop: Header=BB18_1 Depth=1
	subl	%edx, %r9d
.LBB18_1:                               # %while.cond.outer
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB18_2 Depth 2
                                        #       Child Loop BB18_10 Depth 3
                                        #     Child Loop BB18_6 Depth 2
	leal	(%r8,%r9), %r10d
	leal	(%r8,%r12), %r11d
	addl	%r9d, %r11d
	jmp	.LBB18_2
	.p2align	4, 0x90
.LBB18_11:                              # %for.end40
                                        #   in Loop: Header=BB18_2 Depth=2
	addl	%r10d, %r12d
	addl	%r10d, %r11d
.LBB18_2:                               # %while.cond
                                        #   Parent Loop BB18_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB18_10 Depth 3
	movl	%r9d, %r13d
	subl	%r15d, %r13d
	setg	%r14b
	movl	%r15d, %edx
	subl	%r12d, %edx
	setg	%bl
	andb	%r14b, %bl
	cmpb	$1, %bl
	jne	.LBB18_12
# BB#3:                                 # %while.body
                                        #   in Loop: Header=BB18_2 Depth=2
	cmpl	%edx, %r13d
	jg	.LBB18_4
# BB#8:                                 # %if.else
                                        #   in Loop: Header=BB18_2 Depth=2
	xorl	%edx, %edx
	cmpl	%r13d, %edx
	jge	.LBB18_11
	.p2align	4, 0x90
.LBB18_10:                              # %for.body25
                                        #   Parent Loop BB18_1 Depth=1
                                        #     Parent Loop BB18_2 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	leal	(%r12,%rdx), %ebx
	movslq	%ebx, %rbx
	movq	(%rdi,%rbx,8), %rcx
	leal	(%r15,%rdx), %eax
	cltq
	movq	(%rdi,%rax,8), %rsi
	movq	%rsi, (%rdi,%rbx,8)
	movq	%rcx, (%rdi,%rax,8)
	incl	%edx
	cmpl	%r13d, %edx
	jl	.LBB18_10
	jmp	.LBB18_11
	.p2align	4, 0x90
.LBB18_4:                               # %if.then
                                        #   in Loop: Header=BB18_1 Depth=1
	xorl	%r14d, %r14d
	cmpl	%edx, %r14d
	jge	.LBB18_7
	.p2align	4, 0x90
.LBB18_6:                               # %for.body
                                        #   Parent Loop BB18_1 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leal	(%r12,%r14), %ebx
	movslq	%ebx, %rbx
	movq	(%rdi,%rbx,8), %r10
	movslq	%r11d, %r11
	movq	(%rdi,%r11,8), %rsi
	movq	%rsi, (%rdi,%rbx,8)
	movq	%r10, (%rdi,%r11,8)
	incl	%r14d
	incl	%r11d
	cmpl	%edx, %r14d
	jl	.LBB18_6
	jmp	.LBB18_7
.LBB18_12:                              # %while.end
	movl	optind(%rip), %eax
	subl	last_nonopt(%rip), %eax
	addl	%eax, first_nonopt(%rip)
	movl	optind(%rip), %eax
	movl	%eax, last_nonopt(%rip)
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
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
.Lcfi96:
	.cfi_def_cfa_offset 16
.Lcfi97:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi98:
	.cfi_def_cfa_register %rbp
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	xorl	%r9d, %r9d
	callq	_getopt_internal
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
.Lcfi99:
	.cfi_def_cfa_offset 16
.Lcfi100:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi101:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi102:
	.cfi_offset %rbx, -24
	movl	%esi, %ebx
	movw	$0, -12(%rbp)
	movw	$0, -10(%rbp)
	movl	%edi, ifd(%rip)
	movl	%ebx, ofd(%rip)
	movl	$0, outcnt(%rip)
	movl	$8, method(%rip)
	movl	outcnt(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, outcnt(%rip)
	movb	$31, outbuf(%rax)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_2
# BB#1:                                 # %if.then
	callq	flush_outbuf
.LBB20_2:                               # %if.end
	movl	outcnt(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, outcnt(%rip)
	movb	$-117, outbuf(%rax)
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
	setne	%al
	shlb	$3, %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_8
# BB#7:                                 # %if.then21
	callq	flush_outbuf
.LBB20_8:                               # %if.end22
	movl	outcnt(%rip), %eax
	movq	time_stamp(%rip), %rcx
	movl	%ecx, %edx
	cmpq	%rdx, %rcx
	je	.LBB20_10
# BB#9:                                 # %if.end22
	xorl	%ecx, %ecx
.LBB20_10:                              # %if.end22
	leal	1(%rax), %edx
	movl	%edx, outcnt(%rip)
	cmpq	$16381, %rax            # imm = 0x3FFD
	movb	%cl, outbuf(%rax)
	ja	.LBB20_12
# BB#11:                                # %cond.end
	movq	time_stamp(%rip), %rcx
	movl	%ecx, %edx
	xorl	%eax, %eax
	cmpq	%rdx, %rcx
	cmovel	%ecx, %eax
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%ah, outbuf(%rcx)  # NOREX
	jmp	.LBB20_16
.LBB20_12:                              # %cond.end53
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_14
# BB#13:                                # %if.then63
	callq	flush_outbuf
.LBB20_14:                              # %if.end64
	movq	time_stamp(%rip), %rcx
	movl	%ecx, %edx
	xorl	%eax, %eax
	cmpq	%rdx, %rcx
	cmovel	%ecx, %eax
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%ah, outbuf(%rcx)  # NOREX
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_16
# BB#15:                                # %if.then82
	callq	flush_outbuf
.LBB20_16:                              # %if.end84
	movl	outcnt(%rip), %ecx
	movq	time_stamp(%rip), %rdx
	movl	%edx, %esi
	xorl	%eax, %eax
	cmpq	%rsi, %rdx
	cmovneq	%rax, %rdx
	shrq	$16, %rdx
	leal	1(%rcx), %esi
	movl	%esi, outcnt(%rip)
	cmpq	$16381, %rcx            # imm = 0x3FFD
	movb	%dl, outbuf(%rcx)
	ja	.LBB20_18
# BB#17:                                # %cond.end93
	movq	time_stamp(%rip), %rcx
	movl	%ecx, %edx
	cmpq	%rdx, %rcx
	cmovel	%ecx, %eax
	shrl	$24, %eax
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	jmp	.LBB20_22
.LBB20_18:                              # %cond.end122
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_20
# BB#19:                                # %if.then132
	callq	flush_outbuf
.LBB20_20:                              # %if.end133
	movq	time_stamp(%rip), %rax
	movl	%eax, %ecx
	xorl	%edx, %edx
	cmpq	%rcx, %rax
	cmovel	%eax, %edx
	shrl	$24, %edx
	movl	outcnt(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, outcnt(%rip)
	movb	%dl, outbuf(%rax)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_22
# BB#21:                                # %if.then151
	callq	flush_outbuf
.LBB20_22:                              # %if.end153
	xorl	%edi, %edi
	xorl	%esi, %esi
	callq	updcrc
	movq	%rax, crc(%rip)
	movl	%ebx, %edi
	callq	bi_init
	leaq	-12(%rbp), %rdi
	movl	$method, %esi
	callq	ct_init
	movl	level(%rip), %edi
	leaq	-10(%rbp), %rsi
	callq	lm_init
	movb	-10(%rbp), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_24
# BB#23:                                # %if.then160
	callq	flush_outbuf
.LBB20_24:                              # %if.end161
	movl	outcnt(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, outcnt(%rip)
	movb	$3, outbuf(%rax)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_26
# BB#25:                                # %if.then167
	callq	flush_outbuf
.LBB20_26:                              # %if.end168
	cmpl	$0, save_orig_name(%rip)
	je	.LBB20_31
# BB#27:                                # %if.then170
	movl	$ifname, %edi
	callq	base_name
	movq	%rax, %rbx
	.p2align	4, 0x90
.LBB20_28:                              # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movzbl	(%rbx), %eax
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_30
# BB#29:                                # %if.then177
                                        #   in Loop: Header=BB20_28 Depth=1
	callq	flush_outbuf
.LBB20_30:                              # %do.cond
                                        #   in Loop: Header=BB20_28 Depth=1
	cmpb	$0, (%rbx)
	leaq	1(%rbx), %rbx
	jne	.LBB20_28
.LBB20_31:                              # %if.end180
	movl	outcnt(%rip), %eax
	movq	%rax, header_bytes(%rip)
	callq	deflate
	movl	outcnt(%rip), %eax
	movb	crc(%rip), %cl
	leal	1(%rax), %edx
	movl	%edx, outcnt(%rip)
	cmpq	$16381, %rax            # imm = 0x3FFD
	movb	%cl, outbuf(%rax)
	ja	.LBB20_33
# BB#32:                                # %if.then185
	movb	crc+1(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	jmp	.LBB20_37
.LBB20_33:                              # %if.else200
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_35
# BB#34:                                # %if.then209
	callq	flush_outbuf
.LBB20_35:                              # %if.end210
	movb	crc+1(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_37
# BB#36:                                # %if.then221
	callq	flush_outbuf
.LBB20_37:                              # %if.end223
	movl	outcnt(%rip), %eax
	movb	crc+2(%rip), %cl
	leal	1(%rax), %edx
	movl	%edx, outcnt(%rip)
	cmpq	$16381, %rax            # imm = 0x3FFD
	movb	%cl, outbuf(%rax)
	ja	.LBB20_39
# BB#38:                                # %if.then226
	movb	crc+3(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	jmp	.LBB20_43
.LBB20_39:                              # %if.else241
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_41
# BB#40:                                # %if.then250
	callq	flush_outbuf
.LBB20_41:                              # %if.end251
	movb	crc+3(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_43
# BB#42:                                # %if.then262
	callq	flush_outbuf
.LBB20_43:                              # %if.end264
	movl	outcnt(%rip), %eax
	movb	bytes_in(%rip), %cl
	leal	1(%rax), %edx
	movl	%edx, outcnt(%rip)
	cmpq	$16381, %rax            # imm = 0x3FFD
	movb	%cl, outbuf(%rax)
	ja	.LBB20_45
# BB#44:                                # %if.then267
	movb	bytes_in+1(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	jmp	.LBB20_49
.LBB20_45:                              # %if.else282
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_47
# BB#46:                                # %if.then291
	callq	flush_outbuf
.LBB20_47:                              # %if.end292
	movb	bytes_in+1(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_49
# BB#48:                                # %if.then303
	callq	flush_outbuf
.LBB20_49:                              # %if.end305
	movl	outcnt(%rip), %eax
	movb	bytes_in+2(%rip), %cl
	leal	1(%rax), %edx
	movl	%edx, outcnt(%rip)
	cmpq	$16381, %rax            # imm = 0x3FFD
	movb	%cl, outbuf(%rax)
	ja	.LBB20_51
# BB#50:                                # %if.then308
	movb	bytes_in+3(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	jmp	.LBB20_55
.LBB20_51:                              # %if.else323
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_53
# BB#52:                                # %if.then332
	callq	flush_outbuf
.LBB20_53:                              # %if.end333
	movb	bytes_in+3(%rip), %al
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, outbuf(%rcx)
	cmpl	$16384, outcnt(%rip)    # imm = 0x4000
	jne	.LBB20_55
# BB#54:                                # %if.then344
	callq	flush_outbuf
.LBB20_55:                              # %if.end346
	addq	$16, header_bytes(%rip)
	callq	flush_outbuf
	xorl	%eax, %eax
	addq	$8, %rsp
	popq	%rbx
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
.Lcfi103:
	.cfi_def_cfa_offset 16
.Lcfi104:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi105:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$24, %rsp
.Lcfi106:
	.cfi_offset %rbx, -24
	movl	%edi, -12(%rbp)
	movq	%rsi, -24(%rbp)
	movq	(%rsi), %rdi
	callq	base_name
	movq	%rax, progname(%rip)
	movq	%rax, %rdi
	callq	strlen
	cmpl	$5, %eax
	jl	.LBB21_3
# BB#1:                                 # %land.lhs.true
	movq	progname(%rip), %rcx
	movslq	%eax, %rbx
	leaq	-4(%rcx,%rbx), %rdi
	movl	$.L.str.38, %esi
	callq	strcmp
	testl	%eax, %eax
	jne	.LBB21_3
# BB#2:                                 # %if.then
	movq	progname(%rip), %rax
	movb	$0, -4(%rax,%rbx)
.LBB21_3:                               # %if.end
	leaq	-12(%rbp), %rdi
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
.LBB21_16:                              # %if.end48.sink.split
	movl	$1, decompress(%rip)
.LBB21_17:                              # %if.end48
	movq	$.L.str.44, z_suffix(%rip)
	movl	$.L.str.44, %edi
	callq	strlen
	movq	%rax, z_len(%rip)
	jmp	.LBB21_18
	.p2align	4, 0x90
.LBB21_45:                              # %sw.bb87
                                        #   in Loop: Header=BB21_18 Depth=1
	addl	$-48, %eax
	movl	%eax, level(%rip)
.LBB21_18:                              # %while.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB21_22 Depth 2
	movl	-12(%rbp), %edi
	movq	-24(%rbp), %rsi
	movl	$.L.str.45, %edx
	movl	$longopts, %ecx
	xorl	%r8d, %r8d
	callq	getopt_long
                                        # kill: %EAX<def> %EAX<kill> %RAX<def>
	leal	1(%rax), %ecx
	cmpl	$119, %ecx
	ja	.LBB21_47
# BB#19:                                # %while.cond
                                        #   in Loop: Header=BB21_18 Depth=1
	jmpq	*.LJTI21_0(,%rcx,8)
.LBB21_30:                              # %sw.bb69
                                        #   in Loop: Header=BB21_18 Depth=1
	callq	help
	jmp	.LBB21_31
.LBB21_33:                              # %sw.bb71
                                        #   in Loop: Header=BB21_18 Depth=1
	callq	license
	jmp	.LBB21_31
.LBB21_35:                              # %sw.bb73
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$0, no_time(%rip)
	jmp	.LBB21_18
.LBB21_37:                              # %sw.bb75
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$0, no_time(%rip)
	movl	$0, no_name(%rip)
	jmp	.LBB21_18
.LBB21_40:                              # %sw.bb78
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, rsync(%rip)
	jmp	.LBB21_18
.LBB21_41:                              # %sw.bb79
                                        #   in Loop: Header=BB21_18 Depth=1
	movq	optarg(%rip), %rdi
	callq	strlen
	movq	%rax, z_len(%rip)
	movq	optarg(%rip), %rax
	movq	%rax, z_suffix(%rip)
	jmp	.LBB21_18
.LBB21_44:                              # %sw.bb84
                                        #   in Loop: Header=BB21_18 Depth=1
	callq	version
.LBB21_31:                              # %while.cond
                                        #   in Loop: Header=BB21_18 Depth=1
	xorl	%edi, %edi
	callq	do_exit
	jmp	.LBB21_18
.LBB21_46:                              # %sw.bb85
                                        #   in Loop: Header=BB21_18 Depth=1
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.47, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB21_47:                              # %sw.default
                                        #   in Loop: Header=BB21_18 Depth=1
	callq	usage
	movl	$1, %edi
	callq	do_exit
	jmp	.LBB21_18
.LBB21_20:                              # %sw.bb
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, ascii(%rip)
	jmp	.LBB21_18
.LBB21_21:                              # %sw.bb53
                                        #   in Loop: Header=BB21_18 Depth=1
	movq	optarg(%rip), %rdi
	callq	atoi
	movl	%eax, maxbits(%rip)
	jmp	.LBB21_22
	.p2align	4, 0x90
.LBB21_26:                              # %for.inc
                                        #   in Loop: Header=BB21_22 Depth=2
	incq	optarg(%rip)
.LBB21_22:                              # %for.cond
                                        #   Parent Loop BB21_18 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movq	optarg(%rip), %rax
	cmpb	$0, (%rax)
	je	.LBB21_18
# BB#23:                                # %for.body
                                        #   in Loop: Header=BB21_22 Depth=2
	movq	optarg(%rip), %rax
	movsbl	(%rax), %eax
	cmpl	$48, %eax
	jl	.LBB21_25
# BB#24:                                # %land.lhs.true59
                                        #   in Loop: Header=BB21_22 Depth=2
	movq	optarg(%rip), %rax
	movsbl	(%rax), %eax
	cmpl	$58, %eax
	jl	.LBB21_26
.LBB21_25:                              # %if.then63
                                        #   in Loop: Header=BB21_22 Depth=2
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.46, %esi
	xorl	%eax, %eax
	callq	fprintf
	callq	usage
	movl	$1, %edi
	callq	do_exit
	jmp	.LBB21_26
.LBB21_27:                              # %sw.bb66
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, to_stdout(%rip)
	jmp	.LBB21_18
.LBB21_28:                              # %sw.bb67
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, decompress(%rip)
	jmp	.LBB21_18
.LBB21_29:                              # %sw.bb68
                                        #   in Loop: Header=BB21_18 Depth=1
	incl	force(%rip)
	jmp	.LBB21_18
.LBB21_32:                              # %sw.bb70
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, to_stdout(%rip)
	movl	$1, decompress(%rip)
	movl	$1, list(%rip)
	jmp	.LBB21_18
.LBB21_34:                              # %sw.bb72
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, no_time(%rip)
	jmp	.LBB21_18
.LBB21_36:                              # %sw.bb74
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, no_time(%rip)
	movl	$1, no_name(%rip)
	jmp	.LBB21_18
.LBB21_38:                              # %sw.bb76
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, quiet(%rip)
	movl	$0, verbose(%rip)
	jmp	.LBB21_18
.LBB21_39:                              # %sw.bb77
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, recursive(%rip)
	jmp	.LBB21_18
.LBB21_42:                              # %sw.bb81
                                        #   in Loop: Header=BB21_18 Depth=1
	movl	$1, to_stdout(%rip)
	movl	$1, decompress(%rip)
	movl	$1, test(%rip)
	jmp	.LBB21_18
.LBB21_43:                              # %sw.bb82
                                        #   in Loop: Header=BB21_18 Depth=1
	incl	verbose(%rip)
	movl	$0, quiet(%rip)
	jmp	.LBB21_18
.LBB21_48:                              # %while.end
	cmpl	$0, quiet(%rip)
	je	.LBB21_51
# BB#49:                                # %land.lhs.true90
	movl	$13, %edi
	movl	$1, %esi
	callq	signal
	cmpq	$1, %rax
	je	.LBB21_51
# BB#50:                                # %if.then94
	movl	$13, %edi
	movl	$abort_gzip_signal, %esi
	callq	signal
.LBB21_51:                              # %if.end96
	cmpl	$0, no_time(%rip)
	jns	.LBB21_53
# BB#52:                                # %if.then99
	movl	decompress(%rip), %eax
	movl	%eax, no_time(%rip)
.LBB21_53:                              # %if.end100
	cmpl	$0, no_name(%rip)
	jns	.LBB21_55
# BB#54:                                # %if.then103
	movl	decompress(%rip), %eax
	movl	%eax, no_name(%rip)
.LBB21_55:                              # %if.end104
	movl	-12(%rbp), %ebx
	subl	optind(%rip), %ebx
	cmpl	$0, ascii(%rip)
	je	.LBB21_58
# BB#56:                                # %if.end104
	movl	quiet(%rip), %eax
	testl	%eax, %eax
	jne	.LBB21_58
# BB#57:                                # %if.then109
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.48, %esi
	xorl	%eax, %eax
	callq	fprintf
.LBB21_58:                              # %if.end111
	movq	z_len(%rip), %rax
	testq	%rax, %rax
	sete	%cl
	cmpl	$0, decompress(%rip)
	sete	%dl
	testb	%dl, %cl
	jne	.LBB21_60
# BB#59:                                # %if.end111
	cmpq	$31, %rax
	jb	.LBB21_61
.LBB21_60:                              # %if.then119
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movq	z_suffix(%rip), %rcx
	movl	$.L.str.49, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, %edi
	callq	do_exit
.LBB21_61:                              # %if.end121
	cmpl	$0, do_lzw(%rip)
	je	.LBB21_64
# BB#62:                                # %if.end121
	movl	decompress(%rip), %eax
	testl	%eax, %eax
	jne	.LBB21_64
# BB#63:                                # %if.then125
	movq	$lzw, work(%rip)
.LBB21_64:                              # %if.end126
	testl	%ebx, %ebx
	jne	.LBB21_65
# BB#67:                                # %if.else149
	callq	treat_stdin
	jmp	.LBB21_68
	.p2align	4, 0x90
.LBB21_66:                              # %while.body144
                                        #   in Loop: Header=BB21_65 Depth=1
	movq	-24(%rbp), %rax
	movslq	optind(%rip), %rcx
	leal	1(%rcx), %edx
	movl	%edx, optind(%rip)
	movq	(%rax,%rcx,8), %rdi
	callq	treat_file
.LBB21_65:                              # %while.cond141
                                        # =>This Inner Loop Header: Depth=1
	movl	optind(%rip), %eax
	cmpl	-12(%rbp), %eax
	jl	.LBB21_66
.LBB21_68:                              # %if.end150
	cmpl	$0, list(%rip)
	setne	%al
	cmpl	$0, quiet(%rip)
	sete	%cl
	andb	%al, %cl
	cmpb	$1, %cl
	jne	.LBB21_71
# BB#69:                                # %if.end150
	cmpl	$2, %ebx
	jl	.LBB21_71
# BB#70:                                # %if.then157
	movl	$-1, %edi
	movl	$-1, %esi
	callq	do_list
.LBB21_71:                              # %if.end158
	movl	exit_code(%rip), %edi
	callq	do_exit
	movl	exit_code(%rip), %eax
	addq	$24, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end21:
	.size	main, .Lfunc_end21-main
	.cfi_endproc
	.section	.rodata,"a",@progbits
	.p2align	3
.LJTI21_0:
	.quad	.LBB21_48
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_45
	.quad	.LBB21_45
	.quad	.LBB21_45
	.quad	.LBB21_45
	.quad	.LBB21_45
	.quad	.LBB21_45
	.quad	.LBB21_45
	.quad	.LBB21_45
	.quad	.LBB21_45
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_30
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_30
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_33
	.quad	.LBB21_35
	.quad	.LBB21_37
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_40
	.quad	.LBB21_41
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_44
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_46
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_20
	.quad	.LBB21_21
	.quad	.LBB21_27
	.quad	.LBB21_28
	.quad	.LBB21_47
	.quad	.LBB21_29
	.quad	.LBB21_47
	.quad	.LBB21_30
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_32
	.quad	.LBB21_34
	.quad	.LBB21_36
	.quad	.LBB21_47
	.quad	.LBB21_47
	.quad	.LBB21_38
	.quad	.LBB21_39
	.quad	.LBB21_47
	.quad	.LBB21_42
	.quad	.LBB21_47
	.quad	.LBB21_43

	.text
	.globl	base_name
	.p2align	4, 0x90
	.type	base_name,@function
base_name:                              # @base_name
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi107:
	.cfi_def_cfa_offset 16
.Lcfi108:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi109:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi110:
	.cfi_offset %rbx, -24
	movq	%rdi, %rbx
	movl	$47, %esi
	callq	strrchr
	testq	%rax, %rax
	leaq	1(%rax), %rax
	cmoveq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
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
.Lcfi111:
	.cfi_def_cfa_offset 16
.Lcfi112:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi113:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
.Lcfi114:
	.cfi_offset %rbx, -56
.Lcfi115:
	.cfi_offset %r12, -48
.Lcfi116:
	.cfi_offset %r13, -40
.Lcfi117:
	.cfi_offset %r14, -32
.Lcfi118:
	.cfi_offset %r15, -24
	movq	%rsi, %r14
	movq	%rdi, %r12
	movl	(%r12), %eax
	movl	%eax, -44(%rbp)         # 4-byte Spill
	movq	%rdx, %rdi
	callq	getenv
	movq	%rax, %rbx
	xorl	%r13d, %r13d
	testq	%rbx, %rbx
	je	.LBB23_20
# BB#1:                                 # %if.end
	movq	%rbx, %rdi
	callq	strlen
	leal	1(%rax), %edi
	callq	xmalloc
	movq	%rax, %rdi
	movq	%rbx, %rsi
	callq	strcpy
	movq	%rax, %r15
	movq	%r15, %rbx
	cmpb	$0, (%rbx)
	je	.LBB23_6
	.p2align	4, 0x90
.LBB23_3:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	$.L.str.71, %esi
	movq	%rbx, %rdi
	callq	strspn
	cmpb	$0, (%rbx,%rax)
	je	.LBB23_6
# BB#4:                                 # %if.end9
                                        #   in Loop: Header=BB23_3 Depth=1
	addq	%rax, %rbx
	movl	$.L.str.71, %esi
	movq	%rbx, %rdi
	callq	strcspn
	leaq	(%rbx,%rax), %rcx
	cmpb	$0, (%rbx,%rax)
	je	.LBB23_2
# BB#5:                                 # %if.then13
                                        #   in Loop: Header=BB23_3 Depth=1
	movb	$0, (%rcx)
	incq	%rcx
.LBB23_2:                               # %for.inc
                                        #   in Loop: Header=BB23_3 Depth=1
	decl	%r13d
	movq	%rcx, %rbx
	cmpb	$0, (%rbx)
	jne	.LBB23_3
.LBB23_6:                               # %for.end
	testl	%r13d, %r13d
	je	.LBB23_19
# BB#7:                                 # %if.end18
	movq	%r15, -56(%rbp)         # 8-byte Spill
	subl	%r13d, (%r12)
	movslq	(%r12), %rdi
	incq	%rdi
	movl	$8, %esi
	callq	calloc
	movq	%rax, %r15
	testq	%r15, %r15
	jne	.LBB23_9
# BB#8:                                 # %if.then25
	movl	$.L.str.62, %edi
	callq	error
.LBB23_9:                               # %if.end26
	movq	(%r14), %r12
	movq	%r15, (%r14)
	movl	-44(%rbp), %ebx         # 4-byte Reload
	testl	%ebx, %ebx
	jns	.LBB23_11
# BB#10:                                # %if.then29
	movl	$.L.str.72, %edi
	callq	error
.LBB23_11:                              # %if.end30
	negl	%r13d
	decl	%ebx
	movl	%ebx, -44(%rbp)         # 4-byte Spill
	movq	(%r12), %rax
	movq	%r15, %r14
	addq	$8, %r14
	movq	%rax, (%r15)
	movq	-56(%rbp), %r15         # 8-byte Reload
	movq	%r15, %rbx
	testl	%r13d, %r13d
	jle	.LBB23_15
	.p2align	4, 0x90
.LBB23_13:                              # %for.body36
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB23_14 Depth 2
	movl	$.L.str.71, %esi
	movq	%rbx, %rdi
	callq	strspn
	addq	%rax, %rbx
	movq	%rbx, (%r14)
	addq	$8, %r14
	.p2align	4, 0x90
.LBB23_14:                              # %while.cond
                                        #   Parent Loop BB23_13 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpb	$0, (%rbx)
	leaq	1(%rbx), %rbx
	jne	.LBB23_14
# BB#12:                                # %for.inc42
                                        #   in Loop: Header=BB23_13 Depth=1
	decl	%r13d
	testl	%r13d, %r13d
	jg	.LBB23_13
.LBB23_15:                              # %while.cond45.preheader
	movl	-44(%rbp), %eax         # 4-byte Reload
	xorl	%ecx, %ecx
	cmpl	%ecx, %eax
	je	.LBB23_17
	.p2align	4, 0x90
.LBB23_16:                              # %while.body48
                                        # =>This Inner Loop Header: Depth=1
	movq	8(%r12,%rcx,8), %rdx
	movq	%rdx, (%r14,%rcx,8)
	incq	%rcx
	cmpl	%ecx, %eax
	jne	.LBB23_16
.LBB23_17:                              # %while.end51
	movq	$0, (%r14,%rcx,8)
	jmp	.LBB23_21
.LBB23_19:                              # %if.then17
	movq	%r15, %rdi
	callq	free
.LBB23_20:                              # %return
	xorl	%r15d, %r15d
.LBB23_21:                              # %return
	movq	%r15, %rax
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
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
.Lcfi119:
	.cfi_def_cfa_offset 16
.Lcfi120:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi121:
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
.Lcfi122:
	.cfi_def_cfa_offset 16
.Lcfi123:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi124:
	.cfi_def_cfa_register %rbp
	xorl	%r9d, %r9d
	callq	_getopt_internal
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
.Lcfi125:
	.cfi_def_cfa_offset 16
.Lcfi126:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi127:
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
.Lcfi128:
	.cfi_def_cfa_offset 16
.Lcfi129:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi130:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi131:
	.cfi_offset %rbx, -24
	movl	%edi, %ebx
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
	movl	%ebx, %edi
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
.Lcfi132:
	.cfi_def_cfa_offset 16
.Lcfi133:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi134:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi135:
	.cfi_offset %rbx, -24
	movq	progname(%rip), %rsi
	movl	$.L.str.105, %edi
	movl	$.L.str.106, %edx
	movl	$.L.str.107, %ecx
	xorl	%eax, %eax
	callq	printf
	callq	usage
	movl	$help.help_msg, %ebx
	cmpq	$0, (%rbx)
	je	.LBB28_3
	.p2align	4, 0x90
.LBB28_2:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movq	(%rbx), %rsi
	addq	$8, %rbx
	movl	$.L.str.108, %edi
	xorl	%eax, %eax
	callq	printf
	cmpq	$0, (%rbx)
	jne	.LBB28_2
.LBB28_3:                               # %while.end
	addq	$8, %rsp
	popq	%rbx
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
.Lcfi136:
	.cfi_def_cfa_offset 16
.Lcfi137:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi138:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi139:
	.cfi_offset %rbx, -24
	movq	progname(%rip), %rsi
	movl	$.L.str.105, %edi
	movl	$.L.str.106, %edx
	movl	$.L.str.107, %ecx
	xorl	%eax, %eax
	callq	printf
	movl	$license_msg, %ebx
	cmpq	$0, (%rbx)
	je	.LBB29_3
	.p2align	4, 0x90
.LBB29_2:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movq	(%rbx), %rsi
	addq	$8, %rbx
	movl	$.L.str.108, %edi
	xorl	%eax, %eax
	callq	printf
	cmpq	$0, (%rbx)
	jne	.LBB29_2
.LBB29_3:                               # %while.end
	addq	$8, %rsp
	popq	%rbx
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
.Lcfi140:
	.cfi_def_cfa_offset 16
.Lcfi141:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi142:
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
.Lcfi143:
	.cfi_def_cfa_offset 16
.Lcfi144:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi145:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi146:
	.cfi_offset %rbx, -32
.Lcfi147:
	.cfi_offset %r14, -24
	movl	%esi, %r14d
	movl	%edi, %ebx
	cmpl	$0, msg_done(%rip)
	jne	.LBB31_3
# BB#1:                                 # %if.end
	movl	$1, msg_done(%rip)
	movq	stderr(%rip), %rdi
	movl	$.L.str.52, %esi
	xorl	%eax, %eax
	callq	fprintf
	cmpl	%r14d, %ebx
	je	.LBB31_3
# BB#2:                                 # %if.then1
	movl	$1, exit_code(%rip)
.LBB31_3:                               # %return
	movl	$1, %eax
	popq	%rbx
	popq	%r14
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
.Lcfi148:
	.cfi_def_cfa_offset 16
.Lcfi149:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi150:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$144, %rsp
.Lcfi151:
	.cfi_offset %rbx, -32
.Lcfi152:
	.cfi_offset %r14, -24
	movq	%rdi, %rbx
	movl	$.L.str.149, %esi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB32_1
# BB#2:                                 # %if.end
	movl	$istat, %esi
	movq	%rbx, %rdi
	callq	get_istat
	testl	%eax, %eax
	jne	.LBB32_66
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
	leaq	-160(%rbp), %r14
	movl	$istat, %esi
	movl	$144, %edx
	movq	%r14, %rdi
	callq	memcpy
	movq	%rbx, %rdi
	callq	treat_dir
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	reset_times
	jmp	.LBB32_66
.LBB32_1:                               # %if.then
	movl	to_stdout(%rip), %ebx
	callq	treat_stdin
	movl	%ebx, to_stdout(%rip)
.LBB32_66:                              # %if.end155
	addq	$144, %rsp
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.LBB32_10:                              # %if.end16
	andl	istat+24(%rip), %eax
	cmpl	$32768, %eax            # imm = 0x8000
	jne	.LBB32_11
# BB#15:                                # %if.end27
	cmpq	$2, istat+16(%rip)
	jb	.LBB32_22
# BB#16:                                # %if.end27
	movl	to_stdout(%rip), %eax
	testl	%eax, %eax
	jne	.LBB32_22
# BB#17:                                # %if.end27
	movl	force(%rip), %eax
	testl	%eax, %eax
	jne	.LBB32_22
# BB#18:                                # %if.then32
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
	jne	.LBB32_66
# BB#21:                                # %if.then39
	movl	$2, exit_code(%rip)
	jmp	.LBB32_66
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
	jne	.LBB32_66
# BB#14:                                # %if.then25
	movl	$2, exit_code(%rip)
	jmp	.LBB32_66
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
	jne	.LBB32_66
# BB#9:                                 # %if.then13
	movl	$2, exit_code(%rip)
	jmp	.LBB32_66
.LBB32_22:                              # %if.end41
	movq	istat+48(%rip), %rax
	movq	%rax, ifile_size(%rip)
	xorl	%eax, %eax
	cmpl	$0, list(%rip)
	movq	istat+88(%rip), %rcx
	cmovneq	%rcx, %rax
	cmpl	$0, no_time(%rip)
	cmoveq	%rcx, %rax
	movq	%rax, time_stamp(%rip)
	cmpl	$0, to_stdout(%rip)
	je	.LBB32_26
# BB#23:                                # %if.end41
	movl	list(%rip), %eax
	testl	%eax, %eax
	jne	.LBB32_26
# BB#24:                                # %if.end41
	movl	test(%rip), %eax
	testl	%eax, %eax
	jne	.LBB32_26
# BB#25:                                # %if.then51
	movl	$ofname, %edi
	movl	$.L.str.16, %esi
	callq	strcpy
	jmp	.LBB32_27
.LBB32_26:                              # %if.else53
	callq	make_ofname
	testl	%eax, %eax
	jne	.LBB32_66
.LBB32_27:                              # %if.end58
	cmpl	$0, ascii(%rip)
	movl	$ifname, %edi
	xorl	%esi, %esi
	movl	$384, %edx              # imm = 0x180
	xorl	%eax, %eax
	callq	open
	movl	%eax, ifd(%rip)
	cmpl	$-1, %eax
	je	.LBB32_28
# BB#29:                                # %if.end65
	callq	clear_bufs
	movl	$0, part_nb(%rip)
	cmpl	$0, decompress(%rip)
	je	.LBB32_32
# BB#30:                                # %if.then67
	movl	ifd(%rip), %edi
	callq	get_method
	movl	%eax, method(%rip)
	testl	%eax, %eax
	js	.LBB32_31
.LBB32_32:                              # %if.end73
	cmpl	$0, list(%rip)
	je	.LBB32_34
# BB#33:                                # %if.then75
	movl	ifd(%rip), %edi
	movl	method(%rip), %esi
	callq	do_list
.LBB32_31:                              # %if.then70
	movl	ifd(%rip), %edi
	callq	close
	jmp	.LBB32_66
.LBB32_28:                              # %if.then64
	movl	$ifname, %edi
	callq	progerror
	jmp	.LBB32_66
.LBB32_34:                              # %if.end77
	cmpl	$0, to_stdout(%rip)
	je	.LBB32_36
# BB#35:                                # %if.then79
	movq	stdout(%rip), %rdi
	callq	fileno
	movl	%eax, ofd(%rip)
.LBB32_41:                              # %if.end96
	cmpl	$0, save_orig_name(%rip)
	jne	.LBB32_43
.LBB32_42:                              # %if.then98
	xorl	%eax, %eax
	cmpl	$0, no_name(%rip)
	sete	%al
	movl	%eax, save_orig_name(%rip)
.LBB32_43:                              # %if.end101
	cmpl	$0, verbose(%rip)
	je	.LBB32_45
# BB#44:                                # %if.then103
	movq	stderr(%rip), %rdi
	movl	$.L.str.154, %esi
	movl	$ifname, %edx
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB32_45
.LBB32_55:                              # %if.end117
                                        #   in Loop: Header=BB32_45 Depth=1
	movq	$0, bytes_out(%rip)
.LBB32_45:                              # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	ifd(%rip), %edi
	movl	ofd(%rip), %esi
	callq	*work(%rip)
	testl	%eax, %eax
	jne	.LBB32_46
# BB#53:                                # %if.end109
                                        #   in Loop: Header=BB32_45 Depth=1
	callq	input_eof
	testl	%eax, %eax
	jne	.LBB32_47
# BB#54:                                # %if.end113
                                        #   in Loop: Header=BB32_45 Depth=1
	movl	ifd(%rip), %edi
	callq	get_method
	movl	%eax, method(%rip)
	testl	%eax, %eax
	jns	.LBB32_55
	jmp	.LBB32_47
.LBB32_36:                              # %if.else81
	callq	create_outfile
	testl	%eax, %eax
	jne	.LBB32_66
# BB#37:                                # %if.end85
	cmpl	$0, decompress(%rip)
	setne	%al
	cmpl	$0, save_orig_name(%rip)
	sete	%cl
	orb	%al, %cl
	jne	.LBB32_41
# BB#38:                                # %if.end85
	movl	verbose(%rip), %eax
	testl	%eax, %eax
	jne	.LBB32_41
# BB#39:                                # %if.end85
	movl	quiet(%rip), %eax
	testl	%eax, %eax
	jne	.LBB32_41
# BB#40:                                # %if.then93
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.153, %esi
	movl	$ifname, %ecx
	movl	$ofname, %r8d
	xorl	%eax, %eax
	callq	fprintf
	cmpl	$0, save_orig_name(%rip)
	jne	.LBB32_43
	jmp	.LBB32_42
.LBB32_46:                              # %if.then108
	movl	$-1, method(%rip)
.LBB32_47:                              # %for.end
	movl	ifd(%rip), %edi
	callq	close
	cmpl	$0, to_stdout(%rip)
	jne	.LBB32_50
# BB#48:                                # %if.then120
	movl	$istat, %edi
	callq	copy_stat
	movl	ofd(%rip), %edi
	callq	close
	testl	%eax, %eax
	je	.LBB32_50
# BB#49:                                # %if.then123
	callq	write_error
.LBB32_50:                              # %if.end125
	cmpl	$-1, method(%rip)
	je	.LBB32_51
# BB#56:                                # %if.end132
	cmpl	$0, verbose(%rip)
	je	.LBB32_66
# BB#57:                                # %if.then134
	cmpl	$0, test(%rip)
	je	.LBB32_59
# BB#58:                                # %if.then136
	movq	stderr(%rip), %rdi
	movl	$.L.str.155, %esi
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB32_63
.LBB32_51:                              # %if.then127
	cmpl	$0, to_stdout(%rip)
	jne	.LBB32_66
# BB#52:                                # %if.then129
	movl	$ofname, %edi
	callq	xunlink
	jmp	.LBB32_66
.LBB32_59:                              # %if.else138
	cmpl	$0, decompress(%rip)
	je	.LBB32_61
# BB#60:                                # %if.then140
	movq	bytes_out(%rip), %rsi
	movq	bytes_in(%rip), %rax
	jmp	.LBB32_62
.LBB32_61:                              # %if.else143
	movq	bytes_in(%rip), %rsi
	movq	bytes_out(%rip), %rax
.LBB32_62:                              # %if.end147
	subq	header_bytes(%rip), %rax
	movq	%rsi, %rdi
	subq	%rax, %rdi
	movq	stderr(%rip), %rdx
	callq	display_ratio
.LBB32_63:                              # %if.end147
	movl	test(%rip), %eax
	orl	to_stdout(%rip), %eax
	jne	.LBB32_65
# BB#64:                                # %if.then151
	movq	stderr(%rip), %rdi
	movl	$.L.str.156, %esi
	movl	$ofname, %edx
	xorl	%eax, %eax
	callq	fprintf
.LBB32_65:                              # %if.end153
	movq	stderr(%rip), %rdi
	movl	$.L.str.123, %esi
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB32_66
.Lfunc_end32:
	.size	treat_file, .Lfunc_end32-treat_file
	.cfi_endproc

	.p2align	4, 0x90
	.type	treat_stdin,@function
treat_stdin:                            # @treat_stdin
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
	movl	force(%rip), %eax
	orl	list(%rip), %eax
	jne	.LBB33_3
# BB#1:                                 # %land.lhs.true2
	cmpl	$0, decompress(%rip)
	movl	$stdin, %eax
	movl	$stdout, %ecx
	cmovneq	%rax, %rcx
	movq	(%rcx), %rdi
	callq	fileno
	movl	%eax, %edi
	callq	isatty
	testl	%eax, %eax
	je	.LBB33_3
# BB#2:                                 # %if.then
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
.LBB33_3:                               # %if.end
	movl	$ifname, %edi
	movl	$.L.str.130, %esi
	callq	strcpy
	movl	$ofname, %edi
	movl	$.L.str.16, %esi
	callq	strcpy
	movq	$0, time_stamp(%rip)
	cmpl	$0, list(%rip)
	jne	.LBB33_5
# BB#4:                                 # %if.end
	movl	no_time(%rip), %eax
	testl	%eax, %eax
	jne	.LBB33_8
.LBB33_5:                               # %if.then30
	movq	stdin(%rip), %rdi
	callq	fileno
	movl	$istat, %esi
	movl	%eax, %edi
	callq	fstat
	testl	%eax, %eax
	je	.LBB33_7
# BB#6:                                 # %if.then33
	movl	$.L.str.131, %edi
	callq	progerror
	movl	$1, %edi
	callq	do_exit
.LBB33_7:                               # %if.end34
	movq	istat+88(%rip), %rax
	movq	%rax, time_stamp(%rip)
.LBB33_8:                               # %if.end35
	movq	$-1, ifile_size(%rip)
	callq	clear_bufs
	movl	$1, to_stdout(%rip)
	movl	$0, part_nb(%rip)
	cmpl	$0, decompress(%rip)
	je	.LBB33_11
# BB#9:                                 # %if.then37
	movl	ifd(%rip), %edi
	callq	get_method
	movl	%eax, method(%rip)
	testl	%eax, %eax
	jns	.LBB33_11
# BB#10:                                # %if.then40
	movl	exit_code(%rip), %edi
	callq	do_exit
.LBB33_11:                              # %if.end42
	cmpl	$0, list(%rip)
	je	.LBB33_13
# BB#12:                                # %if.then44
	movl	ifd(%rip), %edi
	movl	method(%rip), %esi
	callq	do_list
.LBB33_23:                              # %if.end71
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
	.p2align	4, 0x90
.LBB33_16:                              # %if.end59
                                        #   in Loop: Header=BB33_13 Depth=1
	movq	$0, bytes_out(%rip)
.LBB33_13:                              # %for.cond
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
	jne	.LBB33_23
# BB#14:                                # %if.end51
                                        #   in Loop: Header=BB33_13 Depth=1
	callq	input_eof
	testl	%eax, %eax
	jne	.LBB33_17
# BB#15:                                # %if.end55
                                        #   in Loop: Header=BB33_13 Depth=1
	movl	ifd(%rip), %edi
	callq	get_method
	movl	%eax, method(%rip)
	testl	%eax, %eax
	jns	.LBB33_16
	jmp	.LBB33_23
.LBB33_17:                              # %for.end
	cmpl	$0, verbose(%rip)
	je	.LBB33_23
# BB#18:                                # %if.then61
	cmpl	$0, test(%rip)
	je	.LBB33_20
# BB#19:                                # %if.then63
	movq	stderr(%rip), %rdi
	movl	$.L.str.132, %esi
.LBB33_22:                              # %if.end71
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB33_23
.LBB33_20:                              # %if.else
	cmpl	$0, decompress(%rip)
	jne	.LBB33_23
# BB#21:                                # %if.then66
	movq	bytes_in(%rip), %rsi
	movq	bytes_out(%rip), %rax
	subq	header_bytes(%rip), %rax
	movq	%rsi, %rdi
	subq	%rax, %rdi
	movq	stderr(%rip), %rdx
	callq	display_ratio
	movq	stderr(%rip), %rdi
	movl	$.L.str.123, %esi
	jmp	.LBB33_22
.Lfunc_end33:
	.size	treat_stdin, .Lfunc_end33-treat_stdin
	.cfi_endproc

	.p2align	4, 0x90
	.type	do_list,@function
do_list:                                # @do_list
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
	pushq	%r12
	pushq	%rbx
	subq	$16, %rsp
.Lcfi161:
	.cfi_offset %rbx, -48
.Lcfi162:
	.cfi_offset %r12, -40
.Lcfi163:
	.cfi_offset %r14, -32
.Lcfi164:
	.cfi_offset %r15, -24
	movl	%esi, %r14d
	movl	%edi, %r15d
	movabsq	$9223372036854775807, %rdx # imm = 0x7FFFFFFFFFFFFFFF
	movl	$1, %ebx
	movabsq	$7378697629483820647, %rcx # imm = 0x6666666666666667
	cmpq	$10, %rdx
	jl	.LBB34_3
	.p2align	4, 0x90
.LBB34_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	incl	%ebx
	movq	%rdx, %rax
	imulq	%rcx
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$2, %rdx
	addq	%rax, %rdx
	cmpq	$10, %rdx
	jge	.LBB34_2
.LBB34_3:                               # %for.end
	cmpl	$0, do_list.first_time(%rip)
	je	.LBB34_19
# BB#4:                                 # %for.end
	testl	%r14d, %r14d
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
	movq	$.L.str.190, (%rsp)
	movl	$.L.str.188, %edi
	movl	$.L.str.189, %ecx
	xorl	%eax, %eax
	movl	%ebx, %esi
	movl	%ebx, %edx
	movl	%ebx, %r8d
	movl	%ebx, %r9d
	callq	printf
	jmp	.LBB34_9
.LBB34_19:                              # %if.else
	testl	%r14d, %r14d
	js	.LBB34_20
.LBB34_9:                               # %if.end28
	movq	$-1, bytes_out(%rip)
	movq	ifile_size(%rip), %rax
	movq	%rax, bytes_in(%rip)
	cmpl	$8, %r14d
	movq	$-1, %r12
	jne	.LBB34_15
# BB#10:                                # %if.end28
	movl	last_member(%rip), %eax
	testl	%eax, %eax
	jne	.LBB34_15
# BB#11:                                # %if.then32
	movq	$-8, %rsi
	movl	$2, %edx
	movl	%r15d, %edi
	callq	lseek
	movq	%rax, bytes_in(%rip)
	cmpq	$-1, %rax
	je	.LBB34_15
# BB#12:                                # %if.then35
	addq	$8, bytes_in(%rip)
	leaq	-40(%rbp), %rsi
	movl	$8, %edx
	movl	%r15d, %edi
	callq	read
	cmpq	$8, %rax
	je	.LBB34_14
# BB#13:                                # %if.then38
	callq	read_error
.LBB34_14:                              # %if.end39
	movzbl	-40(%rbp), %eax
	movzbl	-39(%rbp), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	-38(%rbp), %eax
	movzbl	-37(%rbp), %r12d
	shll	$8, %r12d
	orl	%eax, %r12d
	shlq	$16, %r12
	orq	%rcx, %r12
	movzbl	-36(%rbp), %eax
	movzbl	-35(%rbp), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	-34(%rbp), %eax
	movzbl	-33(%rbp), %edx
	shll	$8, %edx
	orl	%eax, %edx
	shlq	$16, %rdx
	orq	%rcx, %rdx
	movq	%rdx, bytes_out(%rip)
.LBB34_15:                              # %if.end90
	movl	$time_stamp, %edi
	callq	ctime
	movq	%rax, %rcx
	movb	$0, 16(%rcx)
	cmpl	$0, verbose(%rip)
	je	.LBB34_17
# BB#16:                                # %if.then95
	addq	$4, %rcx
	movslq	%r14d, %rax
	movq	do_list.methods(,%rax,8), %rsi
	movl	$.L.str.194, %edi
	xorl	%eax, %eax
	movq	%r12, %rdx
	callq	printf
.LBB34_17:                              # %if.end98
	movq	stdout(%rip), %rdi
	movq	bytes_in(%rip), %rsi
	movl	%ebx, %edx
	callq	fprint_off
	movl	$.L.str.192, %edi
	xorl	%eax, %eax
	callq	printf
	movq	stdout(%rip), %rdi
	movq	bytes_out(%rip), %rsi
	movl	%ebx, %edx
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
	addq	$16, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB34_20:                              # %if.then9
	cmpq	$0, total_in(%rip)
	jle	.LBB34_35
# BB#21:                                # %if.then9
	movq	total_out(%rip), %rax
	testq	%rax, %rax
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
	jne	.LBB34_26
# BB#25:                                # %if.end17
	movl	quiet(%rip), %eax
	testl	%eax, %eax
	jne	.LBB34_27
.LBB34_26:                              # %if.then21
	movq	stdout(%rip), %rdi
	movq	total_in(%rip), %rsi
	movl	%ebx, %edx
	callq	fprint_off
	movl	$.L.str.192, %edi
	xorl	%eax, %eax
	callq	printf
	movq	stdout(%rip), %rdi
	movq	total_out(%rip), %rsi
	movl	%ebx, %edx
	callq	fprint_off
	movl	$.L.str.192, %edi
	xorl	%eax, %eax
	callq	printf
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
.Lcfi165:
	.cfi_def_cfa_offset 16
.Lcfi166:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi167:
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
.Lcfi168:
	.cfi_def_cfa_offset 16
.Lcfi169:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi170:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$1576, %rsp             # imm = 0x628
.Lcfi171:
	.cfi_offset %rbx, -56
.Lcfi172:
	.cfi_offset %r12, -48
.Lcfi173:
	.cfi_offset %r13, -40
.Lcfi174:
	.cfi_offset %r14, -32
.Lcfi175:
	.cfi_offset %r15, -24
	movq	16(%rbp), %r13
	xorps	%xmm0, %xmm0
	movaps	%xmm0, -208(%rbp)
	movaps	%xmm0, -224(%rbp)
	movaps	%xmm0, -240(%rbp)
	movaps	%xmm0, -256(%rbp)
	movl	$0, -192(%rbp)
	movl	%esi, %r12d
	xorl	%eax, %eax
	.p2align	4, 0x90
.LBB36_1:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movl	(%rdi,%rax,4), %ebx
	incl	-256(%rbp,%rbx,4)
	incq	%rax
	cmpl	%eax, %r12d
	jne	.LBB36_1
# BB#2:                                 # %do.end
	cmpl	%esi, -256(%rbp)
	jne	.LBB36_4
# BB#3:                                 # %if.then
	movq	$0, (%r9)
	movl	$0, (%r13)
	xorl	%r14d, %r14d
	jmp	.LBB36_60
.LBB36_4:                               # %if.end
	movq	%rcx, -168(%rbp)        # 8-byte Spill
	movq	%r9, -152(%rbp)         # 8-byte Spill
	movl	(%r13), %r14d
	leaq	-248(%rbp), %rbx
	movl	$1, %esi
	movl	$3, %r11d
	jmp	.LBB36_5
	.p2align	4, 0x90
.LBB36_7:                               # %for.inc
                                        #   in Loop: Header=BB36_5 Depth=1
	incl	%esi
	incl	%r11d
	addq	$4, %rbx
.LBB36_5:                               # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	leal	-2(%r11), %ecx
	cmpl	$16, %ecx
	ja	.LBB36_8
# BB#6:                                 # %for.body
                                        #   in Loop: Header=BB36_5 Depth=1
	movl	%ecx, %eax
	cmpl	$0, -256(%rbp,%rax,4)
	je	.LBB36_7
.LBB36_8:                               # %for.end
	movq	%r8, -176(%rbp)         # 8-byte Spill
	cmpl	%ecx, %r14d
	movl	%r14d, %eax
	movq	%rcx, -88(%rbp)         # 8-byte Spill
	cmovbl	%ecx, %eax
	movq	%rax, %rcx
	leaq	-272(%rbp), %r10
	movl	$-17, %r9d
	xorl	%eax, %eax
	jmp	.LBB36_9
	.p2align	4, 0x90
.LBB36_11:                              # %for.inc20
                                        #   in Loop: Header=BB36_9 Depth=1
	incl	%r9d
	decl	%eax
	addq	$-4, %r10
.LBB36_9:                               # %for.cond12
                                        # =>This Inner Loop Header: Depth=1
	leal	16(%rax), %r8d
	cmpl	$-16, %eax
	je	.LBB36_12
# BB#10:                                # %for.body14
                                        #   in Loop: Header=BB36_9 Depth=1
	movq	%rax, %r15
	movl	%r8d, %eax
	cmpl	$0, -256(%rbp,%rax,4)
	movq	%r15, %rax
	je	.LBB36_11
.LBB36_12:                              # %for.end22
	movl	%edx, -104(%rbp)        # 4-byte Spill
	movl	%esi, -44(%rbp)         # 4-byte Spill
	cmpl	%r8d, %ecx
	cmoval	%r8d, %ecx
	movq	%rcx, -80(%rbp)         # 8-byte Spill
	movl	%ecx, (%r13)
	movl	$1, %edx
	movq	-88(%rbp), %rcx         # 8-byte Reload
	shll	%cl, %edx
	movl	$-15, %r13d
	subl	%eax, %r13d
	movl	$-17, %r15d
	movq	%rax, %rsi
	movq	%rsi, -136(%rbp)        # 8-byte Spill
	subl	%eax, %r15d
	movl	%ecx, %eax
	cmpl	%r8d, %eax
	jb	.LBB36_14
	jmp	.LBB36_17
	.p2align	4, 0x90
.LBB36_16:                              # %for.inc34
                                        #   in Loop: Header=BB36_14 Depth=1
	incl	%eax
	addl	%edx, %edx
	cmpl	%r8d, %eax
	jae	.LBB36_17
.LBB36_14:                              # %for.body28
                                        # =>This Inner Loop Header: Depth=1
	movl	%eax, %esi
	subl	-256(%rbp,%rsi,4), %edx
	jns	.LBB36_16
# BB#15:
	movl	$2, %r14d
	jmp	.LBB36_60
.LBB36_17:                              # %for.end37
	movl	%r8d, %eax
	subl	-256(%rbp,%rax,4), %edx
	js	.LBB36_18
# BB#19:                                # %if.end43
	movq	%rbx, -144(%rbp)        # 8-byte Spill
	addl	%edx, -256(%rbp,%rax,4)
	movl	$0, -332(%rbp)
	leaq	-252(%rbp), %rbx
	xorl	%esi, %esi
	leaq	-328(%rbp), %rax
	testl	%r13d, %r13d
	je	.LBB36_21
	.p2align	4, 0x90
.LBB36_61:                              # %while.body
                                        # =>This Inner Loop Header: Depth=1
	addl	(%rbx), %esi
	addq	$4, %rbx
	movl	%esi, (%rax)
	addq	$4, %rax
	incl	%r13d
	testl	%r13d, %r13d
	jne	.LBB36_61
.LBB36_21:                              # %do.body55.preheader
	xorl	%ecx, %ecx
	.p2align	4, 0x90
.LBB36_22:                              # %do.body55
                                        # =>This Inner Loop Header: Depth=1
	movl	(%rdi,%rcx,4), %eax
	testq	%rax, %rax
	je	.LBB36_24
# BB#23:                                # %if.then58
                                        #   in Loop: Header=BB36_22 Depth=1
	movl	-336(%rbp,%rax,4), %esi
	leal	1(%rsi), %ebx
	movl	%ebx, -336(%rbp,%rax,4)
	movl	%ecx, -1616(%rbp,%rsi,4)
.LBB36_24:                              # %do.cond65
                                        #   in Loop: Header=BB36_22 Depth=1
	incq	%rcx
	cmpl	%r12d, %ecx
	jb	.LBB36_22
# BB#25:                                # %do.end68
	movl	%r8d, -100(%rbp)        # 4-byte Spill
	movl	(%r10), %ecx
	movl	$0, -336(%rbp)
	leaq	-1616(%rbp), %rax
	movq	%rax, -128(%rbp)        # 8-byte Spill
	movq	-80(%rbp), %r8          # 8-byte Reload
	movl	%r8d, %r10d
	negl	%r10d
	movq	$0, -464(%rbp)
	movq	-88(%rbp), %rbx         # 8-byte Reload
	cmpl	%ebx, %r14d
	movl	%ebx, %edi
	cmoval	%r14d, %edi
	notl	%edi
	cmpl	%edi, %r15d
	cmovbel	%edi, %r15d
	movl	-44(%rbp), %esi         # 4-byte Reload
	cmpl	%esi, %r14d
	cmoval	%r14d, %esi
	notl	%esi
	cmpl	%esi, %r9d
	cmoval	%r9d, %esi
	addl	%r11d, %esi
	movl	%esi, -44(%rbp)         # 4-byte Spill
	incl	%r15d
	movl	%r15d, -108(%rbp)       # 4-byte Spill
	cmpl	%edi, %r9d
	cmoval	%r9d, %edi
	movq	-136(%rbp), %rsi        # 8-byte Reload
	leal	17(%rdi,%rsi), %esi
	movl	%esi, -112(%rbp)        # 4-byte Spill
	movl	$-1, %r15d
	xorl	%eax, %eax
	leaq	-1616(%rbp,%rcx,4), %rcx
	movq	%rcx, -160(%rbp)        # 8-byte Spill
	xorl	%r9d, %r9d
	xorl	%r14d, %r14d
	movl	%edx, -48(%rbp)         # 4-byte Spill
	cmpl	-100(%rbp), %ebx        # 4-byte Folded Reload
	jle	.LBB36_27
.LBB36_59:                              # %for.end226
	testl	%edx, %edx
	setne	%al
	cmpl	$-15, -136(%rbp)        # 4-byte Folded Reload
	setne	%cl
	andb	%al, %cl
	movzbl	%cl, %r14d
	jmp	.LBB36_60
.LBB36_18:
	movl	$2, %r14d
	jmp	.LBB36_60
.LBB36_58:                              # %for.inc224
                                        #   in Loop: Header=BB36_27 Depth=1
	incl	%ebx
	incl	-44(%rbp)               # 4-byte Folded Spill
	addq	$4, -144(%rbp)          # 8-byte Folded Spill
	cmpl	-100(%rbp), %ebx        # 4-byte Folded Reload
	jg	.LBB36_59
.LBB36_27:                              # %for.body77
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB36_30 Depth 2
                                        #       Child Loop BB36_31 Depth 3
                                        #         Child Loop BB36_36 Depth 4
                                        #       Child Loop BB36_52 Depth 3
                                        #       Child Loop BB36_54 Depth 3
                                        #       Child Loop BB36_56 Depth 3
	movslq	%ebx, %rcx
	movl	-256(%rbp,%rcx,4), %r11d
	movq	%rbx, -88(%rbp)         # 8-byte Spill
	testl	%r11d, %r11d
	jne	.LBB36_30
	jmp	.LBB36_58
.LBB36_28:                              # %while.cond80.loopexit
                                        #   in Loop: Header=BB36_30 Depth=2
	movq	%r13, -128(%rbp)        # 8-byte Spill
                                        # kill: %R15D<def> %R15D<kill> %R15<kill>
	movq	%r12, %rbx
	testl	%r11d, %r11d
	je	.LBB36_58
.LBB36_30:                              # %while.cond84.preheader
                                        #   Parent Loop BB36_27 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB36_31 Depth 3
                                        #         Child Loop BB36_36 Depth 4
                                        #       Child Loop BB36_52 Depth 3
                                        #       Child Loop BB36_54 Depth 3
                                        #       Child Loop BB36_56 Depth 3
	movq	%r14, -72(%rbp)         # 8-byte Spill
	movq	%rax, -96(%rbp)         # 8-byte Spill
	decl	%r11d
	movl	-44(%rbp), %r12d        # 4-byte Reload
	subl	%r10d, %r12d
	movslq	%r15d, %rsi
	jmp	.LBB36_31
	.p2align	4, 0x90
.LBB36_43:                              # %while.cond84.backedge
                                        #   in Loop: Header=BB36_31 Depth=3
	movl	-116(%rbp), %r12d       # 4-byte Reload
	addl	-108(%rbp), %r12d       # 4-byte Folded Reload
	movq	-184(%rbp), %rsi        # 8-byte Reload
	incq	%rsi
	movq	%rax, -152(%rbp)        # 8-byte Spill
	movl	%r13d, %r10d
	movq	-88(%rbp), %rbx         # 8-byte Reload
.LBB36_31:                              # %while.cond84
                                        #   Parent Loop BB36_27 Depth=1
                                        #     Parent Loop BB36_30 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB36_36 Depth 4
	leal	(%r10,%r8), %r13d
	movl	%ebx, %r14d
	subl	%r13d, %r14d
	jle	.LBB36_44
# BB#32:                                # %while.body87
                                        #   in Loop: Header=BB36_31 Depth=3
	movl	-112(%rbp), %edx        # 4-byte Reload
	subl	%r10d, %edx
	cmpl	%r8d, %edx
	cmoval	%r8d, %edx
	movl	$1, %eax
	movl	%r14d, %ecx
	shll	%cl, %eax
	leal	1(%r11), %ecx
	subl	%ecx, %eax
	movq	%rsi, -184(%rbp)        # 8-byte Spill
	jbe	.LBB36_38
# BB#33:                                # %if.then96
                                        #   in Loop: Header=BB36_31 Depth=3
	cmpl	%edx, %r14d
	jae	.LBB36_38
# BB#34:                                # %while.cond103.preheader
                                        #   in Loop: Header=BB36_31 Depth=3
	movq	-144(%rbp), %rcx        # 8-byte Reload
	movl	%r12d, %r14d
	cmpl	%edx, %r14d
	jb	.LBB36_36
	jmp	.LBB36_38
	.p2align	4, 0x90
.LBB36_37:                              # %if.end111
                                        #   in Loop: Header=BB36_36 Depth=4
	subl	(%rcx), %eax
	incl	%r14d
	addq	$4, %rcx
	cmpl	%edx, %r14d
	jae	.LBB36_38
.LBB36_36:                              # %while.body106
                                        #   Parent Loop BB36_27 Depth=1
                                        #     Parent Loop BB36_30 Depth=2
                                        #       Parent Loop BB36_31 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	addl	%eax, %eax
	cmpl	(%rcx), %eax
	ja	.LBB36_37
	.p2align	4, 0x90
.LBB36_38:                              # %if.end115
                                        #   in Loop: Header=BB36_31 Depth=3
	movl	%r12d, -116(%rbp)       # 4-byte Spill
	movq	%r11, %rbx
	incl	%r15d
	movl	$1, %r12d
	movl	%r14d, %ecx
	shll	%cl, %r12d
	leal	1(%r12), %edi
	shlq	$4, %rdi
	callq	malloc
	testq	%rax, %rax
	je	.LBB36_39
# BB#41:                                # %if.end126
                                        #   in Loop: Header=BB36_31 Depth=3
	movq	%rax, %rcx
	movl	hufts(%rip), %edx
	movq	%r12, -72(%rbp)         # 8-byte Spill
	leal	1(%rdx,%r12), %edx
	movl	%edx, hufts(%rip)
	leaq	16(%rax), %r9
	movq	-152(%rbp), %rsi        # 8-byte Reload
	movq	%r9, (%rsi)
	addq	$8, %rax
	movq	$0, 8(%rcx)
	movslq	%r15d, %rsi
	movq	%r9, -464(%rbp,%rsi,8)
	testl	%esi, %esi
	movq	-80(%rbp), %r8          # 8-byte Reload
	movq	%rbx, %r11
	je	.LBB36_43
# BB#42:                                # %if.then136
                                        #   in Loop: Header=BB36_31 Depth=3
	movq	-96(%rbp), %rdx         # 8-byte Reload
	movl	%edx, -336(%rbp,%rsi,4)
	movb	%r8b, -63(%rbp)
	addl	$16, %r14d
	movb	%r14b, -64(%rbp)
	movq	%r9, -56(%rbp)
	movl	%r13d, %ecx
	subl	%r8d, %ecx
	movl	%edx, %edi
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %edi
	decl	%esi
	movslq	%esi, %rcx
	movq	-464(%rbp,%rcx,8), %rcx
	shlq	$4, %rdi
	movups	-64(%rbp), %xmm0
	movups	%xmm0, (%rcx,%rdi)
	jmp	.LBB36_43
.LBB36_44:                              # %while.end153
                                        #   in Loop: Header=BB36_30 Depth=2
	movq	%rsi, %r15
	movq	%rbx, %r12
	movl	%ebx, %ecx
	subl	%r10d, %ecx
	movb	%cl, -63(%rbp)
	movq	-128(%rbp), %r13        # 8-byte Reload
	cmpq	-160(%rbp), %r13        # 8-byte Folded Reload
	jb	.LBB36_46
# BB#45:                                # %if.then162
                                        #   in Loop: Header=BB36_30 Depth=2
	movb	$99, -64(%rbp)
	movl	-48(%rbp), %edx         # 4-byte Reload
	movq	-96(%rbp), %rax         # 8-byte Reload
	jmp	.LBB36_50
.LBB36_46:                              # %if.else
                                        #   in Loop: Header=BB36_30 Depth=2
	movq	%r11, %r14
	movl	(%r13), %esi
	movl	%esi, %edi
	movl	-104(%rbp), %r8d        # 4-byte Reload
	subl	%r8d, %edi
	movl	-48(%rbp), %edx         # 4-byte Reload
	movq	%r13, %r11
	movq	-96(%rbp), %rax         # 8-byte Reload
	jae	.LBB36_48
# BB#47:                                # %if.then166
                                        #   in Loop: Header=BB36_30 Depth=2
	cmpl	$256, %esi              # imm = 0x100
	movb	$15, %bl
	adcb	$0, %bl
	movb	%bl, -64(%rbp)
	movzwl	(%r11), %esi
	movw	%si, -56(%rbp)
	addq	$4, %r11
	jmp	.LBB36_49
.LBB36_48:                              # %if.else176
                                        #   in Loop: Header=BB36_30 Depth=2
	movq	-176(%rbp), %rsi        # 8-byte Reload
	movb	(%rsi,%rdi,2), %bl
	movb	%bl, -64(%rbp)
	movl	(%r11), %esi
	addq	$4, %r11
	subl	%r8d, %esi
	movq	-168(%rbp), %rdi        # 8-byte Reload
	movzwl	(%rdi,%rsi,2), %esi
	movw	%si, -56(%rbp)
.LBB36_49:                              # %if.end189
                                        #   in Loop: Header=BB36_30 Depth=2
	movq	-80(%rbp), %r8          # 8-byte Reload
	movq	%r11, %r13
	movq	%r14, %r11
.LBB36_50:                              # %if.end189
                                        #   in Loop: Header=BB36_30 Depth=2
	movq	-72(%rbp), %r14         # 8-byte Reload
	movl	$1, %esi
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shll	%cl, %esi
	movl	%eax, %edi
	movl	%r10d, %ecx
	shrl	%cl, %edi
	cmpl	%r14d, %edi
	jae	.LBB36_53
	.p2align	4, 0x90
.LBB36_52:                              # %for.body196
                                        #   Parent Loop BB36_27 Depth=1
                                        #     Parent Loop BB36_30 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	%edi, %ecx
	shlq	$4, %rcx
	movups	-64(%rbp), %xmm0
	movups	%xmm0, (%r9,%rcx)
	addl	%esi, %edi
	cmpl	%r14d, %edi
	jb	.LBB36_52
.LBB36_53:                              # %for.end201
                                        #   in Loop: Header=BB36_30 Depth=2
	leal	-1(%r12), %ecx
	movl	$1, %esi
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shll	%cl, %esi
	jmp	.LBB36_54
	.p2align	4, 0x90
.LBB36_55:                              # %for.inc207
                                        #   in Loop: Header=BB36_54 Depth=3
	shrl	%esi
.LBB36_54:                              # %for.cond204
                                        #   Parent Loop BB36_27 Depth=1
                                        #     Parent Loop BB36_30 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	%eax, %ecx
	xorl	%esi, %eax
	testl	%esi, %ecx
	jne	.LBB36_55
	jmp	.LBB36_56
	.p2align	4, 0x90
.LBB36_57:                              # %while.body219
                                        #   in Loop: Header=BB36_56 Depth=3
	subl	%r8d, %r10d
	decq	%r15
.LBB36_56:                              # %while.cond211
                                        #   Parent Loop BB36_27 Depth=1
                                        #     Parent Loop BB36_30 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	$1, %esi
	movl	%r10d, %ecx
	shll	%cl, %esi
	decl	%esi
	andl	%eax, %esi
	cmpl	-336(%rbp,%r15,4), %esi
	jne	.LBB36_57
	jmp	.LBB36_28
.LBB36_39:                              # %if.then120
	movl	$3, %r14d
	testl	%r15d, %r15d
	je	.LBB36_60
# BB#40:                                # %if.then122
	movq	-464(%rbp), %rdi
	callq	huft_free
.LBB36_60:                              # %return
	movl	%r14d, %eax
	addq	$1576, %rsp             # imm = 0x628
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
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
.Lcfi176:
	.cfi_def_cfa_offset 16
.Lcfi177:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi178:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi179:
	.cfi_offset %rbx, -24
	testq	%rdi, %rdi
	je	.LBB37_3
	.p2align	4, 0x90
.LBB37_2:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%rdi), %rbx
	addq	$-16, %rdi
	callq	free
	movq	%rbx, %rdi
	testq	%rdi, %rdi
	jne	.LBB37_2
.LBB37_3:                               # %while.end
	xorl	%eax, %eax
	addq	$8, %rsp
	popq	%rbx
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
.Lcfi180:
	.cfi_def_cfa_offset 16
.Lcfi181:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi182:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$56, %rsp
.Lcfi183:
	.cfi_offset %rbx, -56
.Lcfi184:
	.cfi_offset %r12, -48
.Lcfi185:
	.cfi_offset %r13, -40
.Lcfi186:
	.cfi_offset %r14, -32
.Lcfi187:
	.cfi_offset %r15, -24
	movl	%edx, %r15d
	movq	%rsi, -80(%rbp)         # 8-byte Spill
	movq	%rdi, -88(%rbp)         # 8-byte Spill
	movq	bb(%rip), %rbx
	movl	bk(%rip), %r14d
	movl	outcnt(%rip), %r13d
	movslq	%r15d, %rax
	movzwl	mask_bits(%rax,%rax), %eax
	movl	%eax, -68(%rbp)         # 4-byte Spill
	movl	%ecx, -64(%rbp)         # 4-byte Spill
	movslq	%ecx, %rax
	movzwl	mask_bits(%rax,%rax), %eax
	movl	%eax, -60(%rbp)         # 4-byte Spill
	cmpl	%r15d, %r14d
	jb	.LBB38_3
	jmp	.LBB38_7
.LBB38_22:                              # %if.then70
                                        #   in Loop: Header=BB38_7 Depth=1
	movb	8(%rax), %al
	movl	%r13d, %ecx
	incl	%r13d
	movb	%al, window(%rcx)
	cmpl	$32768, %r13d           # imm = 0x8000
	jne	.LBB38_2
# BB#23:                                # %if.then79
                                        #   in Loop: Header=BB38_7 Depth=1
	movl	%r13d, outcnt(%rip)
	callq	flush_window
	xorl	%r13d, %r13d
	cmpl	%r15d, %r14d
	jb	.LBB38_3
	jmp	.LBB38_7
	.p2align	4, 0x90
.LBB38_1:                               # %cond.end
	movzbl	%al, %eax
	movl	%r14d, %ecx
	shlq	%cl, %rax
	orq	%rax, %rbx
	addl	$8, %r14d
.LBB38_2:                               # %while.cond
	cmpl	%r15d, %r14d
	jae	.LBB38_7
.LBB38_3:                               # %while.body
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB38_5
# BB#4:                                 # %cond.true
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB38_1
	.p2align	4, 0x90
.LBB38_5:                               # %cond.false
	movl	%r13d, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	jmp	.LBB38_1
.LBB38_6:                               # %for.cond.loopexit
                                        #   in Loop: Header=BB38_7 Depth=1
	movl	-56(%rbp), %r15d        # 4-byte Reload
	movq	-48(%rbp), %rbx         # 8-byte Reload
	cmpl	%r15d, %r14d
	jb	.LBB38_3
.LBB38_7:                               # %while.end
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB38_8 Depth 2
                                        #       Child Loop BB38_11 Depth 3
                                        #     Child Loop BB38_19 Depth 2
                                        #     Child Loop BB38_26 Depth 2
                                        #     Child Loop BB38_30 Depth 2
                                        #       Child Loop BB38_33 Depth 3
                                        #     Child Loop BB38_39 Depth 2
                                        #     Child Loop BB38_43 Depth 2
                                        #       Child Loop BB38_46 Depth 3
	movl	%ebx, %eax
	andl	-68(%rbp), %eax         # 4-byte Folded Reload
	shlq	$4, %rax
	movq	-88(%rbp), %rcx         # 8-byte Reload
	leaq	(%rcx,%rax), %rdx
	movq	%rdx, -48(%rbp)         # 8-byte Spill
	movzbl	(%rcx,%rax), %r12d
	cmpl	$17, %r12d
	jb	.LBB38_15
	.p2align	4, 0x90
.LBB38_8:                               # %do.body
                                        #   Parent Loop BB38_7 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB38_11 Depth 3
	cmpl	$99, %r12d
	je	.LBB38_51
# BB#9:                                 # %if.end
                                        #   in Loop: Header=BB38_8 Depth=2
	movq	-48(%rbp), %rax         # 8-byte Reload
	movzbl	1(%rax), %ecx
	shrq	%cl, %rbx
	subl	%ecx, %r14d
	addl	$-16, %r12d
	cmpl	%r12d, %r14d
	jae	.LBB38_14
	.p2align	4, 0x90
.LBB38_11:                              # %while.body29
                                        #   Parent Loop BB38_7 Depth=1
                                        #     Parent Loop BB38_8 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB38_13
# BB#12:                                # %cond.true32
                                        #   in Loop: Header=BB38_11 Depth=3
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB38_10
	.p2align	4, 0x90
.LBB38_13:                              # %cond.false37
                                        #   in Loop: Header=BB38_11 Depth=3
	movl	%r13d, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB38_10:                              # %cond.end39
                                        #   in Loop: Header=BB38_11 Depth=3
	movzbl	%al, %eax
	movl	%r14d, %ecx
	shlq	%cl, %rax
	orq	%rax, %rbx
	addl	$8, %r14d
	cmpl	%r12d, %r14d
	jb	.LBB38_11
.LBB38_14:                              # %do.cond
                                        #   in Loop: Header=BB38_8 Depth=2
	movq	-48(%rbp), %rax         # 8-byte Reload
	movq	8(%rax), %rax
	movl	%r12d, %ecx
	movzwl	mask_bits(%rcx,%rcx), %ecx
	andl	%ebx, %ecx
	shlq	$4, %rcx
	leaq	(%rax,%rcx), %rdx
	movq	%rdx, -48(%rbp)         # 8-byte Spill
	movzbl	(%rax,%rcx), %r12d
	cmpl	$16, %r12d
	ja	.LBB38_8
.LBB38_15:                              # %if.end60
                                        #   in Loop: Header=BB38_7 Depth=1
	movq	-48(%rbp), %rax         # 8-byte Reload
	movzbl	1(%rax), %ecx
	shrq	%cl, %rbx
	subl	%ecx, %r14d
	cmpl	$16, %r12d
	je	.LBB38_22
# BB#16:                                # %if.end60
                                        #   in Loop: Header=BB38_7 Depth=1
	cmpl	$15, %r12d
	je	.LBB38_52
# BB#17:                                # %while.cond85.preheader
                                        #   in Loop: Header=BB38_7 Depth=1
	movl	%r15d, -56(%rbp)        # 4-byte Spill
	movl	%r14d, %r15d
	movq	-48(%rbp), %r14         # 8-byte Reload
	cmpl	%r12d, %r15d
	jae	.LBB38_24
	.p2align	4, 0x90
.LBB38_19:                              # %while.body88
                                        #   Parent Loop BB38_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB38_21
# BB#20:                                # %cond.true91
                                        #   in Loop: Header=BB38_19 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB38_18
	.p2align	4, 0x90
.LBB38_21:                              # %cond.false96
                                        #   in Loop: Header=BB38_19 Depth=2
	movl	%r13d, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB38_18:                              # %cond.end98
                                        #   in Loop: Header=BB38_19 Depth=2
	movzbl	%al, %eax
	movl	%r15d, %ecx
	shlq	%cl, %rax
	orq	%rax, %rbx
	addq	$8, %r15
	cmpl	%r12d, %r15d
	jb	.LBB38_19
.LBB38_24:                              # %while.end106
                                        #   in Loop: Header=BB38_7 Depth=1
	movzwl	8(%r14), %eax
	movzwl	mask_bits(%r12,%r12), %ecx
	andl	%ebx, %ecx
	addl	%eax, %ecx
	movl	%ecx, -52(%rbp)         # 4-byte Spill
	movl	%r12d, %ecx
	shrq	%cl, %rbx
	movq	%rbx, -48(%rbp)         # 8-byte Spill
	subl	%r12d, %r15d
	movl	-64(%rbp), %ebx         # 4-byte Reload
	cmpl	%ebx, %r15d
	jae	.LBB38_29
	.p2align	4, 0x90
.LBB38_26:                              # %while.body122
                                        #   Parent Loop BB38_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB38_28
# BB#27:                                # %cond.true125
                                        #   in Loop: Header=BB38_26 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB38_25
	.p2align	4, 0x90
.LBB38_28:                              # %cond.false130
                                        #   in Loop: Header=BB38_26 Depth=2
	movl	%r13d, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB38_25:                              # %cond.end132
                                        #   in Loop: Header=BB38_26 Depth=2
	movzbl	%al, %eax
	movl	%r15d, %ecx
	shlq	%cl, %rax
	orq	%rax, -48(%rbp)         # 8-byte Folded Spill
	addl	$8, %r15d
	cmpl	%ebx, %r15d
	jb	.LBB38_26
.LBB38_29:                              # %while.end140
                                        #   in Loop: Header=BB38_7 Depth=1
	movq	-48(%rbp), %rax         # 8-byte Reload
                                        # kill: %EAX<def> %EAX<kill> %RAX<kill> %RAX<def>
	andl	-60(%rbp), %eax         # 4-byte Folded Reload
	shlq	$4, %rax
	movq	-80(%rbp), %rcx         # 8-byte Reload
	leaq	(%rcx,%rax), %r12
	movzbl	(%rcx,%rax), %r14d
	cmpl	$17, %r14d
	jb	.LBB38_37
	.p2align	4, 0x90
.LBB38_30:                              # %do.body150
                                        #   Parent Loop BB38_7 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB38_33 Depth 3
	cmpl	$99, %r14d
	je	.LBB38_51
# BB#31:                                # %if.end154
                                        #   in Loop: Header=BB38_30 Depth=2
	movzbl	1(%r12), %ecx
	shrq	%cl, -48(%rbp)          # 8-byte Folded Spill
	subl	%ecx, %r15d
	addl	$-16, %r14d
	cmpl	%r14d, %r15d
	jae	.LBB38_36
	.p2align	4, 0x90
.LBB38_33:                              # %while.body166
                                        #   Parent Loop BB38_7 Depth=1
                                        #     Parent Loop BB38_30 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB38_35
# BB#34:                                # %cond.true169
                                        #   in Loop: Header=BB38_33 Depth=3
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB38_32
	.p2align	4, 0x90
.LBB38_35:                              # %cond.false174
                                        #   in Loop: Header=BB38_33 Depth=3
	movl	%r13d, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB38_32:                              # %cond.end176
                                        #   in Loop: Header=BB38_33 Depth=3
	movzbl	%al, %eax
	movl	%r15d, %ecx
	shlq	%cl, %rax
	orq	%rax, -48(%rbp)         # 8-byte Folded Spill
	addl	$8, %r15d
	cmpl	%r14d, %r15d
	jb	.LBB38_33
.LBB38_36:                              # %do.cond185
                                        #   in Loop: Header=BB38_30 Depth=2
	movq	8(%r12), %rax
	movl	%r14d, %ecx
	movzwl	mask_bits(%rcx,%rcx), %ecx
	andl	-48(%rbp), %ecx         # 4-byte Folded Reload
	shlq	$4, %rcx
	leaq	(%rax,%rcx), %r12
	movzbl	(%rax,%rcx), %r14d
	cmpl	$16, %r14d
	ja	.LBB38_30
.LBB38_37:                              # %if.end200
                                        #   in Loop: Header=BB38_7 Depth=1
	movzbl	1(%r12), %ecx
	shrq	%cl, -48(%rbp)          # 8-byte Folded Spill
	subl	%ecx, %r15d
	cmpl	%r14d, %r15d
	jae	.LBB38_42
	.p2align	4, 0x90
.LBB38_39:                              # %while.body211
                                        #   Parent Loop BB38_7 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB38_41
# BB#40:                                # %cond.true214
                                        #   in Loop: Header=BB38_39 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB38_38
	.p2align	4, 0x90
.LBB38_41:                              # %cond.false219
                                        #   in Loop: Header=BB38_39 Depth=2
	movl	%r13d, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB38_38:                              # %cond.end221
                                        #   in Loop: Header=BB38_39 Depth=2
	movzbl	%al, %eax
	movl	%r15d, %ecx
	shlq	%cl, %rax
	orq	%rax, -48(%rbp)         # 8-byte Folded Spill
	addq	$8, %r15
	cmpl	%r14d, %r15d
	jb	.LBB38_39
.LBB38_42:                              # %while.end229
                                        #   in Loop: Header=BB38_7 Depth=1
	movzwl	8(%r12), %eax
	movl	%r13d, %ebx
	subl	%eax, %ebx
	movzwl	mask_bits(%r14,%r14), %eax
	movq	-48(%rbp), %rdx         # 8-byte Reload
	andl	%edx, %eax
	subl	%eax, %ebx
	movl	%r14d, %ecx
	shrq	%cl, %rdx
	movq	%rdx, -48(%rbp)         # 8-byte Spill
	negl	%r14d
	addq	%r15, %r14
	movl	-52(%rbp), %r12d        # 4-byte Reload
	.p2align	4, 0x90
.LBB38_43:                              # %do.body243
                                        #   Parent Loop BB38_7 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB38_46 Depth 3
	andl	$32767, %ebx            # imm = 0x7FFF
	cmpl	%r13d, %ebx
	movl	%r13d, %eax
	cmoval	%ebx, %eax
	movl	$32768, %r15d           # imm = 0x8000
	subl	%eax, %r15d
	cmpl	%r12d, %r15d
	cmoval	%r12d, %r15d
	movl	%r12d, %edx
	movl	%r13d, %ecx
	subl	%ebx, %ecx
	cmpl	%r15d, %ecx
	jb	.LBB38_45
# BB#44:                                # %if.then262
                                        #   in Loop: Header=BB38_43 Depth=2
	movl	%edx, %r12d
	movl	%r13d, %eax
	leaq	window(%rax), %rdi
	movl	%ebx, %eax
	leaq	window(%rax), %rsi
	movl	%r15d, %edx
	callq	memcpy
	addl	%r15d, %r13d
	addl	%r15d, %ebx
	jmp	.LBB38_47
	.p2align	4, 0x90
.LBB38_45:                              # %do.body271.preheader
                                        #   in Loop: Header=BB38_43 Depth=2
	movl	%edx, %r12d
	movl	%edx, %ecx
	notl	%ecx
	addl	$-32769, %eax           # imm = 0xFFFF7FFF
	cmpl	%eax, %ecx
	cmoval	%ecx, %eax
	incl	%eax
	.p2align	4, 0x90
.LBB38_46:                              # %do.body271
                                        #   Parent Loop BB38_7 Depth=1
                                        #     Parent Loop BB38_43 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movl	%ebx, %ecx
	incl	%ebx
	movzbl	window(%rcx), %ecx
	movl	%r13d, %edx
	incl	%r13d
	movb	%cl, window(%rdx)
	incl	%eax
	jne	.LBB38_46
.LBB38_47:                              # %if.end280
                                        #   in Loop: Header=BB38_43 Depth=2
	subl	%r15d, %r12d
	cmpl	$32768, %r13d           # imm = 0x8000
	jne	.LBB38_49
# BB#48:                                # %if.then283
                                        #   in Loop: Header=BB38_43 Depth=2
	movl	%r13d, outcnt(%rip)
	callq	flush_window
	xorl	%r13d, %r13d
.LBB38_49:                              # %do.cond285
                                        #   in Loop: Header=BB38_43 Depth=2
	testl	%r12d, %r12d
	jne	.LBB38_43
	jmp	.LBB38_6
.LBB38_51:
	movl	$1, %eax
.LBB38_53:                              # %return
	addq	$56, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB38_52:                              # %for.end
	movl	%r13d, outcnt(%rip)
	movq	%rbx, bb(%rip)
	movl	%r14d, bk(%rip)
	xorl	%eax, %eax
	jmp	.LBB38_53
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
.Lcfi188:
	.cfi_def_cfa_offset 16
.Lcfi189:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi190:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi191:
	.cfi_offset %rbx, -24
	movl	%edi, %ebx
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
	testl	%eax, %eax
	je	.LBB39_5
# BB#2:                                 # %do.body
                                        #   in Loop: Header=BB39_1 Depth=1
	cmpl	$-1, %eax
	je	.LBB39_3
# BB#4:                                 # %if.end6
                                        #   in Loop: Header=BB39_1 Depth=1
	addl	insize(%rip), %eax
	movl	%eax, insize(%rip)
	cmpl	$32768, %eax            # imm = 0x8000
	jb	.LBB39_1
	jmp	.LBB39_5
.LBB39_3:                               # %if.then5
	callq	read_error
.LBB39_5:                               # %do.end
	cmpl	$0, insize(%rip)
	je	.LBB39_6
.LBB39_8:                               # %if.end15
	movl	insize(%rip), %eax
	addq	%rax, bytes_in(%rip)
	movl	$1, inptr(%rip)
	movzbl	inbuf(%rip), %eax
	jmp	.LBB39_9
.LBB39_6:                               # %if.then11
	movl	$-1, %eax
	testl	%ebx, %ebx
	je	.LBB39_7
.LBB39_9:                               # %return
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
.LBB39_7:                               # %if.end13
	callq	flush_window
	callq	__errno_location
	movl	$0, (%rax)
	callq	read_error
	jmp	.LBB39_8
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
.Lcfi192:
	.cfi_def_cfa_offset 16
.Lcfi193:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi194:
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
.Lcfi195:
	.cfi_def_cfa_offset 16
.Lcfi196:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi197:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
.Lcfi198:
	.cfi_offset %rbx, -56
.Lcfi199:
	.cfi_offset %r12, -48
.Lcfi200:
	.cfi_offset %r13, -40
.Lcfi201:
	.cfi_offset %r14, -32
.Lcfi202:
	.cfi_offset %r15, -24
	movq	bb(%rip), %r15
	movl	bk(%rip), %ebx
	movl	outcnt(%rip), %r12d
	movl	%ebx, %ecx
	andl	$7, %ecx
	shrq	%cl, %r15
	movl	%ebx, %r14d
	subl	%ecx, %r14d
	addl	$-16, %ebx
	subl	%ecx, %ebx
	cmpl	$15, %r14d
	jbe	.LBB41_2
	jmp	.LBB41_6
	.p2align	4, 0x90
.LBB41_5:                               # %cond.end
                                        #   in Loop: Header=BB41_2 Depth=1
	movzbl	%al, %eax
	movl	%r14d, %ecx
	shlq	%cl, %rax
	orq	%rax, %r15
	addl	$8, %ebx
	addq	$8, %r14
	cmpl	$15, %r14d
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
	jmp	.LBB41_5
	.p2align	4, 0x90
.LBB41_4:                               # %cond.false
                                        #   in Loop: Header=BB41_2 Depth=1
	movl	%r12d, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	jmp	.LBB41_5
.LBB41_6:                               # %while.end
	movzwl	%r15w, %r13d
	shrq	$16, %r15
	movl	%ebx, %r14d
	addl	$-16, %ebx
	cmpl	$15, %r14d
	jbe	.LBB41_8
	jmp	.LBB41_12
	.p2align	4, 0x90
.LBB41_11:                              # %cond.end22
                                        #   in Loop: Header=BB41_8 Depth=1
	movzbl	%al, %eax
	movl	%r14d, %ecx
	shlq	%cl, %rax
	orq	%rax, %r15
	addl	$8, %ebx
	addq	$8, %r14
	cmpl	$15, %r14d
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
	jmp	.LBB41_11
	.p2align	4, 0x90
.LBB41_10:                              # %cond.false20
                                        #   in Loop: Header=BB41_8 Depth=1
	movl	%r12d, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	jmp	.LBB41_11
.LBB41_12:                              # %while.end30
	movl	%r15d, %eax
	notl	%eax
	movzwl	%ax, %ecx
	movl	$1, %eax
	cmpl	%ecx, %r13d
	jne	.LBB41_25
# BB#13:                                # %if.end
	shrq	$16, %r15
	testl	%r13d, %r13d
	jne	.LBB41_15
	jmp	.LBB41_24
	.p2align	4, 0x90
.LBB41_23:                              # %if.end68
                                        #   in Loop: Header=BB41_15 Depth=1
	shrq	$8, %r15
	addl	$-8, %ebx
	testl	%r13d, %r13d
	je	.LBB41_24
.LBB41_15:                              # %while.cond39.preheader
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB41_17 Depth 2
	decl	%r13d
	movl	%ebx, %ebx
	cmpl	$7, %ebx
	jbe	.LBB41_17
	jmp	.LBB41_21
	.p2align	4, 0x90
.LBB41_20:                              # %cond.end52
                                        #   in Loop: Header=BB41_17 Depth=2
	movzbl	%al, %eax
	movl	%ebx, %ecx
	shlq	%cl, %rax
	orq	%rax, %r15
	addq	$8, %rbx
	cmpl	$7, %ebx
	ja	.LBB41_21
.LBB41_17:                              # %while.body42
                                        #   Parent Loop BB41_15 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB41_19
# BB#18:                                # %cond.true45
                                        #   in Loop: Header=BB41_17 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB41_20
	.p2align	4, 0x90
.LBB41_19:                              # %cond.false50
                                        #   in Loop: Header=BB41_17 Depth=2
	movl	%r12d, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	jmp	.LBB41_20
	.p2align	4, 0x90
.LBB41_21:                              # %while.end60
                                        #   in Loop: Header=BB41_15 Depth=1
	movl	%r12d, %eax
	incl	%r12d
	movb	%r15b, window(%rax)
	cmpl	$32768, %r12d           # imm = 0x8000
	jne	.LBB41_23
# BB#22:                                # %if.then67
                                        #   in Loop: Header=BB41_15 Depth=1
	movl	%r12d, outcnt(%rip)
	callq	flush_window
	xorl	%r12d, %r12d
	jmp	.LBB41_23
.LBB41_24:                              # %while.end71
	movl	%r12d, outcnt(%rip)
	movq	%r15, bb(%rip)
	movl	%ebx, bk(%rip)
	xorl	%eax, %eax
.LBB41_25:                              # %return
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
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
.Lcfi203:
	.cfi_def_cfa_offset 16
.Lcfi204:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi205:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$1192, %rsp             # imm = 0x4A8
.Lcfi206:
	.cfi_offset %rbx, -24
	xorl	%eax, %eax
	leaq	-1184(%rbp), %rcx
	cmpl	$144, %eax
	jge	.LBB42_3
	.p2align	4, 0x90
.LBB42_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	$8, (%rcx)
	incl	%eax
	addq	$4, %rcx
	cmpl	$144, %eax
	jl	.LBB42_2
	jmp	.LBB42_3
	.p2align	4, 0x90
.LBB42_4:                               # %for.body3
                                        #   in Loop: Header=BB42_3 Depth=1
	movl	$9, (%rcx)
	incl	%eax
	addq	$4, %rcx
.LBB42_3:                               # %for.cond1
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$256, %eax              # imm = 0x100
	jl	.LBB42_4
	jmp	.LBB42_5
	.p2align	4, 0x90
.LBB42_6:                               # %for.body11
                                        #   in Loop: Header=BB42_5 Depth=1
	movl	$7, (%rcx)
	incl	%eax
	addq	$4, %rcx
.LBB42_5:                               # %for.cond9
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$280, %eax              # imm = 0x118
	jl	.LBB42_6
	jmp	.LBB42_7
	.p2align	4, 0x90
.LBB42_8:                               # %for.body19
                                        #   in Loop: Header=BB42_7 Depth=1
	movl	$8, (%rcx)
	incl	%eax
	addq	$4, %rcx
.LBB42_7:                               # %for.cond17
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$287, %eax              # imm = 0x11F
	jle	.LBB42_8
# BB#9:                                 # %for.end24
	movl	$7, -16(%rbp)
	leaq	-16(%rbp), %rax
	movq	%rax, (%rsp)
	leaq	-1184(%rbp), %rdi
	leaq	-32(%rbp), %r9
	movl	$288, %esi              # imm = 0x120
	movl	$257, %edx              # imm = 0x101
	movl	$cplens, %ecx
	movl	$cplext, %r8d
	callq	huft_build
	movl	%eax, %ebx
	testl	%ebx, %ebx
	jne	.LBB42_17
# BB#10:                                # %for.cond26.preheader
	xorl	%eax, %eax
	cmpl	$29, %eax
	jg	.LBB42_13
	.p2align	4, 0x90
.LBB42_12:                              # %for.body28
                                        # =>This Inner Loop Header: Depth=1
	movl	$5, -1184(%rbp,%rax,4)
	incq	%rax
	cmpl	$29, %eax
	jle	.LBB42_12
.LBB42_13:                              # %for.end33
	movl	$5, -12(%rbp)
	leaq	-12(%rbp), %rax
	movq	%rax, (%rsp)
	leaq	-1184(%rbp), %rdi
	leaq	-24(%rbp), %r9
	movl	$30, %esi
	xorl	%edx, %edx
	movl	$cpdist, %ecx
	movl	$cpdext, %r8d
	callq	huft_build
	movl	%eax, %ebx
	movq	-32(%rbp), %rdi
	cmpl	$2, %ebx
	jl	.LBB42_15
# BB#14:                                # %if.then37
	callq	huft_free
	jmp	.LBB42_17
.LBB42_15:                              # %if.end39
	movq	-24(%rbp), %rsi
	movl	-16(%rbp), %edx
	movl	-12(%rbp), %ecx
	callq	inflate_codes
	movl	$1, %ebx
	testl	%eax, %eax
	jne	.LBB42_17
# BB#16:                                # %if.end42
	movq	-32(%rbp), %rdi
	callq	huft_free
	movq	-24(%rbp), %rdi
	callq	huft_free
	xorl	%ebx, %ebx
.LBB42_17:                              # %return
	movl	%ebx, %eax
	addq	$1192, %rsp             # imm = 0x4A8
	popq	%rbx
	popq	%rbp
	retq
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
.Lcfi207:
	.cfi_def_cfa_offset 16
.Lcfi208:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi209:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$1352, %rsp             # imm = 0x548
.Lcfi210:
	.cfi_offset %rbx, -56
.Lcfi211:
	.cfi_offset %r12, -48
.Lcfi212:
	.cfi_offset %r13, -40
.Lcfi213:
	.cfi_offset %r14, -32
.Lcfi214:
	.cfi_offset %r15, -24
	movq	bb(%rip), %r14
	movl	bk(%rip), %r12d
	movl	outcnt(%rip), %r13d
	cmpl	$4, %r12d
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
	jmp	.LBB43_1
	.p2align	4, 0x90
.LBB43_4:                               # %cond.false
                                        #   in Loop: Header=BB43_2 Depth=1
	movl	%r13d, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB43_1:                               # %cond.end
                                        #   in Loop: Header=BB43_2 Depth=1
	movzbl	%al, %eax
	movl	%r12d, %ecx
	shlq	%cl, %rax
	orq	%rax, %r14
	addl	$8, %r12d
	cmpl	$4, %r12d
	jbe	.LBB43_2
.LBB43_5:                               # %while.end
	movl	%r14d, %ebx
	andl	$31, %ebx
	addl	$257, %ebx              # imm = 0x101
	shrq	$5, %r14
	addl	$-14, %r12d
	jmp	.LBB43_7
	.p2align	4, 0x90
.LBB43_6:                               # %cond.end19
                                        #   in Loop: Header=BB43_7 Depth=1
	movzbl	%al, %eax
	movl	%r15d, %ecx
	shlq	%cl, %rax
	orq	%rax, %r14
	addl	$8, %r12d
.LBB43_7:                               # %while.cond6
                                        # =>This Inner Loop Header: Depth=1
	leal	9(%r12), %r15d
	cmpl	$4, %r15d
	ja	.LBB43_11
# BB#8:                                 # %while.body9
                                        #   in Loop: Header=BB43_7 Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB43_10
# BB#9:                                 # %cond.true12
                                        #   in Loop: Header=BB43_7 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB43_6
	.p2align	4, 0x90
.LBB43_10:                              # %cond.false17
                                        #   in Loop: Header=BB43_7 Depth=1
	movl	%r13d, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	jmp	.LBB43_6
.LBB43_11:                              # %while.end27
	movq	%rbx, -96(%rbp)         # 8-byte Spill
	movl	%r14d, %eax
	andl	$31, %eax
	incl	%eax
	movq	%rax, -88(%rbp)         # 8-byte Spill
	shrq	$5, %r14
	jmp	.LBB43_13
	.p2align	4, 0x90
.LBB43_12:                              # %cond.end46
                                        #   in Loop: Header=BB43_13 Depth=1
	movzbl	%al, %eax
	movl	%ebx, %ecx
	shlq	%cl, %rax
	orq	%rax, %r14
	addl	$8, %r12d
.LBB43_13:                              # %while.cond33
                                        # =>This Inner Loop Header: Depth=1
	movl	%r12d, %ebx
	addl	$4, %ebx
	jae	.LBB43_17
# BB#14:                                # %while.body36
                                        #   in Loop: Header=BB43_13 Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB43_16
# BB#15:                                # %cond.true39
                                        #   in Loop: Header=BB43_13 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB43_12
	.p2align	4, 0x90
.LBB43_16:                              # %cond.false44
                                        #   in Loop: Header=BB43_13 Depth=1
	movl	%r13d, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	jmp	.LBB43_12
.LBB43_17:                              # %while.end54
	cmpl	$286, -96(%rbp)         # 4-byte Folded Reload
                                        # imm = 0x11E
	movl	$1, %eax
	ja	.LBB43_79
# BB#18:                                # %while.end54
	cmpl	$30, -88(%rbp)          # 4-byte Folded Reload
	ja	.LBB43_79
# BB#19:                                # %for.cond.preheader
	movl	%r14d, %r15d
	andl	$15, %r15d
	addl	$4, %r15d
	shrq	$4, %r14
	xorl	%ebx, %ebx
	cmpl	%r15d, %ebx
	jae	.LBB43_27
	.p2align	4, 0x90
.LBB43_21:                              # %while.cond66.preheader
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB43_23 Depth 2
	movl	%r12d, %r12d
	cmpl	$2, %r12d
	ja	.LBB43_20
	.p2align	4, 0x90
.LBB43_23:                              # %while.body69
                                        #   Parent Loop BB43_21 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB43_25
# BB#24:                                # %cond.true72
                                        #   in Loop: Header=BB43_23 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB43_22
	.p2align	4, 0x90
.LBB43_25:                              # %cond.false77
                                        #   in Loop: Header=BB43_23 Depth=2
	movl	%r13d, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB43_22:                              # %cond.end79
                                        #   in Loop: Header=BB43_23 Depth=2
	movzbl	%al, %eax
	movl	%r12d, %ecx
	shlq	%cl, %rax
	orq	%rax, %r14
	addq	$8, %r12
	cmpl	$2, %r12d
	jbe	.LBB43_23
.LBB43_20:                              # %while.end87
                                        #   in Loop: Header=BB43_21 Depth=1
	movl	%r14d, %eax
	andl	$7, %eax
	movl	%ebx, %ecx
	movl	border(,%rcx,4), %ecx
	movl	%eax, -1376(%rbp,%rcx,4)
	shrq	$3, %r14
	addl	$-3, %r12d
	incq	%rbx
	cmpl	%r15d, %ebx
	jb	.LBB43_21
	jmp	.LBB43_27
	.p2align	4, 0x90
.LBB43_26:                              # %for.body100
                                        #   in Loop: Header=BB43_27 Depth=1
	movl	border(,%rbx,4), %eax
	movl	$0, -1376(%rbp,%rax,4)
	incq	%rbx
.LBB43_27:                              # %for.cond97
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$18, %ebx
	jbe	.LBB43_26
# BB#28:                                # %for.end107
	movl	$7, -44(%rbp)
	leaq	-44(%rbp), %r15
	movq	%r15, (%rsp)
	leaq	-1376(%rbp), %rdi
	leaq	-56(%rbp), %r9
	movl	$19, %esi
	movl	$19, %edx
	xorl	%ecx, %ecx
	xorl	%r8d, %r8d
	callq	huft_build
	movl	%eax, %ebx
	testl	%ebx, %ebx
	je	.LBB43_31
# BB#29:                                # %for.end107
	cmpl	$1, %ebx
	jne	.LBB43_33
# BB#30:                                # %if.then114
	movq	-56(%rbp), %rdi
	callq	huft_free
	movl	%ebx, %eax
	jmp	.LBB43_79
.LBB43_31:                              # %if.end117
	cmpq	$0, -56(%rbp)
	je	.LBB43_34
# BB#32:                                # %if.end121
	movq	-96(%rbp), %rax         # 8-byte Reload
	movq	-88(%rbp), %rcx         # 8-byte Reload
	leal	(%rax,%rcx), %eax
	movl	%eax, -60(%rbp)         # 4-byte Spill
	movslq	-44(%rbp), %rax
	movzwl	mask_bits(%rax,%rax), %eax
	movl	%eax, -100(%rbp)        # 4-byte Spill
	movl	$0, -68(%rbp)           # 4-byte Folded Spill
	xorl	%ebx, %ebx
	movl	%r13d, -64(%rbp)        # 4-byte Spill
	cmpl	-60(%rbp), %ebx         # 4-byte Folded Reload
	jb	.LBB43_38
	jmp	.LBB43_70
.LBB43_33:
	movl	%ebx, %eax
	jmp	.LBB43_79
.LBB43_34:
	movl	$2, %eax
	jmp	.LBB43_79
.LBB43_36:                              # %while.cond126.loopexit2
                                        #   in Loop: Header=BB43_38 Depth=1
	movl	$0, -68(%rbp)           # 4-byte Folded Spill
	.p2align	4, 0x90
.LBB43_37:                              # %while.cond126
                                        #   in Loop: Header=BB43_38 Depth=1
	cmpl	-60(%rbp), %ebx         # 4-byte Folded Reload
	jae	.LBB43_70
.LBB43_38:                              # %while.cond130.preheader
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB43_40 Depth 2
                                        #     Child Loop BB43_61 Depth 2
                                        #     Child Loop BB43_69 Depth 2
                                        #     Child Loop BB43_56 Depth 2
                                        #     Child Loop BB43_66 Depth 2
                                        #     Child Loop BB43_47 Depth 2
                                        #     Child Loop BB43_52 Depth 2
	xorl	%r15d, %r15d
	movl	%r12d, %r13d
	cmpl	-44(%rbp), %r13d
	jae	.LBB43_43
	.p2align	4, 0x90
.LBB43_40:                              # %while.body133
                                        #   Parent Loop BB43_38 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB43_42
# BB#41:                                # %cond.true136
                                        #   in Loop: Header=BB43_40 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB43_39
	.p2align	4, 0x90
.LBB43_42:                              # %cond.false141
                                        #   in Loop: Header=BB43_40 Depth=2
	movl	-64(%rbp), %eax         # 4-byte Reload
	movl	%eax, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB43_39:                              # %cond.end143
                                        #   in Loop: Header=BB43_40 Depth=2
	movzbl	%al, %eax
	movl	%r13d, %ecx
	shlq	%cl, %rax
	orq	%rax, %r14
	addl	$8, %r13d
	addl	$8, %r15d
	cmpl	-44(%rbp), %r13d
	jb	.LBB43_40
.LBB43_43:                              # %while.end151
                                        #   in Loop: Header=BB43_38 Depth=1
	movq	-56(%rbp), %rax
	movl	%r14d, %edx
	andl	-100(%rbp), %edx        # 4-byte Folded Reload
	shlq	$4, %rdx
	leaq	(%rax,%rdx), %rcx
	movq	%rcx, -80(%rbp)
	movzbl	1(%rax,%rdx), %ecx
	shrq	%cl, %r14
	movzwl	8(%rax,%rdx), %eax
	cmpl	$15, %eax
	jbe	.LBB43_35
# BB#44:                                # %if.else
                                        #   in Loop: Header=BB43_38 Depth=1
	subl	%ecx, %r12d
	addl	%r15d, %r12d
	cmpl	$16, %eax
	jne	.LBB43_53
# BB#45:                                # %while.cond170.preheader
                                        #   in Loop: Header=BB43_38 Depth=1
	movl	-64(%rbp), %r13d        # 4-byte Reload
	leaq	-44(%rbp), %r15
	cmpl	$1, %r12d
	ja	.LBB43_50
	.p2align	4, 0x90
.LBB43_47:                              # %while.body173
                                        #   Parent Loop BB43_38 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB43_49
# BB#48:                                # %cond.true176
                                        #   in Loop: Header=BB43_47 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB43_46
	.p2align	4, 0x90
.LBB43_49:                              # %cond.false181
                                        #   in Loop: Header=BB43_47 Depth=2
	movl	%r13d, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB43_46:                              # %cond.end183
                                        #   in Loop: Header=BB43_47 Depth=2
	movzbl	%al, %eax
	movl	%r12d, %ecx
	shlq	%cl, %rax
	orq	%rax, %r14
	addq	$8, %r12
	cmpl	$1, %r12d
	jbe	.LBB43_47
.LBB43_50:                              # %while.end191
                                        #   in Loop: Header=BB43_38 Depth=1
	movl	%r14d, %ecx
	andl	$3, %ecx
	leal	3(%rbx,%rcx), %eax
	cmpl	-60(%rbp), %eax         # 4-byte Folded Reload
	ja	.LBB43_73
# BB#51:                                # %while.cond202.preheader
                                        #   in Loop: Header=BB43_38 Depth=1
	shrq	$2, %r14
	addq	$-2, %r12
	movl	$-3, %eax
	subl	%ecx, %eax
	movslq	%ebx, %rbx
	testl	%eax, %eax
	je	.LBB43_37
	.p2align	4, 0x90
.LBB43_52:                              # %while.body203
                                        #   Parent Loop BB43_38 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	-68(%rbp), %ecx         # 4-byte Reload
	movl	%ecx, -1376(%rbp,%rbx,4)
	incl	%eax
	incq	%rbx
	testl	%eax, %eax
	jne	.LBB43_52
	jmp	.LBB43_37
.LBB43_35:                              # %if.then163
                                        #   in Loop: Header=BB43_38 Depth=1
	movslq	%ebx, %rdx
	incl	%ebx
	movl	%eax, -1376(%rbp,%rdx,4)
	subl	%ecx, %r13d
	movl	%r13d, %r12d
	movl	%eax, -68(%rbp)         # 4-byte Spill
	leaq	-44(%rbp), %r15
	cmpl	-60(%rbp), %ebx         # 4-byte Folded Reload
	jb	.LBB43_38
	jmp	.LBB43_70
.LBB43_53:                              # %if.else
                                        #   in Loop: Header=BB43_38 Depth=1
	cmpl	$17, %eax
	jne	.LBB43_59
# BB#54:                                # %while.cond212.preheader
                                        #   in Loop: Header=BB43_38 Depth=1
	movl	-64(%rbp), %r13d        # 4-byte Reload
	leaq	-44(%rbp), %r15
	cmpl	$2, %r12d
	ja	.LBB43_64
	.p2align	4, 0x90
.LBB43_56:                              # %while.body215
                                        #   Parent Loop BB43_38 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB43_58
# BB#57:                                # %cond.true218
                                        #   in Loop: Header=BB43_56 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB43_55
	.p2align	4, 0x90
.LBB43_58:                              # %cond.false223
                                        #   in Loop: Header=BB43_56 Depth=2
	movl	%r13d, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB43_55:                              # %cond.end225
                                        #   in Loop: Header=BB43_56 Depth=2
	movzbl	%al, %eax
	movl	%r12d, %ecx
	shlq	%cl, %rax
	orq	%rax, %r14
	addq	$8, %r12
	cmpl	$2, %r12d
	jbe	.LBB43_56
.LBB43_64:                              # %while.end233
                                        #   in Loop: Header=BB43_38 Depth=1
	movl	%r14d, %ecx
	andl	$7, %ecx
	leal	3(%rbx,%rcx), %eax
	cmpl	-60(%rbp), %eax         # 4-byte Folded Reload
	ja	.LBB43_83
# BB#65:                                # %while.cond244.preheader
                                        #   in Loop: Header=BB43_38 Depth=1
	shrq	$3, %r14
	addq	$-3, %r12
	movl	$-3, %eax
	subl	%ecx, %eax
	movslq	%ebx, %rbx
	testl	%eax, %eax
	je	.LBB43_36
	.p2align	4, 0x90
.LBB43_66:                              # %while.body247
                                        #   Parent Loop BB43_38 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$0, -1376(%rbp,%rbx,4)
	incl	%eax
	incq	%rbx
	testl	%eax, %eax
	jne	.LBB43_66
	jmp	.LBB43_36
.LBB43_59:                              # %while.cond253.preheader
                                        #   in Loop: Header=BB43_38 Depth=1
	movl	-64(%rbp), %r13d        # 4-byte Reload
	leaq	-44(%rbp), %r15
	cmpl	$6, %r12d
	ja	.LBB43_67
	.p2align	4, 0x90
.LBB43_61:                              # %while.body256
                                        #   Parent Loop BB43_38 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB43_63
# BB#62:                                # %cond.true259
                                        #   in Loop: Header=BB43_61 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB43_60
	.p2align	4, 0x90
.LBB43_63:                              # %cond.false264
                                        #   in Loop: Header=BB43_61 Depth=2
	movl	%r13d, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB43_60:                              # %cond.end266
                                        #   in Loop: Header=BB43_61 Depth=2
	movzbl	%al, %eax
	movl	%r12d, %ecx
	shlq	%cl, %rax
	orq	%rax, %r14
	addq	$8, %r12
	cmpl	$6, %r12d
	jbe	.LBB43_61
.LBB43_67:                              # %while.end274
                                        #   in Loop: Header=BB43_38 Depth=1
	movl	%r14d, %ecx
	andl	$127, %ecx
	leal	11(%rbx,%rcx), %eax
	cmpl	-60(%rbp), %eax         # 4-byte Folded Reload
	ja	.LBB43_83
# BB#68:                                # %while.cond285.preheader
                                        #   in Loop: Header=BB43_38 Depth=1
	shrq	$7, %r14
	addq	$-7, %r12
	movl	$-11, %eax
	subl	%ecx, %eax
	movslq	%ebx, %rbx
	testl	%eax, %eax
	je	.LBB43_36
	.p2align	4, 0x90
.LBB43_69:                              # %while.body288
                                        #   Parent Loop BB43_38 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$0, -1376(%rbp,%rbx,4)
	incl	%eax
	incq	%rbx
	testl	%eax, %eax
	jne	.LBB43_69
	jmp	.LBB43_36
.LBB43_70:                              # %while.end296
	movq	-56(%rbp), %rdi
	callq	huft_free
	movq	%r14, bb(%rip)
	movl	%r12d, bk(%rip)
	movl	lbits(%rip), %eax
	movl	%eax, -44(%rbp)
	movq	%r15, (%rsp)
	leaq	-1376(%rbp), %rdi
	leaq	-56(%rbp), %r9
	movl	$257, %edx              # imm = 0x101
	movl	$cplens, %ecx
	movl	$cplext, %r8d
	movq	-96(%rbp), %rbx         # 8-byte Reload
	movl	%ebx, %esi
	callq	huft_build
	movl	%eax, %r12d
	testl	%r12d, %r12d
	je	.LBB43_74
# BB#71:                                # %while.end296
	cmpl	$1, %r12d
	jne	.LBB43_78
# BB#72:                                # %if.then305
	movq	stderr(%rip), %rdi
	movl	$.L.str.50, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	-56(%rbp), %rdi
	callq	huft_free
.LBB43_78:
	movl	%r12d, %eax
	jmp	.LBB43_79
.LBB43_73:
	movl	$1, %eax
.LBB43_79:                              # %return
	addq	$1352, %rsp             # imm = 0x548
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB43_74:                              # %if.end309
	movl	dbits(%rip), %eax
	movl	%eax, -72(%rbp)
	movl	%ebx, %eax
	leaq	-1376(%rbp,%rax,4), %rdi
	leaq	-72(%rbp), %rax
	movq	%rax, (%rsp)
	leaq	-80(%rbp), %r9
	xorl	%edx, %edx
	movl	$cpdist, %ecx
	movl	$cpdext, %r8d
	movq	-88(%rbp), %rsi         # 8-byte Reload
                                        # kill: %ESI<def> %ESI<kill> %RSI<kill>
	callq	huft_build
	movl	%eax, %r14d
	testl	%r14d, %r14d
	je	.LBB43_80
# BB#75:                                # %if.end309
	cmpl	$1, %r14d
	jne	.LBB43_77
# BB#76:                                # %if.then319
	movq	stderr(%rip), %rdi
	movl	$.L.str.51, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	-80(%rbp), %rdi
	callq	huft_free
.LBB43_77:                              # %if.end322
	movq	-56(%rbp), %rdi
	callq	huft_free
	movl	%r14d, %eax
	jmp	.LBB43_79
.LBB43_80:                              # %if.end324
	movq	-56(%rbp), %rdi
	movq	-80(%rbp), %rsi
	movl	-44(%rbp), %edx
	movl	-72(%rbp), %ecx
	callq	inflate_codes
	testl	%eax, %eax
	movl	$1, %eax
	jne	.LBB43_79
# BB#81:                                # %if.end328
	movq	-56(%rbp), %rdi
	callq	huft_free
	movq	-80(%rbp), %rdi
	callq	huft_free
	xorl	%eax, %eax
	jmp	.LBB43_79
.LBB43_83:
	movl	$1, %eax
	jmp	.LBB43_79
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
.Lcfi215:
	.cfi_def_cfa_offset 16
.Lcfi216:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi217:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
.Lcfi218:
	.cfi_offset %rbx, -48
.Lcfi219:
	.cfi_offset %r12, -40
.Lcfi220:
	.cfi_offset %r14, -32
.Lcfi221:
	.cfi_offset %r15, -24
	movq	%rdi, %rbx
	movq	bb(%rip), %r15
	movl	bk(%rip), %r14d
	movl	outcnt(%rip), %r12d
	testl	%r14d, %r14d
	je	.LBB44_2
	jmp	.LBB44_6
	.p2align	4, 0x90
.LBB44_5:                               # %cond.end
                                        #   in Loop: Header=BB44_2 Depth=1
	movzbl	%al, %eax
	movl	%r14d, %ecx
	shlq	%cl, %rax
	orq	%rax, %r15
	addl	$8, %r14d
	testl	%r14d, %r14d
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
	jmp	.LBB44_5
	.p2align	4, 0x90
.LBB44_4:                               # %cond.false
                                        #   in Loop: Header=BB44_2 Depth=1
	movl	%r12d, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	jmp	.LBB44_5
.LBB44_6:                               # %while.end
	movl	%r15d, %eax
	andl	$1, %eax
	movl	%eax, (%rbx)
	shrq	%r15
	leal	-1(%r14), %ebx
	addl	$-3, %r14d
	cmpl	$1, %ebx
	jbe	.LBB44_8
	jmp	.LBB44_12
	.p2align	4, 0x90
.LBB44_11:                              # %cond.end18
                                        #   in Loop: Header=BB44_8 Depth=1
	movzbl	%al, %eax
	movl	%ebx, %ecx
	shlq	%cl, %rax
	orq	%rax, %r15
	addl	$8, %r14d
	addq	$8, %rbx
	cmpl	$1, %ebx
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
	jmp	.LBB44_11
	.p2align	4, 0x90
.LBB44_10:                              # %cond.false16
                                        #   in Loop: Header=BB44_8 Depth=1
	movl	%r12d, outcnt(%rip)
	xorl	%edi, %edi
	callq	fill_inbuf
	jmp	.LBB44_11
.LBB44_12:                              # %while.end26
	movq	%r15, %rax
	shrq	$2, %rax
	movq	%rax, bb(%rip)
	movl	%r14d, bk(%rip)
	andl	$3, %r15d
	je	.LBB44_16
# BB#13:                                # %while.end26
	cmpl	$1, %r15d
	je	.LBB44_17
# BB#14:                                # %while.end26
	movl	$2, %eax
	cmpl	$2, %r15d
	jne	.LBB44_18
# BB#15:                                # %if.then
	callq	inflate_dynamic
	jmp	.LBB44_18
.LBB44_16:                              # %if.then36
	callq	inflate_stored
	jmp	.LBB44_18
.LBB44_17:                              # %if.then41
	callq	inflate_fixed
.LBB44_18:                              # %return
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
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
.Lcfi222:
	.cfi_def_cfa_offset 16
.Lcfi223:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi224:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$16, %rsp
.Lcfi225:
	.cfi_offset %rbx, -32
.Lcfi226:
	.cfi_offset %r14, -24
	movl	$0, outcnt(%rip)
	movl	$0, bk(%rip)
	movq	$0, bb(%rip)
	xorl	%ebx, %ebx
	leaq	-20(%rbp), %r14
	.p2align	4, 0x90
.LBB45_1:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movl	$0, hufts(%rip)
	movq	%r14, %rdi
	callq	inflate_block
	testl	%eax, %eax
	jne	.LBB45_6
# BB#2:                                 # %if.end
                                        #   in Loop: Header=BB45_1 Depth=1
	movl	hufts(%rip), %eax
	cmpl	%ebx, %eax
	cmoval	%eax, %ebx
	cmpl	$0, -20(%rbp)
	je	.LBB45_1
	jmp	.LBB45_3
	.p2align	4, 0x90
.LBB45_4:                               # %while.body
                                        #   in Loop: Header=BB45_3 Depth=1
	addl	$-8, bk(%rip)
	decl	inptr(%rip)
.LBB45_3:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$8, bk(%rip)
	jae	.LBB45_4
# BB#5:                                 # %while.end
	callq	flush_window
	xorl	%eax, %eax
.LBB45_6:                               # %return
	addq	$16, %rsp
	popq	%rbx
	popq	%r14
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
	movq	%rdi, file_type(%rip)
	movq	%rsi, file_method(%rip)
	movq	$0, input_len(%rip)
	movq	$0, compressed_len(%rip)
	cmpw	$0, static_dtree+2(%rip)
	jne	.LBB46_35
# BB#1:                                 # %for.cond.preheader
	pushq	%rbp
.Lcfi227:
	.cfi_def_cfa_offset 16
.Lcfi228:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi229:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi230:
	.cfi_offset %rbx, -24
	xorl	%eax, %eax
	xorl	%edx, %edx
	cmpl	$27, %edx
	jle	.LBB46_3
	jmp	.LBB46_7
	.p2align	4, 0x90
.LBB46_6:                               # %for.inc14
                                        #   in Loop: Header=BB46_3 Depth=1
	incl	%edx
	cmpl	$27, %edx
	jg	.LBB46_7
.LBB46_3:                               # %for.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB46_4 Depth 2
	movslq	%edx, %rsi
	movl	%eax, base_length(,%rsi,4)
	cltq
	xorl	%edi, %edi
	jmp	.LBB46_4
	.p2align	4, 0x90
.LBB46_5:                               # %for.body9
                                        #   in Loop: Header=BB46_4 Depth=2
	movb	%dl, length_code(%rax)
	incl	%edi
	incq	%rax
.LBB46_4:                               # %for.cond4
                                        #   Parent Loop BB46_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	extra_lbits(,%rsi,4), %ecx
	movl	$1, %ebx
	shll	%cl, %ebx
	cmpl	%ebx, %edi
	jl	.LBB46_5
	jmp	.LBB46_6
.LBB46_7:                               # %for.end16
	cltq
	movb	%dl, length_code-1(%rax)
	xorl	%eax, %eax
	xorl	%r8d, %r8d
	cmpl	$15, %eax
	jle	.LBB46_9
	jmp	.LBB46_13
	.p2align	4, 0x90
.LBB46_12:                              # %for.inc40
                                        #   in Loop: Header=BB46_9 Depth=1
	incl	%eax
	addl	%esi, %r8d
	cmpl	$15, %eax
	jg	.LBB46_13
.LBB46_9:                               # %for.body23
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB46_10 Depth 2
	movslq	%eax, %rdi
	movl	%r8d, base_dist(,%rdi,4)
	movslq	%r8d, %rbx
	xorl	%esi, %esi
	jmp	.LBB46_10
	.p2align	4, 0x90
.LBB46_11:                              # %for.body32
                                        #   in Loop: Header=BB46_10 Depth=2
	movb	%al, dist_code(%rbx,%rsi)
	incq	%rsi
.LBB46_10:                              # %for.cond26
                                        #   Parent Loop BB46_9 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzbl	extra_dbits(,%rdi,4), %ecx
	movl	$1, %edx
	shll	%cl, %edx
	cmpl	%edx, %esi
	jl	.LBB46_11
	jmp	.LBB46_12
.LBB46_13:                              # %for.end42
	sarl	$7, %r8d
	cmpl	$30, %eax
	jl	.LBB46_20
	jmp	.LBB46_15
	.p2align	4, 0x90
.LBB46_23:                              # %for.inc65
                                        #   in Loop: Header=BB46_20 Depth=1
	incl	%eax
	addl	%esi, %r8d
	cmpl	$30, %eax
	jge	.LBB46_15
.LBB46_20:                              # %for.body46
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB46_21 Depth 2
	movl	%r8d, %ecx
	shll	$7, %ecx
	movslq	%eax, %rdi
	movl	%ecx, base_dist(,%rdi,4)
	xorl	%esi, %esi
	jmp	.LBB46_21
	.p2align	4, 0x90
.LBB46_22:                              # %for.body57
                                        #   in Loop: Header=BB46_21 Depth=2
	leal	256(%r8,%rsi), %ecx
	movslq	%ecx, %rcx
	movb	%al, dist_code(%rcx)
	incl	%esi
.LBB46_21:                              # %for.cond50
                                        #   Parent Loop BB46_20 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	extra_dbits(,%rdi,4), %ecx
	addl	$-7, %ecx
	movl	$1, %edx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shll	%cl, %edx
	cmpl	%edx, %esi
	jl	.LBB46_22
	jmp	.LBB46_23
.LBB46_15:                              # %for.cond68.preheader
	xorl	%eax, %eax
	cmpl	$16, %eax
	jge	.LBB46_17
	.p2align	4, 0x90
.LBB46_24:                              # %for.body71
                                        # =>This Inner Loop Header: Depth=1
	movw	$0, bl_count(%rax,%rax)
	incq	%rax
	cmpl	$16, %eax
	jl	.LBB46_24
.LBB46_17:                              # %while.cond.preheader
	xorl	%eax, %eax
	cmpl	$144, %eax
	jge	.LBB46_25
	.p2align	4, 0x90
.LBB46_19:                              # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movw	$8, static_ltree+2(,%rax,4)
	incw	bl_count+16(%rip)
	incq	%rax
	cmpl	$144, %eax
	jl	.LBB46_19
	jmp	.LBB46_25
	.p2align	4, 0x90
.LBB46_26:                              # %while.body86
                                        #   in Loop: Header=BB46_25 Depth=1
	movw	$9, static_ltree+2(,%rax,4)
	incw	bl_count+18(%rip)
	incq	%rax
.LBB46_25:                              # %while.cond83
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$256, %eax              # imm = 0x100
	jl	.LBB46_26
	jmp	.LBB46_27
	.p2align	4, 0x90
.LBB46_28:                              # %while.body97
                                        #   in Loop: Header=BB46_27 Depth=1
	movw	$7, static_ltree+2(,%rax,4)
	incw	bl_count+14(%rip)
	incq	%rax
.LBB46_27:                              # %while.cond94
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$280, %eax              # imm = 0x118
	jl	.LBB46_28
	jmp	.LBB46_29
	.p2align	4, 0x90
.LBB46_30:                              # %while.body108
                                        #   in Loop: Header=BB46_29 Depth=1
	movw	$8, static_ltree+2(,%rax,4)
	incw	bl_count+16(%rip)
	incq	%rax
.LBB46_29:                              # %while.cond105
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$287, %eax              # imm = 0x11F
	jle	.LBB46_30
# BB#31:                                # %while.end115
	movl	$static_ltree, %edi
	movl	$287, %esi              # imm = 0x11F
	callq	gen_codes
	xorl	%ebx, %ebx
	cmpl	$29, %ebx
	jg	.LBB46_34
	.p2align	4, 0x90
.LBB46_33:                              # %for.body119
                                        # =>This Inner Loop Header: Depth=1
	movw	$5, static_dtree+2(,%rbx,4)
	movl	$5, %esi
	movl	%ebx, %edi
	callq	bi_reverse
	movw	%ax, static_dtree(,%rbx,4)
	incq	%rbx
	cmpl	$29, %ebx
	jle	.LBB46_33
.LBB46_34:                              # %for.end130
	callq	init_block
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
.LBB46_35:                              # %return
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
.Lcfi231:
	.cfi_def_cfa_offset 16
.Lcfi232:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi233:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$40, %rsp
.Lcfi234:
	.cfi_offset %rbx, -40
.Lcfi235:
	.cfi_offset %r14, -32
.Lcfi236:
	.cfi_offset %r15, -24
	movl	%esi, %r14d
	movq	%rdi, %r15
	xorl	%ecx, %ecx
	movl	$1, %eax
	cmpl	$16, %eax
	jge	.LBB47_2
	.p2align	4, 0x90
.LBB47_8:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movzwl	bl_count-2(%rax,%rax), %edx
	addl	%ecx, %edx
	addl	%edx, %edx
	movw	%dx, -64(%rbp,%rax,2)
	incq	%rax
	movw	%dx, %cx
	cmpl	$16, %eax
	jl	.LBB47_8
.LBB47_2:                               # %for.cond5.preheader
	xorl	%ebx, %ebx
	cmpl	%r14d, %ebx
	jle	.LBB47_4
	jmp	.LBB47_7
	.p2align	4, 0x90
.LBB47_6:                               # %for.inc23
                                        #   in Loop: Header=BB47_4 Depth=1
	incq	%rbx
	cmpl	%r14d, %ebx
	jg	.LBB47_7
.LBB47_4:                               # %for.body8
                                        # =>This Inner Loop Header: Depth=1
	movzwl	2(%r15,%rbx,4), %esi
	testl	%esi, %esi
	je	.LBB47_6
# BB#5:                                 # %if.end
                                        #   in Loop: Header=BB47_4 Depth=1
	movzwl	-64(%rbp,%rsi,2), %edi
	leal	1(%rdi), %eax
	movw	%ax, -64(%rbp,%rsi,2)
                                        # kill: %EDI<def> %EDI<kill> %RDI<kill>
                                        # kill: %ESI<def> %ESI<kill> %RSI<kill>
	callq	bi_reverse
	movw	%ax, (%r15,%rbx,4)
	jmp	.LBB47_6
.LBB47_7:                               # %for.end25
	addq	$40, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
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
.Lcfi237:
	.cfi_def_cfa_offset 16
.Lcfi238:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi239:
	.cfi_def_cfa_register %rbp
	xorl	%eax, %eax
	cmpl	$286, %eax              # imm = 0x11E
	jge	.LBB48_2
	.p2align	4, 0x90
.LBB48_8:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movw	$0, dyn_ltree(,%rax,4)
	incq	%rax
	cmpl	$286, %eax              # imm = 0x11E
	jl	.LBB48_8
.LBB48_2:                               # %for.cond1.preheader
	xorl	%eax, %eax
	cmpl	$30, %eax
	jge	.LBB48_4
	.p2align	4, 0x90
.LBB48_9:                               # %for.body3
                                        # =>This Inner Loop Header: Depth=1
	movw	$0, dyn_dtree(,%rax,4)
	incq	%rax
	cmpl	$30, %eax
	jl	.LBB48_9
.LBB48_4:                               # %for.cond11.preheader
	xorl	%eax, %eax
	cmpl	$18, %eax
	jg	.LBB48_7
	.p2align	4, 0x90
.LBB48_6:                               # %for.body13
                                        # =>This Inner Loop Header: Depth=1
	movw	$0, bl_tree(,%rax,4)
	incq	%rax
	cmpl	$18, %eax
	jle	.LBB48_6
.LBB48_7:                               # %for.end20
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
.Lcfi240:
	.cfi_def_cfa_offset 16
.Lcfi241:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi242:
	.cfi_def_cfa_register %rbp
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	cmpl	$7, %ecx
	jge	.LBB49_2
	.p2align	4, 0x90
.LBB49_8:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movzwl	dyn_ltree(,%rcx,4), %edx
	addl	%edx, %eax
	incq	%rcx
	cmpl	$7, %ecx
	jl	.LBB49_8
.LBB49_2:                               # %while.cond1.preheader
	xorl	%edx, %edx
	cmpl	$128, %ecx
	jge	.LBB49_5
	.p2align	4, 0x90
.LBB49_4:                               # %while.body4
                                        # =>This Inner Loop Header: Depth=1
	movzwl	dyn_ltree(,%rcx,4), %esi
	addl	%esi, %edx
	incq	%rcx
	cmpl	$128, %ecx
	jl	.LBB49_4
	jmp	.LBB49_5
	.p2align	4, 0x90
.LBB49_6:                               # %while.body16
                                        #   in Loop: Header=BB49_5 Depth=1
	movzwl	dyn_ltree(,%rcx,4), %esi
	addl	%esi, %eax
	incq	%rcx
.LBB49_5:                               # %while.cond13
                                        # =>This Inner Loop Header: Depth=1
	cmpl	$255, %ecx
	jle	.LBB49_6
# BB#7:                                 # %while.end24
	shrl	$2, %edx
	xorl	%ecx, %ecx
	cmpl	%edx, %eax
	setbe	%cl
	movq	file_type(%rip), %rax
	movw	%cx, (%rax)
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
.Lcfi243:
	.cfi_def_cfa_offset 16
.Lcfi244:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi245:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
.Lcfi246:
	.cfi_offset %rbx, -56
.Lcfi247:
	.cfi_offset %r12, -48
.Lcfi248:
	.cfi_offset %r13, -40
.Lcfi249:
	.cfi_offset %r14, -32
.Lcfi250:
	.cfi_offset %r15, -24
	movq	%rdi, %r14
	movq	(%r14), %r12
	movq	8(%r14), %rax
	movslq	28(%r14), %r13
	movl	$0, heap_len(%rip)
	movl	$573, heap_max(%rip)    # imm = 0x23D
	movl	$-1, %r15d
	xorl	%ecx, %ecx
	cmpl	%r13d, %ecx
	jl	.LBB50_6
	jmp	.LBB50_2
	.p2align	4, 0x90
.LBB50_7:                               # %if.then
                                        #   in Loop: Header=BB50_6 Depth=1
	movslq	heap_len(%rip), %rdx
	leaq	1(%rdx), %rsi
	movl	%esi, heap_len(%rip)
	movl	%ecx, heap+4(,%rdx,4)
	movb	$0, depth(%rcx)
	movl	%ecx, %r15d
	incq	%rcx
	cmpl	%r13d, %ecx
	jge	.LBB50_2
.LBB50_6:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	cmpw	$0, (%r12,%rcx,4)
	jne	.LBB50_7
# BB#8:                                 # %if.else
                                        #   in Loop: Header=BB50_6 Depth=1
	movw	$0, 2(%r12,%rcx,4)
	incq	%rcx
	cmpl	%r13d, %ecx
	jl	.LBB50_6
.LBB50_2:
	xorl	%ecx, %ecx
	cmpl	$1, heap_len(%rip)
	jle	.LBB50_4
	jmp	.LBB50_9
	.p2align	4, 0x90
.LBB50_5:                               # %if.then25
                                        #   in Loop: Header=BB50_4 Depth=1
	movzwl	2(%rax,%rdx,4), %edx
	subq	%rdx, static_len(%rip)
.LBB50_3:                               # %while.cond
                                        #   in Loop: Header=BB50_4 Depth=1
	cmpl	$1, heap_len(%rip)
	jg	.LBB50_9
.LBB50_4:                               # %while.body
                                        # =>This Inner Loop Header: Depth=1
	leal	1(%r15), %edx
	cmpl	$2, %r15d
	cmovll	%edx, %r15d
	cmovgel	%ecx, %edx
	movslq	heap_len(%rip), %rsi
	leaq	1(%rsi), %rdi
	movl	%edi, heap_len(%rip)
	movl	%edx, heap+4(,%rsi,4)
	movslq	%edx, %rdx
	movw	$1, (%r12,%rdx,4)
	movb	$0, depth(%rdx)
	decq	opt_len(%rip)
	testq	%rax, %rax
	je	.LBB50_3
	jmp	.LBB50_5
.LBB50_9:                               # %while.end
	movl	%r15d, 36(%r14)
	movl	heap_len(%rip), %eax
	movl	%eax, %ebx
	shrl	$31, %ebx
	addl	%eax, %ebx
	sarl	%ebx
	testl	%ebx, %ebx
	jle	.LBB50_12
	.p2align	4, 0x90
.LBB50_11:                              # %for.body36
                                        # =>This Inner Loop Header: Depth=1
	movq	%r12, %rdi
	movl	%ebx, %esi
	callq	pqdownheap
	decl	%ebx
	testl	%ebx, %ebx
	jg	.LBB50_11
	.p2align	4, 0x90
.LBB50_12:                              # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movslq	heap+4(%rip), %rbx
	movslq	heap_len(%rip), %rax
	leal	-1(%rax), %ecx
	movl	%ecx, heap_len(%rip)
	movl	heap(,%rax,4), %eax
	movl	%eax, heap+4(%rip)
	movl	$1, %esi
	movq	%r12, %rdi
	callq	pqdownheap
	movslq	heap+4(%rip), %rax
	movslq	heap_max(%rip), %rcx
	leaq	-1(%rcx), %rdx
	movl	%edx, heap_max(%rip)
	movl	%ebx, heap-4(,%rcx,4)
	movslq	heap_max(%rip), %rcx
	leaq	-1(%rcx), %rdx
	movl	%edx, heap_max(%rip)
	movl	%eax, heap-4(,%rcx,4)
	movzwl	(%r12,%rbx,4), %ecx
	movzwl	(%r12,%rax,4), %edx
	addl	%ecx, %edx
	movw	%dx, (%r12,%r13,4)
	movzbl	depth(%rbx), %ecx
	movzbl	depth(%rax), %edx
	cmpl	%edx, %ecx
	movl	%eax, %ecx
	cmovgel	%ebx, %ecx
	movslq	%ecx, %rcx
	movzbl	depth(%rcx), %ecx
	incl	%ecx
	movb	%cl, depth(%r13)
	movw	%r13w, 2(%r12,%rax,4)
	movw	%r13w, 2(%r12,%rbx,4)
	movq	%r13, %rbx
	incq	%rbx
	movl	%r13d, heap+4(%rip)
	movl	$1, %esi
	movq	%r12, %rdi
	callq	pqdownheap
	cmpl	$1, heap_len(%rip)
	movq	%rbx, %r13
	jg	.LBB50_12
# BB#13:                                # %do.end
	movl	heap+4(%rip), %eax
	movslq	heap_max(%rip), %rcx
	leaq	-1(%rcx), %rdx
	movl	%edx, heap_max(%rip)
	movl	%eax, heap-4(,%rcx,4)
	movq	%r14, %rdi
	callq	gen_bitlen
	movq	%r12, %rdi
	movl	%r15d, %esi
	callq	gen_codes
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
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
.Lcfi251:
	.cfi_def_cfa_offset 16
.Lcfi252:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi253:
	.cfi_def_cfa_register %rbp
	movl	l_desc+36(%rip), %esi
	movl	$dyn_ltree, %edi
	callq	scan_tree
	movl	d_desc+36(%rip), %esi
	movl	$dyn_dtree, %edi
	callq	scan_tree
	movl	$bl_desc, %edi
	callq	build_tree_1
	movl	$18, %eax
	movl	$71, %ecx
	cmpl	$3, %eax
	jge	.LBB51_2
	jmp	.LBB51_4
	.p2align	4, 0x90
.LBB51_3:                               # %for.inc
                                        #   in Loop: Header=BB51_2 Depth=1
	decq	%rax
	addq	$-3, %rcx
	cmpl	$3, %eax
	jl	.LBB51_4
.LBB51_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movzbl	bl_order(%rax), %edx
	cmpw	$0, bl_tree+2(,%rdx,4)
	je	.LBB51_3
.LBB51_4:                               # %for.end
	addq	%rcx, opt_len(%rip)
                                        # kill: %EAX<def> %EAX<kill> %RAX<kill>
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
.Lcfi254:
	.cfi_def_cfa_offset 16
.Lcfi255:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi256:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
.Lcfi257:
	.cfi_offset %rbx, -56
.Lcfi258:
	.cfi_offset %r12, -48
.Lcfi259:
	.cfi_offset %r13, -40
.Lcfi260:
	.cfi_offset %r14, -32
.Lcfi261:
	.cfi_offset %r15, -24
	movq	%rsi, -56(%rbp)         # 8-byte Spill
	movq	%rdi, %r15
	cmpl	$0, last_lit(%rip)
	je	.LBB52_12
# BB#1:                                 # %do.body.preheader
	xorl	%r12d, %r12d
	movl	$0, -44(%rbp)           # 4-byte Folded Spill
	movl	$0, -48(%rbp)           # 4-byte Folded Spill
	xorl	%r14d, %r14d
	.p2align	4, 0x90
.LBB52_2:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	testb	$7, %r14b
	jne	.LBB52_4
# BB#3:                                 # %if.then2
                                        #   in Loop: Header=BB52_2 Depth=1
	movl	-44(%rbp), %ecx         # 4-byte Reload
	movl	%ecx, %eax
	incl	%ecx
	movl	%ecx, -44(%rbp)         # 4-byte Spill
	movb	flag_buf(%rax), %r12b
.LBB52_4:                               # %if.end
                                        #   in Loop: Header=BB52_2 Depth=1
	movl	%r14d, %eax
	incl	%r14d
	movzbl	inbuf(%rax), %ebx
	testb	$1, %r12b
	jne	.LBB52_6
# BB#5:                                 # %if.then10
                                        #   in Loop: Header=BB52_2 Depth=1
	movzwl	(%r15,%rbx,4), %edi
	movzwl	2(%r15,%rbx,4), %esi
	jmp	.LBB52_10
	.p2align	4, 0x90
.LBB52_6:                               # %if.else
                                        #   in Loop: Header=BB52_2 Depth=1
	movzbl	length_code(%rbx), %r13d
	movl	%r13d, %eax
	addl	$257, %eax              # imm = 0x101
	movzwl	(%r15,%rax,4), %edi
	movzwl	2(%r15,%rax,4), %esi
	callq	send_bits
	movl	extra_lbits(,%r13,4), %esi
	testl	%esi, %esi
	je	.LBB52_8
# BB#7:                                 # %if.then38
                                        #   in Loop: Header=BB52_2 Depth=1
	subl	base_length(,%r13,4), %ebx
	movl	%ebx, %edi
	callq	send_bits
.LBB52_8:                               # %if.end41
                                        #   in Loop: Header=BB52_2 Depth=1
	movl	-48(%rbp), %ecx         # 4-byte Reload
	movl	%ecx, %eax
	incl	%ecx
	movl	%ecx, -48(%rbp)         # 4-byte Spill
	movzwl	d_buf(%rax,%rax), %r13d
	movl	%r13d, %eax
	shrl	$7, %eax
	addl	$256, %eax              # imm = 0x100
	cmpl	$256, %r13d             # imm = 0x100
	cmovbl	%r13d, %eax
	movzbl	dist_code(%rax), %ebx
	movq	-56(%rbp), %rax         # 8-byte Reload
	movzwl	(%rax,%rbx,4), %edi
	movzwl	2(%rax,%rbx,4), %esi
	callq	send_bits
	movl	extra_dbits(,%rbx,4), %esi
	testl	%esi, %esi
	je	.LBB52_11
# BB#9:                                 # %if.then69
                                        #   in Loop: Header=BB52_2 Depth=1
	subl	base_dist(,%rbx,4), %r13d
	movl	%r13d, %edi
.LBB52_10:                              # %if.end74
                                        #   in Loop: Header=BB52_2 Depth=1
	callq	send_bits
.LBB52_11:                              # %if.end74
                                        #   in Loop: Header=BB52_2 Depth=1
	movzbl	%r12b, %r12d
	shrl	%r12d
	cmpl	last_lit(%rip), %r14d
	jb	.LBB52_2
.LBB52_12:                              # %if.end80
	movzwl	1024(%r15), %edi
	movzwl	1026(%r15), %esi
	callq	send_bits
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
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
.Lcfi262:
	.cfi_def_cfa_offset 16
.Lcfi263:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi264:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
.Lcfi265:
	.cfi_offset %rbx, -48
.Lcfi266:
	.cfi_offset %r12, -40
.Lcfi267:
	.cfi_offset %r14, -32
.Lcfi268:
	.cfi_offset %r15, -24
	movl	%edx, %r12d
	movl	%esi, %r14d
	movl	%edi, %r15d
	leal	-257(%r15), %edi
	movl	$5, %esi
	callq	send_bits
	decl	%r14d
	movl	$5, %esi
	movl	%r14d, %edi
	callq	send_bits
	leal	-4(%r12), %edi
	movl	$4, %esi
	callq	send_bits
	xorl	%ebx, %ebx
	cmpl	%r12d, %ebx
	jge	.LBB53_3
	.p2align	4, 0x90
.LBB53_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movzbl	bl_order(%rbx), %eax
	movzwl	bl_tree+2(,%rax,4), %edi
	movl	$3, %esi
	callq	send_bits
	incq	%rbx
	cmpl	%r12d, %ebx
	jl	.LBB53_2
.LBB53_3:                               # %for.end
	decl	%r15d
	movl	$dyn_ltree, %edi
	movl	%r15d, %esi
	callq	send_tree
	movl	$dyn_dtree, %edi
	movl	%r14d, %esi
	callq	send_tree
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
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
.Lcfi269:
	.cfi_def_cfa_offset 16
.Lcfi270:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi271:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi272:
	.cfi_offset %rbx, -24
	movl	%esi, %ebx
	movl	%edi, ifd(%rip)
	movl	%ebx, ofd(%rip)
	callq	decode_start
	cmpl	$0, done(%rip)
	je	.LBB54_2
	jmp	.LBB54_5
	.p2align	4, 0x90
.LBB54_4:                               # %if.then
                                        #   in Loop: Header=BB54_2 Depth=1
	movl	$window, %esi
	movl	%ebx, %edi
	movl	%eax, %edx
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
	cmpl	$0, test(%rip)
	jne	.LBB54_1
# BB#3:                                 # %while.body
                                        #   in Loop: Header=BB54_2 Depth=1
	testl	%eax, %eax
	jne	.LBB54_4
	jmp	.LBB54_1
.LBB54_5:                               # %while.end
	xorl	%eax, %eax
	addq	$8, %rsp
	popq	%rbx
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
.Lcfi273:
	.cfi_def_cfa_offset 16
.Lcfi274:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi275:
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
.Lcfi276:
	.cfi_def_cfa_offset 16
.Lcfi277:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi278:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
.Lcfi279:
	.cfi_offset %rbx, -48
.Lcfi280:
	.cfi_offset %r12, -40
.Lcfi281:
	.cfi_offset %r14, -32
.Lcfi282:
	.cfi_offset %r15, -24
	movq	%rsi, %r14
	movl	%edi, %r15d
	movl	%r15d, %r12d
	xorl	%ebx, %ebx
	.p2align	4, 0x90
.LBB56_1:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	decl	j(%rip)
	js	.LBB56_3
# BB#2:                                 # %while.body
                                        #   in Loop: Header=BB56_1 Depth=1
	movl	decode.i(%rip), %eax
	movzbl	(%r14,%rax), %eax
	movb	%al, (%r14,%rbx)
	movl	decode.i(%rip), %eax
	incl	%eax
	andl	$8191, %eax             # imm = 0x1FFF
	movl	%eax, decode.i(%rip)
	incq	%rbx
	cmpl	%ebx, %r12d
	jne	.LBB56_1
	jmp	.LBB56_10
	.p2align	4, 0x90
.LBB56_3:                               # %for.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB56_8 Depth 2
	callq	decode_c
	cmpl	$510, %eax              # imm = 0x1FE
	je	.LBB56_4
# BB#5:                                 # %if.end6
                                        #   in Loop: Header=BB56_3 Depth=1
	cmpl	$255, %eax
	ja	.LBB56_7
# BB#6:                                 # %if.then8
                                        #   in Loop: Header=BB56_3 Depth=1
	movl	%ebx, %ecx
	movb	%al, (%r14,%rcx)
	incl	%ebx
	cmpl	%r15d, %ebx
	jne	.LBB56_3
	jmp	.LBB56_10
	.p2align	4, 0x90
.LBB56_7:                               # %if.else
                                        #   in Loop: Header=BB56_3 Depth=1
	addl	$-253, %eax
	movl	%eax, j(%rip)
	callq	decode_p
	movl	%ebx, %ecx
	subl	%eax, %ecx
	decl	%ecx
	andl	$8191, %ecx             # imm = 0x1FFF
	movl	%ecx, decode.i(%rip)
	.p2align	4, 0x90
.LBB56_8:                               # %while.cond20
                                        #   Parent Loop BB56_3 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	decl	j(%rip)
	js	.LBB56_3
# BB#9:                                 # %while.body24
                                        #   in Loop: Header=BB56_8 Depth=2
	movl	decode.i(%rip), %eax
	movzbl	(%r14,%rax), %eax
	movl	%ebx, %ecx
	movb	%al, (%r14,%rcx)
	movl	decode.i(%rip), %eax
	incl	%eax
	andl	$8191, %eax             # imm = 0x1FFF
	movl	%eax, decode.i(%rip)
	incl	%ebx
	cmpl	%ebx, %r12d
	jne	.LBB56_8
.LBB56_10:                              # %return
	movl	%ebx, %eax
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB56_4:                               # %if.then5
	movl	$1, done(%rip)
	jmp	.LBB56_10
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
.Lcfi283:
	.cfi_def_cfa_offset 16
.Lcfi284:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi285:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
.Lcfi286:
	.cfi_offset %rbx, -48
.Lcfi287:
	.cfi_offset %r12, -40
.Lcfi288:
	.cfi_offset %r14, -32
.Lcfi289:
	.cfi_offset %r15, -24
	movl	%edx, %r12d
	movq	%rsi, %r14
	movl	%edi, %r15d
	jmp	.LBB57_1
	.p2align	4, 0x90
.LBB57_4:                               # %if.end
                                        #   in Loop: Header=BB57_1 Depth=1
	subl	%ebx, %r12d
	movl	%ebx, %eax
	addq	%rax, %r14
.LBB57_1:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	%r12d, %edx
	movl	%r15d, %edi
	movq	%r14, %rsi
	callq	write
	movq	%rax, %rbx
	cmpl	%r12d, %ebx
	je	.LBB57_5
# BB#2:                                 # %while.body
                                        #   in Loop: Header=BB57_1 Depth=1
	cmpl	$-1, %ebx
	jne	.LBB57_4
# BB#3:                                 # %if.then
                                        #   in Loop: Header=BB57_1 Depth=1
	callq	write_error
	jmp	.LBB57_4
.LBB57_5:                               # %while.end
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
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
.Lcfi290:
	.cfi_def_cfa_offset 16
.Lcfi291:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi292:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$88, %rsp
.Lcfi293:
	.cfi_offset %rbx, -56
.Lcfi294:
	.cfi_offset %r12, -48
.Lcfi295:
	.cfi_offset %r13, -40
.Lcfi296:
	.cfi_offset %r14, -32
.Lcfi297:
	.cfi_offset %r15, -24
	movl	%esi, -56(%rbp)         # 4-byte Spill
	movl	%edi, -76(%rbp)         # 4-byte Spill
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB58_2
# BB#1:                                 # %cond.true
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB58_3
.LBB58_2:                               # %cond.false
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB58_3:                               # %cond.end
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
	shlq	%cl, %rax
	movq	%rax, -88(%rbp)         # 8-byte Spill
	cmpl	$17, %ecx
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
	movl	$1, %r14d
	jmp	.LBB58_61
.LBB58_10:                              # %if.end17
	movl	insize(%rip), %ecx
	movl	inptr(%rip), %r15d
	shll	$3, %r15d
	xorl	%r12d, %r12d
	cmpl	$0, block_mode(%rip)
	setne	%r12b
	orl	$256, %r12d             # imm = 0x100
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
	movl	$255, %eax
	testq	%rax, %rax
	js	.LBB58_12
	.p2align	4, 0x90
.LBB58_62:                              # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movb	%al, window(%rax)
	decq	%rax
	testq	%rax, %rax
	jns	.LBB58_62
.LBB58_12:                              # %do.body.preheader
	movq	%rcx, -64(%rbp)         # 8-byte Spill
	movq	$-1, %r13
	movl	$9, %eax
	movq	%rax, -48(%rbp)         # 8-byte Spill
	xorl	%ebx, %ebx
	movl	$511, -52(%rbp)         # 4-byte Folded Spill
                                        # imm = 0x1FF
	movl	$511, %eax              # imm = 0x1FF
	movq	%rax, -72(%rbp)         # 8-byte Spill
	xorl	%r14d, %r14d
	jmp	.LBB58_13
	.p2align	4, 0x90
.LBB58_57:                              # %do.cond230
                                        #   in Loop: Header=BB58_13 Depth=1
	cmpl	$0, -64(%rbp)           # 4-byte Folded Reload
	jne	.LBB58_13
	jmp	.LBB58_58
	.p2align	4, 0x90
.LBB58_34:                              # %if.then130
                                        #   in Loop: Header=BB58_13 Depth=1
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
	movq	-48(%rbp), %rax         # 8-byte Reload
	shll	$3, %eax
	movslq	%eax, %rcx
	leaq	-1(%r15,%rcx), %rax
	cqto
	idivq	%rcx
	subq	%rdx, %rcx
	leaq	-1(%r15,%rcx), %r15
	movl	$9, %eax
	movq	%rax, -48(%rbp)         # 8-byte Spill
	movl	$511, -52(%rbp)         # 4-byte Folded Spill
                                        # imm = 0x1FF
	movl	$511, %eax              # imm = 0x1FF
	movq	%rax, -72(%rbp)         # 8-byte Spill
	movl	$256, %r12d             # imm = 0x100
	jmp	.LBB58_13
	.p2align	4, 0x90
.LBB58_27:                              # %if.then73
                                        #   in Loop: Header=BB58_13 Depth=1
	movq	-48(%rbp), %rcx         # 8-byte Reload
	leal	(,%rcx,8), %eax
	movslq	%eax, %rsi
	leaq	-1(%r15,%rsi), %rax
	cqto
	idivq	%rsi
	subq	%rdx, %rsi
	leaq	-1(%r15,%rsi), %r15
	incl	%ecx
	movl	$1, %eax
	shlq	%cl, %rax
	decq	%rax
	cmpl	maxbits(%rip), %ecx
	cmoveq	-88(%rbp), %rax         # 8-byte Folded Reload
	movq	%rax, -72(%rbp)         # 8-byte Spill
	movl	$1, %eax
	movq	%rcx, -48(%rbp)         # 8-byte Spill
                                        # kill: %CL<def> %CL<kill> %RCX<kill>
	shll	%cl, %eax
	decl	%eax
	movl	%eax, -52(%rbp)         # 4-byte Spill
.LBB58_13:                              # %resetbuf
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB58_15 Depth 2
                                        #     Child Loop BB58_24 Depth 2
                                        #       Child Loop BB58_25 Depth 3
                                        #         Child Loop BB58_43 Depth 4
                                        #         Child Loop BB58_47 Depth 4
	movl	insize(%rip), %eax
	sarq	$3, %r15
	subl	%r15d, %eax
	xorl	%ecx, %ecx
	cmpl	%eax, %ecx
	jge	.LBB58_16
	.p2align	4, 0x90
.LBB58_15:                              # %for.body33
                                        #   Parent Loop BB58_13 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	leal	(%r15,%rcx), %edx
	movslq	%edx, %rdx
	movzbl	inbuf(%rdx), %edx
	movb	%dl, inbuf(%rcx)
	incq	%rcx
	cmpl	%eax, %ecx
	jl	.LBB58_15
.LBB58_16:                              # %for.end40
                                        #   in Loop: Header=BB58_13 Depth=1
	movl	%eax, insize(%rip)
	cmpl	$63, %eax
	ja	.LBB58_20
# BB#17:                                # %if.then43
                                        #   in Loop: Header=BB58_13 Depth=1
	movl	insize(%rip), %eax
	leaq	inbuf(%rax), %rsi
	movl	$32768, %edx            # imm = 0x8000
	movl	-76(%rbp), %edi         # 4-byte Reload
	callq	read
	movq	%rax, %r15
	cmpl	$-1, %r15d
	jne	.LBB58_19
# BB#18:                                # %if.then48
                                        #   in Loop: Header=BB58_13 Depth=1
	callq	read_error
.LBB58_19:                              # %if.end49
                                        #   in Loop: Header=BB58_13 Depth=1
	addl	%r15d, insize(%rip)
	movq	%r15, -64(%rbp)         # 8-byte Spill
	movslq	%r15d, %rax
	addq	%rax, bytes_in(%rip)
.LBB58_20:                              # %if.end53
                                        #   in Loop: Header=BB58_13 Depth=1
	movl	insize(%rip), %ecx
	cmpl	$0, -64(%rbp)           # 4-byte Folded Reload
	je	.LBB58_22
# BB#21:                                # %cond.true56
                                        #   in Loop: Header=BB58_13 Depth=1
	movl	insize(%rip), %eax
	xorl	%edx, %edx
	divl	-48(%rbp)               # 4-byte Folded Reload
                                        # kill: %EDX<def> %EDX<kill> %RDX<def>
	subq	%rdx, %rcx
	shlq	$3, %rcx
	jmp	.LBB58_23
	.p2align	4, 0x90
.LBB58_22:                              # %cond.false61
                                        #   in Loop: Header=BB58_13 Depth=1
	shlq	$3, %rcx
	movq	-48(%rbp), %rax         # 8-byte Reload
	leal	-1(%rax), %eax
	cltq
	subq	%rax, %rcx
.LBB58_23:                              # %cond.end67
                                        #   in Loop: Header=BB58_13 Depth=1
	movq	%rcx, -96(%rbp)         # 8-byte Spill
	xorl	%r15d, %r15d
	movq	%r13, %rax
	jmp	.LBB58_24
.LBB58_56:                              # %if.then222
                                        #   in Loop: Header=BB58_24 Depth=2
	movq	%rax, %rcx
	movq	-104(%rbp), %rax        # 8-byte Reload
	movw	%ax, prev(%r12,%r12)
	movq	%rcx, %rax
	movb	%r13b, window(%r12)
	incq	%r12
	.p2align	4, 0x90
.LBB58_24:                              # %while.cond.outer
                                        #   Parent Loop BB58_13 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB58_25 Depth 3
                                        #         Child Loop BB58_43 Depth 4
                                        #         Child Loop BB58_47 Depth 4
	movq	%r12, -112(%rbp)        # 8-byte Spill
	jmp	.LBB58_25
	.p2align	4, 0x90
.LBB58_54:                              # %if.else214
                                        #   in Loop: Header=BB58_25 Depth=3
	movslq	%ebx, %rcx
	leaq	outbuf(%rcx), %rdi
	movslq	%eax, %rdx
	movq	%r14, %rsi
	callq	memcpy
	movl	%r15d, %ebx
.LBB58_55:                              # %if.end219
                                        #   in Loop: Header=BB58_25 Depth=3
	movzbl	%r13b, %r14d
	movq	-112(%rbp), %r12        # 8-byte Reload
	cmpq	-88(%rbp), %r12         # 8-byte Folded Reload
	movq	-128(%rbp), %r15        # 8-byte Reload
	movq	-120(%rbp), %rax        # 8-byte Reload
	jge	.LBB58_25
	jmp	.LBB58_56
	.p2align	4, 0x90
.LBB58_31:                              # %if.end120
                                        #   in Loop: Header=BB58_25 Depth=3
	movslq	%ebx, %rax
	incl	%ebx
	movb	%r14b, outbuf(%rax)
	movq	%r14, %rax
.LBB58_25:                              # %while.cond
                                        #   Parent Loop BB58_13 Depth=1
                                        #     Parent Loop BB58_24 Depth=2
                                        # =>    This Loop Header: Depth=3
                                        #         Child Loop BB58_43 Depth 4
                                        #         Child Loop BB58_47 Depth 4
	movq	%rax, %r13
	cmpq	%r15, -96(%rbp)         # 8-byte Folded Reload
	jle	.LBB58_57
# BB#26:                                # %while.body
                                        #   in Loop: Header=BB58_25 Depth=3
	cmpq	-72(%rbp), %r12         # 8-byte Folded Reload
	jg	.LBB58_27
# BB#28:                                # %if.end96
                                        #   in Loop: Header=BB58_25 Depth=3
	movq	%r15, %rax
	sarq	$3, %rax
	movzbl	inbuf(%rax), %ecx
	movzbl	inbuf+1(%rax), %edx
	shlq	$8, %rdx
	orq	%rcx, %rdx
	movzbl	inbuf+2(%rax), %eax
	shlq	$16, %rax
	orq	%rdx, %rax
	movl	%r15d, %ecx
	andb	$7, %cl
	shrq	%cl, %rax
	movl	-52(%rbp), %ecx         # 4-byte Reload
	andq	%rax, %rcx
	movslq	-48(%rbp), %rax         # 4-byte Folded Reload
	addq	%rax, %r15
	cmpq	$-1, %r13
	je	.LBB58_29
# BB#32:                                # %if.end126
                                        #   in Loop: Header=BB58_25 Depth=3
	cmpq	$256, %rcx              # imm = 0x100
	movq	%rcx, %rax
	jne	.LBB58_35
# BB#33:                                # %if.end126
                                        #   in Loop: Header=BB58_25 Depth=3
	movq	%rax, %rcx
	movl	block_mode(%rip), %eax
	testl	%eax, %eax
	movq	%rcx, %rax
	jne	.LBB58_34
.LBB58_35:                              # %if.end145
                                        #   in Loop: Header=BB58_25 Depth=3
	cmpq	%r12, %rax
	movq	%r13, -104(%rbp)        # 8-byte Spill
	movq	%rax, -120(%rbp)        # 8-byte Spill
	jl	.LBB58_36
# BB#37:                                # %if.then148
                                        #   in Loop: Header=BB58_25 Depth=3
	jle	.LBB58_42
# BB#38:                                # %if.then151
                                        #   in Loop: Header=BB58_25 Depth=3
	cmpl	$0, test(%rip)
	jne	.LBB58_41
# BB#39:                                # %if.then151
                                        #   in Loop: Header=BB58_25 Depth=3
	testl	%ebx, %ebx
	jle	.LBB58_41
# BB#40:                                # %if.then156
                                        #   in Loop: Header=BB58_25 Depth=3
	movl	$outbuf, %esi
	movl	-56(%rbp), %edi         # 4-byte Reload
	movl	%ebx, %edx
	callq	write_buf
	movslq	%ebx, %rax
	addq	%rax, bytes_out(%rip)
.LBB58_41:                              # %if.end159
                                        #   in Loop: Header=BB58_25 Depth=3
	cmpl	$0, to_stdout(%rip)
	movl	$.L.str.57, %edi
	movl	$.L.str.56, %eax
	cmovneq	%rax, %rdi
	callq	error
.LBB58_42:                              # %if.end162
                                        #   in Loop: Header=BB58_25 Depth=3
	movb	%r14b, d_buf+65533(%rip)
	movq	%r13, %rax
	movl	$d_buf+65533, %r14d
	jmp	.LBB58_43
	.p2align	4, 0x90
.LBB58_29:                              # %if.then116
                                        #   in Loop: Header=BB58_25 Depth=3
	movq	%rcx, %r14
	cmpq	$256, %rcx              # imm = 0x100
	jl	.LBB58_31
# BB#30:                                # %if.then119
                                        #   in Loop: Header=BB58_25 Depth=3
	movl	$.L.str.56, %edi
	callq	error
	jmp	.LBB58_31
	.p2align	4, 0x90
.LBB58_36:                              #   in Loop: Header=BB58_25 Depth=3
	movl	$d_buf+65534, %r14d
	jmp	.LBB58_43
	.p2align	4, 0x90
.LBB58_44:                              # %while.body168
                                        #   in Loop: Header=BB58_43 Depth=4
	movb	%r13b, (%r14)
	movzwl	prev(%rax,%rax), %eax
.LBB58_43:                              # %while.cond165.preheader
                                        #   Parent Loop BB58_13 Depth=1
                                        #     Parent Loop BB58_24 Depth=2
                                        #       Parent Loop BB58_25 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	decq	%r14
	movzbl	window(%rax), %r13d
	cmpq	$256, %rax              # imm = 0x100
	jae	.LBB58_44
# BB#45:                                # %while.end
                                        #   in Loop: Header=BB58_25 Depth=3
	movq	%r15, -128(%rbp)        # 8-byte Spill
	movb	%r13b, (%r14)
	movl	$d_buf+65534, %eax
	subl	%r14d, %eax
	leal	(%rbx,%rax), %r15d
	cmpl	$16384, %r15d           # imm = 0x4000
	jl	.LBB58_54
# BB#46:                                # %do.body183.preheader
                                        #   in Loop: Header=BB58_25 Depth=3
	movl	%ebx, %r15d
	.p2align	4, 0x90
.LBB58_47:                              # %do.body183
                                        #   Parent Loop BB58_13 Depth=1
                                        #     Parent Loop BB58_24 Depth=2
                                        #       Parent Loop BB58_25 Depth=3
                                        # =>      This Inner Loop Header: Depth=4
	movl	$16384, %r12d           # imm = 0x4000
	subl	%r15d, %r12d
	cmpl	%r12d, %eax
	cmovlel	%eax, %r12d
	testl	%r12d, %r12d
	jle	.LBB58_49
# BB#48:                                # %if.then192
                                        #   in Loop: Header=BB58_47 Depth=4
	movslq	%r15d, %rax
	leaq	outbuf(%rax), %rdi
	movslq	%r12d, %rdx
	movq	%r14, %rsi
	callq	memcpy
	addl	%r12d, %r15d
.LBB58_49:                              # %if.end197
                                        #   in Loop: Header=BB58_47 Depth=4
	cmpl	$16384, %r15d           # imm = 0x4000
	jl	.LBB58_50
# BB#51:                                # %if.then200
                                        #   in Loop: Header=BB58_47 Depth=4
	xorl	%ebx, %ebx
	cmpl	$0, test(%rip)
	jne	.LBB58_53
# BB#52:                                # %if.then202
                                        #   in Loop: Header=BB58_47 Depth=4
	movl	$outbuf, %esi
	movl	-56(%rbp), %edi         # 4-byte Reload
	movl	%r15d, %edx
	callq	write_buf
	movslq	%r15d, %rax
	addq	%rax, bytes_out(%rip)
	jmp	.LBB58_53
	.p2align	4, 0x90
.LBB58_50:                              #   in Loop: Header=BB58_47 Depth=4
	movl	%r15d, %ebx
.LBB58_53:                              # %if.end206
                                        #   in Loop: Header=BB58_47 Depth=4
	movslq	%r12d, %rax
	addq	%rax, %r14
	movl	$d_buf+65534, %eax
	subl	%r14d, %eax
	testl	%eax, %eax
	movl	%ebx, %r15d
	jg	.LBB58_47
	jmp	.LBB58_55
.LBB58_58:                              # %do.end233
	xorl	%r14d, %r14d
	cmpl	$0, test(%rip)
	jne	.LBB58_61
# BB#59:                                # %do.end233
	testl	%ebx, %ebx
	jle	.LBB58_61
# BB#60:                                # %if.then238
	movl	$outbuf, %esi
	movl	-56(%rbp), %edi         # 4-byte Reload
	movl	%ebx, %edx
	callq	write_buf
	movslq	%ebx, %rax
	addq	%rax, bytes_out(%rip)
.LBB58_61:                              # %return
	movl	%r14d, %eax
	addq	$88, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
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
.Lcfi298:
	.cfi_def_cfa_offset 16
.Lcfi299:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi300:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi301:
	.cfi_offset %rbx, -24
	callq	__errno_location
	movl	(%rax), %ebx
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.75, %esi
	xorl	%eax, %eax
	callq	fprintf
	testl	%ebx, %ebx
	je	.LBB59_2
# BB#1:                                 # %if.then
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
.Lcfi302:
	.cfi_def_cfa_offset 16
.Lcfi303:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi304:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
.Lcfi305:
	.cfi_offset %rbx, -56
.Lcfi306:
	.cfi_offset %r12, -48
.Lcfi307:
	.cfi_offset %r13, -40
.Lcfi308:
	.cfi_offset %r14, -32
.Lcfi309:
	.cfi_offset %r15, -24
	movl	%edi, ifd(%rip)
	movl	%esi, ofd(%rip)
	callq	read_tree
	callq	build_tree
	movl	$0, valid(%rip)
	movq	$0, bitbuf(%rip)
	movb	peek_bits(%rip), %cl
	movl	$1, %eax
	shll	%cl, %eax
	decl	%eax
	movslq	max_len(%rip), %rcx
	movl	leaves(,%rcx,4), %ecx
	decl	%ecx
	movl	%ecx, -44(%rbp)         # 4-byte Spill
	movl	%eax, %r15d
	jmp	.LBB60_1
.LBB60_16:                              # %if.end
                                        #   in Loop: Header=BB60_1 Depth=1
	movl	max_len(%rip), %eax
	cmpl	-44(%rbp), %ebx         # 4-byte Folded Reload
	jne	.LBB60_18
# BB#17:                                # %if.end
                                        #   in Loop: Header=BB60_1 Depth=1
	cmpl	%eax, %r12d
	je	.LBB60_21
.LBB60_18:                              # %if.end55
                                        #   in Loop: Header=BB60_1 Depth=1
	movslq	%r12d, %rax
	addl	lit_base(,%rax,4), %ebx
	movb	literal(%rbx), %al
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
	subl	%r12d, valid(%rip)
	jmp	.LBB60_1
	.p2align	4, 0x90
.LBB60_5:                               # %cond.end
                                        #   in Loop: Header=BB60_1 Depth=1
	cltq
	orq	%rax, %rbx
	movq	%rbx, bitbuf(%rip)
	addl	$8, valid(%rip)
.LBB60_1:                               # %while.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB60_9 Depth 2
                                        #       Child Loop BB60_10 Depth 3
	movl	valid(%rip), %eax
	movq	bitbuf(%rip), %rbx
	cmpl	peek_bits(%rip), %eax
	jge	.LBB60_6
# BB#2:                                 # %while.body
                                        #   in Loop: Header=BB60_1 Depth=1
	shlq	$8, %rbx
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB60_4
# BB#3:                                 # %cond.true
                                        #   in Loop: Header=BB60_1 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB60_5
	.p2align	4, 0x90
.LBB60_4:                               # %cond.false
                                        #   in Loop: Header=BB60_1 Depth=1
	xorl	%edi, %edi
	callq	fill_inbuf
	jmp	.LBB60_5
.LBB60_6:                               # %while.end
                                        #   in Loop: Header=BB60_1 Depth=1
	movl	valid(%rip), %ecx
	subl	peek_bits(%rip), %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrq	%cl, %rbx
	andq	%r15, %rbx
	movzbl	outbuf(%rbx), %r12d
	testl	%r12d, %r12d
	jle	.LBB60_8
# BB#7:                                 # %if.then
                                        #   in Loop: Header=BB60_1 Depth=1
	movl	peek_bits(%rip), %ecx
	subl	%r12d, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %ebx
	jmp	.LBB60_16
.LBB60_8:                               # %if.else
                                        #   in Loop: Header=BB60_1 Depth=1
	movl	peek_bits(%rip), %r12d
	movq	%r15, %r13
	.p2align	4, 0x90
.LBB60_9:                               # %do.body
                                        #   Parent Loop BB60_1 Depth=1
                                        # =>  This Loop Header: Depth=2
                                        #       Child Loop BB60_10 Depth 3
	incl	%r12d
	leaq	1(%r13,%r13), %r13
	jmp	.LBB60_10
	.p2align	4, 0x90
.LBB60_14:                              # %cond.end35
                                        #   in Loop: Header=BB60_10 Depth=3
	cltq
	orq	%rax, %r14
	movq	%r14, bitbuf(%rip)
	addl	$8, valid(%rip)
.LBB60_10:                              # %while.cond21
                                        #   Parent Loop BB60_1 Depth=1
                                        #     Parent Loop BB60_9 Depth=2
                                        # =>    This Inner Loop Header: Depth=3
	movq	bitbuf(%rip), %r14
	cmpl	%r12d, valid(%rip)
	jge	.LBB60_15
# BB#11:                                # %while.body24
                                        #   in Loop: Header=BB60_10 Depth=3
	shlq	$8, %r14
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB60_13
# BB#12:                                # %cond.true28
                                        #   in Loop: Header=BB60_10 Depth=3
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB60_14
	.p2align	4, 0x90
.LBB60_13:                              # %cond.false33
                                        #   in Loop: Header=BB60_10 Depth=3
	xorl	%edi, %edi
	callq	fill_inbuf
	jmp	.LBB60_14
	.p2align	4, 0x90
.LBB60_15:                              # %while.end40
                                        #   in Loop: Header=BB60_9 Depth=2
	movl	valid(%rip), %ecx
	subl	%r12d, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrq	%cl, %r14
	movl	%r13d, %ebx
	andl	%r14d, %ebx
	movslq	%r12d, %rax
	cmpl	parents(,%rax,4), %ebx
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
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
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
.Lcfi310:
	.cfi_def_cfa_offset 16
.Lcfi311:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi312:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
.Lcfi313:
	.cfi_offset %rbx, -40
.Lcfi314:
	.cfi_offset %r14, -32
.Lcfi315:
	.cfi_offset %r15, -24
	movq	$0, orig_len(%rip)
	movl	$1, %r14d
	cmpl	$4, %r14d
	jle	.LBB61_2
	jmp	.LBB61_6
	.p2align	4, 0x90
.LBB61_5:                               # %cond.end
                                        #   in Loop: Header=BB61_2 Depth=1
	cltq
	orq	%rax, %rbx
	movq	%rbx, orig_len(%rip)
	incl	%r14d
	cmpl	$4, %r14d
	jg	.LBB61_6
.LBB61_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movq	orig_len(%rip), %rbx
	shlq	$8, %rbx
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB61_4
# BB#3:                                 # %cond.true
                                        #   in Loop: Header=BB61_2 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB61_5
	.p2align	4, 0x90
.LBB61_4:                               # %cond.false
                                        #   in Loop: Header=BB61_2 Depth=1
	xorl	%edi, %edi
	callq	fill_inbuf
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
	jmp	.LBB61_9
.LBB61_8:                               # %cond.false11
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB61_9:                               # %cond.end13
	movl	%eax, max_len(%rip)
	cmpl	$26, %eax
	jl	.LBB61_11
# BB#10:                                # %if.then
	movl	$.L.str.198, %edi
	callq	error
.LBB61_11:                              # %for.cond17.preheader
	xorl	%r14d, %r14d
	movl	$1, %ebx
	cmpl	max_len(%rip), %ebx
	jle	.LBB61_13
	jmp	.LBB61_17
	.p2align	4, 0x90
.LBB61_16:                              # %cond.end30
                                        #   in Loop: Header=BB61_13 Depth=1
	movl	%eax, leaves(,%rbx,4)
	addl	%eax, %r14d
	incq	%rbx
	cmpl	max_len(%rip), %ebx
	jg	.LBB61_17
.LBB61_13:                              # %for.body20
                                        # =>This Inner Loop Header: Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB61_15
# BB#14:                                # %cond.true23
                                        #   in Loop: Header=BB61_13 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB61_16
	.p2align	4, 0x90
.LBB61_15:                              # %cond.false28
                                        #   in Loop: Header=BB61_13 Depth=1
	xorl	%edi, %edi
	callq	fill_inbuf
	jmp	.LBB61_16
.LBB61_17:                              # %for.end38
	cmpl	$257, %r14d             # imm = 0x101
	jl	.LBB61_19
# BB#18:                                # %if.then41
	movl	$.L.str.199, %edi
	callq	error
.LBB61_19:                              # %if.end42
	movslq	max_len(%rip), %rax
	incl	leaves(,%rax,4)
	movl	$1, %r14d
	xorl	%r15d, %r15d
	cmpl	max_len(%rip), %r14d
	jle	.LBB61_21
	jmp	.LBB61_28
	.p2align	4, 0x90
.LBB61_27:                              # %for.inc75
                                        #   in Loop: Header=BB61_21 Depth=1
	incl	%r14d
	cmpl	max_len(%rip), %r14d
	jg	.LBB61_28
.LBB61_21:                              # %for.body49
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB61_23 Depth 2
	movslq	%r14d, %rax
	movl	%r15d, lit_base(,%rax,4)
	movl	leaves(,%rax,4), %ebx
	movslq	%r15d, %r15
	testl	%ebx, %ebx
	jg	.LBB61_23
	jmp	.LBB61_27
	.p2align	4, 0x90
.LBB61_26:                              # %cond.end67
                                        #   in Loop: Header=BB61_23 Depth=2
	movb	%al, literal(%r15)
	decl	%ebx
	incq	%r15
	testl	%ebx, %ebx
	jle	.LBB61_27
.LBB61_23:                              # %for.body57
                                        #   Parent Loop BB61_21 Depth=1
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
	jmp	.LBB61_26
	.p2align	4, 0x90
.LBB61_25:                              # %cond.false65
                                        #   in Loop: Header=BB61_23 Depth=2
	xorl	%edi, %edi
	callq	fill_inbuf
	jmp	.LBB61_26
.LBB61_28:                              # %for.end77
	movslq	max_len(%rip), %rax
	incl	leaves(,%rax,4)
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
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
.Lcfi316:
	.cfi_def_cfa_offset 16
.Lcfi317:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi318:
	.cfi_def_cfa_register %rbp
	movslq	max_len(%rip), %rax
	movq	%rax, %rcx
	shlq	$2, %rcx
	xorl	%edx, %edx
	testl	%eax, %eax
	jle	.LBB62_3
	.p2align	4, 0x90
.LBB62_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	sarl	%edx
	subl	%edx, lit_base(%rcx)
	movl	%edx, parents(%rcx)
	addl	leaves(%rcx), %edx
	decl	%eax
	addq	$-4, %rcx
	testl	%eax, %eax
	jg	.LBB62_2
.LBB62_3:                               # %for.end
	movl	max_len(%rip), %eax
	cmpl	$13, %eax
	movl	$12, %ecx
	cmovll	%eax, %ecx
	movl	%ecx, peek_bits(%rip)
	movb	peek_bits(%rip), %cl
	movl	$1, %edx
	movl	$1, %eax
	shll	%cl, %eax
	cltq
	leaq	outbuf(%rax), %rax
	cmpl	peek_bits(%rip), %edx
	jle	.LBB62_8
	jmp	.LBB62_5
	.p2align	4, 0x90
.LBB62_11:                              # %for.inc16
                                        #   in Loop: Header=BB62_8 Depth=1
	incl	%edx
	cmpl	peek_bits(%rip), %edx
	jg	.LBB62_5
.LBB62_8:                               # %for.body10
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB62_10 Depth 2
	movslq	%edx, %rcx
	movl	leaves(,%rcx,4), %esi
	movl	peek_bits(%rip), %ecx
	subl	%edx, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shll	%cl, %esi
	testl	%esi, %esi
	je	.LBB62_11
	.p2align	4, 0x90
.LBB62_10:                              # %while.body
                                        #   Parent Loop BB62_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	decl	%esi
	movb	%dl, -1(%rax)
	decq	%rax
	testl	%esi, %esi
	jne	.LBB62_10
	jmp	.LBB62_11
.LBB62_5:
	movl	$outbuf, %ecx
	cmpq	%rcx, %rax
	jbe	.LBB62_12
	.p2align	4, 0x90
.LBB62_7:                               # %while.body21
                                        # =>This Inner Loop Header: Depth=1
	movb	$0, -1(%rax)
	decq	%rax
	cmpq	%rcx, %rax
	ja	.LBB62_7
.LBB62_12:                              # %while.end23
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
.Lcfi319:
	.cfi_def_cfa_offset 16
.Lcfi320:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi321:
	.cfi_def_cfa_register %rbp
	movl	inptr(%rip), %eax
	movl	%edi, ifd(%rip)
	movzbl	inbuf+26(%rax), %ecx
	movzbl	inbuf+27(%rax), %edx
	shll	$8, %edx
	orl	%ecx, %edx
	movzbl	inbuf+28(%rax), %ecx
	movzbl	inbuf+29(%rax), %esi
	shll	$8, %esi
	orl	%ecx, %esi
	addl	%edx, %esi
	movl	inptr(%rip), %ecx
	leal	30(%rcx,%rsi), %ecx
	movl	%ecx, inptr(%rip)
	cmpl	insize(%rip), %ecx
	ja	.LBB63_2
# BB#1:                                 # %lor.lhs.false
	leaq	inbuf(%rax), %rax
	movzbl	(%rax), %ecx
	movzbl	1(%rax), %edx
	shll	$8, %edx
	orl	%ecx, %edx
	movzbl	2(%rax), %ecx
	movzbl	3(%rax), %esi
	shll	$8, %esi
	orl	%ecx, %esi
	shlq	$16, %rsi
	orq	%rdx, %rsi
	cmpq	$67324752, %rsi         # imm = 0x4034B50
	je	.LBB63_4
.LBB63_2:                               # %if.then
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.59, %esi
.LBB63_3:                               # %return
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	movl	$exit_code, %ecx
	movl	$1, %eax
.LBB63_10:                              # %return
	movl	$1, (%rcx)
	popq	%rbp
	retq
.LBB63_4:                               # %if.end
	movzbl	8(%rax), %ecx
	testl	%ecx, %ecx
	movl	%ecx, method(%rip)
	je	.LBB63_7
# BB#5:                                 # %if.end
	cmpl	$8, %ecx
	je	.LBB63_7
# BB#6:                                 # %if.then50
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.60, %esi
	jmp	.LBB63_3
.LBB63_7:                               # %if.end52
	movzbl	6(%rax), %ecx
	andl	$1, %ecx
	movl	%ecx, decrypt(%rip)
	je	.LBB63_9
# BB#8:                                 # %if.then57
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.61, %esi
	jmp	.LBB63_3
.LBB63_9:                               # %if.end59
	movzbl	6(%rax), %eax
	andl	$8, %eax
	shrl	$3, %eax
	movl	%eax, ext_header(%rip)
	movl	$pkzip, %ecx
	xorl	%eax, %eax
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
.Lcfi322:
	.cfi_def_cfa_offset 16
.Lcfi323:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi324:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$24, %rsp
.Lcfi325:
	.cfi_offset %rbx, -40
.Lcfi326:
	.cfi_offset %r14, -32
.Lcfi327:
	.cfi_offset %r15, -24
	movl	%edi, ifd(%rip)
	movl	%esi, ofd(%rip)
	xorl	%r15d, %r15d
	xorl	%edi, %edi
	xorl	%esi, %esi
	callq	updcrc
	cmpl	$0, pkzip(%rip)
	je	.LBB64_1
# BB#2:                                 # %entry
	movl	ext_header(%rip), %eax
	testl	%eax, %eax
	movl	$0, %r14d
	jne	.LBB64_4
# BB#3:                                 # %if.then
	movzbl	inbuf+14(%rip), %eax
	movzbl	inbuf+15(%rip), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	inbuf+16(%rip), %eax
	movzbl	inbuf+17(%rip), %r14d
	shll	$8, %r14d
	orl	%eax, %r14d
	shlq	$16, %r14
	orq	%rcx, %r14
	movzbl	inbuf+22(%rip), %eax
	movzbl	inbuf+23(%rip), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	inbuf+24(%rip), %eax
	movzbl	inbuf+25(%rip), %r15d
	shll	$8, %r15d
	orl	%eax, %r15d
	shlq	$16, %r15
	orq	%rcx, %r15
	cmpl	$8, method(%rip)
	je	.LBB64_5
	jmp	.LBB64_9
.LBB64_1:
	xorl	%r14d, %r14d
.LBB64_4:                               # %if.end
	cmpl	$8, method(%rip)
	jne	.LBB64_9
.LBB64_5:                               # %if.then32
	callq	inflate
	testl	%eax, %eax
	je	.LBB64_22
# BB#6:                                 # %if.then32
	cmpl	$3, %eax
	jne	.LBB64_8
# BB#7:                                 # %if.then36
	movl	$.L.str.62, %edi
	jmp	.LBB64_21
.LBB64_9:                               # %if.else42
	cmpl	$0, pkzip(%rip)
	je	.LBB64_20
# BB#10:                                # %if.else42
	movl	method(%rip), %eax
	testl	%eax, %eax
	jne	.LBB64_20
# BB#11:                                # %if.then47
	movzbl	inbuf+22(%rip), %eax
	movzbl	inbuf+23(%rip), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	inbuf+24(%rip), %eax
	movzbl	inbuf+25(%rip), %ebx
	shll	$8, %ebx
	orl	%eax, %ebx
	shlq	$16, %rbx
	orq	%rcx, %rbx
	movzbl	inbuf+18(%rip), %eax
	movzbl	inbuf+19(%rip), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	inbuf+20(%rip), %eax
	movzbl	inbuf+21(%rip), %edx
	shll	$8, %edx
	orl	%eax, %edx
	shlq	$16, %rdx
	orq	%rcx, %rdx
	movl	decrypt(%rip), %eax
	testl	%eax, %eax
	movl	$12, %ecx
	cmovel	%eax, %ecx
	subq	%rcx, %rdx
	cmpq	%rdx, %rbx
	je	.LBB64_13
# BB#12:                                # %if.then85
	movq	stderr(%rip), %rdi
	movzbl	inbuf+18(%rip), %eax
	movzbl	inbuf+19(%rip), %edx
	shll	$8, %edx
	orl	%eax, %edx
	movzbl	inbuf+20(%rip), %eax
	movzbl	inbuf+21(%rip), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	shlq	$16, %rcx
	orq	%rdx, %rcx
	movl	$.L.str.64, %esi
	xorl	%eax, %eax
	movq	%rbx, %rdx
	callq	fprintf
	movl	$.L.str.65, %edi
	callq	error
	testq	%rbx, %rbx
	jne	.LBB64_14
	jmp	.LBB64_19
	.p2align	4, 0x90
.LBB64_18:                              # %if.then116
	callq	flush_window
.LBB64_13:                              # %while.cond
	testq	%rbx, %rbx
	je	.LBB64_19
.LBB64_14:                              # %while.body
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB64_16
# BB#15:                                # %cond.true
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB64_17
	.p2align	4, 0x90
.LBB64_16:                              # %cond.false
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB64_17:                              # %cond.end
	decq	%rbx
	movl	outcnt(%rip), %ecx
	leal	1(%rcx), %edx
	movl	%edx, outcnt(%rip)
	movb	%al, window(%rcx)
	cmpl	$32768, outcnt(%rip)    # imm = 0x8000
	jne	.LBB64_13
	jmp	.LBB64_18
.LBB64_20:                              # %if.else118
	movl	$.L.str.66, %edi
	jmp	.LBB64_21
.LBB64_19:                              # %while.end
	callq	flush_window
	cmpl	$0, pkzip(%rip)
	jne	.LBB64_30
	jmp	.LBB64_23
.LBB64_8:                               # %if.then39
	movl	$.L.str.63, %edi
.LBB64_21:                              # %if.end120
	callq	error
.LBB64_22:                              # %if.end120
	cmpl	$0, pkzip(%rip)
	je	.LBB64_23
.LBB64_30:                              # %if.else192
	cmpl	$0, ext_header(%rip)
	je	.LBB64_39
# BB#31:                                # %for.cond195.preheader
	xorl	%ebx, %ebx
	cmpl	$15, %ebx
	jle	.LBB64_33
	jmp	.LBB64_37
	.p2align	4, 0x90
.LBB64_36:                              # %cond.end208
                                        #   in Loop: Header=BB64_33 Depth=1
	movb	%al, -48(%rbp,%rbx)
	incq	%rbx
	cmpl	$15, %ebx
	jg	.LBB64_37
.LBB64_33:                              # %for.body198
                                        # =>This Inner Loop Header: Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB64_35
# BB#34:                                # %cond.true201
                                        #   in Loop: Header=BB64_33 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB64_36
	.p2align	4, 0x90
.LBB64_35:                              # %cond.false206
                                        #   in Loop: Header=BB64_33 Depth=1
	xorl	%edi, %edi
	callq	fill_inbuf
	jmp	.LBB64_36
.LBB64_37:                              # %for.end215
	movzbl	-44(%rbp), %eax
	movzbl	-43(%rbp), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	-42(%rbp), %eax
	movzbl	-41(%rbp), %r14d
	shll	$8, %r14d
	orl	%eax, %r14d
	shlq	$16, %r14
	orq	%rcx, %r14
	movzbl	-36(%rbp), %eax
	movzbl	-35(%rbp), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	-34(%rbp), %eax
	movzbl	-33(%rbp), %r15d
	jmp	.LBB64_38
.LBB64_23:                              # %for.cond.preheader
	xorl	%ebx, %ebx
	cmpl	$7, %ebx
	jle	.LBB64_25
	jmp	.LBB64_29
	.p2align	4, 0x90
.LBB64_28:                              # %cond.end134
                                        #   in Loop: Header=BB64_25 Depth=1
	movb	%al, -48(%rbp,%rbx)
	incq	%rbx
	cmpl	$7, %ebx
	jg	.LBB64_29
.LBB64_25:                              # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB64_27
# BB#26:                                # %cond.true127
                                        #   in Loop: Header=BB64_25 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB64_28
	.p2align	4, 0x90
.LBB64_27:                              # %cond.false132
                                        #   in Loop: Header=BB64_25 Depth=1
	xorl	%edi, %edi
	callq	fill_inbuf
	jmp	.LBB64_28
.LBB64_29:                              # %for.end
	movzbl	-48(%rbp), %eax
	movzbl	-47(%rbp), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	-46(%rbp), %eax
	movzbl	-45(%rbp), %r14d
	shll	$8, %r14d
	orl	%eax, %r14d
	shlq	$16, %r14
	orq	%rcx, %r14
	movzbl	-44(%rbp), %eax
	movzbl	-43(%rbp), %ecx
	shll	$8, %ecx
	orl	%eax, %ecx
	movzbl	-42(%rbp), %eax
	movzbl	-41(%rbp), %r15d
.LBB64_38:                              # %if.end277
	shll	$8, %r15d
	orl	%eax, %r15d
	shlq	$16, %r15
	orq	%rcx, %r15
.LBB64_39:                              # %if.end277
	xorl	%ebx, %ebx
	movl	$outbuf, %edi
	xorl	%esi, %esi
	callq	updcrc
	cmpq	%rax, %r14
	je	.LBB64_41
# BB#40:                                # %if.then281
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.67, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, %ebx
.LBB64_41:                              # %if.end283
	movl	bytes_out(%rip), %eax
	cmpq	%rax, %r15
	je	.LBB64_43
# BB#42:                                # %if.then286
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.68, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, %ebx
.LBB64_43:                              # %if.end288
	cmpl	$0, pkzip(%rip)
	je	.LBB64_52
# BB#44:                                # %land.lhs.true290
	movl	inptr(%rip), %eax
	addl	$4, %eax
	cmpl	insize(%rip), %eax
	jae	.LBB64_52
# BB#45:                                # %land.lhs.true293
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
	jne	.LBB64_52
# BB#46:                                # %if.then325
	cmpl	$0, to_stdout(%rip)
	je	.LBB64_51
# BB#47:                                # %if.then327
	cmpl	$0, quiet(%rip)
	jne	.LBB64_49
# BB#48:                                # %if.then329
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.69, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB64_49:                              # %if.end331
	cmpl	$0, exit_code(%rip)
	jne	.LBB64_52
# BB#50:                                # %if.then334
	movl	$2, exit_code(%rip)
	jmp	.LBB64_52
.LBB64_51:                              # %if.else336
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.70, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, %ebx
.LBB64_52:                              # %if.end339
	movl	$0, pkzip(%rip)
	movl	$0, ext_header(%rip)
	testl	%ebx, %ebx
	je	.LBB64_53
# BB#54:                                # %if.end343
	movl	$1, exit_code(%rip)
	cmpl	$0, test(%rip)
	jne	.LBB64_56
# BB#55:                                # %if.then345
	callq	abort_gzip
	jmp	.LBB64_56
.LBB64_53:
	xorl	%ebx, %ebx
.LBB64_56:                              # %return
	movl	%ebx, %eax
	addq	$24, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
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
.Lcfi328:
	.cfi_def_cfa_offset 16
.Lcfi329:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi330:
	.cfi_def_cfa_register %rbp
	movl	$4294967295, %eax       # imm = 0xFFFFFFFF
	testq	%rdi, %rdi
	movl	$4294967295, %ecx       # imm = 0xFFFFFFFF
	je	.LBB65_3
# BB#1:                                 # %if.else
	movq	updcrc.crc(%rip), %rcx
	testl	%esi, %esi
	je	.LBB65_3
	.p2align	4, 0x90
.LBB65_2:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movzbl	(%rdi), %edx
	incq	%rdi
	xorl	%ecx, %edx
	movzbl	%dl, %edx
	shrq	$8, %rcx
	xorq	crc_32_tab(,%rdx,8), %rcx
	decl	%esi
	jne	.LBB65_2
.LBB65_3:                               # %if.end5
	movq	%rcx, updcrc.crc(%rip)
	xorq	%rcx, %rax
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
.Lcfi331:
	.cfi_def_cfa_offset 16
.Lcfi332:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi333:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi334:
	.cfi_offset %rbx, -32
.Lcfi335:
	.cfi_offset %r14, -24
	movl	%esi, %r14d
	movl	%edi, %ebx
	callq	__errno_location
	movl	$0, (%rax)
	jmp	.LBB66_1
	.p2align	4, 0x90
.LBB66_2:                               # %while.body
                                        #   in Loop: Header=BB66_1 Depth=1
	movl	$inbuf, %esi
	movl	%r14d, %edi
                                        # kill: %EDX<def> %EDX<kill> %RDX<kill>
	callq	write_buf
	movl	insize(%rip), %eax
	addq	%rax, bytes_out(%rip)
	movl	$inbuf, %esi
	movl	$32768, %edx            # imm = 0x8000
	movl	%ebx, %edi
	callq	read
	movl	%eax, insize(%rip)
.LBB66_1:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	insize(%rip), %edx
	leal	1(%rdx), %eax
	cmpl	$2, %eax
	jae	.LBB66_2
# BB#3:                                 # %while.end
	cmpl	$-1, %edx
	jne	.LBB66_5
# BB#4:                                 # %if.then
	callq	read_error
.LBB66_5:                               # %if.end
	movq	bytes_out(%rip), %rax
	movq	%rax, bytes_in(%rip)
	xorl	%eax, %eax
	popq	%rbx
	popq	%r14
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
.Lcfi336:
	.cfi_def_cfa_offset 16
.Lcfi337:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi338:
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
.Lcfi339:
	.cfi_def_cfa_offset 16
.Lcfi340:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi341:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi342:
	.cfi_offset %rbx, -24
	callq	__errno_location
	movl	(%rax), %ebx
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.75, %esi
	xorl	%eax, %eax
	callq	fprintf
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
.Lcfi343:
	.cfi_def_cfa_offset 16
.Lcfi344:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi345:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi346:
	.cfi_offset %rbx, -32
.Lcfi347:
	.cfi_offset %r14, -24
	movq	%rdi, %r14
	movq	%r14, %rbx
	cmpb	$0, (%rbx)
	jne	.LBB69_2
	jmp	.LBB69_5
	.p2align	4, 0x90
.LBB69_4:                               # %cond.end
                                        #   in Loop: Header=BB69_2 Depth=1
	movb	%al, (%rbx)
	incq	%rbx
	cmpb	$0, (%rbx)
	je	.LBB69_5
.LBB69_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	callq	__ctype_b_loc
	movq	(%rax), %rcx
	movzbl	(%rbx), %eax
	movzwl	(%rcx,%rax,2), %ecx
	testb	$1, %ch
	je	.LBB69_4
# BB#3:                                 # %cond.true
                                        #   in Loop: Header=BB69_2 Depth=1
	movl	%eax, %edi
	callq	tolower
                                        # kill: %EAX<def> %EAX<kill> %RAX<def>
	jmp	.LBB69_4
.LBB69_5:                               # %for.end
	movq	%r14, %rax
	popq	%rbx
	popq	%r14
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
.Lcfi348:
	.cfi_def_cfa_offset 16
.Lcfi349:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi350:
	.cfi_def_cfa_register %rbp
	callq	unlink
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
.Lcfi351:
	.cfi_def_cfa_offset 16
.Lcfi352:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi353:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi354:
	.cfi_offset %rbx, -24
	movq	%rdi, %rbx
	movl	$46, %esi
	callq	strrchr
	testq	%rax, %rax
	je	.LBB71_5
# BB#1:                                 # %if.end
	leaq	1(%rax), %rcx
	cmpq	%rbx, %rax
	cmovneq	%rax, %rcx
	.p2align	4, 0x90
.LBB71_2:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	leaq	-1(%rcx), %rax
	cmpb	$46, -1(%rcx)
	jne	.LBB71_4
# BB#3:                                 # %if.then7
                                        #   in Loop: Header=BB71_2 Depth=1
	movb	$95, -1(%rcx)
.LBB71_4:                               # %do.cond
                                        #   in Loop: Header=BB71_2 Depth=1
	cmpq	%rax, %rbx
	movq	%rax, %rcx
	jne	.LBB71_2
.LBB71_5:                               # %do.end
	addq	$8, %rsp
	popq	%rbx
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
.Lcfi355:
	.cfi_def_cfa_offset 16
.Lcfi356:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi357:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi358:
	.cfi_offset %rbx, -24
	movl	%edi, %edi
	callq	malloc
	movq	%rax, %rbx
	testq	%rbx, %rbx
	jne	.LBB72_2
# BB#1:                                 # %if.then
	movl	$.L.str.62, %edi
	callq	error
.LBB72_2:                               # %if.end
	movq	%rbx, %rax
	addq	$8, %rsp
	popq	%rbx
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
	movq	%rdi, %r8
	cmpl	$0, quiet(%rip)
	jne	.LBB73_2
# BB#1:                                 # %if.then
	pushq	%rbp
.Lcfi359:
	.cfi_def_cfa_offset 16
.Lcfi360:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi361:
	.cfi_def_cfa_register %rbp
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.74, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	popq	%rbp
.LBB73_2:                               # %if.end
	cmpl	$0, exit_code(%rip)
	jne	.LBB73_4
# BB#3:                                 # %if.then1
	movl	$2, exit_code(%rip)
.LBB73_4:                               # %if.end2
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
	testq	%rsi, %rsi
	je	.LBB74_1
# BB#2:                                 # %cond.false
	cvtsi2sdq	%rdi, %xmm0
	mulsd	.LCPI74_0(%rip), %xmm0
	cvtsi2sdq	%rsi, %xmm1
	divsd	%xmm1, %xmm0
	jmp	.LBB74_3
.LBB74_1:
	xorpd	%xmm0, %xmm0
.LBB74_3:                               # %cond.end
	pushq	%rbp
.Lcfi362:
	.cfi_def_cfa_offset 16
.Lcfi363:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi364:
	.cfi_def_cfa_register %rbp
	movl	$.L.str.77, %esi
	movb	$1, %al
	movq	%rdx, %rdi
	callq	fprintf
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
.Lcfi365:
	.cfi_def_cfa_offset 16
.Lcfi366:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi367:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	subq	$72, %rsp
.Lcfi368:
	.cfi_offset %rbx, -40
.Lcfi369:
	.cfi_offset %r14, -32
.Lcfi370:
	.cfi_offset %r15, -24
	movl	%edx, %r15d
	movq	%rsi, %rcx
	movq	%rdi, %r14
	testq	%rcx, %rcx
	js	.LBB75_3
# BB#1:
	leaq	-32(%rbp), %rbx
	movabsq	$7378697629483820647, %rsi # imm = 0x6666666666666667
	.p2align	4, 0x90
.LBB75_2:                               # %do.body4
                                        # =>This Inner Loop Header: Depth=1
	movq	%rcx, %rax
	imulq	%rsi
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$2, %rdx
	leal	(%rdx,%rax), %edi
	addl	%edi, %edi
	leal	(%rdi,%rdi,4), %edi
	subl	%edi, %ecx
	addl	$48, %ecx
	movb	%cl, -1(%rbx)
	decq	%rbx
	addq	%rax, %rdx
	movq	%rdx, %rcx
	jne	.LBB75_2
	jmp	.LBB75_6
.LBB75_3:                               # %do.body.preheader
	leaq	-33(%rbp), %rbx
	movabsq	$7378697629483820647, %rsi # imm = 0x6666666666666667
	.p2align	4, 0x90
.LBB75_4:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movq	%rcx, %rax
	imulq	%rsi
	movq	%rdx, %rax
	shrq	$63, %rax
	sarq	$2, %rdx
	leal	(%rdx,%rax), %edi
	addl	%edi, %edi
	leal	(%rdi,%rdi,4), %edi
	subl	%edi, %ecx
	movl	$48, %edi
	subl	%ecx, %edi
	movb	%dil, (%rbx)
	decq	%rbx
	addq	%rax, %rdx
	movq	%rdx, %rcx
	jne	.LBB75_4
# BB#5:                                 # %do.end
	movb	$45, (%rbx)
.LBB75_6:                               # %if.end
	leaq	-96(%rbp), %rax
	addl	$64, %eax
	subl	%ebx, %eax
	subl	%eax, %r15d
	testl	%r15d, %r15d
	jle	.LBB75_8
	.p2align	4, 0x90
.LBB75_12:                              # %while.body
                                        # =>This Inner Loop Header: Depth=1
	decl	%r15d
	movl	$32, %edi
	movq	%r14, %rsi
	callq	_IO_putc
	testl	%r15d, %r15d
	jg	.LBB75_12
.LBB75_8:
	leaq	-32(%rbp), %r15
	cmpq	%r15, %rbx
	jae	.LBB75_11
	.p2align	4, 0x90
.LBB75_10:                              # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movsbl	(%rbx), %edi
	movq	%r14, %rsi
	callq	_IO_putc
	incq	%rbx
	cmpq	%r15, %rbx
	jb	.LBB75_10
.LBB75_11:                              # %for.end
	addq	$72, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
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
.Lcfi371:
	.cfi_def_cfa_offset 16
.Lcfi372:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi373:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$128, %rsp
.Lcfi374:
	.cfi_offset %rbx, -32
.Lcfi375:
	.cfi_offset %r14, -24
	xorl	%r14d, %r14d
	jmp	.LBB76_1
.LBB76_6:                               # %if.then
                                        #   in Loop: Header=BB76_1 Depth=1
	movslq	%r14d, %rax
	incl	%r14d
	movb	%bl, -144(%rbp,%rax)
	.p2align	4, 0x90
.LBB76_1:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	callq	getchar
	movl	%eax, %ebx
	cmpl	$-1, %ebx
	setne	%al
	cmpl	$10, %ebx
	setne	%cl
	andb	%al, %cl
	cmpb	$1, %cl
	jne	.LBB76_7
# BB#2:                                 # %while.body
                                        #   in Loop: Header=BB76_1 Depth=1
	testl	%r14d, %r14d
	jle	.LBB76_4
# BB#3:                                 # %while.body
                                        #   in Loop: Header=BB76_1 Depth=1
	cmpl	$127, %r14d
	jl	.LBB76_6
.LBB76_4:                               # %lor.lhs.false
                                        #   in Loop: Header=BB76_1 Depth=1
	testl	%r14d, %r14d
	jne	.LBB76_1
# BB#5:                                 # %land.lhs.true5
                                        #   in Loop: Header=BB76_1 Depth=1
	callq	__ctype_b_loc
	movq	(%rax), %rax
	movslq	%ebx, %rcx
	movzwl	(%rax,%rcx,2), %eax
	testb	$32, %ah
	jne	.LBB76_1
	jmp	.LBB76_6
.LBB76_7:                               # %while.end
	movslq	%r14d, %rax
	movb	$0, -144(%rbp,%rax)
	leaq	-144(%rbp), %rdi
	callq	rpmatch
	xorl	%ecx, %ecx
	cmpl	$1, %eax
	sete	%cl
	movl	%ecx, %eax
	addq	$128, %rsp
	popq	%rbx
	popq	%r14
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
.Lcfi376:
	.cfi_def_cfa_offset 16
.Lcfi377:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi378:
	.cfi_def_cfa_register %rbp
	movl	$1, %eax
	cmpb	$121, (%rdi)
	je	.LBB77_5
# BB#1:                                 # %lor.lhs.false
	cmpb	$89, (%rdi)
	je	.LBB77_5
# BB#2:                                 # %cond.false
	movb	$1, %al
	cmpb	$110, (%rdi)
	je	.LBB77_4
# BB#3:                                 # %lor.rhs
	cmpb	$78, (%rdi)
	sete	%al
.LBB77_4:                               # %lor.end
	movzbl	%al, %eax
	decl	%eax
.LBB77_5:                               # %cond.end
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
.Lcfi379:
	.cfi_def_cfa_offset 16
.Lcfi380:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi381:
	.cfi_def_cfa_register %rbp
	movl	$1, %r9d
	callq	_getopt_internal
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
.Lcfi382:
	.cfi_def_cfa_offset 16
.Lcfi383:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi384:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi385:
	.cfi_offset %rbx, -32
.Lcfi386:
	.cfi_offset %r14, -24
	movq	%rdi, %r14
	callq	__errno_location
	movl	(%rax), %ebx
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.133, %esi
	xorl	%eax, %eax
	callq	fprintf
	callq	__errno_location
	movl	%ebx, (%rax)
	movq	%r14, %rdi
	callq	perror
	movl	$1, exit_code(%rip)
	popq	%rbx
	popq	%r14
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
.Lcfi387:
	.cfi_def_cfa_offset 16
.Lcfi388:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi389:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
.Lcfi390:
	.cfi_offset %rbx, -56
.Lcfi391:
	.cfi_offset %r12, -48
.Lcfi392:
	.cfi_offset %r13, -40
.Lcfi393:
	.cfi_offset %r14, -32
.Lcfi394:
	.cfi_offset %r15, -24
	movl	%edi, %ebx
	movl	inptr(%rip), %eax
	movl	insize(%rip), %ecx
	cmpl	$0, force(%rip)
	je	.LBB80_8
# BB#1:                                 # %entry
	movl	to_stdout(%rip), %edx
	testl	%edx, %edx
	je	.LBB80_8
# BB#2:                                 # %if.then
	cmpl	%ecx, %eax
	jae	.LBB80_4
# BB#3:                                 # %cond.true
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB80_5
.LBB80_8:                               # %if.else
	cmpl	%ecx, %eax
	jae	.LBB80_10
# BB#9:                                 # %cond.true19
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB80_11
.LBB80_4:                               # %cond.false
	movl	$1, %edi
	callq	fill_inbuf
.LBB80_5:                               # %cond.end
	movb	%al, -42(%rbp)
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_7
# BB#6:                                 # %cond.true6
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	movl	%eax, %r15d
	jmp	.LBB80_14
.LBB80_10:                              # %cond.false24
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB80_11:                              # %cond.end26
	movb	%al, -42(%rbp)
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_13
# BB#12:                                # %cond.true32
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	xorl	%r15d, %r15d
	jmp	.LBB80_14
.LBB80_7:                               # %cond.false11
	movl	$1, %edi
	callq	fill_inbuf
	movl	%eax, %r15d
	jmp	.LBB80_14
.LBB80_13:                              # %cond.false37
	xorl	%r15d, %r15d
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB80_14:                              # %if.end
	movb	%al, -41(%rbp)
	movl	$-1, method(%rip)
	incl	part_nb(%rip)
	movq	$0, header_bytes(%rip)
	movl	$0, last_member(%rip)
	movzwl	-42(%rbp), %eax
	cmpl	$35615, %eax            # imm = 0x8B1F
	je	.LBB80_16
# BB#15:                                # %lor.lhs.false
	movzwl	-42(%rbp), %eax
	cmpl	$40479, %eax            # imm = 0x9E1F
	je	.LBB80_16
# BB#101:                               # %if.else358
	movzwl	-42(%rbp), %eax
	cmpl	$19280, %eax            # imm = 0x4B50
	jne	.LBB80_105
# BB#102:                               # %if.else358
	cmpl	$2, inptr(%rip)
	jne	.LBB80_105
# BB#103:                               # %land.lhs.true366
	cmpl	$67324752, inbuf(%rip)  # imm = 0x4034B50
	je	.LBB80_104
.LBB80_105:                             # %if.else376
	movzwl	-42(%rbp), %eax
	cmpl	$7711, %eax             # imm = 0x1E1F
	je	.LBB80_106
# BB#107:                               # %if.else382
	movzwl	-42(%rbp), %eax
	cmpl	$40223, %eax            # imm = 0x9D1F
	je	.LBB80_108
# BB#109:                               # %if.else388
	movzwl	-42(%rbp), %eax
	cmpl	$40991, %eax            # imm = 0xA01F
	je	.LBB80_110
# BB#111:                               # %if.else394
	cmpl	$0, force(%rip)
	sete	%al
	cmpl	$0, to_stdout(%rip)
	sete	%cl
	orb	%al, %cl
	jne	.LBB80_115
# BB#112:                               # %if.else394
	movl	list(%rip), %eax
	testl	%eax, %eax
	jne	.LBB80_115
# BB#113:                               # %if.then400
	movl	$0, method(%rip)
	movq	$copy, work(%rip)
	movl	$0, inptr(%rip)
	jmp	.LBB80_114
.LBB80_16:                              # %if.then51
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_18
# BB#17:                                # %cond.true54
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB80_19
.LBB80_18:                              # %cond.false59
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB80_19:                              # %cond.end61
	movl	%eax, method(%rip)
	cmpl	$8, %eax
	je	.LBB80_21
# BB#20:                                # %if.then65
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	method(%rip), %r8d
	movl	$.L.str.135, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	jmp	.LBB80_27
.LBB80_21:                              # %if.end67
	movq	$unzip, work(%rip)
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_23
# BB#22:                                # %cond.true70
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %r14d
	testb	$32, %r14b
	jne	.LBB80_25
	jmp	.LBB80_28
.LBB80_23:                              # %cond.false75
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, %r14d
	testb	$32, %r14b
	je	.LBB80_28
.LBB80_25:                              # %if.then83
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.136, %esi
	jmp	.LBB80_26
.LBB80_28:                              # %if.end85
	testb	$2, %r14b
	je	.LBB80_30
# BB#29:                                # %if.then90
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.137, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, exit_code(%rip)
	movl	$-1, %ebx
	cmpl	$2, force(%rip)
	jl	.LBB80_133
.LBB80_30:                              # %if.end96
	testb	$-64, %r14b
	je	.LBB80_32
# BB#31:                                # %if.then101
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movzbl	%r14b, %r8d
	movl	$.L.str.138, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, exit_code(%rip)
	movl	$-1, %ebx
	cmpl	$2, force(%rip)
	jl	.LBB80_133
.LBB80_32:                              # %if.end108
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_34
# BB#33:                                # %cond.true111
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB80_35
.LBB80_106:                             # %if.then381
	movq	$unpack, work(%rip)
	movl	$2, method(%rip)
	cmpl	$0, method(%rip)
	jns	.LBB80_116
	jmp	.LBB80_117
.LBB80_108:                             # %if.then387
	movq	$unlzw, work(%rip)
	movl	$1, method(%rip)
	jmp	.LBB80_114
.LBB80_104:                             # %if.then370
	movl	$0, inptr(%rip)
	movq	$unzip, work(%rip)
	movl	%ebx, %edi
	callq	check_zipfile
	movl	$-1, %ebx
	testl	%eax, %eax
	jne	.LBB80_133
	jmp	.LBB80_114
.LBB80_110:                             # %if.then393
	movq	$unlzh, work(%rip)
	movl	$3, method(%rip)
.LBB80_114:                             # %if.end406
	movl	$1, last_member(%rip)
.LBB80_115:                             # %if.end406
	cmpl	$0, method(%rip)
	js	.LBB80_117
.LBB80_116:                             # %if.then409
	movl	method(%rip), %ebx
	jmp	.LBB80_133
.LBB80_34:                              # %cond.false116
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB80_35:                              # %cond.end118
	movslq	%eax, %rbx
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_37
# BB#36:                                # %cond.true123
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB80_38
.LBB80_37:                              # %cond.false128
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB80_38:                              # %cond.end130
	cltq
	shlq	$8, %rax
	orq	%rax, %rbx
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_40
# BB#39:                                # %cond.true135
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB80_41
.LBB80_40:                              # %cond.false140
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB80_41:                              # %cond.end142
	cltq
	shlq	$16, %rax
	orq	%rax, %rbx
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_43
# BB#42:                                # %cond.true149
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB80_44
.LBB80_43:                              # %cond.false154
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB80_44:                              # %cond.end156
	cltq
	shlq	$24, %rax
	orq	%rax, %rbx
	je	.LBB80_47
# BB#45:                                # %cond.end156
	movl	no_time(%rip), %eax
	testl	%eax, %eax
	jne	.LBB80_47
# BB#46:                                # %if.then165
	movq	%rbx, time_stamp(%rip)
.LBB80_47:                              # %if.end166
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_49
# BB#48:                                # %cond.true169
	movl	inptr(%rip), %eax
	incl	%eax
	movl	%eax, inptr(%rip)
	jmp	.LBB80_50
.LBB80_49:                              # %cond.false174
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB80_50:                              # %cond.end176
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_52
# BB#51:                                # %cond.true180
	movl	inptr(%rip), %eax
	incl	%eax
	movl	%eax, inptr(%rip)
	testb	$2, %r14b
	jne	.LBB80_54
	jmp	.LBB80_62
.LBB80_52:                              # %cond.false185
	xorl	%edi, %edi
	callq	fill_inbuf
	testb	$2, %r14b
	je	.LBB80_62
.LBB80_54:                              # %if.then193
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_56
# BB#55:                                # %cond.true196
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %ebx
	jmp	.LBB80_57
.LBB80_56:                              # %cond.false201
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, %ebx
.LBB80_57:                              # %cond.end203
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_59
# BB#58:                                # %cond.true207
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	cmpl	$0, verbose(%rip)
	jne	.LBB80_61
	jmp	.LBB80_62
.LBB80_59:                              # %cond.false212
	xorl	%edi, %edi
	callq	fill_inbuf
	cmpl	$0, verbose(%rip)
	je	.LBB80_62
.LBB80_61:                              # %if.then219
	shll	$8, %eax
	orl	%eax, %ebx
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.139, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	movl	%ebx, %r8d
	callq	fprintf
.LBB80_62:                              # %if.end222
	testb	$4, %r14b
	je	.LBB80_75
# BB#63:                                # %if.then227
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_65
# BB#64:                                # %cond.true230
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %ebx
	jmp	.LBB80_66
.LBB80_65:                              # %cond.false235
	xorl	%edi, %edi
	callq	fill_inbuf
	movl	%eax, %ebx
.LBB80_66:                              # %cond.end237
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_68
# BB#67:                                # %cond.true241
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB80_69
.LBB80_68:                              # %cond.false246
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB80_69:                              # %cond.end248
	shll	$8, %eax
	orl	%eax, %ebx
	cmpl	$0, verbose(%rip)
	je	.LBB80_71
# BB#70:                                # %if.then253
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.140, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	movl	%ebx, %r8d
	callq	fprintf
	testl	%ebx, %ebx
	jne	.LBB80_72
	jmp	.LBB80_75
	.p2align	4, 0x90
.LBB80_74:                              # %cond.false264
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB80_71:                              # %while.cond
	testl	%ebx, %ebx
	je	.LBB80_75
.LBB80_72:                              # %while.body
                                        # =>This Inner Loop Header: Depth=1
	decl	%ebx
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_74
# BB#73:                                # %cond.true259
                                        #   in Loop: Header=BB80_72 Depth=1
	incl	inptr(%rip)
	testl	%ebx, %ebx
	jne	.LBB80_72
.LBB80_75:                              # %if.end268
	testb	$8, %r14b
	je	.LBB80_94
# BB#76:                                # %if.then273
	cmpl	$0, no_name(%rip)
	je	.LBB80_77
	.p2align	4, 0x90
.LBB80_79:                              # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_81
# BB#80:                                # %cond.true285
                                        #   in Loop: Header=BB80_79 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB80_82
	.p2align	4, 0x90
.LBB80_81:                              # %cond.false290
                                        #   in Loop: Header=BB80_79 Depth=1
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB80_82:                              # %cond.end292
                                        #   in Loop: Header=BB80_79 Depth=1
	testb	%al, %al
	jne	.LBB80_79
.LBB80_94:                              # %if.end330
	testb	$16, %r14b
	je	.LBB80_99
	.p2align	4, 0x90
.LBB80_95:                              # %while.cond336
                                        # =>This Inner Loop Header: Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_97
# BB#96:                                # %cond.true339
                                        #   in Loop: Header=BB80_95 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	testl	%eax, %eax
	jne	.LBB80_95
	jmp	.LBB80_99
	.p2align	4, 0x90
.LBB80_97:                              # %cond.false344
                                        #   in Loop: Header=BB80_95 Depth=1
	xorl	%edi, %edi
	callq	fill_inbuf
	testl	%eax, %eax
	jne	.LBB80_95
.LBB80_99:                              # %if.end352
	cmpl	$1, part_nb(%rip)
	jne	.LBB80_115
# BB#100:                               # %if.then355
	movl	inptr(%rip), %eax
	addq	$16, %rax
	movq	%rax, header_bytes(%rip)
	cmpl	$0, method(%rip)
	jns	.LBB80_116
.LBB80_117:                             # %if.end410
	cmpl	$1, part_nb(%rip)
	jne	.LBB80_119
# BB#118:                               # %if.then413
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.146, %esi
.LBB80_26:                              # %return
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB80_27:                              # %return
	movl	$1, exit_code(%rip)
	movl	$-1, %ebx
.LBB80_133:                             # %return
	movl	%ebx, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB80_119:                             # %if.else415
	cmpb	$0, -42(%rbp)
	jne	.LBB80_128
	jmp	.LBB80_120
	.p2align	4, 0x90
.LBB80_127:                             # %cond.false431
                                        #   in Loop: Header=BB80_120 Depth=1
	movl	$1, %edi
	callq	fill_inbuf
	movl	%eax, %r15d
.LBB80_120:                             # %for.cond421
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB80_125 Depth 2
	testl	%r15d, %r15d
	jne	.LBB80_121
.LBB80_125:                             # %for.inc
                                        #   Parent Loop BB80_120 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_127
# BB#126:                               # %cond.true426
                                        #   in Loop: Header=BB80_125 Depth=2
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %r15d
	testl	%r15d, %r15d
	je	.LBB80_125
.LBB80_121:                             # %for.cond421
	cmpl	$-1, %r15d
	jne	.LBB80_128
# BB#122:                               # %if.then438
	movl	$-3, %ebx
	cmpl	$0, verbose(%rip)
	je	.LBB80_133
# BB#123:                               # %if.then440
	cmpl	$0, quiet(%rip)
	jne	.LBB80_131
# BB#124:                               # %if.then442
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.147, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	cmpl	$0, exit_code(%rip)
	jne	.LBB80_133
	jmp	.LBB80_132
.LBB80_128:                             # %if.end451
	cmpl	$0, quiet(%rip)
	jne	.LBB80_130
# BB#129:                               # %if.then453
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.148, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB80_130:                             # %if.end455
	movl	$-2, %ebx
.LBB80_131:                             # %if.end455
	cmpl	$0, exit_code(%rip)
	jne	.LBB80_133
.LBB80_132:                             # %if.then458
	movl	$2, exit_code(%rip)
	jmp	.LBB80_133
.LBB80_77:                              # %lor.lhs.false275
	cmpl	$0, to_stdout(%rip)
	setne	%al
	cmpl	$0, list(%rip)
	sete	%cl
	testb	%cl, %al
	jne	.LBB80_79
# BB#78:                                # %lor.lhs.false275
	cmpl	$2, part_nb(%rip)
	jge	.LBB80_79
# BB#83:                                # %if.else298
	movl	$ofname, %edi
	callq	base_name
	movq	%rax, %r12
	leaq	1(%r12), %rbx
	movl	$ofname+1024, %r13d
	jmp	.LBB80_84
	.p2align	4, 0x90
.LBB80_90:                              # %for.cond.backedge
                                        #   in Loop: Header=BB80_84 Depth=1
	incq	%rbx
.LBB80_84:                              # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jae	.LBB80_86
# BB#85:                                # %cond.true302
                                        #   in Loop: Header=BB80_84 Depth=1
	movl	inptr(%rip), %eax
	leal	1(%rax), %ecx
	movl	%ecx, inptr(%rip)
	movzbl	inbuf(%rax), %eax
	jmp	.LBB80_87
.LBB80_86:                              # %cond.false307
                                        #   in Loop: Header=BB80_84 Depth=1
	xorl	%edi, %edi
	callq	fill_inbuf
.LBB80_87:                              # %cond.end309
                                        #   in Loop: Header=BB80_84 Depth=1
	movb	%al, -1(%rbx)
	testb	%al, %al
	je	.LBB80_91
# BB#88:                                # %if.end316
                                        #   in Loop: Header=BB80_84 Depth=1
	cmpq	%r13, %rbx
	jb	.LBB80_90
# BB#89:                                # %if.then319
                                        #   in Loop: Header=BB80_84 Depth=1
	movl	$.L.str.141, %edi
	callq	error
	jmp	.LBB80_90
.LBB80_91:                              # %for.end
	movq	%r12, %rdi
	callq	base_name
	movq	%r12, %rdi
	movq	%rax, %rsi
	callq	strcpy
	cmpl	$0, list(%rip)
	jne	.LBB80_94
# BB#92:                                # %for.end
	testq	%r12, %r12
	je	.LBB80_94
# BB#93:                                # %if.then326
	movl	$0, list(%rip)
	testb	$16, %r14b
	jne	.LBB80_95
	jmp	.LBB80_99
.Lfunc_end80:
	.size	get_method, .Lfunc_end80-get_method
	.cfi_endproc

	.p2align	4, 0x90
	.type	input_eof,@function
input_eof:                              # @input_eof
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
	cmpl	$0, decompress(%rip)
	movl	$1, %ebx
	je	.LBB81_7
# BB#1:                                 # %entry
	movl	last_member(%rip), %eax
	testl	%eax, %eax
	jne	.LBB81_7
# BB#2:                                 # %if.end
	movl	inptr(%rip), %eax
	cmpl	insize(%rip), %eax
	jne	.LBB81_6
# BB#3:                                 # %if.then2
	cmpl	$32768, insize(%rip)    # imm = 0x8000
	jne	.LBB81_7
# BB#4:                                 # %lor.lhs.false4
	movl	$1, %ebx
	movl	$1, %edi
	callq	fill_inbuf
	cmpl	$-1, %eax
	je	.LBB81_7
# BB#5:                                 # %if.end7
	movl	$0, inptr(%rip)
.LBB81_6:                               # %return
	xorl	%ebx, %ebx
.LBB81_7:                               # %return
	movl	%ebx, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
.Lfunc_end81:
	.size	input_eof, .Lfunc_end81-input_eof
	.cfi_endproc

	.p2align	4, 0x90
	.type	get_istat,@function
get_istat:                              # @get_istat
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
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
.Lcfi402:
	.cfi_offset %rbx, -56
.Lcfi403:
	.cfi_offset %r12, -48
.Lcfi404:
	.cfi_offset %r13, -40
.Lcfi405:
	.cfi_offset %r14, -32
.Lcfi406:
	.cfi_offset %r15, -24
	movq	%rsi, %r14
	movq	%rdi, %r15
	movq	z_suffix(%rip), %rax
	movq	%rax, get_istat.suffixes(%rip)
	callq	strlen
	cmpq	$1022, %rax             # imm = 0x3FE
	jbe	.LBB82_1
.LBB82_15:                              # %name_too_long
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.160, %esi
	xorl	%eax, %eax
	movq	%r15, %rcx
	callq	fprintf
	movl	$1, exit_code(%rip)
	jmp	.LBB82_16
.LBB82_1:                               # %if.end
	movl	$ifname, %edi
	movq	%r15, %rsi
	callq	strcpy
	movl	$ifname, %edi
	movq	%r14, %rsi
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
	testq	%rax, %rax
	je	.LBB82_7
.LBB82_5:                               # %if.then8
	movl	$ifname, %edi
	callq	progerror
.LBB82_16:                              # %return
	movl	$1, %eax
.LBB82_17:                              # %return
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB82_2:
	xorl	%eax, %eax
	jmp	.LBB82_17
.LBB82_7:                               # %if.end13
	movl	$ifname, %edi
	callq	strlen
	movq	%rax, %rbx
	movq	z_suffix(%rip), %rdi
	movl	$.L.str.44, %esi
	callq	strcmp
	testl	%eax, %eax
	movl	$get_istat.suffixes, %eax
	movl	$get_istat.suffixes+8, %r13d
	cmovneq	%rax, %r13
	addq	$8, %r13
	movl	$0, -44(%rbp)           # 4-byte Folded Spill
	movslq	%ebx, %r12
	.p2align	4, 0x90
.LBB82_8:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movq	-8(%r13), %rbx
	movl	$ifname, %edi
	movq	%r15, %rsi
	callq	strcpy
	movq	%rbx, %rdi
	callq	strlen
	addq	%r12, %rax
	cmpq	$1023, %rax             # imm = 0x3FF
	ja	.LBB82_15
# BB#9:                                 # %if.end26
                                        #   in Loop: Header=BB82_8 Depth=1
	movl	$ifname, %edi
	movq	%rbx, %rsi
	callq	strcat
	movl	$ifname, %edi
	movq	%r14, %rsi
	callq	do_stat
	testl	%eax, %eax
	je	.LBB82_10
# BB#11:                                # %if.end32
                                        #   in Loop: Header=BB82_8 Depth=1
	movq	z_suffix(%rip), %rsi
	movq	%rbx, %rdi
	callq	strcmp
	testl	%eax, %eax
	jne	.LBB82_13
# BB#12:                                # %if.then36
                                        #   in Loop: Header=BB82_8 Depth=1
	callq	__errno_location
	movl	(%rax), %eax
	movl	%eax, -44(%rbp)         # 4-byte Spill
.LBB82_13:                              # %do.cond
                                        #   in Loop: Header=BB82_8 Depth=1
	cmpq	$0, (%r13)
	leaq	8(%r13), %r13
	jne	.LBB82_8
# BB#14:                                # %do.end
	movl	$ifname, %edi
	movq	%r15, %rsi
	callq	strcpy
	movq	z_suffix(%rip), %rsi
	movl	$ifname, %edi
	callq	strcat
	callq	__errno_location
	movl	-44(%rbp), %ecx         # 4-byte Reload
	movl	%ecx, (%rax)
	jmp	.LBB82_5
.LBB82_10:
	xorl	%eax, %eax
	jmp	.LBB82_17
.Lfunc_end82:
	.size	get_istat, .Lfunc_end82-get_istat
	.cfi_endproc

	.p2align	4, 0x90
	.type	treat_dir,@function
treat_dir:                              # @treat_dir
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi407:
	.cfi_def_cfa_offset 16
.Lcfi408:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi409:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$1032, %rsp             # imm = 0x408
.Lcfi410:
	.cfi_offset %rbx, -56
.Lcfi411:
	.cfi_offset %r12, -48
.Lcfi412:
	.cfi_offset %r13, -40
.Lcfi413:
	.cfi_offset %r14, -32
.Lcfi414:
	.cfi_offset %r15, -24
	movq	%rdi, %r14
	callq	opendir
	movq	%rax, %r12
	testq	%r12, %r12
	jne	.LBB83_1
	jmp	.LBB83_12
.LBB83_8:                               # %if.else
                                        #   in Loop: Header=BB83_1 Depth=1
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.168, %esi
	xorl	%eax, %eax
	movq	%r14, %rcx
	movq	%rbx, %r8
	callq	fprintf
	movl	$1, exit_code(%rip)
	.p2align	4, 0x90
.LBB83_1:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	callq	__errno_location
	movl	$0, (%rax)
	movq	%r12, %rdi
	callq	readdir
	movq	%rax, %rbx
	testq	%rbx, %rbx
	je	.LBB83_9
# BB#2:                                 # %while.body
                                        #   in Loop: Header=BB83_1 Depth=1
	addq	$19, %rbx
	movl	$.L.str.166, %esi
	movq	%rbx, %rdi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB83_1
# BB#3:                                 # %lor.lhs.false
                                        #   in Loop: Header=BB83_1 Depth=1
	movl	$.L.str.167, %esi
	movq	%rbx, %rdi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB83_1
# BB#4:                                 # %if.end11
                                        #   in Loop: Header=BB83_1 Depth=1
	movq	%r14, %rdi
	callq	strlen
	movq	%rax, %r13
	movslq	%r13d, %r15
	movq	%rbx, %rdi
	callq	strlen
	leaq	1(%r15,%rax), %rax
	cmpq	$1022, %rax             # imm = 0x3FE
	ja	.LBB83_8
# BB#5:                                 # %if.then20
                                        #   in Loop: Header=BB83_1 Depth=1
	leaq	-1072(%rbp), %rdi
	movq	%r14, %rsi
	callq	strcpy
	testl	%r13d, %r13d
	je	.LBB83_7
# BB#6:                                 # %if.then25
                                        #   in Loop: Header=BB83_1 Depth=1
	incl	%r13d
	movb	$47, -1072(%rbp,%r15)
.LBB83_7:                               # %if.end26
                                        #   in Loop: Header=BB83_1 Depth=1
	movslq	%r13d, %rax
	leaq	-1072(%rbp,%rax), %rdi
	movq	%rbx, %rsi
	callq	strcpy
	leaq	-1072(%rbp), %rdi
	callq	treat_file
	jmp	.LBB83_1
.LBB83_9:                               # %while.end
	callq	__errno_location
	cmpl	$0, (%rax)
	je	.LBB83_11
# BB#10:                                # %if.then39
	movq	%r14, %rdi
	callq	progerror
.LBB83_11:                              # %if.end40
	movq	%r12, %rdi
	callq	closedir
	testl	%eax, %eax
	je	.LBB83_13
.LBB83_12:                              # %if.then44
	movq	%r14, %rdi
	callq	progerror
.LBB83_13:                              # %if.end45
	addq	$1032, %rsp             # imm = 0x408
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
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
.Lcfi415:
	.cfi_def_cfa_offset 16
.Lcfi416:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi417:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$24, %rsp
.Lcfi418:
	.cfi_offset %rbx, -24
	movq	%rsi, %rbx
	movq	72(%rbx), %rax
	movq	%rax, -24(%rbp)
	movq	88(%rbx), %rax
	movq	%rax, -16(%rbp)
	leaq	-24(%rbp), %rsi
	callq	utime
	testl	%eax, %eax
	je	.LBB84_8
# BB#1:                                 # %land.lhs.true
	movl	$61440, %eax            # imm = 0xF000
	andl	24(%rbx), %eax
	cmpl	$16384, %eax            # imm = 0x4000
	je	.LBB84_8
# BB#2:                                 # %if.then
	callq	__errno_location
	movl	(%rax), %ebx
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
	callq	__errno_location
	movl	%ebx, (%rax)
	movl	$ofname, %edi
	callq	perror
.LBB84_8:                               # %if.end13
	addq	$24, %rsp
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
.Lcfi419:
	.cfi_def_cfa_offset 16
.Lcfi420:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi421:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi422:
	.cfi_offset %rbx, -24
	movl	$ofname, %edi
	movl	$ifname, %esi
	callq	strcpy
	movl	$ofname, %edi
	callq	get_suffix
	movq	%rax, %rbx
	cmpl	$0, decompress(%rip)
	je	.LBB85_5
# BB#1:                                 # %if.then
	testq	%rbx, %rbx
	je	.LBB85_10
# BB#2:                                 # %if.end21
	movq	%rbx, %rdi
	callq	strlwr
	movl	$.L.str.162, %esi
	movq	%rbx, %rdi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB85_9
# BB#3:                                 # %lor.lhs.false25
	movl	$.L.str.161, %esi
	movq	%rbx, %rdi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB85_9
# BB#4:                                 # %if.else
	movb	$0, (%rbx)
	jmp	.LBB85_23
.LBB85_5:                               # %if.else31
	testq	%rbx, %rbx
	je	.LBB85_16
# BB#6:                                 # %if.then33
	cmpl	$0, verbose(%rip)
	jne	.LBB85_8
# BB#7:                                 # %lor.lhs.false35
	movl	recursive(%rip), %ecx
	movl	$2, %eax
	orl	quiet(%rip), %ecx
	jne	.LBB85_24
.LBB85_8:                               # %if.then39
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.171, %esi
	movl	$ifname, %ecx
	xorl	%eax, %eax
	movq	%rbx, %r8
	callq	fprintf
	movl	$2, %eax
	jmp	.LBB85_24
.LBB85_9:                               # %if.then28
	movl	$.L.str.170, %esi
	movq	%rbx, %rdi
	callq	strcpy
	jmp	.LBB85_23
.LBB85_10:                              # %if.then2
	cmpl	$0, recursive(%rip)
	jne	.LBB85_12
# BB#11:                                # %land.lhs.true
	movl	list(%rip), %ecx
	xorl	%eax, %eax
	orl	test(%rip), %ecx
	jne	.LBB85_24
.LBB85_12:                              # %if.end
	cmpl	$0, verbose(%rip)
	jne	.LBB85_14
# BB#13:                                # %lor.lhs.false8
	movl	recursive(%rip), %ecx
	movl	$2, %eax
	orl	quiet(%rip), %ecx
	jne	.LBB85_24
.LBB85_14:                              # %if.then12
	cmpl	$0, quiet(%rip)
	jne	.LBB85_20
# BB#15:                                # %if.then14
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.169, %esi
	jmp	.LBB85_19
.LBB85_16:                              # %if.else42
	movl	$0, save_orig_name(%rip)
	movl	$ofname, %edi
	callq	strlen
	addq	z_len(%rip), %rax
	cmpq	$1023, %rax             # imm = 0x3FF
	jbe	.LBB85_22
# BB#17:                                # %name_too_long
	cmpl	$0, quiet(%rip)
	jne	.LBB85_20
# BB#18:                                # %if.then51
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.160, %esi
.LBB85_19:                              # %if.end53
	movl	$ifname, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB85_20:                              # %if.end53
	movl	$2, %eax
	cmpl	$0, exit_code(%rip)
	jne	.LBB85_24
# BB#21:                                # %if.then55
	movl	$2, exit_code(%rip)
	jmp	.LBB85_24
.LBB85_22:                              # %if.end46
	movq	z_suffix(%rip), %rsi
	movl	$ofname, %edi
	callq	strcat
.LBB85_23:                              # %return
	xorl	%eax, %eax
.LBB85_24:                              # %return
	addq	$8, %rsp
	popq	%rbx
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
.Lcfi423:
	.cfi_def_cfa_offset 16
.Lcfi424:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi425:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
	subq	$144, %rsp
.Lcfi426:
	.cfi_offset %rbx, -32
.Lcfi427:
	.cfi_offset %r14, -24
	leaq	-160(%rbp), %r14
	jmp	.LBB86_2
	.p2align	4, 0x90
.LBB86_1:                               # %if.end30
                                        #   in Loop: Header=BB86_2 Depth=1
	movl	ofd(%rip), %edi
	callq	close
	movl	$ofname, %edi
	callq	xunlink
	movl	$ofname, %edi
	callq	shorten_name
.LBB86_2:                               # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	callq	check_ofname
	testl	%eax, %eax
	jne	.LBB86_12
# BB#3:                                 # %if.end4
                                        #   in Loop: Header=BB86_2 Depth=1
	movl	$1, remove_ofname(%rip)
	movl	$ofname, %edi
	movl	$193, %esi
	movl	$384, %edx              # imm = 0x180
	xorl	%eax, %eax
	callq	open
	movl	%eax, ofd(%rip)
	cmpl	$-1, %eax
	je	.LBB86_11
# BB#4:                                 # %if.end9
                                        #   in Loop: Header=BB86_2 Depth=1
	movl	ofd(%rip), %edi
	movq	%r14, %rsi
	callq	fstat
	movl	$ofname, %edi
	testl	%eax, %eax
	jne	.LBB86_13
# BB#5:                                 # %if.end16
                                        #   in Loop: Header=BB86_2 Depth=1
	movq	%r14, %rsi
	callq	name_too_long
	xorl	%ebx, %ebx
	testl	%eax, %eax
	je	.LBB86_15
# BB#6:                                 # %if.end20
                                        #   in Loop: Header=BB86_2 Depth=1
	cmpl	$0, decompress(%rip)
	je	.LBB86_1
# BB#7:                                 # %if.then22
	cmpl	$0, quiet(%rip)
	jne	.LBB86_9
# BB#8:                                 # %if.then24
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	movl	$.L.str.172, %esi
	movl	$ofname, %ecx
	xorl	%eax, %eax
	callq	fprintf
.LBB86_9:                               # %if.end26
	cmpl	$0, exit_code(%rip)
	jne	.LBB86_15
# BB#10:                                # %if.then28
	movl	$2, exit_code(%rip)
	jmp	.LBB86_15
.LBB86_11:                              # %if.then7
	movl	$ofname, %edi
	callq	progerror
.LBB86_12:                              # %if.then2
	movl	ifd(%rip), %edi
	callq	close
	jmp	.LBB86_14
.LBB86_13:                              # %if.then12
	callq	progerror
	movl	ifd(%rip), %edi
	callq	close
	movl	ofd(%rip), %edi
	callq	close
	movl	$ofname, %edi
	callq	xunlink
.LBB86_14:                              # %return
	movl	$1, %ebx
.LBB86_15:                              # %return
	movl	%ebx, %eax
	addq	$144, %rsp
	popq	%rbx
	popq	%r14
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
.Lcfi428:
	.cfi_def_cfa_offset 16
.Lcfi429:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi430:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi431:
	.cfi_offset %rbx, -32
.Lcfi432:
	.cfi_offset %r14, -24
	movq	%rdi, %rbx
	cmpl	$0, decompress(%rip)
	je	.LBB87_5
# BB#1:                                 # %entry
	movq	time_stamp(%rip), %rax
	testq	%rax, %rax
	je	.LBB87_5
# BB#2:                                 # %land.lhs.true1
	movq	88(%rbx), %rax
	cmpq	time_stamp(%rip), %rax
	je	.LBB87_5
# BB#3:                                 # %if.then
	movq	time_stamp(%rip), %rax
	movq	%rax, 88(%rbx)
	cmpl	$2, verbose(%rip)
	jl	.LBB87_5
# BB#4:                                 # %if.then6
	movq	stderr(%rip), %rdi
	movl	$.L.str.181, %esi
	movl	$ofname, %edx
	xorl	%eax, %eax
	callq	fprintf
.LBB87_5:                               # %if.end7
	movl	$ofname, %edi
	movq	%rbx, %rsi
	callq	reset_times
	movl	ofd(%rip), %edi
	movl	$4095, %esi             # imm = 0xFFF
	andl	24(%rbx), %esi
	callq	fchmod
	testl	%eax, %eax
	je	.LBB87_12
# BB#6:                                 # %if.then10
	callq	__errno_location
	movl	(%rax), %r14d
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
	callq	__errno_location
	movl	%r14d, (%rax)
	movl	$ofname, %edi
	callq	perror
.LBB87_12:                              # %if.end23
	movl	ofd(%rip), %edi
	movl	28(%rbx), %esi
	movl	32(%rbx), %edx
	callq	fchown
	movl	$0, remove_ofname(%rip)
	movl	$ifname, %edi
	callq	xunlink
	testl	%eax, %eax
	je	.LBB87_19
# BB#13:                                # %if.then27
	callq	__errno_location
	movl	(%rax), %ebx
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
	callq	__errno_location
	movl	%ebx, (%rax)
	movl	$ifname, %edi
	callq	perror
.LBB87_19:                              # %if.end41
	popq	%rbx
	popq	%r14
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
.Lcfi433:
	.cfi_def_cfa_offset 16
.Lcfi434:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi435:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi436:
	.cfi_offset %rbx, -32
.Lcfi437:
	.cfi_offset %r14, -24
	movq	%rsi, %r14
	movq	%rdi, %rbx
	callq	__errno_location
	movl	$0, (%rax)
	movl	to_stdout(%rip), %eax
	orl	force(%rip), %eax
	je	.LBB88_1
# BB#2:                                 # %if.end
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	stat
	jmp	.LBB88_3
.LBB88_1:                               # %if.then
	movq	%rbx, %rdi
	movq	%r14, %rsi
	callq	lstat
.LBB88_3:                               # %return
	popq	%rbx
	popq	%r14
	popq	%rbp
	retq
.Lfunc_end88:
	.size	do_stat, .Lfunc_end88-do_stat
	.cfi_endproc

	.p2align	4, 0x90
	.type	get_suffix,@function
get_suffix:                             # @get_suffix
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi438:
	.cfi_def_cfa_offset 16
.Lcfi439:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi440:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$56, %rsp
.Lcfi441:
	.cfi_offset %rbx, -56
.Lcfi442:
	.cfi_offset %r12, -48
.Lcfi443:
	.cfi_offset %r13, -40
.Lcfi444:
	.cfi_offset %r14, -32
.Lcfi445:
	.cfi_offset %r15, -24
	movq	%rdi, %r15
	movq	z_suffix(%rip), %rax
	movq	%rax, get_suffix.known_suffixes(%rip)
	movl	$get_suffix.known_suffixes, %r14d
	movq	z_suffix(%rip), %rdi
	movl	$.L.str.165, %esi
	callq	strcmp
	testl	%eax, %eax
	movl	$get_suffix.known_suffixes+8, %ebx
	cmovneq	%r14, %rbx
	movq	%r15, %rdi
	callq	strlen
	cmpl	$32, %eax
	movq	%rax, -48(%rbp)         # 8-byte Spill
	jg	.LBB89_2
# BB#1:                                 # %if.then4
	leaq	-96(%rbp), %rdi
	movq	%r15, %rsi
	jmp	.LBB89_3
.LBB89_2:                               # %if.else
	cltq
	leaq	-32(%r15,%rax), %rsi
	leaq	-96(%rbp), %rdi
.LBB89_3:                               # %if.end10
	callq	strcpy
	leaq	-96(%rbp), %r12
	movq	%r12, %rdi
	callq	strlwr
	movq	%r12, %rdi
	callq	strlen
	movq	%rax, %r12
	movslq	%r12d, %rax
	leaq	-96(%rbp,%rax), %r13
	.p2align	4, 0x90
.LBB89_4:                               # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movq	(%rbx), %rdi
	callq	strlen
	movl	%r12d, %ecx
	subl	%eax, %ecx
	jle	.LBB89_8
# BB#5:                                 # %land.lhs.true
                                        #   in Loop: Header=BB89_4 Depth=1
	movslq	%ecx, %rcx
	cmpb	$47, -97(%rbp,%rcx)
	je	.LBB89_8
# BB#6:                                 # %land.lhs.true24
                                        #   in Loop: Header=BB89_4 Depth=1
	movslq	%eax, %r14
	movq	%r13, %rdi
	subq	%r14, %rdi
	movq	(%rbx), %rsi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB89_7
.LBB89_8:                               # %do.cond
                                        #   in Loop: Header=BB89_4 Depth=1
	cmpq	$0, 8(%rbx)
	leaq	8(%rbx), %rbx
	jne	.LBB89_4
# BB#9:
	xorl	%r15d, %r15d
	jmp	.LBB89_10
.LBB89_7:                               # %if.then33
	movslq	-48(%rbp), %rax         # 4-byte Folded Reload
	addq	%rax, %r15
	subq	%r14, %r15
.LBB89_10:                              # %return
	movq	%r15, %rax
	addq	$56, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
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
.Lcfi446:
	.cfi_def_cfa_offset 16
.Lcfi447:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi448:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	subq	$152, %rsp
.Lcfi449:
	.cfi_offset %rbx, -24
	callq	__errno_location
	movl	$0, (%rax)
	leaq	-152(%rbp), %rbx
	jmp	.LBB90_1
	.p2align	4, 0x90
.LBB90_4:                               # %if.end
                                        #   in Loop: Header=BB90_1 Depth=1
	movl	$ofname, %edi
	callq	shorten_name
.LBB90_1:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	$ofname, %edi
	movq	%rbx, %rsi
	callq	lstat
	testl	%eax, %eax
	je	.LBB90_5
# BB#2:                                 # %while.body
                                        #   in Loop: Header=BB90_1 Depth=1
	callq	__errno_location
	cmpl	$36, (%rax)
	je	.LBB90_4
# BB#3:
	xorl	%eax, %eax
	jmp	.LBB90_24
.LBB90_5:                               # %while.end
	cmpl	$0, decompress(%rip)
	je	.LBB90_6
.LBB90_8:                               # %if.end11
	leaq	-152(%rbp), %rsi
	movl	$istat, %edi
	callq	same_file
	testl	%eax, %eax
	je	.LBB90_13
# BB#9:                                 # %if.then14
	movl	$ifname, %edi
	movl	$ofname, %esi
	callq	strcmp
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	testl	%eax, %eax
	je	.LBB90_10
# BB#11:                                # %if.else
	movl	$.L.str.174, %esi
	movl	$ifname, %ecx
	movl	$ofname, %r8d
	jmp	.LBB90_12
.LBB90_6:                               # %land.lhs.true
	leaq	-152(%rbp), %rsi
	movl	$ofname, %edi
	callq	name_too_long
	testl	%eax, %eax
	je	.LBB90_8
# BB#7:                                 # %if.then6
	movl	$ofname, %edi
	callq	shorten_name
	leaq	-152(%rbp), %rsi
	movl	$ofname, %edi
	callq	lstat
	movl	%eax, %ecx
	xorl	%eax, %eax
	testl	%ecx, %ecx
	jne	.LBB90_24
	jmp	.LBB90_8
.LBB90_13:                              # %if.end22
	cmpl	$0, force(%rip)
	jne	.LBB90_20
# BB#14:                                # %if.then24
	movq	stderr(%rip), %rdi
	movq	progname(%rip), %rdx
	xorl	%ebx, %ebx
	movl	$.L.str.175, %esi
	movl	$ofname, %ecx
	xorl	%eax, %eax
	callq	fprintf
	cmpl	$0, foreground(%rip)
	je	.LBB90_17
# BB#15:                                # %land.lhs.true27
	movq	stdin(%rip), %rdi
	callq	fileno
	movl	%eax, %edi
	callq	isatty
	testl	%eax, %eax
	je	.LBB90_17
# BB#16:                                # %if.then31
	movq	stderr(%rip), %rdi
	movl	$.L.str.176, %esi
	xorl	%eax, %eax
	callq	fprintf
	movq	stderr(%rip), %rdi
	callq	fflush
	callq	yesno
	movl	%eax, %ebx
.LBB90_17:                              # %if.end35
	testl	%ebx, %ebx
	je	.LBB90_18
.LBB90_20:                              # %if.end43
	movl	$ofname, %edi
	callq	xunlink
	testl	%eax, %eax
	je	.LBB90_21
# BB#22:                                # %if.then46
	movl	$ofname, %edi
	callq	progerror
	jmp	.LBB90_23
.LBB90_10:                              # %if.then17
	cmpl	$0, decompress(%rip)
	movl	$.L.str.128, %eax
	movl	$.L.str.8, %r8d
	cmovneq	%rax, %r8
	movl	$.L.str.173, %esi
	movl	$ifname, %ecx
.LBB90_12:                              # %if.end21
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, exit_code(%rip)
.LBB90_23:                              # %return
	movl	$1, %eax
.LBB90_24:                              # %return
	addq	$152, %rsp
	popq	%rbx
	popq	%rbp
	retq
.LBB90_21:
	xorl	%eax, %eax
	jmp	.LBB90_24
.LBB90_18:                              # %if.then37
	movq	stderr(%rip), %rdi
	movl	$.L.str.177, %esi
	xorl	%eax, %eax
	callq	fprintf
	movl	$1, %eax
	cmpl	$0, exit_code(%rip)
	jne	.LBB90_24
# BB#19:                                # %if.then40
	movl	$2, exit_code(%rip)
	jmp	.LBB90_24
.Lfunc_end90:
	.size	check_ofname, .Lfunc_end90-check_ofname
	.cfi_endproc

	.p2align	4, 0x90
	.type	name_too_long,@function
name_too_long:                          # @name_too_long
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi450:
	.cfi_def_cfa_offset 16
.Lcfi451:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi452:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$152, %rsp
.Lcfi453:
	.cfi_offset %rbx, -56
.Lcfi454:
	.cfi_offset %r12, -48
.Lcfi455:
	.cfi_offset %r13, -40
.Lcfi456:
	.cfi_offset %r14, -32
.Lcfi457:
	.cfi_offset %r15, -24
	movq	%rsi, %r14
	movq	%rdi, %rbx
	callq	strlen
	movslq	%eax, %r12
	movb	-1(%rbx,%r12), %r13b
	leaq	-184(%rbp), %r15
	movl	$144, %edx
	movq	%r15, %rdi
	movq	%r14, %rsi
	callq	memcpy
	movb	$0, -1(%rbx,%r12)
	movq	%rbx, %rdi
	movq	%r15, %rsi
	callq	lstat
	testl	%eax, %eax
	je	.LBB91_2
# BB#1:
	xorl	%eax, %eax
	jmp	.LBB91_3
.LBB91_2:                               # %land.rhs
	leaq	-184(%rbp), %rsi
	movq	%r14, %rdi
	callq	same_file
	testl	%eax, %eax
	setne	%al
.LBB91_3:                               # %land.end
	movzbl	%al, %eax
	movb	%r13b, -1(%rbx,%r12)
	addq	$152, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
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
.Lcfi458:
	.cfi_def_cfa_offset 16
.Lcfi459:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi460:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
.Lcfi461:
	.cfi_offset %rbx, -48
.Lcfi462:
	.cfi_offset %r12, -40
.Lcfi463:
	.cfi_offset %r14, -32
.Lcfi464:
	.cfi_offset %r15, -24
	movq	%rdi, %r14
	callq	strlen
	movq	%rax, %rbx
	cmpl	$0, decompress(%rip)
	je	.LBB92_4
# BB#1:                                 # %if.then
	cmpl	$1, %ebx
	jg	.LBB92_3
# BB#2:                                 # %if.then2
	movl	$.L.str.178, %edi
	callq	error
.LBB92_3:                               # %if.end
	movslq	%ebx, %rax
	movb	$0, -1(%r14,%rax)
	jmp	.LBB92_22
.LBB92_4:                               # %if.end3
	movq	%r14, %rdi
	callq	get_suffix
	movq	%rax, %r15
	testq	%r15, %r15
	jne	.LBB92_6
# BB#5:                                 # %if.then7
	movl	$.L.str.179, %edi
	callq	error
.LBB92_6:                               # %if.end8
	movb	$0, (%r15)
	movl	$1, save_orig_name(%rip)
	cmpl	$4, %ebx
	jle	.LBB92_7
# BB#11:                                # %land.lhs.true
	addq	$-4, %r15
	movl	$.L.str.170, %esi
	movq	%r15, %rdi
	callq	strcmp
	testl	%eax, %eax
	je	.LBB92_12
.LBB92_7:                               # %do.body.preheader
	movl	$3, %r12d
	xorl	%r15d, %r15d
	.p2align	4, 0x90
.LBB92_8:                               # %do.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB92_10 Depth 2
	movl	$47, %esi
	movq	%r14, %rdi
	callq	strrchr
	testq	%rax, %rax
	leaq	1(%rax), %rbx
	cmoveq	%r14, %rbx
	cmpb	$0, (%rbx)
	je	.LBB92_13
	.p2align	4, 0x90
.LBB92_10:                              # %while.body
                                        #   Parent Loop BB92_8 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movl	$.L.str.166, %esi
	movq	%rbx, %rdi
	callq	strcspn
	cltq
	leaq	(%rbx,%rax), %rcx
	cmpl	%r12d, %eax
	leaq	-1(%rbx,%rax), %rdx
	cmovgq	%rdx, %r15
	cmpb	$0, (%rbx,%rax)
	leaq	1(%rbx,%rax), %rbx
	cmoveq	%rcx, %rbx
	cmpb	$0, (%rbx)
	jne	.LBB92_10
.LBB92_13:                              # %do.cond
                                        #   in Loop: Header=BB92_8 Depth=1
	movl	%r12d, %eax
	decl	%eax
	setne	%cl
	testq	%r15, %r15
	sete	%dl
	cmovel	%eax, %r12d
	testb	%cl, %dl
	jne	.LBB92_8
# BB#14:                                # %do.end
	testq	%r15, %r15
	je	.LBB92_17
# BB#15:                                # %do.body40.preheader
	decq	%r15
	.p2align	4, 0x90
.LBB92_16:                              # %do.body40
                                        # =>This Inner Loop Header: Depth=1
	movzbl	2(%r15), %eax
	movb	%al, 1(%r15)
	incq	%r15
	testb	%al, %al
	jne	.LBB92_16
	jmp	.LBB92_20
.LBB92_17:                              # %if.else
	movl	$46, %esi
	movq	%r14, %rdi
	callq	strrchr
	movq	%rax, %rbx
	testq	%rbx, %rbx
	jne	.LBB92_19
# BB#18:                                # %if.then52
	movl	$.L.str.180, %edi
	callq	error
.LBB92_19:                              # %if.end53
	leaq	-1(%rbx), %r15
	cmpb	$0, 1(%rbx)
	cmovneq	%rbx, %r15
.LBB92_20:                              # %if.end61
	movq	z_suffix(%rip), %rsi
.LBB92_21:                              # %return
	movq	%r15, %rdi
	callq	strcpy
.LBB92_22:                              # %return
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	retq
.LBB92_12:                              # %if.then14
	movl	$.L.str.162, %esi
	jmp	.LBB92_21
.Lfunc_end92:
	.size	shorten_name, .Lfunc_end92-shorten_name
	.cfi_endproc

	.p2align	4, 0x90
	.type	same_file,@function
same_file:                              # @same_file
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi465:
	.cfi_def_cfa_offset 16
.Lcfi466:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi467:
	.cfi_def_cfa_register %rbp
	movq	8(%rdi), %rax
	cmpq	8(%rsi), %rax
	jne	.LBB93_1
# BB#2:                                 # %land.rhs
	movq	(%rdi), %rax
	cmpq	(%rsi), %rax
	sete	%al
	jmp	.LBB93_3
.LBB93_1:
	xorl	%eax, %eax
.LBB93_3:                               # %land.end
	movzbl	%al, %eax
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
.Lcfi468:
	.cfi_def_cfa_offset 16
.Lcfi469:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi470:
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
.Lcfi471:
	.cfi_def_cfa_offset 16
.Lcfi472:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi473:
	.cfi_def_cfa_register %rbp
                                        # kill: %ESI<def> %ESI<kill> %RSI<def>
	movslq	%esi, %rax
	movl	heap(,%rax,4), %r8d
	movslq	%r8d, %r9
	jmp	.LBB95_1
	.p2align	4, 0x90
.LBB95_10:                              # %if.end87
                                        #   in Loop: Header=BB95_1 Depth=1
	movl	heap(,%rax,4), %eax
	movslq	%esi, %rcx
	movl	%eax, heap(,%rcx,4)
	movl	%edx, %esi
.LBB95_1:                               # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	leal	(%rsi,%rsi), %edx
	cmpl	heap_len(%rip), %edx
	jg	.LBB95_11
# BB#2:                                 # %while.body
                                        #   in Loop: Header=BB95_1 Depth=1
	cmpl	heap_len(%rip), %edx
	jge	.LBB95_7
# BB#3:                                 # %land.lhs.true
                                        #   in Loop: Header=BB95_1 Depth=1
	movslq	%edx, %rax
	movslq	heap+4(,%rax,4), %rcx
	movzwl	(%rdi,%rcx,4), %r10d
	movslq	heap(,%rax,4), %rcx
	movzwl	(%rdi,%rcx,4), %ecx
	cmpl	%ecx, %r10d
	jge	.LBB95_4
.LBB95_6:                               # %if.then
                                        #   in Loop: Header=BB95_1 Depth=1
	incl	%edx
	jmp	.LBB95_7
	.p2align	4, 0x90
.LBB95_4:                               # %lor.lhs.false
                                        #   in Loop: Header=BB95_1 Depth=1
	movslq	heap+4(,%rax,4), %rcx
	movzwl	(%rdi,%rcx,4), %r10d
	movslq	heap(,%rax,4), %rcx
	movzwl	(%rdi,%rcx,4), %ecx
	cmpl	%ecx, %r10d
	jne	.LBB95_7
# BB#5:                                 # %land.lhs.true32
                                        #   in Loop: Header=BB95_1 Depth=1
	movslq	heap+4(,%rax,4), %rcx
	movzbl	depth(%rcx), %ecx
	movslq	heap(,%rax,4), %rax
	movzbl	depth(%rax), %eax
	cmpl	%eax, %ecx
	jle	.LBB95_6
	.p2align	4, 0x90
.LBB95_7:                               # %if.end
                                        #   in Loop: Header=BB95_1 Depth=1
	movzwl	(%rdi,%r9,4), %r10d
	movslq	%edx, %rax
	movslq	heap(,%rax,4), %rcx
	movzwl	(%rdi,%rcx,4), %ecx
	cmpl	%ecx, %r10d
	jl	.LBB95_11
# BB#8:                                 # %lor.lhs.false60
                                        #   in Loop: Header=BB95_1 Depth=1
	movzwl	(%rdi,%r9,4), %r10d
	movslq	heap(,%rax,4), %rcx
	movzwl	(%rdi,%rcx,4), %ecx
	cmpl	%ecx, %r10d
	jne	.LBB95_10
# BB#9:                                 # %land.lhs.true75
                                        #   in Loop: Header=BB95_1 Depth=1
	movzbl	depth(%r9), %r10d
	movslq	heap(,%rax,4), %rcx
	movzbl	depth(%rcx), %ecx
	cmpl	%ecx, %r10d
	jg	.LBB95_10
.LBB95_11:                              # %while.end
	movslq	%esi, %rax
	movl	%r8d, heap(,%rax,4)
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
.Lcfi474:
	.cfi_def_cfa_offset 16
.Lcfi475:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi476:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
.Lcfi477:
	.cfi_offset %rbx, -48
.Lcfi478:
	.cfi_offset %r12, -40
.Lcfi479:
	.cfi_offset %r14, -32
.Lcfi480:
	.cfi_offset %r15, -24
	movq	(%rdi), %r14
	movq	8(%rdi), %r9
	movq	16(%rdi), %r10
	movl	24(%rdi), %r11d
	movl	36(%rdi), %ecx
	movl	32(%rdi), %r15d
	movslq	%r15d, %r8
	xorl	%eax, %eax
	cmpl	$15, %eax
	jg	.LBB96_3
	.p2align	4, 0x90
.LBB96_2:                               # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movw	$0, bl_count(%rax,%rax)
	incq	%rax
	cmpl	$15, %eax
	jle	.LBB96_2
.LBB96_3:                               # %for.end
	movslq	heap_max(%rip), %rax
	movslq	heap(,%rax,4), %rax
	movw	$0, 2(%r14,%rax,4)
	movl	heap_max(%rip), %eax
	incl	%eax
	movslq	%eax, %rsi
	xorl	%edi, %edi
	cmpl	$572, %esi              # imm = 0x23C
	jle	.LBB96_5
	jmp	.LBB96_11
	.p2align	4, 0x90
.LBB96_9:                               # %for.cond7.backedge
                                        #   in Loop: Header=BB96_5 Depth=1
	incq	%rsi
	cmpl	$572, %esi              # imm = 0x23C
	jg	.LBB96_11
.LBB96_5:                               # %for.body9
                                        # =>This Inner Loop Header: Depth=1
	movslq	heap(,%rsi,4), %rbx
	movzwl	2(%r14,%rbx,4), %eax
	movzwl	2(%r14,%rax,4), %eax
	incl	%eax
	leal	1(%rdi), %edx
	cmpl	%r15d, %eax
	cmovgl	%r15d, %eax
	cmovgl	%edx, %edi
	movw	%ax, 2(%r14,%rbx,4)
	cmpl	%ecx, %ebx
	jg	.LBB96_9
# BB#6:                                 # %if.end31
                                        #   in Loop: Header=BB96_5 Depth=1
	movslq	%eax, %rdx
	incw	bl_count(%rdx,%rdx)
	xorl	%r12d, %r12d
	cmpl	%r11d, %ebx
	jl	.LBB96_8
# BB#7:                                 # %if.then37
                                        #   in Loop: Header=BB96_5 Depth=1
	movl	%ebx, %edx
	subl	%r11d, %edx
	movslq	%edx, %rdx
	movl	(%r10,%rdx,4), %r12d
.LBB96_8:                               # %if.end40
                                        #   in Loop: Header=BB96_5 Depth=1
	movzwl	(%r14,%rbx,4), %edx
	addl	%r12d, %eax
	cltq
	imulq	%rdx, %rax
	addq	%rax, opt_len(%rip)
	testq	%r9, %r9
	je	.LBB96_9
# BB#10:                                # %if.then47
                                        #   in Loop: Header=BB96_5 Depth=1
	movzwl	2(%r9,%rbx,4), %eax
	movslq	%r12d, %rbx
	addq	%rax, %rbx
	imulq	%rbx, %rdx
	addq	%rdx, static_len(%rip)
	incq	%rsi
	cmpl	$572, %esi              # imm = 0x23C
	jle	.LBB96_5
.LBB96_11:                              # %for.end61
	testl	%edi, %edi
	je	.LBB96_25
# BB#12:                                # %do.body.preheader
	leal	-1(%r15), %eax
	cltq
	leaq	bl_count(%rax,%rax), %rax
	.p2align	4, 0x90
.LBB96_13:                              # %do.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB96_15 Depth 2
	movq	%rax, %rdx
	movl	%r15d, %ebx
	cmpw	$0, (%rdx)
	jne	.LBB96_16
	.p2align	4, 0x90
.LBB96_15:                              # %while.body
                                        #   Parent Loop BB96_13 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	decl	%ebx
	addq	$-2, %rdx
	cmpw	$0, (%rdx)
	je	.LBB96_15
.LBB96_16:                              # %while.end
                                        #   in Loop: Header=BB96_13 Depth=1
	decw	(%rdx)
	movslq	%ebx, %rdx
	movzwl	bl_count(%rdx,%rdx), %ebx
	addl	$2, %ebx
	movw	%bx, bl_count(%rdx,%rdx)
	decw	bl_count(%r8,%r8)
	addl	$-2, %edi
	testl	%edi, %edi
	jg	.LBB96_13
	jmp	.LBB96_17
	.p2align	4, 0x90
.LBB96_24:                              # %for.inc135
                                        #   in Loop: Header=BB96_17 Depth=1
	decl	%r15d
.LBB96_17:                              # %for.cond87
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB96_20 Depth 2
	testl	%r15d, %r15d
	je	.LBB96_25
# BB#18:                                # %for.body90
                                        #   in Loop: Header=BB96_17 Depth=1
	movslq	%r15d, %r8
	movzwl	bl_count(%r8,%r8), %ebx
	testl	%ebx, %ebx
	jne	.LBB96_20
	jmp	.LBB96_24
.LBB96_23:                              # %if.end132
                                        #   in Loop: Header=BB96_20 Depth=2
	decl	%ebx
	.p2align	4, 0x90
.LBB96_19:                              # %while.cond94
                                        #   in Loop: Header=BB96_20 Depth=2
	testl	%ebx, %ebx
	je	.LBB96_24
.LBB96_20:                              # %while.body97
                                        #   Parent Loop BB96_17 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%esi, %rax
	decl	%esi
	movslq	heap-4(,%rax,4), %rax
	cmpl	%ecx, %eax
	jg	.LBB96_19
# BB#21:                                # %if.end104
                                        #   in Loop: Header=BB96_20 Depth=2
	movzwl	2(%r14,%rax,4), %edx
	cmpl	%r15d, %edx
	je	.LBB96_23
# BB#22:                                # %if.then112
                                        #   in Loop: Header=BB96_20 Depth=2
	movzwl	2(%r14,%rax,4), %edx
	movq	%r8, %rdi
	subq	%rdx, %rdi
	movzwl	(%r14,%rax,4), %edx
	imulq	%rdi, %rdx
	addq	%rdx, opt_len(%rip)
	movw	%r15w, 2(%r14,%rax,4)
	jmp	.LBB96_23
.LBB96_25:                              # %for.end137
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
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
.Lcfi481:
	.cfi_def_cfa_offset 16
.Lcfi482:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi483:
	.cfi_def_cfa_register %rbp
	movzwl	2(%rdi), %ecx
	xorl	%r8d, %r8d
	testl	%ecx, %ecx
	setne	%r8b
	movl	$138, %eax
	movl	$7, %r10d
	cmovel	%eax, %r10d
	addl	$3, %r8d
	movslq	%esi, %rax
	movw	$-1, 6(%rdi,%rax,4)
	movl	$-1, %r11d
	xorl	%edx, %edx
	movl	$1, %r9d
	jmp	.LBB97_1
	.p2align	4, 0x90
.LBB97_17:                              # %for.inc
                                        #   in Loop: Header=BB97_1 Depth=1
	movl	%ecx, %r11d
	incl	%r9d
	movl	%eax, %ecx
.LBB97_1:                               # %for.cond
                                        # =>This Inner Loop Header: Depth=1
	leal	-1(%r9), %eax
	cmpl	%esi, %eax
	jg	.LBB97_18
# BB#2:                                 # %for.body
                                        #   in Loop: Header=BB97_1 Depth=1
	movslq	%r9d, %rax
	movzwl	2(%rdi,%rax,4), %eax
	incl	%edx
	cmpl	%r10d, %edx
	jge	.LBB97_5
# BB#3:                                 # %for.body
                                        #   in Loop: Header=BB97_1 Depth=1
	cmpl	%eax, %ecx
	jne	.LBB97_5
# BB#4:                                 #   in Loop: Header=BB97_1 Depth=1
	movl	%r11d, %ecx
	jmp	.LBB97_17
	.p2align	4, 0x90
.LBB97_5:                               # %if.else
                                        #   in Loop: Header=BB97_1 Depth=1
	cmpl	%r8d, %edx
	jge	.LBB97_7
# BB#6:                                 # %if.then20
                                        #   in Loop: Header=BB97_1 Depth=1
	movslq	%ecx, %r8
	addl	bl_tree(,%r8,4), %edx
	movw	%dx, bl_tree(,%r8,4)
	jmp	.LBB97_14
	.p2align	4, 0x90
.LBB97_7:                               # %if.else26
                                        #   in Loop: Header=BB97_1 Depth=1
	testl	%ecx, %ecx
	je	.LBB97_11
# BB#8:                                 # %if.then29
                                        #   in Loop: Header=BB97_1 Depth=1
	cmpl	%r11d, %ecx
	je	.LBB97_10
# BB#9:                                 # %if.then32
                                        #   in Loop: Header=BB97_1 Depth=1
	movslq	%ecx, %rdx
	incw	bl_tree(,%rdx,4)
.LBB97_10:                              # %if.end38
                                        #   in Loop: Header=BB97_1 Depth=1
	incw	bl_tree+64(%rip)
	jmp	.LBB97_14
.LBB97_11:                              # %if.else40
                                        #   in Loop: Header=BB97_1 Depth=1
	cmpl	$10, %edx
	jg	.LBB97_13
# BB#12:                                # %if.then43
                                        #   in Loop: Header=BB97_1 Depth=1
	incw	bl_tree+68(%rip)
	jmp	.LBB97_14
.LBB97_13:                              # %if.else45
                                        #   in Loop: Header=BB97_1 Depth=1
	incw	bl_tree+72(%rip)
	.p2align	4, 0x90
.LBB97_14:                              # %if.end50
                                        #   in Loop: Header=BB97_1 Depth=1
	xorl	%edx, %edx
	testl	%eax, %eax
	je	.LBB97_15
# BB#16:                                # %if.else54
                                        #   in Loop: Header=BB97_1 Depth=1
	xorl	%r8d, %r8d
	cmpl	%eax, %ecx
	setne	%r8b
	leal	6(%r8), %r10d
	addl	$3, %r8d
	jmp	.LBB97_17
.LBB97_15:                              #   in Loop: Header=BB97_1 Depth=1
	movl	$3, %r8d
	movl	$138, %r10d
	jmp	.LBB97_17
.LBB97_18:                              # %for.end
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
.Lcfi484:
	.cfi_def_cfa_offset 16
.Lcfi485:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi486:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$24, %rsp
.Lcfi487:
	.cfi_offset %rbx, -56
.Lcfi488:
	.cfi_offset %r12, -48
.Lcfi489:
	.cfi_offset %r13, -40
.Lcfi490:
	.cfi_offset %r14, -32
.Lcfi491:
	.cfi_offset %r15, -24
	movzwl	2(%rdi), %ebx
	xorl	%eax, %eax
	testl	%ebx, %ebx
	setne	%al
	movl	$138, %r8d
	movl	$7, %edx
	cmovnel	%edx, %r8d
	addl	$3, %eax
	movl	$-1, %edx
	xorl	%r15d, %r15d
	xorl	%r13d, %r13d
	movl	%esi, -44(%rbp)         # 4-byte Spill
	movq	%rdi, -56(%rbp)         # 8-byte Spill
	cmpl	%esi, %r13d
	jle	.LBB98_2
	jmp	.LBB98_21
	.p2align	4, 0x90
.LBB98_20:                              # %for.inc
                                        #   in Loop: Header=BB98_2 Depth=1
	movl	%ebx, %edx
	incl	%r13d
	movl	%r14d, %ebx
	movl	%r12d, %r15d
	cmpl	%esi, %r13d
	jg	.LBB98_21
.LBB98_2:                               # %for.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB98_7 Depth 2
	movslq	%r13d, %rcx
	movzwl	6(%rdi,%rcx,4), %r14d
	leal	1(%r15), %r12d
	cmpl	%r8d, %r12d
	jge	.LBB98_5
# BB#3:                                 # %for.body
                                        #   in Loop: Header=BB98_2 Depth=1
	cmpl	%r14d, %ebx
	jne	.LBB98_5
# BB#4:                                 #   in Loop: Header=BB98_2 Depth=1
	movl	%edx, %ebx
	jmp	.LBB98_20
	.p2align	4, 0x90
.LBB98_5:                               # %if.else
                                        #   in Loop: Header=BB98_2 Depth=1
	cmpl	%eax, %r12d
	jge	.LBB98_8
# BB#6:                                 # %do.body.preheader
                                        #   in Loop: Header=BB98_2 Depth=1
	notl	%r15d
	.p2align	4, 0x90
.LBB98_7:                               # %do.body
                                        #   Parent Loop BB98_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movslq	%ebx, %rax
	movzwl	bl_tree(,%rax,4), %edi
	movzwl	bl_tree+2(,%rax,4), %esi
	callq	send_bits
	incl	%r15d
	jne	.LBB98_7
	jmp	.LBB98_16
	.p2align	4, 0x90
.LBB98_8:                               # %if.else26
                                        #   in Loop: Header=BB98_2 Depth=1
	testl	%ebx, %ebx
	je	.LBB98_12
# BB#9:                                 # %if.then29
                                        #   in Loop: Header=BB98_2 Depth=1
	cmpl	%edx, %ebx
	je	.LBB98_11
# BB#10:                                # %if.then32
                                        #   in Loop: Header=BB98_2 Depth=1
	movslq	%ebx, %rax
	movzwl	bl_tree(,%rax,4), %edi
	movzwl	bl_tree+2(,%rax,4), %esi
	callq	send_bits
	decl	%r12d
.LBB98_11:                              # %if.end44
                                        #   in Loop: Header=BB98_2 Depth=1
	movzwl	bl_tree+64(%rip), %edi
	movzwl	bl_tree+66(%rip), %esi
	callq	send_bits
	addl	$-3, %r12d
	movl	$2, %esi
	jmp	.LBB98_15
.LBB98_12:                              # %if.else47
                                        #   in Loop: Header=BB98_2 Depth=1
	cmpl	$10, %r12d
	jg	.LBB98_14
# BB#13:                                # %if.then50
                                        #   in Loop: Header=BB98_2 Depth=1
	movzwl	bl_tree+68(%rip), %edi
	movzwl	bl_tree+70(%rip), %esi
	callq	send_bits
	addl	$-3, %r12d
	movl	$3, %esi
	jmp	.LBB98_15
.LBB98_14:                              # %if.else54
                                        #   in Loop: Header=BB98_2 Depth=1
	movzwl	bl_tree+72(%rip), %edi
	movzwl	bl_tree+74(%rip), %esi
	callq	send_bits
	addl	$-11, %r12d
	movl	$7, %esi
	.p2align	4, 0x90
.LBB98_15:                              # %if.end61
                                        #   in Loop: Header=BB98_2 Depth=1
	movl	%r12d, %edi
	callq	send_bits
.LBB98_16:                              # %if.end61
                                        #   in Loop: Header=BB98_2 Depth=1
	xorl	%r12d, %r12d
	testl	%r14d, %r14d
	je	.LBB98_17
# BB#18:                                # %if.else65
                                        #   in Loop: Header=BB98_2 Depth=1
	xorl	%eax, %eax
	cmpl	%r14d, %ebx
	setne	%al
	leal	6(%rax), %r8d
	addl	$3, %eax
	jmp	.LBB98_19
.LBB98_17:                              #   in Loop: Header=BB98_2 Depth=1
	movl	$3, %eax
	movl	$138, %r8d
.LBB98_19:                              # %for.inc
                                        #   in Loop: Header=BB98_2 Depth=1
	movl	-44(%rbp), %esi         # 4-byte Reload
	movq	-56(%rbp), %rdi         # 8-byte Reload
	jmp	.LBB98_20
.LBB98_21:                              # %for.end
	addq	$24, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
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
.Lcfi492:
	.cfi_def_cfa_offset 16
.Lcfi493:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi494:
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
.Lcfi495:
	.cfi_def_cfa_offset 16
.Lcfi496:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi497:
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
.Lcfi498:
	.cfi_def_cfa_offset 16
.Lcfi499:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi500:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi501:
	.cfi_offset %rbx, -32
.Lcfi502:
	.cfi_offset %r14, -24
	movzwl	io_bitbuf(%rip), %eax
	movl	%edi, %ecx
	shll	%cl, %eax
	movw	%ax, io_bitbuf(%rip)
	xorl	%r14d, %r14d
	jmp	.LBB101_1
	.p2align	4, 0x90
.LBB101_5:                              # %cond.end
                                        #   in Loop: Header=BB101_1 Depth=1
	movl	%eax, subbitbuf(%rip)
	cmpl	$-1, %eax
	cmovel	%r14d, %eax
	movl	%eax, subbitbuf(%rip)
	movl	$8, bitcount(%rip)
	movl	%ebx, %edi
.LBB101_1:                              # %while.cond
                                        # =>This Inner Loop Header: Depth=1
	movl	bitcount(%rip), %ecx
	movl	subbitbuf(%rip), %eax
	movl	%edi, %ebx
	subl	%ecx, %ebx
	jle	.LBB101_6
# BB#2:                                 # %while.body
                                        #   in Loop: Header=BB101_1 Depth=1
	movl	%ebx, %ecx
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
	jmp	.LBB101_5
	.p2align	4, 0x90
.LBB101_4:                              # %cond.false
                                        #   in Loop: Header=BB101_1 Depth=1
	movl	$1, %edi
	callq	fill_inbuf
	jmp	.LBB101_5
.LBB101_6:                              # %while.end
	subl	%edi, %ecx
	movl	%ecx, bitcount(%rip)
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %eax
	movzwl	io_bitbuf(%rip), %ecx
	orl	%eax, %ecx
	movw	%cx, io_bitbuf(%rip)
	popq	%rbx
	popq	%r14
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
.Lcfi503:
	.cfi_def_cfa_offset 16
.Lcfi504:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi505:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi506:
	.cfi_offset %rbx, -24
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
	movzwl	d_buf(%rax,%rax), %ebx
	cmpl	$510, %ebx              # imm = 0x1FE
	jb	.LBB102_7
# BB#5:                                 # %do.body.preheader
	movl	$8, %eax
	.p2align	4, 0x90
.LBB102_6:                              # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movzwl	io_bitbuf(%rip), %ecx
	testl	%eax, %ecx
	movl	%ebx, %ecx
	leaq	prev(%rcx,%rcx), %rdx
	leaq	prev+65536(%rcx,%rcx), %rcx
	cmoveq	%rdx, %rcx
	movzwl	(%rcx), %ebx
	shrl	%eax
	cmpl	$509, %ebx              # imm = 0x1FD
	ja	.LBB102_6
.LBB102_7:                              # %if.end20
	movzbl	outbuf(%rbx), %edi
	callq	fillbuf
.LBB102_8:                              # %return
	movl	%ebx, %eax
	addq	$8, %rsp
	popq	%rbx
	popq	%rbp
	retq
.LBB102_2:
	movl	$510, %ebx              # imm = 0x1FE
	jmp	.LBB102_8
.Lfunc_end102:
	.size	decode_c, .Lfunc_end102-decode_c
	.cfi_endproc

	.p2align	4, 0x90
	.type	decode_p,@function
decode_p:                               # @decode_p
	.cfi_startproc
# BB#0:                                 # %entry
	pushq	%rbp
.Lcfi507:
	.cfi_def_cfa_offset 16
.Lcfi508:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi509:
	.cfi_def_cfa_register %rbp
	pushq	%r14
	pushq	%rbx
.Lcfi510:
	.cfi_offset %rbx, -32
.Lcfi511:
	.cfi_offset %r14, -24
	movzwl	io_bitbuf(%rip), %eax
	movzbl	%ah, %eax  # NOREX
	movzwl	pt_table(%rax,%rax), %ebx
	cmpl	$14, %ebx
	jb	.LBB103_3
# BB#1:                                 # %do.body.preheader
	movl	$128, %eax
	.p2align	4, 0x90
.LBB103_2:                              # %do.body
                                        # =>This Inner Loop Header: Depth=1
	movzwl	io_bitbuf(%rip), %ecx
	testl	%eax, %ecx
	movl	%ebx, %ecx
	leaq	prev(%rcx,%rcx), %rdx
	leaq	prev+65536(%rcx,%rcx), %rcx
	cmoveq	%rdx, %rcx
	movzwl	(%rcx), %ebx
	shrl	%eax
	cmpl	$13, %ebx
	ja	.LBB103_2
.LBB103_3:                              # %if.end14
	movzbl	pt_len(%rbx), %edi
	callq	fillbuf
	testl	%ebx, %ebx
	je	.LBB103_5
# BB#4:                                 # %if.then20
	decl	%ebx
	movl	$1, %r14d
	movl	%ebx, %ecx
	shll	%cl, %r14d
	movl	%ebx, %edi
	callq	getbits
	movl	%eax, %ebx
	addl	%r14d, %ebx
.LBB103_5:                              # %if.end22
	movl	%ebx, %eax
	popq	%rbx
	popq	%r14
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
.Lcfi512:
	.cfi_def_cfa_offset 16
.Lcfi513:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi514:
	.cfi_def_cfa_register %rbp
	pushq	%rbx
	pushq	%rax
.Lcfi515:
	.cfi_offset %rbx, -24
	movzwl	io_bitbuf(%rip), %ebx
	movl	$16, %ecx
	subl	%edi, %ecx
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shrl	%cl, %ebx
	callq	fillbuf
	movl	%ebx, %eax
	addq	$8, %rsp
	popq	%rbx
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
.Lcfi516:
	.cfi_def_cfa_offset 16
.Lcfi517:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi518:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	pushq	%rax
.Lcfi519:
	.cfi_offset %rbx, -56
.Lcfi520:
	.cfi_offset %r12, -48
.Lcfi521:
	.cfi_offset %r13, -40
.Lcfi522:
	.cfi_offset %r14, -32
.Lcfi523:
	.cfi_offset %r15, -24
	movl	%edx, %r14d
	movl	%esi, %r12d
	movl	%edi, %r13d
	movl	%r12d, %edi
	callq	getbits
	movl	%eax, %r15d
	testl	%r15d, %r15d
	je	.LBB105_6
# BB#1:                                 # %while.cond.preheader
	xorl	%ebx, %ebx
	jmp	.LBB105_2
	.p2align	4, 0x90
.LBB105_11:                             # %while.body
                                        #   in Loop: Header=BB105_2 Depth=1
	movzwl	io_bitbuf(%rip), %r12d
	shrl	$13, %r12d
	cmpl	$7, %r12d
	jne	.LBB105_15
# BB#12:                                # %while.cond17.preheader
                                        #   in Loop: Header=BB105_2 Depth=1
	movl	$4096, %eax             # imm = 0x1000
	jmp	.LBB105_13
	.p2align	4, 0x90
.LBB105_14:                             # %while.body19
                                        #   in Loop: Header=BB105_13 Depth=2
	shrl	%eax
	incl	%r12d
.LBB105_13:                             # %while.cond17
                                        #   Parent Loop BB105_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzwl	io_bitbuf(%rip), %ecx
	testl	%ecx, %eax
	jne	.LBB105_14
.LBB105_15:                             # %if.end
                                        #   in Loop: Header=BB105_2 Depth=1
	leal	-3(%r12), %edi
	cmpl	$7, %r12d
	movl	$3, %eax
	cmovll	%eax, %edi
	callq	fillbuf
	movslq	%ebx, %rax
	incl	%ebx
	movb	%r12b, pt_len(%rax)
	cmpl	%r14d, %ebx
	jne	.LBB105_2
# BB#16:                                # %if.then30
                                        #   in Loop: Header=BB105_2 Depth=1
	movl	$2, %edi
	callq	getbits
	movslq	%ebx, %rbx
	jmp	.LBB105_17
	.p2align	4, 0x90
.LBB105_18:                             # %while.body35
                                        #   in Loop: Header=BB105_17 Depth=2
	movb	$0, pt_len(%rbx)
	incq	%rbx
.LBB105_17:                             # %while.cond32
                                        #   Parent Loop BB105_2 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	decl	%eax
	testl	%eax, %eax
	jns	.LBB105_18
.LBB105_2:                              # %while.cond
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB105_13 Depth 2
                                        #     Child Loop BB105_17 Depth 2
	cmpl	%r15d, %ebx
	jl	.LBB105_11
# BB#3:                                 # %while.cond42.preheader
	movslq	%ebx, %rax
	cmpl	%r13d, %eax
	jge	.LBB105_19
	.p2align	4, 0x90
.LBB105_5:                              # %while.body45
                                        # =>This Inner Loop Header: Depth=1
	movb	$0, pt_len(%rax)
	incq	%rax
	cmpl	%r13d, %eax
	jl	.LBB105_5
.LBB105_19:                             # %while.end49
	movl	$pt_len, %esi
	movl	$8, %edx
	movl	$pt_table, %ecx
	movl	%r13d, %edi
	callq	make_table
	jmp	.LBB105_20
.LBB105_6:                              # %if.then
	movl	%r12d, %edi
	callq	getbits
	xorl	%ecx, %ecx
	cmpl	%r13d, %ecx
	jge	.LBB105_8
	.p2align	4, 0x90
.LBB105_21:                             # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movb	$0, pt_len(%rcx)
	incq	%rcx
	cmpl	%r13d, %ecx
	jl	.LBB105_21
.LBB105_8:                              # %for.cond3.preheader
	xorl	%ecx, %ecx
	cmpl	$255, %ecx
	jg	.LBB105_20
	.p2align	4, 0x90
.LBB105_10:                             # %for.body5
                                        # =>This Inner Loop Header: Depth=1
	movw	%ax, pt_table(%rcx,%rcx)
	incq	%rcx
	cmpl	$255, %ecx
	jle	.LBB105_10
.LBB105_20:                             # %if.end50
	addq	$8, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
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
.Lcfi524:
	.cfi_def_cfa_offset 16
.Lcfi525:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi526:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%rbx
	pushq	%rax
.Lcfi527:
	.cfi_offset %rbx, -40
.Lcfi528:
	.cfi_offset %r14, -32
.Lcfi529:
	.cfi_offset %r15, -24
	movl	$9, %edi
	callq	getbits
	movl	%eax, %r14d
	testl	%r14d, %r14d
	je	.LBB106_6
# BB#1:                                 # %while.cond.preheader
	xorl	%r15d, %r15d
	cmpl	%r14d, %r15d
	jl	.LBB106_11
	jmp	.LBB106_3
	.p2align	4, 0x90
.LBB106_24:                             # %if.else59
                                        #   in Loop: Header=BB106_11 Depth=1
	addl	$-2, %ebx
	movslq	%r15d, %rax
	incl	%r15d
	movb	%bl, outbuf(%rax)
.LBB106_2:                              # %while.cond
                                        #   in Loop: Header=BB106_11 Depth=1
	cmpl	%r14d, %r15d
	jge	.LBB106_3
.LBB106_11:                             # %while.body
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB106_13 Depth 2
                                        #     Child Loop BB106_23 Depth 2
	movzwl	io_bitbuf(%rip), %eax
	movzbl	%ah, %eax  # NOREX
	movzwl	pt_table(%rax,%rax), %ebx
	cmpl	$19, %ebx
	jl	.LBB106_14
# BB#12:                                # %do.body.preheader
                                        #   in Loop: Header=BB106_11 Depth=1
	movl	$128, %eax
	.p2align	4, 0x90
.LBB106_13:                             # %do.body
                                        #   Parent Loop BB106_11 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movzwl	io_bitbuf(%rip), %ecx
	testl	%eax, %ecx
	movslq	%ebx, %rcx
	leaq	prev(%rcx,%rcx), %rdx
	leaq	prev+65536(%rcx,%rcx), %rcx
	cmoveq	%rdx, %rcx
	movzwl	(%rcx), %ebx
	shrl	%eax
	cmpl	$18, %ebx
	jg	.LBB106_13
.LBB106_14:                             # %if.end32
                                        #   in Loop: Header=BB106_11 Depth=1
	movzbl	pt_len(%rbx), %edi
	callq	fillbuf
	cmpl	$2, %ebx
	jg	.LBB106_24
# BB#15:                                # %if.then38
                                        #   in Loop: Header=BB106_11 Depth=1
	testl	%ebx, %ebx
	je	.LBB106_16
# BB#17:                                # %if.then38
                                        #   in Loop: Header=BB106_11 Depth=1
	cmpl	$1, %ebx
	jne	.LBB106_18
# BB#19:                                # %if.then45
                                        #   in Loop: Header=BB106_11 Depth=1
	movl	$3, %ebx
	movl	$4, %edi
	jmp	.LBB106_20
.LBB106_16:                             #   in Loop: Header=BB106_11 Depth=1
	movl	$1, %eax
	jmp	.LBB106_21
.LBB106_18:                             #   in Loop: Header=BB106_11 Depth=1
	movl	$20, %ebx
	movl	$9, %edi
.LBB106_20:                             # %if.end50
                                        #   in Loop: Header=BB106_11 Depth=1
	callq	getbits
	addl	%ebx, %eax
.LBB106_21:                             # %while.cond52.preheader
                                        #   in Loop: Header=BB106_11 Depth=1
	decl	%eax
	movslq	%r15d, %r15
	testl	%eax, %eax
	js	.LBB106_2
	.p2align	4, 0x90
.LBB106_23:                             # %while.body55
                                        #   Parent Loop BB106_11 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	movb	$0, outbuf(%r15)
	decl	%eax
	incq	%r15
	testl	%eax, %eax
	jns	.LBB106_23
	jmp	.LBB106_2
.LBB106_3:                              # %while.cond66.preheader
	movslq	%r15d, %rax
	cmpl	$509, %eax              # imm = 0x1FD
	jg	.LBB106_25
	.p2align	4, 0x90
.LBB106_5:                              # %while.body69
                                        # =>This Inner Loop Header: Depth=1
	movb	$0, outbuf(%rax)
	incq	%rax
	cmpl	$509, %eax              # imm = 0x1FD
	jle	.LBB106_5
.LBB106_25:                             # %while.end73
	movl	$510, %edi              # imm = 0x1FE
	movl	$outbuf, %esi
	movl	$12, %edx
	movl	$d_buf, %ecx
	callq	make_table
	jmp	.LBB106_26
.LBB106_6:                              # %if.then
	movl	$9, %edi
	callq	getbits
	xorl	%ecx, %ecx
	cmpl	$510, %ecx              # imm = 0x1FE
	jge	.LBB106_8
	.p2align	4, 0x90
.LBB106_27:                             # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movb	$0, outbuf(%rcx)
	incq	%rcx
	cmpl	$510, %ecx              # imm = 0x1FE
	jl	.LBB106_27
.LBB106_8:                              # %for.cond3.preheader
	xorl	%ecx, %ecx
	cmpl	$4095, %ecx             # imm = 0xFFF
	jg	.LBB106_26
	.p2align	4, 0x90
.LBB106_10:                             # %for.body5
                                        # =>This Inner Loop Header: Depth=1
	movw	%ax, d_buf(%rcx,%rcx)
	incq	%rcx
	cmpl	$4095, %ecx             # imm = 0xFFF
	jle	.LBB106_10
.LBB106_26:                             # %if.end74
	addq	$8, %rsp
	popq	%rbx
	popq	%r14
	popq	%r15
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
.Lcfi530:
	.cfi_def_cfa_offset 16
.Lcfi531:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
.Lcfi532:
	.cfi_def_cfa_register %rbp
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$136, %rsp
.Lcfi533:
	.cfi_offset %rbx, -56
.Lcfi534:
	.cfi_offset %r12, -48
.Lcfi535:
	.cfi_offset %r13, -40
.Lcfi536:
	.cfi_offset %r14, -32
.Lcfi537:
	.cfi_offset %r15, -24
	movq	%rcx, %r13
	movl	%edx, %r14d
	movq	%rsi, %r15
	movl	%edi, %r12d
	movl	$1, %eax
	cmpl	$17, %eax
	jae	.LBB107_2
	.p2align	4, 0x90
.LBB107_34:                             # %for.body
                                        # =>This Inner Loop Header: Depth=1
	movw	$0, -176(%rbp,%rax,2)
	incq	%rax
	cmpl	$17, %eax
	jb	.LBB107_34
.LBB107_2:                              # %for.cond1.preheader
	xorl	%eax, %eax
	cmpl	%r12d, %eax
	jae	.LBB107_5
	.p2align	4, 0x90
.LBB107_4:                              # %for.body3
                                        # =>This Inner Loop Header: Depth=1
	movzbl	(%r15,%rax), %ecx
	incw	-176(%rbp,%rcx,2)
	incq	%rax
	cmpl	%r12d, %eax
	jb	.LBB107_4
.LBB107_5:                              # %for.end11
	movw	$0, -78(%rbp)
	movl	$15, %ecx
	movl	$1, %eax
	cmpl	$16, %eax
	ja	.LBB107_8
	.p2align	4, 0x90
.LBB107_7:                              # %for.body15
                                        # =>This Inner Loop Header: Depth=1
	movzwl	-80(%rbp,%rax,2), %edx
	movzwl	-176(%rbp,%rax,2), %esi
	shll	%cl, %esi
	addl	%edx, %esi
	movw	%si, -78(%rbp,%rax,2)
	incq	%rax
	decl	%ecx
	cmpl	$16, %eax
	jbe	.LBB107_7
.LBB107_8:                              # %for.end27
	cmpw	$0, -46(%rbp)
	je	.LBB107_10
# BB#9:                                 # %if.then
	movl	$.L.str.197, %edi
	callq	error
.LBB107_10:                             # %if.end
	movl	$16, %r8d
	subl	%r14d, %r8d
	leal	-1(%r14), %esi
	movl	$-15, %edx
	jmp	.LBB107_11
	.p2align	4, 0x90
.LBB107_35:                             # %for.body36
                                        #   in Loop: Header=BB107_11 Depth=1
	movl	%eax, %eax
	movzwl	-80(%rbp,%rax,2), %edi
	movl	%r8d, %ecx
	shrl	%cl, %edi
	movw	%di, -80(%rbp,%rax,2)
	movl	$1, %edi
	movl	%esi, %ecx
	shll	%cl, %edi
	movw	%di, -128(%rbp,%rax,2)
	incl	%edx
	decl	%esi
.LBB107_11:                             # %for.cond33
                                        # =>This Inner Loop Header: Depth=1
	leal	16(%rdx), %eax
	cmpl	%r14d, %eax
	jbe	.LBB107_35
# BB#12:                                # %while.cond.preheader
	negl	%edx
	cmpl	$16, %eax
	ja	.LBB107_15
	.p2align	4, 0x90
.LBB107_14:                             # %while.body
                                        # =>This Inner Loop Header: Depth=1
	movl	$1, %esi
	movl	%edx, %ecx
	shll	%cl, %esi
	movw	%si, -128(%rbp,%rax,2)
	incq	%rax
	decl	%edx
	cmpl	$16, %eax
	jbe	.LBB107_14
.LBB107_15:                             # %while.end
	movslq	%r14d, %rax
	movzwl	-78(%rbp,%rax,2), %eax
	movl	%r8d, %ecx
	shrl	%cl, %eax
	testl	%eax, %eax
	je	.LBB107_19
# BB#16:                                # %if.then64
	movl	$1, %edx
	movl	%r14d, %ecx
	shll	%cl, %edx
	cmpl	%eax, %edx
	je	.LBB107_19
	.p2align	4, 0x90
.LBB107_18:                             # %while.body69
                                        # =>This Inner Loop Header: Depth=1
	movl	%eax, %ecx
	incl	%eax
	movw	$0, (%r13,%rcx,2)
	cmpl	%eax, %edx
	jne	.LBB107_18
.LBB107_19:                             # %if.end74
	movl	$15, %ecx
	subl	%r14d, %ecx
	movl	$1, %r10d
                                        # kill: %CL<def> %CL<kill> %ECX<kill>
	shll	%cl, %r10d
	xorl	%r11d, %r11d
	movl	%r12d, %edi
	cmpl	%r12d, %r11d
	jb	.LBB107_21
	jmp	.LBB107_33
	.p2align	4, 0x90
.LBB107_32:                             # %for.inc148
                                        #   in Loop: Header=BB107_21 Depth=1
	incl	%r11d
	cmpl	%r12d, %r11d
	jae	.LBB107_33
.LBB107_21:                             # %for.body80
                                        # =>This Loop Header: Depth=1
                                        #     Child Loop BB107_27 Depth 2
                                        #     Child Loop BB107_23 Depth 2
	movl	%r11d, %eax
	movzbl	(%r15,%rax), %r9d
	testl	%r9d, %r9d
	je	.LBB107_32
# BB#22:                                # %if.end87
                                        #   in Loop: Header=BB107_21 Depth=1
	movzwl	-80(%rbp,%r9,2), %eax
	movzwl	-128(%rbp,%r9,2), %ebx
	addl	%eax, %ebx
	movzwl	-80(%rbp,%r9,2), %eax
	cmpl	%r14d, %r9d
	jbe	.LBB107_23
# BB#25:                                # %if.else
                                        #   in Loop: Header=BB107_21 Depth=1
	movl	%eax, %edx
	movl	%r8d, %ecx
	shrl	%cl, %edx
	leaq	(%r13,%rdx,2), %rcx
	movl	%r14d, %edx
	subl	%r9d, %edx
	testl	%edx, %edx
	jne	.LBB107_27
	jmp	.LBB107_30
	.p2align	4, 0x90
.LBB107_24:                             # %for.body104
                                        #   in Loop: Header=BB107_23 Depth=2
	movw	%r11w, (%r13,%rax,2)
	incq	%rax
.LBB107_23:                             # %for.cond101
                                        #   Parent Loop BB107_21 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpl	%ebx, %eax
	jb	.LBB107_24
	jmp	.LBB107_31
	.p2align	4, 0x90
.LBB107_29:                             # %if.end132
                                        #   in Loop: Header=BB107_27 Depth=2
	testl	%r10d, %eax
	movzwl	(%rcx), %ecx
	leaq	prev+65536(%rcx,%rcx), %rsi
	leaq	prev(%rcx,%rcx), %rcx
	cmovneq	%rsi, %rcx
	addl	%eax, %eax
	incl	%edx
	testl	%edx, %edx
	je	.LBB107_30
.LBB107_27:                             # %while.body121
                                        #   Parent Loop BB107_21 Depth=1
                                        # =>  This Inner Loop Header: Depth=2
	cmpw	$0, (%rcx)
	jne	.LBB107_29
# BB#28:                                # %if.then125
                                        #   in Loop: Header=BB107_27 Depth=2
	movl	%edi, %esi
	movw	$0, prev(%rsi,%rsi)
	movw	$0, prev+65536(%rsi,%rsi)
	movw	%di, (%rcx)
	leal	1(%rdi), %esi
	movl	%esi, %edi
	jmp	.LBB107_29
	.p2align	4, 0x90
.LBB107_30:                             # %while.end142
                                        #   in Loop: Header=BB107_21 Depth=1
	movw	%r11w, (%rcx)
.LBB107_31:                             # %if.end144
                                        #   in Loop: Header=BB107_21 Depth=1
	movw	%bx, -80(%rbp,%r9,2)
	jmp	.LBB107_32
.LBB107_33:                             # %for.end150
	addq	$136, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
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
