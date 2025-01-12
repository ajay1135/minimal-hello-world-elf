CC = gcc
BINARIES = hello_world hello_world_no_stdlib hello_world_static_no_exception_handling hello_world_static_no_exception_handling_custom_ld_script
STRIPPED_BINARIES = $(foreach binary, $(BINARIES), $(binary)_stripped)
ALL_BINARIES = hello_world_custom_elf $(BINARIES) $(STRIPPED_BINARIES)

.PHONY: all
all: $(ALL_BINARIES)

hello_world:
	$(CC) -o $@ $@.c

hello_world_no_stdlib:
	$(CC) -nostdlib -o $@ $@.c

hello_world_static:
	$(CC) -static -nostdlib -o $@ hello_world_no_stdlib.c

hello_world_static_no_exception_handling:
	$(CC) -Os -static -fno-asynchronous-unwind-tables -fno-exceptions -fno-stack-protector -fdata-sections -ffunction-sections -nostdlib -o $@ hello_world_no_stdlib.c

hello_world_static_no_exception_handling_custom_ld_script:
	$(CC) -Os -static -fno-asynchronous-unwind-tables -fno-exceptions -fno-stack-protector -fdata-sections -ffunction-sections -nostdlib -T hello_world.ld -o $@ hello_world_no_stdlib.c

hello_world_custom_elf:
	./hex_to_elf.sh hello_world.hex $@

%_stripped: %
	strip -s --remove-section=.note.gnu.property --remove-section=.note.gnu.build-id --remove-section=.comment $< -o $@

.PHONY: clean
clean:
	rm -f $(ALL_BINARIES)
