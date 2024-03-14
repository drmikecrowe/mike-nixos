{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.pinentry-curses;
in
  with lib; {
    options = {
      host.application.pinentry-curses = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables pinentry-curses";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [pinentry-curses];
    };
  }
