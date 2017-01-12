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
	movq $24, %rdi
	call malloc
	pushq %rax
	movq $16, %rdi
	call malloc
	pushq %rax
	popq %rdx
	movq 0(%rsp), %rcx
	movq %rdx, 8(%rcx)
	popq %rdi
	movq -8(%rbx), %rsi
	addq $-24, %rsi
	movq %rdi, 0(%rsi)
	movq $24, %rdi
	call malloc
	pushq %rax
	movq $16, %rdi
	call malloc
	pushq %rax
	popq %rdx
	movq 0(%rsp), %rcx
	movq %rdx, 8(%rcx)
	popq %rdi
	movq -8(%rbx), %rsi
	addq $-32, %rsi
	movq %rdi, 0(%rsi)
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq $49, %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
	pushq %rdi
	movq $50, %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	pushq %rdi
	movq $48, %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	pushq 8(%rdi)
	movq -8(%rbx), %rsi
	movq -8(%rsi), %rdi
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
	movq -24(%rsi), %rdi
	pushq %rdi
	movq $51, %rdi
	popq %rsi
	movq %rdi, 16(%rsi)
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq $98, %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq $99, %rdi
	popq %rsi
	movq %rdi, 8(%rsi)
	movq -8(%rbx), %rsi
	movq -32(%rsi), %rdi
	pushq %rdi
	movq $97, %rdi
	popq %rsi
	movq %rdi, 0(%rsi)
	movq -8(%rbx), %rsi
	movq -32(%rsi), %rdi
	pushq 8(%rdi)
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
	movq -32(%rsi), %rdi
	pushq %rdi
	movq $100, %rdi
	popq %rsi
	movq %rdi, 16(%rsi)
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $8, %rsp
	call newline
	movq -8(%rbx), %rsi
	movq -32(%rsi), %rdi
	pushq %rdi
	call fun1
	addq $8, %rsp
	call newline
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -32(%rsi), %rdi
	pushq %rdi
	movq $1, %rdi
cmprec0:
	testq %rdi, %rdi
	jz endcmprec0
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 0(%rdx), %rdx
	cmpq %rdx, 0(%rcx)
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz endcmprec0
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	pushq 8(%rcx)
	pushq 8(%rdx)
cmprec1:
	testq %rdi, %rdi
	jz endcmprec1
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 0(%rdx), %rdx
	cmpq %rdx, 0(%rcx)
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz endcmprec1
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 8(%rdx), %rdx
	cmpq %rdx, 8(%rcx)
	sete %dil
	movzbq %dil, %rdi
endcmprec1:
	addq $16, %rsp
	testq %rdi, %rdi
	jz endcmprec0
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 16(%rdx), %rdx
	cmpq %rdx, 16(%rcx)
	sete %dil
	movzbq %dil, %rdi
endcmprec0:
	addq $16, %rsp
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
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq $1, %rdi
cmprec2:
	testq %rdi, %rdi
	jz endcmprec2
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 0(%rdx), %rdx
	cmpq %rdx, 0(%rcx)
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz endcmprec2
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 8(%rdx), %rdx
	cmpq %rdx, 8(%rcx)
	sete %dil
	movzbq %dil, %rdi
endcmprec2:
	addq $16, %rsp
	testq %rdi, %rdi
	jz else1
if1:
	movq $42, %rdi
	call put
	jmp endif1
else1:
	movq $46, %rdi
	call put
endif1:
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -32(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq $1, %rdi
cmprec3:
	testq %rdi, %rdi
	jz endcmprec3
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 0(%rdx), %rdx
	cmpq %rdx, 0(%rcx)
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz endcmprec3
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 8(%rdx), %rdx
	cmpq %rdx, 8(%rcx)
	sete %dil
	movzbq %dil, %rdi
endcmprec3:
	addq $16, %rsp
	testq %rdi, %rdi
	jz else2
if2:
	movq $42, %rdi
	call put
	jmp endif2
else2:
	movq $46, %rdi
	call put
endif2:
	movq -8(%rbx), %rsi
	movq -32(%rsi), %rdi
	movq 8(%rdi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	movq 8(%rdi), %rdi
	movq 0(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else3
if3:
	movq $42, %rdi
	call put
	jmp endif3
else3:
	movq $46, %rdi
	call put
endif3:
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	pushq 8(%rdi)
	movq -8(%rbx), %rsi
	movq -32(%rsi), %rdi
	movq 8(%rdi), %rdi
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
	movq -24(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq $1, %rdi
cmprec4:
	testq %rdi, %rdi
	jz endcmprec4
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 0(%rdx), %rdx
	cmpq %rdx, 0(%rcx)
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz endcmprec4
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 8(%rdx), %rdx
	cmpq %rdx, 8(%rcx)
	sete %dil
	movzbq %dil, %rdi
endcmprec4:
	addq $16, %rsp
	testq %rdi, %rdi
	jz else4
if4:
	movq $42, %rdi
	call put
	jmp endif4
else4:
	movq $46, %rdi
	call put
endif4:
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -32(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq $1, %rdi
cmprec5:
	testq %rdi, %rdi
	jz endcmprec5
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 0(%rdx), %rdx
	cmpq %rdx, 0(%rcx)
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz endcmprec5
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 8(%rdx), %rdx
	cmpq %rdx, 8(%rcx)
	sete %dil
	movzbq %dil, %rdi
endcmprec5:
	addq $16, %rsp
	testq %rdi, %rdi
	jz else5
if5:
	movq $42, %rdi
	call put
	jmp endif5
else5:
	movq $46, %rdi
	call put
endif5:
	movq -8(%rbx), %rsi
	movq -32(%rsi), %rdi
	movq 8(%rdi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	movq 8(%rdi), %rdi
	movq 0(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else6
if6:
	movq $42, %rdi
	call put
	jmp endif6
else6:
	movq $46, %rdi
	call put
endif6:
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -32(%rsi), %rdi
	pushq %rdi
	movq 0(%rsp), %rdi
	movq 8(%rsp), %rsi
	movq 0(%rdi), %rdx
	movq %rdx, 0(%rsi)
	movq 0(%rsp), %rdi
	movq 8(%rsp), %rsi
	pushq 8(%rsi)
	pushq 8(%rdi)
	movq 0(%rsp), %rdi
	movq 8(%rsp), %rsi
	movq 0(%rdi), %rdx
	movq %rdx, 0(%rsi)
	movq 0(%rsp), %rdi
	movq 8(%rsp), %rsi
	movq 8(%rdi), %rdx
	movq %rdx, 8(%rsi)
	addq $16, %rsp
	movq 0(%rsp), %rdi
	movq 8(%rsp), %rsi
	movq 16(%rdi), %rdx
	movq %rdx, 16(%rsi)
	addq $16, %rsp
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -32(%rsi), %rdi
	pushq %rdi
	movq $1, %rdi
cmprec6:
	testq %rdi, %rdi
	jz endcmprec6
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 0(%rdx), %rdx
	cmpq %rdx, 0(%rcx)
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz endcmprec6
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	pushq 8(%rcx)
	pushq 8(%rdx)
cmprec7:
	testq %rdi, %rdi
	jz endcmprec7
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 0(%rdx), %rdx
	cmpq %rdx, 0(%rcx)
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz endcmprec7
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 8(%rdx), %rdx
	cmpq %rdx, 8(%rcx)
	sete %dil
	movzbq %dil, %rdi
endcmprec7:
	addq $16, %rsp
	testq %rdi, %rdi
	jz endcmprec6
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 16(%rdx), %rdx
	cmpq %rdx, 16(%rcx)
	sete %dil
	movzbq %dil, %rdi
endcmprec6:
	addq $16, %rsp
	testq %rdi, %rdi
	jz else7
if7:
	movq $42, %rdi
	call put
	jmp endif7
else7:
	movq $46, %rdi
	call put
endif7:
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -16(%rsi), %rdi
	pushq %rdi
	movq $1, %rdi
cmprec8:
	testq %rdi, %rdi
	jz endcmprec8
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 0(%rdx), %rdx
	cmpq %rdx, 0(%rcx)
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz endcmprec8
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 8(%rdx), %rdx
	cmpq %rdx, 8(%rcx)
	sete %dil
	movzbq %dil, %rdi
endcmprec8:
	addq $16, %rsp
	testq %rdi, %rdi
	jz else8
if8:
	movq $42, %rdi
	call put
	jmp endif8
else8:
	movq $46, %rdi
	call put
endif8:
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -32(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	movq $1, %rdi
cmprec9:
	testq %rdi, %rdi
	jz endcmprec9
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 0(%rdx), %rdx
	cmpq %rdx, 0(%rcx)
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz endcmprec9
	movq 0(%rsp), %rdx
	movq 8(%rsp), %rcx
	movq 8(%rdx), %rdx
	cmpq %rdx, 8(%rcx)
	sete %dil
	movzbq %dil, %rdi
endcmprec9:
	addq $16, %rsp
	testq %rdi, %rdi
	jz else9
if9:
	movq $42, %rdi
	call put
	jmp endif9
else9:
	movq $46, %rdi
	call put
endif9:
	movq -8(%rbx), %rsi
	movq -32(%rsi), %rdi
	movq 8(%rdi), %rdi
	movq 0(%rdi), %rdi
	pushq %rdi
	movq -8(%rbx), %rsi
	movq -24(%rsi), %rdi
	movq 8(%rdi), %rdi
	movq 0(%rdi), %rdi
	popq %rsi
	cmpq %rsi, %rdi
	sete %dil
	movzbq %dil, %rdi
	testq %rdi, %rdi
	jz else10
if10:
	movq $42, %rdi
	call put
	jmp endif10
else10:
	movq $46, %rdi
	call put
endif10:
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
	movq $91, %rdi
	call put
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 0(%rdi), %rdi
	call put
	movq $44, %rdi
	call put
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 8(%rdi), %rdi
	pushq %rdi
	call fun0
	addq $8, %rsp
	movq $44, %rdi
	call put
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 16(%rdi), %rdi
	call put
	movq $93, %rdi
	call put
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
	movq $91, %rdi
	call put
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 0(%rdi), %rdi
	call put
	movq $44, %rdi
	call put
	movq -16(%rbx), %rsi
	movq 24(%rsi), %rdi
	movq 8(%rdi), %rdi
	call put
	movq $93, %rdi
	call put
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
