ENTRY(reset_handler)

_estack = 0x20005000;

_Min_Leftover_RAM = 0x400;

MEMORY
{
	FLASH ( rx ) : ORIGIN =  0x08000000, LENGTH = 128K
	RAM ( rwx ) : ORIGIN = 0x20000000, LENGTH = 20K
}
