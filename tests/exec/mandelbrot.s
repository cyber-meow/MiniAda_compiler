.text
	.globl	main
main:
	movq %rsp, %rbx
	subq $16, %rsp
	movq %rsp, %rbp
	movq %rbp, -8(%rbx)
	subq $0, %rsp
	movq $30, %rdi
	pushq %rdi
	call fun7
	addq $8, %rsp
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
fun7:
	pushq %rbp
	pushq -16(%rbx)
	movq %rsp, %rbp
	movq %rbp, -16(%rbx)
	subq $64, %rsp
	movq $2, %rdi
	negl %edi
	pushq %rdi
	call fun4
	addq $8, %rsp
	movq %rax, %rdi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq $1, %rdi
	pushq %rdi
	call fun4
	addq $8, %rsp
	movq %rax, %rdi
	movq -16(%rbx), %rsi
	addq $-16, %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	movq $2, %rdi
	popq %rsi
	imull %esi, %edi
	pushq %rdi
	call fun4
	addq $8, %rsp
	movq %rax, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	call fun3
	addq $16, %rsp
	movq %rax, %rdi
	movq -16(%rbx), %rsi
	addq $-24, %rsi
	movq %rdi, 0(%rsi)
	movq $1, %rdi
	negl %edi
	pushq %rdi
	call fun4
	addq $8, %rsp
	movq %rax, %rdi
	movq -16(%rbx), %rsi
	addq $-32, %rsi
	movq %rdi, 0(%rsi)
	movq $1, %rdi
	pushq %rdi
	call fun4
	addq $8, %rsp
	movq %rax, %rdi
	movq -16(%rbx), %rsi
	addq $-40, %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	call fun4
	addq $8, %rsp
	movq %rax, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -32(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -40(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	call fun3
	addq $16, %rsp
	movq %rax, %rdi
	movq -16(%rbx), %rsi
	addq $-48, %rsi
	movq %rdi, 0(%rsi)
	movq $0, %rdi
	pushq %rdi
	movq $1, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	subl %esi, %edi
	pushq %rdi
	jmp fordown0
forup0:
	movq -16(%rbx), %rsi
	movq -48(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -72(%rsi), %rdi
	pushq %rdi
	call fun4
	addq $8, %rsp
	movq %rax, %rdi
	pushq %rdi
	call fun2
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -32(%rsi), %rdi
	pushq %rdi
	call fun0
	addq $16, %rsp
	movq %rax, %rdi
	movq -16(%rbx), %rsi
	addq $-64, %rsi
	movq %rdi, 0(%rsi)
	movq $0, %rdi
	pushq %rdi
	movq $1, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	movq $2, %rdi
	popq %rsi
	imull %esi, %edi
	popq %rsi
	subl %esi, %edi
	pushq %rdi
	jmp fordown1
forup1:
	movq -16(%rbx), %rsi
	movq -24(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -88(%rsi), %rdi
	pushq %rdi
	call fun4
	addq $8, %rsp
	movq %rax, %rdi
	pushq %rdi
	call fun2
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	call fun0
	addq $16, %rsp
	movq %rax, %rdi
	movq -16(%rbx), %rsi
	addq $-56, %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq -64(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -56(%rsi), %rdi
	pushq %rdi
	call fun6
	addq $16, %rsp
	movq %rax, %rdi
	testq %rdi, %rdi
	jz else0
if0:
	movq $48, %rdi
	call put
	jmp endif0
else0:
	movq $49, %rdi
	call put
endif0:
	incl -88(%rbp)
fordown1:
	movl -88(%rbp), %edi
	cmpl -96(%rbp), %edi
	jle forup1
	addq $16, %rsp
	call newline
	incl -72(%rbp)
fordown0:
	movl -72(%rbp), %edi
	cmpl -80(%rbp), %edi
	jle forup0
	addq $16, %rsp
	addq $64, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
fun6:
	pushq %rbp
	pushq -16(%rbx)
	movq %rsp, %rbp
	movq %rbp, -16(%rbx)
	subq $0, %rsp
	movq $0, %rdi
	pushq %rdi
	call fun4
	addq $8, %rsp
	movq %rax, %rdi
	pushq %rdi
	movq $0, %rdi
	pushq %rdi
	call fun4
	addq $8, %rsp
	movq %rax, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	movq $0, %rdi
	pushq %rdi
	call fun5
	addq $40, %rsp
	movq %rax, %rdi
	movq %rdi, %rax
	addq $0, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
fun5:
	pushq %rbp
	pushq -16(%rbx)
	movq %rsp, %rbp
	movq %rbp, -16(%rbx)
	subq $16, %rsp
	movq $100, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else1
if1:
	movq $1, %rdi
	movq %rdi, %rax
	addq $16, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
	jmp endif1
else1:
endif1:
	movq -16(%rbx), %rsi
	movq 48(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 48(%rsi), %rdi
	pushq %rdi
	call fun2
	addq $16, %rsp
	movq %rax, %rdi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq 56(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 56(%rsi), %rdi
	pushq %rdi
	call fun2
	addq $16, %rsp
	movq %rax, %rdi
	movq -16(%rbx), %rsi
	addq $-16, %rsi
	movq %rdi, 0(%rsi)
	movq $4, %rdi
	pushq %rdi
	call fun4
	addq $8, %rsp
	movq %rax, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	call fun0
	addq $16, %rsp
	movq %rax, %rdi
	popq %rsi
	cmpl %esi, %edi
	setg %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else2
if2:
	movq $0, %rdi
	movq %rdi, %rax
	addq $16, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
	jmp endif2
else2:
endif2:
	movq -16(%rbx), %rsi
	movq 40(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 56(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 48(%rsi), %rdi
	pushq %rdi
	call fun2
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	movq $2, %rdi
	pushq %rdi
	call fun4
	addq $8, %rsp
	movq %rax, %rdi
	pushq %rdi
	call fun2
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	call fun0
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	call fun0
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 40(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	pushq %rdi
	movq $1, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	addl %esi, %edi
	pushq %rdi
	call fun5
	addq $40, %rsp
	movq %rax, %rdi
	movq %rdi, %rax
	addq $16, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
fun4:
	pushq %rbp
	pushq -16(%rbx)
	movq %rsp, %rbp
	movq %rbp, -16(%rbx)
	subq $0, %rsp
	movq $8192, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	imull %esi, %edi
	movq %rdi, %rax
	addq $0, %rsp
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
	movq $8192, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	imull %esi, %edi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	pushq %rdi
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
	movq -8(%rsi), %rdi
	popq %rsi
	addl %esi, %edi
	popq %rsi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %edi
	movq %rdi, %rax
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
	subq $8, %rsp
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	imull %esi, %edi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq $8192, %rdi
	pushq %rdi
	movq $2, %rdi
	pushq %rdi
	movq $8192, %rdi
	popq %rsi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %edi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	popq %rsi
	addl %esi, %edi
	popq %rsi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %edi
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
	subq $0, %rsp
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	subl %esi, %edi
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
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	addl %esi, %edi
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
