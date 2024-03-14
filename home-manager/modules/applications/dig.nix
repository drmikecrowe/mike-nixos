{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.dig;
in
  with lib; {
    options = {
      host.home.applications.dig = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables dig";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [dig];
    };
  }
