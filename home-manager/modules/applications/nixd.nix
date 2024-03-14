{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.nixd;
in
  with lib; {
    options = {
      host.home.applications.nixd = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables nixd";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [nixd];
    };
  }
