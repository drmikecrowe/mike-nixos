{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.albert;
in
  with lib; {
    options = {
      host.home.applications.albert = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables albert";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [albert];
    };
  }
