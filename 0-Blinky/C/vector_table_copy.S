.global vector_table
.global Reset_routine

.type vector_table, %object
vector_table:
	//reserved
	.word _estack
	//0x04
	.word Reset_routine
	//0x08
	.word NMI_routine
	//0x0C
	.word HardFault_routine
	//0x10
	.word MemManage_routine
	//0x14
	.word BusFault_routine
	//0x18
	.word UsageFault_routine
	//0x1c - 0x2b
	.word 0
	.word 0
	.word 0
	.word 0
	//0x2c
	.word SVCall_routine
	//0x30
	.word DebugMonitor_routine
	//0x34
	.word 0
	//0x38
	.word PendSV_routine
	//0x3c
	.word SysTick_routine
	//0x40
	.word WWDG_routine
	//0x44
	.word PVD_routine
	//0x48
	.word TAMPER_routine
	//0x4c
	.word RTC_routine
	//0x50
	.word FLASH_routine
	//0x54
	.word RCC_routine
	//0x58
	.word EXTI0_routine
	//0x5c
	.word EXTI1_routine
	//0x60
	.word EXTI2_routine
	//0x64
	.word EXTI3_routine
	//0x68
	.word EXTI4_routine
	//0x6c
	.word DMA1_Channel1_routine
	//0x70
	.word DMA1_Channel2_routine
	//0x74
	.word DMA1_Channel3_routine
	//0x78
	.word DMA1_Channel4_routine
	//0x7c
	.word DMA1_Channel5_routine
	//0x80
	.word DMA1_Channel6_routine
	//0x84
	.word DMA1_Channel7_routine
	//0x88
	.word ADC1_2_routine
	//0x8c
	.word USB_HP_CAN_TX_routine
	//0x90
	.word USB_LP_CAN_RX0_routine
	//0x94
	.word CAN_RX1_routine
	//0x98
	.word CAN_SCE_routine
	//0x9c
	.word EXTI9_5_routine
	//0xa0
	.word TIM1_BRK_routine
	//0xa4
	.word TIM1_UP_routine
	//0xa8
	.word TIM1_TRG_COM_routine
	//0xac
	.word TIM1_CC_routine
	//0xb0
	.word TIM2_routine
	//0xb4
	.word TIM3_routine
	//0xb8
	.word TIM4_routine
	//0xbc
	.word I2C1_EV_routine
	//0xc0
	.word I2C1_ER_routine
	//0xc4
	.word I2C2_EV_routine
	//0xc8
	.word I2C2_ER_routine
	//0xcc
	.word SPI1_routine
	//0xd0
	.word SPI2_routine
	//0xd4
	.word USART1_routine
	//0xd8
	.word USART2_routine
	//0xdc
	.word USART3_routine
	//0xe0
	.word EXTI15_10_routine
	//0xe4
	.word RTCAlarm_routine
	//0xe8
	.word USBWakeup_routine
	//0xec
	.word TIM8_BRK_routine
	//0xf0
	.word TIM8_UP_routine
	//0xf4
	.word TIM8_TRG_COM_routine
	//0xf8
	.word TIM8_CC_routine
	//0xfc
	.word ADC3_routine
	//0x100
	.word FSMC_routine
	//0x104
	.word SDIO_routine
	//0x108
	.word TIM5_routine
	//0x10c
	.word SPI3_routine
	//0x110
	.word UART4_routine
	//0x114
	.word UART5_routine
	//0x118
	.word TIM6_routine
	//0x11c
	.word TIM7_routine
	//0x120
	.word DMA2_Channel1_routine
	//0x124
	.word DMA2_Channel2_routine
	//0x128
	.word DMA2_Channel3_routine
	//0x12c
	.word DMA2_Channel4_5_routine
	
	
	//we are going to set all of the above vectors as weak
	//please declare them in case you're using them
	.weak NMI_routine
	.weak HardFault_routine
	.weak MemManage_routine
	.weak BusFault_routine
	.weak UsageFault_routine
	.weak SVCall_routine
	.weak DebugMonitor_routine
	.weak PendSV_routine
	.weak SysTick_routine
	.weak WWDG_routine
	.weak PVD_routine
	.weak TAMPER_routine
	.weak RTC_routine
	.weak FLASH_routine
	.weak RCC_routine
	.weak EXTI0_routine
	.weak EXTI1_routine
	.weak EXTI2_routine
	.weak EXTI3_routine
	.weak EXTI4_routine
	.weak DMA1_Channel1_routine
	.weak DMA1_Channel2_routine
	.weak DMA1_Channel3_routine
	.weak DMA1_Channel4_routine
	.weak DMA1_Channel5_routine
	.weak DMA1_Channel6_routine
	.weak DMA1_Channel7_routine
	.weak ADC1_2_routine
	.weak USB_HP_CAN_TX_routine
	.weak USB_LP_CAN_RX0_routine
	.weak CAN_RX1_routine
	.weak CAN_SCE_routine
	.weak EXTI9_5_routine
	.weak TIM1_BRK_routine
	.weak TIM1_UP_routine
	.weak TIM1_TRG_COM_routine
	.weak TIM1_CC_routine
	.weak TIM2_routine
	.weak TIM3_routine
	.weak TIM4_routine
	.weak I2C1_EV_routine
	.weak I2C1_ER_routine
	.weak I2C2_EV_routine
	.weak I2C2_ER_routine
	.weak SPI1_routine
	.weak SPI2_routine
	.weak USART1_routine
	.weak USART2_routine
	.weak USART3_routine
	.weak EXTI15_10_routine
	.weak RTCAlarm_routine
	.weak USBWakeup_routine
	.weak TIM8_BRK_routine
	.weak TIM8_UP_routine
	.weak TIM8_TRG_COM_routine
	.weak TIM8_CC_routine
	.weak ADC3_routine
	.weak FSMC_routine
	.weak SDIO_routine
	.weak TIM5_routine
	.weak SPI3_routine
	.weak UART4_routine
	.weak UART5_routine
	.weak TIM6_routine
	.weak TIM7_routine
	.weak DMA2_Channel1_routine
	.weak DMA2_Channel2_routine
	.weak DMA2_Channel3_routine
	.weak DMA2_Channel4_5_routine
.size vector_table, .-vector_table