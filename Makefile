all:
	nasm -f bin ./bootloader/boot.asm -o ./bin/boot.bin

clean:
	rm -f ./bin/boot.bin
