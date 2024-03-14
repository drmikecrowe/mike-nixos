{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.miller;
in
  with lib; {
    options = {
      host.home.applications.miller = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables miller";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [miller];
    };
  }
