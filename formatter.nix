{
  flake,
  inputs,
  pkgs,
  ...
}:
let
  formatter = inputs.treefmt-nix.lib.mkWrapper pkgs {
    # Used to find the project root
    projectRootFile = "flake.nix";

    programs = {
      nixfmt.enable = true;
      cmake-format.enable = true;
      clang-format.enable = true;
      shfmt.enable = true;
      asmfmt = {
        enable = true;
        includes = [ "*.S" ];
      };
    };
  };

  check =
    pkgs.runCommand "format-check"
      {
        nativeBuildInputs = [
          formatter
          pkgs.git
        ];
      }
      ''
        treefmt --fail-on-change
      '';
in
formatter
// {
  meta = formatter.meta // {
    tests = {
      check = check;
    };
  };
}
