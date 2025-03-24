{
  pico-sdk,
  pico-extras,
  cmake,
  ninja,
  python3,
  pkg-config,
  mkNativeApp,
  mkRp2040App,
}: {
  name,
  src,
  picoSys ? "rp2040",
  cmakeFlags ? [],
  doCheck ? false,
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
    ./morse-code
  '';
in
  (
    if picoSys == "host"
    then mkNativeApp
    else mkRp2040App
  ) {
    inherit name src buildPhase checkPhase doCheck commonBuildInputs commonCmakeFlags args;
  }
