[BITS 32]

global strcspn:function

%include "utils.inc"

section .text

strcspn:
	push		ebp
	mov		ebp, esp
	mov		edi, [ebp + 0x8]
	mov		esi, [ebp + 0xc]
	xor		eax, eax
	MovDqU		xmm0, [edi + eax]
	xor		edx, edx
	jmp		.loop + 0x3

.loop:
	add		edx, 0x10
	MovDqU		xmm1, [esi + edx]
	PcmpIstrI	xmm1, xmm0, AOP_EqAny
	jc		.ret
	jns		.loop
	jz		.str_length
	add		eax, 0x10
	jmp		.loop - 0x9

.str_length:
	Pxor		xmm1, xmm1
	PcmpIstrI	xmm1, xmm0, AOP_EqEach

.ret:
	add		eax, ecx
	mov		esp, ebp
	pop		ebp
	ret
