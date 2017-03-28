[BITS 64]

global strcspn:function

%include "utils.inc"

section .text

strcspn:
	push		rbp
	mov		rbp, rsp
	xor		rax, rax
	MovDqU		xmm0, [rdi + rax]
	xor		rdx, rdx
	jmp		.loop + 0x4

.loop:
	add		rdx, 0x10
	MovDqU		xmm1, [rsi + rdx]
	PcmpIstrI	xmm1, xmm0, AOP_EqAny
	jc		.ret
	jns		.loop
	jz		.str_length
	add		rax, 0x10
	jmp		.loop - 0xa

.str_length:
	Pxor		xmm1, xmm1
	PcmpIstrI	xmm1, xmm0, AOP_EqEach

.ret:
	add		rax, rcx
	mov		rsp, rbp
	pop		rbp
	ret
