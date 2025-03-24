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

  installPhase = ''
    mkdir -p $out/book

    cp -R ./book/* $out/book/
  '';
}
