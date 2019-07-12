.thumb
.cpu cortex-m3
.include "register_definitions.S"

.global reset_handler
.global USART1_routine
.include "vector_table.S"

.type reset_handler, %function
reset_handler:	ldr r0, =_estack
		mov sp, r0
		b main

.type main, %function
main:	
//setting up the clocks
	ldr r0, =RCC_CR_HSEON //RCC_CR = 1 << HSEON
	ldr r1, =RCC_CR
	str r0, [r1]
	
	//turning the RCC for the correct peripherals
	ldr r0, =( (1 << 0) | (1 << 4) | (1 << 2) | (1 << 14) )
	ldr r1, =RCC_APB2ENR
	str r0, [r1]

//running LED (PC13)
	//setting the LED on PC13 as output etc etc
	ldr r0, =0x40011004
	ldr r1, =(3 << 21)
	str r1, [r0]
	
//we now setup the USART
	//setting the baud rate
	ldr r0, =USART1_BRR
	ldr r1, =833
	str r1, [r0]
	
	//setting the pins PA9 and PA10 as I/O
	ldr r0, =(0b01001011 << 4)
	ldr r1, =GPIOA_CRH
	str r0, [r1]
	
	//enabling RX and TX, enabling RXIE interrupt
	ldr r0, =( (1 << 13) | (1 << 3) | (1 << 2) | (1 << 5) )
	ldr r1, =USART1_CR1
	str r0, [r1]

	//enabling NVIC interrupt
	ldr r0, =( 1 << 5 )
	ldr r1, =NVIC_ISER1
	str r0, [r1]

	//setting priority as 0
	ldr r0, =(0 << 15)
	ldr r1, =NVIC_IPR9
	str r0, [r1]
	
	cpsie i
	
	ldr r5, =3000000
	ldr r6, =200000

loop:	ldr r0, =0x40011010
	ldr r1, =(1 << 13)
	str r1, [r0]

	mov r0, r5
	ldr r1, =0
rep0:	add r1, r1, #1
	cmp r0,r1
	bne rep0


	ldr r0, =0x40011010
	ldr r1, =(1 << 29)
	str r1, [r0]

	mov r0, r6
	ldr r1, =0
rep1:	add r1, r1, #1
	cmp r0,r1
	bne rep1
	
	b loop

.type fault, %function

fault:	ldr r0, =0x40011010
	ldr r1, =(1 << 29)
	str r1, [r0]
	b fault

.type USART1_routine, %function
USART1_routine:	ldr r0, =0x40011010
		ldr r1, =(1 << 29)
		str r1, [r0]

		ldr r0, =USART1_DR
		ldr r1, ='a'
		str r1, [r0]
conf:		ldr r0, =USART1_SR
		ldr r1, [r0]
		ldr r2, =(1 << 7)
		and r1, r2
		cmp r1, r2
		bne conf

		//checking if RXNE is set or not
		ldr r0, =USART1_SR
		ldr r2, [r0]
		ldr r3, =(1 << 5)
		and r2, r3
		cmp r2, r3
		beq USART1_routine_RXNE
		b fault


.type USART1_routine_RXNE, %function
USART1_routine_RXNE:	ldr r0, =USART1_DR
			ldr r1, ='b'
			str r1, [r0]

			//clearing flag
			ldr r0, =USART1_SR
			ldr r1, =0xffffffef
			ldr r2, [r0]
			and r2, r1
			str r2, [r0]		

			//clearing interrupt
			ldr r0, =NVIC_ICPR1
			ldr r1, =(1 << 5)
			str r1, [r0]

			//modifying off time
			ldr r5, =1000000

			//jumping back
			b loop