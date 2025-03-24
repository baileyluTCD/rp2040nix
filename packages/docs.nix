{
  pkgs,
  ...
}:
pkgs.stdenv.mkDerivation {
  name = "docs";

  src = ../docs;

  nativeBuildInputs = with pkgs; [
    mdbook
  ];

  buildPhase = ''
    mdbook build
  '';

  # Output all build file types specified in the assignment
  installPhase = ''
    mkdir -p $out/book

    cp -R ./book/* $out/book/
  '';
}
