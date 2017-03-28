[BITS 32]

global memmove:function
extern memcpy

section .text

memmove:
	jmp	memcpy
