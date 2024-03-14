{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.zoom-us;
in
  with lib; {
    options = {
      host.home.applications.zoom-us = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables zoom-us";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [zoom-us];
    };
  }
