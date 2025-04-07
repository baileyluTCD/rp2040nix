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
      asmfmt.enable = true;
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
        export HOME=$NIX_BUILD_TOP/home

        # keep timestamps so that treefmt is able to detect mtime changes
        cp --no-preserve=mode --preserve=timestamps -r ${flake} source
        cd source
        git init --quiet
        git add .
        treefmt --no-cache
        if ! git diff --exit-code; then
          echo "-------------------------------"
          echo "aborting due to above changes ^"
          exit 1
        fi
        touch $out
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
