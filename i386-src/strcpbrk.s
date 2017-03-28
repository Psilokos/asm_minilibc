[BITS 32]

global strcpbrk:function

%include "utils.inc"

section .text

strcpbrk:
	push		ebp
	mov		ebp, esp
	mov		edi, [ebp + 0x8]
	mov		esi, [ebp + 0xc]
	MovDqU		xmm0, [edi]
	xor		eax, eax
	jmp		.loop + 0x3

.loop:
	add		eax, 0x10
	MoVDqU		xmm1, [esi + eax]
	PcmpIstrI	xmm1, xmm0, AOP_EqAny + POL_NegMask
	jc		.found
	js		.ret - 0x3
	jnz		.loop
	add		edi, 0x10
	jmp		.loop - 0x8

.found:
	mov		eax, edi
	add		eax, ecx
	jmp		.ret

	xor		eax, eax
.ret:
	mov		esp, ebp
	pop		ebp
	ret
