[BITS 64]

global strncmp:function

%include "utils.inc"

section .text

strncmp:
	push		rbp
	mov		rbp, rsp
	or		rdx, 0x0
	jz		.eq
	mov		rax, -0x10

.loop:
	add		rax, 0x10
	MovDqU		xmm0, [rsi + rax]
	PcmpIstrI	xmm0, [rdi + rax], AOP_EqEach | POL_Neg
	jc		.diff
	jz		.eq
	add		rcx, rax
	cmp		rdx, rcx
	jna		.eq
	jmp		.loop

.diff:
	add		rcx, rax
	cmp		rdx, rcx
	jna		.eq
	movzx		rax, BYTE [rdi + rcx]
	movzx		rdx, BYTE [rsi + rcx]
	sub		eax, edx
	jmp		.ret

.eq:
	xor		rax, rax

.ret:
	mov		rsp, rbp
	pop		rbp
	ret
