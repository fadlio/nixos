{
  description = "Module based NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    plasma-manager.url = "github:pjones/plasma-manager";
    nixvim.url = "github:nix-community/nixvim";
    vscode-server.url = "github:nix-community/nixos-vscode-server";

    flake-compat = {
      url = "github:inclyc/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      vars = {
        currentSystem = "x86_64-linux";
        stateVersion = "23.05";
        rev = self.rev or "dirty";
      };
      utils = {
        setUpNixOS = import ./lib/setup-nixos.nix { inherit self nixpkgs inputs; };
      };
    in
    {
      inherit utils vars;

      nixosConfigurations = {
        "phantom" = utils.setUpNixOS {
          name = "phantom";
          system = "x86_64-linux";
        };
        "spectre" = utils.setUpNixOS {
          name = "spectre";
          system = "x86_64-linux";
        };
        "ghost" = utils.setUpNixOS {
          name = "ghost";
          system = "x86_64-linux";
        };
        "wraith" = utils.setUpNixOS {
          name = "wraith";
          system = "x86_64-linux";
        };
      };

      nixosModules = {
        amdGpu = import ./modules/nixos/amd-gpu.nix;
        android = import ./modules/nixos/android.nix;
        basePackages = import ./modules/nixos/base-packages.nix;
        docker = import ./modules/nixos/docker.nix;
        embeddedDev = import ./modules/nixos/embedded-dev.nix;
        fonts = import ./modules/nixos/fonts.nix;
        gnome = import ./modules/nixos/gnome.nix;
        kde = import ./modules/nixos/kde.nix;
        nix = import ./modules/nixos/nix.nix;
        nvidiaGpu = import ./modules/nixos/nvidia-gpu.nix;
        opengl = import ./modules/nixos/opengl.nix;
        pipewire = import ./modules/nixos/pipewire.nix;
        podman = import ./modules/nixos/podman.nix;
        qemu = import ./modules/nixos/qemu.nix;
        sshd = import ./modules/nixos/sshd.nix;
        systemdBoot = import ./modules/nixos/systemd-boot.nix;
        wayland = import ./modules/nixos/wayland.nix;
        waydroid = import ./modules/nixos/waydroid.nix;
        x11 = import ./modules/nixos/x11.nix;
      };

      homeManagerModules = {
        plasma-manager-module = inputs.plasma-manager.homeManagerModules.plasma-manager;
        nixvim-module = inputs.nixvim.homeManagerModules.nixvim;
        vscode-server-module = inputs.vscode-server.homeModules.default;

        gnome-manager = import ./modules/home-manager/gnome-manager;
        nixvim = import ./modules/home-manager/nixvim;

        alacritty = import ./modules/home-manager/alacritty.nix;
        fish = import ./modules/home-manager/fish.nix;
        nnn = import ./modules/home-manager/nnn.nix;
        plasma-manager = import ./modules/home-manager/plasma-manager.nix;
        tmux = import ./modules/home-manager/tmux.nix;
        vscode = import ./modules/home-manager/vscode.nix;
      };

      # devShells = {
      #   "x86_64-linux" = rec {
      #     pkgs = import nixpkgs { system = "x86_64-linux"; };
      #     default = pkgs.mkShell {
      #       packages = with pkgs; [
      #         nixfmt
      #         nixd
      #       ];
      #       shellHook = ''
      #         export NIX_PATH="nixpkgs=${nixpkgs}"
      #       '';
      #     };
      #   };
      # };
    };
}
