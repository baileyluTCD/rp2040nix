.thumb_func
.global hello_asm
.align

/* *
 * @brief Test assembly function
 *
 * Simply prints "Hello From ASM!" and is callable from C
 *
 */
hello_asm:
	LDR R0, =hello_world
	BL  printf

	.data
	hello_world:   .asciz "Hello From ASM!\n"

