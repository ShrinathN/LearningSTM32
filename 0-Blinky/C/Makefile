CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OBJCOPY = arm-none-eabi-objcopy

AFLAGS = -mthumb -mcpu=cortex-m3
LFLAGS = -Tstm32f103c8t6.ld

all: main.S
	$(AS) $(AFLAGS) $^ -o main.o
	$(LD) $(LFLAGS) main.o -o main.elf
	$(OBJCOPY) -O ihex main.elf main.hex

clean:
	rm main.o main.elf main.hex