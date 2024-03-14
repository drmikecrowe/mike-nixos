{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.element-desktop;
in
  with lib; {
    options = {
      host.home.applications.element-desktop = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables element-desktop";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [element-desktop];
    };
  }
