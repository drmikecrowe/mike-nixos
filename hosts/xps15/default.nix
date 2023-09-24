{ config, pkgs, globals, overlays, home-manager, impermanence, nixos-hardware, ... }:

let
  common = import ../../modules/common;
  nixosMain = import ../../modules/nixos;
  gruvbox = import ../../colorscheme/gruvbox;

  passwordHash = pkgs.lib.fileContents ../../password.sha512;

  mkZfsMount = device: {
    fsType = "zfs";
    options = [ "zfsutil" "X-mount.mkdir" ];
  };

in
{
  imports = [
    # inputs.nixos-hardware.nixosModules.dell-xps-15-9560
    nixos-hardware.nixosModules.dell-xps-15-9560-intel
    # inputs.nixos-hardware.nixosModules.dell-xps-15-9560-nvidia
    impermanence.nixosModule
    home-manager.nixosModule
    common
    nixosMain
  ];

  config = {

    user = "mcrowe";

    gui.enable = true;
    physical = true;

    kde.enable = true;
    lightdm.enable = true;
    sddm.enable = false;
    budgie.enable = false;
    gnome.enable = false;
    gdm.enable = false;

    # Programs and services
    # charm.enable = true;
    gpg.enable = true;
    neovim.enable = true;
    kitty.enable = true;
    nushell.enable = true;
    _1password.enable = true;
    discord.enable = true;
    slack.enable = true;
    nixlang.enable = true;
    carapace.enable = true;

    boot = {
      swraid.enable = false;
      kernelModules = [ "kvm-intel" "acpi_call" ];
      initrd.availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "uas"
        "sd_mod"
        "usbhid"
        "rtsx_pci_sdmmc"
      ];
      initrd.postDeviceCommands = pkgs.lib.mkAfter ''
        zfs rollback -r rpool/nixos@SYSINIT
      '';
      loader.grub = {
        extraPrepareConfig = ''
          mkdir -p /boot/efis
          for i in /boot/efis/*; do mount $i ; done
          mkdir -p /boot/efi
          mount /boot/efi
        '';
        extraInstallCommands = ''
          ESP_MIRROR=$(mktemp -d)
          cp -r /boot/efi/EFI $ESP_MIRROR
          for i in /boot/efis/*; do
            cp -r $ESP_MIRROR/EFI $i
          done
          rm -rf $ESP_MIRROR
        '';
        devices = [ "/dev/disk/by-id/nvme-Fanxiang_S500PRO_2TB_FXS500PRO231912172" ];
      };
    };

    services = {
      duplicati = {
        enable = true;
        user = "mcrowe";
      };
      blueman.enable = true;
      printing = {
        enable = true;
        drivers = [ pkgs.legacyPackages.x86_64-linux.samsung-unified-linux-driver ];
        browsing = true;
      };
    };

    zfs.enable = true;

    # fileSystems = {
    #   "/" = mkZfsMount "rpool/nixos" // { neededForBoot = true; };
    #   "/home" = mkZfsMount "rpool/nixos/home";
    #   "/keep" = mkZfsMount "rpool/nixos/keep" // { neededForBoot = true; };
    #   "/nix" = mkZfsMount "rpool/nixos/nix";
    #   "/root" = mkZfsMount "rpool/nixos/root";
    #   "/usr" = mkZfsMount "rpool/nixos/usr";
    #   "/var" = mkZfsMount "rpool/nixos/var";
    #   "/boot" = mkZfsMount "bpool/nixos/boot" // { neededForBoot = true; };
    #   "/boot/efis/efiboot0" = { device = "/dev/disk/by-uuid/9250-2D17"; fsType = "vfat"; };
    #   "/boot/efi" = { device = "/boot/efis/efiboot0"; fsType = "none"; options = [ "bind" ]; };
    # };

    swapDevices = [{
      device = "/dev/disk/by-uuid/4fdbdf13-9cbf-4c44-a41a-09bc274ff496";
    }];

    fileSystems."/" = {
      device = "rpool/nixos";
      fsType = "zfs";
      options = [ "zfsutil" "X-mount.mkdir" ];
      neededForBoot = true;
    };

    fileSystems."/home" = {
      device = "rpool/nixos/home";
      fsType = "zfs";
      options = [ "zfsutil" "X-mount.mkdir" ];
    };

    fileSystems."/keep" = {
      device = "rpool/nixos/keep";
      fsType = "zfs";
      options = [ "zfsutil" "X-mount.mkdir" ];
      neededForBoot = true;
    };

    fileSystems."/nix" = {
      device = "rpool/nixos/nix";
      fsType = "zfs";
      options = [ "zfsutil" "X-mount.mkdir" ];
    };

    fileSystems."/root" = {
      device = "rpool/nixos/root";
      fsType = "zfs";
      options = [ "zfsutil" "X-mount.mkdir" ];
    };

    fileSystems."/usr" = {
      device = "rpool/nixos/usr";
      fsType = "zfs";
      options = [ "zfsutil" "X-mount.mkdir" ];
    };

    fileSystems."/var" = {
      device = "rpool/nixos/var";
      fsType = "zfs";
      options = [ "zfsutil" "X-mount.mkdir" ];
    };

    fileSystems."/boot" = {
      device = "bpool/nixos/boot";
      fsType = "zfs";
      options = [ "zfsutil" "X-mount.mkdir" ];
      neededForBoot = true;
    };

    fileSystems."/boot/efis/efiboot0" = {
      device = "/dev/disk/by-uuid/9250-2D17";
      fsType = "vfat";
    };

    fileSystems."/boot/efi" = {
      device = "/boot/efis/efiboot0";
      fsType = "none";
      options = [ "bind" ];
    };


    console.packages = [ pkgs.legacyPackages.x86_64-linux.terminus_font ];
    console.font = "ter-124n";
    hardware.bluetooth.enable = true;
    networking = {
      hostName = "xps15";
      hostId = "c904de5f";
      hosts = {
        "192.168.1.107" = [
          "sonarr.local"
          "radarr.local"
          "transfer.local"
          "sabnzbd.local"
          "crowenas.local"
          "jackett.local"
        ];
      };
      useDHCP = pkgs.lib.mkDefault true;
    };
    location = {
      latitude = 34.1089;
      longitude = -77.8931;
    };
    time.timeZone = "America/New_York";

    systemd.services.nix-gc.unitConfig.ConditionACPower = true;

    nixpkgs.hostPlatform = pkgs.lib.mkDefault "x86_64-linux";

    powerManagement.cpuFreqGovernor = pkgs.lib.mkDefault "powersave";

    hardware.cpu.intel.updateMicrocode = true;
  };
}
