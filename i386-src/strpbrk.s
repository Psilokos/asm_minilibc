[BITS 32]

global strpbrk:function

%include "utils.inc"

section .text

strpbrk:
	push		ebp
	mov		ebp, esp
	mov		edi, [ebp + 0x8]
	mov		esi, [ebp + 0xc]
	MovDqU		xmm0, [edi]
	xor		eax, eax
	jmp		.loop + 0x3

.loop:
	add		eax, 0x10
	MovDqU		xmm1, [esi + eax]
	PcmpIstrI	xmm1, xmm0, AOP_EqAny
	jc		.found
	jz		.not_found
	jns		.loop
	add		edi, 0x10
	jmp		strpbrk + 0x9

.found:
	mov		eax, edi
	add		eax, ecx
	jmp		.ret

.not_found:
	xor		eax, eax

.ret:
	mov		esp, ebp
	pop		ebp
	ret
