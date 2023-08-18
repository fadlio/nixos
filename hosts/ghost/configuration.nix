{ config, lib, pkgs, ... }:

{
  modules = {
    basePackages.enable = true;
    systemdBoot.enable = true;
    fonts.enable = true;
    docker.enable = true;
    podman.enable = true;
    sshd.enable = true;
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "usb_storage" "sd_mod" ];
    kernelModules = [ "kvm-intel" ];
    kernelParams = [
      "ipv6.disable=1"
    ];
    extraModprobeConfig = ''
      options snd slots=snd-hda-intel
    '';
  };


  fileSystems."/" =
    {
      device = "/dev/disk/by-uuid/c891c1c7-f92a-43da-8311-48151d5e4d1a";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/73A4-0F1D";
      fsType = "vfat";
    };

  swapDevices = [ ];

  networking = {
    hostName = "ghost";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    firewall.enable = false;
    enableIPv6 = false;

    interfaces = {
      enp3s0 = {
        ipv4.addresses = [{
          address = "192.168.1.110";
          prefixLength = 24;
        }];
      };
    };
    defaultGateway = "192.168.1.1";
    nameservers = [ "8.8.8.8" ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  hardware.sane = {
    enable = true;
    # extraBackends = [ pkgs.hplipWithPlugin ];
  };

  #Keyboard layouts
  services.xserver = {
    layout = "us,us";
    xkbVariant = "intl,";
  };

  environment = {
    variables = {
      # Enables cedilla
      GTK_IM_MODULE = "cedilla";
      QT_IM_MODULE = "cedilla";
    };
  };

  users = {
    groups = {
      docker.gid = 1000;
    };
    users = {
      docker = {
        uid = 1000;
        description = "Docker";
        isNormalUser = true;
        group = "docker";
        extraGroups = [ "wheel" "disk" "podman" "scanner" ];
        shell = pkgs.fish;
      };
    };
  };

  home-manager.users = {
    docker.imports = [ ../../users/docker.nix ];
  };
}
