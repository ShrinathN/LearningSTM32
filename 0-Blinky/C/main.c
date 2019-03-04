#define RCC_BASE 0x40021000
#define RCC_APB2ENR *((volatile unsigned int *)(RCC_BASE + 0x18))

#define GPIOC_BASE 0x40011000
#define GPIOC_CRH *((volatile unsigned int *)(GPIOC_BASE + 0x04))
#define GPIOC_BSRR *((volatile unsigned int *)(GPIOC_BASE + 0x10))

void delay(unsigned int da)
{
	while(da--);
}

void main()
{
	RCC_APB2ENR = 1 << 4;
	GPIOC_CRH |= 0b11 << 21;
	//GPIOC_CRH &= ~(0b00) < 23;
	while(1)
	{	
		GPIOC_BSRR |= (1 << 29);
		delay(1000000);
		GPIOC_BSRR |= (1 << 13);
		delay(1000000);
	}
}
