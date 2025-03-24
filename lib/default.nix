{pkgs, ...}:
with pkgs; {
  mkRp2040App = callPackage ./mkRp2040App.nix {};
  mkNativeApp = callPackage ./mkNativeApp.nix {};

  mkPicoApp = callPackage ./mkPicoApp.nix {inherit mkNativeApp mkRp2040App;};
}

