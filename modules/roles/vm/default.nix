{
  config,
  inputs,
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
      (modulesPath + "/profiles/qemu-guest.nix")
    ];

    config = mkIf (role == "vm") {
      documentation = {
        # This makes some nix commands not display --help
        enable = mkDefault false;
        info.enable = mkDefault false;
        man.enable = mkDefault false;
        nixos.enable = mkDefault false;
      };

      host = {
        feature = {
          boot = {
            efi.enable = mkDefault true;
            graphical.enable = mkDefault false;
          };
          graphics = {
            enable = mkDefault false; # Maybe if we were doing openCL
          };
        };
        filesystem = {
          swap = {
            enable = mkDefault true;
            type = mkDefault "partition";
          };
        };
        hardware = {
          bluetooth.enable = mkDefault false;
          printing.enable = mkDefault false;
          # sound.enable = mkDefault false;
          yubikey.enable = mkDefault false;
        };
        network = {};
      };

      networking = {
        networkmanager = {
          enable = mkDefault true;
        };
      };

      services.qemuGuest.enable = mkDefault true; # Make the assumption we're using QEMU

      systemd = {
        enableEmergencyMode = mkDefault false; # Allow system to continue booting in headless mode.
        sleep.extraConfig = ''
          AllowSuspend=no
          AllowHibernation=no
        '';
      };
    };
  }
