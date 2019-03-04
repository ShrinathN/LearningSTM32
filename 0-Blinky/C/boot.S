.global Reset_routine

.type Reset_routine, %function

Reset_routine:	ldr r0, =_estack
		mov sp, r0
		
copy_sidata:	ldr r0, =_sidata
		ldr r1, =_sdata
		ldr r2, =_edata
		ldr r4, =0
		ldr r5, =4
repeat:		ldr r3, [r0, r4]
		str r3, [r1, r4]
		add r4,r4,r5
		add r3,r0,r4
		cmp r3, r2
		bcc repeat
		b main
		