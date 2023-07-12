{ config, pkgs, lib, ... }: {

  boot.loader = lib.mkIf config.physical {
    grub = {
      enable = true;

      efiInstallAsRemovable = true;
      copyKernels = true;
      efiSupport = true;

      # Attempt to display GRUB on widescreen monitor
      gfxmodeEfi = "1920x1080";

    };

    generationsDir.copyKernels = true;
    # Always display menu indefinitely; default is 5 seconds
    # timeout = null;
    efi.efiSysMountPoint = "/boot/efi";
    efi.canTouchEfiVariables = false;
  };

  # Use latest released Linux kernel by default
  boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

}
