{pkgs, ...}: {
  name,
  src,
  buildPhase,
  checkPhase,
  patchPhase,
  doCheck,
  commonBuildInputs,
  commonCmakeFlags,
  args,
}:
pkgs.stdenv.mkDerivation {
  inherit name src buildPhase patchPhase checkPhase doCheck;

  nativeBuildInputs = with pkgs;
    commonBuildInputs
    ++ [
      gcc-arm-embedded
      picotool
    ];

  cmakeFlags = with pkgs;
    commonCmakeFlags
    ++ [
      "-DCMAKE_C_COMPILER=${gcc-arm-embedded}/bin/arm-none-eabi-gcc"
      "-DCMAKE_CXX_COMPILER=${gcc-arm-embedded}/bin/arm-none-eabi-g++"
    ];

  # Output all build file types specified in the assignment
  installPhase =
    args.installPhase
    or ''
      mkdir -p $out

      cp *.elf $out
      cp *.uf2 $out
      cp *.dis $out
    '';
}
