{
  pkgs,
  flake,
  system,
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
pkgs.stdenv.mkDerivation {
  inherit name src buildPhase checkPhase doCheck patchPhase;

  nativeBuildInputs = with pkgs;
    commonBuildInputs
    ++ [
      SDL2
      SDL2_image
      alsa-lib.dev
    ];

  cmakeFlags = with pkgs;
    commonCmakeFlags
    ++ [
      "-DPICO_PLATFORM=host"
      "-DPICO_SDK_PRE_LIST_DIRS=${flake.outputs.${system}.pico-host-sdl}/lib/pico-host-sdl"
      "-DSDL2_MAIN_LIBRARY=${SDL2}/lib/libSDL2.so"
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
