# name of executable
TEMPLATEROOT = $(PWD)

CFLAGS  = -O1 -g -I$(LIBROOT)
ASFLAGS = -g

OBJS = $(STARTUP) main.o
ELF = main.elf         

# Tool path

TOOLROOT=/bin

# Library path

LIBROOT=STM32F10x_StdPeriph_Lib_V3.5.0

# Tools

CC=$(TOOLROOT)/arm-none-eabi-gcc
LD=$(TOOLROOT)/arm-none-eabi-gcc
AR=$(TOOLROOT)/arm-none-eabi-ar
AS=$(TOOLROOT)/arm-none-eabi-as

# Code Paths

DEVICE=$(LIBROOT)/Libraries/CMSIS/CM3/DeviceSupport/ST/STM32F10x
CORE=$(LIBROOT)/Libraries/CMSIS/CM3/CoreSupport
PERIPH=$(LIBROOT)/Libraries/STM32F10x_StdPeriph_Driver

# Search path for standard files

vpath %.c $(LIBROOT)

# Search path for perpheral library

vpath %.c $(CORE)
vpath %.c $(PERIPH)/src
vpath %.c $(DEVICE)

# Search path for Library

vpath %.c $(TEMPLATEROOT)/Library/ff9/src
vpath %.c $(TEMPLATEROOT)/Library/ff9/src/option
vpath %.c $(TEMPLATEROOT)/Library

#  Processor specific

PTYPE = STM32F10X_MD_VL 
LDSCRIPT = $(LIBROOT)/stm32f103c8t6.ld
STARTUP= startup_stm32f10x.o system_stm32f10x.o 

# Compilation Flags

FULLASSERT = -DUSE_FULL_ASSERT 

LDFLAGS+= -T$(LDSCRIPT) -mthumb -mcpu=cortex-m3 
CFLAGS+= -mcpu=cortex-m3 -mthumb 
CFLAGS+= -I$(TEMPLATEROOT) -I$(DEVICE) -I$(CORE) -I$(PERIPH)/inc -I.
CFLAGS+= -D$(PTYPE) -DUSE_STDPERIPH_DRIVER $(FULLASSERT)
CFLAGE+= -I$(TEMPLATEROOT)/Library/ff9/src -I$(TEMPLATEROOT)/Library

# Build executable 

$(ELF) : $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS) $(LDLIBS)

# compile and generate dependency info

%.o: %.c
	$(CC) -c $(CFLAGS) $< -o $@
	$(CC) -MM $(CFLAGS) $< > $*.d

%.o: %.s
	$(CC) -c $(CFLAGS) $< -o $@

clean:
	rm -f $(OBJS) $(OBJS:.o=.d) $(ELF) startup_stm32f* $(CLEANOTHER)

debug: $(ELF)
	arm-none-eabi-gdb $(ELF)


# pull in dependencies

-include $(OBJS:.o=.d)




