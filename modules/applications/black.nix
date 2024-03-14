{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.black;
in
  with lib; {
    options = {
      host.application.black = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables black";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [black];
    };
  }
