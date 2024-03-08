{
  pkgs,
  lib,
  ...
}: {
  boot = {
    swraid.enable = false;
    kernelModules = ["kvm-intel" "acpi_call"];

    # Use latest released Linux kernel by default
    kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;

    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "uas"
        "sd_mod"
        "usbhid"
        "rtsx_pci_sdmmc"
      ];
    };
    loader = {
      grub = {
        enable = true;

        efiInstallAsRemovable = true;
        copyKernels = true;
        efiSupport = true;

        # Attempt to display GRUB on widescreen monitor
        gfxmodeEfi = "1920x1080";

        theme = pkgs.stdenv.mkDerivation {
          pname = "distro-grub-themes";
          version = "3.1";
          src = pkgs.fetchFromGitHub {
            owner = "AdisonCavani";
            repo = "distro-grub-themes";
            rev = "v3.1";
            hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
          };
          installPhase = "cp -r customize/nixos $out";
        };
      };

      generationsDir.copyKernels = true;
      # Always display menu indefinitely; default is 5 seconds
      # timeout = null;
      efi.efiSysMountPoint = "/boot/efi";
      efi.canTouchEfiVariables = false;
    };
  };
}
