section .text:
	global _start
_start:
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, 12
	mov	edx, 3
	int	0x80
	mov	eax, 1
	mov	ebx, 0
	int	0x80
