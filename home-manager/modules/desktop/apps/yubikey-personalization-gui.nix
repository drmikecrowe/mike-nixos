{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.yubikey-personalization-gui;
in
  with lib; {
    options = {
      host.home.applications.yubikey-personalization-gui = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables yubikey-personalization-gui";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [yubikey-personalization-gui];
    };
  }
