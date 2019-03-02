.global vtable
.global reset_handler
.global _main


vtable:
	.word _estack
	.word reset_handler

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
	
loop:	//turning LED off
	//setting GPIOC_BSSR
	ldr r0, =0x40011010
	ldr r1, =(1 << 13)
	str r1, [r0]
	mov r5, pc
	b delay

	//turning LED on
	//resetting GPIOC_BSSR
	ldr r0, =0x40011010
	ldr r1, =(1 << 29)
	str r1, [r0]
	mov r5, pc
	b delay
	
	b loop

.type delay, %function

delay:	ldr r2,=0
	ldr r1,=1
	ldr r3,=1000000
redo1:	add r2,r2,r1
	cmp r2, r3
	bne redo1
	mov pc,r5