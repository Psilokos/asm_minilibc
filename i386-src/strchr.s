[BITS 32]

global strchr:function

%include "utils.inc"

section .text

strchr:
	push		ebp
	mov		ebp, esp
	mov		edi, [ebp + 0x8]
	fill_xmm_m32	xmm0, [ebp + 0xc]
	mov		eax, -0x10

.loop:
	add		eax, 0x10
	PcmpIstrI	xmm0, [edi + eax], 0b1000
	ja		.loop
	jc		.found
	xor		eax, eax
	jmp		.ret

.found:
	add		eax, edi
	add		eax, ecx

.ret:
	mov		esp, ebp
	pop		ebp
	ret
