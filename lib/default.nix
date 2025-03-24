{pkgs, ...}:
with pkgs; let
  inherit (flake) pico-sdk pico-extras pico-host-sdl rp2040nix-cmakeLists;
in {
  mkRp2040App = callPackage ./mkRp2040App.nix {};
  mkNativeApp = callPackage ./mkNativeApp.nix {inherit pico-host-sdl;};

  mkPicoApp = callPackage ./mkPicoApp.nix {
    inherit mkNativeApp mkRp2040App pico-sdk pico-extras rp2040nix-cmakeLists;

    defaultCmakeFlags = [];
    defaultDoCheck = false;
  };

  mkPicoTests = callPackage ./mkPicoApp.nix {
    inherit mkNativeApp mkRp2040App pico-sdk pico-extras rp2040nix-cmakeLists;

    defaultCmakeFlags = ["-DTEST=on"];
    defaultDoCheck = true;
  };
}

