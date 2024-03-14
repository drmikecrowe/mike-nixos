{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.inetutils;
in
  with lib; {
    options = {
      host.home.applications.inetutils = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables inetutils";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [inetutils];
    };
  }
