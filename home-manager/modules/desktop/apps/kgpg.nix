{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.kgpg;
in
  with lib; {
    options = {
      host.home.applications.kgpg = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables kgpg";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [libsForQt5.kgpg];
    };
  }
