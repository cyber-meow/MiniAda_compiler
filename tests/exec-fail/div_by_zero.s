.text
	.globl	main
main:
	movq %rsp, %rbx
	subq $8, %rsp
	movq %rsp, %rbp
	movq %rbp, -8(%rbx)
	subq $8, %rsp
	movq $0, %rdi
	movq -8(%rbx), %rsi
	addq $-8, %rsi
	movq %rdi, 0(%rsi)
	movq $1, %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq $1, %rdi
	popq %rsi
	movl %edi, %eax
	cltd
	idivl %esi
	movl %eax, %edi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else0
if0:
	call newline
	jmp endif0
else0:
endif0:
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
.data
put_msg:
	.string "%c"
newline_msg:
	.string "\n"
