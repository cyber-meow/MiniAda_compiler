.text
	.globl	main
main:
	movq %rsp, %rbx
	subq $16, %rsp
	movq %rsp, %rbp
	movq %rbp, -8(%rbx)
	subq $0, %rsp
	call fun0
	addq $0, %rsp
	movq %rax, %rdi
	call put
	call newline
	movq $98, %rdi
	pushq %rdi
	call fun1
	addq $8, %rsp
	movq %rax, %rdi
	call put
	call newline
	call fun0
	addq $0, %rsp
	movq %rax, %rdi
	pushq %rdi
	call fun1
	addq $8, %rsp
	movq %rax, %rdi
	call put
	call newline
	addq $16, %rsp
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
fun1:
	pushq %rbp
	pushq -16(%rbx)
	movq %rsp, %rbp
	movq %rbp, -16(%rbx)
	subq $0, %rsp
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq %rdi, %rax
	addq $0, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
fun0:
	pushq %rbp
	pushq -16(%rbx)
	movq %rsp, %rbp
	movq %rbp, -16(%rbx)
	subq $0, %rsp
	movq $97, %rdi
	movq %rdi, %rax
	addq $0, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
.data
put_msg:
	.string "%c"
newline_msg:
	.string "\n"
