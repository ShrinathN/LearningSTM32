CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy
SIZE = arm-none-eabi-size
NM = arm-none-eabi-nm
CFLAGS = -x assembler-with-cpp -mthumb -mcpu=cortex-m3 -O0 --specs=nosys.specs -nostdlib -lgcc
LDFLAGS = -Tlscript_custom.ld

SERIAL = /dev/ttyUSB0
FLASH = stm32flash -w main.hex $(SERIAL)
RUN = stm32flash -g 0x0 $(SERIAL)

all:
	$(CC) $(LDFLAGS) $(CFLAGS) main.S -o main.elf
	$(OBJCOPY) -O ihex main.elf main.hex
	$(SIZE) main.elf
	$(NM) main.elf
	$(FLASH)
	$(RUN)
	
clean:
	rm main.hex main.elf