{ config, lib, ... }: {

  imports = [
    ./audio.nix
    ./boot.nix
    ./disk.nix
    ./keyboard.nix
    ./mouse.nix
    ./networking.nix
    ./persist.nix
    ./sleep.nix
    ./wifi.nix
    ./yubikey.nix
    ./zfs.nix
  ];

  config = lib.mkIf config.physical {
    hardware.enableRedistributableFirmware = true;
  };

  options = {
    physical = lib.mkEnableOption "Whether this machine is a physical device.";
    server = lib.mkEnableOption "Whether this machine is a server.";
  };

}
