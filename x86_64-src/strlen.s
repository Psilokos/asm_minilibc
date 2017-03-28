[BITS 64]

global strlen:function

%include "utils.inc"

section .text

strlen:
	push		rbp
	mov		rbp, rsp
	push		rdi
	push		rcx
	mov		rax, -0x10
	pxor		xmm0, xmm0

.loop:
	add		rax, 0x10
	PcmpIstrI	xmm0, [rdi + rax], AOP_EqEach
	jnc		.loop
	add		rax, rcx
	pop		rcx
	pop		rdi
	mov		rsp, rbp
	pop		rbp
	ret
