.syntax unified
.cpu cortex-m3
.thumb

.global .vector_table
.type .vector_table, %object
.global reset_handler
.type reset_handler, %function
		
reset_handler:	ldr r0, =_estack
		mov sp, r0
		
		ldr r0, =0 //counter or offset
		ldr r1, =_sdataloc //local address
		ldr r2, =_sdatavir //virtual address
		ldr r3, =_edatavir //used for comparing
		
		//here we copy the .data section from the FLASH to RAM
		//copying from the local address to the virtual address
copy_loop_data:	ldr r4, [r1, r0]
		str r4, [r2, r0]
		add r0, r0, #4
		add r4, r0, r2
		cmp r4, r3
		bcc copy_loop_data
		
		//here we set the .bss section as all 0s
		ldr r0, =0 //register to contain 0
		ldr r1, =_sbssvir
		ldr r2, =_ebssvir
loop_zero_bss:	str r0, [r1]
		add r1, r1, #4
		cmp r1, r2
		bcc loop_zero_bss
		
		b main