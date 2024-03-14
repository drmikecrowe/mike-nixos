{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.parted;
in
  with lib; {
    options = {
      host.application.parted = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables parted";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [parted];
    };
  }
