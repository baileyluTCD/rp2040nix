# Packages

_rp2040nix_ exposes a handful of packages which may be useful in a general setting for developing with the rp2040 using nix, some of which aren't yet packaged in [nixpkgs](https://github.com/NixOS/nixpkgs).

These include:
- [rp2040js](https://github.com/wokwi/rp2040js)
- [Pico Extras](https://github.com/raspberrypi/pico-extras)
- A pinned, regularly updated [Pico SDK](https://github.com/raspberrypi/pico-sdk)
- This documentation packaged as an HTML bundle

## Builder Function - `mkPicoApp`

_rp2040nix_ is largely implemented through a lone builder function which handles all compilation tasks for the rp2040 and native systems - `mkPicoApp`.

### Interface
Currently, here are the supported arguments for `mkPicoApp`.

```nix
  {
    # The name of the package you wish to build
    pname, 
    # The version of the package to build
    version,
    # The package's source code directory
    src, 
    # Any extra flags you want to append to `cmake`. Optional
    extraCmakeFlags, 
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
    pname = "main";
    version = "1.2.4";
    src = ./.;
  };
```

```nix
  # Compile an application's test.c with TEST defined for the rp2040 hardware
  rp2040nix.mkPicoApp {
    pname = "tests";
    version = "1.2.4";
    src = ./.;
    extraCmakeFlags = ["-DTEST=ON"];
  };
```

## Builder Function - `mkDocs`

_rp2040nix_ has built in support for [doxygen](https://www.doxygen.nl/index.html) generated documentation with a nice styling courtesy of [doxygen awesome](https://jothepro.github.io/doxygen-awesome-css/).

### Interface
Currently, here are the supported arguments for `mkDocs`.

```nix
  {
    # The name of the package you wish to build
    pname, 
    # The version of the package to build
    version,
    # The package's source code directory
    src, 
    # The Doxyfile to inject into the source for compilation - See the default at https://github.com/baileyluTCD/rp2040nix/blob/master/packages/mkDocs/Doxyfile
    doxyfile,
  } 
```

### Examples

```nix
  # Compile an application's documentation
  rp2040nix.mkDocs {
    pname = "my-awesome-docs";
    version = "1.2.4";
    src = ./.;
  };
```
