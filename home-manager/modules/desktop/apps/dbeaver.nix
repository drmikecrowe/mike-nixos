{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.dbeaver;
in
  with lib; {
    options = {
      host.home.applications.dbeaver = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables dbeaver";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [dbeaver];
    };
  }
