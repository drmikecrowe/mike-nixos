{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.atool;
in
  with lib; {
    options = {
      host.home.applications.atool = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables atool";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [atool];
    };
  }
