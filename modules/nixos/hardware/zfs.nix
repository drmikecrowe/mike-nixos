{
  config,
  pkgs,
  lib,
  ...
}: {
  options = {zfs.enable = lib.mkEnableOption "ZFS file system.";};

  config = lib.mkIf (pkgs.stdenv.isLinux && config.zfs.enable) {
    boot = {
      kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
      kernelParams = ["nohibernate"];
      supportedFilesystems = ["zfs"];
      zfs.devNodes = "/dev/disk/by-partlabel";
      loader.grub.zfsSupport = true;
    };
  };
}
