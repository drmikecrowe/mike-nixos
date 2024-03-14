{
  config,
  pkgs,
  lib,
  custom,
  dotfiles,
  ...
}: let
  cfg = config.host.home.applications.git;
in
  with lib; {
    options = {
      host.home.applications.git = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables git";
        };
      };
    };

    config = mkIf cfg.enable {
      programs.git = {
        package = pkgs.gitAndTools.gitFull;
        enable = mkDefault true;
      };
    };
  }
