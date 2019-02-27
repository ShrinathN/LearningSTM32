CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
OBJCPY = arm-none-eabi-objcopy
CFLAGS = -x assembler-with-cpp -mthumb -mcpu=cortex-m3 -O0 --specs=nosys.specs -nostdlib -lgcc
LDFLAGS = -Tlscript_custom.ld

all:
	$(CC) $(LDFLAGS) $(CFLAGS) main.S -o main.elf
	$(OBJCPY) -O ihex main.elf main.hex
	
clean:
	rm main.hex main.elf