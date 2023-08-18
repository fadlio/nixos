{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.modules.vscode;
in
{
  options.modules.vscode = {
    enable = mkOption {
      default = false;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        vadimcn.vscode-lldb
      ];

    };
  };
}
