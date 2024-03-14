{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.xonsh;
in
  with lib; {
    options = {
      host.home.applications.xonsh = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables xonsh";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [xonsh];
    };
  }
