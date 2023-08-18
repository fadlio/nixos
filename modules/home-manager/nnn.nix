{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.nnn;
in
{
  options.modules.nnn = {
    enable = mkOption {
      default = false;
      type = types.bool;
    };
  };
  config = mkIf cfg.enable
    {
      programs = {
        nnn = {
          enable = true;
          package = pkgs.nnn.override ({ withNerdIcons = true; });
          extraPackages = with pkgs; [ fzf ffmpegthumbnailer mediainfo sxiv ];
          plugins = {
            src = (pkgs.fetchFromGitHub {
              owner = "jarun";
              repo = "nnn";
              rev = "v4.8";
              sha256 = "sha256-Hpc8YaJeAzJoEi7aJ6DntH2VLkoR6ToP6tPYn3llR7k=";
            }) + "/plugins";
            mappings = {
              c = "fzcd";
              f = "finder";
              v = "imgview";
              p = "preview-tui";
              z = "autojump";
            };
          };
          bookmarks = {
            d = "~/Documents";
            D = "~/Downloads";
            p = "~/Pictures";
            v = "~/Videos";
          };
        };
      };
    };
}
