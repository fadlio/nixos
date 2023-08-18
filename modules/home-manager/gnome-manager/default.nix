{ config, lib, pkgs, ... }:

with lib;
let
  imports = [
    (import ./appearance.nix { inherit pkgs; })
    (import ./extensions.nix { inherit pkgs; })
    (import ./keybindings.nix)
  ];
  cfg = config.modules.gnome-manager;
in
{
  options.modules.gnome-manager = {
    enable = mkOption {
      default = false;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable (mkMerge ([{
    dconf.settings = {
      "org/gnome/shell" = {
        favorite-apps = [
          "firefox.desktop"
          "code.desktop"
        ];
      };
      "system/locale/org/gnome/tweaks" = {
        show-extensions-notice = false;
      };
      # TODO: Make this configurable per host
      "org/gnome/desktop/session" = {
        idle-delay = lib.hm.gvariant.mkUint32 900;
      };
      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-type = "nothing";
        sleep-inactive-battery-type = "nothing";
      };
      "system/locale/org/gnome/settings-daemon/plugins/color" = {
        night-light-enabled = true;
        night-light-temperature = lib.hm.gvariant.mkUint32 3200;
      };
      "system/locale/org/gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
        speed = -0.40458015267175573;
      };
    };

  }] ++ imports));
}
