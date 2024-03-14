{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.appimage-run;
in
  with lib; {
    options = {
      host.application.appimage-run = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables appimage-run";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [appimage-run];
    };
  }
