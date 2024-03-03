{config, ...}: let
  HDD = "/dev/disk/by-id/nvme-Fanxiang_S500PRO_2TB_FXS500PRO231912172";
  SWAP = "/dev/disk/by-id/nvme-Fanxiang_S500PRO_2TB_FXS500PRO231912172-part4";
  EFI = "/dev/disk/by-id/nvme-Fanxiang_S500PRO_2TB_FXS500PRO231912172-part2";

  mkZfsMount = devicePath: {
    device = devicePath;
    fsType = "zfs";
    options = ["zfsutil" "X-mount.mkdir"];
  };
in {
  config = {
    boot = {
      kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
      kernelParams = ["nohibernate"];
      supportedFilesystems = ["zfs"];
      zfs.devNodes = "/dev/disk/by-partlabel";
      loader.grub.zfsSupport = true;
    };

    boot.loader.grub.devices = [HDD];

    swapDevices = [
      {
        device = SWAP;
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
        device = EFI;
        fsType = "vfat";
      };
      "/boot/efi" = {
        device = "/boot/efis/efiboot0";
        fsType = "none";
        options = ["bind"];
      };
    };

    environment.persistence."/keep" = {
      hideMounts = true;
      directories = [
        "/etc/nixos"
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
        "/etc/cups"
      ];
      files = [
        "/etc/machine-id"
        {
          file = "/etc/nix/id_rsa";
          parentDirectory = {mode = "u=rwx,g=rx,o=rx";};
        }
        "/etc/ssh/ssh_host_ed25519_key"
        "/etc/ssh/ssh_host_ed25519_key.pub"
        "/etc/ssh/ssh_host_rsa_key"
        "/etc/ssh/ssh_host_rsa_key.pub"
      ];
    };

    # Enable fstrim, which tracks free space on SSDs for garbage collection
    # More info: https://www.reddit.com/r/NixOS/comments/rbzhb1/if_you_have_a_ssd_dont_forget_to_enable_fstrim/
    services.fstrim.enable = true;
  };
}
