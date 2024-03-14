{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.fd;
in
  with lib; {
    options = {
      host.home.applications.fd = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables fd";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [fd];
    };
  }
