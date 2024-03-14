{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.glow;
in
  with lib; {
    options = {
      host.home.applications.glow = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables glow";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [glow];
    };
  }
