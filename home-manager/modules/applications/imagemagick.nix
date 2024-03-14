{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.imagemagick;
in
  with lib; {
    options = {
      host.home.applications.imagemagick = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables imagemagick";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [imagemagick];
    };
  }
