{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.application.zip;
in
  with lib; {
    options = {
      host.application.zip = {
        enable = mkOption {
          default = true;
          type = with types; bool;
          description = "Enables zip";
        };
      };
    };

    config = mkIf cfg.enable {
      environment.systemPackages = with pkgs; [
        unzip
        zip
      ];
    };
  }
