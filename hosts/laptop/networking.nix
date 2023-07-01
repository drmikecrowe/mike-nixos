{ config, pkgs, ... }:

{
  networking = {
    hostName = "xps15";
    hostId = "c904de5f";
    networkmanager = {
      enable = true;
    };
  };
}
