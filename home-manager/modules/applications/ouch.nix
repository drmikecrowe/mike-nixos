{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.ouch;
in
  with lib; {
    options = {
      host.home.applications.ouch = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables ouch";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [ouch];
    };
  }
