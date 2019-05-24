all: src/main.asm
	nasm -f elf32 src/main.asm
	nasm -f elf32 src/main_write.asm
	gcc -m32 -o main src/main.o lib/driver.c lib/asm_io.o
	gcc -m32 -o main_write src/main_write.o lib/driver.c lib/asm_io.o

clean:
	rm main main_write
