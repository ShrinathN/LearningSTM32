.thumb
.cpu cortex-m3
.include "register_definitions.S"
.include "vector_table.S"

.global reset_handler
.global USART1_routine

.type reset_handler, %function
reset_handler:	ldr r0, =_estack
		mov sp, r0
		b main

.type USART1_routine, %function
USART1_routine:	ldr r0, =0x40011010
		ldr r1, =(1 << 29)
		str r1, [r0]
led_off:		b led_off

.type main, %function
main:	
//setting up the clocks
	ldr r0, =RCC_CR_HSEON //RCC_CR = 1 << HSEON
	ldr r1, =RCC_CR
	str r0, [r1]
	
	//turning the RCC for the correct peripherals
	ldr r0, =( (1 << RCC_APB2ENR_AFIOEN) | (1 << RCC_APB2ENR_IOPCEN) | (1 << RCC_APB2ENR_IOPAEN) | (1 << RCC_APB2ENR_USART1EN) )
	ldr r1, =RCC_APB2ENR
	str r0, [r1]

//running LED (PC13)
	//setting the LED on PC13 as output etc etc
	ldr r0, =0x40011004
	ldr r1, =(3 << 21)
	str r1, [r0]
	
	//turning on the LED
	ldr r0, =0x40011010
	ldr r1, =(1 << 29)
	str r1, [r0]

//we now setup the USART
	//setting the baud rate
	ldr r0, =USART1_BRR
	ldr r1, =833
	str r1, [r0]
	
	//setting the pins PA9 and PA10 as I/O
	ldr r0, =( (0b1011 << 4) | (0b1000 << 8) )
	ldr r1, =GPIOA_CRH
	str r0, [r1]
	
	//enabling RX and TX
	ldr r0, =( (1 << 13) | (1 << 3) | (1 << 2) | (1 << 7) )
	ldr r1, =USART1_CR1
	
//sending the byte '#' indefinitely
	
repeat:	ldr r0, =USART1_SR
	ldr r1, [r0]
	ldr r2, =(1 << 7)
	and r1, r2
	cmp r1, #(1 << 7)
	bne repeat
	ldr r2, =USART1_DR
	ldr r3, =98
	str r3, [r2]
	b repeat