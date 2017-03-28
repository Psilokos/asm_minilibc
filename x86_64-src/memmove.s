[BITS 64]

global memmove:function
extern memcpy

section .text

memmove:
	jmp	memcpy wrt ..plt
