ASM=nasm

SRC_DIR=src
BUILD_DIR=build

.PHONY: all floopy_image kernel bootloader clean always


floopy_image: $(BUILD_DIR)/main_floopy.img 

$(BUILD_DIR)/main_floopy.img: bootloader kernel
	dd if=/dev/zero of=$(BUILD_DIR)/main_floopy.img bs=512 count=2880
	mkfs.fat -F 12 -n "NBOS" $(BUILD_DIR)/main_floopy.img
	dd if=$(BUILD_DIR)/bootloader.bin of=$(BUILD_DIR)/main_floopy.img conv=notrunc
	mcopy -i $(BUILD_DIR)/main_floopy.img $(BUILD_DIR)/kernel.bin "::kernel.bin"
	
	# cp $(BUILD_DIR)/main.bin $(BUILD_DIR)/main_floopy.img
	# truncate -s 1440k $(BUILD_DIR)/main_floopy.img

bootloader: $(BUILD_DIR)/bootloader.bin

$(BUILD_DIR)/bootloader.bin: always
	$(ASM) $(SRC_DIR)/bootloader/boot.asm -f  bin -o $(BUILD_DIR)/bootloader.bin


kernel: $(BUILD_DIR)/kernel.bin

$(BUILD_DIR)/kernel.bin: always
	$(ASM) $(SRC_DIR)/kernel/main.asm -f bin -o $(BUILD_DIR)/kernel.bin

always:
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)/*



$(BUILD_DIR)/main.bin: $(SRC_DIR)/main.asm
	$(ASM) $(SRC_DIR)/main.asm -f bin -o $(BUILD_DIR)/main.bin

run: $(BUILD_DIR)/main_floopy.img
	qemu-system-x86_64 -drive file=$(BUILD_DIR)/main_floopy.img,format=raw
