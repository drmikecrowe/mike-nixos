{ config, lib, pkgs, ... }:

{
  boot = {
    kernelModules = [ "kvm-intel" ];
  };

  # Fix unreadable tty under high dpi
  console = {
    packages = [ pkgs.terminus_font ];
    font = "ter-124n";
  };

  # Bluetooth
  hardware.bluetooth.enable = true;

}
