{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.codeium;
in
  with lib; {
    options = {
      host.home.applications.codeium = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables codeium";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [codeium];
    };
  }
