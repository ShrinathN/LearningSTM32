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
//turning on the red LED
	//setting the APB2 clock
main:	ldr r0, =RCC_APB2ENR
	ldr r1, =((1 << RCC_APB2ENR_IOPCEN) | (1 << RCC_APB2ENR_IOPAEN) | (1 << RCC_APB2ENR_AFIOEN) | (1 << RCC_APB2ENR_USART1EN))
	str r1, [r0]
	
	ldr r0, =GPIOC_CRH
	ldr r1, =(0b11 << 21)
	str r1, [r0]
	
//setting up the USART on USART1
	//setting GPIO Pins
	ldr r0, =GPIOA_CRH
	ldr r1, =(0b10001011 << 4)
	str r1, [r0]
	//configuring USART1 control register 1
	ldr r0, =USART1_CR1
	ldr r1, =((1 << 13) | (1 << 3) | (1 << 2))
	str r1, [r0]
	//configuring BAUD rate register
	ldr r0, =USART1_BRR
	ldr r1, =((52 << 4) | 1)
	str r1, [r0]
	
	//loading r0 with address of USART1_DR
	ldr r2, =USART1_SR
	ldr r4, =(1 << 7)
loop:	ldr r0, =USART1_DR
	ldr r1, =96
loop2:	add r1, r1, #1
	str r1, [r0]
wait:	ldr r3, [r2, #0]
	and r3, r4
	cmp r3, #128
	bne wait
	cmp r1, #123
	bcc loop2
	b loop
	