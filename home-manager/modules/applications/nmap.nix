{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.nmap;
in
  with lib; {
    options = {
      host.home.applications.nmap = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables nmap";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [nmap];
    };
  }
