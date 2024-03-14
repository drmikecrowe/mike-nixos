{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.bash;
in
  with lib; {
    options = {
      host.home.applications.bash = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables bash";
        };
      };
    };

    config = mkIf cfg.enable {
      programs = {
        bash = {
          enable = true;
          enableCompletion = true;
          historyControl = ["ignoredups" "ignorespace"];
        };
      };
    };
  }
