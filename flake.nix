{
  description = "Nix framework for developing rp2040 apps";

  # Add all your dependencies here
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    blueprint.url = "github:numtide/blueprint";
    blueprint.inputs.nixpkgs.follows = "nixpkgs";

    treefmt-nix.url = "github:numtide/treefmt-nix";

    pico-sdk-src = {
      url = "https://github.com/raspberrypi/pico-sdk.git";
      flake = false;
      type = "git";
      submodules = true;
    };

    pico-host-sdl-src = {
      url = "https://github.com/raspberrypi/pico-host-sdl.git";
      flake = false;
      type = "git";
      submodules = true;
    };

    pico-extras-src = {
      url = "https://github.com/raspberrypi/pico-extras.git";
      flake = false;
      type = "git";
      submodules = true;
    };
  };

  # Load the blueprint
  outputs = inputs: inputs.blueprint { inherit inputs; };
}
