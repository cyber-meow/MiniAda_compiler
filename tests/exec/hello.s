.text
	.globl	main
main:
	movq %rsp, %rbx
	subq $8, %rsp
	movq %rsp, %rbp
	movq %rbp, -8(%rbx)
	subq $0, %rsp
	movq $72, %rdi
	call put
	movq $101, %rdi
	call put
	movq $108, %rdi
	call put
	movq $108, %rdi
	call put
	movq $111, %rdi
	call put
	movq $44, %rdi
	call put
	movq $32, %rdi
	call put
	movq $119, %rdi
	call put
	movq $111, %rdi
	call put
	movq $114, %rdi
	call put
	movq $108, %rdi
	call put
	movq $100, %rdi
	call put
	movq $33, %rdi
	call put
	call newline
	addq $8, %rsp
	xorq %rax, %rax
	ret
put:
	movq %rdi, %rsi
	movq $put_msg, %rdi
	xorq %rax, %rax
	call printf
	ret
newline:
	movq $newline_msg, %rdi
	xorq %rax, %rax
	call printf
	ret
.data
put_msg:
	.string "%c"
newline_msg:
	.string "\n"
