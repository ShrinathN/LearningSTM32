#include "register_defs.h"

#define __IO(x) *((volatile unsigned int *)x)

void delay(unsigned int x)
{
	while(x--)
		asm("nop");
}
unsigned int off_time = 3000000;
unsigned on_time = 200000;

//functions
void USART1_routine(void);
void USART1_routine_RXNE(void);


void main()
{
	__IO(RCC_APB2ENR) = ((1 << 0) | (1 << 4) | (1 << 2) | (1 << 14));
	__IO(GPIOC_CRH) |= 0b11 << 21;	
	__IO(USART1_BRR) = 833;
	__IO(GPIOA_CRH) = (0b01001011 << 4);
	__IO(USART1_CR1) |= ( (1 << 13) | (1 << 3) | (1 << 2) | (1 << 5) );
	__IO(NVIC_ISER1) |= ( 1 << 5 );
	while(1)
	{
		__IO(GPIOC_BSRR) = (1 << 13);
		delay(off_time);
		__IO(GPIOC_BSRR) = (1 << 29);
		delay(on_time);
	}
}

void USART1_routine(void)
{

	if(__IO(USART1_SR) & (1 << 5)) //meaning its RXNE
	{
		__IO(USART1_SR) &= 0xffffffef;
		__IO(NVIC_ICPR1) |= (1 << 5);
		while(!(__IO(USART1_SR) & (1 << 7))){};
		__IO(USART1_DR) = 'a';
		USART1_routine_RXNE();
	}
	return;
}

void USART1_routine_RXNE(void)
{
	while(!(__IO(USART1_SR) & (1 << 7))){};
	__IO(USART1_DR) = 'b';
	off_time = 1000000;
	return;
}