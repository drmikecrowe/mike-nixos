{ config, lib, pkgs, ... }:
{
  networking = {
    networkmanager = {
      enable = true;
    };
  };
  # Workaround https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.NetworkManager-wait-online.enable = false;
}
