[BITS 64]

global strcmp:function

section .text

strcmp:
	push		rbp
	mov		rbp, rsp
	mov		rax, rdi
	sub		rax, rsi
	sub		rsi, 0x10

.loop:
	add		rsi, 0x10
	MovDqU		xmm0, [rsi]
	PcmpIstrI	xmm0, [rsi + rax], 0b11000
	ja		.loop
	jc		.diff
	xor		rax, rax
	jmp		.ret

.diff:
	add		rax, rsi
	movzx		rax, byte [rax + rcx]
	movzx		rsi, byte [rsi + rcx]
	sub		rax, rsi

.ret:
	mov		rsp, rbp
	pop		rbp
	ret
