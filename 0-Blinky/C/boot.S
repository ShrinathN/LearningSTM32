.global Reset_routine

.type Reset_routine, %function

Reset_routine:	ldr r0, =_estack
		mov sp, r0
		b _main	

.thumb_set RCC_APB2ENR, 0x40021018
.thumb_set GPIOC_CRH, 0x40011004
.thumb_set GPIOC_BSRR, 0x40011010

_main:		
copying_data:	ldr r0, =0 //this is a counter
		ldr r1, =_sdata //starting of .data
		ldr r2, =_edata //ending of .data
		ldr r3, =_sidata //current position
		b data_copyi
		
data_copy:	ldr r4, [r3, r0] //loading from *(_sidata + r0) to r4
		str r4, [r1, r0] //storing r4 to *(_sdata + r0)
		add r0, r0, #4 //incrementing r0 by a word
data_copyi:	add r4, r1, r0
		cmp r4, r2
		bcc data_copy
		
bss_zeroing:	ldr r0, =_sbss
		ldr r1, =_ebss
		ldr r2, =0
bss_zeroing0:	str r2, [r0]
		add r0,r0,#4
		cmp r0, r1
		bcc bss_zeroing0
		
		b main