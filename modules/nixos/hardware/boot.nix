{ config, pkgs, lib, ... }: {

  boot.loader = lib.mkIf config.physical {
    grub = {
      enable = true;

      efiInstallAsRemovable = true;
      copyKernels = true;
      efiSupport = true;
    };

    generationsDir.copyKernels = true;
    # Always display menu indefinitely; default is 5 seconds
    # timeout = null;
    efi.efiSysMountPoint = "/boot/efi";
    efi.canTouchEfiVariables = false;
  };

  # Allow reading from Windows drives
  boot.supportedFilesystems = lib.mkIf config.physical [ "ntfs" ];

  # Use latest released Linux kernel by default
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

}
