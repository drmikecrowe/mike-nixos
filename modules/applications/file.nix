{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.file;
in
  with lib; {
    options = {
      host.application.file = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables file";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [file];
    };
  }
