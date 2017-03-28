[BITS 32]

global memcpy:function

section .text

memcpy:
	push	ebp
	mov	ebp, esp
	mov	edi, [ebp + 0x8]
	mov	esi, [ebp + 0xc]
	mov	ecx, [ebp + 0x10]
	or	ecx, 0x0
	jz	.ret
	mov	eax, 0b1111
	not	eax
	test	eax, ecx
	jz	.loop1

.loop0:
	MovDqu	xmm0, [esi + ecx - 0x10]
	MovDqU	[edi + ecx - 0x10], xmm0
	sub	ecx, 0x10
	jz	.ret
	test	eax, ecx
	jnz	.loop0

.loop1:
	dec	ecx
	mov	al, [esi + ecx]
	mov	[edi + ecx], al
	jnz	.loop1

.ret:
	mov	eax, edi
	mov	esp, ebp
	pop	ebp
	ret
