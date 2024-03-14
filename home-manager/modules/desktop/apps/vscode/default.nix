{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.vscode;
in
  with lib; {
    options = {
      host.home.applications.vscode = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables vscode";
        };
      };
    };

    config = mkIf cfg.enable {
      programs.vscode = {
        enable = true;
        package = pkgs.vscode.fhs;
      };
    };
  }
