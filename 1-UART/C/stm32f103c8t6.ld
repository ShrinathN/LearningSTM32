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
		*(.text)
		*(.text*)
	} > FLASH
	
	.rodata :
	{
		*(.rodata)
		*(.rodata*)
	} > FLASH
	
	_sdataloc = .;
	.data :
	{
		_sdatavir = .;
		*(.data)
		*(.data*)
		_edatavir = .;
	} > RAM
	
	_sbssloc = .;
	.bss :
	{
		_sbssvir = .;
		*(.bss)
		*(.bss*)
		_ebssvir = .;
	} > RAM
	
	dynamic_allocations :
	{
		_ssystem_ram = .;
		. = . + _min_leftover_ram;
		_esystem_ram = .;
	} > RAM
}