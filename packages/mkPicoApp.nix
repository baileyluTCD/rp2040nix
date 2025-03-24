{
  pkgs,
  flake,
  system,
  ...
}: {
  name,
  src,
  picoSys ? "rp2040",
  cmakeFlags ? [],
  doCheck ? false,
  cmakeLists ? flake.outputs.${system}.rp2040-cmakeLists,
  ...
} @ args: let
  commonBuildInputs = with pkgs; [
    cmake
    ninja
    python3
    pkg-config
    pico-sdk
    pico-extras
  ];

  patchPhase = ''
    cp ${cmakeLists} ./CMakeLists.txt
  '';

  commonCmakeFlags =
    [
      "-G Ninja"
      "-DPICO_SDK_PATH=${flake.outputs.${system}.pico-sdk}/lib/pico-sdk"
      "-DPICO_EXTRAS_PATH=${flake.outputs.${system}.pico-extras}/lib/pico-extras"
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
    then
      flake.outputs.${system}.mkNativeApp {
        inherit name src buildPhase checkPhase doCheck commonBuildInputs commonCmakeFlags args patchPhase;
      }
    else
      flake.outputs.${system}.mkRp2040App {
        inherit name src buildPhase checkPhase doCheck commonBuildInputs commonCmakeFlags args patchPhase;
      }
  ) {
    inherit name src buildPhase checkPhase doCheck commonBuildInputs commonCmakeFlags args;
  }
