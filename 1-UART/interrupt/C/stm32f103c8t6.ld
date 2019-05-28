ENTRY(reset_handler)

_estack = 0x20005000;

_min_leftover_ram = 0x400;

MEMORY
{
	FLASH ( rx ) : ORIGIN = 0x08000000, LENGTH = 128K
	RAM ( rwx ) : ORIGIN = 0x20000000, LENGTH = 20K
}

SECTIONS
{
	.vector_table :
	{
		. = ALIGN(4);
		KEEP(*(.vector_table))
		. = ALIGN(4);
	} > FLASH
	
	.text :
	{
		. = ALIGN(4);
		*(.text)
		*(.text*)
		. = ALIGN(4);
	} > FLASH
	
	.rodata :
	{
		. = ALIGN(4);	
		*(.rodata)
		*(.rodata*)
		. = ALIGN(4);		
	} > FLASH
	
	_sdataloc = .;
	.data :
	{
		. = ALIGN(4);	
		_sdatavir = .;
		*(.data)
		*(.data*)
		. = ALIGN(4);
		_edatavir = .;
		
	} > RAM
	
	_sbssloc = .;
	.bss :
	{
		. = ALIGN(4);
		_sbssvir = .;
		*(.bss)
		*(.bss*)
		. = ALIGN(4);
		_ebssvir = .;
	} > RAM
	
	dynamic_allocations :
	{
		. = ALIGN(4);
		_ssystem_ram = .;
		. = . + _min_leftover_ram;
		. = ALIGN(4);
		_esystem_ram = .;
	} > RAM
}