#include "my_lib_file.h"
#include "pico/stdio.h"
#include "pico/stdlib.h"
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>

/**
 * rp2040nix project main entry point.
 *
 * Try it out with `nix build .` to produce an rp2040 binary or `nix run .` to
 * compile and run it locally.
 *
 */
int main() {
  stdio_init_all();

  say_hi();

  return 0;
}
