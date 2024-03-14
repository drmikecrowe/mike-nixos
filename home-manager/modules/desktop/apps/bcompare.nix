{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.bcompare;
in
  with lib; {
    options = {
      host.home.applications.bcompare = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables bcompare";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [bcompare];
    };
  }
