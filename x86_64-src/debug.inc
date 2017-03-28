extern puts

%macro	pushaDq	0
	push	rax
	push	rbx
	push	rcx
	push	rdx
	push	rdi
	push	rsi
%endmacro

%macro	popaDq	0
	pop	rsi
	pop	rdi
	pop	rdx
	pop	rcx
	pop	rbx
	pop	rax
%endmacro

%macro	write	3
	push	rax
	lahf
	pushaDq
	mov	rax, 0x1
	mov	edi, %1
	mov	rsi, %2
	mov	rdx, %3
	syscall
	popaDq
	sahf
	pop	rax
%endmacro

%macro putstr 1
	push	rax
	lahf
	push	rax
	call	puts wrt ..plt
	pop	rax
	sahf
	pop	rax
%endmacro

section .rodata

	msg db	'debug', 0xa
