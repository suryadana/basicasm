section	.text
	global	_start
_start:
	; Operation code
	mov	eax, 1160
	sub	eax, 23
	mov	edi, eax
	; Output buffer
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, edi
	mov	edx, 10
	int	0x80
	; Exit code
	mov	eax, 1
	int	0x80
