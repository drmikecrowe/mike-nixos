{
  inputs,
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
      "acpi_rev_override=1"
    ];
    extraModulePackages = lib.mkDefault [pkgs.linuxPackages.nvidia_x11_legacy390];

    # TODO: test if this fixes the issue
    blacklistedKernelModules = [
      "snd-intel-dspcfg"
    ];

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
}
