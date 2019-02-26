.syntax unified
.cpu cortex-m3
.thumb

.global vtable
.global reset_handler

.type vtable, %object
vtable:
	.word _estack
	.word reset_handler
.size vtable, .-vtable

.type reset_handler, %function
reset_handler:
	LDR R0, =_estack
	MOV SP, R0

	LDR R7,=0xDEADBEEF
	MOVS R0, #0
	main_loop:
		ADDS R0, R0, #1
		B main_loop
.size reset_handler, .-reset_handler
