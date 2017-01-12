.text
	.globl	main
main:
	movq %rsp, %rbx
	subq $16, %rsp
	movq %rsp, %rbp
	movq %rbp, -8(%rbx)
	subq $8, %rsp
	movq $0, %rdi
	movq -8(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	call fun4
	addq $8, %rsp
	call newline
	movq -8(%rbx), %rsi
	leaq -8(%rsi), %rdi
	pushq %rdi
	movq $5, %rdi
	pushq %rdi
	call fun0
	addq $16, %rsp
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	call fun4
	addq $8, %rsp
	call newline
	movq -8(%rbx), %rsi
	leaq -8(%rsi), %rdi
	pushq %rdi
	movq $2, %rdi
	pushq %rdi
	call fun0
	addq $16, %rsp
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	call fun4
	addq $8, %rsp
	call newline
	movq -8(%rbx), %rsi
	leaq -8(%rsi), %rdi
	pushq %rdi
	movq $7, %rdi
	pushq %rdi
	call fun0
	addq $16, %rsp
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	call fun4
	addq $8, %rsp
	call newline
	movq $1, %rdi
	pushq %rdi
	movq $10, %rdi
	pushq %rdi
	jmp fordown0
forup0:
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $16, %rsp
	movq %rax, %rdi
	pushq %rdi
	call fun3
	addq $8, %rsp
	movq -8(%rbx), %rsi
	leaq -8(%rsi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	call fun0
	addq $16, %rsp
	incl -16(%rbp)
fordown0:
	movl -16(%rbp), %edi
	cmpl -24(%rbp), %edi
	jle forup0
	addq $16, %rsp
	call newline
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	call fun4
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
fun4:
	pushq %rbp
	pushq -16(%rbx)
	movq %rsp, %rbp
	movq %rbp, -16(%rbx)
	subq $0, %rsp
	movq $0, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else0
if0:
	addq $0, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
	jmp endif0
else0:
endif0:
	movq $40, %rdi
	call put
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	call fun4
	addq $8, %rsp
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	call fun2
	addq $8, %rsp
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 16(%rdi), %rdi
	pushq %rdi
	call fun4
	addq $8, %rsp
	movq $41, %rdi
	call put
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
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	testq %rdi, %rdi
	jz else1
if1:
	movq $84, %rdi
	call put
	jmp endif1
else1:
	movq $70, %rdi
	call put
endif1:
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
	jz else2
if2:
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
	call fun2
	addq $8, %rsp
	jmp endif2
else2:
endif2:
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
	jz else3
if3:
	movq $0, %rdi
	movq %rdi, %rax
	addq $0, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
	jmp endif3
else3:
endif3:
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	cmpl %esi, %edi
	setl %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else5
if5:
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $16, %rsp
	movq %rax, %rdi
	movq %rdi, %rax
	addq $0, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
	jmp endif4
else5:
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 0(%rdi), %rdi
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
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 16(%rdi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $16, %rsp
	movq %rax, %rdi
	movq %rdi, %rax
	addq $0, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
	jmp endif4
else4:
	movq $1, %rdi
	movq %rdi, %rax
	addq $0, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
endif4:
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
	movq 0(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else6
if6:
	movq $24, %rdi
	call malloc
	pushq %rax
	popq %rdi
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	addq $0, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
	jmp endif5
else6:
endif5:
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 0(%rdi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	cmpl %esi, %edi
	setl %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else8
if8:
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 0(%rdi), %rdi
	addq $8, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	call fun0
	addq $16, %rsp
	jmp endif6
else8:
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 0(%rdi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	cmpl %esi, %edi
	setg %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else7
if7:
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 0(%rdi), %rdi
	addq $16, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	call fun0
	addq $16, %rsp
	jmp endif6
else7:
endif6:
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
