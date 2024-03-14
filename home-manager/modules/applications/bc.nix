{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.bc;
in
  with lib; {
    options = {
      host.home.applications.bc = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables bc";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [bc];
    };
  }
