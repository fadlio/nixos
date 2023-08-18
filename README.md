# Introduction
Modular NixOS/home-manager configuration.

# Hosts
## `phantom`
Main desktop @ 192.168.1.100
- i7-4790K
- AMD RX 480
- NVIDIA GTX 1660 Super (passthrough)

## `spectre`
Main laptop @ 192.168.1.101
- i7-8550U
- NVIDIA MX150

## `ghost`
Docker server @ 192.168.1.110
- i7-3537U

## `wraith`
Media server @ 192.168.1.111
- i7-3635QM
- AMD Radeon HD 8870M

# Commands
- check: `nix flake check`
- build: `sudo nixos-rebuild [switch boot dry-activate] --flake .`
- update: `nix flake update [--update-input nixpkgs]`
- garbage collect (nixos): `sudo nix-collect-garbage -d`
- garbage collect (home-manager): `nix-collect-garbage -d`


# Config Inspirations
- Module system - [mrkuz](https://github.com/mrkuz/nixos)
- Neovim config - [Matt Moriarity](https://git.mattmoriarity.com/mjm/nix-config)