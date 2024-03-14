{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.argc-completions;
in
  with lib; {
    options = {
      host.home.applications.argc-completions = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables argc-completions";
        };
      };
    };

    config = mkIf cfg.enable {
      # home.packages = with pkgs; [argc argc-completions];
    };
  }
