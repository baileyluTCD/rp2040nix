#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include "pico/stdlib.h"
#include "pico/stdio.h"

/**
 * @brief Test assembly function
 *
 * Simply prints "Hello From ASM!" and is callable from C
 *
*/
void hello_asm();

/**
 * @brief Test header visible function
 *
 * Function exposed by the header that should be callable from main.c
 *
*/
void say_hi() {
   printf("Hello, World!");
   hello_asm();
};
