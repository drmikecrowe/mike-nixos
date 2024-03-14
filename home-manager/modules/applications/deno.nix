{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.host.home.applications.deno;
in
  with lib; {
    options = {
      host.home.applications.deno = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables deno";
        };
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [deno];
    };
  }
