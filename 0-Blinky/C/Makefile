CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy
NM = arm-none-eabi-nm

CFLAGS = -c -mthumb -mcpu=cortex-m3 -O6
ASFLAGS = -mthumb -mcpu=cortex-m3
LDFLAGS = -Tstm32f103c8t6.ld

all: vector_table.o boot.o main.o
	$(LD) $(LDFLAGS) $^ -o main.elf
	$(OBJCOPY) -O binary main.elf main.bin

debug: vector_table.o boot.o main.o
	$(CC) $(CFLAGS) -g $^ -o main.elf
	$(OBJCOPY) -O binary main.elf main.bin

main.o: main.c

boot.o: boot.S

vector_table.o: vector_table.S

clean:
	rm *.o *.hex *.elf *.bin
