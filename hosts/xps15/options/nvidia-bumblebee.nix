{
  config,
  lib,
  inputs,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.dell-xps-15-9560-nvidia
  ];

  boot = {
    blacklistedKernelModules = ["nouveau"];
    kernelParams = ["acpi_rev_override=1"];
  };

  hardware = {
    nvidia = {
      prime.offload.enable = false;
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
    };
  };

  boot.kernelPackages = pkgs.linuxPackages.extend (self: super: {
    nvidia_x11 = super.nvidia_x11_legacy390;
  });

  hardware.bumblebee.enable = true;
}
