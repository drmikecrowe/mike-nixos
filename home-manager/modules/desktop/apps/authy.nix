{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.authy;
in
  with lib; {
    options = {
      host.home.applications.authy = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables authy";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [authy];
    };
  }
