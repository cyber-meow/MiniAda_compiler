.text
	.globl	main
main:
	movq %rsp, %rbx
	subq $8, %rsp
	movq %rsp, %rbp
	movq %rbp, -8(%rbx)
	subq $0, %rsp
	movq $1, %rdi
	pushq %rdi
	movq $10, %rdi
	pushq %rdi
	jmp fordown0
forup0:
	movq $65, %rdi
	call put
	incl -8(%rbp)
fordown0:
	movl -8(%rbp), %edi
	cmpl -16(%rbp), %edi
	jle forup0
	addq $16, %rsp
	call newline
	movq $10, %rdi
	pushq %rdi
	movq $1, %rdi
	pushq %rdi
	jmp fordown1
forup1:
	movq $66, %rdi
	call put
	incl -8(%rbp)
fordown1:
	movl -8(%rbp), %edi
	cmpl -16(%rbp), %edi
	jle forup1
	addq $16, %rsp
	call newline
	movq $10, %rdi
	pushq %rdi
	movq $1, %rdi
	pushq %rdi
	jmp fordown2
forup2:
	movq $67, %rdi
	call put
	decl -8(%rbp)
fordown2:
	movl -8(%rbp), %edi
	cmpl -16(%rbp), %edi
	jge forup2
	addq $16, %rsp
	call newline
	movq $1, %rdi
	pushq %rdi
	movq $10, %rdi
	pushq %rdi
	jmp fordown3
forup3:
	movq $68, %rdi
	call put
	decl -8(%rbp)
fordown3:
	movl -8(%rbp), %edi
	cmpl -16(%rbp), %edi
	jge forup3
	addq $16, %rsp
	call newline
	addq $8, %rsp
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
