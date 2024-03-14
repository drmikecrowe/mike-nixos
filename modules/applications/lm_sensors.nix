{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.lm_sensors;
in
  with lib; {
    options = {
      host.application.lm_sensors = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables lm_sensors";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [lm_sensors];
    };
  }
