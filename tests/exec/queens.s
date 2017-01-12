.text
	.globl	main
main:
	movq %rsp, %rbx
	subq $24, %rsp
	movq %rsp, %rbp
	movq %rbp, -8(%rbx)
	subq $8, %rsp
	movq $0, %rdi
	movq -8(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq $1, %rdi
	pushq %rdi
	movq $10, %rdi
	pushq %rdi
	jmp fordown2
forup2:
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	call fun0
	addq $8, %rsp
	movq $32, %rdi
	call put
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	call fun2
	addq $8, %rsp
	movq %rax, %rdi
	pushq %rdi
	call fun0
	addq $8, %rsp
	call newline
	incl -16(%rbp)
fordown2:
	movl -16(%rbp), %edi
	cmpl -24(%rbp), %edi
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
fun2:
	pushq %rbp
	pushq -16(%rbx)
	movq %rsp, %rbp
	movq %rbp, -16(%rbx)
	subq $8, %rsp
	movq $0, %rdi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
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
	movq $1, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq $2, %rdi
	popq %rsi
	imull %esi, %edi
	popq %rsi
	addl %esi, %edi
	movq -16(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	incl -16(%rbp)
fordown0:
	movl -16(%rbp), %edi
	cmpl -24(%rbp), %edi
	jle forup0
	addq $16, %rsp
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	call fun3
	addq $24, %rsp
	movq %rax, %rdi
	movq %rdi, %rax
	addq $8, %rsp
	popq %rbp
	movq %rbp, -16(%rbx)
	popq %rbp
	ret
fun3:
	pushq %rbp
	pushq -24(%rbx)
	movq %rsp, %rbp
	movq %rbp, -24(%rbx)
	subq $16, %rsp
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq -24(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else0
if0:
	movq $1, %rdi
	movq %rdi, %rax
	addq $16, %rsp
	popq %rbp
	movq %rbp, -24(%rbx)
	popq %rbp
	ret
	jmp endif0
else0:
endif0:
	movq $0, %rdi
	movq -24(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq $1, %rdi
	movq -24(%rbx), %rsi
	addq $-16, %rsi
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
	jmp fordown1
forup1:
	movq -24(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	movq -24(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $16, %rsp
	movq %rax, %rdi
	testq %rdi, %rdi
	jz endandthen1
	movq -24(%rbx), %rsi
	movq 32(%rsi), %rdi
	pushq %rdi
	movq -24(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $16, %rsp
	movq %rax, %rdi
	notq %rdi
	andq $1, %rdi
endandthen1:
	testq %rdi, %rdi
	jz endandthen0
	movq -24(%rbx), %rsi
	movq 40(%rsi), %rdi
	pushq %rdi
	movq -24(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $16, %rsp
	movq %rax, %rdi
	notq %rdi
	andq $1, %rdi
endandthen0:
	testq %rdi, %rdi
	jz else1
if1:
	movq $2, %rdi
	pushq %rdi
	movq -24(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq -24(%rbx), %rsi
	movq 40(%rsi), %rdi
	popq %rsi
	addl %esi, %edi
	popq %rsi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %edi
	pushq %rdi
	movq $2, %rdi
	pushq %rdi
	movq -24(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq -24(%rbx), %rsi
	movq 32(%rsi), %rdi
	popq %rsi
	addl %esi, %edi
	popq %rsi
	imull %esi, %edi
	pushq %rdi
	movq -24(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq -24(%rbx), %rsi
	movq 24(%rsi), %rdi
	popq %rsi
	subl %esi, %edi
	pushq %rdi
	call fun3
	addq $24, %rsp
	movq %rax, %rdi
	pushq %rdi
	movq -24(%rbx), %rsi
	movq -8(%rsi), %rdi
	popq %rsi
	addl %esi, %edi
	movq -24(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	jmp endif1
else1:
endif1:
	movq -24(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq $2, %rdi
	popq %rsi
	imull %esi, %edi
	movq -24(%rbx), %rsi
	addq $-16, %rsi
	movq %rdi, 0(%rsi)
	incl -24(%rbp)
fordown1:
	movl -24(%rbp), %edi
	cmpl -32(%rbp), %edi
	jle forup1
	addq $16, %rsp
	movq -24(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq %rdi, %rax
	addq $16, %rsp
	popq %rbp
	movq %rbp, -24(%rbx)
	popq %rbp
	ret
fun1:
	pushq %rbp
	pushq -16(%rbx)
	movq %rsp, %rbp
	movq %rbp, -16(%rbx)
	subq $0, %rsp
	movq $1, %rdi
	pushq %rdi
	movq $2, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	popq %rsi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %edi
	popq %rsi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %edx, %edi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
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
	call fun0
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
.data
put_msg:
	.string "%c"
newline_msg:
	.string "\n"
