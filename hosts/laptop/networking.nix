{ config, pkgs, ... }:

{
  networking = {
    hostName = "xps15";
    hostId = "c904de5f";
    search = [ "local" ];
    networkmanager = {
      enable = true;
    };
    hosts = {
      "192.168.1.107" = [ "sonarr.local" "radarr.local" "transfer.local" "sabnzbd.local" ];
    };
  };
}
