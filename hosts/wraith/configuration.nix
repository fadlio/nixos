{ config, lib, pkgs, ... }:

{
  modules = {
    amdGpu.enable = true;
    basePackages.enable = true;
    systemdBoot.enable = true;
    x11.enable = true;
    wayland.enable = true;
    fonts.enable = true;
    pipewire.enable = true;
    opengl.enable = true;

    gnome.enable = true;

    android.enable = true;
    docker.enable = true;
    podman.enable = true;
    sshd.enable = true;
    # waydroid.enable = true;
    qemu = {
      enable = true;
      vfioPciIds = [ "10de:21c4" "10de:1aeb" "10de:1aec" "10de:1aed" ];
    };
    embedded-dev = {
      enable = true;
      jlink = true;
      probe-run = true;
    };
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
    hostName = "phantom";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    firewall.enable = false;
    enableIPv6 = false;

    interfaces = {
      enp3s0 = {
        ipv4.addresses = [{
          address = "192.168.1.100";
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
      lio.gid = 1000;
    };
    users = {
      lio = {
        uid = 1000;
        description = "Fernando de Lio";
        isNormalUser = true;
        group = "lio";
        extraGroups = [ "wheel" "plugdev" "adbusers" "disk" "docker" "libvirtd" "lp" "lxd" "podman" "scanner" ];
        shell = pkgs.fish;
      };
    };
  };

  home-manager.users = {
    lio.imports = [ ../../users/lio.nix ];
  };
}
