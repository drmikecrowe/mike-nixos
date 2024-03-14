{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.meld;
in
  with lib; {
    options = {
      host.home.applications.meld = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables meld";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [meld];
    };
  }
