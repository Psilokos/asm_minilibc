[BITS 32]

global rindex:function
global strrchr:function
extern strlen

%include "utils.inc"

section .text

rindex:
strrchr:
	push		ebp
	mov		ebp, esp
	mov		edi, [ebp + 0x8]
	or		DWORD [ebp + 0xc], 0x0
	jz		.length
	fill_xmm_m32	xmm0, [ebp + 0xc]
	mov		eax, -0x10
	push		ebx
	xor		ebx, ebx

.loop:
	add		eax, 0x10
	PcmpIstrI	xmm0, [edi + eax], AOP_EqEach | OS_MSI
	ja		.loop
	jnc		.ret
	mov		ebx, edi
	add		ebx, eax
	add		ebx, ecx
	jmp		.loop

.length:
	push		edi
	call		strlen
	pop		edi
	add		eax, edi
	jmp		.ret + 0x3

.ret:
	mov		eax, ebx
	pop		ebx
	mov		esp, ebp
	pop		ebp
	ret
