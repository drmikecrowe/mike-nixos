{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.xdg-utils;
in
  with lib; {
    options = {
      host.application.xdg-utils = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables xdg-utils";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [xdg-utils];
    };
  }
