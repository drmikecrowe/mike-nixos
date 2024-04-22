{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.publii;
in
  with lib; {
    options = {
      host.application.publii = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables publii";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [publii];
    };
  }
