#include <assert.h>
#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include "pico/stdlib.h"
#include "pico/stdio.h"
#include "pico/assert.h"

#define BRIGHT_GREEN "\033[1;32m"
#define BRIGHT_RED "\033[1;31m"
#define RESET_COLOR "\033[0m"

/**
 * Test runner function
 *
 * Try making a bad assertion i.e. `assert(0 == 1)` and view the output of `nix flake check`.
 *
*/
void run_tests() {
   assert(1 + 1 == 2);
}

/**
 * rp2040nix project test entry point.
 *
 * Try it out with `nix flake check`. If all goes well no output should be produced.
 *
*/
int main() {
   stdio_init_all();

   printf("\n\n" BRIGHT_GREEN "Running morse code game tests!" RESET_COLOR "\n\n\n");
   fflush(stdout);

   printf(BRIGHT_RED);
   fflush(stdout);

   run_tests();

   printf(RESET_COLOR);
   fflush(stdout);

   printf(BRIGHT_GREEN "\n\nSuccessfully ran morse code game tests" RESET_COLOR "\n\n");
   
   return 0;
}

