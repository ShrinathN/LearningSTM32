.global reset_handler
.global _main

.global vtable
.global reset_handler

.type vtable, %object

vtable:
	.word _estack
	.word reset_handler
.size vtable, .-vtable


.type reset_handler, %function
reset_handler:	ldr r0, =_estack
		mov sp, r0
		b _main
		
		
_main:	ldr r0, =0x40021018 //rcc_ABP2ENR register
	ldr r1, =16
	str r1, [r0]
	
	
	//gpioc base = 0x40011000
	//gpioc crh =  0x40011004
	//gpioc odr =  0x40011008
	//gpioc bssr = 0x40011010
	
	//setting GPIOC_CRH = (3 << 21), output mode, pin 13, 50MHz speed
	ldr r0, =0x40011004
	ldr r1, =(3 << 21)
	str r1, [r0]
	
	//setting GPIOC_BSSR
	ldr r0, =0x40011010
	ldr r1, =(1 << 29)
	str r1, [r0]
	
here:	b here
	