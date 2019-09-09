.thumb
.cpu cortex-m3
.include "register_definitions.S"
.global vector_table
.global reset_handler

.type vector_table, %object
vector_table:	.word _estack
		.word reset_handler
		
.type reset_handler, %function
reset_handler:	ldr r0, =_estack
		mov sp, r0
		b main
		
.type main, %function
main: