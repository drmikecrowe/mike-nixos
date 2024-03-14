{
  pkgs,
  lib,
  ...
}: {
  console.useXkbConfig = true; #use same kb settings (layout) as xorg

  boot = {
    swraid.enable = false;
    kernelModules = ["kvm-intel" "acpi_call" "dm-snapshot"];
    kernelParams = [
      "nohibernate"
      "quiet"
      "acpi_rev_override"
    ];
    extraModulePackages = lib.mkDefault [pkgs.linuxPackages.nvidia_x11_legacy390];

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
  };

  nixpkgs.config.nvidia.acceptLicense = true;
  hardware.nvidia.prime = {
    # Bus ID of the Intel GPU.
    intelBusId = lib.mkDefault "PCI:0:2:0";

    # Bus ID of the NVIDIA GPU.
    nvidiaBusId = lib.mkDefault "PCI:1:0:0";
  };
}
