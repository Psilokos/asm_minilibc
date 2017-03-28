[BITS 64]

global strpbrk:function

%include "utils.inc"

section .text

strpbrk:
	push		rbp
	mov		rbp, rsp
	MovDqU		xmm0, [rdi]
	xor		rax, rax
	jmp		.loop + 0x4

.loop:
	add		rax, 0x10
	MovDqU		xmm1, [rsi + rax]
	PcmpIstrI	xmm1, xmm0, AOP_EqAny
	jc		.found
	jz		.not_found
	jns		.loop
	add		rdi, 0x10
	jmp		strpbrk + 0x4

.found:
	mov		rax, rdi
	add		rax, rcx
	jmp		.ret

.not_found:
	xor		rax, rax

.ret:
	mov		rsp, rbp
	pop		rbp
	ret
