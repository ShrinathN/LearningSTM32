#define RCC_BASE 0x40021000
#define RCC_APB2ENR *((volatile unsigned int *)(RCC_BASE + 0x18))

#define GPIOC_BASE 0x40011000
#define GPIOC_CRH *((volatile unsigned int *)(GPIOC_BASE + 0x04))
#define GPIOC_BSRR *((volatile unsigned int *)(GPIOC_BASE + 0x10))
void main()
{
	RCC_APB2ENR = 1 << 4;
	GPIOC_CRH |= 0b11 << 21;
	GPIOC_BSRR |= (1 << 29);
	while(1)
	{
	}
}