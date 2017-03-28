[BITS 32]

global strstr:function

%include "utils.inc"

section .text

strstr:
	push		ebp
	mov		ebp, esp
	mov		edi, [ebp + 0x8]
	mov		esi, [ebp + 0xc]
	mov		eax, edi
	xor		eax, esi
	jz		.ret
	mov		[esp - 0x4], ebx
	Pxor		xmm1, xmm1
	MovDqU		xmm4, [esi]
	jmp		.loop + 0x3

	sub		edi, 0xf
.loop:
	add		edi, 0x10
	PcmpIstrI	xmm4, [edi], AOP_EqOrder
	ja		.loop
	jnc		.not_found
	add		edi, ecx
	mov		eax, edi
	mov		ebx, esi
	sub		ebx, eax
	sub		eax, 0x10

.check_match:
	add		eax, 0x10
	MovDqU		xmm3, [eax + ebx]
	PcmpIstrM	xmm1, xmm3, AOP_EqEach + POL_Neg + OS_BWMask
	MovDqU		xmm2, [eax]
	Pand		xmm2, xmm0
	PcmpIstrI	xmm3, xmm2, AOP_EqEach + POL_Neg
	ja		.check_match
	jc		.loop - 0x3
	mov		eax, edi
	jmp		.ret

.not_found:
	xor		eax, eax

.ret:
	mov		ebx, [esp - 0x4]
	mov		esp, ebp
	pop		ebp
	ret
