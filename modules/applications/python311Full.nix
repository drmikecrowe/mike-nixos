{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.python311Full;
in
  with lib; {
    options = {
      host.application.python311Full = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables python311Full";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        python311Full
        python311Packages.flake8
        python311Packages.mypy
        python311Packages.pip
        python311Packages.poetry-core
        python311Packages.pynvim
      ];
    };
  }
