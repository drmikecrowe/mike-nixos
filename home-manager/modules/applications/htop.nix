{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.htop;
in
  with lib; {
    options = {
      host.home.applications.htop = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables htop";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [htop];
    };
  }
