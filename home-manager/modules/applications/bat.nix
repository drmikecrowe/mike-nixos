{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.bat;
in
  with lib; {
    options = {
      host.home.applications.bat = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables bat";
        };
      };
    };

    config = mkIf cfg.enable {
      programs = {
        bat = {
          enable = true; # cat replacement
          config = {
            # theme = config.theme.colors.batTheme;
            pager = "less -R"; # Don't auto-exit if one screen
          };
        };
      };
    };
  }
