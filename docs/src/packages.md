# Packages

_rp2040nix_ exposes a handful of packages which may be useful in a general setting for developing with the rp2040 using nix, some of which aren't yet packaged in [nixpkgs](https://github.com/NixOS/nixpkgs).

These include:
- [Pico Extras](https://github.com/raspberrypi/pico-extras)
- [Pico Host SDL](https://github.com/raspberrypi/pico-host-sdl)
- A pinned, regularly updated [Pico SDK](https://github.com/raspberrypi/pico-sdk)
- This documentation packaged as an HTML bundle

## Builder Function - `mkPicoApp`

_rp2040nix_ is largely implemented through a lone builder function which handles all compilation tasks for the rp2040 and native systems - `mkPicoApp`.

### Interface
Currently, here are the supported arguments for `mkPicoApp`.

```nix
  {
    # The name of the package you wish to build
    name, 
    # The package's source code directory
    src, 
    # The system you want to compile for - avalible options - "host", "rp2040". Default: "rp2040"
    picoSys, 
    # Any extra flags you want to append to `cmake`. Optional
    cmakeFlags, 
    # Should the checkPhase be ran for this package. Default - false
    doCheck, 
    # A list of file paths to PIO headers which should be included
    pioHeaders,
    # Extra pico libraries to link against
    extraPicoLibraries,
    # The cmake lists file to inject into the source for compilation - See the default at https://github.com/baileyluTCD/rp2040nix/blob/master/packages/mkPicoApp/CMakeLists.txt
    cmakeLists,
  } 
```

### Examples

```nix
  # Compile an application's main.c and run it locally
  rp2040nix.mkPicoApp {
    name = "main";
    src = ./.;
    picoSys = "host";
  };
```

```nix
  # Compile an application's test.c with TEST defined for the rp2040 hardware
  rp2040nix.mkPicoApp {
    name = "tests";
    src = ./.;
    doCheck = true;
    cmakeFlags = ["-DTEST=ON"];
    picoSys = "rp2040";
  };
```
