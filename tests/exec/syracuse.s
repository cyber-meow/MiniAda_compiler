.text
	.globl	main
main:
	movq %rsp, %rbx
	subq $32, %rsp
	movq %rsp, %rbp
	movq %rbp, -8(%rbx)
	subq $0, %rsp
	movq $10, %rdi
	pushq %rdi
	call fun1
	addq $8, %rsp
	addq $32, %rsp
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
	subq $8, %rsp
	movq $1, %rdi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	jmp whiledown0
whileup0:
	call fun2
	addq $0, %rsp
	movq $1, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	popq %rsi
	addl %esi, %edi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
whiledown0:
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	popq %rsi
	cmpl %esi, %edi
	setle %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jnz whileup0
	addq $8, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
fun2:
	pushq %rbp
	pushq -24(%rbx)
	movq %rsp, %rbp
	movq %rbp, -24(%rbx)
	subq $16, %rsp
	movq $0, %rdi
	movq -24(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq -24(%rbx), %rsi
	addq $-16, %rsi
	movq %rdi, 0(%rsi)
	jmp whiledown1
whileup1:
	call fun3
	addq $0, %rsp
whiledown1:
	movq $1, %rdi
	pushq %rdi
	movq -24(%rbx), %rsi
	movq -16(%rsi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	setne %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jnz whileup1
	movq -24(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	call fun0
	addq $8, %rsp
	call newline
	addq $16, %rsp
	popq %rbp
	movq %rbp, -24(%rbx)
	popq %rbp
	ret
fun3:
	pushq %rbp
	pushq -32(%rbx)
	movq %rsp, %rbp
	movq %rbp, -32(%rbx)
	subq $0, %rsp
	movq $1, %rdi
	pushq %rdi
	movq -24(%rbx), %rsi
	movq -8(%rsi), %rdi
	popq %rsi
	addl %esi, %edi
	movq -24(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq $2, %rdi
	pushq %rdi
	movq -24(%rbx), %rsi
	movq -16(%rsi), %rdi
	popq %rsi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %edi
	pushq %rdi
	movq $2, %rdi
	popq %rsi
	imull %esi, %edi
	pushq %rdi
	movq -24(%rbx), %rsi
	movq -16(%rsi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else0
if0:
	movq $2, %rdi
	pushq %rdi
	movq -24(%rbx), %rsi
	movq -16(%rsi), %rdi
	popq %rsi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %edi
	movq -24(%rbx), %rsi
	addq $-16, %rsi
	movq %rdi, 0(%rsi)
	jmp endif0
else0:
	movq $1, %rdi
	pushq %rdi
	movq -24(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq $3, %rdi
	popq %rsi
	imull %esi, %edi
	popq %rsi
	addl %esi, %edi
	movq -24(%rbx), %rsi
	addq $-16, %rsi
	movq %rdi, 0(%rsi)
endif0:
	addq $0, %rsp
	popq %rbp
	movq %rbp, -32(%rbx)
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