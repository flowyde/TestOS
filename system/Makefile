# ASM = nasm

# SRC_DIR = src
# BUILD_DIR = build

# .PHONY: all floppy_image kernel bootloader clean always

# #
# # Arquivo final (floppy image)
# #
# floppy_image: $(BUILD_DIR)/main_floppy.img

# $(BUILD_DIR)/main_floppy.img: bootloader kernel
# 	dd if=/dev/zero of=$(BUILD_DIR)/main_floppy.img bs=512 count=2880
# 	mkfs.fat -F 12 -n "NBOS" $(BUILD_DIR)/main_floppy.img
# 	dd if=$(BUILD_DIR)/bootloader.bin of=$(BUILD_DIR)/main_floppy.img conv=notrunc
# 	mcopy -i $(BUILD_DIR)/main_floppy.img $(BUILD_DIR)/kernel.bin "::kernel.bin"

# #
# # Boot Loader
# #
# bootloader: $(BUILD_DIR)/bootloader.bin

# $(BUILD_DIR)/bootloader.bin: always
# 	$(ASM) $(SRC_DIR)/bootloader/boot.asm -f bin -o $(BUILD_DIR)/bootloader.bin

# #
# # Kernel
# #
# kernel: $(BUILD_DIR)/kernel.bin

# $(BUILD_DIR)/kernel.bin: always
# 	$(ASM) $(SRC_DIR)/kernel/main.asm -f bin -o $(BUILD_DIR)/kernel.bin


# #
# # Always
# #
# always:
# 	mkdir -p $(BUILD_DIR)

# #
# # Clean
# #
# clean:
# 	rm -rf $(BUILD_DIR)/*

GPPPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore
ASPARAMS = --32
LDPARAMS = -melf_i386

ISO_NAME = build/myos.iso
BUILD_DIR = build


objects = loader.o kernel.o

%.o: %.cpp
	g++ $(GPPPARAMS) -o $@ -c $<

%.o: %.s
	as $(ASPARAMS) -o $@ $<

mykernel.bin: linker.ld $(objects)
	ld $(LDPARAMS) -T $< -o $@ $(objects)

# opcional para caso queira instalar o sistema
install: mykernel.bin
		sudo cp $< /boot/mykernel.bin

.PHONY: all iso run clean

all: mykernel.bin

iso: all
	mkdir -p build
	mkdir -p isodir/boot/grub
	cp mykernel.bin isodir/boot/kernel.bin
	cp grub/grub.cfg isodir/boot/grub/grub.cfg
	grub-mkrescue -o $(ISO_NAME) isodir

run: iso
	qemu-system-x86_64 -cdrom $(ISO_NAME)

clean:
	rm -f *.o mykernel.bin
	rm -rf isodir $(BUILD_DIR)