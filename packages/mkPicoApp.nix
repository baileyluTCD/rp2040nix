{
  pkgs,
  flake,
  system,
  ...
}: let
  rp2040packages = builtins.trace "system pkgs ${builtins.toJSON flake.outputs.packages.${system}}" flake.packages.${system};
in
  {
    name,
    src,
    picoSys ? "rp2040",
    cmakeFlags ? [],
    doCheck ? false,
    cmakeLists ? rp2040packages.rp2040-cmakeLists,
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
      cp ${cmakeLists} ./CMakeLists.txt
    '';

    commonCmakeFlags =
      [
        "-G Ninja"
        "-DPICO_SDK_PATH=${rp2040packages.pico-sdk}/lib/pico-sdk"
        "-DPICO_EXTRAS_PATH=${rp2040packages.pico-extras}/lib/pico-extras"
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
      then rp2040packages.mkNativeApp
      else rp2040packages.mkRp2040App
    ) {
      inherit name src buildPhase checkPhase patchPhase doCheck commonBuildInputs commonCmakeFlags args;
    }
