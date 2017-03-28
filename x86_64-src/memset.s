[BITS 64]

global memset:function

%include "utils.inc"

section .text

memset:
	push		rbp
	mov		rbp, rsp
	mov		rcx, rdx
	or		rcx, 0x0
	jz		.ret
	mov		rax, 0b1111
	not		rax
	test		rax, rcx
	jz		.loop1
	mov		[rsp - 0x4], esi
	fill_xmm_m32	xmm0, [rsp - 0x4]

.loop0:
	MovDqU		[rdi + rcx - 0x10], xmm0
	sub		rcx, 0x10
	jz		.ret
	test		rax, rcx
	jnz		.loop0

.loop1:
	dec		rcx
	mov		[rdi + rcx], sil
	jnz		.loop1

.ret:
	mov		rax, rdi
	mov		rsp, rbp
	pop		rbp
	ret
