# #
##
##  per-host configuration for xps15
##
##

{ system, pkgs, ... }: {
  inherit pkgs system;
  zfs-root = {
    boot = {
      devNodes = "/dev/";
      bootDevices = [  "nvme0n1" ];
      immutable = false;
      availableKernelModules = [  "xhci_pci" "ahci" "nvme" "usb_storage" "uas" "sd_mod" "rtsx_pci_sdmmc" ];
      removableEfi = true;
      kernelParams = [ ];
      sshUnlock = {
        # read sshUnlock.txt file.
        enable = false;
        authorizedKeys = [ ];
      };
    };
    networking = {
      # read changeHostName.txt file.
      hostName = "xps15";
      timeZone = "America/New_York";
      hostId = "0dbbe8df";
    };
  };

  # To add more options to per-host configuration, you can create a
  # custom configuration module, then add it here.
  my-config = {
    # Enable custom gnome desktop on xps15
    template.desktop.gnome.enable = false;
  };
}
