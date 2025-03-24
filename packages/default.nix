{
  inputs,
  flake,
  ...
}: system: let
  inherit (flake) pico-sdk pico-extras pico-host-sdl rp2040nix-cmakeLists;
in rec {
  mkRp2040App = pkgs.callPackage ./mkRp2040App.nix {};
  mkNativeApp = pkgs.callPackage ./mkNativeApp.nix {inherit pico-host-sdl;};

  mkPicoApp = pkgs.callPackage ./mkPicoApp.nix {
    inherit mkNativeApp mkRp2040App pico-sdk pico-extras rp2040nix-cmakeLists;

    defaultCmakeFlags = [];
    defaultDoCheck = false;
  };

  mkPicoTests = pkgs.callPackage ./mkPicoApp.nix {
    inherit mkNativeApp mkRp2040App pico-sdk pico-extras rp2040nix-cmakeLists;

    defaultCmakeFlags = ["-DTEST=on"];
    defaultDoCheck = true;
  };
}
