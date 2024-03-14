{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}: let
  role = config.host.role;
in
  with lib; {
    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    config = mkIf (role == "desktop") {
      host = {
        feature = {
          boot = {
            efi.enable = mkDefault true;
            graphical.enable = mkDefault true;
          };
          fonts = {
            enable = mkDefault true;
          };
          graphics = {
            enable = mkDefault true; # We're working with a GUI here
            acceleration = mkDefault true; # Since we have a GUI, we want openGL
          };
          powermanagement.enable = mkDefault true;
          virtualization = {
            docker = {
              enable = mkDefault true;
            };
            virtd = {
              client.enable = mkDefault true;
              daemon.enable = mkDefault true;
            };
          };
        };
        filesystem = {
          swap = {
            enable = mkDefault true;
            type = mkDefault "partition";
          };
          tmp.tmpfs.enable = mkDefault true;
        };
        hardware = {
          bluetooth.enable = mkDefault true; # Most wireless cards have bluetooth radios
          printing.enable = mkDefault true; # If we don't have access to a physical printer we should be able to remotely print
          sound.enable = mkDefault true; #
          yubikey.enable = mkDefault true; #
        };
        network = {};
      };

      networking = {
        networkmanager = {
          enable = mkDefault true;
        };
      };
    };
  }
