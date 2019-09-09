AS = arm-none-eabi-as
LD = arm-none-eabi-ld
CC = arm-none-eabi-gcc
OBJCOPY = arm-none-eabi-objcopy
ASFLAGS = -g -mthumb -mcpu=cortex-m3
LDFLAGS = -g -Tlinker_script.ld

all: main.bin
	st-flash write $^ 0x8000000

main.bin: main.elf
	$(OBJCOPY) $^ -O binary main.bin

main.elf: main.o
	$(LD) $(LDFLAGS) $^ -o main.elf

main.o: main.S

clean:
	rm main.o main.hex main.elf main.bin

flash: main.hex
	stm32flash -w main.hex /dev/ttyUSB0
	stm32flash -g 0x0 /dev/ttyUSB0
