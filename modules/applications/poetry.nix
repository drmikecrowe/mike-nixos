{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.poetry;
in
  with lib; {
    options = {
      host.application.poetry = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables poetry";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [poetry];
    };
  }
