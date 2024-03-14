{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.flameshot;
in
  with lib; {
    options = {
      host.home.applications.flameshot = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables flameshot";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [flameshot];
    };
  }
