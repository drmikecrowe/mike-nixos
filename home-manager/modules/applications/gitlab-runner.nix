{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.gitlab-runner;
in
  with lib; {
    options = {
      host.home.applications.gitlab-runner = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables gitlab-runner";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [gitlab-runner];
    };
  }
