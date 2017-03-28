[BITS 64]

global memcmp:function

section .text

memcmp:
	push		rbp
	mov		rbp, rsp
	or		rdx, 0x0
	jz		.ret
	mov		rax, -0x10

.loop:
	add		rax, 0x10
	MovDqU		xmm0, [rsi + rax]
	PcmpIstrI	xmm0, [rdi + rax], 0b11000
	jc		.diff
	add		rcx, rax
	cmp		rdx, rcx
	jna		.eq
	jmp		.loop

.diff:
	add		rcx, rax
	cmp		rdx, rcx
	jna		.eq
	movzx		rax, byte [rdi + rcx]
	movzx		rdx, byte [rsi + rcx]
	sub		rax, rdx
	jmp		.ret

.eq:
	xor		rax, rax

.ret:
	mov		rsp, rbp
	pop		rbp
	ret
