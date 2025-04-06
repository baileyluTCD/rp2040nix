{pkgs, ...}: let
  version = "1.0.2";

  src = pkgs.fetchFromGitHub {
    owner = "wokwi";
    repo = "rp2040js";
    tag = "v${version}";
    hash = "sha256-kjTqz2PdiyM7x9te3USDbq4vOzWtXS7CK5KLlAiNmhg=";
  };
in
  pkgs.buildNpmPackage {
    pname = "rp2040js";

    nativeBuildInputs = [
      pkgs.nodePackages.typescript
    ];

    inherit src version;

    installPhase = ''
      mkdir -p $out/{lib,bin}

      cp -R ./* $out/lib/

      cat > $out/bin/rp2040js <<EOF
      #!${pkgs.runtimeShell}
      cd $out/lib

      ${pkgs.bun}/bin/bun start -- "\$@" 2>&1 | grep -v -F '[CortexM0Core] SEV'
      EOF

      chmod +x $out/bin/rp2040js
    '';

    npmDepsHash = "sha256-RX3smONJ25JSV8UONci8vd03e6cCyb7jP8JOmEyNB+E=";

    meta = {
      description = "Javascript based pico rp2040 emulator";
      homepage = "https://github.com/wokwi/rp2040js";
      changelog = "https://github.com/wokwi/rp2040js/releases/tag/v${version}";
      license = pkgs.lib.licenses.mit;
      maintainers = [
        pkgs.lib.maintainers.baileylu
      ];
      platforms = pkgs.lib.platforms.all;
      mainProgram = "rp2040js";
      sourceProvenance = with pkgs.lib.sourceTypes; [
        fromSource
        binaryBytecode
      ];
    };
  }
