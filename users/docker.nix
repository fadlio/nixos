{ pkgs, ... }:

{
  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Fernando de Lio";
      userEmail = "fernandodelio@gmail.com";
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    
    zoxide = {
      enable = true;
    };
    starship = {
      enable = true;
    };
  };

  modules = {
    gnome-manager.enable = true;
    alacritty.enable = true;
    fish.enable = true;
    nixvim.enable = true;
    tmux.enable = true;
  };

  home = {
    username = "docker";
    homeDirectory = "/home/docker";

    packages = with pkgs; [
      nil
      nixpkgs-fmt
    ];

    stateVersion = "23.05";
  };
}
