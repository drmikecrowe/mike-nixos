{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.alejandra;
in
  with lib; {
    options = {
      host.home.applications.alejandra = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables alejandra";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [alejandra];
    };
  }
