.text
	.globl	main
main:
	movq %rsp, %rbx
	subq $16, %rsp
	movq %rsp, %rbp
	movq %rbp, -8(%rbx)
	subq $0, %rsp
	movq $5, %rdi
	pushq %rdi
	movq $7, %rdi
	pushq %rdi
	call fun6
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	call fun3
	addq $8, %rsp
	call newline
	movq $5, %rdi
	pushq %rdi
	movq $5, %rdi
	pushq %rdi
	call fun6
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	call fun3
	addq $8, %rsp
	call newline
	movq $17, %rdi
	pushq %rdi
	movq $5, %rdi
	pushq %rdi
	call fun6
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	call fun3
	addq $8, %rsp
	call newline
	movq $2, %rdi
	pushq %rdi
	movq $13, %rdi
	pushq %rdi
	call fun6
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	call fun3
	addq $8, %rsp
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
fun6:
	pushq %rbp
	pushq -16(%rbx)
	movq %rsp, %rbp
	movq %rbp, -16(%rbx)
	subq $8, %rsp
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	call fun5
	addq $8, %rsp
	movq %rax, %rdi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	call fun4
	addq $8, %rsp
	jmp whiledown0
whileup0:
	movq $1, %rdi
	pushq %rdi
	movq $1, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	popq %rsi
	subl %esi, %edi
	pushq %rdi
	jmp fordown0
forup0:
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq 16(%rdi), %rdi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	incl -16(%rbp)
fordown0:
	movl -16(%rbp), %edi
	cmpl -24(%rbp), %edi
	jle forup0
	addq $16, %rsp
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	call fun2
	addq $8, %rsp
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq 16(%rdi), %rdi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
whiledown0:
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq 16(%rdi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	setne %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jnz whileup0
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq 0(%rdi), %rdi
	movq %rdi, %rax
	addq $8, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
fun5:
	pushq %rbp
	pushq -16(%rbx)
	movq %rsp, %rbp
	movq %rbp, -16(%rbx)
	subq $8, %rsp
	movq $1, %rdi
	pushq %rdi
	call fun0
	addq $8, %rsp
	movq %rax, %rdi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	movq $2, %rdi
	pushq %rdi
	jmp fordown1
forup1:
	movq -16(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $16, %rsp
	decl -16(%rbp)
fordown1:
	movl -16(%rbp), %edi
	cmpl -24(%rbp), %edi
	jge forup1
	addq $16, %rsp
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq %rdi, %rax
	addq $8, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
fun4:
	pushq %rbp
	pushq -16(%rbx)
	movq %rsp, %rbp
	movq %rbp, -16(%rbx)
	subq $8, %rsp
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	call fun3
	addq $8, %rsp
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 16(%rdi), %rdi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	jmp whiledown1
whileup1:
	movq $44, %rdi
	call put
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	call fun3
	addq $8, %rsp
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq 16(%rdi), %rdi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
whiledown1:
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	setne %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jnz whileup1
	call newline
	addq $8, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
fun3:
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
	jz else0
if0:
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
	call fun3
	addq $8, %rsp
	jmp endif0
else0:
endif0:
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
fun2:
	pushq %rbp
	pushq -16(%rbx)
	movq %rsp, %rbp
	movq %rbp, -16(%rbx)
	subq $0, %rsp
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 16(%rdi), %rdi
	popq %rsi
	movq %rdi, 16(%rsi)
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 16(%rdi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 8(%rdi), %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
	addq $0, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
fun1:
	pushq %rbp
	pushq -16(%rbx)
	movq %rsp, %rbp
	movq %rbp, -16(%rbx)
	subq $8, %rsp
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	pushq %rdi
	call fun0
	addq $8, %rsp
	movq %rax, %rdi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 16(%rdi), %rdi
	popq %rsi
	movq %rdi, 16(%rsi)
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	popq %rsi
	movq %rdi, 16(%rsi)
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq 16(%rdi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
	addq $8, %rsp
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
	movq $24, %rdi
	call malloc
	pushq %rax
	popq %rdi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	popq %rsi
	movq %rdi, 16(%rsi)
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq %rdi, %rax
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
