section .bss                            ;Uninitialized data
        input   resb    36              ;declare input length

section .text
	global _start			;must be declared for linker (ld)

_start:					;tells linker entry point
	mov	edx, lenMsgInput	;message length
	mov	ecx, msgInput		;message to write
	mov	ebx, 1			;file descriptor (stdout)
	mov	eax, 4			;system call number (sys_write)
	int	0x80			;call kernel

	;Read and store the user input
	mov	eax, 3
	mov	ebx, 2
	mov	ecx, input
	mov	edx, 36			;36 bytes (flag input)
	int	0x80

	mov	ecx, input			;Nasm would use "offset"
	mov	esi, secret
top:
	mov	al, [ecx] ; get a character
	mov	edi, eax
	mov	al, [esi]
	inc	ecx  ; get ready for next one
	inc	esi
	; do something intelligent with al
	cmp	ebp, 0x24
	jz	done
	xor	edi, 0x3f ; xor input per char with 0x3f
	cmp	edi, eax
	jne	lose
	inc	ebp
	jmp	top
lose:
	mov	edx, lenMsgFalse
	mov	ecx, msgFalse
	mov	ebx, 1
	mov	eax, 4
	int	0x80
	jmp	exit

done:
	mov	edx, lenMsgTrue
	mov	ecx, msgTrue
	mov	ebx, 1
	mov	eax, 4
	int	0x80
	jmp	exit

exit:
	;Exit code
	mov	eax, 1			;system all number (sys_exit)
	int	0x80			;call kernel

section .data
	msgInput 	db 'Input flag : '		;message input header
	lenMsgInput 	equ $ - msgInput		;length message input header
	msgTrue		db 'Yeah you win!!!', 0xa	;message if true
	lenMsgTrue	equ $ - msgTrue			;length message if true
	msgFalse	db 'Ooh no you lose!!!', 0xa	;message if false
	lenMsgFalse	equ $ - msgFalse		;length message if false
	secret		db "}M^WR^Q^|kyD]^LV\`^LLZR]SF`POZM^KPMB";
