{
  description = "Template project for rp2040nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    rp2040nix.url = "github:baileylutcd/rp2040nix";
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

      version = "0.1.0";
      src = ./.;

      # Compile with the main entrypoint
      main = rp2040nix.mkPicoApp {
        pname = "main";
        inherit version src;
      };

      # Compile with the main entrypoint
      docs = rp2040nix.mkDocs {
        pname = "docs";
        inherit version src;
      };

      # Compile with the tests entrypoint
      test = rp2040nix.mkPicoApp {
        pname = "test";
        extraCmakeFlags = ["-DTEST=ON"];
        inherit version src;
      };

      # Compile the dev environment
      shell = pkgs.callPackage ./shell.nix {inherit rp2040nix;};
    in {
      # Build for rp2040 with `nix build`
      packages = {
        default = main;
        inherit test docs;
      };

      devShells.default = shell;
    });
}
