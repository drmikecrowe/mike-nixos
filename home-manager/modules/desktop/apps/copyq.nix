{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.copyq;
in
  with lib; {
    options = {
      host.home.applications.copyq = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables copyq";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [copyq];
    };
  }
