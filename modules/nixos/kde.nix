{ config, lib, pkgs, sources, ... }:

with lib;
let
  cfg = config.modules.kde;
in
{
  options.modules.kde = {
    enable = mkOption {
      default = false;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      dconf.enable = true;
      # For GSConnect
      kdeconnect = {
        enable = true;
        package = pkgs.gnomeExtensions.gsconnect;
      };
    };

    services = {
      xserver = {
        displayManager = {
          sddm.enable = true;
          # autoLogin.enable = true;
          # autoLogin.user = config.home.username;
        };
        desktopManager.plasma5 = {
          enable = true;
        };
      };
      gnome.gnome-keyring.enable = true;
    };

    security.pam.services.sddm.enableGnomeKeyring = true;

    environment = {
      plasma5 = {
        excludePackages = with pkgs.libsForQt5; [
          elisa
          gwenview
          okular
          oxygen
          khelpcenter
          konsole
          # plasma-browser-integration
          # print-manager
        ];
      };

      systemPackages = with pkgs; [
        polkit-kde-agent
        libsForQt5.packagekit-qt
        libsForQt5.bismuth
      ];

    };
  };
}
