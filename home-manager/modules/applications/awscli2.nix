{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.awscli2;
in
  with lib; {
    options = {
      host.home.applications.awscli2 = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables awscli2";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [awscli2];
    };
  }
