[BITS 64]

global strncasecmp:function
extern tolower

%include "utils.inc"

section .text

strncasecmp:
	push		rbp
	mov		rbp, rsp
	or		rdx, 0x0
	jz		.eq
	MovDqA		xmm4, [rel upper_a]
	MovDqA		xmm5, [rel upper_z]
	MovDqA		xmm6, [rel diff_aA]
	mov		rax, -0x10

.loop:
	add		rax, 0x10
	MovDqU		xmm0, [rdi + rax]
	MovDqU		xmm1, [rsi + rax]
	lowercase_xmm	xmm0
	lowercase_xmm	xmm1
	PcmpIstrI	xmm0, xmm1, 0b11000
	jc		.diff
	jz		.eq
	add		rcx, rax
	cmp		rdx, rcx
	jna		.eq
	jmp		.loop

.diff:
	add		rcx, rax
	push		rdi
	mov		dil, [rsi + rcx]
	call		tolower wrt ..plt
	mov		rdx, rax
	pop		rdi
	mov		dil, [rdi + rcx]
	call		tolower wrt ..plt
	sub		rax, rdx
	jmp		.ret

.eq:
	xor		rax, rax

.ret:
	mov		rsp, rbp
	pop		rbp
	ret

section .data

align 16
upper_a:	times 16 db 0x40
upper_z:	times 16 db 0x5a
diff_aA:	times 16 db 0x20
