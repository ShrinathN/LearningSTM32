
ENTRY(reset_handler)

_estack = 0x20005000;

_Min_Leftover_RAM = 0x400;

/*Since this is a simple linker script i think I should not use the sections yet...until I figure out how to reiably use them*/
MEMORY
{
    FLASH ( rx )    : ORIGIN = 0x08000000, LENGTH = 128K
    RAM ( rxw )     : ORIGIN = 0x20000000, LENGTH = 20K
}