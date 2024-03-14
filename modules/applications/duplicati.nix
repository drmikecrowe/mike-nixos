{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.duplicati;
in
  with lib; {
    options = {
      host.application.duplicati = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables duplicati";
        };
      };
    };

    config = mkIf (cfg.enable && config.host.user.mcrowe.enable) {
      # Duplicati backup
      services.duplicati = {
        user = "mcrowe";
        enable = true;
      };
    };
  }
