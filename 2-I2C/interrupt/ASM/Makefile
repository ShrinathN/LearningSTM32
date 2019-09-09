AS = arm-none-eabi-as
LD = arm-none-eabi-ld
CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
ASFLAGS = -mthumb -mcpu=cortex-m3
LDFLAGS = -Tlinker_script.ld

all: main.hex

main.hex: main.elf
	$(OBJCOPY) $^ -O ihex main.hex

main.elf: main.o
	$(LD) $(LDFLAGS) $^ -o main.elf

main.o: main.S

clean:
	rm main.o main.hex main.elf
	
flash: main.hex
	stm32flash -w main.hex /dev/ttyUSB0
	stm32flash -g 0x0 /dev/ttyUSB0