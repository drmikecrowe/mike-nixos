{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.sysz;
in
  with lib; {
    options = {
      host.application.sysz = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables sysz";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [sysz];
    };
  }
