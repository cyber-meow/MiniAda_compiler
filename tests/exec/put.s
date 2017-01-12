.text
	.globl	main
main:
	movq %rsp, %rbx
	subq $8, %rsp
	movq %rsp, %rbp
	movq %rbp, -8(%rbx)
	subq $0, %rsp
	movq $65, %rdi
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
