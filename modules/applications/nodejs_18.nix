{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.nodejs_18;
in
  with lib; {
    options = {
      host.application.nodejs_18 = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables nodejs_18";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        nodejs_18
        corepack
      ];
    };
  }
