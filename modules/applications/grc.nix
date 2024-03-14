{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.grc;
in
  with lib; {
    options = {
      host.application.grc = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables grc";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [grc];
    };
  }
