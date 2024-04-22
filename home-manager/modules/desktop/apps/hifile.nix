{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.hifile;
in
  with lib; {
    options = {
      host.home.applications.hifile = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables hifile";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [hifile];
    };
  }
