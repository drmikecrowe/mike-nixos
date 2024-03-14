{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.unzip;
in
  with lib; {
    options = {
      host.home.applications.unzip = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables unzip";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [unzip];
    };
  }
