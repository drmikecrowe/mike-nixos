{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.yubioath-flutter;
in
  with lib; {
    options = {
      host.home.applications.yubioath-flutter = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables yubioath-flutter";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [yubioath-flutter];
    };
  }
