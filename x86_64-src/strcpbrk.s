[BITS 64]

global strcpbrk:function

%include "utils.inc"

section .text

strcpbrk:
	push		rbp
	mov		rbp, rsp
	MovDqU		xmm0, [rdi]
	xor		rax, rax
	jmp		.loop + 0x4

.loop:
	add		rax, 0x10
	MovDqU		xmm1, [rsi + rax]
	PcmpIstrI	xmm1, xmm0, AOP_EqAny + POL_NegMask
	jc		.found
	js		.ret - 0x3
	jnz		.loop
	add		rdi, 0x10
	jmp		.loop - 0xa

.found:
	mov		rax, rdi
	add		rax, rcx
	jmp		.ret

	xor		rax, rax
.ret:
	mov		rsp, rbp
	pop		rbp
	ret
