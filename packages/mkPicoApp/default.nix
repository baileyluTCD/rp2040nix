{
  pkgs,
  flake,
  system,
  ...
}: let
  rp2040packages = flake.packages.${system};

  pico-host-sdl = rp2040packages.pico-host-sdl;

  mkNativeApp = pkgs.callPackage ./mkNativeApp.nix {
    inherit pico-host-sdl;
  };
  mkRp2040App = pkgs.callPackage ./mkRp2040App.nix {};
in
  {
    name,
    src,
    picoSys ? "rp2040",
    cmakeFlags ? [],
    pioHeaders ? [],
    extraPicoLibraries ? [],
    doCheck ? false,
    ...
  } @ args: let
    commonBuildInputs = with pkgs; [
      cmake
      ninja
      python3
      pkg-config
      rp2040packages.pico-sdk
      rp2040packages.pico-extras
    ];

    patchPhase = ''
      cp ${args.cmakeLists or ./CMakeLists.txt} ./CMakeLists.txt
    '';

    toCmakeList = pkgs.lib.concatStringsSep ";";

    commonCmakeFlags =
      [
        "-G Ninja"
        "-DPICO_SDK_PATH=${rp2040packages.pico-sdk}/lib/pico-sdk"
        "-DPICO_EXTRAS_PATH=${rp2040packages.pico-extras}/lib/pico-extras"
        "-DRP2040NIX_LIBRARIES=${toCmakeList extraPicoLibraries}"
        "-DRP2040NIX_PIO=${toCmakeList pioHeaders}"
      ]
      ++ cmakeFlags;

    # Compile using ninja for speed
    buildPhase = ''
      ninja
    '';

    checkPhase = ''
      ./rp2040nix-app
    '';
  in
    (
      if picoSys == "host"
      then mkNativeApp
      else mkRp2040App
    ) {
      inherit name src buildPhase checkPhase patchPhase doCheck commonBuildInputs commonCmakeFlags args;
    }
