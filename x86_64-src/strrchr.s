[BITS 64]

global rindex:function
global strrchr:function
extern strlen

%include "utils.inc"

section .text

rindex:
strrchr:
	push		rbp
	mov		rbp, rsp
	or		esi, 0x0
	jz		.length
	mov		[rsp - 0x4], esi
	fill_xmm_m32	xmm0, [rsp - 0x4]
	mov		rax, -0x10
	push		rbx
	xor		rbx, rbx

.loop:
	add		rax, 0x10
	PcmpIstrI	xmm0, [rdi + rax], AOP_EqEach | OS_MSI
	ja		.loop
	jnc		.ret
	mov		rbx, rdi
	add		rbx, rax
	add		rbx, rcx
	jmp		.loop

.length:
	call		strlen wrt ..plt
	add		rax, rdi
	jmp		.ret + 0x4

.ret:
	mov		rax, rbx
	pop		rbx
	mov		rsp, rbp
	pop		rbp
	ret
