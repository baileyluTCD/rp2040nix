{
  pico-sdk,
  pico-extras,
  cmake,
  ninja,
  python3,
  pkg-config,
  mkNativeApp,
  mkRp2040App,
  rp2040nix-cmakeLists,
  defaultCmakeFlags,
  defaultDoCheck,
}: {
  name,
  src,
  picoSys ? "rp2040",
  cmakeFlags ? defaultCmakeFlags,
  doCheck ? defaultDoCheck,
  cmakeLists ? rp2040nix-cmakeLists,
  ...
} @ args: let
  commonBuildInputs = [
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
      "-DPICO_SDK_PATH=${pico-sdk}/lib/pico-sdk"
      "-DPICO_EXTRAS_PATH=${pico-extras}/lib/pico-extras"
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
    inherit name src buildPhase checkPhase doCheck commonBuildInputs commonCmakeFlags args;
  }
