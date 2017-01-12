.text
	.globl	main
main:
	movq %rsp, %rbx
	subq $16, %rsp
	movq %rsp, %rbp
	movq %rbp, -8(%rbx)
	subq $24, %rsp
	movq $16, %rdi
	call malloc
	pushq %rax
	popq %rdi
	movq -8(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq $24, %rdi
	call malloc
	pushq %rax
	movq $16, %rdi
	call malloc
	pushq %rax
	popq %rdx
	movq 0(%rsp), %rcx
	movq %rdx, 8(%rcx)
	popq %rdi
	movq -8(%rbx), %rsi
	addq $-16, %rsi
	movq %rdi, 0(%rsi)
	movq $24, %rdi
	call malloc
	pushq %rax
	movq $16, %rdi
	call malloc
	pushq %rax
	popq %rdx
	movq 0(%rsp), %rcx
	movq %rdx, 8(%rcx)
	popq %rdi
	movq -8(%rbx), %rsi
	addq $-24, %rsi
	movq %rdi, 0(%rsi)
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq $49, %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq $50, %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq $48, %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq 8(%rdi)
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq 0(%rsp), %rdi
	movq 8(%rsp), %rsi
	movq 0(%rdi), %rdx
	movq %rdx, 0(%rsi)
	movq 0(%rsp), %rdi
	movq 8(%rsp), %rsi
	movq 8(%rdi), %rdx
	movq %rdx, 8(%rsi)
	addq $16, %rsp
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq $51, %rdi
	popq %rsi
	movq %rdi, 16(%rsi)
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $8, %rsp
	call newline
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq $108, %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $8, %rsp
	call newline
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq 0(%rsp), %rdi
	movq 8(%rsp), %rsi
	movq 0(%rdi), %rdx
	movq %rdx, 0(%rsi)
	movq 0(%rsp), %rdi
	movq 8(%rsp), %rsi
	pushq 8(%rsi)
	pushq 8(%rdi)
	movq 0(%rsp), %rdi
	movq 8(%rsp), %rsi
	movq 0(%rdi), %rdx
	movq %rdx, 0(%rsi)
	movq 0(%rsp), %rdi
	movq 8(%rsp), %rsi
	movq 8(%rdi), %rdx
	movq %rdx, 8(%rsi)
	addq $16, %rsp
	movq 0(%rsp), %rdi
	movq 8(%rsp), %rsi
	movq 16(%rdi), %rdx
	movq %rdx, 16(%rsi)
	addq $16, %rsp
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $8, %rsp
	call newline
	addq $40, %rsp
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
	movq $91, %rdi
	call put
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 0(%rdi), %rdi
	call put
	movq $44, %rdi
	call put
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	call fun0
	addq $8, %rsp
	movq $44, %rdi
	call put
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 16(%rdi), %rdi
	call put
	movq $93, %rdi
	call put
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
	movq $91, %rdi
	call put
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 0(%rdi), %rdi
	call put
	movq $44, %rdi
	call put
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 8(%rdi), %rdi
	call put
	movq $93, %rdi
	call put
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
