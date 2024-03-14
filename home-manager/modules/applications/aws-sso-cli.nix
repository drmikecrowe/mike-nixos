{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.aws-sso-cli;
in
  with lib; {
    options = {
      host.home.applications.aws-sso-cli = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables aws-sso-cli";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [aws-sso-cli];
    };
  }
