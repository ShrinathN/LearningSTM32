#include <stm32f10x.h>

void delay(unsigned long x)
{
	while(x--)
		asm("nop");
}

int main()
{
	SystemInit();
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOC, ENABLE);
	GPIO_InitTypeDef gpio;
	gpio.GPIO_Mode = GPIO_Mode_Out_PP;
	gpio.GPIO_Pin = GPIO_Pin_13;
	gpio.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_Init(GPIOC, &gpio);
	while(1)
	{
		GPIO_SetBits(GPIOC, GPIO_Pin_13);
		delay(8000000);
		GPIO_ResetBits(GPIOC, GPIO_Pin_13);
		delay(8000000);
	}
}
