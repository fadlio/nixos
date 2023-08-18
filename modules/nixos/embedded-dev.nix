{ config, lib, nixpkgs, vars, ... }:

with lib;
let
  cfg = config.modules.embedded-dev;
  system = vars.currentSystem;
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true; # Allow proprietary software
    config.segger-jlink.acceptLicense = true;
  };
in
{
  options.modules.embedded-dev = {
    enable = mkOption {
      default = false;
      type = types.bool;
    };
    # TODO: make a list of debbugers and a list of devices
    jlink = mkOption {
      default = false;
      type = types.bool;
    };
    probe-run = mkOption {
      default = false;
      type = types.bool;
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      users.groups.plugdev = { };
      environment.systemPackages = with pkgs; [
        (if cfg.jlink then segger-jlink else null)
        (if cfg.probe-run then probe-run else null)
      ];
    }


  ]);
}

    
