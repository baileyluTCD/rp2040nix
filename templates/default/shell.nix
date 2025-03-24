{
  mkShell,
  rp2040nix,
}: let
  compileCommandsJson = rp2040nix.lib.mkPicoApp {
    name = "compile_commands.json";
    src = ../.;
    cmakeFlags = ["-DCMAKE_EXPORT_COMPILE_COMMANDS=ON"];
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
