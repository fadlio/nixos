{ config, lib, pkgs, ... }:

{
  modules = {
    basePackages.enable = true;
    systemdBoot.enable = true;
    nvidiaGpu.enable = true;
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
    waydroid.enable = true;
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
      device = "/dev/disk/by-uuid/dcf4f0f7-7899-43c8-b4aa-2d77890e1b7c";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    {
      device = "/dev/disk/by-uuid/40bd793f-a53d-4bb7-a66b-1034f1ddf97a";
      fsType = "vfat";
    };

  swapDevices = [ ];

  networking = {
    hostName = "spectre";
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
    firewall.enable = false;
    enableIPv6 = false;

    interfaces = {
      enp3s0 = {
        ipv4.addresses = [{
          address = "192.168.1.101";
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
