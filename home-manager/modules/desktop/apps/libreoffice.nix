{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.libreoffice;
in
  with lib; {
    options = {
      host.home.applications.libreoffice = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables libreoffice";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [libreoffice];
    };
  }
