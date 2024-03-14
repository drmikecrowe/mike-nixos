{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.qcad;
in
  with lib; {
    options = {
      host.home.applications.qcad = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables qcad";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [qcad];
    };
  }
