{
  config,
  lib,
  inputs,
  pkgs,
  disko,
  modulesPath,
  ...
}: let
  powerMode = "performance";
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    # inputs.impermanence.nixosModule
    ./boot.nix
    ./btrfs-disko.nix
  ];
  powerManagement.cpuFreqGovernor = powerMode;
  services.auto-cpufreq.enable = true;
  # services.thermald.enable = false;

  # Fix unreadable tty under high dpi
  # console = {
  #   packages = [pkgs.terminus_font];
  #   font = "ter-124n";
  # };

  # Network
  networking = {
    useDHCP = pkgs.lib.mkDefault true;
    hostName = "xps15";
    hostId = "c904de5f";
  };

  hardware = {
    cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
}
