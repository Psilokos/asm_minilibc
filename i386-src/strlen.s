[BITS 32]

global strlen:function

section .text

strlen:
	push		ebp
	mov		ebp, esp
	mov		edi, [ebp + 0x8]
	mov		eax, -0x10
	pxor		xmm0, xmm0

.loop:
	add		eax, 0x10
	PcmpIstrI	xmm0, [edi + eax], 0b1000
	jnc		.loop
	add		eax, ecx
	mov		esp, ebp
	pop		ebp
	ret
