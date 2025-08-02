GPPPARAMS = -m32 -fno-use-cxa-atexit -nostdlib -fno-builtin -fno-rtti -fno-exceptions -fno-leading-underscore
ASPARAMS = --32
LDPARAMS = -melf_i386

ISO_NAME = mykernel.iso
ISO_DIR = iso
GRUB_DIR = iso/boot/grub/grub.cfg
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

mykernel.iso: mykernel.bin
	mkdir -p build
	mkdir -p $(ISO_DIR)/boot/grub
	cp $< $(ISO_DIR)/boot/
	echo 'set timeout=0' >> $(GRUB_DIR)
	echo 'set default=0' >> $(GRUB_DIR)
	echo '' >> $(GRUB_DIR)
	echo 'menuentry "My Operating System yeah" {' >> $(GRUB_DIR)
	echo '	multiboot /boot/mykernel.bin' >> $(GRUB_DIR)
	echo '	boot' >> $(GRUB_DIR)
	echo '}' >> $(GRUB_DIR)
	grub-mkrescue --output=$@ iso
	rm -rf iso

.PHONY: all iso run clean

run: mykernel.iso
	qemu-system-x86_64 -cdrom $(ISO_NAME)

clean:
	rm -f *.o mykernel.bin
	rm -rf $(ISO_DIR) $(BUILD_DIR)