{ config, lib, ... }:

with lib;
let
  # host = name;
  cfg = config.modules.alacritty;
in
{
  options.modules.alacritty = {
    enable = mkOption {
      default = false;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    programs = {
      starship = {
        enable = true;
      };

      alacritty = {
        enable = true;
        settings = {
          env = {
            TERM = "xterm-256color";
          };
          window = {
            # opacity = 0.8;
            # decorations = "None";
            padding = {
              x = 10;
              y = 10;
            };
          };
          font = {
            normal.family = "FiraCode Nerd Font";
            bold = { style = "Bold"; };
            # size = if host == "nixos-laptop" then 7 else 10;
          };
        };
      };
    };
  };
}
