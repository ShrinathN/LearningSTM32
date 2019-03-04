CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy

CFLAGS = -c -mthumb -mcpu=cortex-m3
ASFLAGS = -mthumb -mcpu=cortex-m3
LDFLAGS = -Tstm32f103c8t6.ld

all: main.o boot.o vector_table.o
	$(LD) $(LDFLAGS) $^ -o main.elf
	$(OBJCOPY) -O ihex main.elf main.hex

main.o: main.c

boot.o: boot.S

vector_table.o: vector_table.S

clean:
	rm *.o *.hex *.elf