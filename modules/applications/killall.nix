{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.killall;
in
  with lib; {
    options = {
      host.application.killall = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables killall";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [killall];
    };
  }
