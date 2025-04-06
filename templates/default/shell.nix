{
  mkShell,
  rp2040nix,
}: let
  compileCommandsJson = rp2040nix.mkPicoApp {
    pname = "compile_commands.json";
    src = ./.;
    version = "1.0.0";
    extraCmakeFlags = ["-DCMAKE_EXPORT_COMPILE_COMMANDS=ON"];
    installPhase = ''
      cp compile_commands.json $out
    '';
  };
in
  # Produce a nix shell with the cmake generated compile commands linked
  mkShell {
    shellHook = ''
      ln -sf ${compileCommandsJson} compile_commands.json
    '';
  }
