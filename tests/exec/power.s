.text
	.globl	main
main:
	movq %rsp, %rbx
	subq $16, %rsp
	movq %rsp, %rbp
	movq %rbp, -8(%rbx)
	subq $0, %rsp
	movq $0, %rdi
	pushq %rdi
	movq $2, %rdi
	pushq %rdi
	call fun2
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	call fun1
	addq $8, %rsp
	call newline
	movq $8, %rdi
	pushq %rdi
	movq $2, %rdi
	pushq %rdi
	call fun2
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	call fun1
	addq $8, %rsp
	call newline
	movq $30, %rdi
	pushq %rdi
	movq $2, %rdi
	pushq %rdi
	call fun2
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	call fun1
	addq $8, %rsp
	call newline
	movq $31, %rdi
	pushq %rdi
	movq $2, %rdi
	pushq %rdi
	call fun2
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	call fun1
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
fun2:
	pushq %rbp
	pushq -16(%rbx)
	movq %rsp, %rbp
	movq %rbp, -16(%rbx)
	subq $8, %rsp
	movq $0, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else0
if0:
	movq $1, %rdi
	movq %rdi, %rax
	addq $8, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
	jmp endif0
else0:
endif0:
	movq $2, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	popq %rsi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %edi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	call fun2
	addq $16, %rsp
	movq %rax, %rdi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	popq %rsi
	imull %esi, %edi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq $1, %rdi
	pushq %rdi
	movq $2, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	popq %rsi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %edx, %edi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else1
if1:
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	imull %esi, %edi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	jmp endif1
else1:
endif1:
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq %rdi, %rax
	addq $8, %rsp
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
	movq $0, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	cmpl %esi, %edi
	setge %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else2
if2:
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	call fun0
	addq $8, %rsp
	addq $8, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
	jmp endif2
else2:
endif2:
	movq $45, %rdi
	call put
	movq $9, %rdi
	negl %edi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	cmpl %esi, %edi
	setl %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else3
if3:
	movq $10, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %edi
	negl %edi
	pushq %rdi
	call fun0
	addq $8, %rsp
	jmp endif3
else3:
endif3:
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq $48, %rdi
	popq %rsi
	subl %esi, %edi
	call put
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
	jz else4
if4:
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
	jmp endif4
else4:
endif4:
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
