{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.glxinfo;
in
  with lib; {
    options = {
      host.home.applications.glxinfo = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables glxinfo";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [glxinfo];
    };
  }
