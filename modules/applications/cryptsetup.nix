{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.cryptsetup;
in
  with lib; {
    options = {
      host.application.cryptsetup = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables cryptsetup";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [cryptsetup];
    };
  }
