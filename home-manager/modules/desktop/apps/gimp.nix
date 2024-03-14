{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.gimp;
in
  with lib; {
    options = {
      host.home.applications.gimp = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables gimp";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [gimp];
    };
  }
