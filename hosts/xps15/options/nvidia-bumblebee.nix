{
  config,
  lib,
  inputs,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    # inputs.nixos-hardware.nixosModules.dell-xps-15-9560
    inputs.nixos-hardware.nixosModules.dell-xps-15-9560-nvidia
  ];
  boot = {
    extraModulePackages = [config.boot.kernelPackages.nvidia_x11];
  };
  boot.blacklistedKernelModules = ["nouveau" "bbswitch"];
  boot.kernelParams = ["acpi_rev_override=1"];

  hardware = {
    bumblebee.enable = lib.mkDefault true;
    bumblebee.pmMethod = lib.mkDefault "none";

    # nvidia = {
    #   prime.offload.enable = true;
    #   nvidiaSettings = true;
    #   open = true;
    #   powerManagement.enable = false;
    #   powerManagement.finegrained = false;
    #   modesetting.enable = true;
    #   # package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
    # };
  };
  # inputs.nixpkgs.config.nvidia.acceptLicense = true;
}
