{
  config,
  lib,
  ...
}: {
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./keyboard.nix
    ./mouse.nix
    ./networking.nix
    ./wifi.nix
    ./yubikey.nix
  ];

  config = {
    hardware.enableRedistributableFirmware = true;
  };
}
