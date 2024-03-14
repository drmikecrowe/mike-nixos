{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.yubikey-manager;
in
  with lib; {
    options = {
      host.home.applications.yubikey-manager = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables yubikey-manager";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [yubikey-manager];
    };
  }
