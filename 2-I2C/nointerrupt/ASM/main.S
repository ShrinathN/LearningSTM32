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
//clocks config
		//enabling clocks for GPIOC, GPIOB and AFIO
		ldr r0, =RCC_APB2ENR
		ldr r1, =(1 << RCC_APB2ENR_IOPBEN) | (1 << RCC_APB2ENR_IOPCEN | 1)
		str r1, [r0]

		//enabling clock for I2C1
		ldr r0, =(RCC_APB1ENR)
		ldr r1, =((1 << 21))
		str r1, [r0, #0]

//GPIO config
	//LED init
		//setting PC13 LED as output
		ldr r0, =GPIOC_CRH
		ldr r1, =(0b10010 << 20)
		str r1, [r0]

		//turning on LED
		ldr r0, = GPIOC_BSRR
		ldr r1, =(1 << 29)
		str r1, [r0]

	//I2C pins init
		//setting PB6 and PB7 as AFOD
		ldr r0, =GPIOB_CRL
		ldr r1, =(0b11111111 << 24)
		str r1, [r0]

//I2C init
	//I2C_CR1 register, reseting peripheral
	//ldr r0, =(0x40005400 + 0x0)
	//ldr r1, =(1 << 15)
	//str r1, [r0]

	//I2C_CR2 register, setting FREQ as 8
	ldr r0, =(0x40005400 + 0x4)
	ldr r1, =(8)
	strh r1, [r0, #0]

	//I2C_CCR register, setting CCR as 500
	ldr r0, =(0x40005400 + 0x1c)
	ldr r1, =(500)
	strh r1, [r0, #0]

	//I2C_TRISE, setting max rise time as 9
	ldr r0, =(0x40005400 + 0x20)
	ldr r1, =(0x9)
	strh r1, [r0, #0]

	//I2C_CR1 register, enabling peripheral
	//ldr r0, =(0x40005400 + 0x0)
	//ldr r1, =(1)
	//strh r1, [r0, #0]

	//I2C_CR1 register, generating start condition
	ldr r0, =(0x40005400 + 0x0)
	ldr r1, =(1 << 8 | 1)
	strh r1, [r0, #0]

			//I2C_SR1 register, waiting for SB bit to be set
			ldr r0, =(0x40005400 + 0x14)
			ldr r2, =(1 << 0)
startcon:	ldrh r1, [r0, #0]
			and r1, r2
			cmp r1, r2
			bne startcon

	//I2C_DR register, sending the device address 0x4e
	ldr r0, =(0x40005400 + 0x10)
	ldr r1, =(0x4e)
	strh r1, [r0]

			//I2C_SR1 register, waiting while the address is sent
			ldr r0, =(0x40005400 + 0x14)
			ldr r2, =(1 << 1 | 1 << 7)
wait_addr:	ldrh r1, [r0, #0] //sr1
			ldrh r3, [r0, #4] //sr2
			and r1, r2
			cmp r1, r2
			bne wait_addr

			ldr r5, =0
			ldr r6, =0
			ldr r7, [r0, #0]

bigloop:	ldr r0, =(0x40005400 + 0x10)
			ldr r1, =(0x0)
			strh r1, [r0]

			ldr r0, = GPIOC_BSRR
			ldr r1, =(1 << 29)
			str r1, [r0]

			ldr r0, =(0x40005400 + 0x14)
			ldr r3, [r0, #0]

			//cmp r5, r6
			//beq skiper

			//waiting for byte to be sent
			ldr r0, =(0x40005400 + 0x14)
			ldr r2, =(1 << 7)
rep0:		ldr r1, [r0, #0]
			and r1, r2
			cmp r1, r2
			bne rep0

ghetto:
			//delay
			ldr r0, =4000000
			ldr r1, =0
wait0:		add r1,r1,#1
			cmp r0,r1
			bne wait0

			ldr r0, =GPIOC_BSRR
			ldr r1, =(1 << 13)
			str r1, [r0]

			//sending second data byte 0xff
			ldr r0, =(0x40005400 + 0x10)
			ldr r1, =(0xff)
			strh r1, [r0]

			//waiting for byte to be sent
			ldr r0, =(0x40005400 + 0x14)
			ldr r2, =(1 << 7)
rep1:		ldr r1, [r0, #0]
			and r1, r2
			cmp r1, r2
			bne rep1

			//delay
			ldr r0, =4000000
			ldr r1, =0
wait1:		add r1,r1,#1
			cmp r0,r1
			bne wait1

			b bigloop

skiper:		add r5,r5,#100
			b ghetto