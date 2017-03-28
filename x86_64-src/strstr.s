[BITS 64]

global strstr:function

%include "utils.inc"

section .text

strstr:
	push		rbp
	mov		rbp, rsp
	mov		rax, rdi
	xor		rax, rsi
	jz		.ret
	Pxor		xmm1, xmm1
	MovDqU		xmm4, [rsi]
	jmp		.loop + 0x4

	sub		rdi, 0xf
.loop:
	add		rdi, 0x10
	PcmpIstrI	xmm4, [rdi], AOP_EqOrder
	ja		.loop
	jnc		.not_found
	add		rdi, rcx
	mov		r8, rdi
	mov		r9, rsi
	sub		r9, r8
	sub		r8, 0x10

.check_match:
	add		r8, 0x10
	MovDqU		xmm3, [r8 + r9]
	PcmpIstrM	xmm1, xmm3, AOP_EqEach + POL_Neg + OS_BWMask
	MovDqU		xmm2, [r8]
	Pand		xmm2, xmm0
	PcmpIstrI	xmm3, xmm2, AOP_EqEach + POL_Neg
	ja		.check_match
	jc		.loop - 0x4
	mov		rax, rdi
	jmp		.ret

.not_found:
	xor		rax, rax

.ret:
	mov		rsp, rbp
	pop		rbp
	ret
