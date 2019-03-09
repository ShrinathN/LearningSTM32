.thumb
.cpu cortex-m3
.include "register_definitions.S"
.global vector_table
.global reset_handler

//.type vector_table, %object
vector_table:	.word _estack
		.word reset_handler
		
.type reset_handler, %function
reset_handler:	ldr r0, =_estack
		mov sp, r0
		b main
		
main:	ldr r0, =RCC_APB2ENR
	ldr r1, =(1 << 0x4)
	str r1, [r0]
	
	ldr r0, =GPIOC_CRH
	ldr r1, =(0b11 << 21)
	str r1, [r0]
	
	ldr r0, =GPIOC_BSRR
	ldr r1, =(1 << 29)
	str r1, [r0]
	
here:	b here
