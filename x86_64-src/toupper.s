[BITS 64]

global toupper:function

section .text

toupper:
	push	rbp
	mov	rbp, rsp
	movzx	rax, dil
	cmp	al, 0x61
	jc	.ret
	cmp	al, 0x7a
	ja	.ret
	sub	al, 0x20

.ret:
	mov	rsp, rbp
	pop	rbp
	ret
