#include "register_def.h"
#define REG(x) *(volatile unsigned int *)(x)

void main()
{
//we'll just turn on the LED 
	//starting clock for the following peripherals
	REG(RCC_APB2ENR) = (1 << RCC_APB2ENR_AFIOEN) | \
				(1 << RCC_APB2ENR_IOPAEN) | \
				(1 << RCC_APB2ENR_IOPCEN) | \
				(1 << RCC_APB2ENR_USART1EN);
	REG(GPIOC_CRH) |= 0b11 << 21; //setting pin 13 as output etc etc
	REG(GPIOC_BSRR) |= (1 << 29); //turning the LED on
	
	REG(GPIOA_CRH) |= (0b1110 << 4) | (0b0010 << 8); //setting PORTA-9 and PORTA-10 as output input respectively
	REG(USART1_CR1) |= (1 << USART1_CR1_UE) | (1 << USART1_CR1_TE) | (1 << USART1_CR1_RE);
	REG(USART1_BRR) |= (52 << 4) | 1;
	unsigned char x = 97;
	while(1)
	{
		if(x == (97 + 26))
		{
			x = 97;
		}
		while(!(REG(USART1_SR) & (1 << USART1_SR_TXE)));
		REG(USART1_DR) |= (unsigned int)x;
		x++;
	}
}