{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.glab;
in
  with lib; {
    options = {
      host.home.applications.glab = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables glab";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [glab];
    };
  }
