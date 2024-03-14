{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.ripgrep;
in
  with lib; {
    options = {
      host.home.applications.ripgrep = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables ripgrep";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [ripgrep];
    };
  }
