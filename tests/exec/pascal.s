.text
	.globl	main
main:
	movq %rsp, %rbx
	subq $16, %rsp
	movq %rsp, %rbp
	movq %rbp, -8(%rbx)
	subq $16, %rsp
	movq $42, %rdi
	movq -8(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq $1, %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	popq %rsi
	addl %esi, %edi
	pushq %rdi
	call fun2
	addq $8, %rsp
	movq %rax, %rdi
	movq -8(%rbx), %rsi
	addq $-16, %rsi
	movq %rdi, 0(%rsi)
	movq $0, %rdi
	pushq %rdi
	movq $1, %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	popq %rsi
	subl %esi, %edi
	pushq %rdi
	jmp fordown2
forup2:
	movq $0, %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $24, %rsp
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	pushq %rdi
	call fun4
	addq $8, %rsp
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	pushq %rdi
	call fun3
	addq $8, %rsp
	incl -24(%rbp)
fordown2:
	movl -24(%rbp), %edi
	cmpl -32(%rbp), %edi
	jle forup2
	addq $16, %rsp
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
fun4:
	pushq %rbp
	pushq -16(%rbx)
	movq %rsp, %rbp
	movq %rbp, -16(%rbx)
	subq $0, %rsp
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	movq $1, %rdi
	pushq %rdi
	jmp fordown0
forup0:
	movq $7, %rdi
	pushq %rdi
	movq $1, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	popq %rsi
	subl %esi, %edi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	call fun0
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	call fun0
	addq $16, %rsp
	movq %rax, %rdi
	popq %rsi
	addl %esi, %edi
	popq %rsi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %edx, %edi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $24, %rsp
	decl -8(%rbp)
fordown0:
	movl -8(%rbp), %edi
	cmpl -16(%rbp), %edi
	jge forup0
	addq $16, %rsp
	movq $1, %rdi
	pushq %rdi
	movq $0, %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $24, %rsp
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
	subq $0, %rsp
	movq $0, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	jmp fordown1
forup1:
	movq $0, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	call fun0
	addq $16, %rsp
	movq %rax, %rdi
	popq %rsi
	cmpq %rsi, %rdi
	setne %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else0
if0:
	movq $42, %rdi
	call put
	jmp endif0
else0:
	movq $46, %rdi
	call put
endif0:
	incl -8(%rbp)
fordown1:
	movl -8(%rbp), %edi
	cmpl -16(%rbp), %edi
	jle forup1
	addq $16, %rsp
	call newline
	addq $0, %rsp
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
	movq $0, %rdi
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
	movq $0, %rdi
	movq %rdi, %rax
	addq $8, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
	jmp endif1
else1:
endif1:
	movq $16, %rdi
	call malloc
	pushq %rax
	popq %rdi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq $0, %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq $1, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	subl %esi, %edi
	pushq %rdi
	call fun2
	addq $8, %rsp
	movq %rax, %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
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
	subq $0, %rsp
	movq $0, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else2
if2:
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 40(%rsi), %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	jmp endif2
else2:
	movq -16(%rbx), %rsi
	movq 40(%rsi), %rdi
	pushq %rdi
	movq $1, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	popq %rsi
	subl %esi, %edi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	call fun1
	addq $24, %rsp
endif2:
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
	movq $0, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else3
if3:
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 0(%rdi), %rdi
	movq %rdi, %rax
	addq $0, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
	jmp endif3
else3:
endif3:
	movq $1, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	popq %rsi
	subl %esi, %edi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	call fun0
	addq $16, %rsp
	movq %rax, %rdi
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
