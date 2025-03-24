#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include "pico/stdlib.h"
#include "pico/stdio.h"

/**
 * rp2040nix project main entry point.
 *
 * Try it out with `nix build .` to produce an rp2040 binary or `nix run .` to compile and run it locally.
 *
*/
int main() {
   stdio_init_all();

   printf("Hello, World!");

   return 0;
}
