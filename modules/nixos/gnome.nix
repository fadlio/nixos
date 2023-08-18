{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.modules.gnome;
in
{
  options.modules.gnome = {
    enable = mkOption {
      default = false;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    services.xserver = {
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
      desktopManager.xterm.enable = mkForce false;
      displayManager.defaultSession = "gnome";
    };

    environment.gnome.excludePackages = with pkgs; [
      gnome.epiphany
      gnome.geary
      gnome.gnome-contacts
      gnome.gnome-logs
      gnome.gnome-maps
      gnome.gnome-music
      gnome.totem
      gnome.yelp
      gnome-connections
      gnome-console
      gnome-photos
    ];

    programs.dconf.enable = true;
    environment.systemPackages = with pkgs; [
      gnome.mutter
      # Gnome utilities
      gnome.dconf-editor
      # gnome.gnome-boxes
      gnome.gnome-tweaks
      libnotify

      # Miscellaneous applications
      gparted
      gthumb
      remmina
      # thunderbird
      vlc
    ];


  };
}
