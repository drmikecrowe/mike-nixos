{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.eza;
in
  with lib; {
    options = {
      host.home.applications.eza = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables eza";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [eza];
    };
  }
