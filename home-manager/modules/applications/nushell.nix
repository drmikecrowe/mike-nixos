{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.nushell;
in
  with lib; {
    options = {
      host.home.applications.nushell = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables nushell";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [nushell];
    };
  }
