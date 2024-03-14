{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.obsidian;
in
  with lib; {
    options = {
      host.home.applications.obsidian = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables obsidian";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [obsidian];
    };
  }
