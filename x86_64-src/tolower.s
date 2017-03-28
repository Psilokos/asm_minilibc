[BITS 64]

global tolower:function

section .text

tolower:
	push	rbp
	mov	rbp, rsp
	movzx	rax, dil
	cmp	al, 0x41
	jc	.ret
	cmp	al, 0x5a
	ja	.ret
	add	al, 0x20

.ret:
	mov	rsp, rbp
	pop	rbp
	ret
