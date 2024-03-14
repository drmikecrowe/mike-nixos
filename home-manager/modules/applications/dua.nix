{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.dua;
in
  with lib; {
    options = {
      host.home.applications.dua = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables dua";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [dua];
    };
  }
