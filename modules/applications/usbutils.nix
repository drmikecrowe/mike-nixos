{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.usbutils;
in
  with lib; {
    options = {
      host.application.usbutils = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables usbutils";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [usbutils];
    };
  }
