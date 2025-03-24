# Getting Started

# Nix Installation

To get started with _rp2040nix_ you must have a [nix](https://nixos.org/) installation with [flakes](https://nixos.wiki/wiki/flakes) enabled.

## Fresh Installation on Linux or macOS

The easiest way to get a nix installation with flakes enabled on an existing Linux or macOS system is to use the [Determinate Systems Nix Installer](https://determinate.systems/nix-installer/) which will guide you through the setup process.

## Enabling Flakes on an existing Nix install (Non NixOS)

You can enable flakes on an existing nix installation by adding to or creating `~/.config/nix/nix.conf`.

Simply ensure it has this line:
```toml
experimental-features = nix-command flakes
```

And restart your shell session with `exec bash` (or whatever your equivalent is).

## WSL

If you do not already have an existing WSL install and wish to use Nix, it makes sense to grab the full WSL NixOS image and install that instead of layering Nix on top of a distro like Ubuntu.

First, follow the [NixOS WSL Install Guide](https://nix-community.github.io/NixOS-WSL/).

To configure your system run `nano /etc/nixos/configuration.nix` as `nano` is the only text editor which is installed out of the box on new NixOS systems.

These lines are probably a good idea to include:

```nix
  # Enable the nix-ld program to support running foreign binaries
  # Needed for using vscode wsl plugin to interact with Nix files
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs; # Use nix-ld-rs for NixOS 24.05
  };

  # Set up the environment for VSCode
  # Find more options on https://search.nixos.org
  environment.systemPackages = with pkgs; [
    wget

    # Git + Gitlab utils
    git
    glab

    # Load enviroments from .envrc files
    direnv

    # Optional - Handy instead of `nano` even if you use a text editor on the main windows install
    neovim
  ];

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

Seeing as you are using WSL, you likely already use [VSCode](https://code.visualstudio.com/), in that case make sure you also grab:
- [VSCode WSL Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl) and load into WSL.
- [Direnv](https://marketplace.visualstudio.com/items?itemName=mkhl.direnv) for developing inside WSL.
- [CCLS](https://marketplace.visualstudio.com/items?itemName=ccls-project.ccls) for editing C and getting correct error messages from generated files.


# Framework Setup
Now that you have Nix setup, hopefully the most difficult part of using _rp2040nix_ is behind you.

Create a new project with:

```bash
mkdir my-amazing-project
cd my-amazing-project
nix flake init -t github:baileyluTCD/rp2040nix
```

If all is successfull you can run it with:

```bash
nix run .
"Hello World!"
```
