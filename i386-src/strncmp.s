[BITS 32]

global strncmp:function

%include "utils.inc"

section .text

strncmp:
	push		ebp
	mov		ebp, esp
	mov		edx, [ebp + 0x10]
	or		edx, 0x0
	jz		.eq
	mov		edi, [ebp + 0x8]
	mov		esi, [ebp + 0xc]
	mov		eax, -0x10

.loop:
	add		eax, 0x10
	MovDqU		xmm0, [esi + eax]
	PcmpIstrI	xmm0, [edi + eax], AOP_EqEach + POL_Neg
	jc		.diff
	jz		.eq
	add		ecx, eax
	cmp		edx, ecx
	jna		.eq
	jmp		.loop

.diff:
	add		ecx, eax
	cmp		edx, ecx
	jna		.eq
	movzx		eax, BYTE [edi + ecx]
	movzx		edx, BYTE [esi + ecx]
	cmp		ecx, 0x18
	jc		.weird
	sub		eax, edx
	jmp		.ret

.eq:
	xor		eax, eax

.ret:
	mov		esp, ebp
	pop		ebp
	ret

.weird:
	cmp		eax, edx
	jge		.weird_greater
	mov		eax, -0x1
	jmp		.ret

.weird_greater:
	mov		eax, 0x1
	jmp		.ret
