; imm8 for SSE 4.2 string processing instructions (Pcmp[I/E]str[I/M])
%define SDF_UB		(0b00000000)
%define SDF_UW		(0b00000001)
%define SDF_SB		(0b00000010)
%define SDF_SW		(0b00000011)
%define AOP_EqAny	(0b00000000)
%define AOP_Ranges	(0b00000100)
%define AOP_EqEach	(0b00001000)
%define AOP_EqOrder	(0b00001100)
%define POL_Pos		(0b00000000)
%define POL_Neg		(0b00010000)
%define POL_PosMask	(0b00100000)
%define POL_NegMask	(0b00110000)
%define OS_LSI		(0b00000000) ; Pcmp[I/E]strI
%define OS_MSI		(0b01000000) ; Pcmp[I/E]strI
%define OS_bMask	(0b00000000) ; Pcmp[I/E]strM
%define OS_BWMask	(0b01000000) ; Pcmp[I/E]strM

%macro	fill_xmm_m32	2
	movss		%1, %2
	PunpckLBW	%1, %1
	PunpckLWD	%1, %1
	PunpckLDQ	%1, %1
	PunpckLQDq	%1, %1
%endmacro

%macro lowercase_xmm 1
	MovDqA		xmm2, %1
	MovDqA		xmm3, %1
	PcmpGtB		xmm2, xmm4
	PcmpGtB		xmm3, xmm5
	PandN		xmm3, xmm2
	Pand		xmm3, xmm6
	PaddUsB		%1, xmm3
%endmacro

section .text

debug:
	push	ebp
	mov	ebp, esp
	pusha
	mov	eax, 0x4
	mov	ebx, 0x1
	mov	ecx, msg
	mov	edx, 0x6
	int	0x80
	popa
	leave
	ret

section .rodata

	msg db	'debug', 0xa, 0x0
