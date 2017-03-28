[BITS 64]

global memcpy:function

section .text

memcpy:
	push	rbp
	mov	rbp, rsp
	mov	rcx, rdx
	or	rcx, 0x0
	jz	.ret
	mov	rax, 0b1111
	not	rax
	test	rax, rcx
	jz	.loop1

.loop0:
	MovDqu	xmm0, [rsi + rcx - 0x10]
	MovDqU	[rdi + rcx - 0x10], xmm0
	sub	rcx, 0x10
	jz	.ret
	test	rax, rcx
	jnz	.loop0

.loop1:
	dec	rcx
	mov	al, [rsi + rcx]
	mov	[rdi + rcx], al
	jnz	.loop1

.ret:
	mov	rax, rdi
	mov	rsp, rbp
	pop	rbp
	ret
