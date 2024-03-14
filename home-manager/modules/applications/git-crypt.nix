{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.git-crypt;
in
  with lib; {
    options = {
      host.home.applications.git-crypt = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables git-crypt";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [git-crypt];
    };
  }
