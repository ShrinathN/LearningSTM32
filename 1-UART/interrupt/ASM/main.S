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
main:	ldr r0, =RCC_CR_HSEON //RCC_CR = 1 << HSEON
	ldr r1, =RCC_CR
	str r0, [r1]
	
	//turning the RCC for the correct peripherals
	ldr r0, =( (1 << RCC_APB2ENR_AFIOEN) | (1 << RCC_APB2ENR_IOPCEN) | (1 << RCC_APB2ENR_IOPAEN) | (1 << RCC_APB2ENR_USART1EN) )
	ldr r1, =RCC_APB2ENR
	str r0, [r1]
	
	//setting the pins PA9 and PA10 as I/O
	ldr r0, 
	
	//setting the LED on PC13 as output etc etc
	ldr r0, =0x40011004
	ldr r1, =(3 << 21)
	str r1, [r0]
	//turning on the LED
	ldr r0, =0x40011010
	ldr r1, =(1 << 29)
	str r1, [r0]
	
	//setting the baud rate
	ldr r0, =USART_BRR
	ldr r1, =833
	str r1, [r0]
	
	//enabling RX and TX
	
here:	b here