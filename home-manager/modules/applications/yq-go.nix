{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.yq-go;
in
  with lib; {
    options = {
      host.home.applications.yq-go = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables yq-go";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [yq-go];
    };
  }
