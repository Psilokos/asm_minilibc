[BITS 32]

global strncasecmp:function
extern tolower

%include "utils.inc"

section .text

strncasecmp:
	push		ebp
	mov		ebp, esp
	mov		edx, [ebp + 0x10]
	or		edx, 0x0
	jz		.eq
	MovDqA		xmm4, [rel upper_a]
	MovDqA		xmm5, [rel upper_z]
	MovDqA		xmm6, [rel diff_aA]
	mov		edi, [ebp + 0x8]
	mov		esi, [ebp + 0xc]
	mov		eax, -0x10

.loop:
	add		eax, 0x10
	MovDqU		xmm0, [edi + eax]
	MovDqU		xmm1, [esi + eax]
	lowercase_xmm	xmm0
	lowercase_xmm	xmm1
	PcmpIstrI	xmm0, xmm1, 0b11000
	jc		.diff
	jz		.eq
	add		ecx, eax
	cmp		edx, ecx
	jna		.eq
	jmp		.loop

.diff:
	add		ecx, eax
	mov		dl, [esi + ecx]
	push		dx
	call		tolower
	mov		edx, eax
	mov		al, [edi + ecx]
	mov		[esp], al
	call		tolower
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

section .data

align 16
upper_a:	times 16 db 0x40
upper_z:	times 16 db 0x5a
diff_aA:	times 16 db 0x20
