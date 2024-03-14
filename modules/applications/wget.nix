{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.wget;
in
  with lib; {
    options = {
      host.application.wget = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables wget";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [wget];
    };
  }
