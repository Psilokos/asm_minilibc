[BITS 32]

global strcmp:function

section .text

strcmp:
	push		ebp
	mov		ebp, esp
	mov		edi, [ebp + 0x8]
	mov		esi, [ebp + 0xc]
	mov		eax, -0x10

.loop:
	add		eax, 0x10
	MovDqU		xmm0, [esi + eax]
	PcmpIstrI	xmm0, [edi + eax], 0b11000
	ja		.loop
	jc		.diff
	xor		eax, eax
	jmp		.ret

.diff:
	add		ecx, eax
	movzx		eax, byte [edi + ecx]
	movzx		edx, byte [esi + ecx]
	cmp		ecx, 0x18
	jc		.weird
	sub		eax, edx

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
