{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.host.home.applications.wezterm;
  dotfiles = ../../../dotfiles;
in
  with lib; {
    options = {
      host.home.applications.wezterm = {
        enable = mkOption {
          default = false;
          type = with types; bool;
          description = "Enables wezterm";
        };
      };
    };

    config = mkIf cfg.enable {
      home = {
        packages = with pkgs; [wezterm];
        file.".config/wezterm" = {
          source = "${dotfiles}/wezterm";
          recursive = true;
        };
      };
    };
  }
