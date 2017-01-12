.text
	.globl	main
main:
	movq %rsp, %rbx
	subq $16, %rsp
	movq %rsp, %rbp
	movq %rbp, -8(%rbx)
	subq $32, %rsp
	movq $16, %rdi
	call malloc
	pushq %rax
	popq %rdi
	movq -8(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq $16, %rdi
	call malloc
	pushq %rax
	popq %rdi
	movq -8(%rbx), %rsi
	addq $-16, %rsi
	movq %rdi, 0(%rsi)
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq $0, %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq $1, %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq $2, %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq $3, %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq 8(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq 0(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	popq %rsi
	andq %rsi, %rdi
	testq %rdi, %rdi
	jz else4
if4:
	movq $97, %rdi
	call put
	jmp endif4
else4:
endif4:
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
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
	movq 8(%rdi), %rdx
	movq %rdx, 8(%rsi)
	addq $16, %rsp
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq 8(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq 0(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	popq %rsi
	andq %rsi, %rdi
	testq %rdi, %rdi
	jz else5
if5:
	movq $98, %rdi
	call put
	jmp endif5
else5:
endif5:
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq $0, %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq $1, %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq $2, %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq $3, %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq 8(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq 0(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	popq %rsi
	andq %rsi, %rdi
	testq %rdi, %rdi
	jz else6
if6:
	movq $97, %rdi
	call put
	jmp endif6
else6:
endif6:
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	call fun0
	addq $16, %rsp
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq 8(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	movq 0(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	popq %rsi
	andq %rsi, %rdi
	testq %rdi, %rdi
	jz else7
if7:
	movq $101, %rdi
	call put
	jmp endif7
else7:
endif7:
	movq $16, %rdi
	call malloc
	pushq %rax
	popq %rdi
	movq -8(%rbx), %rsi
	addq $-24, %rsi
	movq %rdi, 0(%rsi)
	movq $16, %rdi
	call malloc
	pushq %rax
	popq %rdi
	movq -8(%rbx), %rsi
	addq $-32, %rsi
	movq %rdi, 0(%rsi)
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	pushq %rdi
	movq $0, %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	pushq %rdi
	movq $1, %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
	movq -8(%rbx), %rsi
	movq -32(%rsi), %rdi
	pushq %rdi
	movq $0, %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -8(%rbx), %rsi
	movq -32(%rsi), %rdi
	pushq %rdi
	movq $1, %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
	movq -8(%rbx), %rsi
	movq -32(%rsi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else8
if8:
	movq $97, %rdi
	call put
	jmp endif8
else8:
endif8:
	movq -8(%rbx), %rsi
	leaq -32(%rsi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	leaq -24(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $16, %rsp
	movq -8(%rbx), %rsi
	movq -32(%rsi), %rdi
	pushq %rdi
	movq $42, %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
	movq -8(%rbx), %rsi
	movq -32(%rsi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else9
if9:
	movq $102, %rdi
	call put
	jmp endif9
else9:
endif9:
	call newline
	addq $48, %rsp
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
	movq 0(%rdi), %rdi
	pushq %rdi
	movq $0, %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	movq $1, %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	movq $2, %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	movq $3, %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 0(%rdi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 0(%rdi), %rdi
	movq 8(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 0(%rdi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 0(%rdi), %rdi
	movq 0(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	popq %rsi
	andq %rsi, %rdi
	testq %rdi, %rdi
	jz else0
if0:
	movq $97, %rdi
	call put
	jmp endif0
else0:
endif0:
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 0(%rdi), %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 0(%rdi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 0(%rdi), %rdi
	movq 8(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 0(%rdi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 0(%rdi), %rdi
	movq 0(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	popq %rsi
	andq %rsi, %rdi
	testq %rdi, %rdi
	jz else1
if1:
	movq $100, %rdi
	call put
	jmp endif1
else1:
endif1:
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
	movq 24(%rsi), %rdi
	pushq %rdi
	movq $0, %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	movq $1, %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	pushq %rdi
	movq $2, %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	pushq %rdi
	movq $3, %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 8(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 0(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	popq %rsi
	andq %rsi, %rdi
	testq %rdi, %rdi
	jz else2
if2:
	movq $97, %rdi
	call put
	jmp endif2
else2:
endif2:
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
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
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 8(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 32(%rsi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 0(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	popq %rsi
	andq %rsi, %rdi
	testq %rdi, %rdi
	jz else3
if3:
	movq $100, %rdi
	call put
	jmp endif3
else3:
endif3:
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
