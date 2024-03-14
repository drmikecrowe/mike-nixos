{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.dconf2nix;
in
  with lib; {
    options = {
      host.home.applications.dconf2nix = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables dconf2nix";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [dconf2nix];
    };
  }
