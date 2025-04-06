# Usage
_rp2040nix_, by default, provides a number of simple, idiomatic ways of invoking it:

## Building
To build the project for the pico, run `nix build .` in the root directory.

All created (`*.elf`, `*.uf2` and `*.dis`) files will be output in `./result`.

## Running
Thanks to [rp2040js](https://github.com/wokwi/rp2040js) we can compile the pico code and run on your system without having the actual hardware present.

Run the project with `nix run .`.

## Testing
Run this project's tests with `nix run .#test`. 

You can use something like this to define code that only runs in testing mode:
```c
#ifdef TEST
    printf("Test mode enabled!\n");
#else
    printf("Normal mode\n");
#endif
```

## Editor
To use this properly in your editor, you must use the [dev shell](https://nix.dev/tutorials/first-steps/declarative-shell.html) provided by the nix flake, which produces a `compile_commands.json` suitable for use in your c language server, [CCLS](https://github.com/MaskRay/ccls/wiki) is an example of a language server that works with this.

You can enter this manually with `nix develop` and start your editor inside there, or, the [direnv](https://nix.dev/tutorials/first-steps/declarative-shell.html) editor plugin will load this manually ([vscode](https://github.com/direnv/direnv-vscode), [nvim](https://github.com/direnv/direnv.vim)).
