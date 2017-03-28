[BITS 64]

global index:function
global strchr:function

%include "utils.inc"

section .text

index:
strchr:
	push		rbp
	mov		rbp, rsp
	mov		[rsp - 0x4], esi
	fill_xmm_m32	xmm0, [rsp - 0x4]
	mov		rax, -0x10

.loop:
	add		rax, 0x10
	PcmpIstrI	xmm0, [rdi + rax], 0b1000
	ja		.loop
	jc		.found
	xor		rax, rax
	jmp		.ret

.found:
	add		rax, rdi
	add		rax, rcx

.ret:
	mov		rsp, rbp
	pop		rbp
	ret
