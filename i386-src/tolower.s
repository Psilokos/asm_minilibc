[BITS 32]

global tolower:function

section .text

tolower:
	push	ebp
	mov	ebp, esp
	movzx	eax, byte [ebp + 0x8]
	cmp	al, 0x41
	jc	.ret
	cmp	al, 0x5a
	ja	.ret
	add	al, 0x20

.ret:
	mov	esp, ebp
	pop	ebp
	ret
