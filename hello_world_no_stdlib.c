#define __NR_write 1
#define __NR_exit 60

void _start() {
	const char* buf = "Hello, world!\n";
	int ret;

	// Write syscall
	asm volatile (
			"syscall"
			: "=a" (ret)
			: "0"(__NR_write), "D"(1), "S"(buf), "d"(15)
			: "rcx", "r11", "memory"
		     );

	// Exit syscall
	asm volatile (
			"syscall"
			:
			: "a"(__NR_exit), "D"(0)
			: "rcx", "r11", "memory"
		     );
}
