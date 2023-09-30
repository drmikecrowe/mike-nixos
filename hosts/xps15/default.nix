{
  inputs,
  config,
  pkgs,
  globals,
  overlays,
  home-manager,
  impermanence,
  nixos-hardware,
  ...
}: let
  gruvbox = import ../../colorscheme/gruvbox;

  mkZfsMount = devicePath: {
    device = devicePath;
    fsType = "zfs";
    options = ["zfsutil" "X-mount.mkdir"];
  };
in {
  imports = [
    # nixos-hardware.nixosModules.dell-xps-15-9560
    nixos-hardware.nixosModules.dell-xps-15-9560-intel
    # nixos-hardware.nixosModules.dell-xps-15-9560-nvidia
    impermanence.nixosModule
    ../../modules/nixos
    ../../home/mcrowe
  ];

  config = {
    # Must be prepared ahead
    passwordHash = pkgs.lib.fileContents ../../password.sha512;

    # Theming
    gui.enable = true;
    physical = true;

    kde.enable = true;

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

    continue.enable = true;
    services.flatpak.enable = true;

    # Hardware

    boot.swraid.enable = false;

    boot.kernelModules = ["kvm-intel" "acpi_call"];
    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "nvme"
      "usb_storage"
      "uas"
      "sd_mod"
      "usbhid"
      "rtsx_pci_sdmmc"
    ];
    boot.initrd.postDeviceCommands = pkgs.lib.mkAfter ''
      zfs rollback -r rpool/nixos@SYSINIT
    '';
    boot.loader.grub.extraPrepareConfig = ''
      mkdir -p /boot/efis
      for i in  /boot/efis/*; do mount $i ; done

      mkdir -p /boot/efi
      mount /boot/efi
    '';

    boot.loader.grub.extraInstallCommands = ''
      ESP_MIRROR=$(mktemp -d)
      cp -r /boot/efi/EFI $ESP_MIRROR
      for i in /boot/efis/*; do
        cp -r $ESP_MIRROR/EFI $i
      done
      rm -rf $ESP_MIRROR
    '';

    boot.loader.grub.devices = ["/dev/disk/by-id/nvme-Fanxiang_S500PRO_2TB_FXS500PRO231912172"];

    # ZFS
    zfs.enable = true;

    # Fix unreadable tty under high dpi
    console = {
      packages = [pkgs.terminus_font];
      font = "ter-124n";
    };

    # Duplicati backup
    services.duplicati = {
      enable = true;
      user = "mcrowe";
    };

    # Bluetooth
    services.blueman.enable = true;
    hardware.bluetooth.enable = true;

    # Network
    networking = {
      hostName = "xps15";
      hostId = "c904de5f";
      extraHosts = builtins.readFile "${inputs.hosts}/hosts";
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
    };

    location = {
      latitude = 34.1089;
      longitude = -77.8931;
    };

    # Set your time zone.
    time.timeZone = "America/New_York";

    # Printing
    services.printing = {
      enable = true;
      # drivers = [ inputs.nixpkgs.gutenprint ];
      drivers = [pkgs.samsung-unified-linux-driver];
      browsing = true;
    };

    systemd.services.nix-gc.unitConfig.ConditionACPower = true;

    swapDevices = [
      {
        device = "/dev/disk/by-uuid/4fdbdf13-9cbf-4c44-a41a-09bc274ff496";
      }
    ];

    fileSystems = {
      "/" = mkZfsMount "rpool/nixos" // {neededForBoot = true;};
      "/home" = mkZfsMount "rpool/nixos/home";
      "/keep" = mkZfsMount "rpool/nixos/keep" // {neededForBoot = true;};
      "/nix" = mkZfsMount "rpool/nixos/nix";
      "/root" = mkZfsMount "rpool/nixos/root";
      "/usr" = mkZfsMount "rpool/nixos/usr";
      "/var" = mkZfsMount "rpool/nixos/var";
      "/boot" = mkZfsMount "bpool/nixos/boot" // {neededForBoot = true;};
      "/boot/efis/efiboot0" = {
        device = "/dev/disk/by-uuid/9250-2D17";
        fsType = "vfat";
      };
      "/boot/efi" = {
        device = "/boot/efis/efiboot0";
        fsType = "none";
        options = ["bind"];
      };
    };

    # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
    # (the default) this is the recommended approach. When using systemd-networkd it's
    # still possible to use this option, but it's recommended to use it in conjunction
    # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
    networking.useDHCP = pkgs.lib.mkDefault true;
    # networking.interfaces.enp62s0u1u3.useDHCP = pkgs.lib.mkDefault true;
    # networking.interfaces.wlp2s0.useDHCP = pkgs.lib.mkDefault true;

    nixpkgs.hostPlatform = pkgs.lib.mkDefault "x86_64-linux";
    powerManagement.cpuFreqGovernor = pkgs.lib.mkDefault "powersave";
    hardware.cpu.intel.updateMicrocode = true;
  };
}
