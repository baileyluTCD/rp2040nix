{pkgs}:
pkgs.mkShell {
  # Local package dependencies
  packages = with pkgs; [
    mdbook
  ];
}
