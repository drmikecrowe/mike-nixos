{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.betterbird;
in
  with lib; {
    options = {
      host.home.applications.betterbird = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables betterbird";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [betterbird];
    };
  }
