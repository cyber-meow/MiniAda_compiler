.text
	.globl	main
main:
	movq %rsp, %rbx
	subq $16, %rsp
	movq %rsp, %rbp
	movq %rbp, -8(%rbx)
	subq $8, %rsp
	movq $10, %rdi
	pushq %rdi
	call fun1
	addq $8, %rsp
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	call fun0
	addq $8, %rsp
	call newline
	addq $24, %rsp
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
	movq $1, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	cmpl %esi, %edi
	setle %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else0
if0:
	movq $1, %rdi
	movq -8(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	jmp endif0
else0:
	movq $1, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	subl %esi, %edi
	pushq %rdi
	call fun1
	addq $8, %rsp
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	imull %esi, %edi
	movq -8(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
endif0:
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
	subq $8, %rsp
	movq $10, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %edx, %edi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq $9, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	cmpl %esi, %edi
	setg %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else1
if1:
	movq $10, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %edi
	pushq %rdi
	call fun0
	addq $8, %rsp
	jmp endif1
else1:
endif1:
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq $48, %rdi
	popq %rsi
	addl %esi, %edi
	call put
	addq $8, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
.data
put_msg:
	.string "%c"
newline_msg:
	.string "\n"
