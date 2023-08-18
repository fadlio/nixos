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
  };

  services = {
    vscode-server.enable = true;
  };

  modules = {
    gnome-manager.enable = true;
    alacritty.enable = true;
    fish.enable = true;
    vscode.enable = true;
    nixvim.enable = true;
  };

  home = {
    username = "lio";
    homeDirectory = "/home/lio";

    packages = with pkgs; [
      nil
      nixpkgs-fmt
      nixd # TODO: investigate why it's not working on devShells setups
      rnix-lsp # TODO: investigate why it's not working on devShells setups

      # Video/Audio
      vlc # Media Player

      # Apps
      appimage-run # Runs AppImages on NixOS
      firefox # Browser
      remmina # XRDP & VNC Client
      anydesk

      # File Management
      p7zip # Zip Encryption
      rsync # Syncer - $ rsync -r dir1/ dir2/
      unzip # Zip Files
      unrar # Rar Files
      zip # Zip

      openvpn
      bitwarden
      dbeaver

      # Communication
      discord
      whatsapp-for-linux

      chatgpt-cli

      python3
    ];

    stateVersion = "23.05";
  };
}
