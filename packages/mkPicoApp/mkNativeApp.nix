{
  stdenv,
  SDL2,
  SDL2_image,
  alsa-lib,
  pico-host-sdl,
  pico-sdk,
  ...
}: {
  name,
  src,
  buildPhase,
  patchPhase,
  checkPhase,
  doCheck,
  commonBuildInputs,
  commonCmakeFlags,
  args,
}:
stdenv.mkDerivation {
  inherit name src buildPhase patchPhase checkPhase doCheck;

  nativeBuildInputs =
    commonBuildInputs
    ++ [
      SDL2
      SDL2_image
      alsa-lib.dev
    ];

  cmakeFlags =
    commonCmakeFlags
    ++ [
      "-DPICO_PLATFORM=host"
      "-DPICO_SDK_PRE_LIST_DIRS=${pico-host-sdl}/lib/pico-host-sdl"
      "-DSDL2_MAIN_LIBRARY=${SDL2}/lib/libSDL2.so"
      "-DPICO_HOST_SDK_INCLUDE_DIRS=${pico-sdk}/lib/pico-sdk/src/host"
    ];

  # Output all build file types specified in the assignment
  installPhase =
    args.installPhase
    or ''
      mkdir -p $out/bin

      cp ./rp2040nix-app $out/bin/$name
    '';

  meta.mainProgram = name;
}
