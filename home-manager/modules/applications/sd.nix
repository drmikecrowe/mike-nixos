{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.sd;
in
  with lib; {
    options = {
      host.home.applications.sd = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables sd";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [sd];
    };
  }
