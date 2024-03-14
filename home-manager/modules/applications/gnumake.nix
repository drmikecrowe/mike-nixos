{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.gnumake;
in
  with lib; {
    options = {
      host.home.applications.gnumake = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables gnumake";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [gnumake];
    };
  }
