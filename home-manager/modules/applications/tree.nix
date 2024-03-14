{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.tree;
in
  with lib; {
    options = {
      host.home.applications.tree = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables tree";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [tree];
    };
  }
