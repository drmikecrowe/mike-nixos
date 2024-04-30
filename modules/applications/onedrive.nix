{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.onedrive;
in
  with lib; {
    options = {
      host.application.onedrive = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables Microsoft Onedrive";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        onedrive
        onedrivegui
      ];
    };
  }
