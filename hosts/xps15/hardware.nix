{
  config,
  lib,
  inputs,
  pkgs,
  modulesPath,
  ...
}: let
  powerMode = "performance";
in {
  imports = [
    # inputs.nixos-hardware.nixosModules.dell-xps-15-9560
    inputs.impermanence.nixosModule
    ./boot.nix
    ./disks.nix
  ];
  powerManagement.cpuFreqGovernor = powerMode;
  services.auto-cpufreq.enable = true;
  # services.thermald.enable = false;

  # Fix unreadable tty under high dpi
  console = {
    packages = [pkgs.terminus_font];
    font = "ter-124n";
  };

  # Network
  networking = {
    useDHCP = pkgs.lib.mkDefault true;
    hostName = "xps15";
    hostId = "c904de5f";
  };

  hardware = {
    cpu.intel.updateMicrocode = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
}
