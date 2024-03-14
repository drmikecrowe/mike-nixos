{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.mc;
in
  with lib; {
    options = {
      host.home.applications.mc = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables mc";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [mc];
    };
  }
