# rp2040nix

_rp2040nix_ is an opinionated [Nix](https://nixos.org/) based framework for building `C` and `ASM` programs to run on the [rp2040](https://en.wikipedia.org/wiki/RP2040).

## At a glance

### Features
- Declarative Config.
- Far more simple setup compared to [pico-sdk](https://github.com/raspberrypi/pico-sdk) and [cmake](https://cmake.org/) alone.
- Built in cross compling support - develop applications on your native hardware and the pico itself.
- Unit test support via nix flake checks.
- Add extra dependencies and share them with your team with ease.
- Built in editor support via `compile_commands.json`.

### Downsides

- No support for windows at all → Linux, Mac and WSL only.
- Nix is relatively less compared to the regular, more popular ways, there may be less documentation, etc.

### Alternatives
- [rp2040js](https://github.com/wokwi/rp2040js) with precompiled pico binary.
- [RP2040 PIO Emulator](https://github.com/soundpaint/rp2040pio).

## Getting Started

Ready to get started? Head over to our [setup guide](https://baileylutcd.github.io/rp2040nix/getting_started.html).

## Usage

Learn how to use the framework at our [usage guide](https://baileylutcd.github.io/rp2040nix/usage.html).
