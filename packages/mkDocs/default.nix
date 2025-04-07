{pkgs, ...}: {
  pname,
  version,
  src,
  doxyfile ? ./Doxyfile,
  ...
} @ args: let
  # Fetch nicer css styles
  doxygen-awesome-css = pkgs.fetchFromGitHub {
    owner = "jothepro";
    repo = "doxygen-awesome-css";
    tag = "v2.3.4";
    hash = "sha256-HrFNbnpG0ttOg0xbC+WLhC77KmvkNjtVNk1QUD+JgYY=";
  };
in
  pkgs.stdenv.mkDerivation ({
      inherit pname src version;

      nativeBuildInputs = with pkgs; [
        doxygen
        makeWrapper
      ];

      env = {
        DOXYGEN_PROJECT_NAME = pname;
        DOXYGEN_PROJECT_NUMBER = version;
        DOXYGEN_AWESOME_CSS = "${doxygen-awesome-css}/doxygen-awesome.css";
      };

      # Produce doxygen output files (html, latex, etc)
      buildPhase = ''
        doxygen ${doxyfile}
      '';

      # Put raw outputs in lib and create a http server binary in bin
      installPhase = ''
        mkdir -p $out/{bin,lib}

        cp -R ./doxygen/* $out/lib

        makeWrapper ${pkgs.httplz}/bin/httplz $out/bin/${pname} \
          --chdir "$out/lib/html"
      '';

      meta.mainProgram = pname;
    }
    // args)
