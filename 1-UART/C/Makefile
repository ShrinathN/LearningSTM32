CC=arm-none-eabi-gcc
AS=arm-none-eabi-as
LD=arm-none-eabi-ld
OBJCOPY=arm-none-eabi-objcopy
NM=arm-none-eabi-nm
SIZE=arm-none-eabi-size

CFLAGS=-mthumb -mcpu=cortex-m3
LDFLAGS=-Tstm32f103c8t6.ld

all: main.hex

main.hex: main.elf
	$(OBJCOPY) -O ihex $^ main.hex
	
main.elf: main.o boot.o
	$(LD) $(LDFLAGS) $^ -o main.elf

boot.o: boot.S

main.o: main.c

clean:
	rm *.o *.elf *hex