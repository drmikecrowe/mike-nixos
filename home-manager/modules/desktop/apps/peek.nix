{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.peek;
in
  with lib; {
    options = {
      host.home.applications.peek = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables peek";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [peek];
    };
  }
