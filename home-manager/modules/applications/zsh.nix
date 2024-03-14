{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.zsh;
in
  with lib; {
    options = {
      host.home.applications.zsh = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables zsh";
        };
      };
    };

    config = mkIf cfg.enable {
      programs = {
        zsh = {
          enable = true;
          enableCompletion = true;
        };
      };
    };
  }
