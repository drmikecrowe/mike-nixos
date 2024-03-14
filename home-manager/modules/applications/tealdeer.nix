{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.tealdeer;
in
  with lib; {
    options = {
      host.home.applications.tealdeer = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables tealdeer";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [tealdeer];
    };
  }
