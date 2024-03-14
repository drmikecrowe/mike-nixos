{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.yazi;
in
  with lib; {
    options = {
      host.home.applications.yazi = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables yazi";
        };
      };
    };

    config = mkIf cfg.enable {
      programs = {
        yazi = {
          enable = true;
          enableBashIntegration = true;
          enableFishIntegration = true;
          enableNushellIntegration = true;
          enableZshIntegration = true;
        };
      };
    };
  }
