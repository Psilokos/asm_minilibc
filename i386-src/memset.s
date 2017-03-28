[BITS 32]

global memset:function

%include "utils.inc"

section .text

memset:
	push		ebp
	mov		ebp, esp
	mov		edi, [ebp + 0x8]
	mov		ecx, [ebp + 0x10]
	or		ecx, 0x0
	jz		.ret
	mov		eax, 0b1111
	not		eax
	test		eax, ecx
	jz		.loop1 - 0x3
	fill_xmm_m32	xmm0, [ebp + 0xc]

.loop0:
	MovDqU		[edi + ecx - 0x10], xmm0
	sub		ecx, 0x10
	jz		.ret
	test		eax, ecx
	jnz		.loop0

	mov		dl, [ebp + 0xc]
.loop1:
	dec		ecx
	mov		[edi + ecx], dl
	jnz		.loop1

.ret:
	mov		eax, edi
	mov		esp, ebp
	pop		ebp
	ret
