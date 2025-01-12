CC = gcc
BINARIES = hello_world hello_world_no_stdlib hello_world_no_stdlib_stripped hello_world_static_no_stdlib hello_world_static_no_stdlib_stripped hello_world_static_no_stdlib_no_exception_handling hello_world_static_no_stdlib_no_exception_handling_stripped hello_world_static_no_stdlib_no_exception_handling_no_pie hello_world_static_no_stdlib_no_exception_handling_no_pie_stripped hello_world_static_no_stdlib_no_exception_handling_no_pie_custom_ld_script hello_world_custom_elf

.PHONY: all
all: $(BINARIES)

hello_world:
	$(CC) -o $@ $@.c

hello_world_no_stdlib:
	$(CC) -nostdlib -o $@ $@.c

hello_world_static_no_stdlib:
	$(CC) -static -nostdlib -o $@ hello_world_no_stdlib.c

hello_world_static_no_stdlib_no_exception_handling:
	$(CC) -Os -static -fno-asynchronous-unwind-tables -fno-exceptions -fno-stack-protector -fdata-sections -ffunction-sections -nostdlib -o $@ hello_world_no_stdlib.c

hello_world_static_no_stdlib_no_exception_handling_no_pie:
	$(CC) -Os -static -fno-asynchronous-unwind-tables -fno-exceptions -fno-stack-protector -fdata-sections -ffunction-sections -nostdlib -o $@ hello_world_no_stdlib.c

hello_world_static_no_stdlib_no_exception_handling_no_pie_custom_ld_script:
	$(CC) -Os -static -fno-asynchronous-unwind-tables -fno-exceptions -fno-stack-protector -fdata-sections -ffunction-sections -nostdlib -T hello_world.ld -o $@ hello_world_no_stdlib.c

hello_world_custom_elf:
	./hex_to_elf.sh hello_world.hex $@

%_stripped: %
	strip -s $< -o $@
	strip --remove-section=.note.gnu.property --remove-section=.note.gnu.build-id --remove-section=.comment $@

.PHONY: clean
clean:
	rm -f $(BINARIES)
