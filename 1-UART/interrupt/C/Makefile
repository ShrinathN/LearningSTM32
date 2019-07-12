CC=arm-none-eabi-gcc
AS=arm-none-eabi-as
LD=arm-none-eabi-ld
OBJCOPY=arm-none-eabi-objcopy
NM=arm-none-eabi-nm
SIZE=arm-none-eabi-size

CFLAGS=-mthumb -mcpu=cortex-m3 -O0
LDFLAGS=-Tstm32f103c8t6.ld

PORT=/dev/ttyUSB0

all: main.hex

main.hex: main.elf
	$(OBJCOPY) -O ihex $^ main.hex
	
main.elf: vector_table.o boot.o main.o
	$(LD) $(LDFLAGS) $^ -o main.elf

vector_table.o: vector_table.S

boot.o: boot.S

main.o: main.c

clean:
	rm *.o *.elf *hex
	
flash: main.hex
	stm32flash -w $^ $(PORT)
	stm32flash -g 0x0 $(PORT)