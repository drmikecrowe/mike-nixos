{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.pciutils;
in
  with lib; {
    options = {
      host.application.pciutils = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables pciutils";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [pciutils];
    };
  }
