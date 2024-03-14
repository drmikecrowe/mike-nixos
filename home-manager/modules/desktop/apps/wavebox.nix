{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.wavebox;
in
  with lib; {
    options = {
      host.home.applications.wavebox = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables wavebox";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [wavebox];
    };
  }
