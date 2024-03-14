{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.rsync;
in
  with lib; {
    options = {
      host.home.applications.rsync = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables rsync";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [rsync];
    };
  }
