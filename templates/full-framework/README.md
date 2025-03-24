# rp2040nix template

This project uses the [rp2040nix](https://github.com/baileyluTCD/rp2040nix) framework to build, run and test code for the [rp2040](https://en.wikipedia.org/wiki/RP2040).

## Setup

Install nix using the [determinate nix installer](https://determinate.systems/nix-installer/).

This will then allow us to automatically install system packages like language package managers (i.e. `npm`, `cargo`, etc.), ensuring we have a build system with much less manual setup.

## Developing

### Testing
Run this project's tests with `nix flake check`. 

You can use something like this to define code that only runs in testing mode:
```c
#ifdef TEST
    printf("Test mode enabled!\n");
#else
    printf("Normal mode\n");
#endif
```

### Building
To build the project for the pico, run `nix build .` in the root directory.

All created (`*.elf`, `*.uf2` and `*.dis`) files will be output in `./result`.

### Running
Thanks to [pico sdl host](https://github.com/raspberrypi/pico-host-sdl) we can compile the pico code to run natively on your system without having hardware or an emulator with some compiler tricks.

Run the project with `nix run .`.

### Editor
To use this properly in your editor, you must use the [dev shell](https://nix.dev/tutorials/first-steps/declarative-shell.html) provided by the nix flake, which produces a `compile_commands.json` suitable for use in your c language server.

You can enter this manually with `nix develop` and start your editor inside there, or, the [direnv](https://nix.dev/tutorials/first-steps/declarative-shell.html) editor plugin will load this manually ([vscode](https://github.com/direnv/direnv-vscode), [nvim](https://github.com/direnv/direnv.vim)).
