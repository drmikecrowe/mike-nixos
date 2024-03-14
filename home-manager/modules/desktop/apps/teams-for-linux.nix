{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.teams-for-linux;
in
  with lib; {
    options = {
      host.home.applications.teams-for-linux = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables teams-for-linux";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [teams-for-linux];
    };
  }
