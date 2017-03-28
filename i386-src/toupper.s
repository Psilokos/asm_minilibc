[BITS 32]

global toupper:function

section .text

toupper:
	push	ebp
	mov	ebp, esp
	movzx	eax, byte [ebp + 0x8]
	cmp	al, 0x61
	jc	.ret
	cmp	al, 0x7a
	ja	.ret
	sub	al, 0x20

.ret:
	mov	esp, ebp
	pop	ebp
	ret
