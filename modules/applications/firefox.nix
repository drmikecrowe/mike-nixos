{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.firefox;
in
  with lib; {
    options = {
      host.application.firefox = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables firefox";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [firefox];
    };
  }
