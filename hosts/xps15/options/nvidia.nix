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
    # extraModulePackages = [config.boot.kernelPackages.nvidia_x11];
    kernelPackages = pkgs.linuxPackages_5_10;
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
}
