{
  description = "Template project for rp2040nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    rp2040nix.url = "github:baileylutcd/rp2040nix/master";
    rp2040nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};

      # Access the rp2040nix packages bundle
      rp2040nix = inputs.rp2040nix.packages.${system};

      # Compile with the main entrypoint
      main = picoSys:
        rp2040nix.mkPicoApp {
          name = "main";
          src = ./.;
          inherit picoSys;
        };

      # Compile with the tests entrypoint
      tests = picoSys:
        rp2040nix.mkPicoApp {
          name = "tests";
          src = ./.;
          doCheck = true;
          cmakeFlags = ["-DTEST=ON"];
          inherit picoSys;
        };

      # Compile the dev environment
      shell = pkgs.callPackage ./shell.nix {inherit rp2040nix;};
    in {
      # Build for rp2040 with `nix build`
      packages.default = main "rp2040";

      apps = {
        # Run the app on the host system
        default = {
          type = "app";
          program = "${main "host"}/bin/main";
        };
      };

      # Run unit tests as flake checks
      checks = {unitTests = tests "host";};

      devShells.default = shell;
    });
}
