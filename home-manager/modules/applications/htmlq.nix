{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.htmlq;
in
  with lib; {
    options = {
      host.home.applications.htmlq = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables htmlq";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [htmlq];
    };
  }
