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
      prime.sync.enable = true;
      modesetting.enable = true;
      nvidiaSettings = true;
      open = false;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
    };
  };

  services.xserver.videoDrivers = [
    "nvidiaLegacy390"
  ];
}
