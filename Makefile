ASM = nasm

SRC_DIR = src
BUILD_DIR = build

# Arquivo final (floppy image)
$(BUILD_DIR)/main_floppy.img: $(BUILD_DIR)/main.bin | $(BUILD_DIR)
	cp $< $@
	truncate -s 1440k $@

# Binário compilado do ASM
$(BUILD_DIR)/main.bin: $(SRC_DIR)/main.asm | $(BUILD_DIR)
	$(ASM) $< -f bin -o $@

# Garante que o diretório build existe
$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
