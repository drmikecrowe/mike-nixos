{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.feature.ssh;
in
  with lib; {
    options = {
      host.home.feature.ssh = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enable ssh";
        };
      };
    };

    config = mkIf cfg.enable {
      programs.ssh = {
        enable = true;
      };
    };
  }
